From: hch@lst.de (Christoph Hellwig)
Date: Mon, 25 Sep 2017 14:52:11 +0200
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <daf5fe87-6b93-68aa-65be-b442615b9bd0@suse.de>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
 <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>
 <83264609-d5f9-8990-d79e-0b6eed1b2471@grimberg.me>
 <31e90477-59fc-8f70-d482-50c25393f58f@suse.de>
 <6d9304e2-f943-f063-1298-c6a2d582f78f@grimberg.me>
 <daf5fe87-6b93-68aa-65be-b442615b9bd0@suse.de>
Message-ID: <20170925125211.GD8130@lst.de>

On Mon, Sep 25, 2017@10:23:16AM +0200, Hannes Reinecke wrote:
> > We could have such an interface I assume. But it would suck to maintain
> > yet another state (we are already having enough trouble to have a
> > coherent controller state machine).
> 
> Weell ... we could be using a notifier chain for that.
> I think I should post my patchset.

The point is: if you want proper multipath behavior use the nvme
in-kernel multipath code.  If you want to weird crap in userspace don't
expect any help from the kernel driver.
