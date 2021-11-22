Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E701AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/YqTM3Nw57K+lbbMBUXAbo5JwUmFi7YnqVmnSk14OJw=; b=kT4FNEuuoX5xCG46u3SsGetYba
	aEqAwlPDEV+PzAewPyKvbNS2EgFyVF4Y5pn8NkrRZmhHLqwMDt1DktB5UasotRpQLMxb+YoUc/Bnc
	wJTILkEBy+cW7nspIxhbuWr2/xjW5a5wZrzrzmU9K4lnhX9DLQYTzZict2expD/KDl5BmjxmQGos6
	Z/OwPHDyECGEmvK2H4hIlQRs1red0i1SlEXAJitz0eHwrGRhKO8H52GAEVqU80S5QTXHEZ5/sTe2L
	lGFtqQuRD3pBdOM1QfJINMpWtrzv2LEfPScBen9M9URrDD+PnOYkqJo/2QXeZ+FefQ9hb8t9F0pO+
	YBxK6nPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5B5-00FS1C-1e; Mon, 22 Nov 2021 08:59:55 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5A6-00FRce-NR
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:58:56 +0000
Received: by mail-wr1-f41.google.com with SMTP id a9so31274907wrr.8
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/YqTM3Nw57K+lbbMBUXAbo5JwUmFi7YnqVmnSk14OJw=;
 b=qxLh8dWvqNB/Q/jCw67567evle8SKzxw8uzA/hyjEEUxt/F0/eptZn3mWRR5t4P1pf
 3A/dZESAxUqws4Feb2AsoncD8YbcLj7wjNRYUmDzKT/6SV/puVeEJ9qHG93YBX58v/H/
 5BvzD2g5G3AHt+0TN4MaP5pP+rEtp2oOg7HsTEE768hY9YVWeNokRktKfdinhNlP/P2W
 041nqyz7X/SN7d30cuf6EMXehpktEucRpN+yMNaAJW2xbSKS39R7YM8kB5pw/F/dzT9F
 bxDcI6xA/F0zLcsUyxbUfandy8/l+Qwu3q6vGxh2JTWD07RHpdzveo8ve9C5pBgOY2+Y
 HSBQ==
X-Gm-Message-State: AOAM531eBkMvmzF73WLD+zrbSBEL/2TCRCLtpTyU9C/CXdXGQeBCcUgB
 DMS5fxEJHMRZMoKznjabsbP+1rtV4Ts=
X-Google-Smtp-Source: ABdhPJyTq4k3WfBUXjBNtAFv6+N2Mua6bjAcluIUAAfxG4HRsixS7VTv6FJq4v9XSnQPgEsryGTYew==
X-Received: by 2002:a05:6000:184e:: with SMTP id
 c14mr35597922wri.241.1637571532580; 
 Mon, 22 Nov 2021 00:58:52 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l22sm8007134wmp.34.2021.11.22.00.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:58:52 -0800 (PST)
Subject: Re: [PATCH 6/9] nvme/041: test different key types
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96c61139-5206-dad1-6157-d8dab1f314c1@grimberg.me>
Date: Mon, 22 Nov 2021 10:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122075524.26207-7-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_005854_823376_71D3212E 
X-CRM114-Status: GOOD (  17.72  )
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



On 11/22/21 9:55 AM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   tests/nvme/041     | 102 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/041.out |  36 ++++++++++++++++
>   2 files changed, 138 insertions(+)
>   create mode 100644 tests/nvme/041
>   create mode 100644 tests/nvme/041.out
> 
> diff --git a/tests/nvme/041 b/tests/nvme/041
> new file mode 100644
> index 0000000..8fc4ab9
> --- /dev/null
> +++ b/tests/nvme/041
> @@ -0,0 +1,102 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Test nvme over tcp dhchap keys
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test dhchap keys for authenticated TCP connection via localhost"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_modules loop
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +
> +test() {
> +	local port
> +	local genctr
> +	local subsys="blktests-subsystem-"
> +	local hostid="$(uuidgen)"
> +	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	local scratch="/tmp/blktest-ns1.img"
> +	local nvme_trtype="tcp"
> +	local hostkey
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
> +	if [ $? -ne 0 ] ; then
> +		echo "nvme gen-dhchap-key command missing"
> +		return 1
> +	fi

Don't we want to test different secret formats?

