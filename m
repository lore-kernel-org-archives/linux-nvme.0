From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 Mar 2018 11:40:53 -0600
Subject: [PATCH V3] nvme-pci: assign separate irq vectors for adminq and
 ioq1
In-Reply-To: <20180313104452.GA8782@ming.t460p>
References: <1520935088-1343-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180313104452.GA8782@ming.t460p>
Message-ID: <20180313174052.GJ18494@localhost.localdomain>

On Tue, Mar 13, 2018@06:45:00PM +0800, Ming Lei wrote:
> On Tue, Mar 13, 2018@05:58:08PM +0800, Jianchao Wang wrote:
> > Currently, adminq and ioq1 share the same irq vector which is set
> > affinity to cpu0. If a system allows cpu0 to be offlined, the adminq
> > will not be able work any more.
> > 
> > To fix this, assign separate irq vectors for adminq and ioq1. Set
> > .pre_vectors == 1 when allocate irq vectors, then assign the first
> > one to adminq which will have affinity cpumask with all possible
> > cpus. On the other hand, if controller has only legacy or single
> > -message MSI, we will setup adminq and 1 ioq and let them share
> > the only one irq vector.
> > 
> > Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> 
> Reviewed-by: Ming Lei <ming.lei at redhat.com>

Thanks, applied with an updated changelog.

Not being able to use the admin queue is a pretty big deal, so it's pushed
to the next nvme 4.16-rc branch. This may even be good stable material.
