From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 13:21:58 -0800
Subject: [PATCH 05/11] nvmet: Add install_queue callout
In-Reply-To: <af370da9-3d56-e1a8-27db-c0a8e9291417@mellanox.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-6-sagi@lightbitslabs.com>
 <af370da9-3d56-e1a8-27db-c0a8e9291417@mellanox.com>
Message-ID: <98230184-074a-84cf-3aa5-8ad30f2b5339@grimberg.me>


>> diff --git a/drivers/nvme/target/fabrics-cmd.c 
>> b/drivers/nvme/target/fabrics-cmd.c
>> index 1f05d8507e35..a84668e8939c 100644
>> --- a/drivers/nvme/target/fabrics-cmd.c
>> +++ b/drivers/nvme/target/fabrics-cmd.c
>> @@ -117,6 +117,15 @@ static u16 nvmet_install_queue(struct nvmet_ctrl 
>> *ctrl, struct nvmet_req *req)
>> ????? nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1,
>> ????????????? !!(c->cattr & NVME_CONNECT_DISABLE_SQFLOW));
> 
> what is your code base ? does SQFLOW must for TCP ?

Not really, just happens to sit on top..

>> +??? if (ctrl->ops->install_queue) {
>> +??????? int ret = ctrl->ops->install_queue(req->sq);
>> +??????? if (ret) {
>> +??????????? pr_err("failed to install queue %d cntlid %d ret %d\n",
>> +??????????????? qid, ret, ctrl->cntlid);
>> +??????????? return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
> 
> I'm not sure regarding the INVALID_PARAM rc.
> 
> maybe use NVME_SC_INTERNAL ?

You're right, perhaps we should propagate ->install_queue() status.
