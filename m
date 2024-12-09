Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B68E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6EVh6ekbWiJ0H+/RPaWmq2DyRBJuGByAGojKHdpcIlI=; b=NwvOITc124VXgEoC0idd/0GSfO
	Qdf/6WjbqMBNfoZBbWSLSIfOvdXAY+PLpIZUUk701Fsu7chmp2skcilsGstkMUrEkTK0p5knktwPk
	fIXE19R8og/x4hGvi89kKsDNTR5illtEfJACvSLfVTXrKZGjjyizgeOVpIrMXfR1SE2iNenXFK4Q3
	18W6N2oZIBqHVNGKawd54nrZR+SVswJ13PRWUtCaLlTBfHeGMJCv3It2TPSIx6gjkNyLtW68pi3zV
	voIUhme6rd3iK0O7xb8HHP2trdBuqA5GNa0mxIrgNR36lirLUx1F8ol86UKxyTEnYT37uSWSzqAmA
	W3s+0rOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdAx-00000007mNm-0VX4;
	Mon, 09 Dec 2024 12:47:47 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcwc-00000007hap-323n
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 12:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1733747566; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i/tNjtfbeMtUCbW3lnkJdxihZ5vsLX38tmuu3i5ocVGSb+2GeIYwuoInW2sh49cBeFdS9n/71b+g7V/Dey+MsOlZFafZDQ5ugSLcrQ1e2T0+nkUqys1SCnQ3f002rTLsNTjeejSOjPskuz4rMZu0bbmfZOBdcmxVyB2xRbZB44g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733747566; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6EVh6ekbWiJ0H+/RPaWmq2DyRBJuGByAGojKHdpcIlI=; 
	b=XGw2gOoN5FZ2ZPlR/Eca1uM4dLa2t0czZLe+0g0iJ6Lp2pOVthGxQKMflus17M3BKLvW/nvqilzzO37xWvI+aOToaP6SEeXjay19naT5RcPpjhCnNSg7PCn/w8mAub55tBefZQh2IZn2+1xy/fwg+m/n14U3xGBXgG/yZRyt+7A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733747566;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6EVh6ekbWiJ0H+/RPaWmq2DyRBJuGByAGojKHdpcIlI=;
	b=U5qXMH55yECI6a9fA7hrpOuRZlilSSK2ElWL6qcD/5FkpIteEwAadCQU58kxbP/q
	njVRhCZ+HMx6AOx7yjbj0bpQqbVLaE2ef/V9sBRz2wBTSvx/bl0+HBqgZSVaXB9JTi2
	+4qohSQbMkwTfEWN7M6gaSB/BeQ5Ek6Rwpm3HoCw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 173374753370972.00679083416446; Mon, 9 Dec 2024 04:32:13 -0800 (PST)
Date: Mon, 09 Dec 2024 12:32:13 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Pawel Anikiel" <panikiel@google.com>, "axboe" <axboe@kernel.dk>,
	"hch" <hch@lst.de>, "kernel" <kernel@collabora.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>
Message-ID: <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
In-Reply-To: <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com> <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_043258_797764_F5B9F5A8 
X-CRM114-Status: GOOD (  36.29  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org






 ---- On Fri, 22 Nov 2024 19:36:51 +0000  Keith Busch  wrote ---=20
 > On Thu, Nov 14, 2024 at 04:28:48PM +0000, Robert Beckett wrote:
 > >  ---- On Thu, 14 Nov 2024 14:13:52 +0000  Pawe=C5=82 Anikiel  wrote --=
-=20
 > >  > On Thu, Nov 14, 2024 at 2:24=E2=80=AFPM Robert Beckett
 > >  > bob.beckett@collabora.com> wrote:
 > >  > > This is interesting.
 > >  > > I had the same idea previously. I initially just changed the hard=
 coded 256 / 8 to use 31 instead, which should have ensured the last entry =
of each segment never gets used.
 > >  > > When I tested that, it not longer failed, which was a good sign. =
So then I modified it to only do that on the last 256 byte segment of a pag=
e, but then is started failing again.
 > >  >=20
 > >  > Could you elaborate the "only do that on the last 256 byte segment =
of
 > >  > a page" part? How did you check which chunk of the page would be
 > >  > allocated before choosing the dma pool?
 > >  >=20
 > >  > > I never saw any bus error during my testing, just wrong data
 > >  > > read, which then fails image verification. I was expecting iommu
 > >  > > error logs if it was trying to access a chain in to nowhere if it
 > >  > > always interpreted last entry in page as a link. I never saw any
 > >  > > iommu errors.
 > >  >=20
 > >  > Maybe I misspoke, the "bus error" part was just my speculation, I
 > >  > didn't look at the IOMMU logs or anything like that.
 > >  >=20
 > >  > > I'd be glad to if you could share your testing method.
 > >  >=20
 > >  > I dumped all the nvme transfers before the crash happened (using
 > >  > tracefs), and I saw a read of size 264 =3D 8 + 256, which led me to=
 the
 > >  > chaining theory. To test this claim, I wrote a simple pci device
 > >  > driver which creates one IO queue and submits a read command where =
the
 > >  > PRP list is set up in a way that tests if the controller treats it =
as
 > >  > a chained list or not. I ran it, and it indeed treated the last PRP
 > >  > entry as a chained pointer.
 > > hmm, I guess a simple debugfs trigger file could be used to construct
 > > specially formulated requests. Would work as a debug tool.
 > >
 > > Though at this point, the simple dmapool alignment param usage fixes
 > > both of these scenarios, so it will be kind of academic to continue
 > > putting effort in to understand this. I am trying to get answers out
 > > of the vendor to confirm any of these theories, which I hope will be
 > > more conclusive than our combined inference from testing.
 >=20
 > Any updates on this? I'm satisfied with the quirk patch, so we can move
 > this forward if you're okay with the current understanding.
 >=20
apologies for late reply, I think this got missed during a holiday. Thanks =
for prompting on the previous thread.

I have no further updates on this. I have received no further info from the=
 vendor.
I think we can go ahead and use the alignment patch as is. The only outstan=
ding question was whether it is an
implicit last entry per page chain vs simple alisngment requirement. Either=
 way, using the dmapool
alignment fixes both of these potential causes, so we should just take it a=
s is.
If we ever get any better info and can do a more specific patch in future, =
we can rework it then.

