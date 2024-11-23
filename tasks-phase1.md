IMPORTANT ❗ ❗ ❗ Please remember to destroy all the resources after each work session. You can recreate infrastructure by creating new PR and merging it to master.
  
![img.png](doc/figures/destroy.png)

1. Authors:

<ul><h4>Autorzy:</h4></ul>
<li>Aleksandra Gryzik</li>
<li>Gabriel Skowron-Rodriguez</li>
<li>Jakub Rozkosz</li>
   
<p>Group nr: 13</p>
<p>Link to forked repo: https://github.com/spacerunner00/tbd-workshop-1.git</p>
   
3. Follow all steps in README.md.

4. Select your project and set budget alerts on 5%, 25%, 50%, 80% of 50$ (in cloud console -> billing -> budget & alerts -> create buget; unclick discounts and promotions&others while creating budget).

  ![img.png](doc/figures/discounts.png)

5. From avaialble Github Actions select and run destroy on main branch.
   
6. Create new git branch and:
    1. Modify tasks-phase1.md file.
    
    2. Create PR from this branch to **YOUR** master and merge it to make new release. 
    
![img.pnng](shared-files/Step-6-new-branch-pr.png)

7. Analyze terraform code. Play with terraform plan, terraform graph to investigate different modules.

![img.pnng](shared-files/module-dataproc.png)

