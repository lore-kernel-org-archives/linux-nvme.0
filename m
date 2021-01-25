Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C33C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:54:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076CD221F9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076CD221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=genVYl7BDYvBe2SKyPU/Rc6vhX8aVCoFfpXtKq3YOhE=; b=3k4aP96tHzJMPNzksIEjU7wsV
	/MQhDcmwdaCawC+v/v9vYtVYrci9jLc4nfnsa+tCuPoUvZjxh+GerK2y9o+gjnlZvVPLa6QeeHrIL
	hXFOgqRuIr7b8FMC7prAbqMYoCL39Z4SkBNXbgWzsfi08niQdm8jW2g3vnBKyVQmTBUCfFg4JSNKe
	wFYEIxVkp90bnYrDUfEFg8bu9SIOPNUGELa+U5XmK9nLMRurb/8Z7aDWoW2kfvDSpchgj9Kc/d1Tz
	U56TXO1UMwYsq92QbrIjV3UZdKgmHKi8sx/yE45jXfTnahmYVQweiSNoeK8GUAGjccagIEskJxwqi
	TzwZbERqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3tsg-0004iX-2R; Mon, 25 Jan 2021 04:53:38 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3tsc-0004hR-IA
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 04:53:35 +0000
Received: by mail-pj1-x1036.google.com with SMTP id kx7so7623667pjb.2
 for <linux-nvme@lists.infradead.org>; Sun, 24 Jan 2021 20:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yCVXNmnkbukJI6FbnBMkRVDM8J/Lut2yGB3GCl5tMhk=;
 b=mUc+2GmhUCQFtGXsbDdMUePaHUC70SqcjIvNUGzmQAMRmDih05IYA/pLKTv5cpBUJg
 8D4F5NWSJKzdXYHX3tUo/gpur6bsvJgO0jl+aDqenyGk4M3crlQnK9+R3fse9TDvl9Kg
 PDvjAjdRxv7sEQky3VyreBHgThr+GzpCJW1XuWOAUmcO51X0t91JXgwFck88xc5IXzZ7
 kcZMpDwGdq/6TX1yaFTbsmRuAy8Q+Bd9qAymHynKCsDAhhvlHsCRTzF+gutiHWy4k037
 tg1DroGlhRJAHLuCAeOG6dOO/t8s4/8RlUz8Nd7VLJNZUmhsSiwItgtDZcoPgaKB9O6D
 PMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yCVXNmnkbukJI6FbnBMkRVDM8J/Lut2yGB3GCl5tMhk=;
 b=CCG6m5x1yXOnAt1VudwZqioSeYM3VcRYl7iM76xFtYDHwAGrh6OX2SRgNMIn//AvUQ
 zc0nf7fnvLl4ILwumYKtLND7Gwi7kWBcPIexGGJCB5IO7eJr2lnYgBCH3Ms/rSWcwkaB
 jshk5gFRSoEoIgzmruIMTQ+y2wxwLaBcf38l0ADJ6tcT21Duk8tjeozDRVwIZ9ojF5ia
 ATiLJCsKbsJ8wfZuSpJLxs4vWprkMlJhSKHCHx36ilMKEtTOHetwKPNLkZe50OwC4O+i
 jp1KfhSOibx4fX6bFQVwuqXEtY/qmueAi0/sx4IIT6zl6OeQJpA8QB+BI3ywifaRRz2s
 mErA==
X-Gm-Message-State: AOAM530IIBIrBsSK3Q/AehQTmPFMUuOtyWuU42STBzTzpGFcfgz6i7Op
 QrtOMjO29x3vWyiiuvU4mvzOCw==
X-Google-Smtp-Source: ABdhPJxH9fkoQGdpf2yTn0S6RVjDGgTIT95lILem9Ftm+wTQRagGEoMXbOUbGd2ZD+OyyhreIN7wUA==
X-Received: by 2002:a17:902:b285:b029:de:a0a3:f3b9 with SMTP id
 u5-20020a170902b285b02900dea0a3f3b9mr336676plr.34.1611550412389; 
 Sun, 24 Jan 2021 20:53:32 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 68sm14877443pfe.33.2021.01.24.20.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:53:31 -0800 (PST)
Subject: Re: [PATCH V3 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <50c4cdb5-b5ea-5431-c319-a6784f33f8b6@kernel.dk>
Date: Sun, 24 Jan 2021 21:53:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210124_235334_625560_9460D618 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/24/21 9:49 PM, Guoqing Jiang wrote:
> V3 changes:
> 1. rebase with for-5.12/block branch.
> 2. add Ulf's Acked-by.
> 
> V2 changes:
> 1. update commit header per Christoph's comment.
> 
> Hi Jens,
> 
> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
> Also update the comment for blk_execute_rq_nowait.
> 

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
