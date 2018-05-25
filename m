From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 14:36:33 +0200
Subject: [PATCHv3 9/9] nvme-pci: Don't wait for HMB completion on shutdown
In-Reply-To: <20180524211539.GM11037@localhost.localdomain>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-10-keith.busch@intel.com>
 <20180524204506.GA29048@lst.de>
 <20180524211539.GM11037@localhost.localdomain>
Message-ID: <20180525123633.GC23463@lst.de>

On Thu, May 24, 2018@03:15:39PM -0600, Keith Busch wrote:
> > Also if we really need to reset the controller submitting any command
> > just doesn't seem very helpful.  We might as well just skip trying
> > to disable the HMB, as the controller needs to come up in a clean
> > state anyway.
> 
> That's also fine with me.

So let's go for the most simple option..
