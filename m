From: hch@lst.de (Christoph Hellwig)
Date: Thu, 25 Apr 2019 16:44:08 +0200
Subject: [PATCH 0/2] nvme: Check size of command structures
In-Reply-To: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
References: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
Message-ID: <20190425144408.GA17039@lst.de>

I'm not sure we are going a little too crazy with all these
BUILD_BUG_ONs.  It would be a lot easier if we could just throw
the assert into the struct defintion somehow, but that would need
compiler magic..

On Fri, Apr 12, 2019@12:18:30AM +0900, Minwoo Im wrote:
> Many command structures have been added in linux/nvme.h wihtout
> BUILD_BUG_ON() check.  It also needs to be assured to avoid unintended
> growth of structures.
> 
> Minwoo Im (2):
>   nvme: fabrics: Make sure command struct size fixed
>   nvme: pci: Make sure command struct size fixed
> 
>  drivers/nvme/host/fabrics.c | 1 +
>  drivers/nvme/host/pci.c     | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> -- 
> 2.17.1
---end quoted text---
