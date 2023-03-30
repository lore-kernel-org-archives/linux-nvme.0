Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219C4C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8dYMW3XWv0alb9FRUxiLkOt8cztHbN++4YPbl+UQLk=; b=N81z/CWnkNnitvTdMmHX0Q52AI
	qXg+Mim71PPreY2wU/VjzQZ0AOe4rs9lmpSZHAfi+7zpDLcO265fsD+9PO2jwCmgoCpxx2GcYfXCX
	aafmFCIGBbE2XIiFOEc77sB7M4wR3eFHXz5jMdG3dekBTppcqVrHoVOfS60P1D9GXf63sOXy00/Mb
	iuY/LVXfVlAth4lWqiu88hUknBvfa+kP1T8sBfiBgNk04xnZmaCRASXtc7Y6cvN1No7JKvc7F4P5q
	bdkE8qslAeMQ65Zw0O4PefvgBV9HNEstyC6HIF4ucCVbACpguJdpNoTmQtW44jsG20PCKB+BzyUM8
	ru54qYQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi0vk-005Evl-1G;
	Thu, 30 Mar 2023 22:39:40 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi0vh-005Eub-3B
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 22:39:39 +0000
Received: by mail-pl1-x62a.google.com with SMTP id c18so19519649ple.11
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680215976; x=1682807976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8dYMW3XWv0alb9FRUxiLkOt8cztHbN++4YPbl+UQLk=;
        b=woe0VTMiVuN+D8JQTUNxpCp06PCu7tydCq/A2/BAealAPGvqXoUebB1wrIiVMG8Q8t
         roQWdn8HpWOT9aALGRE63bbh4U2imFhF32zYoWniXgX/2jOHmX3y7KFL6+sdyWOBO/I/
         3PE/AdIkveFcimQXkEEUKNVaOybMYLX6aoDHqIBTqdTzwQWJHFYGM/IfC8NWsJj22pDJ
         Q7d/h9S5hg311NwV+2REe66gVtUHDtgvVrITzyZ1mz5tFyI4Pvo7tX43eihyc595V0rK
         dcS7sRKtH/1KXBjigHfri3wXKlRbQ5kxPwaone4tAdwMuZb8N8C3PG5ES5bjifCPQ2Jv
         onjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215976; x=1682807976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8dYMW3XWv0alb9FRUxiLkOt8cztHbN++4YPbl+UQLk=;
        b=JW2ULGuv28d5RRPeFJZHT+mWQfl/gin7psSoPTsSiCnq680U+VA2/ezTBoTzk1QiX7
         YS3BZldO1nMNg+8EqoedheRARKJwJIGrWM/T+90ywc8AjU7A7rMNTnYMfpFam9b+2K6A
         nrKTJ+3xKcL6I9vqtuI6BU5nS+7inPoWz/cNAmN2kaKNkP/JlBdX6BiXK4uToQpQCZb/
         OtbHAroZYVirNi0B9DaZMDo/vhBmdEEWKxtr8TgsUbdFW07oKQZWrlpq81n+5ju8snqE
         aZ/imNtT2ARVtKOLDPKn9SsraCWrurNgMvCc0FTnJdyzqFPOXlI/T2IsFi6Vuw1Io4fH
         oA4w==
X-Gm-Message-State: AAQBX9fNGtRrdMFlVXzcCxv/GwyTDp8EnsFTzozAqv26ct5irH77JkAd
	TWtnN4e+ayAayTv1/sNfwEMnAw==
X-Google-Smtp-Source: AKy350ZNS27Vy05v8IUzf4GKM10aPcsU/6w163pYstgpBDr3hqeZowRVl09Mi8cbV/q1tgBpMk016g==
X-Received: by 2002:a17:90a:ba04:b0:240:cf04:c997 with SMTP id s4-20020a17090aba0400b00240cf04c997mr2537630pjr.2.1680215975566;
        Thu, 30 Mar 2023 15:39:35 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ez16-20020a17090ae15000b002310ed024adsm3712198pjb.12.2023.03.30.15.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 15:39:35 -0700 (PDT)
Message-ID: <47d34a9c-bad7-cb6f-bcbb-48391734721c@kernel.dk>
Date: Thu, 30 Mar 2023 16:39:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <ZCYPEl0cfKtOlkU8@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZCYPEl0cfKtOlkU8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_153938_020508_A9397A14 
X-CRM114-Status: GOOD (  12.39  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/30/23 4:37 PM, Christoph Hellwig wrote:
> The following changes since commit bb430b69422640891b0b8db762885730579a4145:
> 
>   loop: LOOP_CONFIGURE: send uevents for partitions (2023-03-27 13:27:06 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-31
> 
> for you to fetch changes up to 88eaba80328b31ef81813a1207b4056efd7006a6:
> 
>   nvme-tcp: fix a possible UAF when failing to allocate an io queue (2023-03-30 11:24:33 +0900)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - mark Lexar NM760 as IGNORE_DEV_SUBNQN (Juraj Pecigos)
>  - fix a possible UAF when failing to allocate an TCP io queue
>    (Sagi Grimberg)

Pulled, thanks.

-- 
Jens Axboe



