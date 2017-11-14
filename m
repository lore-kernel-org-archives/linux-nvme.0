From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 14 Nov 2017 11:10:19 +0200
Subject: [PATCH 4/4] nvmet: Add feature close connection from target side
In-Reply-To: <6279e907-06df-34dc-ab63-9c4b9ed94f6b@grimberg.me>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
 <1510576183-17215-5-git-send-email-israelr@mellanox.com>
 <6279e907-06df-34dc-ab63-9c4b9ed94f6b@grimberg.me>
Message-ID: <ca29c79a-0737-4e90-f2c4-d22d0f054547@mellanox.com>

Hi Sagi,

On 11/13/2017 10:21 PM, Sagi Grimberg wrote:
> Hi Israel,
>
>> This allows the user to close any connection from target side
>> by writing to the file "force_close" at the controller folder.
>> Full path:
>> /config/nvmet/subsystems/<SUBSYSTEM_NAME>/controllers/<CTRL_ID>/force_close 
>>
>>
>> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
>> ---
>>   drivers/nvme/target/configfs.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 2413df6..90e5925 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -496,10 +496,23 @@ static ssize_t nvmet_ctrl_trsvcid_show(struct 
>> config_item *item, char *page)
>>     CONFIGFS_ATTR_RO(nvmet_ctrl_, trsvcid);
>>   +static ssize_t nvmet_ctrl_force_close_store(struct config_item *item,
>> +        const char *page, size_t count)
>
> Maybe simply 'delete' is a better attribute name?
You probably right.
>
>> +{
>> +    struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
>> +
>> +    ctrl->ops->delete_ctrl(ctrl);
>> +
>
> What guarantees that calling delete_ctrl is safe here? Controllers can
> be freed under various conditions (client disconnect, fatal_error,
> device removal). What protects from user initiated force_close hitting
> a use-after-free condition?

The fact that I call nvmet_ctrl_configfs_del() at nvmet_ctrl_free() 
before freeing the controller guarantees
that the user will not see the controller at the filesystem after this 
point.
The second thing is that configfs_unregister_group() should wait for all 
the user calls on the controller to finish.
I don't see a difference between nvmet_ctrl_trsvcid_show() and 
nvmet_ctrl_force_close_store() (both are synchronous functions).

Regarding the races that you mentioned with client disconnect, 
fatal_error ...
__nvmet_rdma_queue_disconnect() is protected with a state lock.
