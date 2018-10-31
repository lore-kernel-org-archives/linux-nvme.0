From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 21:56:35 -0700
Subject: [PATCH] adjust serial number form u64 to u8[20]
In-Reply-To: <d244b7d7-8880-4dac-ca07-b45bf91b69e9@huawei.com>
References: <1540810606-17252-1-git-send-email-lijie34@huawei.com>
 <739c3b0a-25e5-bcdb-0589-a95d33ea3958@grimberg.me>
 <d244b7d7-8880-4dac-ca07-b45bf91b69e9@huawei.com>
Message-ID: <ca5606a7-2320-637d-d6f0-53b515dd2785@grimberg.me>


>>>  ? ????? down_write(&nvmet_config_sem);
>>> -??? sscanf(page, "%llx\n", &subsys->serial);
>>> +??? memcpy_and_pad(subsys->sn, sizeof(subsys->sn), sn, strlen(sn), ' ');
>>>  ????? up_write(&nvmet_config_sem);
>>>  ? ????? return count;
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index 0acdff9..6bc8860 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -1129,6 +1129,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>>  ????????? enum nvme_subsys_type type)
>>>  ? {
>>>  ????? struct nvmet_subsys *subsys;
>>> +??? u64??? serial;
>>>  ? ????? subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>>>  ????? if (!subsys)
>>> @@ -1136,7 +1137,9 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>>  ? ????? subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
>>>  ????? /* generate a random serial number as our controllers are ephemeral: */
>>> -??? get_random_bytes(&subsys->serial, sizeof(subsys->serial));
>>> +??? get_random_bytes(&serial, sizeof(serial));
>>> +??? memset(subsys->sn, ' ', sizeof(subsys->sn));
>>> +??? bin2hex(subsys->sn, &serial, min(sizeof(serial), sizeof(subsys->sn) / 2));
>>
>> Why not simply get the random bytes directly to subsys->sn?
>>
>>  ????get_random_bytes(subsys->sn, sizeof(subsys->sn));
> The get_random_bytes gets random numbers, possibly not ASCII strings, and it can't be displayed directly.

Why not keep it raw and when either displaying it or sending to the host
convert with bin2hex?
