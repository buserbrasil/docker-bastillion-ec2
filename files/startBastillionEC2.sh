#!/bin/bash

function savejceks {
  # copy JCEKS to persistent folder
  echo "[startBastillionEC2.sh INFO] copy JCEKS file to a save place"
  cp /opt/bastillion/jetty/bastillion/WEB-INF/classes/bastillion.jceks \
     /opt/bastillion/jetty/bastillion/WEB-INF/classes/keydb/bastillion.jceks
}

trap savejceks EXIT

# restore bastillion.jceks from persistent storage
if [ -f /opt/bastillion/jetty/bastillion/WEB-INF/classes/keydb/bastillion.jceks ]; then
  echo "[startBastillionEC2.sh INFO] restoring JCEKS file from persistent storage"
  cp /opt/bastillion/jetty/bastillion/WEB-INF/classes/keydb/bastillion.jceks \
     /opt/bastillion/jetty/bastillion/WEB-INF/classes/bastillion.jceks
fi

# change to jetty dir and start jetty
cd jetty
java -Xms1024m -Xmx1024m -jar start.jar