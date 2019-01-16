From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 Jan 2019 09:45:05 -0700
Subject: [GIT PULL] two nvme fixes for 5.0-rc3
In-Reply-To: <20190116163724.GA24217@infradead.org>
References: <20190116163724.GA24217@infradead.org>
Message-ID: <57fe0e8e-1402-b3d8-4297-c9bf7488369f@kernel.dk>

On 1/16/19 9:37 AM, Christoph Hellwig wrote:
> The following changes since commit 8218a55b6b911d396565da4ed5ca8b18bf0d38fb:
> 
>   sbitmap: Protect swap_lock from hardirq (2019-01-14 21:30:32 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.0
> 
> for you to fetch changes up to eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:
> 
>   nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)
> 
> ----------------------------------------------------------------
> Ming Lei (1):
>       nvme-pci: fix nvme_setup_irqs()
> 
> Sagi Grimberg (1):
>       nvmet-tcp: fix uninitialized variable access
> 
>  drivers/nvme/host/pci.c   | 21 +++++++++++++--------
>  drivers/nvme/target/tcp.c |  2 +-
>  2 files changed, 14 insertions(+), 9 deletions(-)

I applied these manually, Linus and I both committed the patch from
Ming for sbitmap, so I ended up dropping that. Looks like you got
my branch while that was in there.

-- 
Jens Axboe
