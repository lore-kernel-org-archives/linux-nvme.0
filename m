Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81177C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:50:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC5B64F07
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC5B64F07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R8B9+SoSTp1wXBoFsOREz5Khi++pDCDZ6yXtCJiNf+I=; b=GSxEJq0Eu5zeqsmw9sw1zwahh
	GPmvVj8sulEwK+m6vd8uz4AWH/ZMwsoicTEzqQYogpluLIcLqrHiU2/Sv73+DSCoKFGDVwZNKBpnw
	K2ASyL+LFrh/B4hAeiuA4cd5z3o5UjN6XE/Kjy7o3Lh/PZPgDxepnQRADs1iUrcYZA1B1XMTNLW38
	GpiNoR3H7RBlOnj2Z7NGCV6UXoSOdOP0GvCsg8WP59bf9SfXd3zsrTHsq+QZx8vvwDQy7jfo3Dc9O
	ddkPI8BnE4sD1Cn5bjMsyHUYcEBgMItk8g1D5rCzkwu7nPFZCY1piZLcB/7VRaEV/0FrSh9XVAkfc
	gUwLriRNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLv6c-00Gygy-78; Mon, 15 Mar 2021 21:50:30 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLv6V-00Gyfh-Nu
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:50:26 +0000
Received: by mail-pf1-f179.google.com with SMTP id 16so7454655pfn.5
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 14:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ro1OXbkYhme2PpwbaGCsUiyN0X+Wy/g+dn02rSvbP2s=;
 b=KA7XgT+ZwWqg7syxvy4q7kt5ijreemtJZ1mLMZfAAP/SkLiCVDROKm3GF4lLhhWBye
 CETDW4xUL/AywBZ7NWmnieo9e/m6WuDczlB8MZKfkyZ+Q7wCvU3w9r2MEXtM9a3fwT4X
 QAQRp6Mdx4H7QrI1qrLXrNoR+sgq2VXoN5b3Fmce7oKylUgMh2hBZY94ObUnVlQdHnhJ
 BjSGlDJB2QDUrtYsPgZ+gw6vvZsqCESRMJJIGA5+VQ0I10q+m0NXyRYkX5piBFfW/rsq
 wmnA0E6F9JPpAMybKhuxkxyBWB8QmYnQoJBiw//WZ7t6TIHvUOHVMUur3enADX1CsBNt
 gxug==
X-Gm-Message-State: AOAM5300xyBupKDv7DH5YJD+3NxXODRbC67p7jqz4hi6G9CxfS9ynJDa
 CkzbbMvrPIwRFJeW/6Ki0bb4JUJCQZA=
X-Google-Smtp-Source: ABdhPJxePv2V4MoYu8GbNHnQPYh57ab8OEWhDUifpke44Voio48tglwgPM80Ehs38D+BpxQKoKdlTQ==
X-Received: by 2002:a63:1350:: with SMTP id 16mr956171pgt.85.1615845022126;
 Mon, 15 Mar 2021 14:50:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id d5sm577414pjo.12.2021.03.15.14.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 14:50:21 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "ngottlieb@nvidia.com" <ngottlieb@nvidia.com>,
 "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210315145611.155972-1-ngottlieb@nvidia.com>
 <BYAPR04MB49657B5E84CDE72510A5AB77866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a4a2b20-af9c-0474-a5b6-734158dafcb7@grimberg.me>
Date: Mon, 15 Mar 2021 14:50:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49657B5E84CDE72510A5AB77866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_215023_880378_CCD1485B 
X-CRM114-Status: GOOD (  15.83  )
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


>> According to the NVM specifications, the model number size should be
>> 40 bytes (bytes 63:24 of the Identify Controller data structure).
>> Therefore, any attempt to store a value into model_number which
>> exceeds 40 bytes should return an error.
>>
>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
> 
> The patch looks good to me, but is this patch not intended for 5.13 ?
> 
> Since for 5.13 we have nvmet_subsys_attr_model_store_locked(), this
> patch uses nvmet_subsys_attr_model_store().
> 
> Is this a fix for 5.12-rc  ?

I think this patch can wait for 5.13 for sure, maybe needs a Fixes
tag to help it get back to stable...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
