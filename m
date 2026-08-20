Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745CAC5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 07:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=; b=oxyG4hkPV5iZiFLJoAcWuIbAMD
	8dvGDKlmb8BtWuW+q25EQhqScKWNQyY81NjiSFSlRwWt3rZRaeXi4wh/DFHHSbzfj2mJC+k7TedRt
	M6elTBBg6Q4RPiGLg5LMbm3wCFOq8J0GnO8fRrGbf71RNWccl6ma5SOo8dPuCdlLPDkvmm51JWh/W
	3BCDMDOR2Ox+rMY72/ILDV0X6RpqR4fIAZ6m+01TDpg+HSaL2wpEG6ZDH2W2f6jqz/UgvYDmMSUMf
	tbJGsIQ3S5D5cYg7qeZWiJoUtyhu29dHU4oy7zM4PzHthyhfavMktZpwcNBSPXloQMXBjtjKfaBF/
	xjYQz9/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwxJM-0000000B4jK-2Jr8;
	Thu, 20 Aug 2026 07:35:40 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwxJK-0000000B4ip-0wge
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 07:35:39 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cede6375caso44165ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2026 00:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787211336; cv=none;
        d=google.com; s=arc-20260327;
        b=OKCcwhwMKJQmCYulKZFX5RvStUeF3l1VQBLx1fXkLF9CtYjeUJw11s1aDzK/fG8G5n
         RrjxL7DEQ2o5WmhhlOkGlvfbPpAKj5sjRZhZAsJFEpiKpLh5sTKYcKCZYHwff8Hq4sr8
         X84+Dvv179FRCVW8YuP8++5/+ZYGgTrHQYOmBE4C83GScE9x0O1TO7VGGpGxfP2fqnJP
         GFxQ06EgOkKqNh23nuT2nUy50jfDDsgPpzJ/1RBi6r1GLRyKH2GqPF8P1ciQwEJHtSaI
         ZD9j6GB5QEtwGGrNQFpNuCU9t5cINXzCJm7xym9qhqvNcHT++JBGSHKXRhIYlKk9kbxq
         PUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        fh=ZhjazfILHzZgaXjV8IyEwPsUcqfKegp2TOS7BbH24cY=;
        b=gsJ27pfjusmsYolOVCs6NFWY6v1PQuAz01q5mWCacfeXqunJSZQAz47z12JzQP7J1m
         /9VUz1uVgaznM2Prb3V0rn98ojEL9kZruy+HeK55O6910qCx8CCJhbKzH3m/mljVVDyY
         +Tpv/yY6I7VGofOf/Wo7rO0E2SJ29PejSwGEm1oPLLp7tPrCYi4KwZoFuk4AAabyUGrh
         Gll89y1bwSlxMkuPLYPaMuwAb/2ryrbir0+bPEGuipxs2gfdBOKBWg4MNoKEKOWTy/O0
         5EgyNKyz+7WMleVQ0iYVAeWj8dcVGAs0kYH6oGhFw3K38Z9/7GDo8sLPJoLa46+wH3u2
         +Jdw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787211336; x=1787816136; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        b=ZrAt3kmd/kUwlmMyY50G4Zqrs+BxjVmD+zaNvuJ14bSKibFaFlpEryJWeL7oB7DWpR
         6fEb7Xik5skScyQjJq2u3HsjHVx0ZS7fR/mdsNlqKsR8iLZvDLPOKiMDYglHhVuz7CAM
         3zdjpldaq6kXo7MeAdku+kDBkmHXCItVryoC4rX2wAUzFxtChElYglgRQMZRMlyw1UEK
         YY948qbvR/CHKWWtmDLB9t5oHGkuLyGF4Jft2gqspZAmGgurbRZ0sn2w6YccC+rh5rSk
         fWSL51koHp6jUrxRTQfPH8CItQkaIMfa19l5S04VYNhdqR/MrTs52V2Tg9lNtXINk0A8
         99yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787211336; x=1787816136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        b=ArLJTvQUJxCeNh/jPShcsU99ANrTq5w78a5O5eskcSJU2kHMNJDUjczeDMNs/KJD+W
         4Oi+hJTpL90ECTHmTI///IZe8Iy5wGV6SPsQw5ia4B50hrAfqMDZ3P9iuIlOG2qDMbRm
         4Vw3mx0UFXDMU7dcZSXNRMzmdsJg33nAaNnUf7IP1/dHu+ww8XOpENr/Wj0mFSCdpe/U
         LkdKjDCmoIpzEFRTfVwkRXQPmbRfLF+2sPiuzsIZ3JUf/AmjejkcPDSuE429rNot0Rtj
         4jBsJoEowb9M5DP1EpaJi9I6JLiAPWPllfkPPlv2OGSlWckcc2KfEvI8OY/EUZdWCeWk
         vNTg==
