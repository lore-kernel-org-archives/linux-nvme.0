From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 22 Oct 2017 14:11:47 +0300
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl setup/teardown
 symmetric
In-Reply-To: <0a081ffc-5a3d-6b52-7257-18e39034ce93@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-2-git-send-email-sagi@grimberg.me>
 <20171019152910.GA24808@lst.de>
 <0a081ffc-5a3d-6b52-7257-18e39034ce93@grimberg.me>
Message-ID: <d1e113b8-1f76-1084-b075-a32d484287d8@grimberg.me>


>>> From: Roy Shterman <roys at lightbitslabs.com>
>>>
>>> Its strange to have some of the cleanup for nvme_init_ctrl in
>>> nvme_free_ctrl. This cause us to have some magic ctrl refcount
>>> handling in controller initialization error paths.
>>>
>>> Make the init/uninit symmetric so we can have a sane and
>>> maintainable error sequences.
>>
>> This totally conflicts with my refcount / device rework in the
>> mpath patchset..
> 
> I know...
> 
> Do you want me to rebase on top of your next round of patches?

ping?
