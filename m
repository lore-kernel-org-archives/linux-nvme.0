Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D85AC2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 19:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F049E60FE9
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 19:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F049E60FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kURZK9hFcbMcySiAwnm+xKZZCBYaBtL+UbDbE5e9Uo=; b=UyTncN93d+YrNeyft2E23vLOjM
	Vul8XoPNyd3d0d8J25m9IISgoM02JIzSnjHxs9Qb92TBn53s7Xs+9m9svOLbe3nJljxGkEmtnJn0g
	fGaCxYwNrmo+hrTwFGKkjtpF5nL8//5DTZkXS/gdsWVl/oPOuTJiJYam0Hood0BxHtEsIeXgS6YvJ
	0ycQC1CZ8wOOyhmqbASJ5rG4O+mgwZlni1GeWu9I4oE1fRwjRYI4qc2TQ1XaquoT9it/O069fV1bY
	tNqDkj36RdMQK5arKzP7xcBVDMicI/6OoqF5pWWsCnHJlLAfB/E5NTAiTdMGiLBH2qOwkmMuvYf2e
	KNTOHV7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltxLI-00BTTm-Mo; Thu, 17 Jun 2021 19:06:20 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltxLG-00BTSv-Cr
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 19:06:19 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 c18-20020a05600c0ad2b02901cee262e45fso4286439wmr.4
 for <linux-nvme@lists.infradead.org>; Thu, 17 Jun 2021 12:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ldpYMeQHVfEJaHFfaBAlD3CQR26cWxrCbfyfz1t107o=;
 b=PBkVyJujLV7nQFSl0M77VuCTojMRo4KdD+tois4s2W1HTHy7ncSysBou64L85Uy+4Q
 AVrMVKfqXrqdVEro2y35JtpdhlVpTJOHdjYi1DoCZB/G8D5yHVd3pbz/BQOAYfq6jLMn
 rziJgCh60CjPt7E+rivZc7eIkJlmhoG6mR8iWBaax8WMU7ETZmqTOMDJ1OTRREpJG13J
 dZbWe5Tv2uaa58ku9DwkLV2/UwYNbBYmx/NujruY/baMwgpA9ztqAU3t80CZnbkqtMMZ
 OgoXbYqCkzV2nn9AFcm2r+oYaG6kguSB1wisAom7sEjqvp2meDSsqIcmCe5hdidc5Q73
 o11Q==
X-Gm-Message-State: AOAM531nvYYc9izbCKVVMjeTCG+EXem3S60b27kcNMHq9QMlrGmyjam4
 ZqxLKzGG1XzEV1gAEl6f2U3EjFP5Pa4=
X-Google-Smtp-Source: ABdhPJxGhHTxGj2XgFpaITgdZX7HE8BLnF+5AywLa7yIv9IpoV/cHCe4dlhLzQk6os3ZVbRmv2cJtg==
X-Received: by 2002:a1c:de8a:: with SMTP id v132mr6873420wmg.27.1623956775551; 
 Thu, 17 Jun 2021 12:06:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a85:d3a7:9eef:a2fc?
 ([2601:647:4802:9070:a85:d3a7:9eef:a2fc])
 by smtp.gmail.com with ESMTPSA id y26sm5542384wma.33.2021.06.17.12.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jun 2021 12:06:15 -0700 (PDT)
Subject: Re: [PATCH 2/3] nvmet: prevent creating ctrl with no namespace
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, dwagner@suse.de
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
 <20210613200252.9167-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b6b62366-fff4-81e8-5b3b-c3062211389b@grimberg.me>
Date: Thu, 17 Jun 2021 12:06:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210613200252.9167-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_120618_492148_8CCD45D0 
X-CRM114-Status: GOOD (  20.72  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>  From Spec :-
> 
> If the controller supports Asymmetric Namespace Access Reporting, then
> MNAN shall be set to a non-zero value that is less than or equal
> to the NN value.
> 
> In current implementation if subsys has 0 namespaces then we report
> wrong MNAN value for the controller if we allow controller creation.
> 
> Prevent new controller creation if the subsys associated with the new
> controller has no namespaces.

This is a perfectly valid thing to do, preventing this is not the
solution here.

Why not just set both nn and mnan to NVMET_MAX_NAMESPACES and be done
with it?

> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/target/core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 146909486b8f..26d93ac9bd2e 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1325,6 +1325,15 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   		goto out;
>   	}
>   
> +	mutex_lock(&subsys->lock);
> +	if (!subsys->max_nsid) {
> +		mutex_unlock(&subsys->lock);
> +		pr_err("invalid mnan value for the ana enabled controller\n");
> +		status = NVME_SC_INTERNAL;
> +		goto out_put_subsystem;
> +	}
> +	mutex_unlock(&subsys->lock);
> +
>   	down_read(&nvmet_config_sem);
>   	if (!nvmet_host_allowed(subsys, hostnqn)) {
>   		pr_info("connect by host %s for subsystem %s not allowed\n",
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
