# pyspark profile for ipython-shell

# Configure the necessary Spark environment
import os
import sys

spark_home = os.environ.get('SPARK_HOME', None)
sys.path.insert(0, spark_home + "/python")

# Add the py4j to the path.
# You may need to change the version number to match your install
sys.path.insert(0, os.path.join(spark_home, 'python/lib/py4j*.zip'))

# Initialize PySpark to predefine the SparkContext variable 'sc'
execfile(os.path.join(spark_home, 'python/pyspark/shell.py'))
