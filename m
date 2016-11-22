From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 22 Nov 2016 16:00:07 +0200
Subject: [PATCH 1/2] nvmet-rdma: align to generic ib_event logging helper
In-Reply-To: <20161122074110.GA5497@infradead.org>
References: <1479761145-13264-1-git-send-email-maxg@mellanox.com>
 <20161122074110.GA5497@infradead.org>
Message-ID: <b187a6e8-82f7-4a0f-f46e-7e4410ffc1f1@mellanox.com>



On 11/22/2016 9:41 AM, Christoph Hellwig wrote:
> On Mon, Nov 21, 2016@10:45:44PM +0200, Max Gurtovoy wrote:
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
>> ---
>>  drivers/nvme/target/rdma.c |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 005ef5d..80650e2 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -1124,12 +1124,14 @@ static void nvmet_rdma_qp_event(struct ib_event *event, void *priv)
>>  {
>>  	struct nvmet_rdma_queue *queue = priv;
>>
>> +	pr_err("received IB QP event: %s (%d)\n",
>> +	       ib_event_msg(event->event), event->event);
>> +
>>  	switch (event->event) {
>>  	case IB_EVENT_COMM_EST:
>>  		rdma_notify(queue->cm_id, event->event);
>>  		break;
>>  	default:
>> -		pr_err("received unrecognized IB QP event %d\n", event->event);
>>  		break;
>
> This will print an error message every time a connection is established.
> Either tune it down to pr_debug or keep it inside the default case.

I haven't seen this event message on connection establishment and this 
is the debug level we use in iser/isert parrallel function.
But I'll tune it to pr_debug if needed, no problem.
