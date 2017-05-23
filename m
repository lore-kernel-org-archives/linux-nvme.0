From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 23 May 2017 00:17:44 -0700
Subject: [PATCH v2 0/2] nvme_fc: add uevent to allow dynamic connects
In-Reply-To: <20170513190559.25484-1-jsmart2021@gmail.com>
References: <20170513190559.25484-1-jsmart2021@gmail.com>
Message-ID: <20170523071744.GA31698@infradead.org>

On Sat, May 13, 2017@12:05:57PM -0700, James Smart wrote:
> These patches add support for generating a uevent which can be
> caugth and converted to a nvme-cli connect-all request for the
> FC initiator and target ports.

Can you post the nvme-cli side as well so that it can be reviewed
together?

> 
> The patches were cut on nvme-4.12 after apply the patches contained in
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010156.html
> 
> James Smart (2):
>   nvme_fc: create fc class and transport device
>   nvme_fc: add uevent for auto-connect
> 
>  drivers/nvme/host/fc.c         | 102 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/nvme-fc-driver.h |   2 +
>  2 files changed, 100 insertions(+), 4 deletions(-)
> 
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
