From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Sep 2016 17:09:15 +0300
Subject: [PATCH] admin-cmd: Added smart-log command support.
In-Reply-To: <20160905131127.GA3176@infradead.org>
References: <1472759103-16538-1-git-send-email-ckulkarnilinux@gmail.com>
 <ac203b28-39ed-4f2a-b0fc-f586e43c9346@grimberg.me>
 <20160905131127.GA3176@infradead.org>
Message-ID: <8ff4e98e-477f-d159-3e3e-de485d2eb6be@grimberg.me>


>> Given that we don't own the namespaces, I'm wandering if this is the
>> correct way to do this... I'm not at all convinced that having something
>> else reading/writing to the blkdevs other than nvmf is a valid/useful
>> use-case but in this situation we won't get correct log information
>> (or at least the semantics is wrong).
>>
>> Should we maintain these statistics in the target stack instead?
>
> What's the problem with including possible local I/O?  Having to
> maintain another set of counters, including atomics in the fast path
> or complex per-cpu infrastructure is something I'd rather avoid.

I don't want it either. But I think that the semantics of the
smart log info is different, the question is are we ok with it?
