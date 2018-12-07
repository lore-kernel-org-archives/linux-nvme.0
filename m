From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 7 Dec 2018 08:40:44 -0700
Subject: [GIT PULL] nvme fixes for 4.20
In-Reply-To: <20181207153821.GA14210@infradead.org>
References: <20181207153821.GA14210@infradead.org>
Message-ID: <57947e13-0949-dff9-0a16-17ca3bb59843@kernel.dk>

On 12/7/18 8:38 AM, Christoph Hellwig wrote:
> The following changes since commit ba7aeae5539c7a7cccc4cf07a2bc61281a93c50e:
> 
>   block, bfq: fix decrement of num_active_groups (2018-12-07 07:40:07 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.20
> 
> for you to fetch changes up to d7dcdf9d4e15189ecfda24cc87339a3425448d5c:
> 
>   nvmet-rdma: fix response use after free (2018-12-07 07:11:11 -0800)
> 
> ----------------------------------------------------------------
> Israel Rukshin (1):
>       nvmet-rdma: fix response use after free
> 
> James Smart (1):
>       nvme: validate controller state before rescheduling keep alive
> 
>  drivers/nvme/host/core.c   | 10 +++++++++-
>  drivers/nvme/target/rdma.c |  3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
