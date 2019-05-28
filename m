From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 May 2019 15:46:29 -0700
Subject: [PATCH 6/9] nvme: update list-subsys command to show the entire
 list
In-Reply-To: <8a754fd0-6abc-a000-0183-b6832df0f2ba@mellanox.com>
References: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
 <1558951310-31066-7-git-send-email-maxg@mellanox.com>
 <0004494a-67a0-c010-5de6-fa66dcafff68@grimberg.me>
 <8a754fd0-6abc-a000-0183-b6832df0f2ba@mellanox.com>
Message-ID: <a3c90a29-07f3-614a-034e-d04bcc21013a@grimberg.me>


>>> Make it similar to "nvme list" command. For that, remove the
>>> unnecessary ana_state parsing (was introduced only if specific namespace
>>> handle was given).
>>
>> No, this is useful! You're arbitrarily removing useful information from
>> the display...
>>
>> nak from me on this one...
> 
> I intended to add it to different command (maybe to new "nvme multipath" 
> command you suggested).

I think it should be the other way around, we already have an interface
which is useful, if we add information it should either be exposed via
an argument or a different command.

> I don't understand why ANA state is so important attribute for a user 
> that only asked "nvme list-subsys".

It gives you the layout of the subsystem with respect to the volume you
asked for.

> One can always run "nvme ana-log" command to get a full log page (I'll 
> take a look on it and see if it can be improved per given namespace)

This is the reverse info (controller view), this is the
subsystem/namespace view.
