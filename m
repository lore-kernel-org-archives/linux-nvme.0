From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 25 Aug 2016 00:54:00 -0700
Subject: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result
 pointer
In-Reply-To: <20160825073810.GA18622@lst.de>
References: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
 <20160825073810.GA18622@lst.de>
Message-ID: <CALCETrWsJCwO6D9=LsYOV5ghbXMc_MdOYgXm1qzarJ1-cizuXw@mail.gmail.com>

On Thu, Aug 25, 2016@12:38 AM, Christoph Hellwig <hch@lst.de> wrote:
> Ooops, yes.
>
> Are you looking into new nvme_set_features users?  Another thing
> we need to tackle is either replacing dma_addr argument with a
> a real kernel pointer (or just kill it until users show up)

I am, and I have a patch to do the former (and to add a length
argument).  But that's not -stable material.

While I have your attention: the new use is to enable APST (power
saving).  In theory, it seems like I should integrate with dev_pm_qos
so that the standard interface for setting a latency limit will work,
but, on brief inspection, there are literally no drivers in the entire
tree that do this.  Am I missing something?  My current draft patch
just adds a sysfs attribute.  (It saves a *lot* of power on my laptop,
so supporting APST is worth doing.)

--Andy
