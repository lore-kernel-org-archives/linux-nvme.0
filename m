From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 30 Apr 2019 09:58:00 -0700
Subject: [PATCH 1/2] nvme: move command size checks to the core
In-Reply-To: <20190430153833.9011-1-hch@lst.de>
References: <20190430153833.9011-1-hch@lst.de>
Message-ID: <1556643480.161891.172.camel@acm.org>

On Tue, 2019-04-30@11:38 -0400, Christoph Hellwig wrote:
> Most command aren't PCIe specific, so move the size checking for them
> to core.c

Reviewed-by: Bart Van Assche <bvanassche at acm.org>
