From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 13:31:20 -0600
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <20190725192613.GF30641@bombadil.infradead.org>
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
 <20190725192613.GF30641@bombadil.infradead.org>
Message-ID: <a4bb9e66-9165-3557-ae43-02a916b4fa0e@deltatee.com>



On 2019-07-25 1:26 p.m., Matthew Wilcox wrote:
> On Thu, Jul 25, 2019@01:24:22PM -0600, Logan Gunthorpe wrote:
>>>> Assuming that there is a open handle somewhere out there...
>>
>> Yes, that would be a step backwards from an interface. The user would
>> then need a special process to open the fd and pass it through configfs.
>> They couldn't just do it with basic bash commands.
> 
> echo 3 3</dev/nvme3 >/configfs/foor/bar/whatever

Neat. I didn't know you could do that.

Logan
