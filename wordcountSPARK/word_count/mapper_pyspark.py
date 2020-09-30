import sys
import nltk
import string
from pyspark import SparkContext
from nltk.corpus import stopwords

nltk.download('stopwords')
stopwords = set(stopwords.words('english'))
dataFile = 'plain.txt'
outputPath = 'output'


sc = SparkContext("local", "Word Count")

# czyta dane z pliku tekstowego 
words = sc.textFile(dataFile)

# lowercase
words = words.map(lambda x: x.lower())

# dzieli każde słowo
words = words.flatMap(lambda line: line.split(" "))

# usuwa interpunkcję
words = words.map(lambda x: x.replace(',','').replace('.','').replace('-',''))

# usuwa stopwords
words = words.filter(lambda x: x not in stopwords)

# liczy wystąpienie każdego słowa
words = words.map(lambda word: (word, 1)).reduceByKey(lambda a,b:a +b)

# wyniki zapisuje do pliku
words.saveAsTextFile(outputPath)