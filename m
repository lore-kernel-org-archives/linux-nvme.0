From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 25 Jun 2019 14:18:18 -0700
Subject: [PATCH v2] nvme-fc: clean up error messages
In-Reply-To: <4787a63a-186f-124b-ea7a-f3eaf13136f3@broadcom.com>
References: <20190624221240.25268-1-emilne@redhat.com>
 <14240398-683c-1d1c-f6e8-8fa8692270c2@broadcom.com>
 <c1d4377628740d182e16313b444b28ea6a2b8c1d.camel@redhat.com>
 <4787a63a-186f-124b-ea7a-f3eaf13136f3@broadcom.com>
Message-ID: <bfa94e77-0154-2f5d-52de-31754550a056@grimberg.me>


>> commit 5e77d61cbc7e766778037127dab69e6410a8fc48
>> Author: Sagi Grimberg<sagi at grimberg.me>
>> Date:?? Tue Jun 19 15:34:13 2018 +0300
>>
>> ???? nvme-rdma: don't override opts->queue_size
>>
>> So should FC be using the same logic?
> 
> not sure - I'll have to look why Sagi reverted it.

I reverted it because its a user parameter which we should
try to avoid modifying.

And maxcmd or other limits can theoretically change over resets.
