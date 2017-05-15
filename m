From: leon@kernel.org (Leon Romanovsky)
Date: Mon, 15 May 2017 17:36:32 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
References: <809f87ab-b787-9d40-5840-07500d12e81a@mellanox.com>
 <1948057100.362217696.1491824459274.JavaMail.zimbra@kalray.eu>
 <33e2cc35-f147-d4a4-9a42-8f1245e35842@mellanox.com>
 <517fb6d2-a010-1926-b4cb-0e6041722c28@grimberg.me>
 <af9044c2-fb7c-e8b3-d8fc-4874cfd1bb67@mellanox.com>
 <c2a1436f-48a6-bdea-c910-168fc6031364@grimberg.me>
 <DE927C68B458BE418D582EC97927A92855088C6F@ORSMSX113.amr.corp.intel.com>
 <82dd5b24-5657-ae5e-8a33-646fddd8b75b@grimberg.me>
 <20170515133122.GG3616@mtr-leonro.local>
 <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
Message-ID: <20170515143632.GH3616@mtr-leonro.local>

On Mon, May 15, 2017@04:43:18PM +0300, Sagi Grimberg wrote:
> > > > Any update here?  Would love to be able to load up the new kernels without patching them every time. :)
> > >
> > > I would like that too,
> > >
> > > Max, can you send a patch? or should I?
> >
> > Sagi,
> >
> > Max is doing his best to provide a patch, unfortunately he is limited
> > by various architecture implications which he needs to resolve before
> > sending it.
>
> Well, he already sent a patch that fixes the issue.
> He said that he needs additional optimization for CX5 (which I assume
> doesn't need the strong fence), but that still does not change the
> fact that CX4 is broken. I asked to include his patch, fix the
> existing bug and incrementally optimize CX5.
>
> What do you mean by architecture implications? it's broken and there is
> a request from the community to fix it. Are you suggesting that it
> doesn't solve the issue?

I understand you and both Max and me are feeling the same as you. For more
than 2 months, we constantly (almost on daily basis) asked for a solution from
architecture group, but received different answers. The proposals were
extremely broad from need for strong fence for all cards to no need for
strong fence at all.

Thanks

>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170515/20da2579/attachment.sig>
