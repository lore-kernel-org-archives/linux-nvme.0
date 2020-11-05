Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A50C4741F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 14:11:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5811E206DB
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 14:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y7ZsKO+r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZR+QuP+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5811E206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SCXLkefKwW1povigjIujS6IC392DT7cNlvGb1yckDCY=; b=Y7ZsKO+rkszL9kTVW2GZfqEsG
	HAnY6iPWCOxIG/QIKYzsiHzL3BlgtLOdmVCoMCyDvVoJ9KOtBkFqLGVj3S7WBStr82MAGC83HAuii
	bKFeb78LtiBXdVqgBgBPB0KSmAEIYmtGCLSzQSk4kq1Jh9yVcOGittfacv6PXwwohqNxmAXayH/k7
	nB5iSCtWbk+9ytio9E+zEATd+n+3MUfglp/sgWKbv3oYQdjn25/hMfkOmG65LG8bjplExjCpCY9Ou
	ZR2xzg8UR4rOyV2L4E601gPyo/qjqboo5VuJIJwHck93N/ZP1RkCRZqVBerKCybVhr+Sh4+KEcc14
	k3cFQYT+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kafzB-0008US-3k; Thu, 05 Nov 2020 14:11:33 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kafz9-0008SG-1w
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 14:11:32 +0000
Received: by mail-il1-x130.google.com with SMTP id g15so1477934ilc.9
 for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2020 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6EAeut+BnNwdiVFa/Nqg0Qb0vB29gbQLvEOprNqRU54=;
 b=ZR+QuP+BTgpJ9EU7FmG/1siLp/UgI1vBeH+m2DidlPr8jvkptmTG+yiAJLK9V6p00R
 8aw37g8E4MPLAmLkol5B0j0b/HrVgPuEFfBTMBHVAd+f4L9Q9J4IaMilIM0Qc6bU8WVq
 khEsayOsfebf8kfjAcpEC3dez0CiIgQFiPoxkFU44SjlU950OoTGwbgpPYxGVT8t2ScK
 F8TYnlgXZP0+VNnc/N8qJ5REXkW2anvtzOrO4n6TIDGtbU6aVW3hWhilnWq06x69XDAA
 vX7vYmvrTXSNl4md3NtoQ7nMhXufAgi7+YW4yLynjJKKa+E9IETvLvQFkdCan8p2XqiJ
 0g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6EAeut+BnNwdiVFa/Nqg0Qb0vB29gbQLvEOprNqRU54=;
 b=D2VLYLFNkrvO2psZ7wmKCeP1w9BKpomdMObhFiRDUguKlSdl7YjQ8EH4vWY3Q02kWp
 pIezZEQpDxFThbmuIGYREsM2x1CJt4GA28fICbe3rEnUSR8sPh1eahGHyvwl7xrywjnZ
 0JGlvfdyJKy3AIiD7V5w0Ty7BB+b0KFQqZcHcmXQAefkHNP0YtyoXhPA1nh2Vwr0SOw6
 9MhAUxzPorDuWFiv+n3AX8Nc6KJSj1sxJRWNeqLdU31lxS/ukuIrPxvmdPqD1UVi/OIl
 YmfalwdBLvbrrTk0CadOBZpg9cNBpE53JvYvR2+8JYOqdDjgsnDOEP5LPhdbTh6XIRpM
 q5Pw==
X-Gm-Message-State: AOAM530PzD72PsoXMTbmKydm/YR6hsgveJ/PNJalqZnBYRzBYAlD1UXu
 BBKFpG/bP6Ap3Y9SqOW4X9D9N14KPWaKcg==
X-Google-Smtp-Source: ABdhPJwy55OanQ8jU65gd3iWT47QaTuHOvloyGDZvNDYL0EruvHmw3hOf5K45yJHytd/LOMJ7S0vRQ==
X-Received: by 2002:a05:6e02:14ca:: with SMTP id
 o10mr1837408ilk.143.1604585486500; 
 Thu, 05 Nov 2020 06:11:26 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id 9sm1342134ila.61.2020.11.05.06.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:11:25 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20201105075604.GA1690984@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f0295c3b-dda6-01c9-cdd2-3f1ecf9facb6@kernel.dk>
Date: Thu, 5 Nov 2020 07:11:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105075604.GA1690984@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_091131_207366_E8FDBBD4 
X-CRM114-Status: GOOD (  13.28  )
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

On 11/5/20 12:56 AM, Christoph Hellwig wrote:
> The following changes since commit 65ff5cd04551daf2c11c7928e48fc3483391c900:
> 
>   blk-mq: mark flush request as IDLE in flush_end_io() (2020-10-30 08:33:49 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-05

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
