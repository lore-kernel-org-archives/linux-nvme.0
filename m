From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Nov 2018 08:30:26 -0800
Subject: [PATCH v2 2/4] nvmet: don't override treq upon modification.
In-Reply-To: <20181114142032.GB27204@infradead.org>
References: <20181003081323.7504-1-sagi@grimberg.me>
 <20181003081323.7504-3-sagi@grimberg.me>
 <20181114142032.GB27204@infradead.org>
Message-ID: <190e7b5e-f565-2152-6c96-e9ae36350773@grimberg.me>


>> ---
>>   drivers/nvme/target/configfs.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index b37a8e3e3f80..53b88858ee97 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -148,7 +148,7 @@ CONFIGFS_ATTR(nvmet_, addr_traddr);
>>   static ssize_t nvmet_addr_treq_show(struct config_item *item,
>>   		char *page)
>>   {
>> -	switch (to_nvmet_port(item)->disc_addr.treq) {
>> +	switch (to_nvmet_port(item)->disc_addr.treq & 0x3) {
>>   	case NVMF_TREQ_NOT_SPECIFIED:
>>   		return sprintf(page, "not specified\n");
>>   	case NVMF_TREQ_REQUIRED:
>> @@ -164,6 +164,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>>   		const char *page, size_t count)
>>   {
>>   	struct nvmet_port *port = to_nvmet_port(item);
>> +	u8 treq = port->disc_addr.treq & 0xfc;
> 
> I think this wants a named constant instead of a magic value.

its a mask that only used here and pretty clear in my mind that
takes only the upper bits, but I can change that.
