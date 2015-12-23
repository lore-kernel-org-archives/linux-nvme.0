From: axboe@fb.com (Jens Axboe)
Date: Wed, 23 Dec 2015 08:37:59 -0700
Subject: [PATCH v2] PCI/AER: include header file
In-Reply-To: <1450884926-15014-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1450884926-15014-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <567ABFD7.3030705@fb.com>

On 12/23/2015 08:35 AM, Sudip Mukherjee wrote:
> We are having build failure with sparc allmodconfig with the error:
>
> drivers/nvme/host/pci.c:15:0:
> include/linux/aer.h: In function 'pci_enable_pcie_error_reporting':
> include/linux/aer.h:49:10: error: 'EINVAL' undeclared (first use in this function)
>
> The file aer.h is using the error values but they are defined in
> errno.h. Include errno.h so that we have the definitions of the error
> codes.

Applied to for-4.5/nvme, thanks.

-- 
Jens Axboe
