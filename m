From: judy.brock@ssi.samsung.com (Judy Brock-SSI)
Date: Wed, 6 Apr 2016 05:22:06 +0000
Subject: [PATCH] NVMe: Re-introduce polling for completions
In-Reply-To: <20160405222953.GE12625@localhost.localdomain>
References: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
 <20160405123523.GA19495@infradead.org>
 <20160405175437.GC12625@localhost.localdomain>
 <20160405213904.GD12625@localhost.localdomain>
 <36E8D38D6B771A4BBDB1C0D800158A51865F402E@SSIEXCH-MB3.ssi.samsung.com>
 <20160405222953.GE12625@localhost.localdomain>
Message-ID: <36E8D38D6B771A4BBDB1C0D800158A51865F49FD@SSIEXCH-MB3.ssi.samsung.com>

> Maybe you want both?
I think that would be a good solution.

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Tuesday, April 05, 2016 3:30 PM
To: Judy Brock-SSI
Cc: Christoph Hellwig; Jens Axboe; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Re-introduce polling for completions

On Tue, Apr 05, 2016@10:04:22PM +0000, Judy Brock-SSI wrote:
> Going straight to MSI-x is a higher risk change since re-introducing polling restores code that was in place previously with no reported problems whereas changing the init path to something new has no test time on it.

Well, I wouldn't say "no" test time since we have a well tested path that goes straight to MSI-x in place for some time.

If we rely on polled completions during initialization, we potentially add up to 2 seconds for device initialization to complete (1 second polling interval * 2 commands using broken IRQ).

Maybe you want both?
