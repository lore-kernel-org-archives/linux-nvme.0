From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:04:11 +0200
Subject: nvme driver split, the easy part
Message-ID: <1444633456-27698-1-git-send-email-hch@lst.de>

This series contains the trivial and hopefully uncontroversial part of the
nvme driver split to show how I want to get started.

This creates a new core.c with functions sitting on top of the block layer,
splits and split a new struct nvme_ctrl out of struct nvme_dev so that the
SCSI translation layer is decoupled from the PCI driver internals.  A new
struct nvme_ctrl_ops is introduced to call into the low level driver, which
for now just has a single method to read a 32-bit wide register.
