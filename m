From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Apr 2018 19:33:36 +0200
Subject: [PATCH 00/19] nvmet: add support for file backed namespaces
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180424173336.GA30777@lst.de>

Hi Chaitanya,

I've been through the patches that implement the simple O_DIRECT
file support.  I think all these can in fact be merged into a single
patch and would be easier to review.  Can you resend just that merged
patch for the next respin?  I think we want to review the buffered
I/O support and the namespace management support as incremental series
on top of that to keep things a little smaller and easier to review.
