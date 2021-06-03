Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E837C47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 13:43:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615DC613E3
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 13:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615DC613E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=03AkY8LVmR4Shp84yUfiSQZw9dUBfTS0frKopzaMKXg=; b=xJcK+/ASQfpD9iicAoVFPqtXPg
	4Tw5MgTz6wzqMZWPoQszo+jcOT/G6XewrobKqMumcpcOT1msQZ816wWXSOfURQtKdB9pPYBVt4scQ
	V9VjuB7IpAMtSx6GnLIoJFUO8kM8sLhKxQnn6HEmvPtnrqz5rgPETBn5P3pwhQjJr+WFzEUdmc2Ca
	+8h33dYCH+rZYOF/tla2kq+Imf4/PKiAEGiM/fzL2kdCdalKQGbNvdC5g/acPBqpmzada+PueFYWH
	sZUunfQsDE0kv7vcl1p8OgbikSD1jUGsBj5/mQKqPXBCza4V9DtbPonwLeCGc4R6TOeh82AWe+ZCM
	O1h+IynA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loncd-008xr1-Uz; Thu, 03 Jun 2021 13:42:55 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loncY-008xpj-HH
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 13:42:54 +0000
Received: by mail-io1-xd2c.google.com with SMTP id p66so4443303iod.8
 for <linux-nvme@lists.infradead.org>; Thu, 03 Jun 2021 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1RDUISF2jsikTWwm3f0Zbh1NDK4OuRR1Slpow+Un5vU=;
 b=V0esR9S3/wJ1cAgfIL6tcbRBlsmNwi2vKK3YrDvqflsD91/iwrmHxvH8CbELUFZQox
 aeCJjjhsY7P42mzQXAuo/d7357fSe4fxy5uoKn2geR4F3F37jp1RI/4054a+/UYpdOs9
 Jvb8ftpaiTgyRR0D0rKsesxUZMYKgtTKuHf7yrS1V8eKLYQm3LlnZ6cA7TE+nKC9LzPm
 icAZQVKej/EOz4OdXH6qNys+XuFtphqPGkFZyEb4mhJl2oe9x1jg1tfBQO+CLk7kjbe6
 VX7gcU1io4Lnn6pWFJxB7KitqjQfg95OJxQ97uBhgvH+BZNf+SbYusOrb8CPzEimchZO
 EUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1RDUISF2jsikTWwm3f0Zbh1NDK4OuRR1Slpow+Un5vU=;
 b=Fx0HbBgu+L967xO3Ud2+W9obp5vd6z/hfENgXNqS3GzLXb8KwTHrebG++8qpokWCvR
 /Ex6HpXo7Ad0CH0yMXFCdzITGmLo13ps/NAdRKYy4QULWm1fYMr1gzmok4e1ZhmZkngd
 CFE30tig1gO3jibwX5ON67Cq6IcppSySccAbeykO4LEX9+wNQHodY5LlKn5fH99AHfxi
 ZNV0tbSljiVvTuKXv9FgwvdzqAwpSD7uHV8D8bhDGNy6sxJThemSVDVaymEone11Ldc4
 CMfOqUfy7cfvGPZWFQR4hMhHOXY4510UtFu/mTARSpx6hmGintNdQtMM3XXJ5jTzgQIO
 2L5w==
X-Gm-Message-State: AOAM532oLRZAO/hpHZMxiuqW2SFEhirT9Q5u6buv73RJWVCxHdjcpTVg
 8nKRcFJp7FCGBFk/p8z8Tm4RWAJk7KJxIyVj
X-Google-Smtp-Source: ABdhPJyvhFMKNbIdh+lPzLE0icitYuwpRQlqqSNC6QqRYx52mr6hKPoq2evVj57bwfkUobA6EM817g==
X-Received: by 2002:a05:6638:197:: with SMTP id
 a23mr10487867jaq.77.1622727767427; 
 Thu, 03 Jun 2021 06:42:47 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id g3sm1571814ioq.42.2021.06.03.06.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 06:42:47 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YLh/K7UbJFnA2HPa@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4e58ee70-d923-cb66-44de-5e9f82408189@kernel.dk>
Date: Thu, 3 Jun 2021 07:42:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLh/K7UbJFnA2HPa@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_064250_726662_85AFE0BC 
X-CRM114-Status: GOOD (  10.98  )
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

On 6/3/21 1:05 AM, Christoph Hellwig wrote:
> The following changes since commit a4b58f1721eb4d7d27e0fdcaba60d204248dcd25:
> 
>   Merge tag 'nvme-5.13-2021-05-27' of git://git.infradead.org/nvme into block-5.13 (2021-05-27 07:38:12 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-06-03

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
