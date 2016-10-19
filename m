From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 19 Oct 2016 10:08:54 -0700
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <20161019104102.GD1191@lst.de>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
 <20161019104102.GD1191@lst.de>
Message-ID: <5e0ef37c-6411-95fd-606c-aae76c18a1e5@sandisk.com>

On 10/19/2016 03:41 AM, Christoph Hellwig wrote:
>>  {
>> +	char reason[32];
>>
>> +	switch (ev->status) {
>> +	case IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID:
>> +		strlcpy(reason, "duplicate local comm id", sizeof(reason));
>> +		break;
>> +	case IB_CM_REJ_CONSUMER_DEFINED:
>> +		if (ev->param.conn.private_data_len) {
>> +			const struct nvme_rdma_cm_rej *rej =
>> +				(const void *)ev->param.conn.private_data;
>
> What's the point of this void pointer cast?

Hello Christoph,

That cast is not necessary according to the C language standard. I will 
remove it.

Bart.
