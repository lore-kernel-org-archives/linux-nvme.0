From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 8 Apr 2019 13:42:57 +0300
Subject: [PATCHv2] nvmet: make MDTS value configurable
In-Reply-To: <20190408061644.GA26437@lst.de>
References: <20190403230654.109698-1-hare@suse.de>
 <20190404052720.GB7497@lst.de>
 <90391425-546f-61ad-ca9e-890e0246bf3c@mellanox.com>
 <20190408061644.GA26437@lst.de>
Message-ID: <fb0baf79-abbe-55be-c621-abf4d80355d9@mellanox.com>


On 4/8/2019 9:16 AM, Christoph Hellwig wrote:
> On Sun, Apr 07, 2019@03:51:53PM +0300, Max Gurtovoy wrote:
>> On 4/4/2019 8:27 AM, Christoph Hellwig wrote:
>>> On Thu, Apr 04, 2019@01:06:54AM +0200, Hannes Reinecke wrote:
>>>> Some drivers and/or use-cases might need to set a smaller MDTS
>>>> value, so add a per-port attribute to modify the MDTS value.
>>> If the drivers need it they need to communicate that value up the
>>> stack.  We should not require user inputs to make things work.
>> I suggested to add ops function.
>>
>> Something like (pseudo code):
>>
>>
>> static u8 nvmet_rdma_port_mdts(struct nvmet_port *nport)
>> {
>>  ??????? struct nvmet_rdma_port *port = nport->priv;
>>  ??????? struct rdma_cm_id *cm_id = port->cm_id;
>>
>>  ??????? /* we assume ctrl page_size is 4K */
>>  ??????? return ilog2(cm_id->device->attrs.max_io_sz / SZ_4K);
>> }
>>
>>
>> but after digging the code, there is still work to be done in order to do
>> it...
> The general idea sounds fine to me.  Can you look into it?

Yes, from what I saw we don't limit the max_io_size in the target since 
we're using the rw-API.

In case 1 rdma ctx is not enough (MR page list for example) we use more 
ctx's in the rw-API. I think we have a bug there since we don't check 
that nr_ops is not to big for transaction.

So probably we need to add some limit int nvmet/RDMA for that as 
NFS/RDMA does (let's agree on some value/module_param/tunable).

Or we can say that the limit is (if we force MRs for example):

rdma_rw_fr_page_list_len(device) * device_page_size * 
max_mrs_per_transaction.

We also need to calculate mr_pool_size and max_rdma_ctxs more carefully IMO.

So let's agree on the approach and then implement a solution (Sagi, can 
you comments on that too please ?)


Nevertheless, While digging into it I saw some improvements we can do to 
rw-API, so I'm preparing few patches (add static allocations option 
instead of allocations in fast-path).

-Max.
