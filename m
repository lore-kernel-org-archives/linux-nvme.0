From: mlin@kernel.org (Ming Lin)
Date: Tue, 13 Sep 2016 10:14:46 -0700
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
References: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
 <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
 <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
Message-ID: <CAF1ivSb7wA0c4BKG-qfy=dBLRmdaTd7xtNtCKJA-+6WdyCyJtw@mail.gmail.com>

On Tue, Sep 13, 2016@7:21 AM, Steve Wise <swise@opengridcomputing.com> wrote:
>>
>> >>> I think Ming sent a patch for this some time ago... Not sure what
>> >>> happened with it though...
>> >>
>> >> This?
>> >>
>> >> http://lists.infradead.org/pipermail/linux-nvme/2016-June/004884.html
>> >
>> > This is indeed the same problem.  I don't have the knoggin to propose a fix.
>> > Sagi/Christoph, do you have any ideas on this?  I'm willing to take and idea
>> > forward and test it out of you all have any clever ideas.  We should at
> least
>> > prevent setting nr_io_queues to a value that will crash immediately when
> nvmf is
>> > used...
>>
>> I think that Ming and Keith had a few suggestions.
>>
>> ++ Keith.
>>
>
> Ming has been silent. :(  Keith, any thoughts on this?

Sorry, has been busy with other internal projects :(

>
> Thanks,
>
> Steve.
>
