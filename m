Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DE0C44536
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=; b=ArWmacwfDvL6tZE62fqobWCvBK
	F3VMyaqdOBmBlk89Y7NV+p7Y4/zcWFvPUlCHyG2AHGFaJV/M9oHXM1ADpkk2/rYsgAcIGqSFMTmal
	ype3tGykL0EonyoCEaHHq7I/J+wQKHgZJ4TYo28EX8+ek8N7uCUq6iK896x59B9ZxkSjd2arzqGJy
	EL83r8GPX7He8U0gNYMXMfJsM/FrkRsQlRMaRB9k5fD9P6qkO3nJBpedYAtbeqGHdudYtRqyoArOh
	kf1Nn4oYSu6avNPz9cg4tOn4WgxfQjq7c7aJ71LwiSoG7QwvNn4HjWrr2UV1vgoTR44JNZemG20Pm
	m6oZRenw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXl-0000000A5S4-2sLB;
	Tue, 21 Jul 2026 17:46:13 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXf-0000000A5Nb-34ow
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:09 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-472326ca506so8974377f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655966; x=1785260766; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=SAricblvvb6QUcvGyB7McagIaWUErbacCU6vmomi6QYgHemudiYC9VH/loTl1OxeJl
         YWPEkw1yW9YHYj57cvpwi9WAxjuRT66Qx/MItKABtXAu/6T3uQmgkVfIBmTzCRxPqKxP
         3zTedJCsOYd3uUDRnXHVlGZAO/iZmPT2YfjwNDt6GT1XeOh1CMxRJiqevhD0x/N4NXH9
         x/lD0mcfsvLwvqT97fEPc1lMu85hmHEdnq/7mFYWDtj81oz5IA5nF/XpY7p3g1G9TsZy
         /BbplDblcwIgY+qSc5crzfg60/BuuCHJZ5ZWbLKb4Ad1A9zUs7FYMekTg/9PczfrXrb1
         5Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655966; x=1785260766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=V5Qr61YUnyCaplYbz1/JGOIQMhGGS6hybGbLYOHIvZZs+zOpbQCJf/qwTb00UW5Dc3
         BhmVzL1aEyVOlyhip7JZ4ZQHHWgFOPVLhiAY9LgI9IUedFGv1L3ik5UkWK9kpcUDBccM
         s6meyCIMSN4Ak4Vay9FmCIWPz1/JSgBScolsQupHGYTUHS33IcVG+zOhGInfDNZk0u5u
         q8RB580py7TAmPwUcPPzuEYCL1s3Y0BXyj/+8AplXtTpFqKYpWXHHG5mvb5aepgrhUXP
         iG05zW93RAu647sBpDnhb4yQgvOfcIts8rsV85Lkr9FaYSY9YNLSmsxGZa2lRtbE3OeS
         QO1A==
X-Forwarded-Encrypted: i=1; AHgh+RoG2hZ8oOfR2lSeLenI/rfHubOq8b5QN8wexB12yWngabqkMy/LORnoxooEhmVs2XP2vvhZY88jDOHZ@lists.infradead.org
X-Gm-Message-State: AOJu0Yw95Sk743oPvsvZ7qeZ3nf9A4z5KYJgKbkTZP+6/p2ZuPRZdGHY
	p9mF7UufBaUc9c6YrHjhKjq8FAZNFqtz/ZSsmV9ewAH7ytxqe+AJnvxFdQKQGz+MbA==
X-Gm-Gg: AR+sD12hpjxAvYTr1Xj2A+5uvNmWI1N0mD1MCvw4pA0Kxim/ftMcAMvdmPn3VCCH++u
	cEhtiE0kfz7oOJbAAVjj2552uN6mlUGXtGu5aD1k/PsNCkN+QiLju18p//b7oyZ3xjrM/VKuYpR
	+NjAf7QpO7TCDEopCpV2MzGFGtCYgxaUWtFuZa/Q4fcvslMdE6z3kemC9i57ewg7ObToig7UkIG
	KFVntErrgZKHZGqCbAFcIB5P2KLd2C5jG1YZxwjUbSsEPkbshEkgI+v5swmBZuxtK6D57MIT4mz
	RKPk4Q+r0zFIdfwb78eKg/uPfEy3S2IckmEygX/E1Bp/r3dAUg7s+kocG8gkXzu44k66wvKbWhc
	MKqapG0xhLyMPzcC9TxmkPPpI5nIZGG7AhPpL9HGEGUBhTbD1doGxDD7ETvpoXmiB4StWwqMVqr
	VJLUb2+EPHHPNMsiEV4yeVS28/wxMXTxcrvFqOhzM/xJM83Lk=
X-Received: by 2002:a05:6000:27db:20b0:47f:4602:66e9 with SMTP id ffacd0b85a97d-47f6232e29dmr17004239f8f.40.1784655965889;
        Tue, 21 Jul 2026 10:46:05 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:05 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 3/8] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Tue, 21 Jul 2026 19:44:57 +0200
Message-ID: <20260721174502.111503-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104607_807987_8C928DD3 
X-CRM114-Status: GOOD (  13.29  )
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

A write that skips write-behind (full behind queue, a waiting
reader, failed behind-bio allocation) races the in-flight behind
write it overlaps: nothing orders the two on the write-mostly
member, and if the older behind data lands last the member keeps
stale data for sectors already acknowledged as rewritten.

Serialize on CollisionCheck, which marks exactly the rdevs owning a
serial tree: serialize_policy rdevs plus write-mostly members when
write-behind arms serialization -- the case the MD_SERIALIZE_POLICY
test misses.  remove_serial() under the same condition.  This also
avoids the old gate's latent NULL deref for rdevs hot-added under
serialize_policy (they never get a serial tree).

Fixes: d0d2d8ba0494 ("md/raid1: introduce wait_for_serialization")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..997f79c05db7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -564,7 +564,7 @@ static void raid1_end_write_request(struct bio *bio)
 				call_bio_endio(r1_bio);
 			}
 		}
-	} else if (test_bit(MD_SERIALIZE_POLICY, &rdev->mddev->flags))
+	} else if (test_bit(CollisionCheck, &rdev->flags))
 		remove_serial(rdev, lo, hi);
 	if (r1_bio->bios[mirror] == NULL)
 		rdev_dec_pending(rdev, conf->mddev);
@@ -1677,7 +1677,11 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * CollisionCheck marks every rdev with a serial
+			 * tree; order against in-flight write-behind I/O.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.52.0


