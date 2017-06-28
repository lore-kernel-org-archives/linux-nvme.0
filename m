From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Jun 2017 08:13:03 -0600
Subject: [GIT PULL] some more early nvme patches for kernel 4.13
In-Reply-To: <1498633287-451-1-git-send-email-sagi@grimberg.me>
References: <1498633287-451-1-git-send-email-sagi@grimberg.me>
Message-ID: <de3521cf-49a1-ac76-0fca-123a3845839e@kernel.dk>

On 06/28/2017 01:01 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Another round of early patches for 4.13 to spend some time
> in linux-next.
> 
> This includes:
> - finally remove SCSI translations from Kieth 
> - NQN handling fixes from Christoph
> - several nvme(t)-fc fixes from James
> - expose hostid configure knob to userspace from Johannes
> - APST disable quirks from Kai-Heng Feng
> - nvme-pci process_cq refactoring from me
> - relax NVME_AQ_DEPTH to 32 and share it in fabrics and pci from me
> - fix nvmet-rdma surprise device removal handling
> 
> please consider pulling from:
> 
>   git://git.infradead.org/nvme.git nvme-4.13
> 
> It's rebased on top of your for-next (2c4a9e73b3c6).

Never rebase on top of my for-next. My for-next exists only for
Stephen, and it continually gets master merged in to resolve
conflicts. Please rebase this on top of for-4.13/block asap,
I can't pull this on.

-- 
Jens Axboe
