From: xiaoguang.chen@dji.com (First Light)
Date: Tue, 23 Aug 2016 09:03:07 +0000
Subject: NVME PCI driver question
Message-ID: <0aa9297eed8d4090a5e24c611e47d7c7@CWMAIL-AP-F14.dji.com>

Dear maintainers of NVME driver
I have a question about NVME driver.
In drivers/nvme/host/pci.c, function: nvme_dev_map calls pci_enable_msix, what if  a device just supports MSI but doesn't support MSIX? in such logic, if   pci_enable_msix failed,
I'm using synopsys pcie driver which doesn't support MSIX, but I also want to use it to connect a SSD, what should I do to make it work?

Thanks
Xiaoguang





This email and any attachments thereto may contain private, confidential, and privileged material for the sole use of the intended recipient. Any review, copying, or distribution of this email (or any attachments thereto) by others is strictly prohibited. If you are not the intended recipient, please contact the sender immediately and permanently delete the original and any copies of this email and any attachments thereto.

???????????????????????????????? ???????????????????????????????????????????????????????????????????????
