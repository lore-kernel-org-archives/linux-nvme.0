Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D121C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 21:54:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B7C208DB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 21:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sKxyJEib";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="u+ajFCQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B7C208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D29jGdTBQ9lQRShvnlcfMlgZGxJQcatSiwEHGSyti3M=; b=sKxyJEibSgjPb8tm3YfIQaFLE
	70p1xf53+rQMc1NqLhtOk1pHF0FU1xWhzTWVxUh3gEhJI7TW8o4qaL4lu2Ww5CgIU7Lr/SR5aTdmc
	VVzrz7vsSNU+6/RSkgGh1cVY36Np2UjC+tYOrCItYVBNgSjmECAi7y1B0EVX5q0z1eAVRKYdZ4Hpr
	fHt6KvtsIncqpmcPhueZkamniw3WzA5qcvIoE+ogWJSGqElMy3IZjk3oCKrC1Dy+bEZU+NVmIO+G3
	+bpPej1AAcAjnTPynts8ioGw7aa/Et3/eyIcI0FJz/ueeZw4WNwjb187BSRNxy7vMl+G3mwVk/xDL
	xIBnOahDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHwQC-0006g1-8B; Mon, 14 Sep 2020 21:54:00 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHwQ8-0006cG-OD
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 21:53:58 +0000
Received: by mail-pg1-x542.google.com with SMTP id g29so866234pgl.2
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Fdb1+XGdJXS/95f0xuZP5+Vca+20dd59IHhXELw6DQU=;
 b=u+ajFCQXDkBPYZlp+creOqB2OGBwcENucojKJ+6zyQ6YL9TIZwPFwpH3dpOaL/6sFB
 FWdTKjUsVdkOWqLYSWSHqmq0AIzb8OBAtCPeJeWF953gBrElO6UUTSeKgH6Gawo6UGdL
 mNoddAeIPVNdRD86K2k7eQon5wA19C+am2KVpUHAVYB0lrOQwlG92kk4EOoKqlXIYem4
 BKvQaT+4pbVPmy59NcR+Ldn+DsCwY+i/Ozh4ChU+8jFMbC7qTsUGpwdxyOftFDYfczpF
 NNQo984Ee7fx5xsHqekOC7fPMxGG6YMBj1asJpqWJozfRo1ySEE39Ldgm+TEXARlE62+
 F/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Fdb1+XGdJXS/95f0xuZP5+Vca+20dd59IHhXELw6DQU=;
 b=oR7gPtBOjBVYC8ma//NqOYvtPMYw70AyDXML9N0ob4gaw0lCnbIuV3JjRmV4y/Exlk
 m1r9ethw47tc9dueadLk8ITr7TI3tub2925S7CpktjZtbNdYsxGvUtpny+pIvtXzVCoM
 9GDieviiEYLE8vJyb+rySdaLC6X77fwCPyeLpMaucpx/Sp6kuhsUqOc6ZjSMVO680TYi
 iZW54c9GP75ekvFhpm4IK2R43WI+xOUpDAKkmPNSn1ml9BCkPW4oF/OQW/EqSdJRL/KX
 EdUoZcmIf3TlJBsaWERURKFSPLvVFzIFpV9/NEIhiOJJEM3FaiV96j42a9Fj71zzxvcI
 6xwg==
X-Gm-Message-State: AOAM532MebyAxFGft1mpaEEMJ17I1rNZ2nFWOTnab5udmTTQonmRNp7q
 HwEZLaVwo7trYd061D6jO0UyVw==
X-Google-Smtp-Source: ABdhPJyG94WN0xI3WIghEToJNetpl5TZS1fqBsjfp6yghrnCYrxDLXvtjpiZGvP6iR/Aq4ObLgUuFw==
X-Received: by 2002:a63:1c18:: with SMTP id c24mr12444689pgc.30.1600120430301; 
 Mon, 14 Sep 2020 14:53:50 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
 by smtp.gmail.com with ESMTPSA id mt8sm10140102pjb.17.2020.09.14.14.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 14:53:49 -0700 (PDT)
Date: Mon, 14 Sep 2020 14:53:47 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v7 4/7] tests/nvme: restrict tests to specific transports
Message-ID: <20200914215347.GB148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903235337.527880-5-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_175356_923512_92118387 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 03, 2020 at 04:53:34PM -0700, Sagi Grimberg wrote:
> Protect against running tests with the wrong transport type. Most tests
> cannot have nvme_trtype=nvme and discovery tests expect the $trtype to
> be written and verified in the .out file. Adding a couple of helpers
> to restrict the transport types in tests.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/002 |  1 +
>  tests/nvme/003 |  1 +
>  tests/nvme/004 |  1 +
>  tests/nvme/005 |  1 +
>  tests/nvme/006 |  1 +
>  tests/nvme/007 |  1 +
>  tests/nvme/008 |  1 +
>  tests/nvme/009 |  1 +
>  tests/nvme/010 |  1 +
>  tests/nvme/011 |  1 +
>  tests/nvme/012 |  1 +
>  tests/nvme/013 |  1 +
>  tests/nvme/014 |  1 +
>  tests/nvme/015 |  1 +
>  tests/nvme/016 |  1 +
>  tests/nvme/017 |  1 +
>  tests/nvme/018 |  1 +
>  tests/nvme/019 |  1 +
>  tests/nvme/020 |  1 +
>  tests/nvme/021 |  1 +
>  tests/nvme/022 |  1 +
>  tests/nvme/023 |  1 +
>  tests/nvme/024 |  1 +
>  tests/nvme/025 |  1 +
>  tests/nvme/026 |  1 +
>  tests/nvme/027 |  1 +
>  tests/nvme/028 |  1 +
>  tests/nvme/029 |  1 +
>  tests/nvme/030 |  1 +
>  tests/nvme/031 |  1 +
>  tests/nvme/rc  | 16 ++++++++++++++++
>  31 files changed, 46 insertions(+)
> 
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 955f68da026a..ca11c11c9a09 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -12,6 +12,7 @@ DESCRIPTION="create many subsystems and test discovery"
>  requires() {
>  	_nvme_requires
>  	_have_modules loop
> +	_require_nvme_trtype_is_loop

Same comment here, chain these with &&.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