X-Forwarded-Encrypted: i=1; AHgh+RpAYZA98Yu5ncSiLpzQoRWrzKpLita/YRHf24SEYgII5Q7gwMrMCLcO9MLxiMr0NAicU9xK+G1J9HR2@lists.infradead.org
X-Gm-Message-State: AFuF++lM5/Stwon1n9An3Ut3AneHKCuxKrbtwirtWeiwgH3J/KXgClvj
	2sldj+1XwD4l+80sDbXHRRr2L6GhSEvbeg8/oN2GyIraL3OfczdDergNiqCshYKVDrfptrpOwdI
	O8tT6r29y4k3XSXazfeuE4Qk3Ms6M1H84hF7DXQvO
X-Gm-Gg: AR+sD13dx7EVEBAzDmLH8iCyBasGqsYfIFt9BpgUJ+VBJgQJ1jRkGmSLVMJAQeMlu/0
	pFSCWvuTH3ypEaIh6EzzfRJzmT/0coPvavlHpQW1KzHa1plJD3V4B2wrYCCl/4kYKMVHLqtlytK
	LkXgj/MsodIYPnK4djCYgxh/IeUtXXfk+gCyocXFoLKX76RkOFJqKkbKMfNyem0mq1e1O7iMduK
	9COMgus+ncPyWdf6isrpbpVfW5YHLGRXycBpyjsziTZgc/r4W0hx/j1Idoc+bEBkjFV8nXza9gX
	ytsgyYn46I88Oqkx48kTzLlwNXXmnHgb2Wdgy3hChevTFQ==
X-Received: by 2002:a17:903:26c4:b0:2d5:db3d:1a43 with SMTP id
 d9443c01a7336-2d61eaf2a00mr5392465ad.16.1787211335900; Thu, 20 Aug 2026
 00:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com> <aoaoERD5m1MNvMWd@infradead.org>
In-Reply-To: <aoaoERD5m1MNvMWd@infradead.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 20 Aug 2026 09:34:59 +0200
X-Gm-Features: AcwNN1UEas5zzKqBrgfMq8L346ulYCSqqrdVmLWHWX-HHf-jbZz6J4McJCDiFEU
Message-ID: <CAMOZA0JrLia8NU1-4JEJAe+p65C19HsRGU6VK7sLAjNFKm8G3w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Fengnan Chang <changfengnan@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_003538_266152_2CEF9F5C 
X-CRM114-Status: GOOD (  21.35  )
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

On Thu, Aug 20, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Aug 19, 2026 at 12:43:34PM +0000, Luigi Rizzo wrote:
> > Configuration is easy and robust. System administrators specify the
> > maximum targets (moderation delay; interrupt rate; percentage of time
> > spent in hardirq), and which interrupt sources should be moderated.
> > Independent per-CPU control loops adjust actual delays to try and keep
> > metrics within the targets.
>
> Can we find a way to autodetect and autoenable this?  A magic go faster
> mode that needs very specific tuning is annoying compare to sensible
> defaults.

As mentioned later, the tunings do not need to be specific,
because the control loop adjusts the delay to stay within the target,
and the target is generally just a "don't overload me" value with little
impact on performance.

Of course there are many cases (eg small systems with little I/O) where
moderation is not needed at all so at least one bit of user input is necess=
ary.

What I normally do is use another small patch to pass the initial settings =
via
module parameters, using values similar to those below
(enable on all interrupts, delay_us=3D100, target_intr_rate=3D1000000,
hardirq_percent=3D70)

> Also how does this interact with adaptive polling code inside drivers
> like NAPI or the upcoming nvme variant?

GSIM acts at hardirq level (so below NAPI, and above device moderation e.g.
the one in ethtool -C ...) and is completely orthogonal to those other
mechanisms.

If NAPI etc manage to keep the interrupt rate/load below the targets,
then the adaptive controller in GSIM ends up using zero additional delay.
Otherwise, it gently adjusts the moderation delay so the combination suffic=
es
to stay within the target.

All the above assumes the parameters are sensible.
GSIM or any HW moderation allows up to 1/delay_us interrupts per second, so
setting delay_us=3D10 allows up to 100Kintr/s per CPU handling interrupts,
so there is no way we can throttle interrupts below 100K/s)

>
> >
> > The system is adaptive. Moderation affects only latency and only in
> > high load scenarios.  Throughput and CPU efficiencly generally benefits
> > significantly.  Targets don't need to match precisely the platform
> > limits, and one can make conservative and robust choices. Values like
> > delay_us=3D100, target_intr_rate=3D1000000, hardirq_percent=3D70 are a =
very
> > good starting point.

cheers
luigi

