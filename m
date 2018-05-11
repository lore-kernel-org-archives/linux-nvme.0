From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 May 2018 08:19:47 +0200
Subject: [PATCH RFC 0/2] 8K Inline Support
In-Reply-To: <cover.1525880285.git.swise@opengridcomputing.com>
References: <cover.1525880285.git.swise@opengridcomputing.com>
Message-ID: <20180511061947.GB7962@lst.de>

On Wed, May 09, 2018@08:38:05AM -0700, Steve Wise wrote:
> For small nvmf write IO over the rdma transport, it is advantagous to
> make use of inline mode to avoid the latency of the target issuing an
> rdma read to fetch the data.  Currently inline is used for <= 4K writes.
> 8K, though, requires the rdma read.  For iWARP transports additional
> latency is incurred because the target mr of the read must be registered
> with remote write access.  By allowing 2 pages worth of inline payload,
> I see a reduction in 8K nvmf write latency of anywhere from 2-7 usecs
> depending on the RDMA transport..
> 
> Is this a worthwhile change?  I think it is.  Please comment!

I think this came up before.  I'm fine with supporting larger sizes,
but I really want the size configurable.  We can argue about the
default separately.
