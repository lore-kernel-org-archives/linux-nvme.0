From: james.smart@broadcom.com (James Smart)
Date: Fri, 16 Jun 2017 09:41:09 -0700
Subject: [PATCH] nvme_fc: Fix crash when nvme controller connection fails.
In-Reply-To: <20170616094352.GA23760@infradead.org>
References: <20170616064054.20758-1-jsmart2021@gmail.com>
 <20170616094352.GA23760@infradead.org>
Message-ID: <595ea418-61d9-f5ee-d6c8-01b7dacc3662@broadcom.com>

On 6/16/2017 2:43 AM, Christoph Hellwig wrote:
> On Thu, Jun 15, 2017@11:40:54PM -0700, James Smart wrote:
>> If a controller connection is attempted (say to a subsystem that
>> does not exist), the first attempt errors out.  If another connect
>> is attempted, it crashes.
>>
>> Issue is the prior controller has yet execute it's final put, thus
>> its still on lists. However, opts points on it have been cleared, thus
>> causing the crash if they are referenced.
>>
>> Fix is to add the missing put after the nvme_uninit_ctrl() call on
>> the attachment failure.
>>
>> Signed-off-by: Paul Ely <Paul.Ely at broadcom.com>
>> Signed-off-by: James Smart <james.smart at broadcom.com>
>> ---
>>   drivers/nvme/host/fc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 5165007e86a6..9700b45a3929 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2769,6 +2769,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>>   		nvme_uninit_ctrl(&ctrl->ctrl);
>>   		nvme_put_ctrl(&ctrl->ctrl);
>>   
>> +		/* Remove core ctrl ref. */
>> +		nvme_put_ctrl(&ctrl->ctrl);
> So where is the additional reference vs the other transport drivers
> coming from?
The different transports differ in their create/create 
association/delete association flows.  This was a bug specific to 
nvme_fc's implementation - on a teardown on failure, called 
nvme_uninit_ctrl but didn't remove the final reference so the nvme 
controller goes away, with allows the nvme_fc controller to go away.

-- james
