Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA3BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5TtBNBvMl6JvIK0aoTcj/mILEdsXI8q8SZTB8zh87GY=; b=Y9oChWeJMLvdvFGWMso9IKbA1Z
	J/OCiS/AtZ2+cHOpkncRMd1l6IF+7KNUQOJ4D8F5qroEoCEVEeOhoyWpWE0u/Krh890h3pOIvdV9M
	qkJk76oKFsI9yRNynK8wpD6Pycq94YWsOZOWjfjpUIi/KRaol/RIXzchOAkgFoohIr5gxrVD0q7D8
	bsOW2jb+l6Wbj17aQbxW+OsHBovxDb6g+VusGHH3Psi/pZlI4i6JMmc2dQr/OvDvwUivPsodp9L7+
	NFT+gL/QlbuVQ4o4TFKWIByyIy+bOyiOJ7VbqhXZKS+clp76AaPOWqZn9Dr4GMWuRSlTvltM0tP0R
	w2d/0cwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp57O-00FQLt-U8; Mon, 22 Nov 2021 08:56:06 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp53n-00FO0i-2K
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:52:24 +0000
Received: by mail-wm1-f41.google.com with SMTP id p18so14503458wmq.5
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5TtBNBvMl6JvIK0aoTcj/mILEdsXI8q8SZTB8zh87GY=;
 b=NLy+qgo+IujtSrWdcqtD0jE1IEM/i9nTomyCuMLpbGCt9NbaYm17MxyZQ7S0YJdc7T
 fZkznmoQQ5FnHBTE9FeIJHWp0Z/PZviyXIknvejVL88MbqOowifaFoU4TukT3S3Wtfb6
 8eqoxV8MNEUgwqkXyi1uFg0NI6I2XOfCCSS9Qi6IippCQ/Ve/6ymlc+NfbtkpfbiVO36
 SCRPqNl8u9k56RdENe7UUXAY+xhYy9C1E2KZdz2LhZ08nrrtQHxhgzuh2q9/9O227B35
 npRxe/qpVlTT3ogGfO5DyzYHmwO+NFmoQsy/HCy6jtJYt4grg3wXyIaoKLRzPGJIYsBC
 6WBg==
X-Gm-Message-State: AOAM53053Lt4se3GYs3m4Mu1hcb4rr4uL0JHaUPdo9dM1rDls6kT1DxJ
 UQn0mmyk4MePakhTHaQ6CKpegMuYkPU=
X-Google-Smtp-Source: ABdhPJw7kOuQP6F0o2nTdmIcvuTvwL3Teaz1b8YGnFOnnJfXRAUBTsSdt9YXpS8L5dNDnnJvNzeFDw==
X-Received: by 2002:a1c:2585:: with SMTP id l127mr27595891wml.72.1637571141230; 
 Mon, 22 Nov 2021 00:52:21 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d7sm8032519wrw.87.2021.11.22.00.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:52:21 -0800 (PST)
Subject: Re: [PATCH 3/9] nvme/rc: add functions for in-band authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a4e3d91a-f618-8bff-0218-1396274bf1fd@grimberg.me>
Date: Mon, 22 Nov 2021 10:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122075524.26207-4-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_005223_162178_F2D741EB 
X-CRM114-Status: GOOD (  18.25  )
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
> Add functions to enable in-band authentication.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   tests/nvme/rc | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index aa223df..7d05e4a 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -247,6 +247,17 @@ _create_nvmet_subsystem() {
>   	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
>   }
>   
> +_create_nvmet_host() {
> +	local nvmet_subsystem="$1"
> +	local nvmet_hostnqn="$2"
> +	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +
> +	mkdir "${NVMET_CFS}/hosts/${nvmet_hostnqn}"
> +	echo 0 > "${cfs_path}/attr_allow_any_host"
> +	ln -s "${NVMET_CFS}/hosts/${nvmet_hostnqn}" \
> +	   "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
> +}

I'd say that perhaps we can add optional parameters for
host key,hash,dhgrp so that simple tests can just add
a host with these params set?

