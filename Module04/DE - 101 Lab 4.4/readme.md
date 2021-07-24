## Pentaho DI installation
1. [Download](https://sourceforge.net/projects/pentaho/) and extract Pentaho DI
2. [Download](https://downzen.com/en/windows/java-runtime-environment/download/8-update-261/) and install Java 8 ver.261
3. Set the Environment Variable JAVA_HOME<br>
«Settings» → Find «Edit environment variables for your account»<br>
Click «Environment Variables…» button<br>
Click «New...» under «System variables» and create a new variable with the name JAVA_HOME and value -  JRE installation path<br> 
![edit_environmental_variables.png](edit_environmental_variables.png)
4. Run *Spoon.bat*.
5. *Tip*. Create a shortcut of *Spoon.bat* in order to pint in to Start. Target:
*C:\Windows\System32\cmd.exe /c "C:\...\pdi-ce-9.1.0.0-324\data-integration\Spoon.bat"*
   
# Sample Superstore ETL process
![Job](job.png)
**1. db_preparation<br>**
![Job](db_preparation.png)

**2. Fill Staging Tables<br>** 
![Job](stg_tables.png)

**3. Fill Dim Tables<br>**
![Job](dim_tables.png)

**4. Fill tfct_sales<br>**
![Job](tfct_sales.png)

## Refference
- [Pentaho DI documentation](https://wiki.pentaho.com/display/EAI/Pentaho+Data+Integration+Steps)
- [Pentaho DI Steps Guide (Rus)](https://medium.com/@romangailit/pentaho-di-steps-guide-faada864b3e)  by romangailit (draft)