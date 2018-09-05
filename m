From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 5 Sep 2018 13:33:23 -0600
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
 <20180901082812.GB670@lst.de>
 <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>
 <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk>
Message-ID: <1b4283da-44df-4a02-3167-e295243cef78@deltatee.com>



On 05/09/18 01:26 PM, Jens Axboe wrote:
> On 9/3/18 4:26 PM, Logan Gunthorpe wrote:
>> I personally agree with Christoph. But if there's consensus in the other
>> direction or this is a real blocker moving this forward, I can remove it
>> for the next version.
> 
> It's a simple branch because the check isn't exhaustive. It just checks
> the first page. At that point you may as well just require the caller to
> flag the bio/rq as being P2P, and then do a check for P2P compatibility
> with the queue.

Hmm, we had something like that in v4[1] but it just seemed redundant to
create a flag when the information was already in the bio and kind of
ugly for the caller to check for, then set, the flag. I'm not _that_
averse to going back to that though...

Logan

[1]
https://lore.kernel.org/lkml/20180423233046.21476-8-logang at deltatee.com/T/#u
