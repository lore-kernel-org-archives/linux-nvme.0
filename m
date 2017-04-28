From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Apr 2017 16:53:00 +0200
Subject: update ->init_request and ->exit_request prototypes
In-Reply-To: <20170427174501.18965-1-hch@lst.de>
References: <20170427174501.18965-1-hch@lst.de>
Message-ID: <20170428145300.GA1776@lst.de>

On Thu, Apr 27, 2017@07:44:56PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series (against for-4.12/post-merge) updates the blk-mq
> ->init_request and ->exit request methods to drop a now harmful
> parameter, and update one to pass a little more information.  It
> then cleans up the nvme drivers based on that.

Turns out that while Jeff was right that this won't work against
for-4.12/post-merge, it applies without fuzz and works fine against
for-next.  Sorry for the confusion.
