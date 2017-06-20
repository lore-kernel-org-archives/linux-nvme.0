From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Jun 2017 20:19:35 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <CAANLjFrpHzapvqgBajUu7QpgNNPvNjThMZrsXGcKt58E+6siMA@mail.gmail.com>
References: <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
 <20170515143632.GH3616@mtr-leonro.local>
 <20170515145952.GA7871@infradead.org>
 <20170515170506.GK3616@mtr-leonro.local>
 <779753075.36035391.1495025796237.JavaMail.zimbra@kalray.eu>
 <20170518133439.GD3616@mtr-leonro.local>
 <CAANLjFrCLpX3nb3q7LpFPpLJKciU+1Hvmt_hxyTovQJM2-zQmg@mail.gmail.com>
 <6073e553-e8c2-6d14-ba5d-c2bd5aff15eb@grimberg.me>
 <20170620074639.GP17846@mtr-leonro.local>
 <1c706958-992e-b104-6bae-4a6616c0a9f9@grimberg.me>
 <20170620083309.GQ17846@mtr-leonro.local>
 <bd0b986f-9bed-3dfa-7454-0661559a527b@grimberg.me>
 <614481c7-22dd-d93b-e97e-52f868727ec3@grimberg.me>
 <CAANLjFrpHzapvqgBajUu7QpgNNPvNjThMZrsXGcKt58E+6siMA@mail.gmail.com>
Message-ID: <3f3830eb-68c5-f862-58c7-7021e6462f6f@grimberg.me>


> Testing this patch I didn't see these new messages even when rebooting
> the targets multiple times. It also resolved some performance problems
> I was seeing (I think our switches are having bugs with IPv6 and
> routing) and I was receiving expected performance. At one point in the
> test, one target (4.9.33) showed:
> [Tue Jun 20 10:11:20 2017] iSCSI Login timeout on Network Portal [::]:3260
> [Tue Jun 20 10:11:39 2017] iSCSI Login timeout on Network Portal [::]:3260
> [Tue Jun 20 10:11:58 2017] isert: isert_print_wc: login send failure:
> transport retry counter exceeded (12) vend_err 81

I don't understand, is this new with the patch applied?

> After this and a reboot of the target, the initiator would drop the
> connection after 1.5-2 minutes then faster and faster until it was
> every 5 seconds. It is almost like it set up the connection then lose
> the first ping, or the ping wasn't set-up right. I tried rebooting the
> target multiple times.

So the initiator could not recover even after the target as available
again?
