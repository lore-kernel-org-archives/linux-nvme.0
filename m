From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 3 Jul 2017 13:49:26 +0300
Subject: block: spread MSI(-X) vectors to all possible CPUs
In-Reply-To: <5dee80fb-8439-8611-a5f2-a30f1aefb835@kernel.dk>
References: <20170626102058.10200-1-hch@lst.de>
 <5dee80fb-8439-8611-a5f2-a30f1aefb835@kernel.dk>
Message-ID: <933e41e4-6c02-9ccd-1b60-76f4faeb5b22@mellanox.com>



On 6/27/2017 9:24 PM, Jens Axboe wrote:
> On 06/26/2017 04:20 AM, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series contains the left-over block bits to spread the MSI-X
>> vectors over all CPU.  Thomas already rewrote and then merged the
>> irq bits into the tip irq/core branch, and this is the remainder.
>>
>> As there are no dependencies on other block changes adding them
>> to the tip tree might be easiest if Jens could ACK them.
>
> Looks fine to me, you can add my Reviewed-by if you want to funnel
> them through the tip tree.
>

I guess we'll need to do some rebasing with my "blk-mq: map all HWQ also 
in hyperthreaded system" patch.
Jens/Christoph,
how do you prefer doing it ?
