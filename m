From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 15 Feb 2017 14:38:20 +0200
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
 <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
Message-ID: <6f56f570-c0a9-0f8a-2459-ec49ea680364@mellanox.com>



On 2/15/2017 11:56 AM, Sagi Grimberg wrote:
>
>> @@ -595,6 +595,11 @@ static int connect_ctrl(struct
>> nvmf_disc_rsp_page_entry *e)
>>                  return -EINVAL;
>>              p += len;
>>
>> +            len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
>> +            if (len < 0)
>> +                return -EINVAL;
>> +            p+= len;
>> +
>
> I think this needs to be conditional on if provided at all.
>

Also, currently this is implemented for FC but I'll want to add an 
option for rdma too.
so we'll be able to use it like that:

nvme connect -t rdma -n testsubsystem -a <target_ip> -w <host_ip> -s 1023

in case we want to choose the interface for rdma_resolve_addr.
I'll put it on my plate.

Max.

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
