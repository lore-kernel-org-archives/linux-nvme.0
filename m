Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3D5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0tUfEDwLEgAWdQcAg7deP60ErmXaKGy36F0aaX7os4=; b=iq/0p5YiZPcm4W9g73BcD4ZhuK
	sMbBZ3J5ItsqDyqoUPURVi7axU7iUWqAtpq3dWHNBfdawxujH0uSHtkTtsd3ciHRFSydC8jR3HEOy
	M5xYZxCtMkQSYbBM3qwT0MQva3x8O/tCxoJEp9RjAuPKJFdTLBCVinEeOXzPu+z7nIxErHDMuGn5j
	kd3q3ACyYlOpNobQSwruXaYPpsMnwft7bq1kiw6Kbs++x7a7k/bAQ36xbYclEfNA30Zd5B7e7yx34
	kljzTiYeMz/uKKmUJA3nuhfO6GrqrQsJUKdRgbBLMvh0XgWyL4lzWw2ZL4sWlfwxKXlenUWOpG/2Y
	H/elfq2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtxd-006jsA-JU; Thu, 16 Dec 2021 16:50:29 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtkg-006evv-6p
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:37:08 +0000
Received: by mail-il1-x12d.google.com with SMTP id k14so845453ils.12
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b0tUfEDwLEgAWdQcAg7deP60ErmXaKGy36F0aaX7os4=;
 b=sYYHxKlbf6fMXEPtKdwtAP8PvSg0n65C7qAV9GhxaTpBSHq1fKhlBEU0AUsIUxmAWn
 0PyvuNQXWIs1IY8F4zicDKFi8bM1/PLBF8xgM0pt7xWSepfu4b485pv4ojs9PM0Z1J4R
 AYxU2/t7W1l5L+ATJckl2z/kT8cdu1XBMEyMkGe8hZqATMiuOJx1yOEfRxFG3FXsx8Zm
 wM4etQoT1IP95ZaN+TFI7niLnvl2vFNvDVnjtoFqL6wUobGIFByMV+j+u90xwv0hLvwt
 k9NCR3hKnV0mIK503ljPtpdnv2chxJYceymi9bNQIM5isBI0HZoRKuEbcuRbDljzFwpZ
 tV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b0tUfEDwLEgAWdQcAg7deP60ErmXaKGy36F0aaX7os4=;
 b=lv+Yv771vd2YKy9c+xNtmLfdluEhJwhpqyvofFI2YayvKMoR1T+y4KXNkRwrBxniUt
 bcNfgy6iAiINJ+4Wtwq1ttU81Ljyh1/QTQhJOu6pq+d3QgiXQ9/kd07i2AfgdIgyP/4O
 r1dGIsRhe7fhbrFyT9d36eYAlYUatlbEeXtEBT7m3S7X4x5zS6LqMo7YMMJhMSfQoQe5
 0aLsBr/CrnBWD1h3tN/WkyNkJf01ZX0u0Mh+hys1kGfwRWyrOuWhFGaqrHH8ahkEAV9P
 nIOSgNPMt4tG0+VGcxqP9prVeNLRDEfzUP0Qbuz+5UOxi3jgvz9HhgdbRG7+rKYJvEdL
 eYRQ==
X-Gm-Message-State: AOAM530HSck6PduL+8TaOGv99H0fHIlkBK3pCrOkumPHedvW5XcEqP8v
 4T+Qwf0SrGHujjtgYRCFVrQMXw==
X-Google-Smtp-Source: ABdhPJzpmskZuLx90OXi7btpLqIEuoDT98iBxa7blsO/MV1NWiFmJSYpMKaVFg4uIKJLqjIT2A3hCw==
X-Received: by 2002:a92:d849:: with SMTP id h9mr4050363ilq.181.1639672619988; 
 Thu, 16 Dec 2021 08:36:59 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id s3sm2934794ilv.69.2021.12.16.08.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 08:36:59 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Christoph Hellwig <hch@infradead.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk> <YbsB/W/1Uwok4i0u@infradead.org>
 <83aa4715-7bf8-4ed1-6945-3910cb13f233@kernel.dk>
 <YbtmPjisO5RIAnby@infradead.org>
 <db771bc2-4d7a-ee1c-aff7-f8e37dc964d5@kernel.dk>
 <YbtpwAP5HJSKAjh8@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9d54331d-d0d8-4164-918e-96e17dd99d89@kernel.dk>
Date: Thu, 16 Dec 2021 09:36:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbtpwAP5HJSKAjh8@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_083706_287949_6013CC73 
X-CRM114-Status: GOOD (  12.03  )
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

On 12/16/21 9:30 AM, Christoph Hellwig wrote:
> On Thu, Dec 16, 2021 at 09:27:18AM -0700, Jens Axboe wrote:
>> OK, I misunderstood which one you referred to then. So this incremental,
> 
> Yes, that's the preferred version.

Respun it, will send out an updated one.

-- 
Jens Axboe


