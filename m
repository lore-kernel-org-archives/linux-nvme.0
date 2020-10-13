Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB329C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 00:52:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C83218AC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 00:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KfklhnUK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYjTWQks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C83218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6K1G0OCUIh4FK2q3mV0H6Ci83v0DVkoolbXIuWbB+Tk=; b=KfklhnUKAO32aQ+3jIcGOM8Wm
	nRdaSOCrnWdK1GfefWWga/hu1QSm8zz8Y5PUwdZYR8B3KhXoZxcnkpnHAELh8IgQF5N1MdhHBwLnv
	3hGE4In+G1RavvnN/izltSrmih2AsgTbbIERTZTWICosvsI1/Ae+QHEZpbg86PXAITm1UnpS1Yao2
	KYre6sai9qx1C7utCosgILxOr4Z12PmTxEz/uR8at5CQur5xp1Y0z3kG+Ey6w4xgupPaIS/i/K4Eq
	RxA74mjotYw3syAcNld/MIY+08geGkrmQ3ZxPyTD1u8Prf6RROhwPRpm+P6+dOXKAKBeUqBfIKJS9
	3NFrxY5hg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS8Xp-0003x7-0r; Tue, 13 Oct 2020 00:52:01 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS8Xl-0003vT-Ql
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 00:51:58 +0000
Received: by mail-yb1-xb43.google.com with SMTP id o70so10938789ybc.1
 for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2020 17:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vgelu9n5lqWgV2jo4LH+xDpL2caa/69+hTU/kOs8Gvs=;
 b=PYjTWQks3ramcSOcaclBmJJj4uOh2LpGzZzfTxPnUHT9VSlExCCrhRNZhjkq0PndEW
 iV3NJhq3TMEsaFXFuFbt84bmRIF9qdZojYBBkWMFGog7w5I5cwxTJqHG3kcJJLLPqx74
 bTcv5M9mp1XNP5T3mO0hanfqdajPsOTZ28HTWfev0VOl9CcdDF7okymUWoPVNZ1fckxh
 qSro78AJp3qs/XMuv1IvkWsM6pI4s8h9X7Ro+/U7ZTDRqJXOJEz/gvaHrC7A+B19+std
 kPR8RXRzaDIfj2DhHfvGBBnl/9uDn739+aOFZR3FTg2MV4GytygN+nSvmxQvHdSdAjpd
 9whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vgelu9n5lqWgV2jo4LH+xDpL2caa/69+hTU/kOs8Gvs=;
 b=tXHD4Q2MQvUGmSVJx5Qkoadj8ydHlYXKm+Fon/Caw8A+VmkgYa/rrsf3TtH+7H+eP6
 VJap/gB7NBLRdna7fmhZj6MBTmboAzWsFcZ57/nY9kTxh8AknMlwj8jFfDc/NUX7ZK0V
 gWhY1vxstsSFQVpO4fv5/XzNCL0oiM82Tu4Evq3UlMlqOfjRBAxrMcNEGpKT4WMGIPaE
 kG/k/FRJmtfg5mkm2Rj+p3EgyLHnOS2v8Q8nGtyZLNifMcdk+VWsbjIMd2MJnYEd/J3j
 WSCroxprDN4N+UANxRz8CF8qdPv61djU1X9XhXfKFmrH7DdXGMstZRhdl0jS8em54J+Z
 wEYA==
X-Gm-Message-State: AOAM533xN7dHg24dJAzMcmmCgWre0U8TyEA62kK5lmTAvOPms2VUcWhX
 3mSRvCuZEb5rTYpW9gFfFTyieOXUbWmhi7LZA/imMWzRtbP8l3yf
X-Google-Smtp-Source: ABdhPJwkBahFCtb5lDriFMvjFYdIEaicslGzWsWjR2e7mnaDy6upcfhXgZL5lm7HJWmM1BVwB812PP8RnkwE4t2Cnus=
X-Received: by 2002:a25:57d6:: with SMTP id
 l205mr12874570ybb.117.1602550314435; 
 Mon, 12 Oct 2020 17:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
In-Reply-To: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 13 Oct 2020 08:51:43 +0800
Message-ID: <CACVXFVM=UPgJ0K4iZOG=DJNmfovHFjg-u5zQkEFgwG7np5V3PQ@mail.gmail.com>
Subject: Re: NVME, isolcpus, and irq affinity
To: Chris Friesen <chris.friesen@windriver.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_205157_867978_62BD379B 
X-CRM114-Status: GOOD (  22.10  )
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

On Mon, Oct 12, 2020 at 11:52 PM Chris Friesen
<chris.friesen@windriver.com> wrote:
>
> Hi,
>
> I'm not subscribed to the list so please CC me on replies.
>
> I've got a linux system running the RT kernel with threaded irqs.  On
> startup we affine the various irq threads to the housekeeping CPUs, but
> I recently hit a scenario where after some days of uptime we ended up
> with a number of NVME irq threads affined to application cores instead
> (not good when we're trying to run low-latency applications).
>
> Looking at the code, it appears that the NVME driver can in some
> scenarios call nvme_setup_io_queues() after the initial setup and thus
> allocate new IRQ threads at runtime.  It appears that this will then
> call pci_alloc_irq_vectors_affinity(), which seems to determine affinity
> without any regard for things like "isolcpus" or "cset shield".
>
> There seem to be other reports of similar issues:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566
>
> Am I worried about nothing, or is there a risk that those irq threads
> would actually need to do real work (which would cause unacceptable
> jitter in my application)?
>
> Assuming I'm reading the code correctly, how does it make sense for the
> NVME driver to affine interrupts to CPUs which have explicitly been
> designated as "isolated"?

You may pass 'isolcpus=managed_irq,...' for this kind of isolation, see details
in 'isolcpus=' part of Documentation/admin-guide/kernel-parameters.txt.

And this feature is added since v5.6.

Thanks,
Ming Lei

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
