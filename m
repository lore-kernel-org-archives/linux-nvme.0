From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Dec 2016 18:59:59 +0100
Subject: [PATCH] nvme: support bi-directional commands
In-Reply-To: <20161207180723.GE29574@localhost.localdomain>
References: <1481132364-20583-1-git-send-email-keith.busch@intel.com>
 <20161207173323.GA24967@lst.de>
 <20161207175049.GD29574@localhost.localdomain>
 <20161207174427.GA25211@lst.de>
 <20161207180723.GE29574@localhost.localdomain>
Message-ID: <20161207175959.GA25611@lst.de>

On Wed, Dec 07, 2016@01:07:24PM -0500, Keith Busch wrote:
> On Wed, Dec 07, 2016@06:44:27PM +0100, Christoph Hellwig wrote:
> > On Wed, Dec 07, 2016@12:50:50PM -0500, Keith Busch wrote:
> > > NVMe defines this capability, so why would we want to make it unreachable
> > > in Linux?
> > 
> > NVMe defines no user of it, so that defintion is entirely theoretical
> > and it's a giant mess
> 
> It defines the use, but no user today. We can burn that bridge when we
> get there.

It does not define anything related to bidi comments.  The only mention
of bidirection is in the explanation of the table column.  And I'm not
being mean here - your patch assumes bidi commands would use the
a single data pointer for in and out data.  On the other hand all
bidirectional commands in SCSI do use separate data in and data out
buffers.  So any command "ported" from SCSI would work completely
differently from whatever vendor specific command you're trying to
support.

Please go to the NVMe committee first and define semantics for
bidirectional commands first.  After that we can decide how to support
them in Linux.
