Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B981C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 07:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDC32072F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 07:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ovtnctTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDC32072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ejgFH4oOMfNkyWewOPaNUiKVHi39uqBPBfDfupbUK2k=; b=ovtnctTGrqKgcOxvc6PjfolJx
	314oJhYMghwX5rKcg5wzzf1bzF+hZhcxPvs65U900Tz7id9qPR973P/kGSWfJW1HNaDcjuaxByyAy
	CYc4rBMbiuXM7e/vikWsbVm7gkdLBmVi4cdFEo6RbBtge6soA+DBExcBFWamXlZECjApXJRQqrWE+
	c6Za0ctZNw9KS56GT5Z44TA/AfPydDLpnN4zRjg/z5Qi8hlKRlz13DWgO5yJh4gIAI/GDiYWs0eiQ
	+kSDkGQaANhQlv/d+dm6jH9F/8gadwruAQhRGNx5I2KsQwxhQZCNUtyJPRskd+wXWkzzNiHvHdKUE
	6eeS5GTMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg1K5-00078z-1g; Tue, 02 Jun 2020 07:26:57 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg1K2-00078X-JP
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 07:26:55 +0000
Received: by mail-pl1-f171.google.com with SMTP id n2so980091pld.13
 for <linux-nvme@lists.infradead.org>; Tue, 02 Jun 2020 00:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DnnlMUE+TVOUifLZ4QeabbiKpcF5jRZhpD73ruxiaGo=;
 b=Bp8/M0Jnd/BIuFOlyicFcllQvzCUzUEDA34zqSoPT1mq9BgcduWfP1A9YLfdBnmF4V
 FFLhBKfn6Jp5ajB284dX+WCmUamsDca3qc0Y7vdhmRw9CgXV9sDVeKo4Hdi6DQ1J5qrW
 YiOEyrHIdEz96smSNr4Qfy2qRDLIkfL+jc0x60xUYRO5twn+OmQwlrj+SvWLzKCnt4+1
 2ClA5gB7W97cNjaq1uu4ECVQNRygzo1x0UviCI+sw2SiPyc5sKCFSCI1CnFa0tdqpREN
 WmtHyYAdI4jnTf8teJv1NxGQsAiM72YKjyjDSjju2QqzlyH/LLvD3QeAmDNrZ/j+yZYO
 x0pg==
X-Gm-Message-State: AOAM5322QSYcMeP05n4lkWdtnZu+VNU4gt6hHETR0Vl8kvebuRlgQrDo
 WaoxYT0CHqlGu8iY7LEGIuWxFeFZdb8=
X-Google-Smtp-Source: ABdhPJxuTq94T7AD5zSl6xIefCGInF0auT1syCdQlZf1w9AqkjHy1P6x5bbiY4Q97hqjFFbKXJ2ctQ==
X-Received: by 2002:a17:902:aa92:: with SMTP id
 d18mr24352296plr.127.1591082812364; 
 Tue, 02 Jun 2020 00:26:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cc02:c83a:8bd6:1cfd?
 ([2601:647:4802:9070:cc02:c83a:8bd6:1cfd])
 by smtp.gmail.com with ESMTPSA id h7sm1430705pgn.60.2020.06.02.00.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 00:26:51 -0700 (PDT)
Subject: Re: [bug report] nvmet-tcp: Memory leak when connecting /
 disconnecting to the target
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <d9e18f6916a24a5a921ebbf5ec5e0249@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29ca9be1-22d3-dba6-b2d1-648b27e471cc@grimberg.me>
Date: Tue, 2 Jun 2020 00:26:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d9e18f6916a24a5a921ebbf5ec5e0249@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_002654_636877_2CD69BC3 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> [Environment]
> Branch: nvme-5.7
> Commit: 9210c075cef29c1f764b4252f93105103bdfb292

Hi, can you please provide kmemleak output for this test case?

Is this specific to nvmet-tcp? what about nvmet-rdma?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
