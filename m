From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Nov 2014 08:07:49 -0700
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <20141114145858.GF11522@wil.cx>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
 <54655B01.9090206@kernel.dk> <20141114145858.GF11522@wil.cx>
Message-ID: <54661AC5.7000605@kernel.dk>

On 11/14/2014 07:58 AM, Matthew Wilcox wrote:
> On Thu, Nov 13, 2014@06:29:37PM -0700, Jens Axboe wrote:
>> The downside I see is that this is an OOB IO path. Once we start adding IO
>> scheduling for those that need that, then this will completely bypass that.
> 
> The idea is that you would only enable it for devices that are based on
> NVM that is of "near-DRAM" speeds, and can complete small I/Os as fast
> as they are issued.  For those kinds of devices, there is absolutely no
> value to any kind of IO scheduling.

I agree, that's not the kind of device that people would generally do
scheduling on, and we can't at those rates. But if that's the case, why
isn't this a sync interface? "Near DRAM speeds" and interrupt driven
seems like a poor choice.


-- 
Jens Axboe
