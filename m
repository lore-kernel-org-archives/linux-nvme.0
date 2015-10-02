From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Oct 2015 06:15:29 -0700
Subject: [PATCH 3/4] nvme: split pci specific functionality out of core
 code
In-Reply-To: <1443717338.2803.58.camel@linux.intel.com>
References: <1443493257.3449.15.camel@linux.intel.com>
 <560D2D26.5000703@dev.mellanox.co.il>
 <1443717338.2803.58.camel@linux.intel.com>
Message-ID: <20151002131529.GA27956@infradead.org>

On Thu, Oct 01, 2015@09:35:38AM -0700, J Freyensee wrote:
> What is not clear that the summary email and the the 'Subject' line is
> not explaining?

The summary is just a little intro, you need to explain the purpose
of the patch in the that patch as that's the only thing that will be
in the commit and thus easily available later.

> Would you like me to just include the summary email
> into patch 2/4 and 3/4?

Yes!

> Other than that, is the actual patch ok?  I was about ready to send an
> email asking if the silence of this patch set means it is OK and will
> be applied to the nvme tree to submission to the upstream kernel?

This is not at all.  I think it's the polar opposite of how I'd like to
see the split.  I fear I can't explain all the details due to NDAs here,
but we can take it up offline as you're bound by the same NDA.

Anyway, here is my suggestion on how to move forward.

(1) please work on fixing all the process issues first.

Your mail line wraps the patches, which make them impossible to apply.
Ask other people like Keith how to get git-send-email working inside the
intel environment.  That'll also take care of proper threading of the
multiple patches and the intro mail while we're at it.  Write proper
changeslogs.

(2) Let's get the file move in.  I would suggest to move the current
nvme-core.c to drivers/nvme/host/pci.  This is because it actually
contains way more PCI specific than common code, and also because this
means we can move pieces of code to the common layer in small bits once
we agree on the exact abstractions.

(3) We need to sort out the headers.  Currently the two nvme.h headers
are a good example on how not to set up headers for a kernel driver.  We
need to have one for the actual ioctl API, one for the common nvme
hardware / protocol defintions, and one for structures and prototypes
at least.  I have started some work on this, and I can put it on the
backburner.  It's pretty independend of (1) and (2) so this looks like
a good split of work.

After than we can start moving existing common data structures (e.g.
struct nvme_ns) to the common code, and start splitting out common
bits from nvme_dev and nvme_queue and move them.  I do not agree with
the current split in your patches as it moves way too much into common
code.  After that grunt work is done we can start moving functionality
to the common code one bit at a time while adding operations vectors
as needed.  I would suggest to start with the scsi translation layer
as that sits on top of the request structure and would only has an
absolutely minimal dependency on the PCI code.  Namespace scanning
would be a next logical step after than.
