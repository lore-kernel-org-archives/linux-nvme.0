From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 26 Mar 2018 08:54:07 -0600
Subject: [GIT PULL] nvme-4.17
In-Reply-To: <20180323202111.GM12909@localhost.localdomain>
References: <20180323202111.GM12909@localhost.localdomain>
Message-ID: <f8c4ad9d-0737-1a2e-87a1-49091f1d4649@kernel.dk>

On 3/23/18 2:21 PM, Keith Busch wrote:
> Hi Jens,
> 
> This is the first nvme pull request for 4.17, mostly cleanups and bug
> fixes across the spectrum with a few minor new features.
> 
> There are two patches outside the nvme subsystem to support fabrics.
> I believe Sagi has the 'ok' to go through here, but I've Cc'ed those
> maintainers just in case.
> 
> Otherwise there shouldn't be anything controversial here, and merges
> clean with linux-block/for-next.
> 
> There is a trivial conflict merging Linus' upstream due to the late nvme
> patch 8a30ecc6e0 (Revert "nvme: create 'slaves' and 'holders'..."). For
> reference, a merge conflict resolution branch is here:
> 
>   git://git.infradead.org/nvme.git nvme-4.17-conflict-resolution
> 
> The following changes since commit f168127a96c55844011e79344322ac317844803a:
> 
>   Merge branch 'for-4.17/block' into for-next (2018-03-01 08:38:06 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.17

Keith, this is against for-next. Pull requests should be against
for-4.17/block, for-next only exists for Stephen's next tree and is
the former merged with master, in case there are merge issues. Or when
I have multiple branches, it'll be all of them merged with master.

I'm just going to hand-apply these.

-- 
Jens Axboe
