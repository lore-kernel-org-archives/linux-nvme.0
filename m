From: jalee@purestorage.com (Jaesoo Lee)
Date: Thu, 17 Jan 2019 18:19:45 -0800
Subject: [PATCH v2] nvme-rdma: fix timeout handler
In-Reply-To: <CAJX3CtgkGX_1eUU_x=v+VrUwvEA6ZwOgiPdps_-sPc5+JUFBqg@mail.gmail.com>
References: <20190108085734.9681-1-sagi@grimberg.me>
 <c5db3853-daf4-49c0-0cab-a2cb3298ed85@grimberg.me>
 <CAJX3CtgkGX_1eUU_x=v+VrUwvEA6ZwOgiPdps_-sPc5+JUFBqg@mail.gmail.com>
Message-ID: <CAJX3Ctit1Tquhd_g=u-EAJSgEk_g7P+7XoC_sf7LBq+xy7ztpQ@mail.gmail.com>

I have tested the code (backported to v4.19.9) and verified it works
for below two scenarios I had originally reported.

* Scenario 1
1. issued connect nvme-cli command for nvme-rdma target with 500 namespaces
2. after 3 seconds while the scan process is still going, issued
disconnect command

* Scenario 2
1. connected nvme-rdma target with 4 namespaces
2. ran IO traffic over the namespaces
3. changed MTU to 568 for the roce interface at the target

Thanks,

Jaesoo Lee.


On Wed, Jan 16, 2019@6:57 PM Jaesoo Lee <jalee@purestorage.com> wrote:
>
> Sure. I will test and post the results ASAP.
>
>
> On Wed, Jan 16, 2019, 5:27 PM Sagi Grimberg <sagi@grimberg.me wrote:
>>
>> Jaesoo, can you verify that this patch fixes the issue
>> you were seeing?
