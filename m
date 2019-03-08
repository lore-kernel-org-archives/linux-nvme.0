From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Mar 2019 17:06:07 -0800
Subject: nvme-tcp: SUCCESS Flag in C2HData PDU
In-Reply-To: <005ac848-0c71-8852-ff60-7e91418f83cc@oracle.com>
References: <005ac848-0c71-8852-ff60-7e91418f83cc@oracle.com>
Message-ID: <5db9fdb7-bbbe-f805-94b6-fa5c2f31e9a8@grimberg.me>

Hi Steve,

> Do the Linux nvme-tcp host & target implemetations support the use of 
> the SUCCESS Flag in the C2HData PDU?

Currently this optimization is not used by the target and not expected
by the host (although it should be very easy to support).

> I could not find any reference to 
> it in the code,? even though TP 8000 doesn't seem to suggest it's 
> optional.? Am I missing something?

It is optional, the target may set the success flag. The host needs to
be able to support it though. So it should be fairly simple to add.
