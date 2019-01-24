From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 23 Jan 2019 17:17:45 -0700
Subject: [GIT PULL] nvme fixes for 5.0-rc4
In-Reply-To: <20190123214252.27491-1-sagi@grimberg.me>
References: <20190123214252.27491-1-sagi@grimberg.me>
Message-ID: <d6379865-7f4a-5609-d051-f6421660b796@kernel.dk>

On 1/23/19 2:42 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Couple of nvme fixes for the next rc round.
> 
> - Fix nvme-rdma and nvme-tcp timeout handlers racing with queue
>   disconnections and initial connect failuers
> - fix nvme-rdma regression in queue maps assignment introduced
>   in read/write queue map separation
> - fix nvmet-rdma null dereference when we run out of rsps under
>   heavy load
> - fix multipath ana log underallocation when static group ids are used
> 
> The following changes since commit eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:
> 
>   nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.0

This is still forward of my existing branch, so I just hand
applied these. After my next pull, I'll fast forward the
branch for next time.

-- 
Jens Axboe
