From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 15:50:43 +0300
Subject: [PATCH 0/3] Add BLK_MQ_F_NO_SCHED flag to admin tag set
In-Reply-To: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
References: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
Message-ID: <ac3c9220-a7be-cbd4-324a-ceeb4c31c139@grimberg.me>


> Since commit b86dd81
> "block: get rid of blk-mq default scheduler choice Kconfig entries",
> when setting nr_hw_queues to 1 the admin tag set uses mq-deadline scheduler.
> This flag is useful for admin queues that aren't used for normal IO.
> We already use this flag at nvme-pci.

How is the fact that we set a single hw queue has anything to do with
the admin tagset?
