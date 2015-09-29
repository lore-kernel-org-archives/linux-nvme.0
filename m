From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 28 Sep 2015 19:17:39 -0700
Subject: 4 Patch summary of PCIe re-arrangement of nvme code for future
 technology expansion, v3
Message-ID: <1443493059.3449.11.camel@linux.intel.com>

The four patch series following this email is based on a previous email
thread and the following suggestion:

 a) move files to a new directory.
 b) start splitting struct nvme_dev into a generic struct nvme_ctrl
    and a PCI-specific nvme_pci_ctrl

The goal is still based on the previous patch submission (subject "Move
nvme driver source into subdirectory and move pci specifics from core
into separate file") which:

 - moved files to a new directory
 - split data structures
 - split files
 - introduced a new internal API

to enable future technology expansion of the NVMe protocol.
