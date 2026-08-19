Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7722CC5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:
	Content-Transfer-Encoding:In-Reply-To:References:Mime-Version:From:Cc:
	Message-Id:Content-Type:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rqCVnzS/NPfiWjrhbZkLQ3VkJuSaz5Zu2kIHduRdAKg=; b=MZ80XdiQsytkCu
	xdefhJBs1xeXs/3iQixUfZ+25oj8/u0Wm+zWmejo28PjwqidaNhpq84M3vDQiuQIyH/2dVVPYLcPX
	yuWc8jwtBXfRj81gc5xg7XHnP304nAVnicCSGZLkpQoNy0tLvWBuZ3tBElxokIZjdpE1UWLPLKjR9
	9YQ+KJd/7TuhQgbyqL5AoGsJ52CwlpmQrmqzKRfCMYqKl38kZ001lxlYmcfupm8R2y8f0yJnVs8ic
	wOapNGZHN29YoFnW3DKF4/4b1a9el9DC1SURKLH7FwPm73VixM1crAuUqLJL3ZS+IAWmoHxN8cmnn
	lEw4a1QLGGo393Q0E8RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZsO-000000096a0-1BvO;
	Wed, 19 Aug 2026 06:34:16 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZsJ-000000096Z9-3zvP
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 06:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787121242; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rqCVnzS/NPfiWjrhbZkLQ3VkJuSaz5Zu2kIHduRdAKg=;
 b=OmPJfq6YtvXUlii1glvo+sIXx2zblXqs73BvD/nGza1iqzU8l+czq0JIUA6DT6OV6k3AdZ
 nA+qMHHbmQQ9NKcIO0uAmeYBdnnvmCL1nl84QmIdqZyJ/zvRJ2QwgBxG1rAAFU6Tm+aAi3
 yz4A+q02W3tNJPvD3OPIMyWGORqM4cHsBGEJOAMzQ+fR2YcXKULVAMsFnvTYagL6zMpf/R
 4AT6zX4M2ourmUOxzYRD4LyALt0hG8AZ3RknCCLXF4G2y0TNoyC9Ja+tX9QzycQPbPUl6Z
 PmW+yzLHemiiyWWBzRpQTe0ZcgIhMWK7Gc0FnKy9pNumvExo/kwD0GWDXTYvEg==
Subject: Re: [PATCH] nvme-pci: add adaptive interrupt polling
X-Lms-Return-Path: <lba+16a854e58+dd0286+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.24f615b7.8a6c.4015.8a82.6921eb95e609@bytedance.com>
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, "Guzebing" <guzebing@bytedance.com>
From: "changfengnan" <changfengnan@bytedance.com>
Mime-Version: 1.0
References: <20260818033846.53790-1-changfengnan@bytedance.com> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.c71e295f.cf49.450b.ad13.ed0e27cd481a@bytedance.com>
	<20260819052517.GB32364@lst.de>
In-Reply-To: <20260819052517.GB32364@lst.de>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 14:33:57 +0800
To: "Christoph Hellwig" <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_233412_332186_43221ECB 
X-CRM114-Status: GOOD (  13.56  )
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
> Date:=C2=A0 Wed, Aug 19, 2026, 13:25
> Subject:=C2=A0 Re: [PATCH] nvme-pci: add adaptive interrupt polling
> To: "changfengnan"<changfengnan@bytedance.com>
> Cc: "Keith Busch"<kbusch@kernel.org>, "Jens Axboe"<axboe@kernel.dk>, "Chr=
istoph Hellwig"<hch@lst.de>, "Sagi Grimberg"<sagi@grimberg.me>, <linux-nvme=
@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <jun1.zeng@intel.com=
>, "Guzebing"<guzebing@bytedance.com>
> On Tue, Aug 18, 2026 at 11:53:55AM +0800, changfengnan wrote:
> > 1. Regarding the NVME_ADAPTIVE_POLL_PERIOD_NS parameter, is it necessar=
y to make it a configurable setting? Perhaps Gen6 SSDs require a smaller va=
lue? I currently do not have a testing environment for this, but the defaul=
t value of 10 us appears to be sufficient for Gen4 and Gen5.=C2=A0
>=C2=A0
> The most important thing to consider in the short term is not the fastest
> possible devices, but the worst. =C2=A0I.e. consider what this does on re=
ally
> crappy older cusomer drives, as that is probably the biggest install base
> using the Linux nvme driver.
That makes sense, we also need to see how it performs with consumer-grade
NVMe drives. I only have an old Samsung 970 NVMe here, so I don=E2=80=99t h=
ave
much of a testing environment for consumer-grade NVMe drives.=C2=A0
I hope someone can help me test it out :)

>=C2=A0
> > 2. Should MSI be supported? I do not have a similar environment, so I a=
m unsure how it would perform in such scenarios.=C2=A0
>=C2=A0
> Or legacy interrupts :) =C2=A0I don't think we have to support them as lo=
ng
> as we cleanly disable the feature.
>=C2=A0
> > 3. Should it be enabled by default? Although current tests show only a =
minor performance hit, I still lean toward disabling it by default and wait=
ing to gather more test feedback.
>=C2=A0
> I think it should eventually enabled by default, but I'd also be happy
> to merge it fist and then flip the bit later.
>=C2=A0

