From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 30 Mar 2017 08:47:49 +0300
Subject: [PATCH 1/1] nvme: don't ignore tagset allocation failures
In-Reply-To: <20170329231029.GE20181@localhost.localdomain>
References: <1490778212-11007-1-git-send-email-maxg@mellanox.com>
 <a7db55a8-d40a-81e9-332e-2bd0306687bc@grimberg.me>
 <20170329173241.GC20181@localhost.localdomain>
 <fb263c4e-0403-c39c-1c88-be47d846c2b6@grimberg.me>
 <20170329231029.GE20181@localhost.localdomain>
Message-ID: <0d85bb44-eb90-8712-1fcd-2f0885649cdf@grimberg.me>


>>> Not having a tagset doesn't mean we can't go live; it just means we can't
>>> do IO, but the admin handle is still up for device management.
>>
>> So don't queue ns scanning...
>
> And what about the sysfs rescan or namespace notify async event? We have
> to fence those off too, so doing it in one place sounds better than
> three.

True, but it still feels wrong that the pci driver fails tagset
allocation and continues to scan namespaces as if nothing happened, then
queue namespaces checks for the existence of a tagset... It looks awkward...

Why is the controller moving to LIVE anyway? Obviously something went
wrong, which is either a SW BUG (EINVAL), or a temporary failure that
needs to be retried again (ENOMEM). So I think the proper solution would
be to either retry again later for transient errors and for
non-transient errors simply log the error remove the controller (its
not a device issue so no point in keeping the controller around for
error log query).

Thoughts?
