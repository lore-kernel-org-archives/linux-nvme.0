From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Feb 2017 11:12:53 +0200
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170215160448.fk3igep336tj5f3k@merlins.org>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <c42e8e1e-f96f-9b2d-f3e6-72599430a327@grimberg.me>
 <20170215154649.GA30251@localhost.localdomain>
 <20170215160448.fk3igep336tj5f3k@merlins.org>
Message-ID: <8b6205c1-00f6-0a5f-7cd1-10f9a3e3f63b@grimberg.me>


> Howdy,

Hey Mark,

> Let me chime in here about how the stuck request thing is not just
> theory, or made up :)
>
> I first reported this in Aug 2016: https://patchwork.kernel.org/patch/9265695/
>
> Long story short, I have been unable to upgrade to any kernel past 4.4
> due to my M2 NVME drive. No matter what I did, S3 suspend would not
> succeed or resume (as in ever, not just sometimes).
>
> It's only until the last patch I got from Keith applied to 4.10
> linux-block/for-next that I can _finally_ upgrade to a kernel past 4.4
> and that suspend/resume works.
>
> So while I don't have the knowledge to say whether Keith's patch is the
> best way to fix my problem, it is the only thing I've seen that works in
> the last 9 months, and has taken me from 100% failure to 0% failure so
> far.
>
> As a result, a big thanks to Keith again and thumbs up from me.

I have no doubt this patch is useful, I'm just wandering if we can
place the functionality in a more generic location so that more
drivers can enjoy it.
