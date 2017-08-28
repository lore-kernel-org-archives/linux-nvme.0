From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Aug 2017 08:23:11 +0200
Subject: [PATCH 05/10] nvme: don't blindly overwrite identifiers on
 disk revalidate
In-Reply-To: <e62a9b05-a02a-1846-6339-84c13248c9ce@grimberg.me>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-6-hch@lst.de>
 <e62a9b05-a02a-1846-6339-84c13248c9ce@grimberg.me>
Message-ID: <20170828062311.GB913@lst.de>

On Mon, Aug 28, 2017@09:17:44AM +0300, Sagi Grimberg wrote:
>> +	u8 eui64[8] = { 0 }, nguid[16] = { 0 };
>> +	uuid_t uuid = uuid_null;
>>   	int ret = 0;
>>     	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
>> @@ -1252,7 +1254,15 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>>   		goto out;
>>   	}
>>   -	nvme_report_ns_ids(ctrl, ns->ns_id, id, ns->eui, ns->nguid, 
>> &ns->uuid);
>> +	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
>> +	if (!uuid_equal(&ns->uuid, &uuid) ||
>> +	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
>> +	    memcmp(&ns->eui, &eui64, sizeof(ns->eui))) {
>
> Shouldn't uuid,nguid,eui64 record the previous values prior to calling
> nvme_report_ns_ids?

The previous values are still in the namespace structure, and we use
the on-stack variables for the current ones.
