From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 May 2017 14:48:36 +0200
Subject: [PATCH 4/4] nvme-pci: implement host memory buffer support
In-Reply-To: <20170522072229.GI7850@localhost.localdomain>
References: <20170520131357.15929-1-hch@lst.de>
 <20170520131357.15929-5-hch@lst.de>
 <20170522072229.GI7850@localhost.localdomain>
Message-ID: <20170522124836.GC11869@lst.de>

On Mon, May 22, 2017@03:22:30AM -0400, Keith Busch wrote:
> > +out_free_bufs:
> > +	while (--i >= 0) {
> > +		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
> 
> I think you want to use the local desc's variable since
> dev->host_mem_descs isn't set if you goto this out_free_bufs label.

Indeed..
