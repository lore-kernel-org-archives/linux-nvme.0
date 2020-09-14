Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB967C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 21:52:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4B6208DB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z73uOSYX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="UolNJ2Qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4B6208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ToAP7rUPxe0TZAHp9fLf3YImvcdrZwapEhEffFnDs5g=; b=z73uOSYX5uJ0OZeG9R1zu6JW5
	0t2Xp6h4FQI3UY0oyRZXRtJQ4csU/6BknD9xxdVkLkSEkHsC/egoj7pBKtmTfscALwjeekKMhpx5p
	ghgn0rndImRsxXjdPwZ9YspsBZKTX78AJKjY6fBwBYvT3ZNsoN27TE2WPY+TZKEkreyOS0krUwm2U
	USht20vWkteWJhLrq/i5vqNZWHatS2jqBsVR0xhdQr0VirDnEC1Ucz+pbOszYbI5yAiGsW3m3rjl3
	gIQUek/HqstErDXcn7BS4hx3YGdVcl+HJMgy54VWhQMQj6+D/RxvRdvJ4xSSUHm4oNhT33gNfl0VC
	5HHUG7C8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHwOW-00060M-0I; Mon, 14 Sep 2020 21:52:16 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHwO8-0005nX-MQ
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 21:52:07 +0000
Received: by mail-pl1-x642.google.com with SMTP id y6so199199plt.9
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=U4dxBL5lsmUkAnRogiSWrIkPaB8LDdppIlQGHsnDf3s=;
 b=UolNJ2QrHl5bJzfiY97waQhgIfmDggCUlurXebJZfDpv5AU1uECOQW4XpejtQi+a4c
 NR74FPUqE9dJce1uJdRvJHFCUFu6CHm/Af+pIWojCVSB2HwQghpQlXxF7Rje0s1V3h1g
 1zdXeG05lfMDZuVmrr1CYvVNbMSr5FDfeSzxSWj2Qu5bDtEbiJXpxl4pT/h7zkfG78nN
 YbgDX7ho1nr7gBUMJA3jronPFskeO1JvRZkeOQd/r7SPe1dwFNuRUZ2Ls/bcRE3nhWrA
 ezruUgESaChPH/FzgByPzkliX3RsDQ5Na2I/2Ovm9aEigLrOsOjqESrbBz/770rUqKWX
 fpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U4dxBL5lsmUkAnRogiSWrIkPaB8LDdppIlQGHsnDf3s=;
 b=s3VnqpRqZofsvvSmHnDyGMudPSMzFm7WIV8IV9FThtW2lGEw79ed/gy1v4lyU6tdzW
 7FMTv+paDbA3FlaskfR8qG1AJ+GW92+LJX3yUHlFg2bGDMQuI5K7tb4JF+h/Y1zoraxe
 tziHnwSiYOjXQiojgODFwcIsTamikEhFe24logX/p38g3AubRY6YGqZyCJ+TJSuWV6PV
 7sPxF+ysc/Sus2NB/idJP4eFL9Eg0mVQZhzZWTT2T3Bazk0Ecl+MTfyCA+r2GQTsOsvj
 FbMNkxR89WHx6InXsEYARlUYCaf0YJyRqhlb8uz2yPpPjIi5csXZsX0SuSba/PWCTOmc
 DcIg==
X-Gm-Message-State: AOAM530kaWY71t+PaQtxFHfaTEnFDPQ0qNjFq6/pYUTTxMNDv1W0awgy
 wI11Xf5qzYDvR7d0ruwZremCbX+FcPvQWg==
X-Google-Smtp-Source: ABdhPJyP+D4YKKuBg6KbuMnPfeL7dQy3WoAqrudqf1dGVbBlzm33dC0AmOwaIIbSl+HpX+r9+vat9Q==
X-Received: by 2002:a17:902:9f84:b029:d1:cc21:9a49 with SMTP id
 g4-20020a1709029f84b02900d1cc219a49mr5097477plq.9.1600120308225; 
 Mon, 14 Sep 2020 14:51:48 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
 by smtp.gmail.com with ESMTPSA id z22sm11496450pjq.2.2020.09.14.14.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 14:51:47 -0700 (PDT)
Date: Mon, 14 Sep 2020 14:51:45 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Message-ID: <20200914215145.GA148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903235337.527880-2-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_175152_907505_C01907BF 
X-CRM114-Status: GOOD (  25.78  )
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

