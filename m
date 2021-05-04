Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE5C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:57:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91070611AC
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91070611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oaMg62XX64hLnThrQOmXTclB0K21ntczLSUANDd2dfQ=; b=KEMtG+YFKUFKfqJw2/htcO8BV
	u0mLBILoG0qAFz+48Pt9vfs83ZN46NQTxeh0eDgF4bM3/VpR8Z0I5VkpBh3D5nSqNn6sRlQ2Ycovd
	7V7yessL35PbjHPaAG5e2X/5XZ0+EdFmvvDmJMywKvi3ew7o2jaHHDnmbpjH913/sprY9frfHIBAF
	ibDyPaazEv+2rwQrDW1xB9Gnfh+VPn/jhzKt4N/VX6w3An7OcUJ2xq4Znc0+4KGM2+69eoF8gu98r
	VGT/IGaGM0iQ/bncsYg/QX3jeI3SRGSAI/CPYj8V676abCyaYZxNQMDT4srpAct3u6J4755Lkqp27
	DE3xkw6YA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le1AD-00GxpP-08; Tue, 04 May 2021 19:57:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1A9-00Gxoh-Kk
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 19:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=MGstaeLeeYawbnSWIbx1Lak6nJ2JjNuXCJziq/A5oNY=; b=Icru3aWWXqf7UcCnvo3eXMlK3p
 Jfg5Hdno9H9i5AeTIBCdHaG7i7vcHxNKJs2vyfG97ZG2FoJeckY2anJo29AUn+07Bm8vCuahrzzTY
 Kl43MONtCN+PX+tIHEKhtXqKQE8BOs0bkDEIx3ToR0mlT9TyTIyqFLgGtB8L4dSGaIzmAv8TP41tb
 3EMIJKptzsNlqZKhe1U53NqdtYdwRi4hmDsUneuWeeCoeYaeWI8xWs0Beil86ie6Kv4iWY87kKDcX
 Ptph0PeSrkujHV7hdTduJqEMOy5pOyvpCQN9IfvO6IFOcXVRbi8W2gPHdvWncBT123SB7/CuaENmu
 +pKODjYA==;
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1A7-004EW6-0W
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 19:56:56 +0000
Received: by mail-pl1-f182.google.com with SMTP id s20so5907298plr.13
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 12:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MGstaeLeeYawbnSWIbx1Lak6nJ2JjNuXCJziq/A5oNY=;
 b=LsKaqgjWFiZGdD1bd153wmJtuG3+88nr0FXBIZBUhUcUWyzqH/VjA/x+YtjxZPzbKC
 LqfTSc7e/XoV9eWOOwgNVKoFvmWVWt6RkEEfxSYVj8mfrJmdhaXmL5WZp7vvCGGxdldC
 TBXFVcuKSU0wys+5vMX2DTFFOwhpOIf0oI3PJkfRPyYAgvAV+Tbfg9FxuphteCLmPGPF
 JXJPIFjHWnf5ZMsbXOpOUS4ZR09fGYrHKxCUE682Ujpyy8MG153Hm7khrAnTXK3kpmSX
 vRRgBpSTWQ7teEseXP9nbciRuNbb0WFecweLTxK5+qquDjdXkTNPz53GVcPjNV+4bL4v
 cCQQ==
X-Gm-Message-State: AOAM530Kc6H7LlPThSKjlEjEYnOr8+G8wLNep9ZbHeptzlgX4Tdpjapy
 p4sRmwqDChMfhYAw8c0qimg=
X-Google-Smtp-Source: ABdhPJz5fwoThCdpWLFgLqmy0mIdqjUFsYW0UtiuK7tsmhGfghiEsvzA48qqFy30O0wpWmlyYE5wUg==
X-Received: by 2002:a17:902:7b92:b029:eb:6fc0:39e6 with SMTP id
 w18-20020a1709027b92b02900eb6fc039e6mr27445272pll.83.1620158213716; 
 Tue, 04 May 2021 12:56:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:dee:5152:2348:42c1?
 ([2601:647:4802:9070:dee:5152:2348:42c1])
 by smtp.gmail.com with ESMTPSA id 16sm4989970pjk.15.2021.05.04.12.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 12:56:53 -0700 (PDT)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
Date: Tue, 4 May 2021 12:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_125655_085201_DBE85967 
X-CRM114-Status: GOOD (  19.58  )
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


> From: Martin Belanger <martin.belanger@dell.com>

Change log is missing...

> 
> ---
>   drivers/nvme/host/core.c    |  5 +++++
>   drivers/nvme/host/fabrics.c | 14 +++++++++++++
>   drivers/nvme/host/fabrics.h |  6 +++++-
>   drivers/nvme/host/tcp.c     | 41 ++++++++++++++++++++++++++++++++++---
>   4 files changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 288ac47ff5b4..91ae11a1ae26 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3961,6 +3961,11 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
>   
>   		ret = add_uevent_var(env, "NVME_HOST_TRADDR=%s",
>   				opts->host_traddr ?: "none");
> +		if (ret)
> +			return ret;
> +
> +		ret = add_uevent_var(env, "NVME_HOST_TRIFACE=%s",
> +				opts->host_triface ?: "none");

Given that this was the original intent for host_traddr, why not have
host_traddr resolve the iface from the address and set sockopt
SO_BINDTODEVICE on it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
