Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD3C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF9E20714
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tIXTplhG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="x71SarPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v4PIkNxGPSViyirWDmLOSNFZ+KNYzerjiPv9zmNvzto=; b=tIXTplhGKXCPXY
	WZ1mLArDX9llWH9T9qAUt5mgNegvpyeZR/ya/k8YIjdJEGiS6yu9ppKEcg8bMz1mL05NagB6NQON6
	lihBwlReuH7VBBCqAY9yUHNUKYR6N20MCa3tNr/Du1q55alS9Hu/Xrm+e1YnEjGYWk4SvGOYZ2PQA
	r9Xnw4+CpUIabxs1w5TOIUnfLwJN4F4uxKgPqU2cq13bwcnbNR6KKKE+AjAZR+p8vUZiFXcIEvctY
	SGWqJ8Zd8eSi3oca8mURcXNMe8UTrg3wO6KVBsm4n60nCMgagL7sUcADSuNhEU4Igy4BQfSDSBGAs
	19wJXLCzn9/B+rnMx64Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1ddv-00084o-5q; Tue, 11 Feb 2020 22:04:31 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1ddt-00084L-4d
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 22:04:30 +0000
Received: by mail-pj1-x1044.google.com with SMTP id m13so1858892pjb.2
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ofdE0/BkV9/IevyyDrVK7PvogL7v8E+hcQz5pcDIuYw=;
 b=x71SarPt20Wb73D4ygd5wAwFOcbzeVdtXl2McQyfkupXZBS1PZc+M3zBBEOXnX1Lpb
 87Lu0kSBHGHsz2u4e3BkN0xEy/crVlDfCHzjPlpenvhl+IGS0mRvvC4jp162aGwOeGD2
 2pA5onubyuXO+64KU4RmozW/frriPEDTu2MfAWto9ZKDxj0QJ87jP9jcHoEAkrzPodaw
 xKSwIszJ/mw+oLBP2/U7/Lic8QML4HehKsyRJjJN6CXEUVMokMB+ulK/F4Xgpe6NZdqR
 Jx3F3CdMksVaT0GZjhDA2H1O4ZfrV14s7X6Xz6cL1tR768+E3Zk5x1E378Xex7Cue4iM
 4D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ofdE0/BkV9/IevyyDrVK7PvogL7v8E+hcQz5pcDIuYw=;
 b=jMnqQyu2zE1A8jGGUKAryWx3DCUhSnnc1eU2eIfOOq4rBBdYHUBp2yQLIIjRgqoilO
 HSUZwQODm0jSU0oZ7u+TvwBLCNq6AjlpM1Yi4wMikI+25WTxvxAacLyCXczFWiYHICF7
 9OAx8uRlLhLACvgvmfHltWssDIuFnlRD9yH7pcpzu9Bmx3jaPcPx7LPdZVERtSBLT2n1
 rJ0rIoCxFcrN5tUGblPNnn9DxBa9FU1nGYim/j92LTm/HZN9uswIGA7jjZ8F/cLxxpeq
 CpOKxpuXS23G6iPdCJTBCPvP8jRnc9b2WnZAwSS0sXDuZahlT9zF8DSdfbQ2B9NcIsBt
 wLPA==
X-Gm-Message-State: APjAAAUh7LHjRs3GZpon/Ht3LfcwSBmC4nFOp5k6cCjtE6lLWRQaghsj
 c+k0IkFhY1BPiFiWWuSyhAiOBQ==
X-Google-Smtp-Source: APXvYqyVIg6t3k7ZDhQl+hAAYZNEZ7XKDQUBG1fRRv6+Pai/Qrk6AF9zfIjDsczSOVzqAaSLRt3SHA==
X-Received: by 2002:a17:90a:d990:: with SMTP id
 d16mr6022270pjv.143.1581458667555; 
 Tue, 11 Feb 2020 14:04:27 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
 by smtp.gmail.com with ESMTPSA id d4sm4451197pjg.19.2020.02.11.14.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 14:04:27 -0800 (PST)
Date: Tue, 11 Feb 2020 14:04:21 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 4/5 blktests] nvme: test target model attribute
Message-ID: <20200211220421.GE100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-5-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_140429_181941_32298E32 
X-CRM114-Status: GOOD (  16.08  )
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

On Wed, Jan 29, 2020 at 03:29:20PM -0800, Chaitanya Kulkarni wrote:
> The new testcases exercises newly added cntlid [min|max] attribute for
> NVMeOF target.

Model, not cntlid, right?

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/034     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/034.out |  3 +++
>  2 files changed, 63 insertions(+)
>  create mode 100755 tests/nvme/034
>  create mode 100644 tests/nvme/034.out
> 
> diff --git a/tests/nvme/034 b/tests/nvme/034
> new file mode 100755
> index 0000000..1a55ff9
> --- /dev/null
> +++ b/tests/nvme/034
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
> +#
> +# Test NVMeOF target cntlid[min|max] attributes.

Same here.

> +. tests/nvme/rc
> +
> +DESCRIPTION="Test NVMeOF target model attribute"
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> +		_have_configfs
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local port
> +	local result
> +	local nvmedev
> +	local loop_dev
> +	local model="test~model"
> +	local file_path="$TMPDIR/img"
> +	local subsys_name="blktests-subsystem-1"
> +
> +	truncate -s 1G "${file_path}"
> +
> +	loop_dev="$(losetup -f --show "${file_path}")"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}

Since the cntlid doesn't matter for this test, maybe you should be able
to pass them as "" "" to _create_nvmet_subsystem so it can ignore them?

> +	port="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +
> +	nvme connect -t loop -n "${subsys_name}"
> +
> +	udevadm settle
> +
> +	nvmedev="$(_find_nvme_loop_dev)"
> +	nvme list | grep ${nvmedev}n1 | grep -q test~model

Can we do

	nvme list | grep "${nvmedev}n1" | grep -o "$model"

And have that in the test output rather than checking the return value?

> +	result=$?
> +
> +	nvme disconnect -n "${subsys_name}"
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	_remove_nvmet_subsystem "${subsys_name}"
> +	_remove_nvmet_port "${port}"
> +
> +	losetup -d "${loop_dev}"
> +
> +	rm "${file_path}"
> +
> +	if [ ${result} -eq 0 ]; then
> +		echo "Test complete"
> +	fi
> +}
> diff --git a/tests/nvme/034.out b/tests/nvme/034.out
> new file mode 100644
> index 0000000..0a7bd2f
> --- /dev/null
> +++ b/tests/nvme/034.out
> @@ -0,0 +1,3 @@
> +Running nvme/034
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> -- 
> 2.22.1
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
