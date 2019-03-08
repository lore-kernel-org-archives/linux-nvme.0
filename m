From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 8 Mar 2019 15:04:15 -0800
Subject: nvme-tcp: SUCCESS Flag in C2HData PDU
In-Reply-To: <5e7839a9-f3ba-31b5-29cf-cb9662e06991@cisco.com>
References: <005ac848-0c71-8852-ff60-7e91418f83cc@oracle.com>
 <5db9fdb7-bbbe-f805-94b6-fa5c2f31e9a8@grimberg.me>
 <cad669f2-028c-a4fe-0b9d-cd7ad479b6fb@oracle.com>
 <5e7839a9-f3ba-31b5-29cf-cb9662e06991@cisco.com>
Message-ID: <92a0c822-bb8c-5bd5-e9c9-f76471c3de3b@grimberg.me>

Hi Oliver,

> Sagi - is the following patch in the right direction? If it is,
> I will write some controller code to test it and send an actual
> patch email. I just wanted to get your feedback before continuing
> down this path. Do we need to submit an actual CQE to the NVMe
> layer, or does just the nvme_end_request suffice? My understanding
> is the below patch handles both the case of data digest and not
> data digest, but please let me know if I am missing something. So far
> this patch is untested, but it does compile on the nvme-5.1 branch.

The below is in the right direction indeed, its actually pretty similar
to what I did, but your version seems slightly more elegant.

Thanks for looking at it, I have it implemented on both the host and the
controller, would be great to have a tester for it?
