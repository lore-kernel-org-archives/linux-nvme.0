From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 18 May 2018 10:28:04 -0600
Subject: [PATCH V6 11/11] nvme: pci: support nested EH
In-Reply-To: <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180517084129.GA26570@lst.de>
 <20180517142051.GB22063@localhost.localdomain>
 <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
Message-ID: <20180518162804.GA27795@localhost.localdomain>

On Thu, May 17, 2018@04:23:45PM +0200, Johannes Thumshirn wrote:
> > Agreed. Alternatively possibly call the driver's reset_preparei/done
> > callbacks.
> 
> Exactly, but as long as we can issue the reset via sysfs the test-case
> is still valid.

I disagree the test case is valid. The test writes '0' to the
pci-sysfs 'enable', but the driver also disables the pci device as part
of resetting, which is a perfectly reasonable thing for a driver to do.

If the timing of the test's loop happens to write '0' right after the
driver disabled the device that it owns, a 'write error' on that sysfs
write occurs, and blktests then incorrectly claims the test failed.
