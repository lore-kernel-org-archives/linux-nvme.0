From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 Jul 2019 08:33:24 +0200
Subject: [PATCH] nvme-tcp: Use protocol specific operations while
 reading socket
In-Reply-To: <20190724062836.GA25058@chelsio.com>
References: <20190708095200.15921-1-bharat@chelsio.com>
 <20190724062836.GA25058@chelsio.com>
Message-ID: <20190724063324.GA1999@lst.de>

On Wed, Jul 24, 2019@11:58:38AM +0530, Potnuri Bharat Teja wrote:
> On Monday, July 07/08/19, 2019@15:22:00 +0530, Potnuri Bharat Teja wrote:
> > Using socket specific read_sock() calls instead of directly calling
> > tcp_read_sock() helps lld module registered handlers if any, to be called
> > from nvme-tcp host.
> > This patch therefore replaces the tcp_read_sock() with socket specific
> > prot_ops.
> > 
> > Signed-off-by: Potnuri Bharat Teja <bharat at chelsio.com>
> > Acked-by: Sagi Grimberg <sagi at grimberg.me>
> > ---
> Hi Sagi/Christoph,
> Can this be queued for rc?

How is this a -rc candidate?  I was planning on queuing it up for 5.4444.
