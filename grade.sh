# Create your grading script here

# set -e

rm -rf student-submission
git clone $1 student-submission

cp TestListExamples.java student-submission/
cp -r lib student-submission/
cd student-submission

if [[ -f ListExamples.java ]]
then
  javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java 2> compile-error.txt

  if [[ $? -eq 0 ]]
  then
    java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > runtime-error.txt

    ERR=$(grep "FAILURES" runtime-error.txt)
    if [[ $ERR == "FAILURES!!!" ]]
    then
      cat runtime-error.txt
      echo "Code failed one or more of the tests"
      echo "Your Grade: Fail"
      echo "Try again"
      exit
    fi

    echo "Your Grade: Passed"
    echo "Good Job"
    exit
  fi

  echo "Compile Error"
  cat compile-error.txt
  exit
fi

echo "The file ListExamples.java was not found."
exit