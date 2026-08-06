Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F9CC55174
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 03:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Mime-Version:
	Message-Id:Date:Content-Type:In-Reply-To:From:Subject:Cc:To:
	Content-Transfer-Encoding:Reply-To:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85V3nY+XIMXyXfOpOdYNnkw5ZJRwFN68jLARzrGksbE=; b=d/INJscZjCUQOJVCL3TnDuJab3
	uxIKVF9bc4KLmbqiEqW36xy2KQSlkN4dTqvVRkVpRClmKHmIc2o8CxbvE//Iwq3buJx4xYWQQcwgO
	Np+QFeIjxDEo/+f7D7AuTYSv6IZIJcBOiwbc4+oi14jpHmaZmqRfdPxFzi0W5BqTJfF2l4jSsNI/v
	Jr+yPpBtEQRst0DGI5+e9jnBY4jpg2+H+ajph0MwTf/Zro5PH+2L4zE2J9yFXSS2ym0PFMR4OQ1lG
	SfhDTLgtMPBsTAsTDJdid1JcEe3q5sVFksqxGY0kmWZQRcW6vL+DkWXGJWZ6I/hScnQovtNusA/qy
	j6YR5fIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wroXd-00000004rSO-2Geb;
	Thu, 06 Aug 2026 03:13:09 +0000
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wroXa-00000004rRb-0oOq
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 03:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785985979; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=85V3nY+XIMXyXfOpOdYNnkw5ZJRwFN68jLARzrGksbE=;
 b=glolzkWdPQ/3tOHXpf7AOLLXi+9XbycvDZqAnIkyC+7RbaA+hR2tudlb2eQgfNTyMj0iMv
 Apg78g3O2NTNGUOgTWjXO8vCG9SaDqQMsfGNnNBSQlxRsznLa2KXKonhEY+azM3J9chVdH
 k1Ll62f79bYe5+JKzwcLjd1hcyH2wwDs6zXp2dqqqav35cewgl5Xlb4m+73EB007ODm9QL
 h2DNAD9c9jTNe5nBpr0HmqUGhbifpVqeSHg/ou9Gv0C1yyCUjxzowqj4vA9LjLg0ojsVDE
 u7grMS4b4cFULvLDcWZgQT2T94mNApkSPzEcAylUHth/JVpDAB1fHed22vUx2A==
Content-Transfer-Encoding: quoted-printable
To: "Christoph Hellwig" <hch@lst.de>
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
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.ff265e95.1296.491e.89f9.8ae888a03346@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 11:12:55 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.438d5c5b.1fc9.44ab.ac94.2c29a4116bde@bytedance.com>
Mime-Version: 1.0
References: <20260723120556.58670-1-changfengnan@bytedance.com> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.2c741811.b6d1.4c47.8747.ba7d54957ca3@bytedance.com>
	<20260728044409.GA20140@lst.de>
	<d9210bcdf73fbe1ac8b6ec132865609a3ed68688.ff265e95.1296.491e.89f9.8ae888a03346@bytedance.com>
X-Lms-Return-Path: <lba+16a73fbb9+a7f476+lists.infradead.org+changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_201306_296638_70464C0E 
X-CRM114-Status: GOOD (  14.05  )
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


> From: "changfengnan"<changfengnan@bytedance.com>
> Date:=C2=A0 Tue, Jul 28, 2026, 14:19
> Subject:=C2=A0 Re: [RFC PATCH] nvme-pci: adaptively poll completions on b=
usy queues
> To: "Christoph Hellwig"<hch@lst.de>
> Cc: <linux-nvme@lists.infradead.org>, "Keith Busch"<kbusch@kernel.org>, "=
Jens Axboe"<axboe@kernel.dk>, "Christoph Hellwig"<hch@lst.de>, "Sagi Grimbe=
rg"<sagi@grimberg.me>, "Bart Van Assche"<bvanassche@acm.org>, "Andy Shevche=
nko"<andriy.shevchenko@intel.com>, "Thomas Gleixner"<tglx@kernel.org>, "Jun=
 Zeng"<jun1.zeng@intel.com>, "Gang Cao"<gang.cao@intel.com>, "Jun I Jin"<ju=
n.i.jin@intel.com>, "Liang A Fang"<liang.a.fang@intel.com>, "Yong Hu"<yong.=
hu@intel.com>, <linux-kernel@vger.kernel.org>, "Guzebing"<guzebing@bytedanc=
e.com>
>=C2=A0
> > From: "Christoph Hellwig"<hch@lst.de>
> > Date:=C2=A0 Tue, Jul 28, 2026, 12:44
> > Subject:=C2=A0 Re: [RFC PATCH] nvme-pci: adaptively poll completions on=
 busy queues
> > To: "changfengnan"<changfengnan@bytedance.com>
> > Cc: <linux-nvme@lists.infradead.org>, "Keith Busch"<kbusch@kernel.org>,=
 "Jens Axboe"<axboe@kernel.dk>, "Christoph Hellwig"<hch@lst.de>, "Sagi Grim=
berg"<sagi@grimberg.me>, "Bart Van Assche"<bvanassche@acm.org>, "Andy Shevc=
henko"<andriy.shevchenko@intel.com>, "Thomas Gleixner"<tglx@kernel.org>, "J=
un Zeng"<jun1.zeng@intel.com>, "Gang Cao"<gang.cao@intel.com>, "Jun I Jin"<=
jun.i.jin@intel.com>, "Liang A Fang"<liang.a.fang@intel.com>, "Yong Hu"<yon=
g.hu@intel.com>, <linux-kernel@vger.kernel.org>, "Guzebing"<guzebing@byteda=
nce.com>
> > On Tue, Jul 28, 2026 at 10:24:52AM +0800, changfengnan wrote:
> > > The patch showed 50 confirmed throughput improvements, with a median =
gain of 25.2%
> > > and a maximum gain of 63.0%. Only five cases showed confirmed regress=
ions;
> >=C2=A0
> > Can you drill down into the regression and figure out why they happen
> > and if we can mitigate them? =C2=A0It would be nice if we could find a =
way
> > to avoid major regressions and enable the adaptive mode by default.
>=C2=A0
> Of course, we=E2=80=99ll continue to investigate this issue to minimize p=
erformance
> regressions. As for enabling it by default, it=E2=80=99s too early to say=
=E2=80=94we need
> more testing to verify this, such as seeing how it performs on Gen3/Gen4
> NVMe drives.

Now I can answer this question: When QD=3D33/34, after one or two CQEs are
processed, the number of pending commands is exactly 32, so the system
enters a polling state. However, the number of pending I/O operations does
not guarantee that the CQ will refill quickly. On Samsung drives, the CQ
typically empties after one round of processing. At this point, `fsleep(20)=
` is
called, so new CQEs must wait when they arrive. This delays CQE processing
and causes IOPS to drop. At higher QD, on the other hand, keeps the CQ
sufficiently full, making polling more efficient. Simply adjusting paramete=
rs
does not solve the problem, because this approach confuses the number of
in-flight I/Os with completion density. A high number of in-flight I/Os doe=
s not
necessarily mean that using poll=C2=A0 is more efficient.=C2=A0
Therefore, we developed an alternative solution to address this issue.
https://lore.kernel.org/linux-nvme/20260806031058.40176-1-changfengnan@byte=
dance.com/T/#u
>=C2=A0
> >=C2=A0

