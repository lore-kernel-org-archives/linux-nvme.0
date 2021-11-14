Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99694C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:31:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462B561037
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 462B561037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QMCJTfQlsmHRAq0wjET6JlH+0QTX7CbxflZX+LFcMPc=; b=TQPhy4AY6/4l2xfqYvjMRY+C33
	h2wgvGnQaMMTPs/ljUS+hVu8MFXESyq1FcuMBDS4iH544fBTEmVO34WwkWy4k5niQd5QBEth2FZAM
	hBvHCczqpA9Db/RYweKt9LPm80Fhc9h1hhaHVBoJIbJJOQpnf0qZP4DwC0PXn2oxJJDx8mLTh15zQ
	jbcefqdLm91iIB3yaAPweKWEh9KzQzcimEiWtaZGTJ2Ev4JQUoBK5mCEivCbUz4Ib10/k1oDbpA8W
	GAhy98v6Zta1amqTxit3CZ3QlFIP2kL/gKWXCVHRb+JJtoSGhQ5ZyfrSX4ZsTW5USwrMBqtEjzJey
	ZmhhHFnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmCnB-00DWf9-Tx; Sun, 14 Nov 2021 10:31:21 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmCn9-00DWel-LM
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 10:31:21 +0000
Received: by mail-wr1-f52.google.com with SMTP id d27so24345050wrb.6
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 02:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QMCJTfQlsmHRAq0wjET6JlH+0QTX7CbxflZX+LFcMPc=;
 b=djTV/MMNUGQMgMIExVSGlFhDwUioSDWvWQXHJaKcLDvSVwNXvh71oNxwc/LH8ilXNt
 NQOoO8+PSNp+tBX23eW+DotudyfEYGlgAbpzpcMQ0jiysbLEvKSDjC7GCLM4xKBkNUCD
 C05TlYXY6bYjwWbKkfBtJoeDWCB/Ba3fOPpVbecOiQr+t6coEZ7zp2SpawZrHbvDX43O
 uu/Gj47VMTekG1fU7V6QFwsMXhebL/tOJT4na1Flyjul3iSWLqUi4YqlUjlFfJRQkM0O
 7oj1SNjcRckY/jSEQuIow95hDMp72uogk5dQwJuGaK/Jt2bvMC9HRibNeNvD5fL80a8n
 oNuA==
X-Gm-Message-State: AOAM531CDkscDwoMWtnpaEsSzU8o0VlkVw+7xXzFi4DFx+7MxusGtvyf
 fJxGkUq+uPFubNa5JQNy8gDlNFH3UEI=
X-Google-Smtp-Source: ABdhPJx0uKderI/4d+odykx2nSTzKdUawOTxwEiaXpGKYqS373OP1MFAndbOri1ydfKB4iMxjMilFA==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr37585957wri.242.1636885877818; 
 Sun, 14 Nov 2021 02:31:17 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n2sm13710531wmi.36.2021.11.14.02.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 02:31:17 -0800 (PST)
Subject: Re: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
Date: Sun, 14 Nov 2021 12:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112144510.98523-2-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_023119_742712_4ADDD997 
X-CRM114-Status: GOOD (  17.92  )
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


> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   tests/nvmeof-tcp/001     |  55 +++++++
>   tests/nvmeof-tcp/001.out |   6 +
>   tests/nvmeof-tcp/rc      | 347 +++++++++++++++++++++++++++++++++++++++

Why another directory? why nvmeof-tcp? what prevents inband-auth
to be tested with loop/rdma?

>   3 files changed, 408 insertions(+)
>   create mode 100644 tests/nvmeof-tcp/001
>   create mode 100644 tests/nvmeof-tcp/001.out
>   create mode 100644 tests/nvmeof-tcp/rc
> 
> diff --git a/tests/nvmeof-tcp/001 b/tests/nvmeof-tcp/001
> new file mode 100644
> index 0000000..39f4108
> --- /dev/null
> +++ b/tests/nvmeof-tcp/001
> @@ -0,0 +1,55 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Test nvme over tcp connection
> +
> +. tests/nvmeof-tcp/rc
> +
> +DESCRIPTION="Create single TCP connection via localhost"
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
> +
> +	echo "Running ${TEST_NAME}"
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
> +
> +	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
> +	     -a "${def_traddr}" -s "${def_trsvcid}" \
> +	     --hostnqn="${hostnqn}" --hostid="${hostid}"
> +
> +	nvme list-subsys
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
> diff --git a/tests/nvmeof-tcp/001.out b/tests/nvmeof-tcp/001.out
> new file mode 100644
> index 0000000..1eae834
> --- /dev/null
> +++ b/tests/nvmeof-tcp/001.out
> @@ -0,0 +1,6 @@
> +Running nvmeof-tcp/001
> +nvme-subsys0 - NQN=blktests-subsystem-1
> +\
> + +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> diff --git a/tests/nvmeof-tcp/rc b/tests/nvmeof-tcp/rc
> new file mode 100644
> index 0000000..9ae0899
> --- /dev/null
> +++ b/tests/nvmeof-tcp/rc
> @@ -0,0 +1,347 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2018 Johannes Thumshirn
> +#
> +# Test specific to NVMe devices

Isn't this just a copy of nvme/rc?

