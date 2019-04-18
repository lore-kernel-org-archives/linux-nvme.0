From: aaron.ma@canonical.com (Aaron Ma)
Date: Thu, 18 Apr 2019 14:24:58 +0800
Subject: [PATCH] nvme: determine the number of IO queues
In-Reply-To: <08ac5733-596b-598d-c821-f1aa2dc32650@gmail.com>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <08ac5733-596b-598d-c821-f1aa2dc32650@gmail.com>
Message-ID: <2024829f-4b8f-7f83-d861-da009cd75edb@canonical.com>

On 4/18/19 5:30 AM, Edmund Nadolski (Microsoft) wrote:
> On 4/17/19 7:12 AM, Aaron Ma wrote:
>> Some controllers support limited IO queues, when over set
>> the number, it will return invalid field error.
>> Then NVME will be removed by driver.
>>
>> Find the max number of IO queues that controller supports.
>> When it still got invalid result, set 1 IO queue at least to
>> bring NVME online.
>>
>> Signed-off-by: Aaron Ma <aaron.ma at canonical.com>
>> ---
>> ? drivers/nvme/host/core.c | 29 ++++++++++++++++++-----------
>> ? 1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 2c43e12b70af..fb7f05c310c8 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1134,14 +1134,24 @@ static int nvme_set_features(struct nvme_ctrl
>> *dev, unsigned fid, unsigned dword
>> ? ? int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>> ? {
>> -??? u32 q_count = (*count - 1) | ((*count - 1) << 16);
>> +??? u32 q_count;
>> ????? u32 result;
>> -??? int status, nr_io_queues;
>> -
>> -??? status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count,
>> NULL, 0,
>> -??????????? &result);
>> -??? if (status < 0)
>> -??????? return status;
>> +??? int status = -1;
>> +??? int nr_io_queues;
>> +??? int try_count;
>> +
>> +??? for (try_count = *count; try_count > 0; try_count--) {
>> +??????? q_count = (try_count - 1) | ((try_count - 1) << 16);
> 
> A macro here might help readability.

Will add in V2.

> 
>> +??????? status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES,
>> +??????????????? q_count, NULL, 0, &result);
>> +??????? if (status < 0)
>> +??????????? return status;
>> +??????? else if (status == 0) {
> 
> else following return is not needed.

 *      0: successful read
 *      > 0: NVMe error status code
 *      < 0: Linux errno error code

3 conditions should be taken care.
status > 0 will be handled after loop.

else is needed.

> 
> 
>> +??????????? nr_io_queues = min(result & 0xffff, result >> 16) + 1;
> 
> Likewise, a macro as above.

Will add in V2.

> 
> 
> Ed
> 
>> +??????????? *count = min(try_count, nr_io_queues);
>> +??????????? break;
>> +??????? }
>> +??? }
>> ? ????? /*
>> ?????? * Degraded controllers might return an error when setting the
>> queue
>> @@ -1150,10 +1160,7 @@ int nvme_set_queue_count(struct nvme_ctrl
>> *ctrl, int *count)
>> ?????? */
>> ????? if (status > 0) {
>> ????????? dev_err(ctrl->device, "Could not set queue count (%d)\n",
>> status);
>> -??????? *count = 0;
>> -??? } else {
>> -??????? nr_io_queues = min(result & 0xffff, result >> 16) + 1;
>> -??????? *count = min(*count, nr_io_queues);
>> +??????? *count = 1;
>> ????? }
>> ? ????? return 0;
>>
> 
