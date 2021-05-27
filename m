Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECC0C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 13:49:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A975613BC
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 13:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A975613BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4gibLWAhd2pcuwNPI1PQuTCMmkxE05v6AAIQ8chzwzc=; b=E41Ra7BJwfoiltI7dpPLndESSk
	CSW86VtDoJamvUREOPUOtUsdtAbvp+MDxuGtJkhXO88Mzrh9V95/hxUC7bC2s2bp4Gho8dFmQSqf6
	1ILb2uyLjfKoB6Ip2i/TU0Ffx/ELRK2JiijLfsha655mXl4g442bards6AQNd84HxbmTDy2PQYwbB
	ApZOllANQ2Ej9700cSx79OP9LwCLmgLH6QCcI5W/0BBgcikR11DpAs2y21KBTFIklBuNfnPD/YSma
	b4gX97xKpGjsMiW5id0UVCxByTWo5WQWXAyd/Piur/qTsSXFPDd7hTC8t4lA2vOVXyZk8+rK9Q/TL
	ZUvCm3BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmGOA-006QYa-2u; Thu, 27 May 2021 13:49:30 +0000
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmGDm-006LaA-KQ
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 13:38:49 +0000
Received: by mail-oo1-xc33.google.com with SMTP id
 o66-20020a4a44450000b029020d44dea886so116404ooa.5
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4eHU56OavFWesCLDdAv7Vdf5HO31M1iMmqu3fhWgUAk=;
 b=eqo68ERsC2eAQcqwxYhWPsRrMzGg3aydusljL3RA08ZrnIdWwgndYDNxI811wMrB9h
 oC1PdNcYGx/D4qy0RmH519bA5vNW1zaWgJSLLYKEDgGuqKZ2503csGufug0gt+L2RXmk
 z2O0Gyp/7YIknfhmxnGshr/sMyGJcvK3lxCiyUw1phiB4nMNrDJ3SpZWrE5C2SdpTKZX
 vs5n0REbGxnGotyMFtTS7IcJ7jXZ4iACYhcQRzxAdIGwlG54EH0I/MRyjSoJZgIi4JFo
 bdLSMG8k1bGEYexUgjGOsql9IvgH1EgF9+3g4FUcr0l54kGKs10ODa6eeaFoHKU1bzGL
 UVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4eHU56OavFWesCLDdAv7Vdf5HO31M1iMmqu3fhWgUAk=;
 b=GcqyeaaK2O+s/6JlDkJ5Gsket6NY9spCNzxMQY29wCEz8MHG0Qf1CZmCjnN+tonU+I
 2I3mCSUfp7UE51QTEUKRJ9Sb3FKWHbFLYdP1nF5r4lgsj8/5J9yjygeIY4+hyQ8MxDL1
 YWwDI9bIzCuU0i3vMaqhNi1CPrl8GBfjkJWuQPN2aJgWZtco3jtTwkpfdb6ImLbfE8mD
 9vfSL11kHgSuIKL+LufJJxbZCu8E/KMNDX/3jGFk7mUNdTvr4+7hfSJmFBzofIxAvWWt
 eKCkxl4C4wDf9+ZStciZSS14t08PuA35PdhCV/ZbE+av9LcLf/XsTN1qCsLmbyiSC7ME
 an3Q==
X-Gm-Message-State: AOAM532O0ZE0qrXbZ9UDz1c2QrZfeIh8FT91HD23mACUpBkTyEnTd7JQ
 dDH9Bk4LEXtet15a6VUlfMuUoY7w8d9jWg==
X-Google-Smtp-Source: ABdhPJy8c7dZ7F012TVZTqv6U/eX6J1o7e+ZSdOPhqpFyLu6FzrJ4As1ekPlFgGBFeOD+IF9e6iIaQ==
X-Received: by 2002:a4a:97ab:: with SMTP id w40mr828880ooi.19.1622122723881;
 Thu, 27 May 2021 06:38:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
 by smtp.gmail.com with ESMTPSA id x11sm477677otr.36.2021.05.27.06.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 06:38:42 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YK+JXQOdbaoUH4Zr@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <95f7e606-fdc2-4668-af69-a68d85e82144@kernel.dk>
Date: Thu, 27 May 2021 07:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YK+JXQOdbaoUH4Zr@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_063846_706189_A5134E24 
X-CRM114-Status: GOOD (  11.71  )
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

On 5/27/21 5:58 AM, Christoph Hellwig wrote:
> The following changes since commit bc6a385132601c29a6da1dbf8148c0d3c9ad36dc:
> 
>   block: fix a race between del_gendisk and BLKRRPART (2021-05-20 07:59:35 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-27

Thanks, pulled.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
