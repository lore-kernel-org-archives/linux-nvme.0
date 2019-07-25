From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 25 Jul 2019 12:43:27 -0700
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <966fa988-de56-effe-dd52-3515ee83629c@grimberg.me>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
 <5951e0f5-cc90-f3de-0083-088fecfd43bb@grimberg.me>
 <20190725193415.GA12117@kroah.com>
 <966fa988-de56-effe-dd52-3515ee83629c@grimberg.me>
Message-ID: <af960e70-7373-51f2-3ff3-f23335f94aa1@grimberg.me>


>> So, as was kind of alluded to in another part of the thread, what are
>> you doing about permissions?? It seems that any user/group permissions
>> are out the window when you have the kernel itself do the opening of the
>> char device, right?? Why is that ok?? You can pass it _any_ character
>> device node and away it goes?? What if you give it a "wrong" one?? Char
>> devices are very different from block devices this way.
> 
> We could condition any configfs operation on capable(CAP_NET_ADMIN) to
> close that hole for now..

s/NET/SYS/...
