From: hch@lst.de (Christoph Hellwig)
Date: Mon,  6 Jun 2016 23:23:30 +0200
Subject: NVMe over Fabrics RDMA transport drivers
Message-ID: <1465248215-18186-1-git-send-email-hch@lst.de>

This patch set implements the NVMe over Fabrics RDMA host and the target
drivers.

The host driver is tied into the NVMe host stack and implements the RDMA
transport under the NVMe core and Fabrics modules. The NVMe over Fabrics
RDMA host module is responsible for establishing a connection against a
given target/controller, RDMA event handling and data-plane command
processing.

The target driver hooks into the NVMe target core stack and implements
the RDMA transport. The module is responsible for RDMA connection
establishment, RDMA event handling and data-plane RDMA commands
processing.

RDMA connection establishment is done using RDMA/CM and IP resolution.
The data-plane command sequence follows the classic storage model where
the target pushes/pulls the data.
