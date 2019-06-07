From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 7 Jun 2019 14:05:50 -0600
Subject: [GIT PULL] nvme fixes for 5.2-rc
In-Reply-To: <20190607195458.12866-1-sagi@grimberg.me>
References: <20190607195458.12866-1-sagi@grimberg.me>
Message-ID: <87d6eb42-e12e-39f6-43df-c59226bf1911@kernel.dk>

On 6/7/19 1:54 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Couple of nvme fixes for the next rc round.
> - nvmet write zeros fix from Minwoo
> - nvme-rdma use-after-free fix from Max
> - nvme-core u32 overflow fix from Jaesoo
> - tcp,rdma fixes for limited number of queues from me
> 
> The following changes since commit cb9e0e5006064a807b5d722c7e3c42f307193792:
> 
>    nvme-pci: use blk-mq mapping for unmanaged irqs (2019-05-22 10:11:36 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.infradead.org/nvme.git nvme-5.2-rc-next
> 
> for you to fetch changes up to 62f99b62e5e3b88d23b6ced4380199e8386965af:
> 
>    nvme-rdma: use dynamic dma mapping per command (2019-06-06 09:53:19 -0700)
> 
> ----------------------------------------------------------------
> Jaesoo Lee (1):
>        nvme: Fix u32 overflow in the number of namespace list calculation
> 
> Max Gurtovoy (1):
>        nvme-rdma: use dynamic dma mapping per command
> 
> Minwoo Im (1):
>        nvmet: fix data_len to 0 for bdev-backed write_zeroes
> 
> Sagi Grimberg (2):
>        nvme-rdma: fix queue mapping when queue count is limited
>        nvme-tcp: fix queue mapping when queue count is limited
> 
>   drivers/nvme/host/core.c          |   3 +-
>   drivers/nvme/host/rdma.c          | 152 ++++++++++++++++++++++++--------------
>   drivers/nvme/host/tcp.c           |  57 ++++++++++++--
>   drivers/nvme/target/io-cmd-bdev.c |   1 +
>   4 files changed, 150 insertions(+), 63 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
