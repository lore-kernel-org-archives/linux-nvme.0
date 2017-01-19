From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Jan 2017 20:57:22 -0800
Subject: [PATCH 01/17] lpfc: Use new pci_alloc_irq_vectors() interface
In-Reply-To: <20170118165443.GA14012@infradead.org>
References: <587ec2ec.lHOM16QZ9nmppg4/%jsmart2021@gmail.com>
 <20170118165443.GA14012@infradead.org>
Message-ID: <81b7018d-6957-6a9a-b122-0dab31984541@gmail.com>


On 1/18/2017 8:54 AM, Christoph Hellwig wrote:
> On Tue, Jan 17, 2017@05:20:44PM -0800, James Smart wrote:
>> Move to new pci_alloc_irq_vectors() interface for intx/msi/msix
>>
>> Note: io channel paradigm remains, for now.
> Not exactly a well written changelog.  I'd like to know why this is
> better than my version here:
>
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/lpfc-msix
>
> It also seems to be missing the post_vectors setting for the
> Flash Optimized Fabric interrupt, which may lead to an incorrect
> vector assignment for all the queues.

well, my intent was to post what we've been testing for a while. Then we 
would look at your mods, the remaining blk-mq mods from Hannes, and 
re-evalute the io channel thing and see where we end up.   This patch 
was just an initial convert to new api change, with the real mods to 
queing and adapter configuration following in the initiator basemods 
patches (a..f). I know your mods did more than the simple api change.

thanks for the post_vectors pickup.

-- james
