From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 4 Oct 2016 06:58:25 -0700
Subject: [PATCH 1/7] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <60438ee8-66d4-4730-fed3-470a12bfa9a1@suse.de>
References: <57f34bb1.R7Xz9kkZOAJuQODz%james.smart@broadcom.com>
 <60438ee8-66d4-4730-fed3-470a12bfa9a1@suse.de>
Message-ID: <20161004135825.GB23761@infradead.org>

On Tue, Oct 04, 2016@09:32:39AM +0200, Hannes Reinecke wrote:
> I would have loved to use the SCSI FC headers here; eg the definitions
> for FC-LS are most definitely duplicated.
> But until we've sorted that one out:

I remember we discussed this before, but I've forgot the outcome on
why this needed to be separate.  IIRC it was just a timing issue,
but now that we've just missed the previous merge window we should
have plenty of time to sort that out properly.  Correct me if I'm wrong.
