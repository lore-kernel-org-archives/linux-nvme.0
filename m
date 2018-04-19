From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Apr 2018 08:33:04 -0600
Subject: [PATCH 2/3] nvme: Sync queues on controller resets
In-Reply-To: <2e46f418-ea62-eebf-f2a6-0627645dcfff@oracle.com>
References: <20180209174127.7224-1-keith.busch@intel.com>
 <20180209174127.7224-2-keith.busch@intel.com>
 <a16208e7-9b1a-1270-fd34-3bd743c07918@oracle.com>
 <8a34b67a-1889-46d7-0658-b3834f22720f@oracle.com>
 <20180212214601.GB20962@localhost.localdomain>
 <2e46f418-ea62-eebf-f2a6-0627645dcfff@oracle.com>
Message-ID: <20180419143303.GA19048@localhost.localdomain>

On Wed, Apr 18, 2018@10:26:28AM +0800, jianchao.wang wrote:
> Hi Keith
> 
> On 02/13/2018 05:46 AM, Keith Busch wrote:
> > On Sun, Feb 11, 2018@09:53:03AM +0800, jianchao.wang wrote:
> >> On 02/10/2018 09:55 AM, jianchao.wang wrote:
> >>> There could be a circular pattern here. Please consider the following scenario:
> >>>
> >>> timeout_work context                    reset_work context
> >>> nvme_timeout                            nvme_reset_work
> >>>   -> nvme_dev_disable                     -> nvme_sync_queues // hold namespace_mutex
> >>>     -> nvme_stop_queues                     -> blk_sync_queue
> >>>       -> require namespaces_mutex               -> cancel_work_sync(&q->timeout_work)
> >>>
> >>
> >> Looks like we could use rwsem to replace namespaces_mutex.
> > 
> > Looks like rwsem is queued up for 4.17. I'll send an update based on
> > that. I guess this one and 3/3 can wait for 4.17, but 1/3 should still
> > go in 4.16.
> > 
> 
> Would you please queue this patch for next ?
> I incurred this issue when NVMe card died with a lot of in-flight requests.

Right, thanks for the reminder. I'll need to rebase and resend this.
Travelling at the moment, so may be another day or two. Thanks again!
