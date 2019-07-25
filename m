From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 25 Jul 2019 12:31:14 -0700
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
Message-ID: <e91094eb-3ce8-b42b-663a-b62d4617fc96@grimberg.me>


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
> 
> Well, that's how we'd know that the application echoing /dev/nvme3 into
> configfs actually has permission to access /dev/nvme3.

Actually, the application is exposing a target device to someone else,
its actually preferable that it doesn't have access to it as its
possibly can create a consistency hole, but that is usually a root
application anyways... We could verify at least that though..

>  Think about
> containers, for example.  It's not exactly safe to mount configfs in a
> non-root container since it can access any NVMe device in the system,
> not just ones which it's been given permission to access.  Right?

I'm seeing this as an equivalent to an application that is binding a
socket to an ip address, and the kernel looks-up according to the net
namespace that the socket has.

I do agree this is an area that was never really thought of. But what
you are describing requires infrastructure around it instead of forcing
the user to pass an fd to validate around it.
