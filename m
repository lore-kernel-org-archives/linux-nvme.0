Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9AAC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:56:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FAA664DF5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAA664DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CJ29lfvNGByey3XmJqhx9Nlj40EY9IwHDESOmuDL3tg=; b=XBJ3kW/pLuGv/V55kDNxRlavz
	Wp/Gtmm2FwNZRyelaKm7kfpyHSeOVat/QIZjTWGA68aP3Sq+W30IY7F7XyWI86wHDWCV7/xSKfXJg
	cpZLuUKhc6HxB5ToDW5+WDHZluOYrhDnOUcYom8zvmPzbcBreqWehimLie0D9eP1p2+JguRZ5G05v
	2a4+4cgfpFXVfLmJ+62XYL5gcGzDpU3KNc6OkZVNGB9r7WTy+oPstE6zXcas6fGpFUXmfDwrfHI60
	DM6SJip+6tRYb8rJg7d/8lOnQF+w89V6zYajrSrBVDqNnlL9zKRUk922EY6W2UR/Ac7Ozs+A/Eksp
	OnfpwszAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7R4I-00051R-EE; Wed, 03 Feb 2021 22:56:14 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7R4F-00051A-Eh
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 22:56:12 +0000
Received: by mail-pl1-f170.google.com with SMTP id b8so666945plh.12
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 14:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nRdz6/NXmNPYWrhhI5dKDdAbc2iWE4V9wNyC8owQDew=;
 b=oFVomSyb3G7zpGZbNN5hFFRR4X3A6+g9SeEdIDvnwK6qeOHrgv9EJyMv+Pwmu9x7jN
 QAkYJG7KtzASoAuCyMUNXrt1L4TzRRVoG8fvBxEtajEK8zklBORe4fY53uEsttg5CiQ6
 8FT2coTdwW0Rk3BRCw5R/WVPNWPd20MXQm79rOrKcXienIX3OWPqc000U9xT7MjYeMDS
 yCnu5EoG2Ib41UPN+n0N1Om0N4t06fzVEti5eCLEcgvxma75d3qe7tZrFWYf77Qcg90D
 i9K5xKmGuIOHBQjp3fZ3L1P0x7HeUJhfOMnKXhNvRz1erdNXAibEmhW4WeF6PUmHx2uy
 glUA==
X-Gm-Message-State: AOAM532T+Ts2zvp0g+HhqRIbr/X3NYW6cCwuoXzUa7OgUsvGZvM9wyLi
 jyu9p3dmNjIBFx8wnHNKZ5lfmahcjn0=
X-Google-Smtp-Source: ABdhPJyuJmzx0jGle2Fs/GZ5v9oo3r5aWT2S7NMBkUElVw/lj7q1hz/r6AubLv6JrAKjnjSPD2AhQA==
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr5069354pll.0.1612392969970; 
 Wed, 03 Feb 2021 14:56:09 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:cd99:e813:1dae:a15a?
 ([2601:647:4802:9070:cd99:e813:1dae:a15a])
 by smtp.gmail.com with ESMTPSA id f71sm3450595pfa.138.2021.02.03.14.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 14:56:09 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
From: Sagi Grimberg <sagi@grimberg.me>
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
Message-ID: <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
Date: Wed, 3 Feb 2021 14:56:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_175611_810071_F48C5E7B 
X-CRM114-Status: UNSURE (   9.75  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Martin,

I can actually see a RIP line,

Can you run gdb on vmlinux and share what this provides?

l *(nvme_tcp_init_iter+0x60)

This is strange that we even get there, because we only
initialize a request iter if we have data, and this shouldn't
be the case for the async request.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
