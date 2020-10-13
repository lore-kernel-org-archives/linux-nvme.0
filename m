Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F938C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 07:50:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8229C20878
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 07:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="llHzoUkS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5qva6d4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8229C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S3B5MCsiC0Ks640rBsG2DPrwdPEyMnHmp6MJ6FQgWb8=; b=llHzoUkSD5dXJAmezlhvv6U5k
	bs5l9MtG22OU145yebHfWfboGinszrgQu3jsn/d/7uPTT/xLxBLbB02JinLjuSgv16eUBrVA+Zzx6
	Kc+qzjkKyAK4170oBTlXacVC5w/mxhCLUg/l8B/t/FKJVCZBvGjCXFSx8LPw0mPXT5DtiNrkTV0fl
	5ddm6S0TXbClguqambBIKLmo5q4Fg6wqIfsQvPg6j49MdERr3TPP0jN/qBymHCPFvEUwyWPGhGBo6
	17ycMptFp7R/2Kc/E2vNFulRwfIy+aYtkrcI7Vfzecjmr084rZLWcM+Q29DbdE45b16tJdlD246X8
	7S7qw9Ivg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSF53-0004H8-AR; Tue, 13 Oct 2020 07:50:45 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSF50-0004Gi-Nj
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 07:50:43 +0000
Received: by mail-yb1-xb44.google.com with SMTP id l15so779475ybp.2
 for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2020 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RX74aO/jN0DueFHlFuuG3p9djtrRRqivzaQ4T3duKmw=;
 b=o5qva6d47g9wcXikLavILMRfGysfdKLGoCcgNP5fkaQnapEKnpGJTLhdZ2C/RL0nO6
 ojz0SLWHOgkb2bfPN1EtBFs58h71+3rgW+T/4D/qVwNgrE2UYZqan4iEOHhjPB49SZot
 8oE3FB54wc5fZl4pdbnL8vYalu7ZgsQASjsLA1bjlYB5j5h5GlI+TwH67Uo0vuEZGem3
 IAUzdpRF8naIeqblPV1mkHw2vsRiNRb7eb/qgSWw4R2/EcVuJjEJL/Y0XKQT5ztyXwi3
 gVllk7NsZKcodWlJhtOsSioUfUchnEOR/aY+zOF5XGWmMJ5huyrJ2BbGeQpX+y8nJof6
 RELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RX74aO/jN0DueFHlFuuG3p9djtrRRqivzaQ4T3duKmw=;
 b=afRyZw6k8x86j6ZTGVx/YeHQLchxkWPqDa4LhH9v5XggZ4d/6vR/kRf79XdYLWc7eW
 u59MfF4sX5+xZgd8ARn7BfA5AS4gmuuvGct7LfI0tkdkDROISHntpNh6VQbW7H9HXcu0
 4CtA6yeABR+tWeqlv2LkRFIRxed7gn6Yv7E1NrSTb0+7eb/zhvzzJ4m22B/QdrEb/95O
 L3uJpmPqIXMYqGNXFFxX4q6fZgYHC27GXkerqR1/h7KqzhbUDKrLj42goSPMD3emNxdN
 Fsbcag0Uj5D9AIBYFwQEJazHw6YN5wDkt4L2aNYarHlocZvLakHF+rv1avEXd4nKPol+
 NHfQ==
X-Gm-Message-State: AOAM533rEJsv9mo0BGAgZqFpbT8InFHw/6MEQWtH37gEdBZslydH/vfC
 jPtH6iQ0yQlW3z7aeUXznj0BDKsW+xebyDTQ7RU=
X-Google-Smtp-Source: ABdhPJwuTyd3aTId2sFvS04vd1I8TdFbAw+ZnMpzgVSzfkL7aQdmHTB927vRxhIPgj7ichcnqyx+BFs6j2lYPXA4sgw=
X-Received: by 2002:a25:8250:: with SMTP id d16mr38754611ybn.498.1602575440949; 
 Tue, 13 Oct 2020 00:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
 <CACVXFVM=UPgJ0K4iZOG=DJNmfovHFjg-u5zQkEFgwG7np5V3PQ@mail.gmail.com>
 <c199e17e-2c7d-8010-7648-3d16ed964c2f@windriver.com>
In-Reply-To: <c199e17e-2c7d-8010-7648-3d16ed964c2f@windriver.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 13 Oct 2020 15:50:29 +0800
Message-ID: <CACVXFVOSR7UXDC52A-2sE1xeZNZ1+KUxGPXUJrvu_FpZ0qT4hA@mail.gmail.com>
Subject: Re: NVME, isolcpus, and irq affinity
To: Chris Friesen <chris.friesen@windriver.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_035042_842650_C7FD7C16 
X-CRM114-Status: GOOD (  30.38  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 13, 2020 at 2:24 PM Chris Friesen
<chris.friesen@windriver.com> wrote:
>
> On 10/12/2020 6:51 PM, Ming Lei wrote:
> > On Mon, Oct 12, 2020 at 11:52 PM Chris Friesen
> > <chris.friesen@windriver.com> wrote:
> >>
> >> Hi,
> >>
> >> I'm not subscribed to the list so please CC me on replies.
> >>
> >> I've got a linux system running the RT kernel with threaded irqs.  On
> >> startup we affine the various irq threads to the housekeeping CPUs, but
> >> I recently hit a scenario where after some days of uptime we ended up
> >> with a number of NVME irq threads affined to application cores instead
> >> (not good when we're trying to run low-latency applications).
> >>
> >> Looking at the code, it appears that the NVME driver can in some
> >> scenarios call nvme_setup_io_queues() after the initial setup and thus
> >> allocate new IRQ threads at runtime.  It appears that this will then
> >> call pci_alloc_irq_vectors_affinity(), which seems to determine affinity
> >> without any regard for things like "isolcpus" or "cset shield".
> >>
> >> There seem to be other reports of similar issues:
> >>
> >> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566
> >>
> >> Am I worried about nothing, or is there a risk that those irq threads
> >> would actually need to do real work (which would cause unacceptable
> >> jitter in my application)?
> >>
> >> Assuming I'm reading the code correctly, how does it make sense for the
> >> NVME driver to affine interrupts to CPUs which have explicitly been
> >> designated as "isolated"?
> >
> > You may pass 'isolcpus=managed_irq,...' for this kind of isolation, see details
> > in 'isolcpus=' part of Documentation/admin-guide/kernel-parameters.txt.
> >
> > And this feature is added since v5.6.
>
> I suspect that might work, unfortunately it's not available in our

Did you look at '11ea68f553e2 genirq, sched/isolation: Isolate from
handling managed interrupts'?
Which supposes to address this kind of issue exactly.

> kernel and jumping to a brand new kernel will mean a lot of additional
> validation work so it's not something we can do on a whim.

You can backport that patch to your kernel.

>
> I'm definitely looking forward to moving to something newer though.

What is the something newer you want?


Thanks,
Ming Lei

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
