From: hch@lst.de (Christoph Hellwig)
Date: Wed, 23 Jan 2019 08:42:11 +0100
Subject: [PATCH] nvme-fc: use pci device as parent for nvme controller
In-Reply-To: <4aa44211-8305-7474-9ff4-2f21e620ee21@broadcom.com>
References: <20190117074241.40672-1-hare@suse.de>
 <4aa44211-8305-7474-9ff4-2f21e620ee21@broadcom.com>
Message-ID: <20190123074211.GA25386@lst.de>

On Sun, Jan 20, 2019@08:38:59AM -0800, James Smart wrote:
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index feb86b59170e..1ecdec6b8b4a 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -3117,7 +3117,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>>   	 * Defer this to the connect path.
>>   	 */
>>   -	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
>> +	ret = nvme_init_ctrl(&ctrl->ctrl, ctrl->dev, &nvme_fc_ctrl_ops, 0);
>>   	if (ret)
>>   		goto out_cleanup_admin_q;
>>   
>
> So how do you solve this with rdma and tcp ??? I'm not sure I like 
> deviating from them.? Did it pick up the fc-nvme and fabric modules too ?

All fabrics drivers currently use the passed in 'fake' fabrics device.
