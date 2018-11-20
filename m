From: hare@suse.de (Hannes Reinecke)
Date: Tue, 20 Nov 2018 17:02:14 +0100
Subject: [PATCH 0/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <20181116082659.GA14334@lst.de>
References: <20181115122927.40431-1-hare@suse.de>
 <20181116082659.GA14334@lst.de>
Message-ID: <f235714b-6f3c-eba7-4f37-5bef6dab600e@suse.de>

On 11/16/18 9:26 AM, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018@01:29:25PM +0100, Hannes Reinecke wrote:
>> Hi all,
>>
>> after my NUMA path balancing patch hasn't met with universal approval,
> 
> Were there any good arguments against it vs just my implementation
> nitpicks?
> 
We had gotten reports that I/O only ever went via the first path, 
despite the node map being set correctly.

Plus the distribution algorithm to spread out the paths across the 
individual nodes is far from simple.

Also once we abandon direct NUMA mapping there's no good reason why we 
should be selecting paths based on NUMA node; it might actually be 
better to use the core id here, as then we could map as many paths as we 
have CPUs.

So in the end the round-robin scheduler was just easier to implement, 
and actually provided better performance on my testbed.

>> here's now my take on a 'real' round-robin I/O scheduler for NVMe multipathing.
>> With this patch I'm able to boost I/O performance from 127k/127k randrw
>> to 156k/156k randrw (as measured by fio).
> 
> Either way that is some horribly bad performance.  How much can
> you get by driving one namespace on each path invididually?
> 
Well ... might be, but these were the numbers I had been getting without 
tweaking the system. So while it might be possible to get better 
numbers, the question then would be why this hasn't been done automatically.

Seeing that the whole point of this patch is to _avoid_ additional 
tuning ...

Cheers,

Hannes
