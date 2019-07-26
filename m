From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 26 Jul 2019 09:46:40 -0600
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <7f48a40c-6e0f-2545-a939-45fc10862dfd@grimberg.me>
References: <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
 <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
 <20190725235502.GJ1131@ZenIV.linux.org.uk>
 <7f48a40c-6e0f-2545-a939-45fc10862dfd@grimberg.me>
Message-ID: <fce9d627-3bf7-2c63-dbdc-5b252792cc36@deltatee.com>



On 2019-07-25 10:29 p.m., Sagi Grimberg wrote:
> 
>>>>>>>> NVMe-OF is configured using configfs. The target is specified by
>>>>>>>> the
>>>>>>>> user writing a path to a configfs attribute. This is the way it
>>>>>>>> works
>>>>>>>> today but with blkdev_get_by_path()[1]. For the passthru code,
>>>>>>>> we need
>>>>>>>> to get a nvme_ctrl instead of a block_device, but the principal
>>>>>>>> is the same.
>>>>>>>
>>>>>>> Why isn't a fd being passed in there instead of a random string?
>>>>>>
>>>>>> I suppose we could echo a string of the file descriptor number there,
>>>>>> and look up the fd in the process' file descriptor table ...
>>>>>
>>>>> Assuming that there is a open handle somewhere out there...
>>>
>>> Yes, that would be a step backwards from an interface. The user would
>>> then need a special process to open the fd and pass it through configfs.
>>> They couldn't just do it with basic bash commands.
>>
>> First of all, they can, but... WTF not have filp_open() done right there?
>> Yes, by name.? With permission checks done.? And pick your object from
>> the
>> sodding struct file you'll get.
>>
>> What's the problem?? Why do you need cdev lookups, etc., when you are
>> dealing with files under your full control?? Just open them and use
>> ->private_data or whatever you set in ->open() to access the damn thing.
>> All there is to it...
> Oh this is so much simpler. There is really no point in using anything
> else. Just need to remember to compare f->f_op to what we expect to make
> sure that it is indeed the same device class.

Yes, that sounds like a good idea. I'll do this for v2.

Thanks,

Logan
