From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 4 Feb 2019 11:28:10 -0700
Subject: [GIT PULL] early nvme pull request for 5.1
In-Reply-To: <20190204151054.GA32678@infradead.org>
References: <20190204151054.GA32678@infradead.org>
Message-ID: <1bd7b844-72bb-29b6-2a92-96f0d7ae9299@kernel.dk>

On 2/4/19 8:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is our current (small) queue of NVMe patches for Linux 5.1.  We
> want the re-addition of the Write Zeroes support to be in linu-next for
> a few weeks as it caused some problems last time.  The only other
> patch is a cleanup from Sagi.
> 
> The following changes since commit bb94aea1444b9859faa8d72aff3713fcd11c6696:
> 
>   blk-mq: save default hctx into ctx->hctxs for not-supported type (2019-02-01 08:33:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.1
> 
> for you to fetch changes up to 794a4cb3d2f7c105112f9b59525533f00ac06006:
> 
>   nvme: remove the .stop_ctrl callout (2019-02-04 15:41:25 +0100)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (1):
>       nvme: add support for the Write Zeroes command
> 
> Sagi Grimberg (1):
>       nvme: remove the .stop_ctrl callout
> 
>  drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/nvme/host/nvme.h |  1 -
>  drivers/nvme/host/rdma.c | 12 +++--------
>  drivers/nvme/host/tcp.c  | 10 +++------
>  4 files changed, 56 insertions(+), 21 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
