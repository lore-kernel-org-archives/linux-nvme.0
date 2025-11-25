Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177F6D0EE13
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqV4ea26VpNRnNDOYj3v3FWNR4t9iRrjXWCFY4hl9NI=; b=De5JiwIIlUtto6l9PmAoeky1B4
	Grrn31Jrr6u6JqlpJYM8KR9X0R98pU5px6ewcxWOiGP9nrzRXnviSosiMX7Br6JrEUTkzkrL+49IZ
	KunS27t90ARCAjzJYHxp4jB7o/2hDMfAUvITOKnBq9xBF9Vv6FJKiQulnU52Vbu4WK4rdkqHifVCT
	0l9E5ZW5IryoUZHqovdlVi92U1dv3ApvpwM5ysji8rGFWQ0dRkEVIfDwjFAr6mDaGh/r38NFQzAsg
	ALnx2IIRovD5EMzcho2kNQNucYAT6B6XiHfRzNh9XZ1r68CTMC7SnqeigCrOcEaCEp5KT4C7p+MIF
	JukNaLzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNyQ1-0000000DnyM-1pqG;
	Tue, 25 Nov 2025 19:09:41 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNyPy-0000000Dnxv-2yKw
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 19:09:40 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-29845b06dd2so72989925ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 11:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764097777; x=1764702577; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqV4ea26VpNRnNDOYj3v3FWNR4t9iRrjXWCFY4hl9NI=;
        b=IGHvCqw16KQpnqYNHluV8/afPFTBvlXmKVcrvxuwI0QhPNsAylZULANOMrwOZFrUoF
         fEK81dCnNbLzVgvk1yUhKXxYivSFECQoeiDG/dGsM2MqC7wqCqwBDel1mTb8oNMOSFMI
         FbFO/T8Rp/G0ft939sDn3wgIqmclMPBswP0o59etH++QEbAQ7Xefd5xFnjUlJcOanygD
         0/OQT7LBOh7118rZ6xoSQcbr/O+fKqFFiK55WVcfDp98TnBsddKeqm4IN/z5rYHukMfn
         NPNOm7vEvA4VTiodx4zpkISRQWmpypXWqAgaIFUB0IiMuPCX+7fkvL+UOjCz/53sYj6k
         xcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097777; x=1764702577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqV4ea26VpNRnNDOYj3v3FWNR4t9iRrjXWCFY4hl9NI=;
        b=IqsP44B3tYKEfA2K36JDtv0JnS5KDCRqkFb2aadCNjVvzkKUwrNvZ5QJhPeaROFHBY
         irXSgT+H55wwtwKNmIrvkstxBB538xuecvgvF995eKHA0BRdUFNUzvbTBYHjdySnCUVW
         a+yLF352mIjR7qA+VIFhS6u553hwcZk8+nfu2tDr1j1H+oOzeB6Xru/X3dYK5QLNtzGC
         xaSFnIrHDo/ZuIA9yUH3/1QnF5ifsV171N57oD3rQo6yRX5U3ek+qX458fhHfOVcn5u1
         qycVpuTqP36ZwZPxjZyaMpm67JU9l70WSR7Aps9RrVNFJsZ3wiAk1fVDaPkR9hI9qlNf
         dceQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPJHZZfCzMYUokudvL6o64P/yj1evtHMDjpjrky337/CGh6enKxBFeRKZjN/zNkWKTWVZtIseFJbiA@lists.infradead.org
X-Gm-Message-State: AOJu0YznrEqjd+jNj2zJ6h8XTnGdw2vdDlAUjAZBBP+ZrzmKVlEMJeal
	fclvQkPoNXilF1FEeJZiBvkByH9Mqgip+lQsMcMZOBemA8LzfeqbbSYf
