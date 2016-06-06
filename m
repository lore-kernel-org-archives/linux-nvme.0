From: hch@lst.de (Christoph Hellwig)
Date: Mon,  6 Jun 2016 23:21:51 +0200
Subject: generic NVMe over Fabrics library support
Message-ID: <1465248119-17875-1-git-send-email-hch@lst.de>

This patch set adds the necessary infrastructure for the NVMe over
Fabrics functionality and the NVMe over Fabrics library itself.

First we add some needed parameters to NVMe request allocation such as flags
(for reserved commands - connect and keep-alive), also support tag
allocation of a given queue ID (for connect to be executed per-queue)
and allow request to be queued at the head of the request queue (so
reconnects can pass in flight I/O).

Second, we add support for additional sysfs attributes that are needed
or useful for the Fabrics driver.

Third we add the NVMe over Fabrics related header definitions and the
Fabrics library itself which is transport independent and handles
Fabrics specific commands and variables.

Last, we add support for periodic keep-alive mechanism which is mandatory
for Fabrics.