<h3>module.dataproc</h3>
<ul>
   <li>Lokalizacja *./modules/dataproc/*</li>
   <li>Moduł *module.data* to moduł terraform odpowiedzialny za stworzenie klastra Dataproc w Google Cloud.</li>
<li>
   Do jego zasobów należą: 
   <ul>
      <li> google_project_service.dataproc - Odpowiada za włączenie usługi API Dataproc w projekcie. Jest to kluczowy krok przed utworzeniem klastra, ponieważ bez aktywnego API Dataproc utworzenie klastra Dataproc nie byłoby możliwe. </li>
      <li>
         google_dataproc_cluster.tbd-dataproc-cluster - Odpowiada za konfigurację i utworzenie klastra Dataproc. W tym zasobie definiowane są szczegóły konfiguracji klastra, takie jak: 
         <ul>
            <li>liczba i rodzaj węzłów (master i worker nodes)</li>
            <li>rodzaj maszyn wirtualnych i ich zasoby (typ maszyn, dyski, sieć)</li>
            <li>oprogramowanie i inicjalizacja, w tym wersja obrazu oraz skrypty inicjalizacyjne</li>
         </ul>
      </li>
   </ul>
</li>
</ul>
   
8. Reach YARN UI

![img.pnng](shared-files/Step-8-yarnui-1.png)
![img.pnng](shared-files/Step-8-yarnui-2.png)

<p>Polecenie użyte do ustawienia tunela:</p>
```bash
gcloud compute ssh tbd-cluster-m \
  --project=tbd-2024zz-305978 \
  --zone=europe-west1-d \
  --tunnel-through-iap \
  -- -L 8088:localhost:8088


   
11. Draw an architecture diagram (e.g. in draw.io) that includes:
    1. VPC topology with service assignment to subnets
    2. Description of the components of service accounts
    3. List of buckets for disposal
    4. Description of network communication (ports, why it is necessary to specify the host for the driver) of Apache Spark running from Vertex AI Workbech


<p>VPC Network</p>
<ul>
   <li>Nazwa VPC: main-vpc</li>
   <li>Liczba podsieci: 2</li>
   <li>
       Podsieć 1: composer-subnet-01
       <ul>
           <li>Gateway: 10.11.0.1</li>
           <li>Region: europe-west1</li>
           <li>Primary IPv4 range: 10.11.0.0/16</li>
       </ul>
   </li>
   <li>
       Podsieć 3: subnet-01
       <ul>
           <li>Gateway: 10.11.0.1</li>
           <li>Region: europe-west1</li>
           <li>Primary IPv4 range: 10.10.10.0/24</li>
       </ul>
   </li>
</ul>

<p>Service accounts</p>
<ul>
   <li>
       tbd-2024zz-305978-data@tbd-2024zz-305978.iam.gserviceaccount.com
       <ul>
           <p>Opis: Konto do operacji: logowania, monitorowania, zarządzania zasobami.</p>
       </ul>
   </li>
   <li>
       tbd-2024zz-305978-lab@tbd-2024zz-305978.iam.gserviceaccount.com
       <ul>
           <p>Opis: Konto do operacji: logowania, monitorowania, zarządzania zasobami.</p>
       </ul>
   </li>
   <li>
       587948061270-compute@developer.gserviceaccount.com
       <ul>
           <li>Opis: Konto używane przez maszyny wirutalne w Compute Engine.</li>
       </ul>
   </li>
</ul>


<p>Google Cloud Storage Buckets</p>
<ul>
   <li>
       dataproc-temp-europe-west1-587948061270
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Tymczasowe przechowywanie danych podczas operacji Dataproc</li>
           <li>
               Zawartość:
               <ul>
                   <li>
                       Foldery:
                       <ul>
                           <li>mapreduce-job-history/ – Dane historii zadań MapReduce</li>
                           <li>spark-job-history/ – Dane historii zadań Spark</li>
                           <li>yarn-logs/ – Logi YARN</li>
                       </ul>
                   </li>
               </ul>
           </li>
       </ul>
   </li>
   <li>
       dataproc-staging-europe-west1-587948061270
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Staging danych dla Dataproc</li>
           <li>
               Zawartość:
               <ul>
                   <li>
                       Foldery:
                       <ul>
                           <li>mapreduce-job-history/ – Historia zadań MapReduce</li>
                           <li>google-cloud-dataproc-metainfo/ – Metadane Dataproc</li>
                           <li>tbd-cluster-* – Dane staging dla klastra</li>
                       </ul>
                   </li>
               </ul>
           </li>
       </ul>
   </li>
   <li>
       europe-west1-demo-lab-6c0e8263-bucket
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Związany z Airflow w środowisku testowym</li>
           <li>
               Zawartość:
               <ul>
                   <li>
                       Foldery:
                       <ul>
                           <li>dags/ – Pliki DAG dla Airflow</li>
			   <li>data/ – Dane przetwarzane przez zadania</li>
                           <li>logs/ – Logi zadań Airflow</li>
			   <li>plugins/ - Pluginy</li>
                       </ul>
                   </li>
               </ul>
           </li>
       </ul>
   </li>
   <li>
       europe-west1-demo-lab-9f3509c0-bucket
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Związany z monitorowaniem i zadaniami Airflow</li>
           <li>
               Zawartość:
               <ul>
                   <li>
                       Foldery:
                       <ul>
                           <li>dags/ – Pliki DAG dla Airflow</li>
			   <li>data/ – Dane przetwarzane przez zadania</li>
                           <li>logs/ – Logi zadań Airflow</li>
			   <li>plugins/ - Pluginy</li>    
                       </ul>
                   </li>
               </ul>
           </li>
       </ul>
   </li>
   <li>
       europe-west1-demo-lab-eb9c6219-bucket
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Przechowywanie plików DAG i logów związanych z Airflow</li>
           <li>
               Zawartość:
               <ul>
                   <li>
                       Foldery:
                       <ul>
                           <li>dags/ – Pliki DAG dla Airflow</li>
			   <li>data/ – Dane przetwarzane przez zadania</li>
                           <li>logs/ – Logi zadań Airflow</li>
			   <li>plugins/ - Pluginy</li>  
                       </ul>
                   </li>
               </ul>
           </li>
       </ul>
   </li>
   <li>
       tbd-2024zz-305978-code
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Przechowywanie kodu dla zadań Spark</li>
           <li>
               Zawartość:
               <ul>
                   <li>Plik: spark-job.py – Skrypt do uruchamiania zadań Spark</li>
               </ul>
           </li>
       </ul>
   </li>
   <li>
       tbd-2024zz-305978-conf
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Przechowywanie plików konfiguracyjnych</li>
           <li>
               Zawartość:
               <ul>
                   <li>
                       Folder: scripts/
                       <ul>
                           <li>Plik: notebook_post_startup_script.sh – Skrypt uruchamiany po starcie notebooka</li>
                       </ul>
                   </li>
               </ul>
           </li>
       </ul>
   </li>
   <li>
       tbd-2024zz-305978-data
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Przechowywanie danych wejściowych i wyjściowych</li>
           <li>Zawartość: Brak plików w tej chwili</li>
       </ul>
   </li>
   <li>
       tbd-2024zz-305978-state
       <ul>
           <li>Lokalizacja: europe-west1</li>
           <li>Cel: Przechowywanie stanu infrastruktury (np. Terraform state)</li>
           <li>
               Zawartość:
               <ul>
                   <li>
                       Folder: cicd/
                       <ul>
                           <li>Plik: default.tfstate – Plik stanu Terraform</li>
                       </ul>
                   </li>
               </ul>
           </li>
       </ul>
   </li>
</ul>

<p>Lista instancji VM</p>
<ul>
   <li>
       tbd-cluster-m
       <ul>
           <li>Rola: Master node w klastrze Dataproc</li>
           <li>Lokalizacja: europe-west1-d</li>
           <li>Internal IP: 10.10.10.3</li>
           <li>Typ maszyny: e2-standard-2</li>
           <li>
               Konfiguracja:
               <ul>
                   <li>CPU: Intel Broadwell</li>
                   <li>Pamięć: Standard dla e2-standard-2</li>
               </ul>
           </li>
           <li>Opis: Zarządza zadaniami w w klastrze Dataproc. Koordynuje działania workerów.</li>
       </ul>
   </li>
   <li>
       tbd-cluster-w-0
       <ul>
           <li>Rola: Worker node 0 w klastrze Dataproc</li>
           <li>Lokalizacja: europe-west1-d</li>
           <li>Internal IP: 10.10.10.2</li>
           <li>Typ maszyny: e2-standard-2</li>
           <li>
               Konfiguracja:
               <ul>
                   <li>CPU: Intel Broadwell</li>
               </ul>
           </li>
           <li>Opis: Wykonuje zadania zlecone przez Master Node w ramach klastrów Dataproc.</li>
       </ul>
   </li>
   <li>
       tbd-cluster-w-1
       <ul>
           <li>Rola: Worker node 1 w klastrze Dataproc</li>
           <li>Lokalizacja: europe-west1-d</li>
           <li>Internal IP: 10.10.10.4</li>
           <li>Typ maszyny: e2-standard-2</li>
           <li>
               Konfiguracja:
               <ul>
                   <li>CPU: Intel Broadwell</li>
               </ul>
           </li>
           <li>Opis: Wykonuje zadania zlecone przez Master Node w ramach klastrów Dataproc.</li>
       </ul>
   </li>
   <li>
       tbd-2024zz-305978-notebook
       <ul>
           <li>Rola: Vertex AI Workbench Notebook Instance</li>
           <li>Lokalizacja: europe-west1-b</li>
           <li>Internal IP: 10.10.10.5</li>
           <li>Typ maszyny: e2-standard-2</li>
           <li>
               Konfiguracja:
               <ul>
                   <li>CPU: Intel Broadwell</li>
               </ul>
           </li>
           <li>Użycie: Środowisko do uruchamiania kodu Spark </li>
       </ul>
   </li>
</ul>

<p>Apache Spark</p>
<span>Do poprawnego działania Apache Spark w środowisku Vertex AI Workbench wykorzystuje porty:</span>
<ul>
   <li>
       30000
       <ul>
           <li>Port używany przez Spark Driver do komunikacji z Executorami</li>
       </ul>
   </li>
   <li>
       30001
       <ul>
           <li>Port używany przez Spark Block Manager do przesyłania danych pomiędzy Executorami i Driverem</li>
       </ul>
   </li>
   <li>
       8088
       <ul>
           <li>Port YARN ResourceManager Web UI, pozwala na monitorowanie stanu klastrów i zadań</li>
       </ul>
   </li>
   <li>
       8030-8033
       <ul>
           <li>Porty YARN ResourceManager, zarządzające zasobami w klastrze</li>
       </ul>
   </li>
   <li>
       18080
       <ul>
           <li>Port Spark History Server, służący do przeglądania logów i wyników zakończonych aplikacji Spark</li>
       </ul>
   </li>
   <li>
       10200
       <ul>
           <li>Port Application History Server YARN, przechowuje historię zakończonych aplikacji</li>
       </ul>
   </li>
</ul>
    ***place your diagram here***

12. Create a new PR and add costs by entering the expected consumption into Infracost
For all the resources of type: `google_artifact_registry`, `google_storage_bucket`, `google_service_networking_connection`
create a sample usage profiles and add it to the Infracost task in CI/CD pipeline. Usage file [example](https://github.com/infracost/infracost/blob/master/infracost-usage-example.yml) 

   ***place the expected consumption you entered here***

   ***place the screenshot from infracost output here***

11. Create a BigQuery dataset and an external table using SQL
    
    ***place the code and output here***
   
    ***why does ORC not require a table schema?***

  
12. Start an interactive session from Vertex AI workbench:

    ***place the screenshot of notebook here***
   
13. Find and correct the error in spark-job.py

    ***describe the cause and how to find the error***

14. Additional tasks using Terraform:

    1. Add support for arbitrary machine types and worker nodes for a Dataproc cluster and JupyterLab instance

    ***place the link to the modified file and inserted terraform code***
    
    3. Add support for preemptible/spot instances in a Dataproc cluster

    ***place the link to the modified file and inserted terraform code***
    
    3. Perform additional hardening of Jupyterlab environment, i.e. disable sudo access and enable secure boot
    
    ***place the link to the modified file and inserted terraform code***

    4. (Optional) Get access to Apache Spark WebUI

    ***place the link to the modified file and inserted terraform code***
