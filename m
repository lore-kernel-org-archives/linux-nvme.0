Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4595FC79F8C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Date:
	Content-Type:In-Reply-To:From:To:References:Content-Transfer-Encoding:
	Message-Id:Subject:Cc:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42eTvA3+zf7J2g0oBhjdgayHhzy7hkEc9NIuW1rhfg8=; b=YdRxcte/Shk6sbth+9X7zhqdne
	uBL1LXH/GDfiRUHDZhtoCc9ZnJlJKAF5reDWwkxai23zBkvjDhcOp7Fc6gerFm61Qx1hrqEoVfN+F
	GGB6kI2GiK93Bh91RKwfxZRvoS23NC9RMg4gJn8HT+7n+Bt6cZLGu/GywMRzKFqb4ZqA33vmT3yBR
	LG8fMgH6Kpd6CUG9xT8fnXA8GtCzpx1rNGKVQmkBWYwKAudGBKezBw0Wpg0bbaTx6HGa0SnUQu+4M
	mgAquo3yu4J676MC+h8IJh9TLoGpZp/F147Wz+EKwAdVET6P7/KjXK2U+rFCEImH9wmZ5Z3oBEd2B
	gPDrA99g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4E3C-0000000BCVk-2fzi;
	Wed, 09 Sep 2026 08:53:02 +0000
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4E38-0000000BCOz-0mAf
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 08:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788943968; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=42eTvA3+zf7J2g0oBhjdgayHhzy7hkEc9NIuW1rhfg8=;
 b=Va+nyMI1D+4ByyiJbOWpl2gpoaHAQ8ujhtZsJK1xUQugG0og0ecc4ZRTLwRXABcFx6qbix
 XW5CGjEYW6thywI31Y8NeTIbKv3v6Jv83k6CykBU66TPxuEzVGPrQk+dFHyeFK77p5GPDv
 cI0Ny+gp1xJqRt5lb0FVZ4CcCvkvF1GyFxQs1X3o6eCowGIjVk1en80FyBRW5FeB15Moee
 vKQRrhYUCqsS2qgixj89w1nyDWscaIvXdE0R1nPYpJZeAj0zIhhawUoDYuz6MkgyPFlHzf
 gWCI3zzY+3/DuJUgHCvvbLr1Vb81+U1vjyW/RVzFRrFcm3OHbQ2p7CAs2cHRQA==
User-Agent: Mozilla Thunderbird
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Marc Zyngier" <maz@kernel.org>, 
	"Luigi Rizzo" <rizzo.unipi@gmail.com>, "Paolo Abeni" <pabeni@redhat.com>, 
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, 
	"Bjorn Helgaas" <bhelgaas@google.com>, <netdev@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, "Guzebing" <guzebing@bytedance.com>, 
	"Keith Busch" <kbusch@kernel.org>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
Message-Id: <8e816cdc-a714-49d8-943f-677617682352@bytedance.com>
Content-Transfer-Encoding: quoted-printable
References: <878q5f5tlt.ffs@fw13> <aqD7FDvDhiEF_u0N@infradead.org> <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com>
To: "Luigi Rizzo" <lrizzo@google.com>, 
	"Christoph Hellwig" <hch@infradead.org>
From: "Fengnan" <changfengnan@bytedance.com>
In-Reply-To: <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com>
X-Lms-Return-Path: <lba+26aa11e5e+367040+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 9 Sep 2026 16:52:27 +0800
Mime-Version: 1.0
X-Original-From: Fengnan <changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_015258_319345_54151890 
X-CRM114-Status: GOOD (  20.30  )
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

=E5=9C=A8 2026/9/9 16:06, Luigi Rizzo =E5=86=99=E9=81=93:
> On Wed, Sep 9, 2026 at 8:25=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>> On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
>>>> it appears that GSIM is only effective in scenarios where multi disks =
at very high
>>>> IOPS; in some cases, there was a noticeable performance regression.
>>>> If there=E2=80=99s something wrong with my configuration, please corre=
ct me.
>>> So we have a NVME specific mechanism to tackle the same problem and a
>>> more generic version which is subsystem "independent".
>> I'm not sure they tackle the entirely same problem, although they are
>> very related.
> There is overlap but it is accidental.
> The difference between the two mechanism is the following:
>
> - GSIM addresses hardware limitations (SoCs that create huge PCIe
>    backpressure on each MSIx interrupt, eventually reducing the available
>    bandwidth too much, regardless of how many CPUs can process interrupts=
).
>    The goal here is to throttle the total MSIx rate, blocking them at
>    the source (PCIe device) rather than later in the interrupt controller=
.
>
> - the NVME mechanism (and NAPI) aim to amortize interrupt processing
>    overhead. It does so by recreating some fine grained single-source
>    interrupt moderation (something that NICs do in hardware, but NVME
>    does not, with 100us being way too coarse for modern SSDs) and an
>    adaptive scheme to adjust the delay and decide when to kick in.
That's a great summary.

As for generic solutions, I've tried several approaches before, but none=20
of them
could achieve the same or close results as NVMe adaptive interrupt polling.
I'm still experimenting with different options.


>
> I think there is a reason for both.
>
> GSIM because it is more general and addresses an issue the others cannot =
handle
> the subsystem-specific scheme because they can be more efficient
> (eg they can hook into existing helpers like the threaded irq handler,
> call directly the handler without going through the full irq chain,
> use more targeted heuristics to decide when to kick in).
>
> cheers
> luigi

