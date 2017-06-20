From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Jun 2017 09:39:36 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <CAANLjFrCLpX3nb3q7LpFPpLJKciU+1Hvmt_hxyTovQJM2-zQmg@mail.gmail.com>
References: <33e2cc35-f147-d4a4-9a42-8f1245e35842@mellanox.com>
 <DE927C68B458BE418D582EC97927A92855088C6F@ORSMSX113.amr.corp.intel.com>
 <82dd5b24-5657-ae5e-8a33-646fddd8b75b@grimberg.me>
 <20170515133122.GG3616@mtr-leonro.local>
 <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
 <20170515143632.GH3616@mtr-leonro.local>
 <20170515145952.GA7871@infradead.org>
 <20170515170506.GK3616@mtr-leonro.local>
 <779753075.36035391.1495025796237.JavaMail.zimbra@kalray.eu>
 <20170518133439.GD3616@mtr-leonro.local>
 <CAANLjFrCLpX3nb3q7LpFPpLJKciU+1Hvmt_hxyTovQJM2-zQmg@mail.gmail.com>
Message-ID: <6073e553-e8c2-6d14-ba5d-c2bd5aff15eb@grimberg.me>

Hi Robert,

> I ran into this with 4.9.32 when I rebooted the target. I tested
> 4.12-rc6 and this particular error seems to have been resolved, but I
> now get a new one on the initiator. This one doesn't seem as
> impactful.
> 
> [Mon Jun 19 11:17:20 2017] mlx5_0:dump_cqe:275:(pid 0): dump error cqe
> [Mon Jun 19 11:17:20 2017] 00000000 00000000 00000000 00000000
> [Mon Jun 19 11:17:20 2017] 00000000 00000000 00000000 00000000
> [Mon Jun 19 11:17:20 2017] 00000000 00000000 00000000 00000000
> [Mon Jun 19 11:17:20 2017] 00000000 93005204 0a0001bd 45c8e0d2

Max, Leon,

Care to parse this syndrome for us? ;)
