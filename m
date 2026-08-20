Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A6AC5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Cc:Message-Id:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:From:To:Date:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QQMRgjIibLl1JqINvilQY7T1UaQ3NOog3eoWf7E/GEA=; b=fi55KP/M5Zq6M9VRhaR0OxetyP
	6SRoa4ltq6k/AhFg4Yp+kSSRCXskzbVPYQuJ1YSyiLujj2MYMynr/NC+7G822GTWK5nlt44ATDqz7
	cjj0yhHwtG7qeQUePdXMszaI00B8xYm8Dlf6mz4gRCooP2BI4GteOBb2dsnD9agMCFKQMPIMwhEhO
	YDvUfj3vSzT+f/T6sCPwYvlYcDUp4KFDMGbApiNn0kHYZohDKqLHwwOJssvtH3X9q8m99gB2cF5hR
	Z718nGjYwJI+AoO7+f24jf33HO7ET/hAtzFDAwq2FjFfvOWWJSOJzaUbjntlVx5cx7DUeKHocYtyP
	9+M5WxFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx1Eb-0000000BTjP-3u5Y;
	Thu, 20 Aug 2026 11:47:01 +0000
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx1EY-0000000BTie-2gRg
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 11:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787226409; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QQMRgjIibLl1JqINvilQY7T1UaQ3NOog3eoWf7E/GEA=;
 b=VQ7zLmUY4d3+BcKQwJbvRyGzkzx8atYIsa+V3lD8B2963VdVD+3dK1s/QnneT6GQY9HLcQ
 JmeofXghfkdv+N18nVo2qBR7skrOPQbZPWar3zrtwi0Lg02oQp0vhw7YXjJSzCED1BRUuS
 e8prFXpM+S7yccceGdaQAADn2p0AIOK7Th87uhMFDKDvfIf7ypu3i14q0xINd1xav1SWeq
 hB4+0Xk+NKkQ2cUyq5RcCxsGDVtISRULs7l8RhR5KfvpvRsiC1vaSFQc/Z5WPI/xFamkQy
 +IeJdSNN0dDD0h8Ig/TJjEAkSw0HMCNSAotC6ThT69ugIE5YyTkDZeT71Y8wEw==
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a86e927+bbb25d+lists.infradead.org+changfengnan@bytedance.com>
Date: Thu, 20 Aug 2026 19:46:45 +0800
To: "Luigi Rizzo" <lrizzo@google.com>
From: "changfengnan" <changfengnan@bytedance.com>
In-Reply-To: <CAMOZA0JrLia8NU1-4JEJAe+p65C19HsRGU6VK7sLAjNFKm8G3w@mail.gmail.com>
References: <20260819124341.4185621-1-lrizzo@google.com> <aoaoERD5m1MNvMWd@infradead.org>
	<CAMOZA0JrLia8NU1-4JEJAe+p65C19HsRGU6VK7sLAjNFKm8G3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.65629680.37f4.46ab.be84.09ae39446f28@bytedance.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, 
	"Thomas Gleixner" <tglx@linutronix.de>, "Marc Zyngier" <maz@kernel.org>, 
	"Luigi Rizzo" <rizzo.unipi@gmail.com>, "Paolo Abeni" <pabeni@redhat.com>, 
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, 
	"Bjorn Helgaas" <bhelgaas@google.com>, <netdev@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_044658_926407_36063297 
X-CRM114-Status: GOOD (  25.26  )
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


