From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 18:29:40 +0300
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl setup/teardown
 symmetric
In-Reply-To: <20171018150859.GD32530@localhost.localdomain>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-2-git-send-email-sagi@grimberg.me>
 <20171018150859.GD32530@localhost.localdomain>
Message-ID: <4627b34e-449a-cd93-ac70-a628d558cac3@grimberg.me>


>> From: Roy Shterman <roys at lightbitslabs.com>
>>
>> Its strange to have some of the cleanup for nvme_init_ctrl in
>> nvme_free_ctrl. This cause us to have some magic ctrl refcount
>> handling in controller initialization error paths.
>>
>> Make the init/uninit symmetric so we can have a sane and
>> maintainable error sequences.
> 
> It's not magic. It's just preventing name reuse when some management
> code retains an open handle after the device was removed.

management code as in nvme-cli?

> Otherwise
> you're going to get naming clashes when you bring up a new device with
> the same name from reusing the still in-use instance.

Can userspace keep an open-handle after device_destroy() was invoked?

Can you explain how would I see naming clashes? I'm not sure I
understand what you are referring to.
