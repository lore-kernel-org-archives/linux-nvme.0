Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03835C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 16:25:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FBF61405
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 16:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FBF61405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FwSbArC7ec8biZ+8M7nA+o34w9FUMviulPb5rRgUrFc=; b=Elm42CIR+gOWs884W9M2micMY
	07nuBBCRgiEmHTQmGzDCu6cI9/6p2nDCvCxxLVpSFeFUzys7cQrmEfVaUbAyWOnFAo/CzSbFEw/mm
	nEnlBXL/fGnAwBKYGHzT4LmiKyP3TrOwiVrAXG54WGhisYxHNTXOB8Szm4DpM86Ln7SfbuVuIYUHn
	stSCfMmCQXkNpDpZ2iQ44LRxrYpkGTIr1oV5Coy1amA7uEFiOHt39oKZ71OeaWO4CCHCXVxy++doT
	YIapTTGOnKqBPxIQKqBzhiRJxrycbgFsYXo1/jIem/pL7EiMCwoJAdgvWujSpWb5o3oaHy3o8/5QB
	eWRt/CU3A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZc8I-00H3es-RY; Thu, 22 Apr 2021 16:24:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZc8G-00H3dh-DP
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 16:24:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=qNli8Bvyrp/OrayAw2x3P5rkmIQ2D/dpkSqa0fGuG/s=; b=1NBXgNPnZTEevldFngIbTxDCLS
 DxBcpI+hhilHtpOEL6XQJNjhS8FoxSqY5bOzmh8yoMsC/izh9hcI+CaCW+gS5zDgCXwmXLOzZujbj
 tAEh264LLBFObpW2tfy7feQXjy1nmJa8fuYwfwfIgUY8KFTlBQTVDstf3Vgx6wFcnZUsMBUPbFbsx
 7gMgRjjacoUQSyy9lTEJYTOT2wN4CwUpSsyaFK1UCcwG311GKF6tXEra3hFN76d6CWOH5bFrf6wLa
 gDlVum3qskIES32jeq1WzI+JVYoZ0P2RwQHHx66tX9CmLsE6PnLOJowqRCU7U80SPfpcFIcC1OWJk
 QRuMr+tA==;
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZc8D-00Dq9Q-FO
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 16:24:47 +0000
Received: by mail-pj1-x102b.google.com with SMTP id
 f6-20020a17090a6546b029015088cf4a1eso1253884pjs.2
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qNli8Bvyrp/OrayAw2x3P5rkmIQ2D/dpkSqa0fGuG/s=;
 b=cjuFxwuL8wRM5mOipSk8cXJlWJgk3hTRlDI44cj/Y6IkMlXCNFqN19VDCdlxhZ3sMR
 7GLz97ST15FolpO/0NeoO7FbUqMxju0mM34ZECcSC0wU088Hpz24USb22r90Zm3ATT23
 BAk4yModv5pAhsft8UzB+PTP9YQ5fYKOgzp/VWZxguqybOJ+h5QxscexyPAir+GdHqgd
 kRSzzSRly8sBo37lowbK1iLT0QLWsQ1BbCN7N9rISdRcbhUv2o9fd1ZZ2UdPlcpNUZ9T
 7Ig4f/speBxnLBwtB1ehvACuOQ6pkBWJgAklVwu4q4gtArb+vr/I46iAK7wyL3Gth+R3
 w4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qNli8Bvyrp/OrayAw2x3P5rkmIQ2D/dpkSqa0fGuG/s=;
 b=ooiTpmyaOH8/qppytZYCo+j8gmOYaR9K8mEiXAFSVIIqDZnwSBWLKuTDSqUi8XFY/h
 1URCy1FJCseVtyUtNxWu3SaOcXc08YcMNW8+KDKCVuLImte7j4YtJw+AWGojIchv0N2Z
 HZ4IddBVhftvZv3Hiz3wb0f7TkqOkIyhLgLcJVZ2OInXAHNEkFIpz6aoK5lCD+4PxlAp
 cGV5iOgZca265zrjGVMsUs7L98frX1xSyWaI25tUPzhyJuCXM1ZzPtTptj91cCx89hsf
 HKEPvFCkSEclOdL87F+IGWVeXPaDuXwqgEcGPZaNG8aZt9IR6Q5R0ssTRiHnlJb6oyMR
 vFcw==
X-Gm-Message-State: AOAM533duj/QoNnsBreJb/gzIzM01V7GxknGGcPvP0+9YGerTb4QNZ6w
 eBuBnLK0GSPBhvkc4kzdS6roJ8ELNVpR5A==
X-Google-Smtp-Source: ABdhPJw408HfqX8ux0SMjNoU1+smcc6Tv2pTBLITekCTe+8bErtsbPS6uronB3e72pTPGY3SitLCrw==
X-Received: by 2002:a17:90a:5d92:: with SMTP id
 t18mr4952889pji.226.1619108683214; 
 Thu, 22 Apr 2021 09:24:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id u6sm2474501pfi.44.2021.04.22.09.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Apr 2021 09:24:42 -0700 (PDT)
Subject: Re: [GIT PULL] third round of nvme updates for Linux 5.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YIGE8ORkKryOdxtE@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2bc18dda-c09b-7a97-5766-0b7a9c14033d@kernel.dk>
Date: Thu, 22 Apr 2021 10:24:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIGE8ORkKryOdxtE@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_092445_681002_A6814E14 
X-CRM114-Status: GOOD (  11.49  )
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

On 4/22/21 8:15 AM, Christoph Hellwig wrote:
> The following changes since commit b777f4c47781df6b23e3f4df6fdb92d9aceac7bb:
> 
>   ataflop: fix off by one in ataflop_probe() (2021-04-21 09:15:27 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-22

Pulled, thanks

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
