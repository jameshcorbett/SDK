#!/bin/sh

# run mongodb, let it settle
echo '--- start MongoDB'
mongod --fork --logpath /tmp/mongodb.log

cd radical.pilot
echo '--- smoke test'
./examples/00_getting_started.py
ret=$?
echo "--- smoke test $ret"

echo '--- unit test'
pytest -vvv tests/unit_tests
test "$ret" = 0 && ret=$?
echo "--- unit test $ret"

echo '--- component test'
pytest -vvv tests/component_tests
test "$ret" = 0 && ret=$?
echo "--- component test $ret"

exit $ret

