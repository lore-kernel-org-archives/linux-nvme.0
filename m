Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D814C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GV9VBm79SKngmQ7cve6tyxoEDAnDq2/eaDqc8avRVJg=; b=QufmIiT6TW5wmFQ0vrMSpITvD3
	7GQy3qnXkfL/oUv+undS+t8H7+YMZsyoIrqmnCeTcRZHQbuQ7pV4iR7lYYktGdBDMAInNBOmSCf0m
	Nb1DbtBW3CHPO7EycPj+pAQFJa8B05+0ss5WcddGppbvPLGthCh27UgCBpVoKp/eOj5tkX7QOpYmi
	buFQf1SparWZeA42v7d98fph65msAjAFPyLsmIL5pzRwk/15lbsERsejHLkPBQlWJuu7O1fKlaho/
	7eU6fXi9Yiz+pmIFWfjsxw2eZ9J6xTVLn9gd2CXAsNqGTs+9+XsdhoNMjO0ryOrY7tzOEt2/MsBBh
	W+AiA8wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5F0-00FT8F-CH; Mon, 22 Nov 2021 09:03:58 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5E6-00FSs8-81
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:03:04 +0000
Received: by mail-wr1-f52.google.com with SMTP id d5so31343551wrc.1
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 01:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GV9VBm79SKngmQ7cve6tyxoEDAnDq2/eaDqc8avRVJg=;
 b=GwVgiBUr9VdizDD5l/ngbKrTuolxm9bjXGqFEiawb8+7Y48Rhg+IJa/qsYFSTxSZq4
 82vFYuJo/L3+tfBomEfzKYVdoWt0dcQav1+r5JHUCdXs2lhueNelZTkkd0zlpn3/T2zJ
 Yuz+3Wx0F5Mfx9U1o/pnmvxURKu56vHGIddQQUy3ozQ/cKjUTXSZ/J4HIOhohzb0pifT
 PYZoopHIzQ6k4UoPnd/Wy9zVFNcfo6jSRuSzDwYh9yrmDFZj8MXMcCsDStUiGdx651UQ
 eS8rX0OdyB4JPDc0G/bIaZzeHtsDrHqASAA/kWX+wAou4+urDy9KJzn0vzvtzEaFVtj/
 r48g==
X-Gm-Message-State: AOAM530BHMZmmfaoAPdd3Sx6bZ0lM2NWp5uxApamatZzITdtD2pUILH2
 JDNKJN+u3NDDMEyt9eGflbsbKxnDCZ0=
X-Google-Smtp-Source: ABdhPJxq3fU71+pBXkmsyDlXyVyLmnlcsVk613+0GAjWyUAIzbGQOAaoOH5OWj582NTdoFqolZGY2g==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr34338025wrw.262.1637571780051; 
 Mon, 22 Nov 2021 01:03:00 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p13sm20999584wmi.0.2021.11.22.01.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 01:02:59 -0800 (PST)
Subject: Re: [PATCH 9/9] nvme/044: test re-authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-10-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2bdd14e4-ac97-c21b-6ecf-f7ea6c4b215a@grimberg.me>
Date: Mon, 22 Nov 2021 11:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122075524.26207-10-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_010302_391477_E572677A 
X-CRM114-Status: GOOD (  19.82  )
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
>   tests/nvme/044     | 116 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/044.out |  22 +++++++++
>   2 files changed, 138 insertions(+)
>   create mode 100644 tests/nvme/044
>   create mode 100644 tests/nvme/044.out
> 
> diff --git a/tests/nvme/044 b/tests/nvme/044
> new file mode 100644
> index 0000000..e3a1e94
> --- /dev/null
> +++ b/tests/nvme/044
> @@ -0,0 +1,116 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Test nvme over tcp re-authentication
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test re-authentication for TCP connection via localhost"
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
> +	local ctrlkey
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
> +	if [ $? -ne 0 ] ; then
> +		echo "nvme gen-dhchap-key command missing"
> +		return 1
> +	fi
> +
> +	ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
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
> +	_create_nvmet_subsystem "${subsys}1" "${scratch}"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
> +	_create_nvmet_host "${subsys}1" "${hostnqn}"
> +
> +	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
> +	_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
> +	_set_nvmet_ctrlkey "${hostnqn}" "${ctrlkey}"
> +
> +	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
> +	     -a "${def_traddr}" -s "${def_trsvcid}" \
> +	     -S "${hostkey}" -C "${ctrlkey}" \
> +	     --hostnqn="${hostnqn}" --hostid="${hostid}"
> +
> +	nvme list-subsys
> +
> +	ctrl=$(_find_nvme_dev "${subsys}1")
> +
> +	echo "Re-authenticate with original host key"
> +
> +	echo "${hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
> +
> +	echo "Renew host key on the controller"
> +
> +	new_hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
> +
> +	_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
> +
> +	echo "Re-authenticate with new host key"
> +
> +	echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
> +
> +	nvme list-subsys
> +
> +	echo "Renew ctrl key on the controller"
> +
> +	new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
> +
> +	_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
> +
> +	echo "Re-authenticate with new ctrl key"
> +
> +	echo "${new_ctrlkey}" > /sys/class/nvme/${ctrl}/dhchap_ctrl_secret
> +
> +	nvme list-subsys
> +
> +	echo "Change DH group to ffdhe8192"
> +
> +	_set_nvmet_dhgroup "${hostnqn}" "ffdhe8192"
> +
> +	echo "Re-authenticate with changed DH group"
> +	echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
> +
> +	nvme list-subsys

Here you may want to compare the lists, but why not to a local
variable?

If you insist of printing, how about introducing a
generic filter helper to filter-out the transport from list-subsys?

