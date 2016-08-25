From: hch@lst.de (Christoph Hellwig)
Date: Thu, 25 Aug 2016 10:27:27 +0200
Subject: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result
 pointer
In-Reply-To: <CALCETrWsJCwO6D9=LsYOV5ghbXMc_MdOYgXm1qzarJ1-cizuXw@mail.gmail.com>
References: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
 <20160825073810.GA18622@lst.de>
 <CALCETrWsJCwO6D9=LsYOV5ghbXMc_MdOYgXm1qzarJ1-cizuXw@mail.gmail.com>
Message-ID: <20160825082727.GA20497@lst.de>

On Thu, Aug 25, 2016@12:54:00AM -0700, Andy Lutomirski wrote:
> I am, and I have a patch to do the former (and to add a length
> argument).  But that's not -stable material.

Great!

> While I have your attention: the new use is to enable APST (power
> saving).  In theory, it seems like I should integrate with dev_pm_qos
> so that the standard interface for setting a latency limit will work,
> but, on brief inspection, there are literally no drivers in the entire
> tree that do this.  Am I missing something?  My current draft patch
> just adds a sysfs attribute.  (It saves a *lot* of power on my laptop,
> so supporting APST is worth doing.)

I'm proably the wrong person to talk about PM interfaces, but not
having it used anywhere is a red herring and needs a ping to the PM
folks why we even have that code in the tree.

Integrating it with the PM core would be preferable, but until that
happens we should just enable it by default in the nvme driver and
have a local tweak (sysfs file, or maybe even just a run-time writeable
module parameter) to turn it off.
