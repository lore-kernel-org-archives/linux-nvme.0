Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F90DC63697
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 16:24:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B67422261
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 16:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e1hH/AEy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yfkLbsgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B67422261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KufrTWwWRSk7h65qYLYcRyB7D+5hqWIvYhk/SPUJWmc=; b=e1hH/AEyj4EvyoEU7JRTWPZJ1
	OTis2N5zXn+MuWlt7qtzsAFCCNwgcvIWQeytRwFgxVB6RHk0s0xYl8crmW8vo5nY6ttK9mtxd6MOc
	aPTv0MPNeSX/d5Y3CaptDLb7ign0bPeKaHHccQJ+C3REkbr2HAnAW4Z42Hz+AdhZySdAQdiMnwi6e
	CFvXGpp0oRyY5nN04gNxCrg3T2SzGzSngXoxNgHXN7vH9aSibFuR2CXxbWBhaqQs1hG6eVHdg/lko
	8jqsNk3VWwbq18igFE/dya7g7sssrM4BJYcLuKNawT0/2tldSicieZzBnPNg9xUTSIqd23W3VIire
	dZb0Md8eA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfmiz-0003us-HT; Thu, 19 Nov 2020 16:23:57 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfmiv-0003u5-N1
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 16:23:55 +0000
Received: by mail-io1-xd32.google.com with SMTP id j23so6693680iog.6
 for <linux-nvme@lists.infradead.org>; Thu, 19 Nov 2020 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SdfnZnZFCAVfsVFw2Gcaj97k5GE/KTLAJnWlDhpg+mc=;
 b=yfkLbsgH+auAQyTeo0NtHJm8/xRBiRHIz3loRAsb1FNG0Ra00wPu60HC1uupu7R5k0
 O0L3SMGWlW0iFoQNsAzzz17cCbDtET/I/DyPs88Q9kbAZnUQfXEwNCWCwTEQyJizM/bl
 L/RTLnUJw/qax5laikNXHNKshnNIfcR5GT7VfY/sjpMHShXSasq3SqeUJqmiHuo6qfor
 6PEk5Vsbsc9+ugnxVAEjGeaBg87mvL9cO1V/ItF/E5z4LfjVxbvdZEJUuyLRrt65URUN
 L/1yx/LFY7fGNVPGYhGProEyfomYVJ+vDGJaa8qxKY7WTrmHJUYzu2mxvba4OCz7fLeK
 ejAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdfnZnZFCAVfsVFw2Gcaj97k5GE/KTLAJnWlDhpg+mc=;
 b=mpD+RD7u1Z23OL9/BRxucutdc66PvobsBrLSiO41qW/FqYgWx8+Zb49jqWq5p7EOaC
 5X1a/4au7Zf+N4bzzpaK8JjdNrGITgRy8ppbD8j+trbFRmWRWwkFutx3HM/SE6WKSPL1
 J23pTSwTCmJnkNKpqlN+H78qe0eEueIjWk/S7Eu/euyil7LsQ4MkRI6Em/I6U6qMvnuS
 myQCdRGTthuNvHrPtPxHVmQLt4M4R48ZNMIvg9TAzPPf1PNOou+JNT8MzYIkUKyq/2hy
 7kXUKH9WP5HrMT8yVDe2ANUWi79lU4PlJyj12EMNbXPpb+NxG3yNWpk9MpgpmRqDtzZz
 LQaA==
X-Gm-Message-State: AOAM5331u61sC9Tirh4WswE6WjTu2n0M4scrZ+Tg0k6+z9pDEjq+At4b
 +bcRjA3feCjc3aHypRS6S6TrPiaUsxibWg==
X-Google-Smtp-Source: ABdhPJwacRNE46/FcGIrducjj2/Ja7LpFzT4psmd2m9exf2iyrVD2fmBKlrS5BD4kiuzaYJE4smlgw==
X-Received: by 2002:a02:cb99:: with SMTP id u25mr14879852jap.73.1605803031610; 
 Thu, 19 Nov 2020 08:23:51 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id a13sm164092ilh.0.2020.11.19.08.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2020 08:23:50 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20201119075057.GA2465128@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ebd1fa99-a32b-cb98-cbd4-ddc5c5b067ba@kernel.dk>
Date: Thu, 19 Nov 2020 09:23:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119075057.GA2465128@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_112353_806535_119EF258 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/19/20 12:50 AM, Christoph Hellwig wrote:
> The following changes since commit 9f16a66733c90b5f33f624b0b0e36a345b0aaf93:
> 
>   block: mark flush request as IDLE when it is really finished (2020-11-13 14:24:16 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-19

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
