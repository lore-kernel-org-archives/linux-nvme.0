From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Wed, 21 Jun 2017 15:03:21 -0300
Subject: [PATCH 0/2] nvme/quirk: backport to v4.4 stable for PCI_DEVICE(0x1c58, 0x0003)
Message-ID: <1498068203-29900-1-git-send-email-mauricfo@linux.vnet.ibm.com>

Hi Christoph, Jens, and Greg.

Would you ack these 2 backports to be applied to v4.4 stable?

The backports differ from the upstream applied commits in two aspects:
1) use PCI IDs directly rather than nvme quirk infrastructure (which was
   introduced later, commit 106198edb7 "nvme: add explicit quirk handling",
   and depends on many further changes, not required for this purpose).
    
2) use 'struct nvme_dev->tagset' rather than 'struct nvme_ctrl->tagset'
   (similarly.)

This has been built and tested on top of v4.4.70.

Thanks,

Mauricio Faria de Oliveira
IBM Linux Technology Center

Guilherme G. Piccoli (2):
  nvme/quirk: Add a delay before checking for adapter readiness
  nvme: apply DELAY_BEFORE_CHK_RDY quirk at probe time too

 drivers/nvme/host/nvme.h | 7 +++++++
 drivers/nvme/host/pci.c  | 5 +++++
 2 files changed, 12 insertions(+)

-- 
1.8.3.1
