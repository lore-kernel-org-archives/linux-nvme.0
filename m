From: xgchenshy@gmail.com (=?UTF-8?B?6ZmI5pmT5YWJ?=)
Date: Thu, 13 Oct 2016 09:19:36 +0800
Subject: Need help for dead lock of nvme shutdown_lock
In-Reply-To: <20161012135339.GA11730@localhost.localdomain>
References: <CAEj2FWN7ZgdBA4kHhKNSoHJnP9x+KCu8YNK_i9VSs2tSLHj3+g@mail.gmail.com>
 <57fdff29.c6efca0a.f2af0.9897SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAEj2FWN7B5svizExg7CNq+maZaP4TrabWee2B30CwAxFDp1U2g@mail.gmail.com>
 <20161012135339.GA11730@localhost.localdomain>
Message-ID: <CAEj2FWNp-7DXan_hqKDtpcK8GgG6k2x4WQKybkDZyfVXP082FQ@mail.gmail.com>

2016-10-12 21:53 GMT+08:00 Keith Busch <keith.busch at intel.com>:
> On Wed, Oct 12, 2016@05:33:01PM +0800, ??? wrote:
>> 2016-10-12 17:15 GMT+08:00 Shan Hai <shan.hai at oracle.com>:
>> >
>> > On Wed, Oct 12, 2016@03:44:34PM +0800, ??? wrote:
>> > > Dear maintainers of NVME
>> > > I met a dead lock issue when I was using NVME.
>> > > the shutdown_lock may cause dead lock when nvme_reset_work is working
>> > > and nvme_timeout happens.
>> > > I checked the latest mainline code, it seems still have such issue,
>> > > please help, thank you!
>> > > below is the log:
>> > >
>> >
>> > Hi Xiaoguang,
>> >
>> > Would you please try the below patch?
>> >
>> >
>> Thank you very much for the quick fix, Shan
>> This can absolutely fix the dead lock issue I met.
>> Will this be submitted to mainline?
>
> NAK!
>
> First of all, you can't complete a request while the controller still
> owns it. You're risking data and/or memory corruption from doing that.
>
> Secondly, there is no such mainline kernel that tries to disable the
> controller in a softirq context. Whoever built your kernel needs to
> cherry pick 287922eb, "block: defer timeouts to a workqueue".
Thank you Keith, this patch works for me :)
