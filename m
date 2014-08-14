From: m@bjorling.me (Matias Bjorling)
Date: Thu, 14 Aug 2014 17:39:46 +0200
Subject: [PATCH v11] NVMe: Convert to blk-mq
In-Reply-To: <53ECD125.3080701@fb.com>
References: <1406365643-27020-1-git-send-email-m@bjorling.me>
 <1406365643-27020-2-git-send-email-m@bjorling.me>
 <CAOu_J6mW-2e2Jgm+khodLPah_-RZrD599SmSH+Mszd0AjterrQ@mail.gmail.com>
 <alpine.LRH.2.03.1408131519590.14603@AMR> <53EC7273.5060303@bjorling.me>
 <53ECD125.3080701@fb.com>
Message-ID: <53ECD842.40302@bjorling.me>

>
>>> I haven't event tried debugging this next one: doing an insmod+rmmod
>>> caused this warning followed by a panic:
>>>
>>
>> I'll look into it. Thanks
>
> nr_tags must be uninitialized or screwed up somehow, otherwise I don't
> see how that kmalloc() could warn on being too large. Keith, are you
> running with slab debugging? Matias, might be worth trying.

Thanks for the hint.

Keith, I'll first have a chance to fix it tomorrow. Let me know if you 
find it in the mean time.

I've put up a nvmemq_v12 on the github repository with the q_suspended 
removed.
