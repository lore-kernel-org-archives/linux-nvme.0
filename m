From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 12 Apr 2016 12:08:26 -0700
Subject: [PATCH v2] nvme: add missing lock nesting notation
In-Reply-To: <570D46A3.1040304@fb.com>
References: <1459877524-15471-1-git-send-email-mlin@kernel.org>
 <20160412190121.GC32482@infradead.org> <570D46A3.1040304@fb.com>
Message-ID: <20160412190826.GA20168@infradead.org>

On Tue, Apr 12, 2016@01:04:03PM -0600, Jens Axboe wrote:
> On 04/12/2016 01:01 PM, Christoph Hellwig wrote:
> >Jens, is this something we could still add to 4.6 to kill this annoying
> >warning?
> 
> Can't it wait until 4.7? It's not a regression in this merge window, looks
> like it happened for 4.5.

True.  On the other hand lockdep annotations are totally harmless..
