From: kashyap.desai@broadcom.com (Kashyap Desai)
Date: Fri, 14 Jun 2019 01:28:47 +0530
Subject: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
In-Reply-To: <20190608081400.GA19573@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
 <20190608081400.GA19573@lst.de>
Message-ID: <98f6557ae91a7cdfe8069fcf7d788c88@mail.gmail.com>

>
> On Thu, Jun 06, 2019@09:07:27PM +0530, Kashyap Desai wrote:
> > Hi Christoph, Changes for <megaraid_sas> and <mpt3sas> looks good. We
> > want to confirm few sanity before ACK. BTW, what benefit we will see
> > moving virt_boundry setting to SCSI mid layer ? Is it just modular
> > approach OR any functional fix ?
>
> The big difference is that virt_boundary now also changes the
> max_segment_size, and this ensures that this limit is also communicated
to
> the DMA mapping layer.
Is there any changes in API  blk_queue_virt_boundary? I could not find
relevant code which account for this. Can you help ?
Which git repo shall I use for testing ? That way I can confirm, I didn't
miss relevant changes.

>From your above explanation, it means (after this patch) max segment size
of the MR controller will be set to 4K.
Earlier it is possible to receive single SGE of 64K datalength (Since max
seg size was 64K), but now the same buffer will reach the driver having 16
SGEs (Each SGE will contain 4K length).
Right ?

Kashyap
