Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02538C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 21:58:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECD220714
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 21:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KgVp8Bib";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Sds6FgZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECD220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qNqVP2tQt4iO7ge/I5cyhSfJRLCNx19/FuFFGOPmyho=; b=KgVp8BibWXkgg+
	b4StnLiOUSfJUmEPpPYG6QbDQTB7yjRHkntLVCRAwXXUHvxJlNUrDOCGwRV1wbtGVKm4eTydiOhUu
	0+9WXVFgJUDPocIxZOuNDJP3xEYk+FtmGb/CLNOtsga7m+sHXuQXBzNGQLNFodh1DtE2+SEgtTL4Q
	iBLynHp2hJ7qgggalyr9qCU4/+227KcBqMPfdoqpIu0WLSdIicL0DmDi2cPgGrfIAl3FkYb6YwBoq
	gzajx/4jI4RV9hvJQl6feD7f6ekX2OTpudRRHfn6VXGwtKFPrxz14swni4i8h/hlkC78XMYkZz0Ew
	yvHdlIGrxT3jTqImkugg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1dXt-0005rv-M6; Tue, 11 Feb 2020 21:58:17 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1dXr-0005rT-7v
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 21:58:16 +0000
Received: by mail-pl1-x643.google.com with SMTP id c23so93991plz.4
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HCBRdtAuyh5TE7Of87GY/FVMU/YgGmS/WGDSqJCB2dI=;
 b=Sds6FgZgSLDt9cKy+TJyJZ67vT4v5Sn/rrV3ImAbtfeloilxjyIH/0bjiISynpMLyI
 gZB2fIh8OpcXlDD1Vzqqao/hd00z0kqEd5q9VhNz56cyL6UPLGj4cxAQtwvF9+xaKxyJ
 hUwEy2UtYSz+DrcabHPrqf+yRzmYlcEdOSD53EjNjc9aNxBvT7X5EGqxKnjFKJrwflJ+
 M5ZMlTDZIX34hpNJE1nmtyPKHyySXASQs+8rEjjpurybMXnIET/DwQWCNrMSwF8yJu2n
 dTqOhqupq+WBKgzVUoRSgsaGLpJb+Oh2KAnk/NVOUsIgLqyRrd44kDkHTf9ELefJtwSO
 AVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HCBRdtAuyh5TE7Of87GY/FVMU/YgGmS/WGDSqJCB2dI=;
 b=ho3RuisF4FURg6aT88TqaOKmXbxOVoQc9YlxBBOK+w7polr9XikEy2/Ctmr9L2RvsQ
 lD05EnG4oX/rP4L3umCKPZFqXuwCKzXVIMoD6Wg+psuPoYGceF63jI7heF05LqbC6ESh
 +GP1Ym49Nng1EoF7iGnjfLLQH5/X8BQ2XlKoSsEKf2DvYZM6iyT3u5aCsOvCC4Qdd8uM
 2fUCunH6EehwDJvJME6CmuGV7xelCYDrhBVT3MSz9xeO1IHWunPmXE5p5mtTPePYFfrf
 mhpZqMD0p6E61bFWB5btrLlubYS2P4sL8XlcK0DR5tn0oiYzK4btLv4EBRa++dFc5cQH
 0DWg==
X-Gm-Message-State: APjAAAWYEYkZ3fVS4/3yEabw/bsfAgulJ11/1XeIGKuD4FSfLGk2Wk8t
 dfufxM2We0Pj8CvjHvgcjZZzCw==
X-Google-Smtp-Source: APXvYqwY9Vb5OiAy/xkxm9FJn4yCsb5+FDsY9b0jccdlVv/zgGmSE5fkhhDjmjMkxDAZRSiLY5IDDg==
X-Received: by 2002:a17:90a:cf07:: with SMTP id
 h7mr5936314pju.66.1581458294076; 
 Tue, 11 Feb 2020 13:58:14 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
 by smtp.gmail.com with ESMTPSA id h62sm5269521pfg.95.2020.02.11.13.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 13:58:13 -0800 (PST)
Date: Tue, 11 Feb 2020 13:58:12 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 2/5 blktests] nvme: test target cntlid min cntlid max
Message-ID: <20200211215812.GC100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-3-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_135815_283103_41BF7A0F 
X-CRM114-Status: GOOD (  14.63  )
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

On Wed, Jan 29, 2020 at 03:29:18PM -0800, Chaitanya Kulkarni wrote:
> The new testcases exercises newly added cntlid [min|max] attributes
> for NVMeOF target.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/033     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/033.out |  4 ++++
>  2 files changed, 61 insertions(+)
>  create mode 100755 tests/nvme/033
>  create mode 100644 tests/nvme/033.out
> 
> diff --git a/tests/nvme/033 b/tests/nvme/033
> new file mode 100755
> index 0000000..97eba7f
> --- /dev/null
> +++ b/tests/nvme/033
> @@ -0,0 +1,57 @@
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
> +	local nvmedev
> +	local loop_dev
> +	local cid_min=14
> +	local cid_max=15
> +	local file_path="$TMPDIR/img"
> +	local subsys_name="blktests-subsystem-1"
> +
> +	truncate -s 1G "${file_path}"
> +
> +	loop_dev="$(losetup -f --show "${file_path}")"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> +	port="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +
> +	nvme connect -t loop -n "${subsys_name}"
> +
> +	udevadm settle
> +
> +	nvmedev="$(_find_nvme_loop_dev)"
> +	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
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
> +	echo "Test complete"
> +}

Another shellcheck warning:

tests/nvme/033:44:20: note: Double quote to prevent globbing and word splitting. [SC2086]

Also, this fails on kernels without this feature:

nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [failed]
    runtime    ...  2.262s
    --- tests/nvme/033.out      2020-02-11 13:52:20.346831467 -0800
    +++ /home/vmuser/repos/blktests/results/nodev/nvme/033.out.bad      2020-02-11 13:52:42.006948791 -0800
    @@ -1,4 +1,4 @@
     Running nvme/033
    -cntlid : e
    +cntlid : 0x1
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete

Presumably because _create_nvmet_subsystem silently does nothing if
attr_cntlid_min doesn't exist. We should skip the test if the kernel doesn't
support it rather than ignoring it in _create_nvmet_subsystem.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
