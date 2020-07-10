Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8FFC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7802082E
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ADoHShW9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qHhvmYUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7802082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hi8ZBjC3vp2JarJqIAuSVmmy3t9OsyevCXeN3dJe4Ow=; b=ADoHShW9PXbS24ULqEHC/FL3E
	u4KDTqAfWV+HzceLk+ZZd9ArLHQZnmiYdBr1EPyWhKitU7M9rBLXhOtE6fhuS/+JCVbBoxNHpewyh
	GD5yGs1YAg8r4mg/Ukhy1lYKkCi9dKPh4G7b/oHFXFRuwRo374ftBxHC7RCEIJPo6nFSsRTSDR1wS
	w5PBYV7Seo1DUJFknspp3ZjYPvLXmzegqZmzuw9XJk+L9z78FZHcpiiRyeKao4cbTHGJ3AbwnIVWf
	+Uz2WhsQ8j6MaqoeJC9AbIYJrLqqAwJIKoE38kOPBHTHkEzU4XtOHyPZtysLLPbT5tJt4M9n7xVzm
	5CrDX6t+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jttbc-0004yc-Gr; Fri, 10 Jul 2020 14:02:24 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jttbW-0004uY-FZ
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 14:02:21 +0000
Received: by mail-il1-x12e.google.com with SMTP id a6so5103925ilq.13
 for <linux-nvme@lists.infradead.org>; Fri, 10 Jul 2020 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=feSplbdpMN3GL73AIVEFNJv5/fgFSu0hAgIYhS6v32Q=;
 b=qHhvmYUqJQM477rO/uq9GuC/S6vQrrzy6XK8a73LAmgRPIL2w0x+N4M7SawSrMLj4l
 5MdUuruSqxG3HAF4ayP13MkBqojz6gUgqbbK+fpcczM/Bii3qZdyVztQvqIZXQnFrTkP
 fTRHtxWgTtjMFP5seQU7T97BCMjYT75IOm52If4Hz34GCs88vnqrKo+/651sdVsgyP8l
 QGpKfakdfkEB/E7al4li1UReHxEDylfAT7ynW04GZvDhs5d/7ahZdIroybT4fNI1tW9Z
 fJQoR+9SyRqIfvTGX3TOWQQxnpG0V419sbU7NcUs2b8WC5KRaLCnQsYKcKqgYttFTwrR
 +lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=feSplbdpMN3GL73AIVEFNJv5/fgFSu0hAgIYhS6v32Q=;
 b=V4er3O/plNf++RHdC39ap2tgxPRebNr23pSDaYYMxRgHP/mMwiReJAAj1Q/O4CKabb
 2baN7kGo86yzYz+9Pajd+iFUn4dZAJYY8gMtiurXkOl55bvLSMSEnIvBkTgEEeJbMqhQ
 t0cbyOnyDJEOLXnl8NkgD9IQ880CfvfAS9/ihjqGLIsZ1rcMySJLQx+WQdGX6TWMOjWs
 pr0DSs6xc2ON1vpyIk0x9cpkr63+2ZFNLfxQrJOWJE+erIbNwv9fXBFdbjqIHPhstBMw
 mQupe6Y5yuLa+I6H4iNAR4EzdfT0wsWDjSxZ0Lpwqi7Z6MEtfRkDSACGtE5a9uvh2HEb
 L+zQ==
X-Gm-Message-State: AOAM531j3ym0RrCHoD57wjagm7owDJRh6dljsssDEAVLhCrXdasXrGbQ
 mL70TLheJfiyi6bEPrI1R6t/NNFGL2ICQw==
X-Google-Smtp-Source: ABdhPJyEG+rPLTvIhTU4mi92nYP+7MDu609t4g1jTerr2y82OCJ0b777KUBjLgTuN4pkX3yCOR0VIA==
X-Received: by 2002:a92:bb55:: with SMTP id w82mr53553900ili.146.1594389736045; 
 Fri, 10 Jul 2020 07:02:16 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id x1sm3430633ilh.29.2020.07.10.07.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 07:02:15 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for 5.9
To: Christoph Hellwig <hch@infradead.org>
References: <20200710134826.GA537445@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b7f32ad5-c3e0-61a6-18c1-b37ad81f90e5@kernel.dk>
Date: Fri, 10 Jul 2020 08:02:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710134826.GA537445@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_100218_592333_A2CA9756 
X-CRM114-Status: GOOD (  12.22  )
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

On 7/10/20 7:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is the current large chunk we have in the nvme tree for 5.9:
> 
>  - ZNS support (Aravind, Keith, Matias, Niklas)
>  - misc cleanups and optimizations
>    (Baolin, Chaitanya, David, Dongli, Max, Sagi)

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
