Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF26C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zMbCrPJzL8yTFIs1neOfn76l0nRWVY5b3AebkpdHLgM=; b=0UpCy3j8zC11KrAxPx1LvpSETf
	WdmYnYn5TzgGQxkcDfnglN2DzAEEzrs8ld4H/Nw1HC3dHa7eWwglYQxWLUOmi5ghvPGh13RL9qJ5o
	XrpAR0ad0XLdHPchKovT4kbrVvIM5p4gDa3EV8w9vq4upgcX0vVTRzJflbtpAzHfNdQFxyCQbASkI
	fWFI01McFxbN5qY97EkgEkl9hshiXrmlh8EjChJtvCFxJmLG4/K3SJG498ykxWJc1XbzSX6xuc5Hs
	0mSr1iUlrGwFl8Mj2bnAXRqKhvo9sv6KXQ5KsW2xRdWass1CEE/5Z3y3zRdnJEWOGdShQL7ojOH2g
	NJRl17iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYshn-00000001Icr-0LtT;
	Fri, 17 Jan 2025 20:12:35 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYshj-00000001IcR-3Yfq
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 20:12:33 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so90991839f.2
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2025 12:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737144750; x=1737749550; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMbCrPJzL8yTFIs1neOfn76l0nRWVY5b3AebkpdHLgM=;
        b=M/owktGaULZ2bYSeNL5Jj4dSYBgObShPH3xi6d+jFSMl6B0dq9NdaEqTLf2LNuWCLP
         Eb+vPyaC1W6AUYDBRHy71GOjLYuqkM1rzMgeGCEL2M62uVaAYdKL24z1uxiS26nk5an+
         B8gUB3vMOeGYdSKseuhB9roFp08h6ssD2XdY8aza/otfQHEpKcRsEzM7i0tXUfd8wjWk
         3+aXQzOPGQ+Kp5QLPGG6xklAPckRj5ojG2NpjYmrVtp08kabCSxuupIQd0WPO/rfqCom
         G8UjdJPP67D4rxFk7X/e+yOoyIWzmrj4be0yWD7PHKDyfq/8qF31tMGcEpRU+958TJIy
         OeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737144750; x=1737749550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMbCrPJzL8yTFIs1neOfn76l0nRWVY5b3AebkpdHLgM=;
        b=EGCVM5Wdug1NyArY577n7PFidnk0VAcm7F4LeBdaL+UrrjLsUhzlDSNKIJWvRgdB0j
         g/iPnR8+3woZE/hgACFhzJDApm5MSB10XbCudUJpP57uAkkQXtv2M5oLaTGbfsZfQIDd
         HCfhzN4f4bQ6D0yQWth0QsJOlhK1iv+AqSx9Pn8IAZ1mjaIgyWtRxUk7nbulJPDxdO/V
         4+JpgzGj3UcY7WlesqdgDpTo+UODNZF5wDILjPZ3rVZQRC/tdWUtGpRyr9O6qlV0utbg
         sK3f/T4W2amQ2DZtVpl+Ipm8Lw6onm91HoHp9ylooY09NijfpOnysBbdtQPY881bQ3cN
         dtKg==
X-Forwarded-Encrypted: i=1; AJvYcCXD6LKr/s1woXiaZtwNbgv6IzblOnhFWkRVvKwT8D7T8xmW01gd7ipO7Zbu7nGJ7W4OR1g/YS77Bxps@lists.infradead.org
X-Gm-Message-State: AOJu0YyydrllPc6da4nE9xyez4+5zTeJ1TpHSlfDLkvWTxSkVP210zu3
	4EsfXdKCdKrmRZBeJNPTJxIFcXfXs2L66XcjGDU6xeL+8cAFWxpX+FJfKeRmIoSdb5mJhNZa2bu
	A
X-Gm-Gg: ASbGnct0KxwJNSPw2Ze/GO009dlPrAVpLaqa/YuOtRiQKscqhQJ541Bo7/DMd1Vihop
	1frx/E4Mvf88/Rg5dZLAO1NmWpetedpdoBs00Zb4M2y1yrt/eXDGpsoAX/zrQ0apcPuF0uPbJFq
	12UWY1X2RrB0+qFf1n0NgkZUiNP972ZJX9eXh6fqc96oJxlLp1D3B48AmvA5munAWyAr2FhLGuD
	/rnoXRUzVZX22hlYHjY65rUCzHyaxqwzkPkRGAfmw1bImDf3B/2Hw==
X-Google-Smtp-Source: AGHT+IH0zo8wsg4X+Ob1gtuGKlznRlHPjHWRlLXjUWO5neR5ZhhSCiPRfv9A+0zKwVoXupgXoXN8hw==
X-Received: by 2002:a05:6602:6402:b0:841:a678:de3f with SMTP id ca18e2360f4ac-851b602f359mr303626939f.0.1737144750350;
        Fri, 17 Jan 2025 12:12:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea754964basm810406173.59.2025.01.17.12.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 12:12:29 -0800 (PST)
Message-ID: <fe80050f-a887-452b-b8f1-86f2ea816228@kernel.dk>
Date: Fri, 17 Jan 2025 13:12:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/8] device mapper atomic write support
To: Mike Snitzer <snitzer@kernel.org>, John Garry <john.g.garry@oracle.com>,
 mpatocka@redhat.com
Cc: agk@redhat.com, hch@lst.de, song@kernel.org, yukuai3@huawei.com,
 kbusch@kernel.org, sagi@grimberg.me, James.Bottomley@hansenpartnership.com,
 martin.petersen@oracle.com, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20250116170301.474130-1-john.g.garry@oracle.com>
 <Z4q45sjEih8vIC-V@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z4q45sjEih8vIC-V@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_121232_155587_A63B80BE 
X-CRM114-Status: GOOD (  14.64  )
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

On 1/17/25 1:09 PM, Mike Snitzer wrote:
> On Thu, Jan 16, 2025 at 05:02:53PM +0000, John Garry wrote:
>> This series introduces initial device mapper atomic write support.
>>
>> Since we already support stacking atomic writes limits, it's quite
>> straightforward to support.
>>
>> Personalities dm-linear, dm-stripe, and dm-raid1 are supported here, and
>> more personalities could be supported in future.
>>
>> This is still an RFC as I would like to test further.
>>
>> Based on 3d9a9e9a77c5 (block/for-6.14/block) block: limit disk max
>> sectors to (LLONG_MAX >> 9)
>>
>> Changes to v1:
>> - Generic block layer atomic writes enable flag and dm-table rework
>> - Add dm-stripe and dm-raid1 support
>> - Add bio_trim() patch
> 
> This all looks good.
> 
> Mikulas, we need Jens to pick up patches 1 and 2.  I wouldn't be
> opposed to him taking the entire set but I did notice the DM core
> (ioctl) version and the 3 DM targets that have had atomic support
> added need their version numbers bumped.  Given that, likely best for
> you (Mikulas) to pick up patches 3-8 after rebasing on Jens' latest
> for-6.14/block branch (once Jens picks up patches 1 and 2).
> 
> Jens, you cool with picking up patches 1+2 for 6.14?  Or too late and
> we circle back to this for 6.15?

I can do 1+2 for 6.14, they are pretty trivial.

-- 
Jens Axboe

