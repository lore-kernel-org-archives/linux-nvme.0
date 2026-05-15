Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16EDCD4F25
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xhVH3ht46gpTJlM/Z5kdx1ELiM9H7nJuHx53pISITc=; b=qJogLSTUsmkiZN47yE9bmjWKM2
	MjV2jPkL3nYuT7Mr7FCCc3cuuuTnPPq0r3SA7Pj0JobLdmd9nv5VKBzzi7oyNTp2p6yaq+2fNrIMm
	/8HKxod+Z0UShx/WAs1HZk0opCM6uyAvu/2y8E1On8V2srMQbIiP9ZZf9YQpj1T187w8nbGHkbXin
	HAeJZy58zt4GeinHtcamnAeIxfxVcwgtS3jHGig3ypfHr1Ag4UR5k5TbhuXclPHMXnPX4J1E/sog6
	b+GJ8affaMl7PuIkgj6c3ee5VhIInXJF3MA+pK+rFMhAkM9mjZIKzTFK+DBlCNR7uK4100TXG+ofk
	KOEtDOxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNh9c-00000006zDG-0vxC;
	Fri, 15 May 2026 01:15:52 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNh9Y-00000006zCb-3SvO
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 01:15:50 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7dca4debedaso8196120a34.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 18:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778807743; x=1779412543; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xhVH3ht46gpTJlM/Z5kdx1ELiM9H7nJuHx53pISITc=;
        b=dP3Zbz+J9RhbqRoh83Udl7Efi7WkPT8RImBlCDLGWSzRLNsxT8dY6GHaqy6qohsGCh
         gajmYgSYT3NVj717XIvuUDeW+knK+o76aVo4tMENKJUL4gzrSUFgK3UdZpC1cdzzU4Lt
         z4CCHBsGK+tK3nSg+Bva7GX0YG8ddGCTRrCVqqEhYDBKcfKeGGCvvO3h7DFUD4/fYVJ6
         3ezKa1f+xzkax4xE/0pJQFbFWsMt0O4EGrLQavz5BSVwVNUG5Wdou2K+q8jyXFHgaJhI
         /gFF8gJx68kWq5KV9Goeo2ZHQqVJEOQn5tkhZMUIeYgejLfdxU1S3EsEKOwdY/yKXU4l
         uDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778807743; x=1779412543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xhVH3ht46gpTJlM/Z5kdx1ELiM9H7nJuHx53pISITc=;
        b=Bfw8uZYxHr63mz/q+gUPxkq2QZyDrhxdip3CEY5GBM4RLiISOd1QY1OLyB+6QMGBbh
         +vmxXjYYwFD5jvh9ERUvv4G1KUDC2kWwuEmafJLZh6mHU/W1S8ZuO3r7NPMMUUNq6bEv
         R5r+xjijMqG5UxxDKwjofeoXRRVa/aNaU2FIZapDa9BRC+99hCWGOQOZC1TKbEPUPsJq
         kZH/97aIn2Z8oBSakMaKy+c+wuBI8qExKPawu1V3P5lZA+luvrPk5l3MPWTsR+KXhGoQ
         R375gTOdWYTdce1RUuQ1fBQZelS/cWRou3Ji38X7WZXTxM7tPDfA60dlfkaSuwbvo9m5
         N2BA==
X-Forwarded-Encrypted: i=1; AFNElJ/vwm4wD+weu+z6ccIILCJET5MS5Rx+/GdoXkC9BQdy6z1pC06lHDj2+h/DMNWvMVCk6OV7auckuypu@lists.infradead.org
X-Gm-Message-State: AOJu0YzI4PoeKo3xRMGot/oQsYzrlk06hgj3Gnq8FHAB9+bH2dRJ/U4u
	RdMnltu4fxJJAvpI8arPD4yqMvssm49nynyjyWNPU8lv/hmcVUFiDowG4dS/+TJZ66A=
X-Gm-Gg: Acq92OHeiOkSPjWTRHw9VdGNwoeZXOSnX1HmybrCMZAhkIQMg4soS+vaQ5Ohmw48l1p
	QnHezb+eg+E9dD8oTWvP0WCKR2hvMT1vfWZi0HeruO8bfcF7Tr9GURML2C762NpJT421FsvboYl
	HwEKGafAdc2bGxs6x3C2cVfER2MQMYW0QP2Okno/C3ASJICVODQpmDIj+qWZSBR51UbBSOaaOHB
	mFbVspG8cmE9oIhI1w+N4+JlAaKQCcMiFFWu+T2EUX50nSuUUT3cvuvK85AZgSpNYCV+6ejkYo1
	nHBEfvbQAU26OjhzPtdxEHZzy0hbwbLmUMeHiVokxI5OyGuMPXh0ONN80hUQLQpOByDnuKgRAzi
	qk5u7n4RKyjrSp0FNXNTGmxdFxxpvVC5pT9J8GyL3Aj6rIKSAGqCQCCjnRLstZGmgpgnu2NHn+t
	PBkZiAr6r6AZA8vGBcMVbFpW5ymuTdSYeepMhjowz7TjOPx5EVMkcD5GZdPfqOlPQ3R4NQ8Vx8L
	P33Le4UVNrWMkapU9Du
X-Received: by 2002:a05:6830:34a2:b0:7dc:e53a:638 with SMTP id 46e09a7af769-7e4f2a36b52mr1204473a34.8.1778807743182;
        Thu, 14 May 2026 18:15:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc14929sm128978a34.22.2026.05.14.18.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 18:15:42 -0700 (PDT)
Message-ID: <a8d7d754-aa70-4ef1-9eb0-b62dc4cec07d@kernel.dk>
Date: Thu, 14 May 2026 19:15:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.1
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <agYuOOFSTynR-wPG@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <agYuOOFSTynR-wPG@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_181549_121951_006A4244 
X-CRM114-Status: UNSURE (   7.49  )
X-CRM114-Notice: Please train this message.
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

On 5/14/26 2:19 PM, Keith Busch wrote:
> ----------------------------------------------------------------
> nvme fixes for Linux 7.1
> 
>  - Fix memory leak on a passthrough integrity mapping failure (Keith)
>  - Hide secrets behind debug option (Hannes)
>  - Fix pci use-after-free for host memory buffer (Chia-Lin Kao)
>  - Fix tcp taregt use-after-free for data digest  (Sagi)
>  - Revert a mistaken quirk (Alan Cui)
>  - Fix uevent and controller state race condition (Maurizio)
>  - Fix apple submission queue re-initialization (Nick Chan)

Pulled, thanks.

-- 
Jens Axboe

