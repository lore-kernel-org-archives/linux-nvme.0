Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153BBC3F2CE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 01:30:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45E520866
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 01:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rgiUg7Cs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="LC5kWgn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45E520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zmrMxDHLpWa1N9we5vrptttgJ/+Uz+s5+FO3+4L1o+c=; b=rgiUg7Cs3/ROzM
	S261nYjqiZ9x8RIOZPV2+Zv3dVO6EwBYcbYy5sq3Y3btV5TjDsJh82uzduPpqNvR69w1tWZ6EtI4V
	k+nyvnTHoiaOeY0anbU+6Ucu7d4VLmcEi5HZ5iidXAqgpiRPVbmitT5yx2ZyR50GHgWw5jwQA7hQ8
	NtjQVYtMNWeHDzkZk2Ef0+3fOt81AQb1l/2EFlWEnHa/fUf4OGFJFQbRKXMgEI2Uanq9sVcgIA6zD
	i0zc1+ZvOSErgaz/6B6GHpHkbsrCJCrVdT1Ohxeu4LeFx9xnPamaU6BjyLvGk67Zji9GgjggDrWWJ
	eMEZW4CS08/+gPM7+PHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9fL6-0000T6-2d; Thu, 05 Mar 2020 01:30:16 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9fL3-0000SV-85
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 01:30:14 +0000
Received: by mail-pl1-x641.google.com with SMTP id u3so1878416plr.9
 for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2020 17:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2thFv659sj5d5Ni5yvxP9gN4h9QVhmEBZCNJK4/mccw=;
 b=LC5kWgn4gVrcc3CXLwwUflPsmsrXBAFgvX6JoZ19giCkmkr9PCA8UdwIEqJy/Akoq1
 j6bMTALPVmIrLpToXZNyjrMh2MjA6z+fcI+2Ggn/BZxvjrEkmdi4ARMDB9fXDmBXcNcf
 6LUt2pjTI3biJBSQyuZop/+KpDpscB2RX1dFyF33KC5Ts9UF54BjgceFI8owpjDZa3iw
 SGALYYVoR+lQxsUrITkJ9KinfidM5Kwz+L2GWZGfr8zF9+jjhVSoCe1gYYrfcnd9dQXh
 8ioecMxkIa/w/MxVQnWgEQ52BgzYC3yhmNOLG8XXzs/mtmJj9EXU8mzxHMWdbBRrEV77
 mgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2thFv659sj5d5Ni5yvxP9gN4h9QVhmEBZCNJK4/mccw=;
 b=Pxg5R38RpN/8La2IwFLPfcT8Fj/Ta6hUyOTtIbsknKSgWAFjh2HrQZDnuRAnoLmuPV
 xAqGdPasapx9tLAjrR/Lk/fDv/Ad771mcsV7NppRGBGG/HUJUU4BhCOO8seXNZARNIWV
 Ta5E83wI2L367y12J7PK8tJNOx0fmQQNCKm52JsIQi5HOL08fbOPy4uKruQ6ZY1FLs5e
 tYeFTp010hw6e1Zw3muWB1BRnSCq0Buyyb/wSHygNJY6Ie1ZZqTaFQXemvDWOKmJw4wT
 gEaDzij8URXD5xaLenUx8f3e90S0/cCFUANTYYA2mcznrTv3aaOUW58DU129CH6lmlbO
 GWEg==
X-Gm-Message-State: ANhLgQ1Z0kmLBmuOyWvkeuD0xSgV11J3jBcx5mN8Ta2WrUw+fhtWG4+7
 92ob3Rba4+PgLtJczn6WX5tLI3SiIc8=
X-Google-Smtp-Source: ADFU+vt+xtLO79oB84p7YASWE2WmLbGoCdm+hk/v+HYCths5SJYrRkJ4dp6xdWmregj7/mqFdlCLeQ==
X-Received: by 2002:a17:90a:2e05:: with SMTP id
 q5mr5788717pjd.68.1583371812000; 
 Wed, 04 Mar 2020 17:30:12 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
 by smtp.gmail.com with ESMTPSA id a71sm14651551pfa.117.2020.03.04.17.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 17:30:11 -0800 (PST)
Date: Wed, 4 Mar 2020 17:30:10 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests V2 2/3] nvme: test target cntlid min cntlid max
Message-ID: <20200305013010.GA293405@vader>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
 <20200215013831.6715-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200215013831.6715-3-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_173013_314516_B934BCAC 
X-CRM114-Status: GOOD (  16.48  )
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
Cc: linux-block@vger.kernel.org, osandov@fb.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 14, 2020 at 05:38:30PM -0800, Chaitanya Kulkarni wrote:
> The new testcases exercises newly added cntlid [min|max] attributes
> for NVMeOF target.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/033.out |  4 +++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/nvme/033
>  create mode 100644 tests/nvme/033.out
> 
> diff --git a/tests/nvme/033 b/tests/nvme/033
> new file mode 100755
> index 0000000..49f2fa1
> --- /dev/null
> +++ b/tests/nvme/033
> @@ -0,0 +1,61 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
> +#
> +# Test NVMeOF target cntlid[min|max] attributes.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
> +QUICK=1
> +
> +PORT=""
> +NVMEDEV=""
> +LOOP_DEV=""
> +FILE_PATH="$TMPDIR/img"
> +SUBSYS_NAME="blktests-subsystem-1"
> +
> +_have_cid_min_max()
> +{
> +	local cid_min=14
> +	local cid_max=15
> +
> +	_setup_nvmet
> +	truncate -s 1G "${FILE_PATH}"
> +	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
> +
> +	# we can only know skip reason when we create a subsys
> +	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> +}

Sorry, I wasn't ignoring these patches, they just made me realize that
we really do need a way to skip a test from the test function itself, so
I wanted to implement that first. Could you try rebasing on my skip-test
branch (https://github.com/osandov/blktests/tree/skip-test) and
reworking this so you don't have to split the setup between requires()
and test()?

> +
> +requires() {
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> +		_have_configfs && _have_cid_min_max
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	PORT="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
> +
> +	nvme connect -t loop -n "${SUBSYS_NAME}"
> +
> +	udevadm settle
> +
> +	NVMEDEV="$(_find_nvme_loop_dev)"
> +	nvme id-ctrl /dev/"${NVMEDEV}"n1 | grep cntlid | tr -s ' ' ' '
> +
> +	nvme disconnect -n "${SUBSYS_NAME}"
> +
> +	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
> +	_remove_nvmet_subsystem "${SUBSYS_NAME}"
> +	_remove_nvmet_port "${PORT}"
> +
> +	losetup -d "${LOOP_DEV}"
> +
> +	rm "${FILE_PATH}"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/033.out b/tests/nvme/033.out
> new file mode 100644
> index 0000000..b1b0d15
> --- /dev/null
> +++ b/tests/nvme/033.out
> @@ -0,0 +1,4 @@
> +Running nvme/033
> +cntlid : e
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> -- 
> 2.22.1
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
