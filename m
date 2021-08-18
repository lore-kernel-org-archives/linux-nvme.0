Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F761C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 13:29:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD9B60F4C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 13:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6AD9B60F4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3hhda1xEXe2KRWIl/I5NPmqfKIiX97/qopUOaymurh0=; b=LCAxpocToUO52TQIeolmRoz7J7
	DpW7a9J5D3cPLwxU4mJK5k3DDyR+PG/VgQ7+RSEp5bOJ34Q+yBNyMEG2Dl37bP0m3UktHVEbfvnjn
	+44BkGDtyut5HciUSBC87CLnPUK0TeQ3rlhklQXVLTp5cyut/sx15ie/eFZpFc/vkeOv3MyWgrVRl
	27QhoNT4OnjGPsPnN+LNoRL6mWPt4XNiXOO5WhKmPARSOF6+kZHpP/6ncGhooCbzHCRFBpRhJf1Vs
	6dIa5Hqahomgfx2FU1lpPfgRn4CxpHdoYkizAMh4qTUqc2olfyGRy8snHvW7rzP5O7tXcZYJAgvTM
	W9IYo8Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGLd4-005h7O-VB; Wed, 18 Aug 2021 13:29:14 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGLcv-005h64-3z
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 13:29:08 +0000
Received: by mail-pj1-x102b.google.com with SMTP id
 m24-20020a17090a7f98b0290178b1a81700so2304920pjl.4
 for <linux-nvme@lists.infradead.org>; Wed, 18 Aug 2021 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YZfF52HpL/UKlefpqFZVekLhQrr9CceEDqqOQlI/5cs=;
 b=VANPbhOvUtEl7/HmLunl0gKjYeFV8bzE5NJu9BuCgf17P3e4Cg2Hc8PFMJN34YAOKT
 V+q5UJzXGLd8M+jOMoq/stNCyu2FVR/0XZ7t4qb/RRCklaW1HPbRWe5nfdugKg9KQxgp
 ryK/Xr4Nh72g2cA/xAMroLzGqcXxIsh/KTTu7723+GwXvSDlFqDUCQXLMFflZYUFT06p
 UGsa0eak99ACPYKKx5gKPgca2t7puUcLZ7vOZTMRewUxp81lC55DYOfXsU6X0gC6h4ip
 BNqwj12qcJaD1P+WmR4MGgolBPE1Y0SjeoSrZRaXTHsbTeEc/TQfRpJaPLNjetFmgLSs
 uT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YZfF52HpL/UKlefpqFZVekLhQrr9CceEDqqOQlI/5cs=;
 b=jpsVzievy4g8i7ld+9I4dqQk5YGDZJVU+cIBapmTtWwyD2mR9PMHEoFpsU1il5jGav
 f4Z7Ivj0uabpj1o3ODKfyZwy+53PP5Z+4ObsS5SD66Gns+jmGoR29Aaw9tK3ex+yAPA7
 pSl/Xq72o5rsfZJvjATkN9s50SZsAb3Lhj+iJ3q5gCoFvgVNK8KgAyY7zXQ5WhSlo6BP
 4GVlGfB/CGddwn4wftUYRiQ3qF5WpFFQzVRJZ5Tufo1NHG5ohe5crJTDElMFhbwoJWTH
 RWlaCv0XE3aAdxfSxhYd5I3VDaeSADbLXEektaqKdu1oxlNrmxEpk4xkUHhIgCNBgaof
 hl6Q==
X-Gm-Message-State: AOAM531+d074pOxfGveJqybCSN53rfg4d+h7J0oS9PsyIwapmHNr07ls
 8L3Sear4Ee1d4BCWQM/6MuWNbQOBtdSPJABP
X-Google-Smtp-Source: ABdhPJzcG4MuuyYGSYc5aRovMBAKdtgr0/c+TmaEGwcn6bvlGOd9c/rLwCWsd7uFwB1rb5YeBKY0Ow==
X-Received: by 2002:a17:90a:5801:: with SMTP id
 h1mr9105659pji.63.1629293343263; 
 Wed, 18 Aug 2021 06:29:03 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id s46sm6663515pfw.89.2021.08.18.06.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 06:29:02 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YRy5uawonM5ERm3D@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2e66212-d555-18df-c9db-957b43d584aa@kernel.dk>
Date: Wed, 18 Aug 2021 07:29:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRy5uawonM5ERm3D@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_062905_213165_52D96F61 
X-CRM114-Status: GOOD (  11.85  )
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

On 8/18/21 1:41 AM, Christoph Hellwig wrote:
> The following changes since commit 9ea9b9c48387edc101d56349492ad9c0492ff78d:
> 
>   remove the lightnvm subsystem (2021-08-14 15:54:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-08-18

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
