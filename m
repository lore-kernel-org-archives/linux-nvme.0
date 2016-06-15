From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 15 Jun 2016 10:09:33 -0300
Subject: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
In-Reply-To: <20160615101045.GB16425@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
 <57607D0E.1060907@linux.vnet.ibm.com> <20160615101045.GB16425@lst.de>
Message-ID: <5761538D.6060303@linux.vnet.ibm.com>

Thanks for the responses Bart and Christoph.


On 06/15/2016 07:10 AM, Christoph Hellwig wrote:
> On Tue, Jun 14, 2016@06:54:22PM -0300, Guilherme G. Piccoli wrote:
>> On 06/14/2016 04:58 PM, Christoph Hellwig wrote:
>>> This is lifted from the blk-mq code and adopted to use the affinity mask
>>> concept just intruced in the irq handling code.
>>
>> Very nice patch Christoph, thanks. There's a little typo above, on
>> "intruced".
>
> fixed.
>
>> Another little typo above in "assining".
>
> fixed a swell.
>
>> I take this opportunity to ask you something, since I'm working in a
>> related code in a specific driver
>
> Which driver?  One of the points here is to get this sort of code out
> of drivers and into common code..

A network driver, i40e. I'd be glad to implement/see some common code to 
raise the topology information I need, but I was implementing on i40e 
more as a test case/toy example heheh...


>> - sorry in advance if my question is
>> silly or if I misunderstood your code.
>>
>> The function irq_create_affinity_mask() below deals with the case in which
>> we have nr_vecs < num_online_cpus(); in this case, wouldn't be a good idea
>> to trying distribute the vecs among cores?
>>
>> Example: if we have 128 online cpus, 8 per core (meaning 16 cores) and 64
>> vecs, I guess would be ideal to distribute 4 vecs _per core_, leaving 4
>> CPUs in each core without vecs.
>
> There have been some reports about the blk-mq IRQ distribution being
> suboptimal, but no one sent patches so far.  This patch just moves the
> existing algorithm into the core code to be better bisectable.
>
> I think an algorithm that takes cores into account instead of just SMT
> sibling would be very useful.  So if you have a case where this helps
> for you an incremental patch (or even one against the current blk-mq
> code for now) would be appreciated.

...but now I'll focus on the common/general case! Thanks for the 
suggestion Christoph. I guess would be even better to have a generic 
function that retrieves an optimal mask, something like 
topology_get_optimal_mask(n, *cpumask), in which we get the best 
distribution of n CPUs among all cores and return such a mask - 
interesting case is when n < num_online_cpus. So, this function could be 
used inside your irq_create_affinity_mask() and maybe in other places it 
is needed.

I was planning to use topology_core_id() to retrieve the core of a CPU, 
if anybody has a better idea, I'd be glad to hear it.

Cheers,


Guilherme


>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
