From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Oct 2015 07:58:30 +0200
Subject: nvme driver split V2
Message-ID: <1444975128-8768-1-git-send-email-hch@lst.de>

This series contains most of the work of splitting the nvme driver into a
core driver, a PCIe frontend for it and the possibility of future other
frontends like virtio or Fabrics.

This creates a new core.c with functions sitting on top of the block layer,
splits and split a new struct nvme_ctrl out of struct nvme_dev so that the
SCSI translation layer is decoupled from the PCI driver internals.  A new
struct nvme_ctrl_ops is introduced to call into the low level driver, and
this is subsequently used to move all the block device, char device and
sysfs interface code as well as the controller identification and namespace
scanning into the common code.  I've ported both my nvme-loop and the
fabrics driver over to this scheme to validate that it works fine, and Ming
ported over virtio_nvme,

Once this this series is done there are a few more items remaining:

 - abort rewrite to sit on top of struct request infrastructure (in progress)
 - AEN rewrite, including making a small part of it common
 - a proper state machine for probing, scanning and resets (will take a while)

To make testing easier I've pushed out a git tree with this and all
dependencies:

    git://git.infradead.org/users/hch/block.git nvme-split.5

or in gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-split.5

Chances since V1:
  - fixed a section mismatch
  - fixed missing byte swap
  - fixed metadata passthrough (thanks Keith!)
  - merged the previously separate series into a single one
  - one whitespace fix
  - added two additional patches to move trivial I/O path helpers to nvme.h
