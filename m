From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 21 Nov 2014 18:23:36 -0700
Subject: [PATCH] NVMe: Update module version major number
In-Reply-To: <1416608192-15924-1-git-send-email-keith.busch@intel.com>
References: <1416608192-15924-1-git-send-email-keith.busch@intel.com>
Message-ID: <546FE598.80704@kernel.dk>

On 11/21/2014 03:16 PM, Keith Busch wrote:
> It's already near impossible to tell what bits someone is running based on
> a 'modinfo nvme', and I don't want to try guessing if someone is running
> blk-mq or bio-based. Let's make it obvious with the module version that
> the blk-mq conversion is a major change. Future bio-based versions can
> increment to 0.10 in a fork if revisions occur.

Thanks, added to the mix. In general I don't put much faith into version 
numbers, you should be able to tell when people report what kernel they 
are running. Distro backports sometimes make that difficult, though.

-- 
Jens Axboe
