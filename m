From: steve.blightman@oracle.com (Steve Blightman)
Date: Fri, 8 Mar 2019 08:46:04 -0800
Subject: nvme-tcp: SUCCESS Flag in C2HData PDU
In-Reply-To: <5db9fdb7-bbbe-f805-94b6-fa5c2f31e9a8@grimberg.me>
References: <005ac848-0c71-8852-ff60-7e91418f83cc@oracle.com>
 <5db9fdb7-bbbe-f805-94b6-fa5c2f31e9a8@grimberg.me>
Message-ID: <cad669f2-028c-a4fe-0b9d-cd7ad479b6fb@oracle.com>

Thanks Sagi,
I understand use of the SUCCESS flag is optional for a target, but I 
think the Spec should either state that support for a host is mandatory, 
or, I think better, there should be a flag in the Connect Initialize PDU 
(IcReq) that indicates whether the host supports it or not.? Otherwise 
implementing it in a target may be problematic.


On 3/7/2019 5:06 PM, Sagi Grimberg wrote:
> Hi Steve,
>
>> Do the Linux nvme-tcp host & target implemetations support the use of 
>> the SUCCESS Flag in the C2HData PDU?
>
> Currently this optimization is not used by the target and not expected
> by the host (although it should be very easy to support).
>
>> I could not find any reference to it in the code,? even though TP 
>> 8000 doesn't seem to suggest it's optional.? Am I missing something?
>
> It is optional, the target may set the success flag. The host needs to
> be able to support it though. So it should be fairly simple to add.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
