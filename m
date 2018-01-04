From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 11:04:40 +0100
Subject: [PATCH 1/1] nvme: Modify the debug level for setting shutdown
 timeout
In-Reply-To: <1514727207-8460-1-git-send-email-maxg@mellanox.com>
References: <1514727207-8460-1-git-send-email-maxg@mellanox.com>
Message-ID: <20180104100440.GC4436@lst.de>

On Sun, Dec 31, 2017@03:33:27PM +0200, Max Gurtovoy wrote:
> When an NVMe controller reports RTD3 Entry Latency larger than
> the value of shutdown_timeout module parameter, we update the
> shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an
> Informational debug level instead of a Warning level for it.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

I'm ok with just info, but in the end it seems like a pretty
buggy device..
