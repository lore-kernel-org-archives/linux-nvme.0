From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Sep 2017 08:36:15 +0300
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <82f50ba2-a9c6-256f-5fd3-f515592c4fa7@huawei.com>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
 <82f50ba2-a9c6-256f-5fd3-f515592c4fa7@huawei.com>
Message-ID: <1fbc20f0-2838-049f-eb9c-de726339d597@grimberg.me>


>>> Notify sysfs about changes of a nvme controller so user-space can watch the
>>> file via poll() or select() in order to react to a state change.
>>
>> Userspace has no business polling for the state.
>>
> 
> Please consider this patch. At least upstream multipath-tools is using the sysfs state now:
> [1] https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=commitdiff;h=29c3b0446c4d919859f9e87b291563d483aab594
> [2] https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=commitdiff;h=d2561442cc0b444e8a728bac2c1466468816ee9d

I have to agree with Christoph that we need to be able to keep the
controller states internal as they are bound to change at any point.

We do need to move into debugfs to avoid the confusion...
