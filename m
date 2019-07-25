From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 25 Jul 2019 10:24:25 -0600
Subject: [GIT PULL] nvme fixes for 5.3
In-Reply-To: <20190725141245.GA4339@infradead.org>
References: <20190725141245.GA4339@infradead.org>
Message-ID: <f1bda303-27f9-8c5c-3cb1-a2bb58c91566@kernel.dk>

On 7/25/19 8:12 AM, Christoph Hellwig wrote:
> 
> The following changes since commit 77ce56e2bfaa64127ae5e23ef136c0168b818777:
> 
>    drbd: dynamically allocate shash descriptor (2019-07-23 07:35:18 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.infradead.org/nvme.git nvme-5.3
> 
> for you to fetch changes up to 8fe34be14ecb5eb0ef8d8d44aa7ab62d9e2911ca:
> 
>    Revert "nvme-pci: don't create a read hctx mapping without read queues" (2019-07-23 17:47:02 +0200)
> 
> ----------------------------------------------------------------
> Logan Gunthorpe (1):
>        nvme: fix memory leak caused by incorrect subsystem free
> 
> Marta Rybczynska (1):
>        nvme: fix multipath crash when ANA is deactivated
> 
> Misha Nasledov (1):
>        nvme: ignore subnqn for ADATA SX6000LNP
> 
> yangerkun (1):
>        Revert "nvme-pci: don't create a read hctx mapping without read queues"
> 
>   drivers/nvme/host/core.c      | 12 +++++-------
>   drivers/nvme/host/multipath.c |  8 ++------
>   drivers/nvme/host/nvme.h      |  6 +++++-
>   drivers/nvme/host/pci.c       |  6 +++---
>   4 files changed, 15 insertions(+), 17 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
