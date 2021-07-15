Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B973DC07E96
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 15:32:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C7D613D9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 15:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C7D613D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BK15sLoeHBhTtQGyUeYFSaXZz/nRfky3b2sa+k3qMpo=; b=KAWL+piASmJ+z8HBtQVaUdnsy+
	N/OA3l/E3bjR6SMU/Y6GE81W+3FhkbNnhS/rXrlOJc2nrjhAGTm25vGwelwO8RiXNGkfeDmENkACo
	93c12FSqAf4CmhwOQgLb4kc/wGa5LUFa6U3VbplwXfcGHoXHFAOiqqBZW7KK/Q10Urh0wSiGcNYBI
	e+ZECcjE1S/RFhV6zYw8Kk8EYpcobMT0cjpUOQKjKnXKG8ikHHcEIXaJPDL4xOCNNirAT4JJl8O0A
	OKoOeugTdR6mTD8bKfkV8ma7eMa+H4xUJY/MJTj5jmKm9w6+2sPQH9CMiVyeN9TXKGj+EtiZtJMNH
	w98L/jGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m43LM-001EMT-Fc; Thu, 15 Jul 2021 15:32:08 +0000
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m43LJ-001ELA-SZ
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 15:32:07 +0000
Received: by mail-oo1-xc29.google.com with SMTP id
 n187-20020a4a40c40000b029025e72bdf5d6so1638279ooa.0
 for <linux-nvme@lists.infradead.org>; Thu, 15 Jul 2021 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ore/buOvmy6PiNPNB+ZztbTPRHromdTxvhlN0ku+HBo=;
 b=oHVwezaYtR6TAFgDpETK45laJD6NHI1GRFaJ+Iu7pQnNWgbfXAgm38Ead7lGAghoZF
 xQPeehO+zSPrEyVENDsIZ78TZ3VpvfxTV6a4wTRIrbyfv2zxgQC7pLi1fB2PXOGvpVXP
 u86ptOdg+wytdLo4svunqcl3CzdewOQ5j0/xIt6+HGgnlMXbTtcy+VnU+85/B8vLc7dc
 qg+0iND5emyy4aWHsPSDw26AgcwOE8TF1UHqzkcprdFUH6Wv0Enz+jY4pgPauP/fLbJ7
 yTScpC3VvVhURILseAMGW4HByDKPOGlH+JpmuaPBe+BPuQGSaiQfls0w101FLWK4IrkF
 CAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ore/buOvmy6PiNPNB+ZztbTPRHromdTxvhlN0ku+HBo=;
 b=Zz4C9jTJ9fvPcmhonRjXu/46Ns8hOrE+sFllG8fMGV76z29ZdehnGKCVZIazGD/JzF
 LtAIajOQ+NIaee3LeQt6HFNFDHGmcpUE/vgevxHFYdjPycAKdo+Qor4U8O5bBzr8WORX
 DrrD4mLVCKBO4fH3TCaAksyTCVq+bJk709CgeLdsY3EV9VD3ELl/D2hccQH/BNtyEQKu
 iEUBscTdXKXof4VluxYn3M2ghsP25EdRbyzg1qZIceX2gWCtNM/Gx+A1SNqTc9KuJinE
 Ko8Ba89Q0Cp/SGl9sABduOfyuzUReZRq422wMZ1uckpOgluCiB0nLy+xJc2usI1cVFgQ
 mKBg==
X-Gm-Message-State: AOAM530BP3ymdaV6zVvT5xXKl5L0d4ViN2p4qFuC4MdigKE/2EqUL9zw
 nFu2vuMp+nwBl2fYLUSOVwUKvIGu8KljPQ==
X-Google-Smtp-Source: ABdhPJzzUyp5Uje9lJudJSaYThAMnKm6MS69xFpl6mAyniP7sxy7BxdpRehY1HafXGlmOqw+xx3SKA==
X-Received: by 2002:a4a:db42:: with SMTP id 2mr3885401oot.47.1626363124320;
 Thu, 15 Jul 2021 08:32:04 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id p4sm1114948ooa.35.2021.07.15.08.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 08:32:03 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YPBCY6IjDBwYTceO@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d4ca9178-9b6c-0612-b1ba-57c244f69adc@kernel.dk>
Date: Thu, 15 Jul 2021 09:32:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPBCY6IjDBwYTceO@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_083206_024700_56CBAA07 
X-CRM114-Status: GOOD (  11.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/15/21 8:12 AM, Christoph Hellwig wrote:
> The following changes since commit a731763fc479a9c64456e0643d0ccf64203100c9:
> 
>   blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs (2021-07-07 09:36:36 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-15

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
