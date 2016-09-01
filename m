From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Sep 2016 10:36:09 +0200
Subject: [PATCH WIP/RFC v3 3/6] nvme_rdma: keep a ref on the ctrl
 during delete/flush
In-Reply-To: <c749145e-618e-ef0c-4249-8f441c55e4b1@grimberg.me>
References: <cover.1472574410.git.swise@opengridcomputing.com>
 <f3b74c6ef7caba2fdff194be0c90ec7423103893.1472574410.git.swise@opengridcomputing.com>
 <c749145e-618e-ef0c-4249-8f441c55e4b1@grimberg.me>
Message-ID: <20160901083609.GC3703@lst.de>

On Tue, Aug 30, 2016@08:24:50PM +0300, Sagi Grimberg wrote:
>
>> -	/* Queue controller deletion */
>> +	/*
>> +	 * Queue controller deletion. Keep a reference until all
>> +	 * work is flushed since delete_work will free the ctrl mem
>> +	 */
>> +	kref_get(&ctrl->ctrl.kref);
>
> kref_get_unless_zero?

How could the refcount be zero here?
