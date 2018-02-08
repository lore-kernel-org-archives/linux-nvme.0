From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Feb 2018 18:05:27 +0200
Subject: [PATCH v3 2/2] Documentation: nvme: Documentation for nvme fault
 injection
In-Reply-To: <600bfddd-448c-bedd-ba6c-a3e925137ee8@oracle.com>
References: <1517526659-3450-1-git-send-email-thomas.tai@oracle.com>
 <1517526659-3450-3-git-send-email-thomas.tai@oracle.com>
 <75fba2c9-3fb6-0cf8-fcf4-7738bd7c6147@grimberg.me>
 <600bfddd-448c-bedd-ba6c-a3e925137ee8@oracle.com>
Message-ID: <cf7ed6dd-05b2-32fe-451a-e32f0ac810fa@grimberg.me>


>>> +o NVMe fault injection
>>> +
>>> +? inject NVMe NVME_SC_INVALID_OPCODE with no retry on devices permitted
>>> +? by setting debugfs entries under /sys/kernel/debug/nvme*/fault_inject
>>> +
>>
>> Actually, can you update the documentation entry here?
> 
> Yes Sagi. I will submit the documentation to the fault injection 
> maintainer. Thank you for your help.

It's going to 4.17 (we have time), so I'd prefer to get it right once
instead of having another fixup on top. Would it be possible to re-spin
with the minor fix?
