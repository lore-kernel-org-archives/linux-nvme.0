Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C52CA6018
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 11:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sO6+wgHmizERNlE89bUfmYnUemgnXAS4GsjCPxo/9Xs=; b=z7I4dGvBnyKdOOQEZbnuvLgr9P
	TmZsoL3BwFzxqqMzZN5fEgRjoItMCDMXWRqaErDF1xc9Vo57IFoVuXIr+uescCRYYsGvU095lC8ua
	FE5A9OSgNSapde63lg1K4ebyxbA3fK+MsDrv0DKF+i0D82eW8nanyDDB8bB/aly/QweuJe2qbTjME
	zJPTJVrVBm3CXqP4gxmUGPFNupbpNwMmuzelVNeWUtYzQo6KWTZw95zp8gcXN7XRSLUHV/+f42l4y
	Y8mQ7iBFsLFNdMC0evgZYaXUQB6XI9TdMiPt3bwOiAHmHXe3TkRBpnfm14BB6+m+YJK6NWR2DFQVw
	s2CUY3FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF8mE-00000006AjI-38zg;
	Fri, 09 Oct 2026 11:28:38 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF8mB-00000006AiH-477c
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 11:28:37 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2db33db4de9so51765ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 09 Oct 2026 04:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791545314; cv=none;
        d=google.com; s=arc-20260327;
        b=cs0G3tF13++eTQ5SbAhegOtx2GKTP2uK0l3fig4BU9bdPAZ8bnWXHXNY9e0WMaUtY2
         AXOxSrATGPs8l7IMu8+u1pAfKZzM7K+wWdASoi5ZMerabIg3QB6ulbVxX0C6YsrzJnHT
         ZA1BTKWGds53P9ejJ8vsnt4Fp9/m3y5iBvitVGHQXZMwOYwn39uZ5MsmgFocis5bFMBF
         2vndisd3Goqd26ImQPWnU4rO0m5fCB4vT6Rygm4vM3fcfJNd9EOvN9QXifR5aPLui74m
         T7XvaRXHBbrzfJlLJ5+VgrWEezesmna88WhhwfMIuZvEmg1reungCh1EPs04LOT37nbk
         9edQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sO6+wgHmizERNlE89bUfmYnUemgnXAS4GsjCPxo/9Xs=;
        fh=z7ja4Hd8a6iVVbyFsQjMvcnVzXE9+c0xFTii2Iwsv8s=;
        b=EPPupFedTgP+7kQJCvGJ/QzuWbIIBlxwZv0TcN73A0Wvs+WJ9nBjNIDgTu5jmTi9d9
         PoCVpJt38rKXLow0bGoE+Naf1tvtml57kGWkTwa5ugFYEAUWkuOtgNqJ2apuBFHCBRyb
         bWAMPVZo3X6bxRt+yLkD3SPkYf3J8FIENeIEQkCOIM5L4QSgkeFNDduz7WKsjI1SkzV4
         iY1304zNB/xKmep0n4BUom6/xIcpPOepZbo6qvgDuablUFUIvb7sspw4px51PkPPhHRv
         suDpZk82Ir0EUuVpn+pGtEy9aAVF/EXD+yfkKYkqkCgSmZQQxBpjttxRfKDTPX6UMPYI
         UnXQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791545314; x=1792150114; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sO6+wgHmizERNlE89bUfmYnUemgnXAS4GsjCPxo/9Xs=;
        b=J3zukFTRRDYo/9xCUdqv4ne1vk9dA/SGa48Gf2pdeGlLInAnjaGyQDuZSutzqQIlZS
         O3a7U/Rh7cfKz0AMA98dpAUH5vUokeHC/TIMmwHcbjqcGtY6LUy1CVgPC+/ahtsgDAlH
         6bsTwYmWylh0MzwNdufBhzNDbrvvcDCswjJGCqLh8dEydfBeW3cn254j2rCp8ho3B71t
         RH8gVLM2Hqhnw/kCmfGJUJOZgnK6wFf293AqXGdCsWjt/KPD5xOAZwb1g11pIb5cqUVL
         GNTqR0qUIT2xIrpUmBcDPhYLK/gT24Q6ZHYB8o1XTQMPOXbcL6PwrkKdoQL1GpTAKBYF
         CMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545314; x=1792150114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sO6+wgHmizERNlE89bUfmYnUemgnXAS4GsjCPxo/9Xs=;
        b=sBLnHwKJiCLa9SpO8ZzI9vJapjQizeeqOMmah+ngQ+nHGiWQaG1Vv4U80g22x0Spt+
         em0WY0ETmN4lAd7RvGk2YPyt5WwJy5/QzejJO42X6mjud9d0cYGYHTdcbXz/AarKS21C
         TD5FE5Qu52wY8q+waD8t28JgxlzM73a0oSkSnleRlPUMN2yooBolodWAIhcjq+/ibQ9K
         8xYAl3wAuuVwPOqjSnd0YMRdBToKdU9K8CZXm7DUNePnniocUiu8mCdqxWCa6y5Atu3A
         i1Z/7jtXuphf8Tfhgic9VrFF68GvfXPSf+TSaFDS8Djp/mSGl4d/JMLNoskwAsJSo+ie
         zlOA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ5vPtG55VHrzpRwXqGepWXfafy5kdZFx7Sb+8AZ/EZDDrw6DSlt28NgVVZhyK+GFdM08wUVAZ6CXI@lists.infradead.org
