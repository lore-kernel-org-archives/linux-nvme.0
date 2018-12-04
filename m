From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 4 Dec 2018 12:10:32 +0200
Subject: [PATCH 1/2] nvmet-rdma: Fix response use after free
In-Reply-To: <97bc61b4-d5b7-6dc9-668e-a3900a08f993@grimberg.me>
References: <1543852205-776-1-git-send-email-israelr@mellanox.com>
 <97bc61b4-d5b7-6dc9-668e-a3900a08f993@grimberg.me>
Message-ID: <3b123a7f-5655-91f5-d1d8-fec5fe18d36a@mellanox.com>


On 12/4/2018 3:23 AM, Sagi Grimberg wrote:
>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 3f7971d3..732806a 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -529,6 +529,7 @@ static void nvmet_rdma_send_done(struct ib_cq 
>> *cq, struct ib_wc *wc)
>> ? {
>> ????? struct nvmet_rdma_rsp *rsp =
>> ????????? container_of(wc->wr_cqe, struct nvmet_rdma_rsp, send_cqe);
>> +??? struct nvmet_rdma_queue *queue = rsp->queue;
>
> Didn't you mean:
> +??? struct nvmet_rdma_queue *queue = cq->cq_context;
>
> I'm not sure what this is solving otherwise...

it doesn't matter where you take the queue pointer from.

the important thing is to take it before you run 
nvmet_rdma_release_rsp(rsp) because after your commit that allocate the 
rsp dynamically

you free it too:

if (rsp->allocated) {
 ??????????????? kfree(rsp);
 ??????????????? return;
 ??????? }

so you might get use after free ... (nvmet_rdma_error_comp(rsp->queue); )


>
>> ? ????? nvmet_rdma_release_rsp(rsp);
>> ? @@ -536,7 +537,7 @@ static void nvmet_rdma_send_done(struct ib_cq 
>> *cq, struct ib_wc *wc)
>> ?????????????? wc->status != IB_WC_WR_FLUSH_ERR)) {
>> ????????? pr_err("SEND for CQE 0x%p failed with status %s (%d).\n",
>> ????????????? wc->wr_cqe, ib_wc_status_msg(wc->status), wc->status);
>> -??????? nvmet_rdma_error_comp(rsp->queue);
>> +??????? nvmet_rdma_error_comp(queue);
>> ????? }
>> ? }
>>
