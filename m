From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 25 Jul 2019 12:02:30 -0700
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
Message-ID: <5951e0f5-cc90-f3de-0083-088fecfd43bb@grimberg.me>


>>>> Why do you have a "string" within the kernel and are not using the
>>>> normal open() call from userspace on the character device node on the
>>>> filesystem in your namespace/mount/whatever?
>>>
>>> NVMe-OF is configured using configfs. The target is specified by the
>>> user writing a path to a configfs attribute. This is the way it works
>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
>>
>> Why isn't a fd being passed in there instead of a random string?
> 
> I wouldn't know the answer to this but I assume because once we decided
> to use configfs, there was no way for the user to pass the kernel an fd.

That's definitely not changing. But this is not different than how we
use the block device or file configuration, this just happen to need the
nvme controller chardev now to issue I/O.
