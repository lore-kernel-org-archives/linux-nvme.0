From: lijie34@huawei.com (lijie (AC))
Date: Wed, 31 Oct 2018 14:44:03 +0800
Subject: [PATCH] adjust serial number form u64 to u8[20]
In-Reply-To: <ca5606a7-2320-637d-d6f0-53b515dd2785@grimberg.me>
References: <1540810606-17252-1-git-send-email-lijie34@huawei.com>
 <739c3b0a-25e5-bcdb-0589-a95d33ea3958@grimberg.me>
 <d244b7d7-8880-4dac-ca07-b45bf91b69e9@huawei.com>
 <ca5606a7-2320-637d-d6f0-53b515dd2785@grimberg.me>
Message-ID: <5b5e1a0c-5b3c-fb5a-97b1-cf776943af34@huawei.com>



On 2018/10/31 12:56, Sagi Grimberg wrote:
> 
>>>> ?? ????? down_write(&nvmet_config_sem);
>>>> -??? sscanf(page, "%llx\n", &subsys->serial);
>>>> +??? memcpy_and_pad(subsys->sn, sizeof(subsys->sn), sn, strlen(sn), ' ');
>>>> ?????? up_write(&nvmet_config_sem);
>>>> ?? ????? return count;
>>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>>> index 0acdff9..6bc8860 100644
>>>> --- a/drivers/nvme/target/core.c
>>>> +++ b/drivers/nvme/target/core.c
>>>> @@ -1129,6 +1129,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>>> ?????????? enum nvme_subsys_type type)
>>>> ?? {
>>>> ?????? struct nvmet_subsys *subsys;
>>>> +??? u64??? serial;
>>>> ?? ????? subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>>>> ?????? if (!subsys)
>>>> @@ -1136,7 +1137,9 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>>> ?? ????? subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
>>>> ?????? /* generate a random serial number as our controllers are ephemeral: */
>>>> -??? get_random_bytes(&subsys->serial, sizeof(subsys->serial));
>>>> +??? get_random_bytes(&serial, sizeof(serial));
>>>> +??? memset(subsys->sn, ' ', sizeof(subsys->sn));
>>>> +??? bin2hex(subsys->sn, &serial, min(sizeof(serial), sizeof(subsys->sn) / 2));
>>>
>>> Why not simply get the random bytes directly to subsys->sn?
>>>
>>> ?????get_random_bytes(subsys->sn, sizeof(subsys->sn));
>> The get_random_bytes gets random numbers, possibly not ASCII strings, and it can't be displayed directly.
> 
> Why not keep it raw and when either displaying it or sending to the host
> convert with bin2hex?
> 
> .
> 
Hi sagi,

If the original value of SN has already met the ASCII string requirement?other places to use serial number can be directly used without conversion.It would be better.
In addition, if use bin2hex to convert when sending it to host, the original value input by nvmet_subsys_attr_serial_store will be different from the value of nvme list at the host side.
For example?

Target side?
linux-toyz:~ # echo 12345678901234567890 > /sys/kernel/config/nvmet/subsystems/fctest1/attr_serial
Host side?
[root at localhost nvme_scripts]# nvme list
Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme0n1     31323334353637383930 Linux                                    1          42.95  GB /  42.95  GB    512   B +  0 B   4.19.0-r

Thanks,
Lijie
