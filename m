From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 Apr 2015 23:34:39 -0700
Subject: [PATCH 1/5 v2] blk-mq: Add prep/unprep support
In-Reply-To: <1429101284-19490-2-git-send-email-m@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-2-git-send-email-m@bjorling.me>
Message-ID: <20150417063439.GB389@infradead.org>

On Wed, Apr 15, 2015@02:34:40PM +0200, Matias Bj??rling wrote:
> Allow users to hook into prep/unprep functions just before an IO is
> dispatched to the device driver. This is necessary for request-based
> logic to take place at upper layers.

I don't think any of this logic belongs into the block layer.  All this
should be library functions called by the drivers.
