From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 6 Feb 2019 08:46:02 -0700
Subject: [GIT PULL] nvme fixes for 5.0
In-Reply-To: <20190206153828.GA14994@infradead.org>
References: <20190206153828.GA14994@infradead.org>
Message-ID: <57c9a73b-88a7-23fe-7b4c-756932a957b7@kernel.dk>

On 2/6/19 8:38 AM, Christoph Hellwig wrote:
> The following changes since commit ec51f8ee1e63498e9f521ec0e5a6d04622bb2c67:
> 
>   aio: initialize kiocb private in case any filesystems expect it. (2019-02-06 08:04:22 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.0
> 
> for you to fetch changes up to 5c959d73dba6495ec01d04c206ee679d61ccb2b0:
> 
>   nvme-pci: fix rapid add remove sequence (2019-02-06 16:35:33 +0100)
> 
> ----------------------------------------------------------------
> Keith Busch (2):
>       nvme: lock NS list changes while handling command effects
>       nvme-pci: fix rapid add remove sequence
> 
>  drivers/nvme/host/core.c |  8 +++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 22 ++++++++++++----------
>  3 files changed, 20 insertions(+), 11 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
