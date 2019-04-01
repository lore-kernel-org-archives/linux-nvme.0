From: hare@suse.com (Hannes Reinecke)
Date: Mon, 1 Apr 2019 04:02:40 +0200
Subject: [PATCH 1/2] nvmet: make MDTS value configurable
In-Reply-To: <3bfa0c56-91d1-a722-df92-1ed4744f04ad@mellanox.com>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-2-hare@suse.de>
 <3bfa0c56-91d1-a722-df92-1ed4744f04ad@mellanox.com>
Message-ID: <9abfa47a-3374-a1a0-8370-1096d02743d0@suse.com>

On 3/31/19 5:04 PM, Max Gurtovoy wrote:
> 
> On 3/29/2019 3:04 PM, Hannes Reinecke wrote:
>> For testing the bio splitting algorithm it's useful to be able to
>> modify the mdts value.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>> ? drivers/nvme/target/admin-cmd.c |? 3 +--
>> ? drivers/nvme/target/configfs.c? | 27 +++++++++++++++++++++++++++
>> ? drivers/nvme/target/nvmet.h???? |? 2 ++
>> ? 3 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c 
>> b/drivers/nvme/target/admin-cmd.c
>> index 76250181fee0..1c4cb371fac8 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -311,8 +311,7 @@ static void nvmet_execute_identify_ctrl(struct 
>> nvmet_req *req)
>> ????? /* we support multiple ports, multiples hosts and ANA: */
>> ????? id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
>> -??? /* no limit on data transfer sizes for now */
>> -??? id->mdts = 0;
>> +??? id->mdts = ctrl->subsys->mdts;
> 
> I think it's more of a ctrl/nvmet_port configuration than a subsystem.
> 
> For example if you have 2 HCAs, one is super strong and can transfer 
> upto 8MB and the second is old model and can transfer upto 64KiB.
> 
> do
> 
> id->mdts = ctrl->ops->port_mdts(req->port);
> 
> and inside the implementation you can do
> 
> min_not_zero(max_port_hca_cap_in_mdts_units, mdts_configfs_val);
> 
> and it will fix the comment that is written above (we're not really 
> unlimited).
> 
> this way we're using the low level device characteristics and also cover 
> the bio split test.
> 
> thoughts ?
> 
> 
Yeah, true, it should be a port configuration.

I'll be updating the patch.

Cheers,

Hannes