X-Gm-Gg: ASbGnctCLEC+mojnM8qpMqmWvw8H2zTQKvRG1BNDA+0f0gKoDgWiVxdUtm5s4UJu0vq
	7nYo8qm/c9iqGi9UE2U0PQu0MYEdO9wJrHbO1jepvr+q/8Qf3nQFYORga6rhopPqxIDEZLfLJDj
	diCL8UScG/5Gy6NBnrd7B+mPvXeHR26DWuyUYVrYJpa21TViSa/1a/DUBgBpb3EJrtIoqgrbjVA
	ADy/KCicUgsAYyED4r8ejmjWpteJRrtjBOdHdWr2xR+LELXHXxbtO/60TcC6yQ0env+c/5CTeTp
	82w2EowJNdqerYQ5KCpaDHBP9iXZwEuHhi2yNCyQX9ciGuyIuH8m7uSoNyTKyFOD96T1wMn5RdA
	FS1pRmQAG/lxKMrf3Ev1jSmk0H0iphR+s/Cn3kOjX1wsYCSjMQabvDUKNC0MIQhHdtR7SuTer+j
	FUhO03ZJnCn7Qa3LhZH+7a820hVp2ZHG1C7F3C8yfTaCG29xPKllmfovt0j4zna3KN
X-Google-Smtp-Source: AGHT+IHuIf8IdstsNtTBrFtuIhxYayVPP9kbYzco+dRdLBQVBBJBvJGBn5Q65xamj5HkAzoQXFriDQ==
X-Received: by 2002:a17:903:2acb:b0:294:fc77:f021 with SMTP id d9443c01a7336-29b6c6b32f7mr194870325ad.49.1764097777372;
        Tue, 25 Nov 2025 11:09:37 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:a9c6:421a:26c5:f914? ([2600:8802:b00:9ce0:a9c6:421a:26c5:f914])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107cc2sm176518725ad.16.2025.11.25.11.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 11:09:37 -0800 (PST)
Message-ID: <851516d5-a5e8-47dd-82e0-3e34090e600d@gmail.com>
Date: Tue, 25 Nov 2025 11:09:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] block: ignore discard return value
To: Jens Axboe <axboe@kernel.dk>, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org,
 cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-2-ckulkarnilinux@gmail.com>
 <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_110938_761504_DD6CFBDE 
X-CRM114-Status: GOOD (  16.30  )
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

On 11/25/25 09:38, Jens Axboe wrote:
> On 11/24/25 4:48 PM, Chaitanya Kulkarni wrote:
>> __blkdev_issue_discard() always returns 0, making the error check
>> in blkdev_issue_discard() dead code.
> Shouldn't it be a void instead then?
>
Yes, we have decided to clean up the callers first [1]. Once they are
merged safely, after rc1 I'll send a patch [2] to make it void since
it touches many different subsystems.

-ck

[1]
https://marc.info/?l=linux-block&m=176405170918235&w=2
https://marc.info/?l=dm-devel&m=176345232320530&w=2

[2]
 From abdf4d1863a02d4be816aaab9a789f44bfca568f Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date: Tue, 18 Nov 2025 10:35:58 -0800
Subject: [PATCH 6/6] block: change discar return type to  void

Now that all callers have been updated to not check the return value
of __blkdev_issue_discard(), change its return type from int to void
and remove the return 0 statement.

This completes the cleanup of dead error checking code around
__blkdev_issue_discard().

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
  block/blk-lib.c        | 3 +--
  include/linux/blkdev.h | 2 +-
  2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 19e0203cc18a..0a5f39325b2d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -60,7 +60,7 @@ struct bio *blk_alloc_discard_bio(struct block_device *bdev,
  	return bio;
  }
  
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+void __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
  {
  	struct bio *bio;
@@ -68,7 +68,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  	while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
  			gfp_mask)))
  		*biop = bio_chain_and_submit(*biop, bio);
-	return 0;
  }
  EXPORT_SYMBOL(__blkdev_issue_discard);
  
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f0ab02e0a673..b05c37d20b09 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1258,7 +1258,7 @@ extern void blk_io_schedule(void);
  
  int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp_mask);
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+void __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp);
-- 
2.40.0


