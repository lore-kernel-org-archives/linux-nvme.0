From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 21 Jan 2019 01:12:37 -0800
Subject: [PATCH] nvme-tcp: fix timeout handler
In-Reply-To: <20190119133646.GC24763@lst.de>
References: <20190108090942.11752-1-sagi@grimberg.me>
 <20190119133646.GC24763@lst.de>
Message-ID: <55f42675-d53c-3165-d174-842e7d8d4af7@grimberg.me>


>> +		/*
>> +		 * teardown immediately if controller times out while starting
>> +		 * or we are already started error recovery. all outstanding
>> +		 * requests are completed on shutdown, so we return BLK_EH_DONE.
>> +		 */
> 
> Same grammar nitpick as for rdma.
> 
> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Applied to nvme-5.0 with the comment fix. Thanks!
