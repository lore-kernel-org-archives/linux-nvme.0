From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Wed, 19 Jul 2017 17:24:18 -0700
Subject: nvme-pci: add sgl support v2. 
Message-ID: <20170720002420.26408-1-chaitanya.kulkarni@hgst.com>

Hi,

This is the second version of patch-series for adding SGL support for 
nvme-pci driver.

Changes since the first version:-

1. Introduced nvme controller virt_boundary mask. For controllers that
   can handle arbitrarily sized bios (e.g advanced RDMA and PCI ctrls)
   we can allow the block layer to pass us gaps by setting the 
   queue.virt_boundary_mask according to each ctrl constraints.
2. Simplified code for setting up the SGLs.
3. Added SGL helper functions.
4. Modified commit log.
5. Use the newly introduced virt_boundary mask and clear its 
   value for SGL capable controllers in PCIe driver.

I've tested these patches on PCIe and loop driver.

[PATCH v2 1/2] nvme: add virt boundary per ctrl
[PATCH v2 2/2] nvme-pci: add sgl support

For reference version 1 details:-

Cover letter:-

Following patch adds the SGL support in the NVMe driver.
We observed approximately 5% performance improvement in the 
IOPs, bandwidth, and latency as block size gets larger ( >= 32k).

In the current implementation, we add "sgl_threshold" module
parameter to decide whether to use SGL or PRP for IO requests, we
set the default value for sgl_threshold to 32k.
This value is exported and configurable via sysfs.

Commit Log: -

This adds SGL support for NVMe PCIe driver which is
reimplementation of the initial version provided by
Rajiv Shanmugam Madeswaran(smrajiv15 at gmail.com):-
"block: nvme-core: Scatter gather list support in the 
NVMe Block Driver".

In order to enable SGL mode for the driver, the user can set the 
sgl_threshold module parameter. This parameter can be used
in the two modes:-

1. Allow all IOs to use SGL mode. (set sgl_threshold to 1). 
2. Set up the IO size threshold to determine whether to use 
    SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
    use SGL only for IOs which are >= 4096 in the size).

Regards,
Chaitanya
