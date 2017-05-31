From: hch@lst.de (Christoph Hellwig)
Date: Wed, 31 May 2017 11:45:31 +0200
Subject: [PATCH 2/7] nvmet: add uuid field to nvme_ns and populate via
 configfs
In-Reply-To: <c5537393-445d-73f8-f8e0-cc9c51d3edcb@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <4aecbc794651073b2812341dc63e1f2918cc6a82.1496131397.git.jthumshirn@suse.de>
 <20170530092442.GA16736@lst.de>
 <c5537393-445d-73f8-f8e0-cc9c51d3edcb@suse.de>
Message-ID: <20170531094531.GB10718@lst.de>

On Tue, May 30, 2017@11:48:09AM +0200, Johannes Thumshirn wrote:
> On 05/30/2017 11:24 AM, Christoph Hellwig wrote:
> > This should be stored as a uuid_t (or rather uuid_be in the current
> > kernel, but I'm about to rename it), and use uuid_be_to_bin / uuid_to_bin
> > for parsing.
> 
> OK, thought you ask me to do that. Which one do you prefer?

I think you'll have to use the old names, unless we get the uuid
changes stabilized soon and can pull the branch for it into the
nvme / block tree.  So go with those for now, and I'll do any
after the fact cleanup later.
