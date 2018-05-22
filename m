From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 22 May 2018 09:35:39 +0200
Subject: [PATCH V6 11/11] nvme: pci: support nested EH
In-Reply-To: <20180518162804.GA27795@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180517084129.GA26570@lst.de>
 <20180517142051.GB22063@localhost.localdomain>
 <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
 <20180518162804.GA27795@localhost.localdomain>
Message-ID: <20180522073539.ygl4ibokbohnjxlj@linux-x5ow.site>

On Fri, May 18, 2018@10:28:04AM -0600, Keith Busch wrote:
> On Thu, May 17, 2018@04:23:45PM +0200, Johannes Thumshirn wrote:
> > > Agreed. Alternatively possibly call the driver's reset_preparei/done
> > > callbacks.
> > 
> > Exactly, but as long as we can issue the reset via sysfs the test-case
> > is still valid.
> 
> I disagree the test case is valid. The test writes '0' to the
> pci-sysfs 'enable', but the driver also disables the pci device as part
> of resetting, which is a perfectly reasonable thing for a driver to do.
> 
> If the timing of the test's loop happens to write '0' right after the
> driver disabled the device that it owns, a 'write error' on that sysfs
> write occurs, and blktests then incorrectly claims the test failed.

Hmm, ok that's a valid point. But seeing you have sent a patch for
blktests anyways I think it's gone now.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
