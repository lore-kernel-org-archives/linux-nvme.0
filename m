Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDF2C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 21:51:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23A0206D7
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 21:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tb+LQpmu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jJj0E9ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23A0206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xKKWI+yjXd7wYMY2ejDjlISsOP1lmfFtqWaRLn8Cy7s=; b=tb+LQpmuGihnQe
	F05wize+FXxJhtpmK0CfnsClTxUGuqLUbawy3vptpORQ8L9fFZtWCaZKRDWuUabWiccMzTC8A6ndR
	QfqYOo+AgtXnQIdbuxeNxJ7RRks1xaxdf04h9ySZorxJQeMC3C5kXaL9Rn7thYhIM28gpPV6yG5as
	rsBb1JzHSWowZj3r3rNBjWvmueqogCQRTuoPTJFckb0zhdwrzwBEFJzkOdE6Ku6K39jgjhqsBWw61
	zBSMvMM3D3xCIe1szEd9oQJjRCHmBi9QHnDZin+W+T6xNIl4fjseurKKbGunWmixE9tR06cAkA8aj
	Q60ellxjuOklu6rqv2KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1dQs-0003y7-5N; Tue, 11 Feb 2020 21:51:02 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1dQp-0003xg-W2
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 21:51:01 +0000
Received: by mail-pf1-x441.google.com with SMTP id j9so101881pfa.8
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f5N2DUlbv6z/GteGd/EGhO/3U8m5u/E+jnsXlDakez8=;
 b=jJj0E9ijZ6+sC99SDS/dAEQLDCqW3lG3g02rfsR8NdtjyF0QwlEOzXcRfDGLXRZTk4
 uZkklh0k5yF6W9mV7r2QFANEmtswTMADwPk1If8ZrsMEZiC8xQ2XdPlOPmPcVD+XGjoa
 jSmd8/E9rpwisrmN2kLLocaRMubaDTDaAGKHSx64kB9k7Sy+TmG41n9HbMNFAXUGS0Ur
 6tRtdtjvneygy5Y8D25FSrg53J/NTPKQylg32+i8IxWJBLceazo3gmM/HqOKGk3YGmpU
 snpDWYxbAMU/vUEHqdseqZh6p/Vnz9dckcX8jmphwgZL7jt25eO8RJoWgobv/lUQE6jG
 3ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f5N2DUlbv6z/GteGd/EGhO/3U8m5u/E+jnsXlDakez8=;
 b=jp66YdstxEnVgm2LZayo+uezq232eWA6dhXAT7NxkSUeFtblQCQfDbgQ2bBtlEA0M1
 dYqxFEuDxpxmoPcoaK8fqLFElWl2NvwiS5ezjlzE0nvUw6F4jLGxe71+tbpuh1M2th4J
 Ai3eH8Qk2X+WxO3d9z6vh6NSQyDeRvBfw+3rkEWetN0vH2hi1dQzRPfOzNgIPxlOTTvR
 kAuL0VlN5HpDpRaCj9etAzk0DOLn+fYKrDug7tgIJFMZDF0rgZ8hzjFzlXg+nvQkyna+
 LEjOGRqUJJ2iZw0Fqp4ayu7ExcW4qvfWrKTGuLfAVhLiuIukgwstrrmlg7oI4TOG3dAy
 sPaA==
X-Gm-Message-State: APjAAAU74CjQNYtvprOmau4fRPS0UwGUA2ujAP77xFRXlUS7ys92QpPq
 5Q1Fnmkp741SDPpF0hm/ZIJ9ozQokXY=
X-Google-Smtp-Source: APXvYqztEKW1pNjfCbxdS8jY+0OSwbjX+iBe/EgNf951ms4uspX6jVEZ07itJ3mFQYj299xMNKUb/Q==
X-Received: by 2002:a63:5a11:: with SMTP id o17mr9146286pgb.60.1581457858499; 
 Tue, 11 Feb 2020 13:50:58 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
 by smtp.gmail.com with ESMTPSA id d15sm5372630pgn.6.2020.02.11.13.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 13:50:58 -0800 (PST)
Date: Tue, 11 Feb 2020 13:50:57 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/5 blktests] nvme: allow target subsys set cntlid min/max
Message-ID: <20200211215057.GB100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_135100_055327_EFDC0D4C 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 29, 2020 at 03:29:17PM -0800, Chaitanya Kulkarni wrote:
> This patch updates helper function create_nvmet_subsystem() to handle
> newly introduced cntlid_min and cntlid_max attributes.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/rc | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 40f0413..d1fa796 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -121,11 +121,18 @@ _create_nvmet_subsystem() {
>  	local nvmet_subsystem="$1"
>  	local blkdev="$2"
>  	local uuid=$3
> +	local cntlid_min=$4
> +	local cntlid_max=$5
>  	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>  
>  	mkdir -p "${cfs_path}"
>  	echo 1 > "${cfs_path}/attr_allow_any_host"
>  	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> +
> +	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
> +		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
> +		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
> +	fi

This has several shellcheck warnings:

tests/nvme/rc:132:26: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:133:8: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:133:24: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:134:8: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:134:24: note: Double quote to prevent globbing and word splitting. [SC2086]

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
