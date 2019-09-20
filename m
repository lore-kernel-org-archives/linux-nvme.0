Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EFC3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:52:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926B42086A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XqK3KIvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926B42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ubOLO7yRLXmXU5XHsu2L6vVH7rrx+x+a1EmvpwIjz+g=; b=XqK3KIvVsYlG3P8sdhYwoSktw
	AGlpYsgqtS1aT7d7lVDNtkwfxiWa32SxeG2Gq42ZBAJUXxAwC9ZH0cAtr04pOEDBCxQw7InQDR1Hf
	SADO/0uuf9Oa+sLLYC3nKiLt7yGFV0xB7v8wC3gk7GCcrffxHeGjEiQetN6nIlXCA34w7TJfWcaTp
	m2X8hCfizTcoAHCqRAnnthv9Os81xhXZffqQ2EZkIILF5Of+QCPGrd7+GzbOf86lPpAz0HfpLmp9j
	PXOtsvPEbPgMHtHLca/6qELVpE41zXl2xcMebOOP2oW+P6X1sNiIad8aGXaWtVWhdp+xf+PCUWMge
	RpFNe8MUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBN4Z-00052a-TX; Fri, 20 Sep 2019 17:51:59 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBN4X-00052B-Bh
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 17:51:58 +0000
Received: by mail-wr1-f65.google.com with SMTP id i18so7606864wru.11
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 10:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AN9aPx99WxCWL1/VSK33UdTIgpopoadgtZlksmY9Z/s=;
 b=sp166AECl0YtIlntASrw1V0cyumRdRN05S3oX2Bh17zApqpBAq+pA4t+QBd3ohQM8k
 +ea8Mx/FYSQuwGoUaD5YtFq1pcaRHpi/IuIxOLIvvhL528oBtA+r1pNhO3kvo3frDPQp
 2lfmw/U8eOnGm/1N1F0bnjs4zsb42R5yGueH2hjKELVqVtIOBfeNVHkJ4YSMQ0RXy4mZ
 JmHkCcNi7fauN2VuKSFQzilWFj3ypT2sIsV9EnzXKBVgMXMU6uyk2PyHYf5VD6scV6oM
 azYpC36GYPW5RLgndaiHoWmdbggVkgTeCEpIlnguL98Y8s+lwgCUJf1OSUpcCFfuOOij
 ma8A==
X-Gm-Message-State: APjAAAWPvkdOTWDLtBLhq1CsowOjiULKU+ZcJucrA+PH1EA/uOAAmRSx
 w+JsvB6Tw/wVgc2X052eYhscu9lj
X-Google-Smtp-Source: APXvYqx2x2/sWwGCqbPThKfdG4WwkDljeKcThcE7nhzfmnpyRr3tkjr9kKuL23H8M1chHL3FB99xNA==
X-Received: by 2002:adf:f4cd:: with SMTP id h13mr13913290wrp.42.1569001915848; 
 Fri, 20 Sep 2019 10:51:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id d22sm2394582wmb.44.2019.09.20.10.51.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 10:51:55 -0700 (PDT)
Subject: Re: [PATCHv2 0/6] nvme: double reset prevention
To: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6f31bc09-95d3-bf11-7846-e57d8600462d@grimberg.me>
Date: Fri, 20 Sep 2019 10:51:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213431.7864-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_105157_395124_D30CC821 
X-CRM114-Status: GOOD (  17.13  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The main objective of this series is to prevent double resets. This sort
> of thing is known to have happened if a timeout occurs at roughly the same time
> as a user intiated reset, like through through PCIe's FLR.
> 
> The double reset could happen because the controller disabling had been
> occuring outside of the RESETTING state when we can't schedule the
> reset_work, which is to occur later. When another reset schedules in
> between these events, the controller ends up in the wrong state.
> 
> The end result of this series is simply to block subsequent resets by
> initializing the controller state to RESETTING without actually
> scheduling the reset_work. The first patches in this series are simply

are simply what?

> 
> v1 -> v2:
> 
>    Merged up to current linux-block for-5.4/post
> 
>    Changelog updates
> 
>    Patch reordering for correct chronological sequence
> 
>    Fixed state handling for f/w activation failures
> 
>    Included a review from James Smart on the patches that weren't changed
> 
> Keith Busch (6):
>    nvme-pci: Free tagset if no IO queues
>    nvme: Remove ADMIN_ONLY state
>    nvme: Restart request timers in resetting state
>    nvme: Introduce nvme_reset_continue
>    nvme: Prevent resets during paused states
>    nvme: Wait for reset state when required
> 
>   drivers/nvme/host/core.c    | 80 ++++++++++++++++++++++++-------------
>   drivers/nvme/host/fabrics.h |  3 +-
>   drivers/nvme/host/nvme.h    |  6 ++-
>   drivers/nvme/host/pci.c     | 78 +++++++++++++++++++++---------------
>   drivers/nvme/host/rdma.c    |  8 ++++
>   drivers/nvme/host/tcp.c     |  8 ++++
>   6 files changed, 121 insertions(+), 62 deletions(-)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
