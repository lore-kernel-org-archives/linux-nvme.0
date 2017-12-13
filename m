From: james.smart@broadcom.com (James Smart)
Date: Wed, 13 Dec 2017 09:40:36 -0800
Subject: [PATCH] Revert "nvme: allow controller RESETTING to RECONNECTING
 transition"
In-Reply-To: <241b0327-2be9-8767-1722-03531c1e7c94@mellanox.com>
References: <20171207143450.7005-1-nitzanc@mellanox.com>
 <3af89c7d-5faa-b0ea-9ab3-4531599b24d4@grimberg.me>
 <241b0327-2be9-8767-1722-03531c1e7c94@mellanox.com>
Message-ID: <6b80c6ae-0751-accc-18dc-5e9f1578b1fd@broadcom.com>

On 12/13/2017 8:21 AM, Max Gurtovoy wrote:
>
>
> On 12/7/2017 5:30 PM, Sagi Grimberg wrote:
>> This breaks fc so NAK...
>
> Are we sure that this is correct transition, regardless if it 
> fixes/break a specific transport ?

Yes.?? I've had many long discussions on the topic with Christoph, Sagi, 
and Keith.

-- james


>
>>
>> You need to fix rdma to make sure reconnect and err works
>> are flushed before moving forward (I think it does but might
>> need to move earlier.
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C7750cec786ce4626261b08d53d879019%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636482574807097969&sdata=fHZd2t69xyqsg3lua9im3FKxOIMZ1BJUSuIina2m6TE%3D&reserved=0 
>>
