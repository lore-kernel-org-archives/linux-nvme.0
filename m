From: hch@lst.de (Christoph Hellwig)
Date: Sun, 24 Sep 2017 17:25:31 +0200
Subject: [PATCH 8/9] nvme: track shared namespaces
In-Reply-To: <20170921151631.GA10713@localhost.localdomain>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-9-hch@lst.de>
 <20170920083643.xe6dbr4iu53hhm5t@linux-x5ow.site>
 <20170920145436.GA4709@lst.de>
 <20170921052217.kmrcmsf4gttubsyd@linux-x5ow.site>
 <20170921143748.GB18424@lst.de>
 <20170921151631.GA10713@localhost.localdomain>
Message-ID: <20170924152531.GA16753@lst.de>

On Thu, Sep 21, 2017@11:16:31AM -0400, Keith Busch wrote:
> If there weren't resistence to renaming structs, it would be more
> aligned to how the specification calls these if we rename nvme_ns to
> nvme_ns_path, and what you're calling nvme_ns_head is should just be
> the nvme_ns.

Then we'd still need a good name for what's now nvme_ns :)

But seriously speaking - I'm a little worried because Linus is really
pissed at me for doing major refactoring in block land (by proxy of
Jens who gets all the heat).  I just don't feel comfortable with a
rename at the moment, even if it's the right thing.
