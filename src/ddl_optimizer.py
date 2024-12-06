from langchain_core.runnables.base import RunnableEach

class DDLOptimizer:
    def __init__(self, hf_pipeline, prompts):
        self.hf_pipeline = hf_pipeline
        self.prompts = prompts
    
    def optimize_ddl(self, ddl_queries, sql_context):
        if ddl_queries and sql_context:
            input_data = [{
                "context": sql_context,
                "sql_statement": ddl
            } for ddl in ddl_queries]
            chain = self.prompts.get_optimized_ddl_prompt() | self.hf_pipeline
            runnable_each = RunnableEach(bound=chain)

            try:
                return runnable_each.invoke(input_data)
            except Exception as e:
                print(f"Erreur lors de l'optimisation : {e}")
                return []