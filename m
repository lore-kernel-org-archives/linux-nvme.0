From: hch@lst.de (Christoph Hellwig)
Date: Sun, 29 Oct 2017 10:44:26 +0200
Subject: controller deletion consolidation
Message-ID: <20171029084431.8702-1-hch@lst.de>

Hi all,

this series consolidates a lot of the boilerplate code in controller
deletion.  I did this when applying the FC patches that finally made
it look exactly like RDMA.

This will probably conflict a bit with Sagis consolidation series, but
in the end should make it easier.

Two notes:

 - do we need the cancellation of reset_work in FC?  If so we probably
   want it in RDMA and loop as well.
 - should RDMA really queue delete_work manually in
   nvme_rdma_reconnect_or_remove instead of going through the state
   machine?  That seems like a bug to me.
