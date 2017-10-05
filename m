From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Thu,  5 Oct 2017 12:48:22 -0700
Subject: [PATCH V6] nvme-pci: add SGL support
Message-ID: <1507232903-9532-1-git-send-email-ckulkarnilinux@gmail.com>

This is the sixth version of the patch for adding SGL support
for nvme-pci driver.

Changes since v5:-

1. Remove the NVME_CTRL_SGL_NOT_SUPP enum constant and use
   simple comparison bits to determine whether controller supports
   SGL or not.

Changes since v4:-

1. Replace NVME_CTRL_SUPP_SGL macro with enum NVME_CTRL_SGL_NOT_SUPP.
2. Adjust patch for new enum.
3. Merge two patches into one.

Changes since v3:-

1. Modify SGL helper functions and add prefix nvme_pci_sgl.
2. Use average request physical segment(s) size to conditionally use SGLs.
   This approach is different from the original one, the original approach
   was based no the IO size. The new approach considers IO size and 
   number of physical segments present in the request to conditionally
   use SGLs.
3. Adjust the patch for Linux 4.14-rc3.

Changes since v2:-

1. Adjust the patch for latest nvme driver changes.
2. For initial submission use the default virt boundary values.
        
In future, work on the patch series for relaxing the virt boundary
for each transport.

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

[PATCH V6] nvme-pci: add SGL support

-Regards,
Chaitanya
