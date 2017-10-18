From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 18 Oct 2017 23:05:16 +0300
Subject: [Suspected-Phishing][PATCH 0/3] Add BLK_MQ_F_NO_SCHED flag to
 admin tag set
In-Reply-To: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
References: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
Message-ID: <a179f3ae-7b4c-da5a-365d-abe15e02372a@mellanox.com>



On 10/18/2017 3:38 PM, Israel Rukshin wrote:
> Since commit b86dd81
> "block: get rid of blk-mq default scheduler choice Kconfig entries",
> when setting nr_hw_queues to 1 the admin tag set uses mq-deadline scheduler.
> This flag is useful for admin queues that aren't used for normal IO.
> We already use this flag at nvme-pci.
> 
> Israel Rukshin (3):
>    nvme-rdma: Add BLK_MQ_F_NO_SCHED flag to admin tag set
>    nvme-fc: Add BLK_MQ_F_NO_SCHED flag to admin tag set
>    nvme-loop: Add BLK_MQ_F_NO_SCHED flag to admin tag set

thanks Israel.
all 3 patches looks good to me,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
