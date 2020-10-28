Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0CBC4363A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:06:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C999C24683
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZAINQ59";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX60avSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C999C24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7e09z8HJRmfXONhY2rLBD7q1icqVzyi782kYrme6CsU=; b=ZZAINQ59RGAV6IWLFPu2yCMsj
	vHr/mTxGSAxNPjjx4QoogwUKNicOgCcT1GwPa1FPoZmyno8XIIZeQkoPeJEEstvrCjwfqvie9oAJC
	gndD8Lz1Frc0FQU5cf6qg8fx2VBUqDzI2zBTXzOcCyHGk/aHvYwh/+ZNSe5pv57O9FCiCOb1GMOyS
	mYEw+pOB3/V8YtDORjNsnfoms4lOZE5kW7wC3XJ5cM1IoUq1t0H5Pb1r1Ai5LWNeViLmBlkLrDVCA
	b5gBVNGV/9TAXuLyFXDbnXLLDgWkQwnAU6L6WpC2xarv1oVB7Pguleno9ZncoD6QP0FEpIhLXwlKL
	/t6QSYmlg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXhPI-0006ZK-BS; Wed, 28 Oct 2020 09:06:12 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXhPF-0006Ym-Hq
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 09:06:10 +0000
Received: by mail-pf1-x444.google.com with SMTP id 133so2542809pfx.11
 for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2020 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JDYiIX5M5YN4J997d/Mh3BGKj9X3sWCSLjXLFcNLDBc=;
 b=eX60avSDqzA2bzgYLeQl527BhC+2uMYkb59k74qtgdwflOAZI5gDXtAcnAaKWs5aSZ
 2GcSfxJEOVXkxwC1dYwb/hJxhKvn4pP7gAMDH8ZUCmJXF+SXdIvksy08noG+3kj0jVFk
 vI8YmE5BP+4X98LlssotlRaptbR/EcWaTpBvD1NqzcbMpn2vq2pTaUwV5ZlczgIbEEwU
 qWdlqwE3Dzt0MLNNM6cgeToL/1rP6HnzE7z+zjj1UgU+mPIAAXfqEcTVXzxM8zQJNB0v
 pJR2sAigZTe8pHCq6uM9k9Ud4mj9GQ8/gxFExn/tS2GBPGC3siswjDsv6wwbJNotvmTy
 ShlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JDYiIX5M5YN4J997d/Mh3BGKj9X3sWCSLjXLFcNLDBc=;
 b=N8KmwgQ8qljfLTPdbUAYJdrMtGlVsqxEgipid2NO7HO/eGeHvz34THlyZ4tjWXjZrc
 ht0kQJBMc56J+4BNZOlcgF/Rn7rnGJ/RhzGEPj6s3pHOxrZegkRUE6oEmwE+0UJOXg+W
 AQLjb25XItDjqEz8QAiSVC9INrdB2ixp8C1e6UHdaHSSC6b/h7LjpdAZ574aUSuHqktW
 hk5ppEJ4SOU+RdwFF12N87IVk02MTCoGyGAs3BQkQjWNksp4dPhRlYKaezj/CVqKEWGf
 er/dqGAT2dYtRHDTbJlrqyHESB3nZ8t0RzhwGWdwHJp4HK0IefUKPpW+ZVLnmrA6Afg+
 rmLg==
X-Gm-Message-State: AOAM531StRhO+SK6s0mjHaN8SuWcJjT8Lyijj7A6O4RYPCtNTfRAhrpi
 xT6AimuJn3QUDL5gbwoj8AQ=
X-Google-Smtp-Source: ABdhPJz36ycURoS1BevCLdRL9PyoyED0cveEb+flOFPdJRDYuvjGRASX8lhp+syOzvHxS2toS7JX4w==
X-Received: by 2002:a63:1a09:: with SMTP id a9mr5610362pga.188.1603875967506; 
 Wed, 28 Oct 2020 02:06:07 -0700 (PDT)
Received: from image-900X5T-900X5U ([220.120.123.224])
 by smtp.gmail.com with ESMTPSA id b3sm5039077pfd.66.2020.10.28.02.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 02:06:07 -0700 (PDT)
Date: Wed, 28 Oct 2020 18:06:03 +0900
From: Jongpil Jung <jongpuls@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201028090603.GB599972@image-900X5T-900X5U>
References: <20201027155438.GA111754@jongpil-desktop>
 <20201027202334.GA1942708@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201027202334.GA1942708@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_050609_608880_98F0FF5B 
X-CRM114-Status: GOOD (  19.27  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 jongpil19.jung@samsung.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 27, 2020 at 01:23:34PM -0700, Keith Busch wrote:
> On Wed, Oct 28, 2020 at 12:54:38AM +0900, Jongpil Jung wrote:
> > suspend.
> > 
> > When NVMe device receive D3hot from host, NVMe firmware will do
> > garbage collection. While NVMe device do Garbage collection,
> > firmware has chance to going incorrect address.
> > In that case, NVMe storage device goes to no device available state.
> > Finally, host can't access the device any more.
> > 
> > Quirk devices will not use simple suspend even if HMB is enabled.
> > In case of poweroff scenario, NVMe receive "PME turn off".
> > So garbage collection will not be happening.
> > 
> > Liteon(SSSTC) will fix the issue, that's why quirk apply on specific
> > vendor id and firmware version.
> 
> This is a concerning quirk. We use the simple suspend when HMB is
> enabled because at least some platforms disable device DMA access in the
> runtime suspend state. Many devices continue to access their HMB while
> in low power, so we can't let both conditions occur concurrently.
> Unless you know for sure this device doesn't access host memory in
> low-power, there will be at least some platform combinations where this
> quirk will fail.
I will submit another patch to check platform.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
