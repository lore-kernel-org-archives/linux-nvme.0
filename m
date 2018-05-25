From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 14:31:55 +0200
Subject: [PATCHv3 5/9] nvme-pci: End IO requests in CONNECTING state
In-Reply-To: <20180524210313.GL11037@localhost.localdomain>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-6-keith.busch@intel.com>
 <20180524204722.GB29048@lst.de>
 <20180524210313.GL11037@localhost.localdomain>
Message-ID: <20180525123154.GA23463@lst.de>

On Thu, May 24, 2018@03:03:13PM -0600, Keith Busch wrote:
> > How can we hit this case?  This just looks a lot like papering
> > over the real issue..
> 
> It'll most likley never really happen. The conditions are a pretty obscure
> timeout handling cases mixed with other errors that could theoretically
> hit it, requiring two or more namespaces.
> 
> The real fix, IMO, is wahat the blk-mq timeout enhancements are working
> toward, so I've no problem dropping this patch.

Ok, lets fix the real issue then.
