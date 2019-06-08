From: hch@lst.de (Christoph Hellwig)
Date: Sat, 8 Jun 2019 10:14:00 +0200
Subject: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
In-Reply-To: <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
Message-ID: <20190608081400.GA19573@lst.de>

On Thu, Jun 06, 2019@09:07:27PM +0530, Kashyap Desai wrote:
> Hi Christoph, Changes for <megaraid_sas> and <mpt3sas> looks good. We want
> to confirm few sanity before ACK. BTW, what benefit we will see moving
> virt_boundry setting to SCSI mid layer ? Is it just modular approach OR any
> functional fix ?

The big difference is that virt_boundary now also changes the
max_segment_size, and this ensures that this limit is also communicated
to the DMA mapping layer.
