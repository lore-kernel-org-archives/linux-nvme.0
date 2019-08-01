From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Jul 2019 18:08:53 -0700
Subject: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
In-Reply-To: <fbcd59ef-9c48-4e1a-4802-1cae33c5f671@grimberg.me>
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
 <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>
 <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
 <66ACE500178B47D6B39F23FE98D22363@alyakaslap>
 <b6443a7c-4be6-3dbc-0535-a8ded3261c50@mellanox.com>
 <8ab1fa5e-2d67-5128-93b5-2f32704869e4@grimberg.me>
 <28046c97-c271-dff4-5252-4b5668c7bfb7@grimberg.me>
 <B3E9005C4E4645628157970AE2A385C4@alyakaslap>
 <fbcd59ef-9c48-4e1a-4802-1cae33c5f671@grimberg.me>
Message-ID: <d7caa73f-b939-41f5-793a-c9b74880f246@grimberg.me>


>> Hi Sagi,
>>
>> Which kernel this patch applies to?
> 
> its based on the nvme tree, but it should apply cleanly on upstream
> 5.2...

Alex, Max? did you retest this?
