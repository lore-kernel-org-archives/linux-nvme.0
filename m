From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 23 Dec 2015 09:35:59 -0500
Subject: [PATCH] nvme: arrange header files
In-Reply-To: <1450877827-19983-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1450877827-19983-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <20151223143559.GG2457@linux.intel.com>

On Wed, Dec 23, 2015@07:07:07PM +0530, Sudip Mukherjee wrote:
> We are having build failure with sparc allmodconfig with the error:
> drivers/nvme/host/pci.c:15:0:
> include/linux/aer.h: In function 'pci_enable_pcie_error_reporting':
> include/linux/aer.h:49:10: error: 'EINVAL' undeclared (first use in this function)
> 
> The file aer.h is using the error values but they are defined in
> errno.h. So if we keep aer.h at the top of header file then we do not
> have any definition of EINVAL.

aer.h should be including errno.h.
