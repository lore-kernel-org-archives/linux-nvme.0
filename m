From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Sep 2016 11:46:46 +0300
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
References: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
 <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
Message-ID: <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>


>>> I think Ming sent a patch for this some time ago... Not sure what
>>> happened with it though...
>>
>> This?
>>
>> http://lists.infradead.org/pipermail/linux-nvme/2016-June/004884.html
>
> This is indeed the same problem.  I don't have the knoggin to propose a fix.
> Sagi/Christoph, do you have any ideas on this?  I'm willing to take and idea
> forward and test it out of you all have any clever ideas.  We should at least
> prevent setting nr_io_queues to a value that will crash immediately when nvmf is
> used...

I think that Ming and Keith had a few suggestions.

++ Keith.
