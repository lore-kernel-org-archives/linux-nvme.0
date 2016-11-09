From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 9 Nov 2016 09:04:26 -0700
Subject: [GIT PULL] nvme fabrics patches for the next round of 4.9 rc
In-Reply-To: <1478678520-26697-1-git-send-email-sagi@grimberg.me>
References: <1478678520-26697-1-git-send-email-sagi@grimberg.me>
Message-ID: <950ac71c-1854-017e-a497-bba97138fa98@kernel.dk>

On 11/09/2016 01:02 AM, Sagi Grimberg wrote:
> Hey Jens,
>
> Mostly some stability fixes for fabrics:
> - some memleaks, correctness and verbosity fixes from Bart
> - fix command delivery during queue reconnect from Christoph
> - nvme rdma reconnect vs io race fix from Christoph and steve
> - nvme rdma queue cleanup on connection failure fix from Steve
> - nvme rdma target error flow and queue teardown fixes
> - nvme rdma queue size fix from Samuel
> - nvmet namespace rcu race fix from Sasha
>
> please pull from:
>
>   git://git.infradead.org/nvme-fabrics.git nvmf-4.9-rc

I'm scanning the list for anything that might NOT be appropriate this
late in the cycle, and I see a few:

     nvme/scsi: Remove set-but-not-used variables
     nvme-fabrics: Adjust source code indentation
     nvme-rdma: remove redundant define

I can pull this in for 4.10 without hesistation, but I don't want to
send a pull request for a fairly new feature with 3 of the commits being
cleanups for -rc5.

Let me know what you want to do.

-- 
Jens Axboe
