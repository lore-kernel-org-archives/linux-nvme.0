From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 19 Apr 2016 11:25:17 -0700
Subject: [PATCH] nvme: fix nvme_ns_remove() deadlock
In-Reply-To: <1461020178.1419.2.camel@ssi>
References: <1461003703-18950-1-git-send-email-mlin@kernel.org>
 <20160418183214.GC4640@localhost.localdomain>
 <20160418203714.GA6484@lst.de> <1461020178.1419.2.camel@ssi>
Message-ID: <20160419182517.GA19164@infradead.org>

On Mon, Apr 18, 2016@03:56:18PM -0700, Ming Lin wrote:
> You mean below changes(un-tested)?

Yes, that's exactly what I had in mind.
