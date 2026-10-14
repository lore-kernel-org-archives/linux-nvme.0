Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65734CC6B24
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 22:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eY3sf91LWak23dQ/GXfxAKMlelY/K2zut7QOmicKyVo=; b=WYcYsPbyBIIFQ+mjkb5InbFjZU
	iubsehbhJGBsrsm4Z3qRTcSS1csU9Zfd53KVk24EXGtcbTlA97/FHQlk4lWpDNdK/swIw+bX4Lma/
	yVCEwbW+/axBpsD4RMhV1T7nArOtKNii0f5K7LiNhVTFFLC/vk4IjAhoZaLj1dX5JHEal1rIEfvoR
	F9vKtbm8SeLqZcyXQgr7Xr3xL0mwstaWxMP7i31dfSQ/SxQDL9BaIPcmzI5uw1RADFVdDk31ZPO8L
	Tky6FCVXdsxazy3T3sQab6536T22qbbZz5E7SoeQn1P+dHxxXzsDJI0TZcPpjiH4EWSW6lYBoWisx
	4ekDRgUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH7J4-0000000GOhr-3QSB;
	Wed, 14 Oct 2026 22:18:42 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH7J2-0000000GOhT-0cvs
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 22:18:41 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e8623790f8so3595ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 15:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792016318; cv=none;
        d=google.com; s=arc-20260327;
        b=KOtpePyab0aaoOl/ZirvN3pVFbuE+sW0scyu0UAg+eIDpr441p7PY19lhFs2QI8OWk
         0sqGambyDAuTRmmoj4bRegwb8uiu1zMyv1f5TVCt3VYYtJ/pWv4JOFErKKlQxNJ1zMo7
         5eILcKQYZi3Nseli/H6fp2LsdZRwe/pRmvxphJpHGq/0QUfCtxBkEETpotu6vrhPTYZQ
         54DGwrusjVaw/FyqS97GGB5m3QOW3hty7bMBlyPtlarZg4sZgbzI4UqLMY/mV45l5S3z
         cbZ5tS/ezoWUDnnK82rdj+CPd0aFxzCkKyMRbGZlutM98aZw57Pj14pfmFCNtmD9hU7u
         t8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eY3sf91LWak23dQ/GXfxAKMlelY/K2zut7QOmicKyVo=;
        fh=It4g3z/1F5xI2fRMMGB/8lQyVldNAe9j+0m/L/+AAEc=;
        b=Wqv1Jml2I+FqVYblOd/CHLsvdMTqorj9y4BNjP/0OHm2QoKRS4YdLsEtOu5yH1wIGZ
         1+lwTNDsmNSsdAVTxkhGYRGF53gpRHj2Cp7pzpUfLWL6gLOWZcVotHBU5F5y9J2vdFLK
         Grje7didtBo2RBTkhqNsALrQfQlQYe8cNfff2sFDNIovvNZO5yYpoEa+zcbWKWp1TW/R
         0qXHgq76QFTAb5nT0qS3FIXZbu/DCiZq0IWvKIDBGyCs9EzZOPs/TKPArslkD/XvYmUp
         H8mXMBCwlXmSuUkclCkZxaNyTQ/cES6CFlkXFF5M1vrdOvxuQvNHo6ueJeZUY7XM259g
         yuZA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792016318; x=1792621118; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eY3sf91LWak23dQ/GXfxAKMlelY/K2zut7QOmicKyVo=;
        b=dUYR1TUApnAMW2rxcp4YtJgYrTneQJIRHhW4PZxghIwwb+FsOpdX13Xkl4KO/WuVnC
         CBNS0goWHGTnnS9X/AHj0FIV5ISx02bYx4WN1feFsYakiX3dt5v+4eQJr3Aj37bD6QTd
         WXkuPKDQQ4fB7/kRoedR6YSCncjkbC7S1NbMn+Cz7tYNiF0KACAMfNrYtPkNNsseiU63
         57+VrPG0oqs6+/zQRgj43gcU+vR0LbT1kghoFkrbPA5+u/Lld56kHpRhmVXfwhrQSUmq
         +eKkNnsV+pRzcTyPaY9EDENt0mchxM6q9kya+Cq7cstrbOuRiAaRHctkVS30YfOwMFmW
         n8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016318; x=1792621118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eY3sf91LWak23dQ/GXfxAKMlelY/K2zut7QOmicKyVo=;
        b=tLQB2jPvqg2LvDKcse5mM+tfiZYB5vQp6BEGOu+ZoG7+u/kSyjerqwEXxXbsdKgPVp
         wboAC5Wg4ZNgu4jH+vgdaYn++KVWkdf/heyl2HJdsdCn5H74E1jHYtlvefdbEH7mxw0g
         3nCX+7pwVbaBUAlAn/DVrpThUHVEhKNL3PiZ7saxpBz9n9KxMvb6Fg3WV6LWJnJ9hogh
         x766/eTu40pahfKgyyGhDyp88da6TN94dbejPgErwXqWtQOzDwV08XBmaDUC9lk5E8A4
         8PGO+wa8QJp0CvYIJ88ISufxacjAIdvvMui6XbzyximMlRiUafxE3QKV2Dnlb92apkR1
         tAnA==
