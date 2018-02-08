From: thomas.tai@oracle.com (Thomas Tai)
Date: Thu, 8 Feb 2018 11:03:10 -0500
Subject: [PATCH v3 2/2] Documentation: nvme: Documentation for nvme fault
 injection
In-Reply-To: <75fba2c9-3fb6-0cf8-fcf4-7738bd7c6147@grimberg.me>
References: <1517526659-3450-1-git-send-email-thomas.tai@oracle.com>
 <1517526659-3450-3-git-send-email-thomas.tai@oracle.com>
 <75fba2c9-3fb6-0cf8-fcf4-7738bd7c6147@grimberg.me>
Message-ID: <600bfddd-448c-bedd-ba6c-a3e925137ee8@oracle.com>



On 2018-02-08 10:42 AM, Sagi Grimberg wrote:
> 
>> +o NVMe fault injection
>> +
>> +? inject NVMe NVME_SC_INVALID_OPCODE with no retry on devices permitted
>> +? by setting debugfs entries under /sys/kernel/debug/nvme*/fault_inject
>> +
> 
> Actually, can you update the documentation entry here?

Yes Sagi. I will submit the documentation to the fault injection 
maintainer. Thank you for your help.

Thomas

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
