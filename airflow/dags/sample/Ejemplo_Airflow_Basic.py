
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.python_operator import PythonOperator
from airflow.operators.bash_operator import BashOperator


default_args = {

    "owner":"Josue",
    "email": ["josuelanda11@gmail.com"],
    "start_date": days_ago(1) 
}

with DAG(
    dag_id = "data_pipeline_basic",
    default_args = default_args,
    catchup=False,
    max_active_runs=1,
    schedule_interval = "*/1 * * * *"
) as dag:

    def _extract_process():
        print("se hace una extraccion")

    def _transform_process():
        print("se hace una transformacion")
    
    def _load_process():
        print("se hace una carga")

    extract_task = PythonOperator(task_id="extract_process",python_callable=_extract_process)
    transform_task = PythonOperator(task_id="transform_process",python_callable=_transform_process)
    load_task =  PythonOperator(task_id="load_process",python_callable=_load_process)

    bash_task = BashOperator(
        task_id="ejemplo_bash",
        bash_command = 'echo Done'
    )

    extract_task >> transform_task >> load_task >> bash_task