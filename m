From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 16 Mar 2018 09:14:34 -0700
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <20180316160110.GC720@localhost.localdomain>
References: <20180316160110.GC720@localhost.localdomain>
Message-ID: <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>

On 3/16/18 9:01 AM, Keith Busch wrote:
> Hi Jens,
> 
> One last fix from Jianchao to address a troubling scenario Ming identified
> with offlining CPUs that could leave nvme controllers unusable. We can
> not allow that to occur, so we wish to include a new IRQ spread that
> prevents that situation.

Since this isn't really a regression in this release, how about
we push this one to 4.17 instead?

-- 
Jens Axboe
