From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Jul 2019 16:13:45 -0700
Subject: [PATCH v6 00/16] nvmet: add target passthru commands support
In-Reply-To: <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
Message-ID: <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>


>> Why? if nvmet is capable, why shouldn't we support it?
> 
> I'm saying that passthru is exporting a specific controller and submits
> commands (both admin and IO) straight to the nvme_ctrl's queues. It's
> not exporting an nvme_subsys and I think it would be troublesome to do
> so; for example, if the target receives an admin command which ctrl of
> the subsystem should it send it to?

Its the same controller in the backend, what is the difference from
which fabrics controller the admin command came from?

> There's also no userspace handle for
> a given subsystem we'd maybe have to use the subsysnqn.

Umm, not sure I understand what you mean.

>>> The one case that I think makes sense to me, but I don't know how if we
>>> can handle, is if the user had a couple multipath enabled controllers
>>> with the same subsynqn
>>
>> That is usually the case, there is no multipathing defined across NVM
>> subsystems (at least for now).
>>
>>> and wanted to passthru all of them to another
>>> system and use multipath on the host with both controllers. This would
>>> require having multiple target subsystems with the same name which I
>>> don't think will work too well.
>>
>> Don't understand why this is the case?
>>
>> AFAICT, all nvmet needs to do is:
>> 1. override cimc
>> 2. allow allocating multiple controllers to the pt ctrl as long as the
>> hostnqn match.
>> 3. answer all the ana stuff.
> 
> But with this scheme the host will only see one controller and then the
> target would have to make decisions on which ctrl to send any commands
> to. Maybe it could be done for I/O but I don't see how it could be done
> correctly for admin commands.

I haven't thought this through so its very possible that I'm missing
something, but why can't the host see multiple controllers if it has
more than one path to the target?

What specific admin commands are you concerned about? What exactly
would clash?

> And from the hosts perspective, having cimc set doesn't help anything
> because we've limited the passthru code to only accept one connection
> from one host so the host can only actually have one route to this
> controller.

And I'm suggesting to allow more than a single controller given that all
controller allocations match a single hostnqn. It wouldn't make sense to
expose this controller to multiple hosts (although that might be doable
but but definitely requires non-trivial infrastructure around it).

Look, when it comes to fabrics, multipath is a fundamental piece of the
puzzle. Not supporting multipathing significantly diminishes the value
of this in my mind (assuming this answers a real-world use-case).
