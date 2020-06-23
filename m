Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B3C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:26:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0B4206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pStq+IAc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S3lvTwR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0B4206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wF8joglRA1beYKVVIe8ruB1B6SE4Nr0WUODMOKE+k5U=; b=pStq+IAcpuxwChCZfr7E/6xyD
	Lpbh1RTKA2vuyk9JUSQjZGl3XanEy8Q/uK/t8NFyXEbSAeSeS7wRlTxvHpYemVpzlHve3eF61g8ry
	eotsQJEBPrrVBLV4Pdc7bIeKuDJTfTm+GAjBYvd7/cwll8XPWCY5lnNneBr55ZUT0rf64wOQxMrZA
	YbRetlWmt7BeV/dJw5Uwk0x2XG8p8/BvoYyuYjKB2oxRt9EQywGaLQH6dtofscBKG5dhO+hHoUD7f
	chLzmKEmF89iGZlcRUXkFDbWuofwSUMw8LV7SdO6CpGCJPSWPnuacGq0ZnaQL9fxOECgAJpvlG2ax
	sGOWlpQHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnlke-0000kB-To; Tue, 23 Jun 2020 16:26:24 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnlka-0000if-KX
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 16:26:21 +0000
Received: by mail-io1-xd41.google.com with SMTP id c4so10796728iot.4
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g6NzstVKPfTZPMLr5Nh9ERsh+jOwQe6rYIYlydmCSZ4=;
 b=S3lvTwR2imSCx2pre4xFBO/hJjiXX5/Gtiu+zmMxfeJMmFwt5ApZQnnip8sOw7cHxa
 b0+nuJF5s9xODSEl6V/y8/lO0nqaf7cj4eC5bMDTzK7S8+TZRxsovXpj0nd2trY54PTB
 MQbkjl79KUzHpmDyTM+7WkJ2p7kDDyiFktQXvtda9PXurRvMLAKtPqAfxw/gKltISIu/
 WIHiI0Zb5xuhMh6gcfpZFpanXGypx43OR7iy/3Tm9TkMqCG9YOiCKFp95vAQOoenhf5i
 CsKvITSw2sD6EJrrc4r83zoPtJMfHwF8/URAJKbEvY1J1bs3Pw6DT9+ph9segCvwudP/
 MRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g6NzstVKPfTZPMLr5Nh9ERsh+jOwQe6rYIYlydmCSZ4=;
 b=W8HfNkO8EfqXGFuAtDHIjpHOY/AFORxhQM7iDAD6qybB//ocPGFeJCJTvK4Og0F3U6
 xKV9eUKH5v0cAAGoLbsEMNbJwVrwwVmi7xoiAvumIHy3nBbceAE9mnddCdOPeDB5Giho
 rGc4mBG+wyYO0zfo9R5OASY2lxBDEDI1DnOvE7DYervmC9DW+AsgjqJ8jmmEmL55NuHb
 FkASynxVT8YohzO/rlekANkOfB9GU5fusSytbUvAr+o2mVGpLXjXLYLDVNRpkSo08EnC
 v/Xb0dSAPM7jRxGoXcws7p3ecUnKdaqAJYY3pIBr07nVZdoetsukyLySKGdxAnOURtjm
 L81A==
X-Gm-Message-State: AOAM531jFyCNXZ71/F7/EaFMkqTZmL/MzlL5XzpQF5PYjjJ8MHHEHDqJ
 LGy4PglFG4njnsGxtLUvmdISpkBqbq4=
X-Google-Smtp-Source: ABdhPJw+OsjFMxkCO2Ii6O+SgfMP1ZHTmpZszoHBozPtsb+wsAAgYcebmEvGu8Ino7YOgCuz/aA8zw==
X-Received: by 2002:a02:896:: with SMTP id 144mr25777843jac.126.1592929576669; 
 Tue, 23 Jun 2020 09:26:16 -0700 (PDT)
Received: from [192.168.1.56] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id 13sm9754400ilg.24.2020.06.23.09.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 09:26:16 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix a missing completion with remove
 invalidation
To: Christoph Hellwig <hch@lst.de>
References: <20200623162239.950789-1-hch@lst.de>
 <20200623162239.950789-2-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b3165c3e-0964-6ea4-b64e-b6c124d3e80a@kernel.dk>
Date: Tue, 23 Jun 2020 10:26:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623162239.950789-2-hch@lst.de>
Content-Language: en-US
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
Cc: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/23/20 10:22 AM, Christoph Hellwig wrote:
> Revert and incorret transformation that caused requests using remote
> invalidation to never complete.

Applied to for-5.9/block, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
