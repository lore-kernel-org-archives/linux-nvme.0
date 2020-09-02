Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099DFC433E7
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 21:12:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EF320758
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DZ9zP4Vq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="IUn+kfTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EF320758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fWrVZLUdn/T7wNcGnxptHGNH8l7PDpDrmMx+PWZrf7c=; b=DZ9zP4VqeJzGzEzf6soh8odF6
	RFfGoIqttHiOucqgrnmeKEeC2Bd9zXVHpZcdgpvfb9gP5MKFrR1EVFeXxxX84MjZcepMiG9OBgUyk
	9Fjo7n70Rmtu1kK5hCys6dKXHeQypFTnzhH4UTx2yDpS2niOEOYvLC3NLPT8GofyaWi8hNbZZ8dGm
	F2ZpKHZbU6t1ks2hwO+LzsNDQEacqeotmA3Fd1j/zLtW+o193W483Kb96tV2eXP/4E2lDDzdX0hRg
	pO5pwNGyQtrXS113+G0NvyiFgeIz/Jbw1jOAhmrY8wV94ZnkyocH5EKckSEml85DK+RGtIzR39Pm+
	HBn7wAmeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDa3L-0000Qi-37; Wed, 02 Sep 2020 21:12:23 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDa3J-0000QN-Ji
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 21:12:22 +0000
Received: by mail-pf1-x444.google.com with SMTP id u20so410133pfn.0
 for <linux-nvme@lists.infradead.org>; Wed, 02 Sep 2020 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=e1KyvAJdZPY3OAESloO+vNAm7aY5HkvjR9Pw1mjyuuo=;
 b=IUn+kfTUPjwPrIWsiEx/BhMsCIAhQE4wZxA9/EyqrHFyoLy/f8QnGt3h5b52ZxQ6Ip
 EEdMEnDPb7q52FObXb4s+xxr4EJe1/Ys/dzNm1z7DaH8uBtWsPNgW8QyttvQ5cc5hL8d
 tO59raGlDVLKtY4iqnl+YIXA5dP4LHIqXJSDv17T9wjh8Dl6sPee4QXsy4PxsxdSPtJp
 kZI9xaw1LYjaPoavAmQEuG6M09MmSsxNLIM8ec537v2zmxhbMayRPqUlIvjObk0I3PiC
 gBE/K6K5MQyKmtavtFT1lyMfWwwRCBOnWPDIpJF7JIIJXzOxxr9rdFQE0nKf8H0HBSSB
 wT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e1KyvAJdZPY3OAESloO+vNAm7aY5HkvjR9Pw1mjyuuo=;
 b=JX5bxGwRzTbL/qDgwp8RXoKDVJmnCWkaC7Q+Lxfp50xsJ/gsjmVgUaCY4x2gONpL4g
 1WYkPMwzvDL/j9VMba+lIaaYjcoewZJXrxg2a2NIOMVR/MYPCV5tt1QYZ+snJD2+z2hK
 yg416M9Vr7GUQuvasiTMjJb9iA/6sxpq1vRxYiLBbnjkhsV4NlgUeUXN8xcLIA9ImOTb
 lu9DDk6SN3M5uPYrGJf2VfcOjhejeWtj/h6pQsBqw7l6taYJy3TEcyM3Etmu1lgsSGgD
 KHTTBgWu1WX1hYvBqHSUWL/vNe+U3OTkDW3wy6kHYADDfDCSx10UhWyxIyhX1+Pk16x+
 1x5w==
X-Gm-Message-State: AOAM533UlhVukzRvqFWL8TRma6i9Ma3SrvPASJC8Sqkmx2VGya6pQHUn
 gxd3UCPICQBbxumgS7zoYMG7aw==
X-Google-Smtp-Source: ABdhPJwjxDVo74Vc3aHLNNkHahQKmG0Dy1knJqOjfLiJOY+Y2r5b8vLM40dwkRIBKTWqeipBh94JSQ==
X-Received: by 2002:aa7:8b01:: with SMTP id f1mr315223pfd.35.1599081137631;
 Wed, 02 Sep 2020 14:12:17 -0700 (PDT)
Received: from exodia.localdomain ([2620:10d:c090:400::5:1aee])
 by smtp.gmail.com with ESMTPSA id ie13sm325924pjb.5.2020.09.02.14.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 14:12:16 -0700 (PDT)
Date: Wed, 2 Sep 2020 14:12:15 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nvme/005: add the missing _have_program nvme
Message-ID: <20200902211215.GA611393@exodia.localdomain>
References: <20200902072757.32187-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200902072757.32187-1-yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_171221_744344_D66C746F 
X-CRM114-Status: GOOD (  15.75  )
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
Cc: linux-nvme@lists.infradead.org, jthumshirn@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 02, 2020 at 03:27:57PM +0800, Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvme/005 | 2 +-
>  tests/nvme/030 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvme/005 b/tests/nvme/005
> index 8c79d23..325f2b6 100755
> --- a/tests/nvme/005
> +++ b/tests/nvme/005
> @@ -13,7 +13,7 @@ QUICK=1
>  requires() {
>  	_have_modules loop nvme-core nvme-loop nvmet && \
>  		_have_module_param_value nvme_core multipath Y && \
> -		_have_configfs
> +		_have_configfs && _have_program nvme
>  }
>  
>  test() {
> diff --git a/tests/nvme/030 b/tests/nvme/030
> index 94020f4..fa68ff1 100755
> --- a/tests/nvme/030
> +++ b/tests/nvme/030
> @@ -36,7 +36,7 @@ test() {
>  
>  	echo "Running ${TEST_NAME}"
>  
> -    _setup_nvmet
> +	_setup_nvmet

Thanks, applied (with this unrelated hunk removed).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
