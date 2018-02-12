From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Feb 2018 14:46:02 -0700
Subject: [PATCH 2/3] nvme: Sync queues on controller resets
In-Reply-To: <8a34b67a-1889-46d7-0658-b3834f22720f@oracle.com>
References: <20180209174127.7224-1-keith.busch@intel.com>
 <20180209174127.7224-2-keith.busch@intel.com>
 <a16208e7-9b1a-1270-fd34-3bd743c07918@oracle.com>
 <8a34b67a-1889-46d7-0658-b3834f22720f@oracle.com>
Message-ID: <20180212214601.GB20962@localhost.localdomain>

On Sun, Feb 11, 2018@09:53:03AM +0800, jianchao.wang wrote:
> On 02/10/2018 09:55 AM, jianchao.wang wrote:
> > There could be a circular pattern here. Please consider the following scenario:
> > 
> > timeout_work context                    reset_work context
> > nvme_timeout                            nvme_reset_work
> >   -> nvme_dev_disable                     -> nvme_sync_queues // hold namespace_mutex
> >     -> nvme_stop_queues                     -> blk_sync_queue
> >       -> require namespaces_mutex               -> cancel_work_sync(&q->timeout_work)
> > 
> 
> Looks like we could use rwsem to replace namespaces_mutex.

Looks like rwsem is queued up for 4.17. I'll send an update based on
that. I guess this one and 3/3 can wait for 4.17, but 1/3 should still
go in 4.16.
