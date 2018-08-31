From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 31 Aug 2018 09:41:51 -0600
Subject: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
In-Reply-To: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-14-logang@deltatee.com>
 <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
Message-ID: <ee3d5c87-4dff-edfb-1f85-958571cb1fef@deltatee.com>

Thanks, for the review.

On 30/08/18 06:25 PM, Sagi Grimberg wrote:
>> +	if (req->port->p2p_dev) {
>> +		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
>> +						&ctrl->p2p_clients)) {
>> +			pr_info("peer-to-peer memory on %s is not supported\n",
>> +				pci_name(req->port->p2p_dev));
>> +			goto free_devices;
>> +		}
>> +		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
>> +	} else {
> 
> When is port->p2p_dev == NULL? a little more documentation would help 
> here...

In the configfs functions, if the user enables p2p (port->use_p2pmem)
using 'auto' or 'y' then port->p2p_dev will be NULL. If the user sets a
specific p2p_dev to use, port->p2p_dev will be set to that device. I can
add a couple comments in the next version.

Logan
