From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 30 May 2017 01:36:51 -0700
Subject: [PATCH v2 1/2] nvme_fc: create fc class and transport device
In-Reply-To: <20170513190559.25484-2-jsmart2021@gmail.com>
References: <20170513190559.25484-1-jsmart2021@gmail.com>
 <20170513190559.25484-2-jsmart2021@gmail.com>
Message-ID: <20170530083651.GA18275@infradead.org>

On Sat, May 13, 2017@12:05:58PM -0700, James Smart wrote:
> Added a new fc class, and a device node for the nvme_fc transport
> under it. I expect the fc class will eventually be the location the
> SCSI and FC transports merge in the future.

If we chose a nvme name for it that pretty much keeps us from doing
that.  It would seem a bit silly to create a new module for just these
few lines, but I think we should keep the name neutral and document the
purpose with extensive comments.  And maybe (just maybe) move it into a
separate source file.
