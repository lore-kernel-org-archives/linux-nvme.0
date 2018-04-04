From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 16:08:09 +0300
Subject: [PATCH rfc 3/3] nvmet: Add port transport active flag
In-Reply-To: <658c0e8d-cdc7-ab48-e4ad-c5ebdcbcbb11@mellanox.com>
References: <20180322190303.10951-1-sagi@grimberg.me>
 <20180322190303.10951-4-sagi@grimberg.me>
 <658c0e8d-cdc7-ab48-e4ad-c5ebdcbcbb11@mellanox.com>
Message-ID: <27bebeb1-75d7-9984-7b7b-e1389923a09a@grimberg.me>


> On 3/22/2018 9:03 PM, Sagi Grimberg wrote:
>> From: Israel Rukshin <israelr at mellanox.com>
>>
>> trstate port flag means that nvmet transport is active and ready for
> 
> *tractive
> 
> this is the configfs attribute name.

We should change it to trstate then...

>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index e6b2d2af81b6..460eeb0c5801 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -268,6 +268,15 @@ static ssize_t nvmet_addr_trtype_store(struct 
>> config_item *item,
>> ? CONFIGFS_ATTR(nvmet_, addr_trtype);
>> +static ssize_t nvmet_addr_tractive_show(struct config_item *item, 
>> char *page)
>> +{
>> +??? struct nvmet_port *port = to_nvmet_port(item);
>> +
>> +??? return sprintf(page, "%d\n", nvmet_is_port_active(port));
>> +}
>> +
>> +CONFIGFS_ATTR_RO(nvmet_, addr_tractive);
>> +
> 
> addr_ prefix is needed for nvmetcli. Since this is a RO attribute, I'm 
> not sure we need this prefix. I guess It will be saved in the config 
> file (nvmetcli save) with no reason. And "nvmetcli restore" will try to 
> echo 1 in to a RO attribute.

Agreed.
