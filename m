From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 13:24:22 -0600
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <20190725191124.GE30641@bombadil.infradead.org>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
Message-ID: <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>



On 2019-07-25 1:11 p.m., Matthew Wilcox wrote:
> On Thu, Jul 25, 2019@12:05:29PM -0700, Sagi Grimberg wrote:
>>
>>>>> NVMe-OF is configured using configfs. The target is specified by the
>>>>> user writing a path to a configfs attribute. This is the way it works
>>>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
>>>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
>>>>
>>>> Why isn't a fd being passed in there instead of a random string?
>>>
>>> I suppose we could echo a string of the file descriptor number there,
>>> and look up the fd in the process' file descriptor table ...
>>
>> Assuming that there is a open handle somewhere out there...

Yes, that would be a step backwards from an interface. The user would
then need a special process to open the fd and pass it through configfs.
They couldn't just do it with basic bash commands.

> Well, that's how we'd know that the application echoing /dev/nvme3 into
> configfs actually has permission to access /dev/nvme3.  

It's the kernel that's accessing the device so it has permission. root
permission is required to configure the kernel.

> Think about
> containers, for example.  It's not exactly safe to mount configfs in a
> non-root container since it can access any NVMe device in the system,
> not just ones which it's been given permission to access.  Right?

I don't think it really makes any sense to talk about NVMe-of and
containers. Though, if we did it would be solely on the configuration
interface so that users inside a container might be able to configure a
new target for resources they can see and they'd have to have their own
view into configfs....

Logan
