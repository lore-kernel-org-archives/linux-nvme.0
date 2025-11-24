Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E63CFD35F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5IpKKGvYwA44MA2SdIRqzoysh0eqDWrauHh/IuigN8=; b=VUCB/OYPWnOUA3+n2K6YJzV+v9
	vVr+CLIHlVI3oebSUNtkOmneYLpqCPe5IgcY801lDCyaKILMPmObqdMxqcwCmJQE4mA1iGTLY/I2H
	VtNt0Wgt9xKt6HMmG7UNACvYj+/ETVOI9EWypFk5FlYJzHgoNbOlfee28f16shBTqNzY+N6QR9cUG
	1zk3gv6ydTOoTrFMB+SgQ0I/sIOYJSbRkpdDYGrjGGf54IqVIQKZ9O0ssfuARaGViKn4vssWjzThv
	hQzGtildA4rKGt8DPoQOSZX9XZGFm165WLBi4jkXpOIRrpwFab+UuauWhAFR6Qy8+ItZ1CuabB+Qu
	ClbKwu6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIG-0000000CTdC-3LX4;
	Mon, 24 Nov 2025 23:48:28 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIE-0000000CTbB-1QVy
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 23:48:27 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-298039e00c2so68051185ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028105; x=1764632905; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5IpKKGvYwA44MA2SdIRqzoysh0eqDWrauHh/IuigN8=;
        b=RSrJyY9nAX0C9qASEYZY2+58mMY1gfvkjlIFJoivjPa10d/nqQdqV9dXD/iszll53J
         1G9q6jWh2ustnzNQAlUZX0dQNhyQKiGKcXgbylZTFDWNiZCSMqm+IFRexiRqU3Vajjxm
         7kePUaavydt7A+Jknw0RUDragjy6ZxZSVQfXboU8vrjoIpQ1Ius6kxhfbz4BtTwBJ2jk
         ouaAYhCRSBn+LIQZcp3jEu4Xziswze/d1UqG18tbpN+BiX+ndTQmDxJ+ZwXCWpcvPiDE
         Yz68s4KqRCim9uIpsfWgvJ0s12fcsX4ClaINujuZiuIpIvD2MBmAV7qwvv6RFPBPIKqX
         DeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028105; x=1764632905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5IpKKGvYwA44MA2SdIRqzoysh0eqDWrauHh/IuigN8=;
        b=BT3RidzPzsYWNgEdT499tMDaDinrNOGZ7Q5DdXhjVoHxE1YX0gYWyBH9KW7jyFDrQC
         7mk91aVPCaZCrKmp7PWwDGE3bxKRBSGUooUQImyRlutEY83pCP2EaRQf+J/ljSXU/5Nc
         Zh8CenwxNGB/6fEWgiQMd3XHHeKNeA77x2KFdAKvmkWoqrl1dnW6xoKZ0DQ7S4Da8CRT
         m6EB/CY/4FLojXYnt9lwycdLwz6qLMz/jEgsNqlo8JKWvDEejrm4IVloFYwA3E5F25dh
         /LIrgGW9y+BPQQ9AktaH1ECp0l9nFcqTqIMrU6NExHPENLDMYu0+LnwNY/ui987lrOsJ
         hV/w==
X-Forwarded-Encrypted: i=1; AJvYcCWHUACKE+tDS+vb6SlOzIhLLZA2kY2FaI/kTSn/ourdvqKFCLzS2zf4nhUn+/VY+fwY4D1HAG2mcL84@lists.infradead.org
X-Gm-Message-State: AOJu0YyxfzQm2ABFt8o5NLzFyosNqtbgMjt4Z6RxZdAs5jJktuzClasH
	egVriDm4c0WJxNw91x1ZsPtt9TVT33cvMPJ6zeopS9gpDu+S0fRnpaEW
X-Gm-Gg: ASbGnctO9vhwvavWyboWPqtEWbKZ+05ZG8aypay0Y+APgKWYyxq/sga6F3OQTRayqVo
	gI66aziS/daq/Qy/zH69R8RxrMzHP8rsUe6rtvXhv3oaQtkHcAsZcpSlAJRnt1S43WL9t4T59G/
	kEavX9okl6ckZP4MrgdbJYclmyA/P7Ka7LMKV/ocRgc7MHZ0UaYrKjFpSHtKiKPKRg1j9Jmms29
	1lLSY+xUyd/Qsrv9k5eQ8WT6sK4R9CFfp43ibJ0V8w2twbg/m+BBYr1yGm+LupRz4ZNZbUm8s8k
	4DQENJ8fscAZlFqug8H55oQP2HGSLZqo4/GxmXe+joSudPKueMHGb2E5maLugXSSLbRKMhbltlS
	8dhqPNB3lhitGqa6hcKipH0CPwbozkvsQU8JrmTF3+qIggE5JWWOF35DNpcyS54AEBDJphrYZ6d
	0vNkywe3DaX3/pytHiDdZDUoiGk6IUcRmoH1IrpWfwOH99bpXmBeXzUr3rSQ==
X-Google-Smtp-Source: AGHT+IGUjnYuQU4uZ65RexnKMVsIkRo4SljblPDkF73f7cjoVp9uAJMvqcbsbNcZ8FiTC+XwEcc2Xg==
X-Received: by 2002:a05:7022:6610:b0:11b:9386:a37b with SMTP id a92af1059eb24-11c9d870ef7mr10566206c88.42.1764028105314;
        Mon, 24 Nov 2025 15:48:25 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm50934572c88.4.2025.11.24.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:25 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 3/6] dm: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:03 -0800
Message-Id: <20251124234806.75216-4-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_154826_405300_565A62EE 
X-CRM114-Status: GOOD (  12.70  )
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

__blkdev_issue_discard() always returns 0, making all error checking
at call sites dead code.

For dm-thin change issue_discard() return type to void, in
passdown_double_checking_shared_status() remove the r assignment from
return value of the issue_discard(), for end_discard() hardcode value of 
r to 0 that matches only value returned from __blkdev_issue_discard().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/md/dm-thin.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index c84149ba4e38..77c76f75c85f 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -395,13 +395,13 @@ static void begin_discard(struct discard_op *op, struct thin_c *tc, struct bio *
 	op->bio = NULL;
 }
 
-static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
+static void issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
 {
 	struct thin_c *tc = op->tc;
 	sector_t s = block_to_sectors(tc->pool, data_b);
 	sector_t len = block_to_sectors(tc->pool, data_e - data_b);
 
-	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
+	__blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
 }
 
 static void end_discard(struct discard_op *op, int r)
@@ -1113,9 +1113,7 @@ static void passdown_double_checking_shared_status(struct dm_thin_new_mapping *m
 				break;
 		}
 
-		r = issue_discard(&op, b, e);
-		if (r)
-			goto out;
+		issue_discard(&op, b, e);
 
 		b = e;
 	}
@@ -1188,8 +1186,8 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 		struct discard_op op;
 
 		begin_discard(&op, tc, discard_parent);
-		r = issue_discard(&op, m->data_block, data_end);
-		end_discard(&op, r);
+		issue_discard(&op, m->data_block, data_end);
+		end_discard(&op, 0);
 	}
 }
 
-- 
2.40.0


