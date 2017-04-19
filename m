From: hch@lst.de (hch@lst.de)
Date: Wed, 19 Apr 2017 08:15:19 +0200
Subject: block: add a error_count field to struct request
In-Reply-To: <1492556229.2689.22.camel@sandisk.com>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-18-hch@bombadil.infradead.org>
 <1492556229.2689.22.camel@sandisk.com>
Message-ID: <20170419061519.GC6257@lst.de>

On Tue, Apr 18, 2017@10:57:11PM +0000, Bart Van Assche wrote:
> Both blk-mq and the traditional block layer support a .cmd_size field to
> make the block layer core allocate driver-specific data at the end of struct
> request. Could that mechanism have been used for the error_count field?

It could, and that's what I did for the modern drivers.  It would have
been a bit of a pain for these old floppy drivers, though.
