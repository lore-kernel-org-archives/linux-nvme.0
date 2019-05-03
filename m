From: kbusch@kernel.org (Keith Busch)
Date: Fri, 3 May 2019 06:09:15 -0600
Subject: [PATCH v2 08/10] nvme/pci: implement the mdev external queue
 allocation interface
In-Reply-To: <f1f471e0b734413e6c0f7a8bb1a03041b1d12d6d.camel@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-9-mlevitsk@redhat.com>
 <63a499c3-25be-5c5b-5822-124854945279@intel.com>
 <f1f471e0b734413e6c0f7a8bb1a03041b1d12d6d.camel@redhat.com>
Message-ID: <20190503120915.GA30013@localhost.localdomain>

On Fri, May 03, 2019@12:20:17AM +0300, Maxim Levitsky wrote:
> On Thu, 2019-05-02@15:12 -0600, Heitke, Kenneth wrote:
> > On 5/2/2019 5:47 AM, Maxim Levitsky wrote:
> > > +static void nvme_ext_queue_free(struct nvme_ctrl *ctrl, u16 qid)
> > > +{
> > > +	struct nvme_dev *dev = to_nvme_dev(ctrl);
> > > +	struct nvme_queue *nvmeq;
> > > +
> > > +	mutex_lock(&dev->ext_dev_lock);
> > > +	nvmeq = &dev->queues[qid];
> > > +
> > > +	if (WARN_ON(!test_bit(NVMEQ_EXTERNAL, &nvmeq->flags)))
> > > +		return;
> > 
> > This condition is probably not expected to happen (since its a warning)
> > but do you need to unlock the ext_dev_lock before returning?
> 
> This is true, I will fix this. This used to be BUG_ON, but due to checkpatch.pl
> complains I turned them all to WARN_ON, and missed this.

Gentle reminder to trim your replies to the relevant context. It's
much easier to read when we don't need to scroll through hundreds of
unnecessary lines.
