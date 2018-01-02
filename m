From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed,  3 Jan 2018 07:56:07 +0800
Subject: [PATCHSET] nvme-pci: sort out nvme initialization procedure in
 nvme_rest_work
Message-ID: <1514937370-4805-1-git-send-email-jianchao.w.wang@oracle.com>

Hello

This patchset is to sort out the nvme initialization procedure in
nvme_reset_work. There is no functional changes in it. Add two new
helper interfaces nvme_pci_pre_init and nvme_pci_post_init to package
the nvme specific initialization work before configuring adminq and
after getting identify information. Then nvme_pci_enable, 
nvme_pci_configure_admin_queue and nvme_reset_work could be clearer.
Change functions' name, nvme_pci_configure_admin_queue and
nvme_alloc_admin_tags to  nvme_pci_setup_adminq and
nvme_pci_start_adminq to make it more readable.

Jianchao Wang (3)
0001-nvme-pci-add-nvme_pci_pre_init.patch
0002-nvme-pci-change-the-name-of-functions-corresponding-.patch
0003-nvme-pci-add-nvme_pci_post_init.patch

 drivers/nvme/host/pci.c | 211 ++++++++++++++++++++++++++----------------------
 1 file changed, 115 insertions(+), 96 deletions(-)

Thanks
Jianchao
