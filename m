Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25FAC79F8B
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2026 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hwgSr9LF1AaQKstntdYXF4tsMbm8X5Lx15fwX+9hr5k=; b=ABBi6vPPCHcx7s/A6ir5sAwrsm
	WcILWJIkNxA2SkZal7Bwym/sGnI+jNUYBVLMkbbEFtxl7vNItsGxvZpaQBQgEVlEOwCLlsRu02BK6
	gefb90EtpFsSaLyUm5A3DRBrSGLti8xmcDs5P5QPvknDS8JCTtXSABhHoRF7qtb4+A9agZL5ktLd0
	fGL/MVFfk+EMv9NUmEi78NSIQXXsb2e3N87n5ORAYFgi8/MN7zaOOlMzIFLxsxSiW/tFvWKdZ6prj
	MSAKCOImjwsvIzG6bo+kHbEQ1iSnkH6rhAlAT/yTampR4uSnZpYbWqL+t83W4S35i/acVnhwrw5K8
	oNvXmpkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2x21-00000004OoU-1yEs;
	Sat, 05 Sep 2026 20:30:33 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2x1v-00000004Oo2-1cx9
	for linux-nvme@lists.infradead.org;
	Sat, 05 Sep 2026 20:30:28 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788640223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwgSr9LF1AaQKstntdYXF4tsMbm8X5Lx15fwX+9hr5k=;
	b=skPCZuyWro0VW6391LtWlzrr/B1W1w/re6wD9oT3npVcauGo05kkwL78ny2VUxbQ4h4nbp
	cj5IQ+1A4obQd3tT2NMZcEwGhi0c5VkXgIW/swYV/fKuOcb60G6nAD8BMfDY97pE5EUxdz
	N+J4pmuFMOZgRS3xtYHK/ZLzjFjp1dz85hlulDsMZKKwBjhzlReZuhzkcRzKmSkLjNUSNz
	p/+UYHaNiWMKrbJoxMk+kuMyrENVwuJh78/3RcXtrncBlBwN8CAy2nzvj42sWOKRkXJG8U
	2zmQrWEee/uqKDmY/58HJDUl+wCj1r8M31dMqCCj0QvWtKV3vswOf73AZpTpNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788640223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwgSr9LF1AaQKstntdYXF4tsMbm8X5Lx15fwX+9hr5k=;
	b=xClnT4gxHr/HnwlWOjClcB0G5DjEE+jqWtE0d0pRDLr92cUPXaH+71Z+zm3v2cOwKwImZi
	iqdeo1gS0rmQ50CQ==
To: changfengnan <changfengnan@bytedance.com>, Luigi Rizzo <lrizzo@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.65629680.37f4.46ab.be84.09ae39446f28@bytedance.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <aoaoERD5m1MNvMWd@infradead.org>
 <CAMOZA0JrLia8NU1-4JEJAe+p65C19HsRGU6VK7sLAjNFKm8G3w@mail.gmail.com>
 <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.65629680.37f4.46ab.be84.09ae39446f28@bytedance.com>
Date: Sat, 05 Sep 2026 22:30:22 +0200
Message-ID: <878q5f5tlt.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_133027_576851_7CE134E2 
X-CRM114-Status: GOOD (  15.36  )
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

On Thu, Aug 20 2026 at 19:46, changfengnan@bytedance.com wrote:
>> From: "Luigi Rizzo"<lrizzo@google.com>
>> Date:=C2=A0 Thu, Aug 20, 2026, 15:35
>> Subject:=C2=A0 Re: [PATCH v5 0/7] Global Software Interrupt Moderation (=
GSIM)
>> To: "Christoph Hellwig"<hch@infradead.org>
>> Cc: "Thomas Gleixner"<tglx@linutronix.de>, "Marc Zyngier"<maz@kernel.org=
>, "Luigi Rizzo"<rizzo.unipi@gmail.com>, "Paolo Abeni"<pabeni@redhat.com>, =
<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Bjorn Helgaas=
"<bhelgaas@google.com>, <netdev@vger.kernel.org>, <linux-nvme@lists.infrade=
ad.org>, "Fengnan Chang"<changfengnan@bytedance.com>
>> On Thu, Aug 20, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:

Can you please fix yuur mail client so it does not copy all that
redundant headers into your reply?

>> > Also how does this interact with adaptive polling code inside drivers
>> > like NAPI or the upcoming nvme variant?
>>=C2=A0
>> GSIM acts at hardirq level (so below NAPI, and above device moderation e=
.g.
>> the one in ethtool -C ...) and is completely orthogonal to those other
>> mechanisms.
>
> Hi Luigi:
> The NVMe variant that Christoph mentioned is this patch of mine.
> https://lore.kernel.org/linux-nvme/d9210bcdf73fbe1ac8b6ec132865609a3ed686=
88.99d43a8b.dfff.41d1.b07d.0592a12473d2@bytedance.com/T/#m561d1366119620556=
41f331e600e719de1e7c573
> I took a quick look at your implementation, and I wouldn't say our two
> approaches are completely independent.
> I=E2=80=99ve run some tests, the test methods, environment, and data are =
detailed in
> this document:
> https://docs.google.com/spreadsheets/d/1p3XqVpKgx18QhqTFb0KlJfEW9giWDGSUu=
oKqCZzdZLg/edit?gid=3D1100001004#gid=3D1100001004
>
> it appears that GSIM is only effective in scenarios where multi disks at =
very high
> IOPS; in some cases, there was a noticeable performance regression.=C2=A0
> If there=E2=80=99s something wrong with my configuration, please correct =
me.

So we have a NVME specific mechanism to tackle the same problem and a
more generic version which is subsystem "independent".

Can you folks please coordinate and get your act together so that we
don't end up with two competing mechanisms which make things worse than
they are now.

TBH. I despise the NVME is special approach because it's fricking
obvious that this is _NOT_ a NVME specific issue. But sure NVME is
special as all other subsystems are special.

Q: When do driver folks actually start to look beyond the brim of their
   tea cup?

A: Probably never ...

Thanks,

        tglx

