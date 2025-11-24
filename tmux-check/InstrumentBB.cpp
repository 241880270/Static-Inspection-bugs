#include <map>

#include "llvm/IR/PassManager.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
// **全局基本块编号**
static int GlobalBBIndex = 0;

struct InstrumentBBPass : public PassInfoMixin<InstrumentBBPass> {
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &) {
    llvm::errs() << "[InstrumentBB] Running on Module\n";

    LLVMContext &Ctx = M.getContext();

    // 获取 printf 函数
    FunctionCallee Printf = M.getOrInsertFunction(
        "printf", FunctionType::get(IntegerType::getInt32Ty(Ctx),
                                    PointerType::get(Type::getInt8Ty(Ctx), 0),
                                    true));

    // **使用 map 存储全局基本块编号**
    std::map<BasicBlock*, int> BBMap;

    // 1️⃣ **遍历整个 Module 的所有基本块**
    for (Function &F : M) {
        llvm::errs() << "  Function: " << F.getName() << "\n";
        if (F.isDeclaration()) continue; // 跳过声明（没有实现的函数）
        for (BasicBlock &BB : F) {
            BBMap[&BB] = GlobalBBIndex++;
        }
    }

    // 2️⃣ **插入 printf**
    for (Function &F : M) {
        if (F.isDeclaration()) continue;
        for (BasicBlock &BB : F) {
            Instruction* InsertPt = &BB.front();
            while (isa<PHINode>(InsertPt)) {
                InsertPt = InsertPt->getNextNode();  // 跳过所有 PHI 节点
            }

            IRBuilder<> Builder(InsertPt);  // 在第一个非-PHI节点之前插入 printf
            Value *FormatStr = Builder.CreateGlobalStringPtr("BB executed: %d\n");

            // 取出当前 BB 的全局编号
            Value *BBNum = ConstantInt::get(Type::getInt32Ty(Ctx), BBMap[&BB]);

            // 插入 printf 语句
            Builder.CreateCall(Printf, {FormatStr, BBNum});
        }
    }

    return PreservedAnalyses::all();
  }
};
} // namespace

// **注册 Module Pass**
extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "InstrumentBBPass", "v0.2",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "instrument-bb") {
                    MPM.addPass(InstrumentBBPass());
                    return true;
                  }
                  return false;
                });
          }};
}
