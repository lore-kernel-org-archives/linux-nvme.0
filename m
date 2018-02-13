From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 13 Feb 2018 20:01:08 +0200
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING
In-Reply-To: <d6e78772-5345-3a03-b376-5656bfebe606@grimberg.me>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-2-git-send-email-maxg@mellanox.com>
 <d8241724-ef3a-4946-4629-3598413ca836@grimberg.me>
 <c896305c-90d0-e4aa-d861-ea9ad0076161@grimberg.me>
 <7a611bf2-8a70-1b11-0616-f79531a2cc3d@mellanox.com>
 <d6e78772-5345-3a03-b376-5656bfebe606@grimberg.me>
Message-ID: <956a48a6-cec1-7c3a-8cbb-a8b8ae4e8cb7@mellanox.com>



On 2/13/2018 12:46 PM, Sagi Grimberg wrote:
>>> Max, I fixed it up locally in nvme-4.16-rc, please verify that its
>>> correct and passes your local tests.
>>
>> Sagi,
>> I guess you applied it after rebasing, I've mentioned that there was 
>> still 1 commit missing in nvme-4.16 (your reset fix).
> 
> Which one?

I guess this one caused the conflict:
d5bf4b7f4 nvme-rdma: fix concurrent reset and reconnect
> 
>> I'll run tests on nvme-4.16-rc and update soon.
> 
> Thanks


During port toggle with traffic (using dm-multipath) I see some warnings 
during ib_destroy_qp that say there are still mrs_used.
and therefore also warning in ib_dealloc_pd that says refcount on pd is 
not 0.

I'll debug it tomorrow hopefully and update.

-Max.