X-Gm-Message-State: AFq9FYI0vorz0AzbpRTOmVRCJU1na20TUnq5KW0re6Tv8MHUvVkJGeEf
	i+cCKL0mfoh5T+/OjM6OjxVJsipiUQN7PAnMvngZc+ZGblq9CrjaFk+E3llq3oQQvt9IWrlr3Cn
	x7+XTJGw9jyqCbd+OmvZpkU1TkgKWJitG8wCX6n4v
X-Gm-Gg: AYBFou3n0XsxnuZ0zpUUc1mP10M1uYI8zUxH4kveO2CgAQl3aiX1WnYBYmE/yuw26UV
	uMwskw5RWc8gw4+jSq97etkwWsX07/3zRpa9a+jSf+FQF2v/szJlpKD2PhNut9uDZ93pBm7iyhA
	hNKT1R9IseMeVUQ+Fly9tVEbE0L0vnNRCLc1tNTlr+ZaLcqt2GbH/SWZ+M2c+2wSJMNi3/rj73n
	Ok0mqtlqUYqGLyMPagCCSS0MOVWhHGIMrHQwfizvyzn9+2E0W/tx9aiy7iIN8zWns+dCSBNrsEb
	3TrxbDFAl0u125+J57wc+xs8hFZGiiCIMIpMh6I5IlGvxTc2/sevuefP
X-Received: by 2002:a17:902:f70b:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2e83db4bc44mr3303955ad.2.1791545313585; Fri, 09 Oct 2026
 04:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com> <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
In-Reply-To: <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 9 Oct 2026 13:27:57 +0200
X-Gm-Features: AclHuK9lXMeYD06lb7uudSY49mGzzzPnQZe8BJ1Av8Eu26jyJ3pnC-vn0cZ5MeA
Message-ID: <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, changfengnan@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261009_042836_061928_6D5C397F 
X-CRM114-Status: GOOD (  30.28  )
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

On Fri, Oct 9, 2026 at 12:17=E2=80=AFPM Naman Jain <namjain@linux.microsoft=
.com> wrote:
>
>
>
> On 10/9/2026 12:21 PM, Naman Jain wrote:
> >
> >
> > On 10/9/2026 11:24 AM, Michael Kelley wrote:
> >> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October
> >> 8, 2026 10:06 PM
> >>>
> >>> On systems with several fast NVMe controllers, completion interrupts =
can
> >>> keep returning to the same CPUs faster than scheduled work can run. E=
ach
> >>> handler may drain only a small number of completions, but the combine=
d
> >>> interrupt stream can still prevent scheduler and watchdog progress.
> >>
> >> See this recent proposal [1] that sounds like it is addressing the
> >> same or a
> >> similar issue. And there is this [2] more global approach. It's
> >> worthwhile to read
> >> through the discussion on both threads. I haven't done a detailed
> >> comparison
> >> of either vs. your proposal.
> >>
> >> Michael
> >>
> >> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-
> >> changfengnan@bytedance.com/
> >> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-
> >> lrizzo@google.com/
> >>
> >
> >
> > Thanks for sharing these Michael. I'll check more on these, and try it =
out.
> >
> > Regards,
> > Naman
>
> ++ authors of these two series, for awareness and if there is some
> configuration in their patches I should be trying to fix these lockup
> issues.

I see your thorough analysis below, thanks for the details.
Is there any reason why you used nvme.use_threaded_interrupts=3D0 ?

Setting to 1 moves the work to a kernel thread and seems to be the
best way to prevent too much work in the hardirq and the soft lockup.

I am surprised that GSIM fails to prevent the soft lockup, though:
under high load the sequence of events (starting from unmoderated)
should be the following:

1. HW sends MSIx interrupt, not blocked by anything
2. SW calls handle_fasteoi_irq() --> handle_irq_event() --> ... -->
action->handler() which starts processing
3. HW possibly sends another MSIx interrupt
4. SW handle_irq_event() completes
5. SW irq_start_moderation() starts the timer, __disable_irq() and
sets IRQD_IRQ_INPROGRESS | IRQD_MODERATED
6. if #3 happened, or another HW interrupt comes before the timer expires:
  SW handle_fasteoi_irq() finds IRQD_IRQ_INPROGRESS | IRQD_MODERATED both s=
et,
  and does not call handle_irq_event(), postponing the call
7. when the timer expires, the pending interrupt is reinjected.

The above suggests that we should see some pauses between runs of
action->handler(),
at least for a single queue per CPU.

Do you have any way to look with perf and bpftrace at the CPU
processing interrupts,
to see what keeps it busy (the pause between 6 and 7 should keep it
well below 100%)
and try to verify whether the calls to hndle_irq_event() are actually space=
d
as the sequence above describes?

Having multiple interrupts on the same CPU mean that the gap
between interrupts for one can be used by others, and that may
definitely make the CPU 100% busy in hardirq.

Again to address these cases, nvme.use_threaded_interrupts=3D1 would
greatly reduce the time spent in hardirq, moving the bulk of the work to so=
ftirq
hence at least becoming interruptible.

cheers
luigi

