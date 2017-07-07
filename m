From: axboe@fb.com (Jens Axboe)
Date: Fri, 7 Jul 2017 08:56:47 -0600
Subject: [PATCH] nvme-pci: add module parameter for io queue depth
In-Reply-To: <20170707135017.GB8782@lst.de>
References: <20170707090547.GA2420@localhost.didichuxing.com>
 <20170707135017.GB8782@lst.de>
Message-ID: <7e44fad3-cd77-bab8-b7ee-a72a9f0873af@fb.com>

On 07/07/2017 07:50 AM, Christoph Hellwig wrote:
> On Fri, Jul 07, 2017@05:05:47PM +0800, weiping zhang wrote:
>> Adjust io queue depth more easily.
>>
>> Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
> 
> Sounds useful in general, the only thin I'm worried about is that
> this will affect all drives in the system, which might have
> very different characteristics.  But I can't really think of
> a better approach.

That's a generic problem that all module parameters have, and it's
sometimes quite annoying. But that should be fixed separately.
I'm fine with this patch, it's an improvement over what we have.

-- 
Jens Axboe
