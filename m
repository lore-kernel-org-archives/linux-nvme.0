Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFBDD116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAlkzqFb5MzFCJaoNDunPaLLzQJH14gDGKiKCNGaT3E=; b=3M/Globa0RCATGHxKBkJub5vSk
	iSKXQlLqnYISVEzMlCXUhyuFp1NPbqTwdNXpuh7mAhHIYxnI5QCD2xW9OVZqYg4sz92VcEYedmBwb
	kld6CbIE/GIPs13OU/+FYCf0aCzxCsVvM+lQhOTjGgPZfeJ1zNyRyTpTTrVh2mZ7BsGuwi1f3prNy
	6nCHzG7RyQSeqvnCAb8+fyVC+9XSgHjEFV7PgGMGIedHL8Pf99xCUvCUfWPA6UY2367icxPYZe/gq
	8XiIO8yCQs/tEU1TuB1j73rLDAmgkTM9ETmCO3/A3pXP3g8wr2OONJC39dwBROfoYcxFHuvgHFWeU
	re9tPg0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtui-000000009V9-1pHb;
	Fri, 28 Nov 2025 08:33:12 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuf-000000009Sg-1f0D
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:11 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-29853ec5b8cso19959515ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318788; x=1764923588; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAlkzqFb5MzFCJaoNDunPaLLzQJH14gDGKiKCNGaT3E=;
        b=lTsL4P6wVeJVi52OzTrAe2wvaDT2FIeFEwmRbajkL/TXg6nFnZFBc6aPOfDBUsFjnx
         b0y3vb8xqQoEMQsUKPPZgQSdBLe6CT5R7DsiU5ulvfEINt1fYKeTHearn8p1d5ttc/Fl
         2toO4DZgY1OETWSfO4iB4EpalIvDf2S4ZrY24V99fWrf0zCi7XNonu/tD0+2HdvTZrnP
         BZycjrR5X3kvmbC/HmuqXAV7sbeO9pIfzXDt++k8P53Lu+KNS9jUd8TmTX2Gq0Gi0vOq
         t/a6H5SuZNoh4Cz16Cu6TxOivxCaMljRsNEAUfizPeSFeKywmMBapbonsPwjlKytWbB4
         keOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318788; x=1764923588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAlkzqFb5MzFCJaoNDunPaLLzQJH14gDGKiKCNGaT3E=;
        b=H+S3LgQfGvjovtzhSXqdhDquQhdc9YouiMqfvEENSd1QQdx1Vzo5fkT1C1b5Up29xn
         XimfXfIIDBNPyy/vmtk/ml5yFQYMrJKVkpsgeCOx+TpYvtAq2ZGTa7T+sOfxZKpWcF4o
         9CBkQISNpA+LvyAccnUY49GBvSUzW7D//4l+UXXo3LFAnCyc0fyiu+AXTtK9opz5sz0k
         ykNCaKRWlj0UM8/Di9Lfpzxa89Gqspcace6JFjMX3UN5VghTII8v4rs6VkeyFhLn90bF
         RvqpARcYNiePfSOFFvvycr5bZRnBTrv+4tomDPsH+iR7fbbxKm6TfJLAMSXUqeFhhr/S
         WAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/taBIKBj/2Opef2sbt1OsQ/KsmOGtZjL8x1IeduPQkVuQ3CXKMe5kkeGcaSbhd6mmvkLujVKEo3oH@lists.infradead.org
X-Gm-Message-State: AOJu0YwwHyhMOl4fpzK8taicy6UUeloGFvxMOVWukCoAYz2ukRKIQMx0
	BTDeuukFCW1lejopJgL7Tl3ae4YdbUmChbGUoizSGeiHoZQkl/xFzvsi
X-Gm-Gg: ASbGnct6xht/iPE7VOD1SmRe2q5UKkOIk1Rswr1kDGsTPLZeMsoXF2YQHyU7tpf1qVh
	XFeGK1eYEdmCQszZUOw9Z/4xLLxNaAe0UtvbA4wIS/lazIVMNU18OyRh6zUaAGhSf1QGGAlJuxK
	wS++8OmE4g+mWjzU4G7T6SDSgqJ5/z3rG3u3NHLEMKl9aNDkgIk2xapPGmy7DKaxZ80ezTjHcVx
	Tb/gHBg6gxy5MxGmc5fUk53uX5bpLC4RIThvOf1g5WGt6/nZBAkwK/pkSWOYXjYsZjgvfRKFLst
	H9YwDDCdElxndGe0EoVL+aiU7RT/+98mBZh4Z+gc+uT+91JQ/EDLBkaYYOGkHn4Gkzc4qjUOqHZ
	AJUCVpijkAXgJ32EjQ9/WGrrn3LB2G90szGzrGq3Bc2QgNzGCsxL4w4/L8bVUzPiRkn5ACrEglE
	YOHZx7JnnnKIfwtghZsI/IPgFNMg==
X-Google-Smtp-Source: AGHT+IFIaFCQuKpxcLcZ63tEcOt0hGjrfoUQN9LWUQ2kBfICDUhGuL68J3zsB+mI5c6KDSWUdB+sFw==
X-Received: by 2002:a05:7022:670f:b0:11a:4016:4491 with SMTP id a92af1059eb24-11c9d84c6f8mr17988575c88.24.1764318788462;
        Fri, 28 Nov 2025 00:33:08 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:08 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:13 +0800
Message-Id: <20251128083219.2332407-7-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003310_025829_D3A24E1B 
X-CRM114-Status: UNSURE (   9.58  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c..0073fd7c454 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(new, prev);
-	submit_bio(prev);
+	bio_chain_and_submit(prev, new);
 	return new;
 }
 
-- 
2.34.1


