From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 23 Oct 2018 06:50:00 +0000
Subject: [PATCH RFC] nvmet: emulate noiob boundary
In-Reply-To: <1fc9b542-caa0-4696-d2bd-5722b97a17c8@grimberg.me>
References: <20181019222437.25289-1-sagi@grimberg.me>
 <20181022085912.GE18755@lst.de>,
 <1fc9b542-caa0-4696-d2bd-5722b97a17c8@grimberg.me>
Message-ID: <BYAPR04MB45022B914FEE4FC6D33783FB86F50@BYAPR04MB4502.namprd04.prod.outlook.com>







From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Sagi Grimberg <sagi@grimberg.me>
Sent: Monday, October 22, 2018 5:29 PM
To: Christoph Hellwig
Cc: Keith Busch; linux-nvme at lists.infradead.org
Subject: Re: [PATCH RFC] nvmet: emulate noiob boundary
? 
 

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
want to have endless attributes to setup.

[CK] We can get away with the target component based debug bitmask and
have one configfs entry to avoid the configfs attribute pollution.

 Perhaps we would want to have
these sort of stuff with a debug prefix such that its clear that only
debug stuff belong there?

Thoughts?


[CK] I like the idea of having debug code handy.
However,?if we start adding?debug code in each file?it will spread
the debug code?all?over the places in the future.?How about we centralize?the
debug code in nvmet-debug.[c|h] ? (not sure how we are going to do this in this
case though).

?


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
