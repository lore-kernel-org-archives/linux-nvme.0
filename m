Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5A8C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5S6t/+cJRUsz/lAp9phJeVND87o5+FJdvoFCNnac/jk=; b=NHONDylo5Xj9e1vkMhWlhSsOiq
	2fhkzldRSBeo8HK7YN4SWdbNnlUmYeLixH/DS3hNhQgMhYIDEMcoSKnw/bhVg+cUtQNMXZWNkf7+X
	S8SAOPKkV04k7FnOVbvifP72MhGh4+jhqI8puiT9lHHeS9B/r6x0msfJ4W9Ye/DbuIkJkg+sEzuj0
	WOaYEgTuQ8hEhniZPkelD/18KrNQg2PUs7CPO+U2V5E/4FNv23wvqTDLb53Mpq9sStGkEGVX2Uhp0
	KEzRPBnpZGXgHTfml6xnRjbgMTnat08NiKNSK/vxGmwsDjDRUG5uydNu9L2fDu3ishyHlv8ssiKpm
	pVhmnv3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKPj-00FUd4-2b;
	Mon, 03 Apr 2023 13:40:03 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKPh-00FUak-18
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 13:40:02 +0000
Received: by mail-wm1-f41.google.com with SMTP id s13so17123688wmr.4
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 06:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529199; x=1683121199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S6t/+cJRUsz/lAp9phJeVND87o5+FJdvoFCNnac/jk=;
        b=geV7H8SedH1q1b3r+3GLcuKmFGNzl3/kbv+PEo9PGhk7ZfNGK6QZuEr8b/oj+oNMTP
         p1erIyFfb6BtuoTNUBhCInCQr2h3PscI/tcBhgWkDlz9kSrOthozMPlIBo49ouORESdY
         zYGow9JZsWnYXn7QPuHDiLSB/2AGNgOYxlZ7wqY8CQhDN4fTL454Z42UVIwjtYCYxwEX
         OK50AroUDRsLaPVhqbZP14uHEqixQg8enTW+jfo/deYVIXsFbTiRyPn2itG5IFfDZ71I
         I9j9lYqyx6cVshkp94PpIVBhJon6NanmeTaBNf6yct5byiWSMsFHIwCDov9WCVM3Vi/k
         9IkA==
X-Gm-Message-State: AAQBX9d58lSwNJ/8S0vayNABDjVuoYkcMj9pRH6zKBKC5C6qGd7AaJdz
	EgLvrEjaFnXv/+SZRcHkIxQ=
X-Google-Smtp-Source: AKy350ZpnmvCR5+ehcjuz5xmjod8ABsDCxd57tdIRoOJPe97QtZt4rkpLwMoFfr6z5iheBg750qkOg==
X-Received: by 2002:a05:600c:1550:b0:3ed:d2ae:9adb with SMTP id f16-20020a05600c155000b003edd2ae9adbmr11897470wmg.0.1680529198885;
        Mon, 03 Apr 2023 06:39:58 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b003f0548d00f1sm3526305wmo.1.2023.04.03.06.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:39:58 -0700 (PDT)
Message-ID: <117038a8-4add-fabd-2187-6e5fae9a4d4e@grimberg.me>
Date: Mon, 3 Apr 2023 16:39:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH blktests v2 2/2] nvme/047: add test for uring-passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, mcgrof@kernel.org
References: <20230331035519.42728-1-joshi.k@samsung.com>
 <CGME20230331035617epcas5p41ff3b2a1def95ba99abd16634b9e726f@epcas5p4.samsung.com>
 <20230331035519.42728-3-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230331035519.42728-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_064001_385897_9D1E37BC 
X-CRM114-Status: GOOD (  16.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> User can communicate to NVMe char device (/dev/ngXnY) using the
> uring-passthrough interface. This test exercises some of these
> communication pathways, using the 'io_uring_cmd' ioengine of fio.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>   tests/nvme/047     | 43 +++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/047.out |  2 ++
>   2 files changed, 45 insertions(+)
>   create mode 100755 tests/nvme/047
>   create mode 100644 tests/nvme/047.out
> 
> diff --git a/tests/nvme/047 b/tests/nvme/047
> new file mode 100755
> index 0000000..ea9b001
> --- /dev/null
> +++ b/tests/nvme/047
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
> +# Test exercising uring passthrough IO on nvme char device
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="basic test for uring-passthrough I/O on /dev/ngX"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_kver 6 1
> +	_have_fio_ver 3 33
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +	local ngdev=${TEST_DEV/nvme/ng}
> +	local common_args=(
> +		--size=1M
> +		--filename="$ngdev"
> +		--bs=4k
> +		--rw=randread

Maybe while you're at it expand a bit to:
--rw=randrw
--bsrange=512-128k,512-128k

> +		--numjobs=1
> +		--iodepth=16
> +		--name=randread
> +		--ioengine=io_uring_cmd
> +		--cmd_type=nvme
> +		--time_based
> +		--runtime=2
> +	)
> +	#plain read test
> +	_run_fio "${common_args[@]}"
> +
> +	#read with iopoll
> +	_run_fio "${common_args[@]}" --hipri
> +
> +	#read with fixedbufs
> +	_run_fio "${common_args[@]}" --fixedbufs
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/047.out b/tests/nvme/047.out
> new file mode 100644
> index 0000000..915d0a2
> --- /dev/null
> +++ b/tests/nvme/047.out
> @@ -0,0 +1,2 @@
> +Running nvme/047
> +Test complete

