From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 09:41:05 -0700
Subject: [PATCH RFC 0/6] nvme: introduce a new flag NVME_ADMIN_QID
In-Reply-To: <SN6PR04MB4527FE451186EEFB3B700EB4862E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
 <20190410171215.GD3714@localhost.localdomain>
 <SN6PR04MB4527FE451186EEFB3B700EB4862E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <f8516356-658b-aaa1-2f34-ffb700ad59e6@grimberg.me>


>>> Hi, all
>>>
>>> This patchset introduces a new flag NVME_ADMIN_QID for admin queue.
>>> Now that, all drivers in host or target are use index '0' as admin
>>> queues. Thus, we can use a flag NVME_ADMIN_QID instead of using '0',
>>> which can make code more easy to read and understand.
>>>
>>> This patchset is RFC, and it just use NVME_ADMIN_QID for drivers in
>>> nvme host. I am not sure whether this patchset actually make sense.
>>> Any suggestion is welcome and thanks in advance.
>>
>> IMO, this makes it harder to read anything that's using the 0 index in a
>> loop.
>>
> Yes it does, how about using 0 in the loop and keeping the macro as it
> is in the rest of places ? or that is too confusing ?

Both are more confusing than what we already have IMO
