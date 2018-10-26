From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Oct 2018 09:54:28 +0200
Subject: [PATCH RFC] nvmet: emulate noiob boundary
In-Reply-To: <1fc9b542-caa0-4696-d2bd-5722b97a17c8@grimberg.me>
References: <20181019222437.25289-1-sagi@grimberg.me>
 <20181022085912.GE18755@lst.de>
 <1fc9b542-caa0-4696-d2bd-5722b97a17c8@grimberg.me>
Message-ID: <20181026075428.GD5092@lst.de>

On Mon, Oct 22, 2018@05:29:55PM -0700, Sagi Grimberg wrote:
> Well, this helped me debug a sub-page bio split code path that I
> wouldn't be able to generate without, so I think its beneficial
> to have a knob for it.
>
> In general, I would be in favor of us having the kernel target
> allow one to exercise the host code in various forms, but would not
> want to have endless attributes to setup. Perhaps we would want to have
> these sort of stuff with a debug prefix such that its clear that only
> debug stuff belong there?

Yes, maybe we could have a config option to turn on this pure debug
code.  For noiob in particular it might make sense to just pass
it up if the lower level device has it, though.
