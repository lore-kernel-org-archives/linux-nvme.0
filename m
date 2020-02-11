Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A42C352A3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:00:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903D920714
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcAVdnjm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Nn6Q+Q9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903D920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l4QSGDELRLCsMMkpKrFNqGzXTd7wtal0xNDWbZ8B6Bs=; b=gcAVdnjmGlJRi0
	S4BYxazY6dwnwszUR1w4vaKzDIMLG0t4ODtgayPScsoLKZZ10YCDiIFsulCI1QKPN5nVTI75Ka+In
	nT3/zYhtp6K1wxw57b6ZYe0iY8vsPJgmWHb7iuhnUNT5NdoBNit1zGEMYoOmbJtsWj6Oule37Tw80
	tTc3JkaDwQD7QSaK6Al4e/Au6wePnzZRD5+GkAgbcuxn4ZN+GLmMzX/HppsFvlxlYrYLrFm0YyxR4
	IOAUVH52kqFwuhgG3BPQBlspV/nRn4P2F2R+uwhOlae3Luv0NjtmGGu0MtaXdCYx7ULYzDdxjplH5
	82Tgjw2WELwxS2/F9jVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1dZh-0007Lk-KO; Tue, 11 Feb 2020 22:00:09 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1dZe-0006kt-Te
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 22:00:08 +0000
Received: by mail-pj1-x1043.google.com with SMTP id n96so1955041pjc.3
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5z04d/7QYXumo3rw61Z10oa4qSG/Keet1HCis3VcD3w=;
 b=Nn6Q+Q9B4/Gh6yJdcQvXoERyjS5R/tEYzIv4Ma7KhC3awte2DBVS3MvvNwzzyn37WI
 m0OmBc2gYWi6qo5pmvcO4vm4Aj1H3oPaIDzG6KMgnsPVapN4QKchJRX+mTJxdA9wqoES
 w6v91+2HkcqmxLHMpCc7YaBK7DiNCqdUvHrUBN/79cqA6TgkeaSEi7Pt++r7h8O/URXW
 sqIedqlVMgMBZEU2LrKVPLxJditw2DXZHN55bdFjhO+x2pKW/3HNopHUUFy+Zlm6XVrE
 lgMHpZmF/A4YjtaPDg1TNuRm4kudmxzFq0WSRmV6XFlz/PCZ66JU5bq1x7KUHGNoKqz8
 9vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5z04d/7QYXumo3rw61Z10oa4qSG/Keet1HCis3VcD3w=;
 b=L7N7C21EGQJV1d947IncTYbMBu0In1QMO798OtXfqT+7n0zvCNqTcq52PdfSY57Kn+
 7x+11o6If/FQgTCjTXGZ1L7a7qFeio4qvcIxNIf2C5g7v3kxDTU89uH50g3gzYLqIeok
 u3yqBp0sdjg1JPBabQBqpUNMrVXm5tCH1TUZdYbz77iVq8gzV6p/SE5DDBZmWJyeEmjy
 pjBzmLxE41bRm3HCz5hOlm/JZj0Dt5v0gJVy5b5+YgehzXlU261/hbodkgaOOiWabndf
 6d7NtOaLhIEvIc3F8fnbGVeizrq+zhvqxgQUfl2Fx9X+Xep0i0oGoxsb3eZP4n9f3nlS
 zvaA==
X-Gm-Message-State: APjAAAXsMGzLblof9sUb48h5rXuJGAD4fQFWfpP3RgQeMCP7P3AXLThr
 OD7Q462KsfLNk2B3APvc0j+40g==
X-Google-Smtp-Source: APXvYqw/yOxnUL1nCMjno4b8EaPU9LEX6QiqVuOEEjCYgojww1T1x7XQikzbA7Y5zj3T3S5ZKSla0w==
X-Received: by 2002:a17:90a:26e1:: with SMTP id
 m88mr6031311pje.101.1581458405067; 
 Tue, 11 Feb 2020 14:00:05 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
 by smtp.gmail.com with ESMTPSA id q21sm5230684pff.105.2020.02.11.14.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 14:00:04 -0800 (PST)
Date: Tue, 11 Feb 2020 14:00:03 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 3/5 blktests] nvme: allow target subsys set model
Message-ID: <20200211220003.GD100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_140006_974895_B5899148 
X-CRM114-Status: GOOD (  14.14  )
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

On Wed, Jan 29, 2020 at 03:29:19PM -0800, Chaitanya Kulkarni wrote:
> This patch updates helper function create_nvmet_subsystem() to handle
> newly introduced model attribute.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/rc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index d1fa796..377c7f7 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -123,6 +123,7 @@ _create_nvmet_subsystem() {
>  	local uuid=$3
>  	local cntlid_min=$4
>  	local cntlid_max=$5
> +	local model=$6
>  	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>  
>  	mkdir -p "${cfs_path}"
> @@ -133,6 +134,9 @@ _create_nvmet_subsystem() {
>  		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
>  		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
>  	fi

It's not in the git diff context, but the line above is

	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then

So if we pass 6 arguments, the cntlid arguments are ignored? These
checks should probably be -ge

> +	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
> +		echo ${model} > ${cfs_path}/attr_model
> +	fi

More shellcheck warnings about unquoted variables.

>  }
>  
>  _remove_nvmet_ns() {
> -- 
> 2.22.1
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
