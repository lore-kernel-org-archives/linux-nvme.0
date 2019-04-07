From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 7 Apr 2019 15:51:53 +0300
Subject: [PATCHv2] nvmet: make MDTS value configurable
In-Reply-To: <20190404052720.GB7497@lst.de>
References: <20190403230654.109698-1-hare@suse.de>
 <20190404052720.GB7497@lst.de>
Message-ID: <90391425-546f-61ad-ca9e-890e0246bf3c@mellanox.com>


On 4/4/2019 8:27 AM, Christoph Hellwig wrote:
> On Thu, Apr 04, 2019@01:06:54AM +0200, Hannes Reinecke wrote:
>> Some drivers and/or use-cases might need to set a smaller MDTS
>> value, so add a per-port attribute to modify the MDTS value.
> If the drivers need it they need to communicate that value up the
> stack.  We should not require user inputs to make things work.

I suggested to add ops function.

Something like (pseudo code):


static u8 nvmet_rdma_port_mdts(struct nvmet_port *nport)
{
 ??????? struct nvmet_rdma_port *port = nport->priv;
 ??????? struct rdma_cm_id *cm_id = port->cm_id;

 ??????? /* we assume ctrl page_size is 4K */
 ??????? return ilog2(cm_id->device->attrs.max_io_sz / SZ_4K);
}


but after digging the code, there is still work to be done in order to 
do it...


>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C01509c9c058248d7ada908d6b8be3f77%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636899524585583497&amp;sdata=BWEpJW%2BdnykRerFGvO6HXtrh2%2BMXr9GI%2BeGOux0vrGA%3D&amp;reserved=0
