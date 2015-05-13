From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 May 2015 17:12:10 +0000 (UTC)
Subject: [PATCH] block:Remove including of the header file, linux/mm.h
 for the file,nvme-core.c
In-Reply-To: <20150513164945.GX4003@linux.intel.com>
References: <1431534078-17740-1-git-send-email-xerofoify@gmail.com>
 <20150513164945.GX4003@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1505131704410.15930@localhost.lm.intel.com>

On Wed, 13 May 2015, Matthew Wilcox wrote:
> On Wed, May 13, 2015@12:21:18PM -0400, Nicholas Krause wrote:
>> This removes the include statement for including the header file,
>> linux/mm.h in the file, nvme-core.c due this driver file never
>> calling any functions from the header file, linux/mm.h  and
>> only adding bloat to this driver by including this unnessary
>> header file.
>
> Nick, I'm not going to apply this patch, simply because the effort of
> verifying that you haven't made a mistake is greater than the gain we
> might get from applying it.

The driver does use functions defined in linux/mm.h: get_user_pages_fast
is one of them. It compiles without including the header because another
we include includes mm.h, but we don't want to depend on that!

Don't worry, I didn't waste time checking; I just happened to know that
one off the top.
