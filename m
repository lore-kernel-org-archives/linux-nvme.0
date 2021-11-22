Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13727C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E76cHHXiZhO/RW6N+yP1iXK+GYc5dF2rQSVH8W5d+aQ=; b=yIzVvXWRw+qjIIi1THskT26Y/3
	ui9v+FBaAZV35xkGFH7asUpHKim/Eju9eKzQ4Qd3TFzcKhffIghQZrjedOCakF+x1i0R+8LrMXN4M
	vV6rOnnMbPoiFNef/br8DTfce8cYO7//b/Qed7F88QvI6+VlrNnWHUD2TbfmFTFC+0/ipgubSmANx
	iDnzBa8PqwNZn3mo4f5tKuhyL8SaZMmfnd+FkV8o/5GCsuk0DDIyk+X9iWpd2ZflFhxN/+HV3SD1q
	o5YMYDs2hN3DkiD3LSs0QIoB301S6UDxRX37QeGxkPKbeUPw/drfsut3SEGn36ZJlhUT8QDfpfDEn
	tabw61NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp59K-00FRFP-RL; Mon, 22 Nov 2021 08:58:06 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp58K-00FQmY-EV
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:57:06 +0000
Received: by mail-wr1-f51.google.com with SMTP id i5so31330703wrb.2
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E76cHHXiZhO/RW6N+yP1iXK+GYc5dF2rQSVH8W5d+aQ=;
 b=M0cSUnd1DnyQzmqAbDMFNRo78z4OEHJM7c52CjqM9zi/LtARLhs5MMb9VyLFrblZHN
 09jskvn2UIdjOkLCtbH0C/XrGblsZjdyP0WfDaXcENmw7Des3cVMJ7R0SVcmtSor6Fbt
 62GtkajyE2ATt8bC6AkrNeLPdBs78mj0xcBOwt2zT/r1jVkY+BE/qeuuDUwSbq3SjQKa
 dCpUigcR21WgxtN91Q1aU17WNRCRzBhTQBdoFcTiThs85bCPMyLdQ4QmkcLmfkaiodT5
 22BPqrc58a8U9BrMFCwyjvgm5CH7NlTwQkB0pZdjlPPnBGGW9RGOuUDESQcwOQWXUSxn
 LG6w==
X-Gm-Message-State: AOAM532jD6kYLpKB2KUplRxsE1JE4RmwqVQ8/fIvkXy9MX9AcL4cKqr0
 M4xYqc5jTGCk+LYxXlscX98MmR/alGo=
X-Google-Smtp-Source: ABdhPJypVNGX192kTzLl08qh3cVg6+FWJe9fIYdBQVTVT4Tn8d2hXl/sLEXpejboPjtXi2rXtQhUzg==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr35809463wrs.200.1637571422164; 
 Mon, 22 Nov 2021 00:57:02 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id s63sm9045842wme.22.2021.11.22.00.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:57:01 -0800 (PST)
Subject: Re: [PATCH 5/9] nvme/040: create an authenticated nvmeof-tcp
 connection
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6f85d8e0-a930-9ddc-e810-f56bf483a22c@grimberg.me>
Date: Mon, 22 Nov 2021 10:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122075524.26207-6-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_005704_555637_EF8AE87B 
X-CRM114-Status: GOOD (  22.40  )
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
>   tests/nvme/040     | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/040.out |  6 +++++
>   2 files changed, 70 insertions(+)
>   create mode 100644 tests/nvme/040
>   create mode 100644 tests/nvme/040.out
> 
> diff --git a/tests/nvme/040 b/tests/nvme/040
> new file mode 100644
> index 0000000..9c2eb07
> --- /dev/null
> +++ b/tests/nvme/040
> @@ -0,0 +1,64 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Test nvme over tcp authentication
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Create authenticated TCP connection via localhost"
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

Why is this tcp specific? what prevents this from passing with
loop/rdma?

AFAICT the rest of the tests are not tcp specific either, nor
is inband auth in general...

I think we should have the tests run with a user-defind nvme_trtype.

> +	local hostkey
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
> +	if [ $? -ne 0 ] ; then
> +		echo "nvme gen-dhchap-key command missing"
> +		return 1
> +	fi

I think that this belongs in nvme/rc

> +
> +	_setup_nvmet
> +
> +	truncate -s 512M "${scratch}"
> +
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	_create_nvmet_subsystem "${subsys}1" "${scratch}"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
> +	_create_nvmet_host "${subsys}1" "${hostnqn}"
> +	_set_nvmet_hostkey "${hostnqn}" "${hostkey}"

Can you comment that hash/dhgrp are used with their default values.

> +
> +	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
> +	     -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
> +	     --hostnqn="${hostnqn}" --hostid="${hostid}"
> +
> +	nvme list-subsys

Why not just look in the connect retcode? why do you need the 
list-subsys output?

> +
> +	nvme disconnect -n "${subsys}1"
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
> +	_remove_nvmet_subsystem "${subsys}1"
> +
> +	_remove_nvmet_port "${port}"
> +
> +	rm ${scratch}
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/040.out b/tests/nvme/040.out
> new file mode 100644
> index 0000000..b1c6825
> --- /dev/null
> +++ b/tests/nvme/040.out
> @@ -0,0 +1,6 @@
> +Running nvme/040
> +nvme-subsys0 - NQN=blktests-subsystem-1
> +\
> + +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> 

