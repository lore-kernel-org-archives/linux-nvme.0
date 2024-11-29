Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE221D729E9
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xRYCaR++kEU3PDN2eQ+b+5uSQTJ5Bb61ApyC7HopWXU=; b=dJyrVdLCKgAVnPIyYox+eGnScb
	WhnmlGfbf9qT61992Fcz5xpe0Wrs+ouZxsLJuCecuZb2AW2+TwP+uffkE60AepEvEZg9D10jGUKJR
	M8bUrMtQpeDOz1D027vJ6uAqzw9P6WyIM846A0F2NPEJl98+4amKE1P/v7ye3/16xlTzpSqUKF8Yx
	XKNzTcDOe7vvlkcv/fBVyBqayIpM9Bc6wF5gk1Oh0b01TN+DHEi/Sjdop9m5PjfBY/MzMqNZdhB3R
	3tkBn5oSilQrNIDLKgMm1ss0O7ykdiOgj6NLfehuD/X+Z6uQQB10usqeA7iZCj249nJjcZMN9xLA2
	qRk1t1aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH3Te-00000000Xzl-1EUh;
	Fri, 29 Nov 2024 16:04:18 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH3Tb-00000000XyV-1luI
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 16:04:16 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-21210eaa803so18299525ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 29 Nov 2024 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732896255; x=1733501055; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRYCaR++kEU3PDN2eQ+b+5uSQTJ5Bb61ApyC7HopWXU=;
        b=harAnw/AHCcR3JFwMLkinMB6M4J+mGOcMnJcdnoadto+UX06rmjmf5MgKWwLRTEwE8
         tpi6qqAHXBB2bgQbTIWfQUixkU3gnBbeSL+QrsP0C56FAbCsKuu1ntn6yGy2pjXvnQQI
         6ERvlOu2NKlBNaWZvjVA5I16HVJhfVl1BqcsYVCXTP+aZP55v+lLV+ilJ9pqF2ye8+/y
         9ihMa7ciIqQqBnVfIO8k4mrGePN3K+K5dB1gEVzIE/d+wqejS3BiSYuDC2MF37nxS0in
         RESujMQDgG9slp2J9N1+Pg1Qzwvb/+K29SLAkZVl59wIVnhMcJWHaup09pInuuIwg1ty
         RwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732896255; x=1733501055;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRYCaR++kEU3PDN2eQ+b+5uSQTJ5Bb61ApyC7HopWXU=;
        b=cyRI6R37ebp1GIikHDP11S06SqOT7cCOKlfbegFsE/WeGDIsWkAXxDpD6kfQkMfPog
         6Jn7fsJ26DsCuVPGnaO+qDQaQxqFLPB1N6ne+ZUILqulOXEW1t2es6lmCG6lcKTpZV8C
         hGQAAH/M+YBZUhxumVla03Jw2XnyOTAsUQ4QSf6mSRnYzhlLh/cZUUY3eBdVvgOls3LY
         LEZSvPzoc2WHlYI/lneubRelrLIGxoBlrICoVxyKF9cbZnlkYvvJNxowa2UeFHm+pSuq
         rT8bBdtUPmsBnrlvtSa33XPJMi2VITVTtszo+aG0r3ptGpTnrko5b75uD8TFnQH4fx6s
         hqJg==
X-Forwarded-Encrypted: i=1; AJvYcCWwNfZBx3azzqS1747EaNM2NKaEV3Tl4gIFnu5aFUyVyPv07uYvWS/w5wjsu/NGYCsqaQvHMAJYPaty@lists.infradead.org
X-Gm-Message-State: AOJu0YyDjLsOC0vXCp0fk1EdngzQ7K+UcfRxjqXvgNopyR6Ous9hdMv7
	Zeum0iivt5Q0/wr7wNnWzNKvmFc6j/gMWmRI++531gZtQsQVxtx8PBPwrgE82Qg=
X-Gm-Gg: ASbGnct/SRhvGExHsUuGkRG9tRgREdsbFeGHqDdVienlvzALNRRVnJpObipey2ktieU
	+F2ZDzajPoc/kUBZea51kzSXhXMv0PzycGxrSmKAPEp3YeEX/2cmHJs88bhSUHLN9nG59/CTxSD
	ROMl/wCaNjpUZbfCJyZE9IinHy2m+rGuthP+grRHBincQ6xm88mH/v48g2/Gb+Nt9Qtoi8En5v0
	Q39QC+fYjcIDTvw85kvJRGfbj1bmoVQs/3IRJQ8GQ==
X-Google-Smtp-Source: AGHT+IGy1chS3Zs1DmbJsFkawdj66lilvO7GzDHuIuxS/pEbGyD3FpT+qxCo038R1fV7cDy/7R55Vg==
X-Received: by 2002:a17:902:d502:b0:212:6187:6a76 with SMTP id d9443c01a7336-215010960cfmr158548025ad.14.1732896254809;
        Fri, 29 Nov 2024 08:04:14 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f46a1sm32302925ad.39.2024.11.29.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:04:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com, 
 asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org, 
 jack@suse.cz, viro@zeniv.linux.org.uk, Anuj Gupta <anuj20.g@samsung.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, gost.dev@samsung.com, 
 linux-scsi@vger.kernel.org, vishak.g@samsung.com, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20241128112240.8867-1-anuj20.g@samsung.com>
References: <CGME20241128113036epcas5p397ba228852b72fff671fe695c322a3ef@epcas5p3.samsung.com>
 <20241128112240.8867-1-anuj20.g@samsung.com>
Subject: Re: [PATCH v11 00/10] Read/Write with meta/integrity
Message-Id: <173289625329.195012.12251484320092641789.b4-ty@kernel.dk>
Date: Fri, 29 Nov 2024 09:04:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_080415_464685_368C7C6F 
X-CRM114-Status: UNSURE (   8.58  )
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


On Thu, 28 Nov 2024 16:52:30 +0530, Anuj Gupta wrote:
> This adds a new io_uring interface to exchange additional integrity/pi
> metadata with read/write.
> 
> Example program for using the interface is appended below [1].
> 
> The patchset is on top of block/for-next.
> 
> [...]

Applied, thanks!

[01/10] block: define set of integrity flags to be inherited by cloned bip
        commit: f64ec9926ed2fb603acf4fbc73c09ba3f68e271b
[02/10] block: copy back bounce buffer to user-space correctly in case of split
        commit: fcc1f91de3e3cf013e810183cb6d333b09fb5741
[03/10] block: modify bio_integrity_map_user to accept iov_iter as argument
        commit: 465f05a6462bb67ff51c663759ca9b4952718205
[04/10] fs, iov_iter: define meta io descriptor
        commit: 3e73053699fc91839e711c75d87fe3da732a323b
[05/10] fs: introduce IOCB_HAS_METADATA for metadata
        commit: bbcf8cb45e21c0a4d4afc45fac6cc6b97e737d8e
[06/10] io_uring: introduce attributes for read/write and PI support
        commit: 0ff16f75c747522b403ae8a23513afe354f98fd7
[07/10] block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
        commit: ff19426ed1a805571f2a9ccff7d3432b57f4725e
[08/10] nvme: add support for passing on the application tag
        commit: 77a3bcc5847683baefd340f615a51e4fdaf9208e
[09/10] scsi: add support for user-meta interface
        commit: 1c1d47350d4eb585e2cc8f010000225b6a578322
[10/10] block: add support to pass user meta buffer
        commit: a757ddcd74c4b78403e4b46080de6eb73a17ab9e

Best regards,
-- 
Jens Axboe