On Thu, Sep 03, 2020 at 04:53:31PM -0700, Sagi Grimberg wrote:
> Right now, only pci and loop have tests, hence these are
> the only ones that are allowed. The user can pass an env
> variable nvme_trtype and check for the necessary modules.
> 
> This allows prepares us to support other transport types.
> 
> Note that test 031 is designed to run only with nvme, hence
> it overrides the environment variable to nvme_trtype=pci.

Thanks, Sagi, this is a nice cleanup. Some comments below, though.

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/002 |  3 ++-
>  tests/nvme/003 |  3 ++-
>  tests/nvme/004 |  3 ++-
>  tests/nvme/005 |  6 +++---
>  tests/nvme/006 |  4 ++--
>  tests/nvme/007 |  2 +-
>  tests/nvme/008 |  4 ++--
>  tests/nvme/009 |  2 +-
>  tests/nvme/010 |  4 ++--
>  tests/nvme/011 |  4 ++--
>  tests/nvme/012 |  5 +++--
>  tests/nvme/013 |  4 ++--
>  tests/nvme/014 |  4 ++--
>  tests/nvme/015 |  3 ++-
>  tests/nvme/016 |  2 +-
>  tests/nvme/017 |  2 +-
>  tests/nvme/018 |  4 ++--
>  tests/nvme/019 |  4 ++--
>  tests/nvme/020 |  2 +-
>  tests/nvme/021 |  4 ++--
>  tests/nvme/022 |  4 ++--
>  tests/nvme/023 |  4 ++--
>  tests/nvme/024 |  4 ++--
>  tests/nvme/025 |  4 ++--
>  tests/nvme/026 |  4 ++--
>  tests/nvme/027 |  4 ++--
>  tests/nvme/028 |  4 ++--
>  tests/nvme/029 |  4 ++--
>  tests/nvme/030 |  5 ++---
>  tests/nvme/031 |  5 ++---
>  tests/nvme/032 |  4 ++++
>  tests/nvme/rc  | 19 +++++++++++++++++++
>  32 files changed, 80 insertions(+), 54 deletions(-)
> 
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 07b7fdae2d39..aaa5ec4d729a 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -10,7 +10,8 @@
>  DESCRIPTION="create many subsystems and test discovery"
>  
>  requires() {
> -	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
> +	_nvme_requires
> +	_have_modules loop

Bash functions return the status of the last executed command, and the
requires function needs to return 0 on success and 1 on failure. So,
this is losing the return value of _nvme_requires. Just chain multiple
checks with && to fix this (here and the other places _nvme_requires was
added with other checks):

requires() {
	_nvme_requires && _have_modules loop
}

> diff --git a/tests/nvme/010 b/tests/nvme/010
> index 2ed0f4871a30..53b97484615f 100755
> --- a/tests/nvme/010
> +++ b/tests/nvme/010
> @@ -10,8 +10,8 @@ DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
>  TIMED=1
>  
>  requires() {
> -	_have_program nvme && _have_fio && \
> -		_have_modules loop nvme-loop nvmet && _have_configfs
> +	_nvme_requires
> +	_have_fio _have_modules loop

Looks like these two got squashed into one command. It should be
_nvme_requires && _have_fio && _have_modules loop

>  test() {
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 0d0d53b325e6..017d4a339971 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -11,11 +11,15 @@
>  
>  . tests/nvme/rc
>  
> +#restrict test to nvme-pci only
> +nvme_trtype=pci
> +
>  DESCRIPTION="test nvme pci adapter rescan/reset/remove during I/O"
>  QUICK=1
>  CAN_BE_ZONED=1
>  
>  requires() {
> +	_nvme_requires
>  	_have_fio
>  }
>  
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 6ffa971b4308..320aa4b2b475 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -6,6 +6,25 @@
>  
>  . common/rc
>  
> +nvme_trtype=${nvme_trtype:-"loop"}
> +
> +_nvme_requires() {
> +	_have_program nvme
> +	case ${nvme_trtype} in
> +	loop)
> +		_have_modules nvmet nvme-core nvme-loop
> +		_have_configfs

Same here, _have_modules nvmet nvme-core nvme-loop && _have_configfs.

> +		;;
> +	pci)
> +		_have_modules nvme nvme-core
> +		;;
> +	*)
> +		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
> +		return 1
> +	esac
> +	return 0

This return swallows the return value of the checks. You can drop it.

> +}
> +
>  group_requires() {
>  	_have_root
>  }
> -- 
> 2.25.1
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
