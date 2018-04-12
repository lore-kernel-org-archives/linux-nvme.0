From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 12 Apr 2018 19:43:02 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <ae1e1064-5c62-3ceb-dd4d-ff14e911df5c@grimberg.me>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>
 <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
 <1c36f016-5b58-038f-8938-cd9deb15a205@grimberg.me>
 <ed15449d-8991-2bcd-a381-54727eaef241@mellanox.com>
 <3ee4b1a9-0b00-f7df-5198-a9f893e5a6af@broadcom.com>
 <ad4fc7df-f53c-0c38-dd12-eb235056a0d8@grimberg.me>
 <ee210857-fc8c-cf1a-eca1-32f58e8cab2e@mellanox.com>
 <ae1e1064-5c62-3ceb-dd4d-ff14e911df5c@grimberg.me>
Message-ID: <fd11876d-6adf-8326-b223-124e29e67b59@mellanox.com>



On 4/12/2018 6:17 PM, Sagi Grimberg wrote:
> 
>>> This together with moving the keep alive timer start in nvme_enable_ctrl
>>> should be enough and not propagating the handle to every transport
>>> driver, we have enough of that already.
>>
>> Great, this is what I wanted to do in the first place but I was 
>> concerned about stopping the keep-alive in nvme_disable_ctrl.
>> Are you sending a new series or I will ?
> 
> I can send it. Given that its your report and your intention in the
> first place, can I place you as the author of these?

Yes. I've also run my test on it successfuly.
I'll run some more tests using RDMA transport and update if there are 
some issues.
