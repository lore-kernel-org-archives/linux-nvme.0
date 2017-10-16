From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Oct 2017 13:21:36 +0300
Subject: nvmeof rdma regression issue on 4.14.0-rc1 (or maybe mlx4?)
In-Reply-To: <ff355fcf-5089-f297-d3fa-9b86d133236b@redhat.com>
References: <1735134433.8514119.1505997532669.JavaMail.zimbra@redhat.com>
 <1215229914.8516804.1505998051674.JavaMail.zimbra@redhat.com>
 <20170921144421.GA15285@infradead.org>
 <47493aa0-4cad-721b-4ea2-c3b2293340aa@grimberg.me>
 <e8aa9f2e-14b1-23f0-f672-07a913842c9d@redhat.com>
 <20170924103426.GB25094@mtr-leonro.local>
 <4d0e27f2-99e4-ffc7-18a5-e5757c27dad4@redhat.com>
 <4faccebf-7fcf-58b9-1605-82ee9acc652b@grimberg.me>
 <e44f4640-44b2-4692-ca57-08f9ebf4da2c@redhat.com>
 <729c512f-55ff-25e4-6dd9-8b4dcc31bb8d@grimberg.me>
 <ff355fcf-5089-f297-d3fa-9b86d133236b@redhat.com>
Message-ID: <6d639dd4-9366-2ecf-b49e-751c7a167528@grimberg.me>

>> Lets take this one step at a time, starting with this issue.
>>
>> First, there is a reason why a simple create_ctrl fails, can we isolate
>> exactly which call fails? Was something else going on that might have
>> made the simple create_ctrl fail?
>>
>> We don't see any "rdma_resolve_addr failed" or "failed to connect queue"
>> messages but we do see "creating I/O queues" which means that we either
>> failed at IO tagset allocation or initializing connect_q.
>>
>> We have a missing error code assignment so can you try the following 
>> patch:
> 
> Hi Sagi
> Sorry for the late response, here is the log with your patch, let me 
> know if you need more test.

Hi Yi,

I was referring to the bug you reported on a simple create_ctrl failed:
https://pastebin.com/7z0XSGSd

Does it reproduce?
