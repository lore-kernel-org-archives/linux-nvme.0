From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 2 Feb 2017 09:37:14 -0700
Subject: [PATCH 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <CACvgo520=CXUHNwd75Er0zPCiEQVfOu0h=eeHNDQ-uQn66kAJA@mail.gmail.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <CACvgo50ruxTOfhGF=bV+xWVq+5UZ_xWeoTqxA+SzSwFNCVaS8g@mail.gmail.com>
 <35aab5e1-c86d-efbb-f0c8-288469aeb52f@deltatee.com>
 <CACvgo520=CXUHNwd75Er0zPCiEQVfOu0h=eeHNDQ-uQn66kAJA@mail.gmail.com>
Message-ID: <fd54d9a2-5613-29b0-35fe-3db3ecbcdd05@deltatee.com>



On 01/02/17 05:10 AM, Emil Velikov wrote:
> You can keep it roughly as-is if you're ~reasonably certain one won't
> change it in the future.

I've made the change anyway. I think it's better now.

> Some teams frown upon adding new IOCTL(s) where existing ones can be
> made backward/forward compatible.
> I'm not fully aware of the general direction/consensus on the topic,
> so it might be a minority.

Sure, I just don't know what might be needed in the future so it's hard
to add a version or flags ioctl now.

> On the other hand, reading through sysfs for module version in order
> to use IOCTL A or B sounds quite hacky. Do you have an example where
> this is used or pointed out as good approach ?

I don't know of anything doing it that way now. But it sure would be
easy and make a bit of sense. (We'd actually use the module version for
something useful.) Either way, it would really depend on if and how
things change in the future. The point is there are options to expand if
needed.


> Afaict the idea is to not ship/bundle/release userspace until kernel
> parts are in.
> The "do not commit the changes" is implied as [very rarely] distros
> package from "random" git checkouts. Leading to all sorts of fun when
> it is mismatched wrt the kernel parts. Likelihood of doing that here
> is virtually none here, so this is a JFYI inspired by some past
> experiences.

Understood.

> Glad to hear. Then again you already had most of the things nicely done, imho.

Great, thanks.

Logan
