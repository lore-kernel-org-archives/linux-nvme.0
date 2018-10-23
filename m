From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Oct 2018 17:29:55 -0700
Subject: [PATCH RFC] nvmet: emulate noiob boundary
In-Reply-To: <20181022085912.GE18755@lst.de>
References: <20181019222437.25289-1-sagi@grimberg.me>
 <20181022085912.GE18755@lst.de>
Message-ID: <1fc9b542-caa0-4696-d2bd-5722b97a17c8@grimberg.me>


>> Useful to exercise the host driver to noiob support without having device
>> that actually require it.
> 
> This code looks ok to me, but I'm rather worried about adding these
> just for fun features - we'll eventually have a configfs mess just
> like the scsi target code if we just keep adding random options.

Well, this helped me debug a sub-page bio split code path that I
wouldn't be able to generate without, so I think its beneficial
to have a knob for it.

In general, I would be in favor of us having the kernel target
allow one to exercise the host code in various forms, but would not
want to have endless attributes to setup. Perhaps we would want to have
these sort of stuff with a debug prefix such that its clear that only
debug stuff belong there?

Thoughts?
