From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Jul 2017 13:34:14 +0300
Subject: [PATCH] nvme: add wrapper for nvme ctrl register r/w
In-Reply-To: <20170712072018.GA5739@lst.de>
References: <20170629172624.GA17319@localhost.didichuxing.com>
 <20170712072018.GA5739@lst.de>
Message-ID: <ad43c2ae-c3af-351d-7a58-0f2f35e79d30@grimberg.me>


>> Simplify nvme ctrl register r/w code.
>>
>> Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
> 
> This seems generally useful, especially with more consolidation
> of code to the core.  Sagi - do you want to integrate this into
> your consolidation series and fixup any clashes?

Not sure whats special about register read/write that they
deserve a wrapper, but its easy enough to get in before
my patches if I'll see a review on it.
