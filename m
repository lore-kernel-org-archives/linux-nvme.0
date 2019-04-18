From: aaron.ma@canonical.com (Aaron Ma)
Date: Thu, 18 Apr 2019 20:52:58 +0800
Subject: [PATCH] nvme: determine the number of IO queues
In-Reply-To: <99ab1942-9c38-695d-03dc-ea6eecb31217@gmail.com>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
 <99ab1942-9c38-695d-03dc-ea6eecb31217@gmail.com>
Message-ID: <130f490e-e173-750d-994e-c00f7c0da080@canonical.com>



On 4/18/19 8:13 PM, Minwoo Im wrote:
>> Yes the IO queues number is 0's based, but driver would return error and
>> remove the nvme device as dead.
> 
> IMHO, if a controller indicates an error with this set_feature command,
> then
> we need to figure out why the controller was returning the error to host.
> 
> If you really want to use at least a single queue to see an alive I/O
> queue,
> controller should not return the error because as you mentioned above,
> NCQA, NSQA will be returned as 0-based.? If an error is there, that could
> mean that controller may not able to provide even a single queue for I/O.

I was thinking about try to set 1 I/O queue in driver to try to probe
NVME device.
If it works, at least system can bootup to debug instead of just remove
NVME device and kernel boot hang at loading rootfs.

If you still concern this 1 I/O queue I can still set it as
*count = 0;

At least we try all count, NVME device still failed to respond.

Regards,
Aaron

> 
> Thanks,
> Minwoo Im
