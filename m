From: axboe@fb.com (Jens Axboe)
Date: Thu, 20 Apr 2017 10:31:36 -0600
Subject: [PATCH] nvme/pci: Poll CQ on timeout
In-Reply-To: <20170420162855.GA25259@localhost.localdomain>
References: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
 <20170228141017.GC20317@lst.de>
 <20170228160056.GA15639@localhost.localdomain>
 <6c0cacb0-ab91-6270-8bae-dbd18a8dbd0e@fb.com>
 <20170420085609.GA6217@linux-x5ow.site>
 <20170420142044.GB21311@localhost.localdomain>
 <4c3be76c-0ae3-a95a-3067-cebb9fab340e@fb.com>
 <8ae3cdeb-0c81-7ce9-758e-717d7955808c@grimberg.me>
 <20170420162855.GA25259@localhost.localdomain>
Message-ID: <dd4e55da-a01a-9671-cd25-3b65add80872@fb.com>

On 04/20/2017 10:28 AM, Keith Busch wrote:
> On Thu, Apr 20, 2017@07:17:40PM +0300, Sagi Grimberg wrote:
>>
>>>> Thanks, I forgot about this one, but still think it's a good idea.
>>>> Applied it to for-next.
>>>
>>> Agree, it's a nice addition.
>>
>> I think its harmless to have. especially when we do log that it
>> happened.
> 
> It's actually proved to be quite useful and maybe good for stable. Any
> objections to roll this into 4.11 instead 4.12?

I'll object to that, we should not queue up anything for 4.11 that
isn't potentially fixing a major issue at this point.

-- 
Jens Axboe