X-Forwarded-Encrypted: i=1; AKwUvBwxuju+2Rmb4jPDMjjcmlPyEOq9o8ZoHTWd6ql1BOQlz7aSsxuA9HoTi8eODp9CLiYf3FNhhFE9smbc@lists.infradead.org
X-Gm-Message-State: AFq9FYJ0/kgkomFG2ltsvolcmjT9ZSYDHgSVIinYFjzPNa6f5WbP3byh
	zhj+/EX6dhvp8Y0E6UyUqs6EpMLLJFS/HiclqzkKkplAWcY3vyPkQ2sQiJiOqqCFX+TGeF+BY32
	q3BYR2IAEb1XH3dEDZGIqs0kqC/vJG4jg7nFJ0Kwz
X-Gm-Gg: AYBFou3NRufb2Zd+zUrC1tId+kl1GiEOjokRImQ/TIQDm310rXRzcBaWY9t6G5oO7OT
	FwVUFujeV4xjHotztJwWN6wyO4pO6Ky1UnfY9cILhRiYBMoBSN/v9N7b91fU6AsgOhXBRqcLJ3H
	cu2sQ8i42hD7y+/KVPqtMbckLvGU7dKEBJHhqXhvZboCl+KNlr0ZweIGwN1WDP6THfmCajzDdZ6
	ugqYCtt+mD6pfhaGhSTaDLMtWBeWm8yTQdQzuIWlr1VnDVFBa+KI36Jl1Eksf0YLxLIpRpHpA9J
	guMdWWnPLCkvEEFVouZRFzJEH20MB4ek2jFVeV/VFyJNjwAhIlYJIOQO
X-Received: by 2002:a17:902:e542:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2e95caacd1amr603715ad.1.1792016317765; Wed, 14 Oct 2026
 15:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261014173106.GA1643226@bhelgaas> <878q40f0oa.ffs@fw13>
In-Reply-To: <878q40f0oa.ffs@fw13>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 15 Oct 2026 00:18:00 +0200
X-Gm-Features: AclHuK-gNlStewG6l-QH68p1JXoWsj7TI1jcaI93dXV8erEDnLAEYXepoL4jjGM
Message-ID: <CAMOZA0+N10HW1VGpMEA94smNdL4VFy-2nHti52U6Fm_SN1OR-g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
To: Thomas Gleixner <tglx@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, 
	hch@lst.de, changfengnan@bytedance.com, linux-pci@vger.kernel.org, 
	namjain@linux.microsoft.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_151840_221020_AD978DAC 
X-CRM114-Status: GOOD (  24.65  )
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

On Wed, Oct 14, 2026 at 11:10=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Wed, Oct 14 2026 at 12:31, Bjorn Helgaas wrote:
> >> Skip the read-back that flushes the MSI-x mask write. Parent domains
> >> that mask on behalf of PCI/MSI continue using their own irq_mask().
> >>
> >> Signed-off-by: Keith Busch <kbusch@kernel.org>
> >
> > I assume Thomas will review/ack the pci/msi/ parts.
>
> Yes. I actually suggested that "nowait" mechanism to Keith at LPC.

The topic also came up around last December. The readback wastes 1000-1500n=
s
under load. I hacked a conditional in pci_msix_mask()
https://lore.kernel.org/all/20251220193120.3339162-1-lrizzo@google.com/
and you suggested a callback irq_mask_dev calling pci_irq_mask_msix_lazy()
https://lore.kernel.org/all/87jyxqiuta.ffs@tglx/

As usual naming is the hard part...

The mechanism is definitely useful (with moderation the mask is a frequent
operation, so saving the extra 1-2us per call is measurable).
I was a bit worried about adding yet another callback, but there are
already 30 or so,
hence one or two more does not make much of a difference.

On passing, on ARM this will not help unless we partially revert the
optimization
that skips PCIe if the interrupt has MSI_FLAG_PCI_MSI_MASK_PARENT
https://lore.kernel.org/all/20250517103011.2573288-1-maz@kernel.org/

> Though I hate the name of that callback because irq_mask() does not
> really wait. It guarantees that the mask store has reached the device
> which means that after that point no further interrupts will be sent by
> the device (assuming sane hardware). That means it's a synchronous
> operation which involves flushing the store, so maybe irq_mask_noflush()
> or irq_mask_async() might be more accurate and descriptive.
>
> > Cc'd Luigi since I know he's interested in interrupt moderation in
> > general.
>
> Correct. I'm curious whether the interrupt frequency based moderation
> mechanism Luigi is proposing does solve the NVME issues as well or can
> be combined with some device specific hint mechanism.

I really think we need both. It depends on what the issue is:

- for hardware level problems (backpressure on PCIe from the interrupt
dispatch pipeline)
  we need to actually disable interrupts at the PCIe sources, and
address the problem at
  a global SoC level, not on the single device (NICs, NVME, VFs used by VMs=
...).
  I honestly believe something global like GSIM is the best answer,
because the alternative
  of having all drivers implement moderation and coordinate the delays
would be hard to manage.

- for pure CPU overload due to e.g. excessive interrupts from a single sour=
ce,
  GSIM can help a bit (e.g. preventing livelock, or cutting some
10-20% interrupt overhead),
  but driver specific solutions have a lot more visibility on what is happe=
ning
   and may possibly do a better job. As an example,
   Fengnan's solution not only moderates (or does timed polling, GSIM
has that too),
   but can also dynamically switch completion processing between
hardirq and softirq.

   https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@b=
ytedance.com/

cheers
luigi

>
> That said, Luigi's approach should benefit from the "nowait" mechanism
> as well.
>
> Luigi?
>
> Thanks,
>
>         tglx

