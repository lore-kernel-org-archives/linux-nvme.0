From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Apr 2019 08:16:44 +0200
Subject: [PATCHv2] nvmet: make MDTS value configurable
In-Reply-To: <90391425-546f-61ad-ca9e-890e0246bf3c@mellanox.com>
References: <20190403230654.109698-1-hare@suse.de>
 <20190404052720.GB7497@lst.de>
 <90391425-546f-61ad-ca9e-890e0246bf3c@mellanox.com>
Message-ID: <20190408061644.GA26437@lst.de>

On Sun, Apr 07, 2019@03:51:53PM +0300, Max Gurtovoy wrote:
>
> On 4/4/2019 8:27 AM, Christoph Hellwig wrote:
>> On Thu, Apr 04, 2019@01:06:54AM +0200, Hannes Reinecke wrote:
>>> Some drivers and/or use-cases might need to set a smaller MDTS
>>> value, so add a per-port attribute to modify the MDTS value.
>> If the drivers need it they need to communicate that value up the
>> stack.  We should not require user inputs to make things work.
>
> I suggested to add ops function.
>
> Something like (pseudo code):
>
>
> static u8 nvmet_rdma_port_mdts(struct nvmet_port *nport)
> {
> ??????? struct nvmet_rdma_port *port = nport->priv;
> ??????? struct rdma_cm_id *cm_id = port->cm_id;
>
> ??????? /* we assume ctrl page_size is 4K */
> ??????? return ilog2(cm_id->device->attrs.max_io_sz / SZ_4K);
> }
>
>
> but after digging the code, there is still work to be done in order to do 
> it...

The general idea sounds fine to me.  Can you look into it?
