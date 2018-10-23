From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Oct 2018 00:31:32 -0700
Subject: [PATCH RFC] nvmet: emulate noiob boundary
In-Reply-To: <BYAPR04MB45022B914FEE4FC6D33783FB86F50@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20181019222437.25289-1-sagi@grimberg.me>
 <20181022085912.GE18755@lst.de>
 <1fc9b542-caa0-4696-d2bd-5722b97a17c8@grimberg.me>
 <BYAPR04MB45022B914FEE4FC6D33783FB86F50@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <13b38d99-04fc-be69-6039-dfd2332b7b9b@grimberg.me>


> Well, this helped me debug a sub-page bio split code path that I
> wouldn't be able to generate without, so I think its beneficial
> to have a knob for it.
> 
> In general, I would be in favor of us having the kernel target
> allow one to exercise the host code in various forms, but would not
> want to have endless attributes to setup.
> 
> [CK] We can get away with the target component based debug bitmask and
> have one configfs entry to avoid the configfs attribute pollution.

That is not a better user experience in my mind...

> [CK] I like the idea of having debug code handy.
> However,?if we start adding?debug code in each file?it will spread
> the debug code?all?over the places in the future.?How about we centralize?the
> debug code in nvmet-debug.[c|h] ? (not sure how we are going to do this in this
> case though).

I don't think the comment was on debug code layout, more about keeping a
clean and simple user interface without tons of irrelevant knobs a user
can see (or I might have misunderstood hch here).
