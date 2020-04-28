Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC65C83004
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 03:47:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F5B206F0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 03:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ObUMGCzj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg3ghA2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xu9s2g3xOXLOLbcN8CTCrwrYn42wswvTN7v9rDo9/B8=; b=ObUMGCzjFBjKmK
	pOJVNU7nZsT30ddkOKhqxmNqs0zgDHW6MsWkfHUZ9bNfPbi+Zzt+y/cs6HWj/tD+YXyMGDpFp8cll
	8Lq/ITbwkwPTBLkohTs2R/+pGaryqzgw3eFEquRvsq9M4OAdU3bsLew+Az3yTNqxqJTxzcf2RiQAd
	iNfIGKn33ZirAyBv4WR+Qe9OXTnnsV7LvWz5kIUcXOPDui6YfHTD5VIddXBetX7FCSqTS+nbTbnQH
	D5R156+Jvh3mZyDXfx8Qfo/6d2VyvU86W84gwwncSieqDCMVnhX//OkWO4t2kx0dViHs5yKHZdFpe
	RldMp8r2gwZgEY0hyg3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTHDD-00063G-7D; Tue, 28 Apr 2020 03:47:11 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTHDA-00062D-50
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 03:47:09 +0000
Received: by mail-wr1-x42d.google.com with SMTP id i10so22906476wrv.10
 for <linux-nvme@lists.infradead.org>; Mon, 27 Apr 2020 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RG8Rbki5yfCP7vNLqvtL+LO58YAQWxr8aSZsjnruSUI=;
 b=Yg3ghA2z9Mveo6l9i2CzcIi4BjSZrrRHCf9OyDItgv6SubRSrOlCqhB/p6SOzbY+PI
 4I6HYC+xR2ZqMePBpc2hpGmK1kf6KhTPiTZmQCY4pmrtVs0fnYDXRsuPgu6GzH40u/fU
 Tm35b5c3qXbKEaIyHkx8SUZYBzWhLYqeM6hwyFMCKecJc8J+R0/qHPJ/hl+cXTN8VPMm
 jOsCZXKa8tM4JYBD60xzGFiEVnorUBDw8jgdlkGOuuCG0a0obDoMMRp/C+2IEw+O2K53
 ycd2RNX8T6bDc0TAdI4hnmbz0rjEyngn32e5gAyrbHlSTQDdDTxOCOXO59w4ZAkM5eOU
 KNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RG8Rbki5yfCP7vNLqvtL+LO58YAQWxr8aSZsjnruSUI=;
 b=s2GYXcNkpeGT9ombPSEk1EZxy6oZE4snq4qmRr0wlGcmBpjUFjAVVdaGJRb8UmoRJt
 Q1jJl2tRatG6IvBAWHeaDMWs3zq3FhbT5l5GjTieMpnPAyoAdHkFDncGe9uF5h/Pq+E1
 LNyidPFC+BMi1jOzn+U1uGw3jY8dQJLm9o0cwP3ECcxAwrqdhYbmXXEqgQU0iehhBIvO
 9dLabUTXnM3IhDQxf7cPO0RvbDQk/VmXIFyxlMKBpiBNn+jv1V1OWvzSZLhpAdK7SC1F
 glm+h1O5eGl1MRRWAQ4tzcPFM/GjZuvcZZOCwlsUEMudlIyFjcFX9+UIXSLlG+1Bc9b8
 wMLQ==
X-Gm-Message-State: AGi0PuZtMHIoIFmchgDkQNZbgo0okwiWbYZtfXabRVTtFuUvvzVzM6ai
 4VQWBfU/wdsiPpMCTV5Q3+cOaBeAleN3FjQvsg0=
X-Google-Smtp-Source: APiQypLkm5d0sG+Kqe/yGerb3Nq1Q1yh+CO6swEsZnqLqvYgYFg9AaPNxU8cofty+lBtX54WApF7Wkye1x8SbntIsX4=
X-Received: by 2002:adf:f30c:: with SMTP id i12mr32203237wro.426.1588045626214; 
 Mon, 27 Apr 2020 20:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCYAscnovJyA0cKeHVxS20+zGgMj4P5ECb95aZE8=o=Wh+5bg@mail.gmail.com>
In-Reply-To: <CAFCYAscnovJyA0cKeHVxS20+zGgMj4P5ECb95aZE8=o=Wh+5bg@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 28 Apr 2020 11:46:54 +0800
Message-ID: <CACVXFVOA4wNw_1rvPZaR0Zkmf_b=yQ7O38zhYX9ZW9WLa3wSqg@mail.gmail.com>
Subject: Re: Pinning nvme interrupts to a single cpu?
To: Jeff Johnson <jeff.johnson@aeoncomputing.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_204708_215626_4B0C69B5 
X-CRM114-Status: GOOD (  10.29  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 28, 2020 at 8:11 AM Jeff Johnson
<jeff.johnson@aeoncomputing.com> wrote:
>
> Greetings,
>
> Is it possible to limit nvme interrupts to a single cpu, rather than
> spread them across many? I have a latency sensitive workload and I am
> trying to do the opposite of what many appear to be doing, I need to
> assign interrupts to a small number of cpus (one for nvme, one for
> Ethernet, etc) leaving the bulk of my cpus for the application.
>
> Single nvme drive which is both boot and application local storage.
> Performance is nice but in my case it's more important to pin the
> interrupts to one cpu even if local nvme performance decreases.

You might reach that by passing isolcpus.managed_irq to kernel for
isolating CPUs which needn't to handle NVMe IO.

thanks,
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
