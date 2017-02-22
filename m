From: hch@lst.de (Christoph Hellwig)
Date: Wed, 22 Feb 2017 08:17:54 +0100
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170221155703.GA4619@localhost.localdomain>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
 <20170220100515.GA20285@lst.de> <20170221155703.GA4619@localhost.localdomain>
Message-ID: <20170222071754.GA17709@lst.de>

On Tue, Feb 21, 2017@10:57:04AM -0500, Keith Busch wrote:
> This is for suspend/resume. The freeze start is done during the suspend
> phase, and the unfreeze on resume. Power management calls nvme_suspend,
> which calls nvme_dev_disable with 'suspend == true',

I guess I'm missing something in my tree then.  I have a local tree
with your five patches applied and there is no suspend argument anywhere
in pci.c.
