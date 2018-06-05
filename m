From: roman.penyaev@profitbricks.com (Roman Penyaev)
Date: Tue, 5 Jun 2018 12:19:46 +0200
Subject: [PATCH v2 2/8] nvmet-rdma: wrap raw kref_get/put() with
 corresponding helpers
In-Reply-To: <20180605044347.GA29420@lst.de>
References: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
 <20180604123003.24748-3-roman.penyaev@profitbricks.com>
 <20180604214916.GC24926@ziepe.ca> <20180605044347.GA29420@lst.de>
Message-ID: <CAJrWOzDiw=wiNrrjccm6p_Z4x6=SVGBzv927LDr7CR2DRCo50w@mail.gmail.com>

On Tue, Jun 5, 2018@6:43 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 04, 2018@03:49:16PM -0600, Jason Gunthorpe wrote:
>> > +{
>> > +   return kref_put(&dev->ref, nvmet_rdma_free_device);
>> > +}
>> > +
>> > +static int nvmet_rdma_dev_get(struct nvmet_rdma_device *dev)
>> > +{
>> > +   return kref_get_unless_zero(&dev->ref);
>> > +}
>>
>> Don't wrap get_unless_zero with something called get..
>
> Agreed.  And I hate all these wrappers.  Either we use kref_*
> or we use wrappers and plain refcount_* ops, not both.

What I did not mention in the commit message is that this is
done only to unify the code with host/rdma.c, which has
exactly the same wrappers.  Since I am touching both sides
(host and target) this code difference annoys.

You think better to remove wrappers from nvme host or just
leave everything as is?

--
Roman
