Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B8ACFD31D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4v5MRSjdziMsNVvfMkn8flY57vC+Pu/WImeTNAJo+ww=; b=qGUNmTFfARVAlcUJVKdsK8yp/O
	esj2UMwtL35ypVLNW0M4BnDzwUZ1TDy50JTNnoG5EI+7FMuH4FnwWH+UuQNK8wVzv9I6K11TD0FHF
	W0nCVfGgh4WqnaPSQontzb+kCwjWeNEfYnDAvzHI7fqOnRZ+qD2j4DHtvd8SEXLHEAkjjV2YBdkqc
	eBKpuNY12iEnL2/rqF6H9EYYmIcaDh7gONH7y/S7l0X1wLPmRqtiXW2iWPf9SVXm0gKRbdAl/GVeI
	//TZ9H79vwItrkvDUf1oTl+7dMIrwEw4PJjYrcNYdIwqZCMp8THb6xCl1FPPxhT3pbwwNZA8xBr/1
	928oyCdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMm0-0000000Azzt-2wOB;
	Mon, 24 Nov 2025 02:57:52 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMlu-0000000Azwz-3kUC
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 02:57:47 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so3537901b3a.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 18:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953066; x=1764557866; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v5MRSjdziMsNVvfMkn8flY57vC+Pu/WImeTNAJo+ww=;
        b=bbgTW+7EYKADYE0Zh5fM6ZSQfndvbFyK3g/SSjWEGuwJM4/PJeTM80XwaP7siovna8
         vsQR8hSGVzwCx7byQ5pLdOElbPKZkOwRbrWRQqavRAtIk9NdW7te7R/9w7fx4Yen9lK0
         4mvaFyFmlLfQMpHmC5CqklcdZSw+7CWz7xPOEpdhXaqk3vSx/cy04uBhrPh/u5D48nOc
         r4YMXS9NLdYrdiVIx/vIO40xyxLxjrT7WYl8RRmMccXOyJ3mgNOzKVkqYKOPXWiYNvqk
         UxydPoKZFWc50H8Iv7FGZR/J9QhEvD+QhIp6vmBvuMsN0XJ1Pn5+Vs3VEQRC/BktUr46
         b9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953066; x=1764557866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4v5MRSjdziMsNVvfMkn8flY57vC+Pu/WImeTNAJo+ww=;
        b=HP0WritkITQQfSWNewPUdg7lLU0+W1aPglv2BdIuVj1F6T2g7UiwWy6bZpNvFi+8be
         Xhy8KbF/1N3j7H8nJ0EseR8lZc4L8VYxDW2Kuq9MuAa8yYKrIvvQz4dt6JlLXkqYuDlv
         cMopHhIesPJb8w+o2BFdPzoabr+G/Yf7kX1uLKgJ8EZhpLYfDghpDMr5J1LW1fyyleG7
         IZ+ONkqsCNv3j/l70Xn+zcsQd7Ll9+VgyUm2jt8kfXeHcB+MIEAEbJ25VpjGWxtE6RrM
         MNP7wRDYpg8XikNLw56EEyXDJAyvkVEn35NjS/Rht6iH4EK1mdSUj2SCNXiVXPnSwep4
         hHDA==
X-Forwarded-Encrypted: i=1; AJvYcCXzNW+UdVokVkGil3gfH+WR/bpAv7CwmuMJSAUsqyoMwTlTPYO0Io7XpQqwjLazmqWRkUiDKOFwbd4S@lists.infradead.org
X-Gm-Message-State: AOJu0YwlixD57aiTgJ8j9Joii+k9J4dUlbN+25AqAw1VKLnRkDU88Wi0
	qpceEuwH3dlaZU/Vou5kZc/B1YW8m3WtS3iwYkIDHsdBljUYUjiL/Olq
X-Gm-Gg: ASbGncs3TJtYHstw6ZQdqcq97lhM19I8/iO83chlFWUIiXZrNdQeR7JiL63vGpyP7vv
	m1dNk9bixIM2di78lg6L23Ea+rc8ComhtuBz2G1EykaX1hoZqZuJHla9uPelmB2/t/Hh1otN3tj
	3KVot/4hbjG/WPoGmsK1/I1Xvl7HQ3ZxUNpQcbcEN0QWPrWec9J6z3y5v81xYAy2+/tNnmYtRz8
	brtPdflDWINMmue6MjMOQSYsqeVzN4eQrcLsEVICu6MjH0XbnRFfdvudLzwabGUk+tkbQVaW+vk
	QcIhx4xTpgPD5lxJrgkJfcrmxXkgSatsw+wgmeMii8y1q0Lc26vPkORyPN405eNnJLp6PXKRoFA
	SabAZB1sAlxcLe7+psX1bNRphtJDbyUy5S5z4QuPu63SkMxxYw75kucoQ7siQ/Tl8hajE4lA0Cv
	n6ag4JZHsgZa9s6i7nXDjmpGwArPpQ4H8ErdCFeguZvJvUYII=
X-Google-Smtp-Source: AGHT+IE2F0nLiNeIHq2g4zMVJnIfiBv34S3msVGeqkx0u3CUtdU5YuLkC01czcghjZ+E6ydM6GCvrQ==
X-Received: by 2002:a05:7022:6391:b0:11b:79f1:847 with SMTP id a92af1059eb24-11c9d712bd4mr5835461c88.12.1763953065943;
        Sun, 23 Nov 2025 18:57:45 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm43367228c88.4.2025.11.23.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:45 -0800 (PST)
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
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 2/5] dm: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:34 -0800
Message-Id: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_185746_932503_12E4390F 
X-CRM114-Status: GOOD (  13.72  )
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
return value of the issue_discard(), for end_discard() hardcod value
of r to 0 that matches only value returned from
__blkdev_issue_discard().

md part is simplified to only check !discard_bio by ignoring the
__blkdev_issue_discard() value.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/md/dm-thin.c | 12 +++++-------
 drivers/md/md.c      |  4 ++--
 2 files changed, 7 insertions(+), 9 deletions(-)

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
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7b5c5967568f..aeb62df39828 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9132,8 +9132,8 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
-			&discard_bio) || !discard_bio)
+	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio);
+	if (!discard_bio)
 		return;
 
 	bio_chain(discard_bio, bio);
-- 
2.40.0


