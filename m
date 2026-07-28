Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5103AC53219
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	References:To:From:Subject:Cc:Message-Id:Date:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJ/nTuQJbbmQA+I69e24WHFIsLja0SYLmGnNNyquQsQ=; b=Dt6Zj5DOmagoBhfXFOhMyLwNsz
	pb8iQbMO2Fdf15sKBQpdCTduL9w+LajWJmYCJ++JAVqzt93lEemd4J8QuNHTkBVGEkj9o8VWsAX+Z
	8zZD111N8wRxfw1tZkbwhY1s88lgDK+W5a1LRfmGMPvI8ngqtkz6ZYBR0Z/V+7XG8u6I+rGoFldnr
	Xrx5brTDYih4FIUOIz1s/mQckZnFK/bT1mdYbD3S/JBarNli2rDIQ68qh4T0A7gLU+yWFxgSTUws9
	tk5oqxyUc09mNaeUNzckUFDIyCDoDvz8cUzw7pFkGB8KCydC/cdy7SI4OkpuQA+KxOPNZxZcfq6fl
	VpA5JqJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wob9l-00000004WUK-1YKl;
	Tue, 28 Jul 2026 06:19:13 +0000
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wob9j-00000004WTv-0IhR
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 06:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785219545; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SJ/nTuQJbbmQA+I69e24WHFIsLja0SYLmGnNNyquQsQ=;
 b=KPx3oChIN9J2SOH0Kun7llWEVWUe2wqlbRZaDeqs4Ak0NC+aALiRTF9KgvpngfQQT8GlfW
 bfi1z31nv28Wxaj9K768HANBdpBrBqLK5PttvvJlBN2Y4H9MQtpCmCvqi6m28uzYCvl12g
 plqODxy5uhRZaxCYzH8eYIUQfqAv2AHPOvYfXDAmi0X0WAXHEVuSeFfI//Hi31r1/q+xX3
 1UintmFyXOHRltIYBRiOEuDA8UPaPHU44R1TXOVpTs8SEEeS069BRgZZ5jOErbb6Kfo/Kf
 fLULaU4Thnx51NSJxxP6CVTr4EQeuypls+PYU5D3/32EeFVoRUYeBhqPQOOv4Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 14:19:00 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.ff265e95.1296.491e.89f9.8ae888a03346@bytedance.com>
Cc: <linux-nvme@lists.infradead.org>, "Keith Busch" <kbusch@kernel.org>, 
	"Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, 
	"Sagi Grimberg" <sagi@grimberg.me>, 
	"Bart Van Assche" <bvanassche@acm.org>, 
	"Andy Shevchenko" <andriy.shevchenko@intel.com>, 
	"Thomas Gleixner" <tglx@kernel.org>, "Jun Zeng" <jun1.zeng@intel.com>, 
	"Gang Cao" <gang.cao@intel.com>, "Jun I Jin" <jun.i.jin@intel.com>, 
	"Liang A Fang" <liang.a.fang@intel.com>, "Yong Hu" <yong.hu@intel.com>, 
	<linux-kernel@vger.kernel.org>, "Guzebing" <guzebing@bytedance.com>
Subject: Re: [RFC PATCH] nvme-pci: adaptively poll completions on busy queues
From: "changfengnan" <changfengnan@bytedance.com>
To: "Christoph Hellwig" <hch@lst.de>
References: <20260723120556.58670-1-changfengnan@bytedance.com> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.2c741811.b6d1.4c47.8747.ba7d54957ca3@bytedance.com>
	<20260728044409.GA20140@lst.de>
In-Reply-To: <20260728044409.GA20140@lst.de>
X-Lms-Return-Path: <lba+16a6849d7+d719c8+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_231911_183778_CED172DC 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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


> From: "Christoph Hellwig"<hch@lst.de>
> Date:=C2=A0 Tue, Jul 28, 2026, 12:44
> Subject:=C2=A0 Re: [RFC PATCH] nvme-pci: adaptively poll completions on b=
usy queues
> To: "changfengnan"<changfengnan@bytedance.com>
> Cc: <linux-nvme@lists.infradead.org>, "Keith Busch"<kbusch@kernel.org>, "=
Jens Axboe"<axboe@kernel.dk>, "Christoph Hellwig"<hch@lst.de>, "Sagi Grimbe=
rg"<sagi@grimberg.me>, "Bart Van Assche"<bvanassche@acm.org>, "Andy Shevche=
nko"<andriy.shevchenko@intel.com>, "Thomas Gleixner"<tglx@kernel.org>, "Jun=
 Zeng"<jun1.zeng@intel.com>, "Gang Cao"<gang.cao@intel.com>, "Jun I Jin"<ju=
n.i.jin@intel.com>, "Liang A Fang"<liang.a.fang@intel.com>, "Yong Hu"<yong.=
hu@intel.com>, <linux-kernel@vger.kernel.org>, "Guzebing"<guzebing@bytedanc=
e.com>
> On Tue, Jul 28, 2026 at 10:24:52AM +0800, changfengnan wrote:
> > The patch showed 50 confirmed throughput improvements, with a median ga=
in of 25.2%
> > and a maximum gain of 63.0%. Only five cases showed confirmed regressio=
ns;
>=C2=A0
> Can you drill down into the regression and figure out why they happen
> and if we can mitigate them? =C2=A0It would be nice if we could find a wa=
y
> to avoid major regressions and enable the adaptive mode by default.

Of course, we=E2=80=99ll continue to investigate this issue to minimize per=
formance
regressions. As for enabling it by default, it=E2=80=99s too early to say=
=E2=80=94we need
more testing to verify this, such as seeing how it performs on Gen3/Gen4
NVMe drives.

>=C2=A0

