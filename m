From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 24 May 2017 10:35:00 -0700
Subject: [PATCH v3 2/3] nvmet_fc: Reduce work_q count
In-Reply-To: <79da00e0-8abb-8694-2075-6461d6855623@gmail.com>
References: <20170522222844.22494-1-jsmart2021@gmail.com>
 <20170522222844.22494-3-jsmart2021@gmail.com>
 <20170523071528.GB16776@infradead.org>
 <79da00e0-8abb-8694-2075-6461d6855623@gmail.com>
Message-ID: <20170524173500.GA13151@infradead.org>

On Tue, May 23, 2017@12:31:07PM -0700, James Smart wrote:
> > Why?  The whole point of workqueues is to avoid this sort of open coded
> > work lists in drivers.  To me it seems like you should simply make
> > the existing workqueue global, and maybe mark it as cpu itensive based
> > on profiling, but that's about it.
> 
> Why: to have parallelism and cpu affinity and its benefits for all the
> interim work the transport does for moving data/responses.

Which is exactly the reason for using a workqueue - they do have
per cpu helpers and keep the affinity, and they keep the logic
for this in one place.

Documentation/core-api/workqueue.rst wil explain quite a bit of the
details.

> So I'm not sure how this differs from rdma. The bottom ib cq handler, which
> can be a workqueue element or a soft_irq instance, sits in a loop and
> processes the cq elements, calling the rdma transport done routine for each
> one, which does equivalent work. So both fc and rdma can be a workqueue
> element, both pull variable numbers of work items with caps on items per
> call, and the work per item is similar. So the only difference is rdma is
> pulling from a memory ring vs nvme-fc pulling from a linked list.

The difference is that by the time they are called we don't even know
how many elements we'll process.

> I can certainly remove the work list and go back to a work queue element
> work item. But I have to believe a work queue element for every completion
> is not as efficient as a simple linked list of the completions.


It should be very similar. The whole point of workqueues is to factor
this pattern into common helpers.
