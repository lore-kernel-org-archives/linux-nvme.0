From: leon@kernel.org (Leon Romanovsky)
Date: Mon, 15 May 2017 20:05:06 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <20170515145952.GA7871@infradead.org>
References: <33e2cc35-f147-d4a4-9a42-8f1245e35842@mellanox.com>
 <517fb6d2-a010-1926-b4cb-0e6041722c28@grimberg.me>
 <af9044c2-fb7c-e8b3-d8fc-4874cfd1bb67@mellanox.com>
 <c2a1436f-48a6-bdea-c910-168fc6031364@grimberg.me>
 <DE927C68B458BE418D582EC97927A92855088C6F@ORSMSX113.amr.corp.intel.com>
 <82dd5b24-5657-ae5e-8a33-646fddd8b75b@grimberg.me>
 <20170515133122.GG3616@mtr-leonro.local>
 <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
 <20170515143632.GH3616@mtr-leonro.local>
 <20170515145952.GA7871@infradead.org>
Message-ID: <20170515170506.GK3616@mtr-leonro.local>

On Mon, May 15, 2017@07:59:52AM -0700, Christoph Hellwig wrote:
> On Mon, May 15, 2017@05:36:32PM +0300, Leon Romanovsky wrote:
> > I understand you and both Max and me are feeling the same as you. For more
> > than 2 months, we constantly (almost on daily basis) asked for a solution from
> > architecture group, but received different answers. The proposals were
> > extremely broad from need for strong fence for all cards to no need for
> > strong fence at all.
>
> So let's get the patch to do a strong fence everywhere now, and relax
> it later where possible.
>
> Correntness before speed..

OK, please give me and Max till EOW to stop this saga. One of the two
options will be: Max will resend original patch, or Max will send patch
blessed by architecture group.

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170515/eda44767/attachment.sig>
