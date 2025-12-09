Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3423ED3B98C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BzfwZgr4h4BhPNLh3j52xxFZfkoKPkXdetQmkUZ/psI=; b=X9O2JBXh1t6Xa2GAUlhoWynCu8
	uk+glWH2UhkATdWyiSYfxojaYCpSF4HI+z5NKRcvVzJ+n9i8tdoDy4bmPfc7Uyxq8nCW8AmsXahm6
	N5b2367tiGj0azeSbxOdugo05GfO3LJGNGpc1A+5pNz8VDVvFySD78IcDF8myGNH3l+3HR12TV2p2
	O6AvI4yv2jTmryXmxpUH0xfXifgJlmkkW+kkk7tZ3edBYHCyCamcDxxii58jqzGz9+IFVV4b5dvd7
	EiJhdLRdle/Gkzcesac6UMe2ewcU+uqxeAT3iyYdIUTCJQl4sarJxiQEHeciL7d6KVg0u/bDCT3g8
	Y/SVkCuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1bG-0000000EbFa-2fjy;
	Tue, 09 Dec 2025 17:34:10 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1bD-0000000EbFB-3Fpy
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 17:34:09 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7e2762ad850so6157622b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Dec 2025 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765301646; x=1765906446; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzfwZgr4h4BhPNLh3j52xxFZfkoKPkXdetQmkUZ/psI=;
        b=nliCGG1O+Br5yjFnK33/UjB/BtfdRpX4YqqdfPOiUSU4+Ck8Zi4cSk35YRbTqc1c2e
         jyqvekIzU1VZT/niOQ6LBnT/w4ky0fkZforVebFqM7Yc7AEsveVgi46gLGRQvraK5vCB
         jGxVg3dh0efQ+xAwfECQz2k6/LtxGgb1Z+/SmQtM0o6WpUtRHvRyxu0EQPRkvQf1QT0D
         gl8lgZMsEfoxIIpTQ9AdmxNc7bePVFigXD7SBMsRf8B1/BKKAtE04F9qaJgVTxho8sMa
         gAEQ4NFiplTl5JukdMhRNFFLB8/fu+VoCffmGqAvDdfSGcyvKUMCkZjzvmuovsrcB7cF
         5xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765301646; x=1765906446;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzfwZgr4h4BhPNLh3j52xxFZfkoKPkXdetQmkUZ/psI=;
        b=pGe6pHOPo06Bbdv7S39bKlwdvhrFEmUVqeD60AFk0CwX7UfQXMnDA41IY5eae1IkHr
         tLP7TLksWL9NZnd46iZzkOXJCNbY4l6/ns355ENotNvYPQvq/8jo/EZBZQb8EECAf4Dh
         /zWM4jG3Ne43RqiFooLzjFlEK/mHM/haKAcIP/Fy6je1odI2/jzTyqdnWAjfjY0mHWxw
         Kekio4hZGoTBcLqFWnLVohrghSUGMZbURbAGalSDBiChs7KQk+bnN8lSmZjz9zRq/uJC
         iI2D07XxxWVZQSxyjoFm0t9vKBiFxDnIuYdsvLSUDoRrlBUuxsZu+qUNmNVQuvih3T1w
         WUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW63/bPto9Yw0SnDgd5nma02nd1fMRWEwTbvKv3Rs3PBXt6KVcFXU6QqVrSJayaCtl4ItxPaVtUsmg@lists.infradead.org
X-Gm-Message-State: AOJu0YxzabevKhYEI2QsT7IczFZEQRLve/O4g/5mSXYuReJqSpc7dCFY
	asDcVLMThBgBnWJwWy9uq7ArcpZLxkk/JpYx/9JjFVINqeglM/a0ejxJaoqEdVtV/5M=
X-Gm-Gg: ASbGncuKYcwcWxJJ66SrQ6g+oWS0zm9nLPj73Ga/iY1uuoDVGWIoy7GSUncQ0tl+ozs
	KAQHpsc5duDymrOHiUrv52jrWR2bNYt7r2ph1hhhs6M0VN9i+EhVwayHnawTyyNVzcOxD/n6/G7
	c6VCKJcO//MNc/inA/oDH6xmRvwAArfw7OQIQqXdj4bqWmT4arCFd2zxRovR+cORJRSeTNb81/X
	zhVjkhyPLrHZkFsvRx0BByVzfTmayYIlFmG6zoPenk2ymsSFh5n0OrARVyjyYIP3+JQpUWbAF5a
	CYkJWnHMcEn0hlojfFk005aIcOS8Dd1NrYPWWJudxU4ppDWguuF1I1yS1OmNkbgWbaT8zlfW9E9
	Xc4KUk3pyIMlp2HsMh3TgCigvpI10nUh0MBdDmZI7yGy5gdfb0sIu01XwiCZWR+zQmRt5dUZTyP
	mMgdAYO8YPNS88yCLwuODohiiiVr0JH01eRdi81FpXf+CdnA==
X-Google-Smtp-Source: AGHT+IFfoIXes1iCAjV5UsXYGWZhHXTyswShTgrkG5vdMBtSxznkyo+2Kn1L/PUWRLbkrpFV5M35sg==
X-Received: by 2002:a05:6a20:258d:b0:366:14ac:e1f6 with SMTP id adf61e73a8af0-3661815910cmr13717265637.72.1765301646601;
        Tue, 09 Dec 2025 09:34:06 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a274af53sm15484593a12.28.2025.12.09.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:34:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Casey Chen <cachen@purestorage.com>, 
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>, 
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>, 
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251205211738.1872244-1-mkhalfella@purestorage.com>
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
Subject: Re: [PATCH v4 0/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-Id: <176530164449.86086.1886657108099467825.b4-ty@kernel.dk>
Date: Tue, 09 Dec 2025 10:34:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_093407_852985_1B23580C 
X-CRM114-Status: GOOD (  10.23  )
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


On Fri, 05 Dec 2025 13:17:01 -0800, Mohamed Khalfella wrote:
> Changes from v3:
> - Fixed typos in commit message.
> - Updated stacktrace in commit message with one taken from recent kernel.
> - Added Fixes: tag to commit message.
> - Deleted synchronize_rcu() (added in v3) and pre-existing
>   INIT_LIST_HEAD(&q->tag_set_list) call in blk_mq_del_queue_tag_set().
> - Updated the commit message to mention why it is safe to delete
>   INIT_LIST_HEAD(&q->tag_set_list) in blk_mq_del_queue_tag_set().
> 
> [...]

Applied, thanks!

[1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
      commit: 59e25ef2b413c72da6686d431e7759302cfccafa

Best regards,
-- 
Jens Axboe




