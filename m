From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 22 Oct 2016 00:33:39 +0300
Subject: [PATCH 0/6] Six NVMeOF-related patches
In-Reply-To: <20161021150831.GA5294@localhost.localdomain>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <1ae62d3e-8e23-6458-e822-7a11d3f9897f@grimberg.me>
 <dc3f4a94-72bd-469d-16ba-b1a6619f8609@sandisk.com>
 <20161021133252.GB16449@infradead.org>
 <20161021150831.GA5294@localhost.localdomain>
Message-ID: <2186e122-a82d-3898-e961-7422c887ddaf@grimberg.me>


>> Maybe.  Or we should just add Sagi and me to the general NVMe antry
>> and replace the Fabrics git tree with a general NVMe one.
>>
>> Keith, Jens - any preferences?
>
> I've no preference. I assumed, though, fabrics developers/users found
> the public staging tree useful since it seems to be changing faster
> than the rest of the driver.

True,

However this tree is designed to share the load with Jens so he doesn't
need to closely monitor all the fabrics changes. IMO It worked pretty
well for the inclusion process and 4.8-rc fixes.

I was a bit busy lately but wanted to pick up on 4.9-rc and 4.10 related
stuff next week.

> We don't have an nvme specific tree, so
> if everyone's okay going through the general block, then let's add the
> maintainer entries.

It all goes through Jens, I think Christoph was offering to increase the
scope of the nvmf tree to nvme in general. This way, you, Christoph and
me can offload from Jens some nvme related patch traffic and send him
pull requests. But if you are more comfortable with the way things are
we can leave it as is.
