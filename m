Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBBAC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nCE19fGrcU9HRqfzrHosUulq2z9AJaSHYhdRwcuWwAA=; b=a8j4EMuxq5ub/WXwer4YZ1S9u+
	0ZMTatv/PaHdavfNn0P4EJhk8THLM0rYlbUSjXBfazcci2DWQbkPuUPNpCcJ5tSiMUyNVCkuzHHa9
	88o+M+BsNw3fBUtLS2HPbCpGk5Qvz65BgHMT2aSzDO3c5GhE7bcVw1d2cHoguAh7uIE7hRpvVT6Rc
	vDqriV4lFm7AkkcScaN1uIRDEeBKDRm7Lvovh6PNSmuoGR7YG3RLkACMn3Krvhg30bak7nkg1aEf7
	01v9VB6n4d3yQ6K6efFQDWnmE33vUXZ3OK2cQyZnp6DHufhL5Q/3f9EGUsqAIIk4DHCOYZjkjAjpB
	TtfU8NTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrKMM-00Frei-0E; Sun, 28 Nov 2021 13:36:50 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrKMI-00Fre1-TG
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 13:36:48 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 o19-20020a1c7513000000b0033a93202467so10415542wmc.2
 for <linux-nvme@lists.infradead.org>; Sun, 28 Nov 2021 05:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nCE19fGrcU9HRqfzrHosUulq2z9AJaSHYhdRwcuWwAA=;
 b=n6rVX2HSrLLQI/M4gnWB8H/iSqnEOvf6my9gHGQpckgZunuSOqMHTPCsCTSSVPTsm9
 9+dJnVWu3J8rVl+uqmSmfszoR98Dqmg+lhA3MBpdTaWuJQqwWxpNQbzwbMIk6PZ3SMs9
 DX602ALN7syUjj2PuzESNKvjqMVxJuQu8yt4RyorARNAH2clIcWuW+uL97h0EOKcyELR
 Dkf6NzZZ9Q8zmyVjg3RqCrr7JOYAHtLf2UVW93I1AE8Nsy+z2Acv3z2uNzs9ayti7o6T
 Th5B1aURY8yCZQOi0MyefyqfthwFRMY/mVg/mrEldUvkNV5T1UrGanzcv8QBYTkhE/y1
 Mpxw==
X-Gm-Message-State: AOAM533LTNeTPdYJ/BsJx8tNSqJ9ILM1bXIUQsrfkwQm02hvJgF6UBxK
 29AxieOjOujKyYNwxlsUYUxv3e3ML8M=
X-Google-Smtp-Source: ABdhPJxKyE1sO0E0UwPaez9wGFPKaGR01T5jxdVSleV3cXddZxBzaJK6zCMvu+gQpCBxMUwrxnbl9A==
X-Received: by 2002:a1c:4d15:: with SMTP id o21mr28903216wmh.171.1638106604709; 
 Sun, 28 Nov 2021 05:36:44 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id c6sm21948732wmq.46.2021.11.28.05.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Nov 2021 05:36:44 -0800 (PST)
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
Date: Sun, 28 Nov 2021 15:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123074940.113390-10-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_053646_980147_33C2C97F 
X-CRM114-Status: GOOD (  18.28  )
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



On 11/23/21 9:49 AM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   tests/nvme/042     | 107 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/042.out |   8 ++++
>   2 files changed, 115 insertions(+)
>   create mode 100644 tests/nvme/042
>   create mode 100644 tests/nvme/042.out
> 
> diff --git a/tests/nvme/042 b/tests/nvme/042
> new file mode 100644
> index 0000000..f3954b4
> --- /dev/null
> +++ b/tests/nvme/042
> @@ -0,0 +1,107 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Test bi-directional authentication
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test bi-directional authentication"
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
> +	local subsys="blktests-subsystem-1"
> +	local hostid="$(uuidgen)"
> +	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	local scratch="/tmp/blktest-ns1.img"
> +	local hostkey
> +	local ctrlkey
> +	local ctrldev
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
> +	if [ $? -ne 0 ] ; then
> +		echo "nvme gen-dhchap-key command missing"
> +		return 1
> +	fi
> +
> +	ctrlkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
> +	if [ $? -ne 0 ] ; then
> +		echo "nvme gen-dhchap-key command missing"
> +		return 1
> +	fi
> +
> +	_setup_nvmet
> +
> +	truncate -s 512M "${scratch}"
> +
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	_create_nvmet_subsystem "${subsys}" "${scratch}"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys}"
> +	_create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}" "${ctrlkey}"
> +
> +	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
> +
> +	# Step 1: Connect with host authentication only
> +	echo "Test host authentication"
> +	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
> +			     "${def_traddr}" "${def_trsvcid}" \
> +			     "${hostnqn}" "${hostid}" \
> +			     "${hostkey}"
> +
> +	ctrldev=$(_find_nvme_dev "${subsys}")
> +	if [ -z "$ctrldev" ] ; then
> +		echo "nvme controller not found"
> +	fi
> +
> +	_nvme_disconnect_subsys "${subsys}"
> +
> +	# Step 2: Connect with host authentication
> +	# and invalid ctrl authentication
> +	echo "Test host authentication and invalid ctrl authentication"
> +	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
> +			     "${def_traddr}" "${def_trsvcid}" \
> +			     "${hostnqn}" "${hostid}" \
> +			     "${hostkey}" "${hostkey}"
> +	ctrldev=$(_find_nvme_dev "${subsys}1")
> +	if [ -n "${ctrldev}" ] ; then
> +		echo "nvme controller found!"
> +		_nvme_disconnect_subsys "${ctrldev}"
> +	fi

This test case has a weird behavior. Why isn't _nvme_connect_subsys
failing?