> From: "Luigi Rizzo"<lrizzo@google.com>
> Date:=C2=A0 Thu, Aug 20, 2026, 15:35
> Subject:=C2=A0 Re: [PATCH v5 0/7] Global Software Interrupt Moderation (G=
SIM)
> To: "Christoph Hellwig"<hch@infradead.org>
> Cc: "Thomas Gleixner"<tglx@linutronix.de>, "Marc Zyngier"<maz@kernel.org>=
, "Luigi Rizzo"<rizzo.unipi@gmail.com>, "Paolo Abeni"<pabeni@redhat.com>, <=
linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Bjorn Helgaas"=
<bhelgaas@google.com>, <netdev@vger.kernel.org>, <linux-nvme@lists.infradea=
d.org>, "Fengnan Chang"<changfengnan@bytedance.com>
> On Thu, Aug 20, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Wed, Aug 19, 2026 at 12:43:34PM +0000, Luigi Rizzo wrote:
> > > Configuration is easy and robust. System administrators specify the
> > > maximum targets (moderation delay; interrupt rate; percentage of time
> > > spent in hardirq), and which interrupt sources should be moderated.
> > > Independent per-CPU control loops adjust actual delays to try and kee=
p
> > > metrics within the targets.
> >
> > Can we find a way to autodetect and autoenable this? =C2=A0A magic go f=
aster
> > mode that needs very specific tuning is annoying compare to sensible
> > defaults.
>=C2=A0
> As mentioned later, the tunings do not need to be specific,
> because the control loop adjusts the delay to stay within the target,
> and the target is generally just a "don't overload me" value with little
> impact on performance.
>=C2=A0
> Of course there are many cases (eg small systems with little I/O) where
> moderation is not needed at all so at least one bit of user input is nece=
ssary.
>=C2=A0
> What I normally do is use another small patch to pass the initial setting=
s via
> module parameters, using values similar to those below
> (enable on all interrupts, delay_us=3D100, target_intr_rate=3D1000000,
> hardirq_percent=3D70)
>=C2=A0
> > Also how does this interact with adaptive polling code inside drivers
> > like NAPI or the upcoming nvme variant?
>=C2=A0
> GSIM acts at hardirq level (so below NAPI, and above device moderation e.=
g.
> the one in ethtool -C ...) and is completely orthogonal to those other
> mechanisms.

Hi Luigi:
The NVMe variant that Christoph mentioned is this patch of mine.
https://lore.kernel.org/linux-nvme/d9210bcdf73fbe1ac8b6ec132865609a3ed68688=
.99d43a8b.dfff.41d1.b07d.0592a12473d2@bytedance.com/T/#m561d136611962055641=
f331e600e719de1e7c573
I took a quick look at your implementation, and I wouldn't say our two
approaches are completely independent.
I=E2=80=99ve run some tests, the test methods, environment, and data are de=
tailed in
this document:
https://docs.google.com/spreadsheets/d/1p3XqVpKgx18QhqTFb0KlJfEW9giWDGSUuoK=
qCZzdZLg/edit?gid=3D1100001004#gid=3D1100001004

it appears that GSIM is only effective in scenarios where multi disks at ve=
ry high
IOPS; in some cases, there was a noticeable performance regression.=C2=A0
If there=E2=80=99s something wrong with my configuration, please correct me=
.

Thanks.

>=C2=A0
> If NAPI etc manage to keep the interrupt rate/load below the targets,
> then the adaptive controller in GSIM ends up using zero additional delay.
> Otherwise, it gently adjusts the moderation delay so the combination suff=
ices
> to stay within the target.
>=C2=A0
> All the above assumes the parameters are sensible.
> GSIM or any HW moderation allows up to 1/delay_us interrupts per second, =
so
> setting delay_us=3D10 allows up to 100Kintr/s per CPU handling interrupts=
,
> so there is no way we can throttle interrupts below 100K/s)
>=C2=A0
> >
> > >
> > > The system is adaptive. Moderation affects only latency and only in
> > > high load scenarios. =C2=A0Throughput and CPU efficiencly generally b=
enefits
> > > significantly. =C2=A0Targets don't need to match precisely the platfo=
rm
> > > limits, and one can make conservative and robust choices. Values like
> > > delay_us=3D100, target_intr_rate=3D1000000, hardirq_percent=3D70 are =
a very
> > > good starting point.
>=C2=A0
> cheers
> luigi
>=C2=A0

