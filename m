From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Wed, 26 Jul 2017 11:19:30 -0700
Subject: [PATCH V3] nvme-pci: add sgl support
Message-ID: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>

Hi,

This is the third version of the patch for adding the SGL support
for nvme-pci driver.

Changes since v2 :-

1. Adjust the patch for latest nvme driver changes.
2. For initial submission use the default virt boundary values.

In future, work on the patch series for relaxing the virt boundary 
for each transport.

[PATCH V3] nvme-pci: add sgl support

-Regards,
Chaitanya

Changes since the v1:-

1. Introduced nvme controller virt_boundary mask. For controllers that
   can handle arbitrarily sized bios (e.g advanced RDMA and PCI ctrls)
   we can allow the block layer to pass us gaps by setting the
   queue.virt_boundary_mask according to each ctrl constraints.
2. Simplified code for setting up the SGLs.
3. Added SGL helper functions.
4. Modified commit log.
5. Use the newly introduced virt_boundary mask and clear its
   value for SGL capable controllers in PCIe driver.

For reference v1 details:-

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
