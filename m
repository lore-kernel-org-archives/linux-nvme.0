From: sean.hefty@intel.com (Hefty, Sean)
Date: Tue, 14 Jun 2016 16:47:00 +0000
Subject: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target driver
In-Reply-To: <00f501d1c657$483a74e0$d8af5ea0$@opengridcomputing.com>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-5-git-send-email-hch@lst.de>
 <5756B75C.9000409@lightbits.io>
 <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com>
 <00f501d1c657$483a74e0$d8af5ea0$@opengridcomputing.com>
Message-ID: <1828884A29C6694DAF28B7E6B8A82373AB061E1B@ORSMSX109.amr.corp.intel.com>

> Am I correct here?  IE: Is it ok for the rdma application to
> rdma_reject()

yes

> rmda_destroy_id() the CONNECT_REQUEST cm_id _inside_ its event handler

no

> as long
> as it returns 0?

The user can return a non-zero value from the cm handler to destroy the id.

- Sean
