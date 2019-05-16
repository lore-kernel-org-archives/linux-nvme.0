From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 08:40:17 -0600
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <20190516064651.GA30234@lst.de>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
Message-ID: <20190516144017.GA23372@localhost.localdomain>

On Wed, May 15, 2019@11:46:51PM -0700, Christoph Hellwig wrote:
> On Wed, May 15, 2019@03:33:51PM -0600, Keith Busch wrote:
> > So here's a solution that no one will like: pull subsystem and controller
> > instances from the same IDA so that there won't be any namespace block
> > devices with a matching controller handle name. While this does nothing
> > to clear up device relationships, this will force the user to think
> > really hard about what they're doing and avoid such mistakes.
> 
> Hmm.  So we'll get:
> 
> /dev/nvme0
>  - chardev subsys X ctl 1
> 
> /dev/nvme1n1
> /dev/nvme1n2
>  - namespaces for subsys X
> 
> /dev/nvme2
>  - chardev subsys X ctl 2
> 
> /dev/nvme3
>  - chardev subsys Y ctl 1
> 
> ...
> 
> This should work.  Not sure it really buys us so much, though.

Right, it's not much. The only thing I want accomplish with this is to remove any excuse for
sending commands to the wrong handle. We can insist that it's wrong 
 
> Btw, I wonder if we should have udev rules for:
> 
> /dev/nvme-subsys-$NQN-ctrl1
> /dev/nvme-subsys-$NQN-ctrl2
> /dev/nvme-subsys-$NQN-ns1
> /dev/nvme-subsys-$NQN-ns2
> 
> I have to admit that since udev/systemd moved to github I can't
> be bother to send them patches, though as it would require signing
> up for that crappy service.

I can send it on your behalf if you have a rule in mind.

We do already have /dev/disk/by-{path,id,uuid} rules already, if that's
what you're looking for.

We don't have rules for the chardev though. Those devices are skipped in
60-persistent-naming.rules.
