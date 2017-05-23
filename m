From: jsmart2021@gmail.com (James Smart)
Date: Tue, 23 May 2017 12:31:07 -0700
Subject: [PATCH v3 2/3] nvmet_fc: Reduce work_q count
In-Reply-To: <20170523071528.GB16776@infradead.org>
References: <20170522222844.22494-1-jsmart2021@gmail.com>
 <20170522222844.22494-3-jsmart2021@gmail.com>
 <20170523071528.GB16776@infradead.org>
Message-ID: <79da00e0-8abb-8694-2075-6461d6855623@gmail.com>

On 5/23/2017 12:15 AM, Christoph Hellwig wrote:
> On Mon, May 22, 2017@03:28:43PM -0700, James Smart wrote:
>> Instead of a work_q per controller queue, use system workqueues.
>> Create "work lists" per cpu that driver ISR posts to and workqueue
>> pulls from.
>
> Why?  The whole point of workqueues is to avoid this sort of open coded
> work lists in drivers.  To me it seems like you should simply make
> the existing workqueue global, and maybe mark it as cpu itensive based
> on profiling, but that's about it.

Why: to have parallelism and cpu affinity and its benefits for all the 
interim work the transport does for moving data/responses.

So I'm not sure how this differs from rdma. The bottom ib cq handler, 
which can be a workqueue element or a soft_irq instance, sits in a loop 
and processes the cq elements, calling the rdma transport done routine 
for each one, which does equivalent work. So both fc and rdma can be a 
workqueue element, both pull variable numbers of work items with caps on 
items per call, and the work per item is similar. So the only difference 
is rdma is pulling from a memory ring vs nvme-fc pulling from a linked list.

I can certainly remove the work list and go back to a work queue element 
work item. But I have to believe a work queue element for every 
completion is not as efficient as a simple linked list of the completions.

The idea of a global workqueue means you are effectively limited by the 
transaction rate of a single workqueue on a single cpu - no parallelism 
- which I've already seen exceeded in older implementations or 
combinations set up with the lldd. At a minimum, nvme-fc needs 
parallelization of work across cpus, and there has to be benefit in 
scheduling completions for the same queue on the same cpu and avoiding 
cross-cpu contention.

I'm open to alternative implementations - but it needs to be 
parallelized and minimize cross-cpu contention.

-- james
