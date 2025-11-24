Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A021CCFD316
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 02:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RkWhYF4f1lhsSHEbmYsrWUEDoM/XD4r0C+XpnxkiI8c=; b=mXf0iymG+XiT1mUyzJOcx1IMny
	LxTFTqmfltbrwSGssDPlXnByVQ29N1yGjeuClBzOK7racNeXvIYbooYa5xqShHn2TYdn21VsYh9UB
	LbAVnIEjL6P4VP3nJTZj87cXLNiCdmLYm7AoV68vi3fjFIJSJVUbYdW6S3GjQURMHG4qXbE7vkWPL
	u1ULg3BHQgSkSjBiu9XDcoy+AA2L8lbPbP/vvx4uSBNNZomgTKuznmYtQThBZEf3NWPN669k3vO+7
	qZYzjIlC+VvlvbP5RwdOrLmVqcfcz4qC0o/WBIUae6N6EMUxVj3xQM+Rs6o9BtjNyzV/9uPxJQEpU
	bf5iTr+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMlw-0000000Azxg-2F6K;
	Mon, 24 Nov 2025 02:57:48 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMlt-0000000AzwZ-1b5k
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 02:57:46 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so3415846b3a.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 18:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953064; x=1764557864; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkWhYF4f1lhsSHEbmYsrWUEDoM/XD4r0C+XpnxkiI8c=;
        b=TbvnJNspiEKvt7J5h2k1CDzpVQgOdr/VCchtNfqsisYbfM70GyT/4kCeonXjJFO7pq
         cT/tniAAgy07pPPLjI/d1GZABPvwVv+bK/QpsXLDgA0mx8l2nt/wuZpZsSMxHeE9UO+5
         iuI4ArZ6BPXeNtKVp1mJq6ZPgOaOh4JIK0jW5aRBubcatRUJ8s71hsuIrimkAfDN5Txr
         rxOtWc4SyLcGRso2ZKgakdEJDjtjt+EfRj++K1eSluEZoo87bCA6eyRWDVCpUEWYvEXP
         Jln5kGhG2HRR8clHXtX+fXh0pLpOrY7U5iknEKzlgNdMpEyLMs7i9BXpMPXvWTmpVclC
         m5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953064; x=1764557864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RkWhYF4f1lhsSHEbmYsrWUEDoM/XD4r0C+XpnxkiI8c=;
        b=itswEDLALcCwH+goKfZi82MyDsOjAWRO2BrBz2KzPSDxFJ7bDebN7a6z98GkbS3Ja3
         crrru6lQB2lMf3yJacJaQ7TN3G/71OoIHd3HmKktVwyxb/0eQUycQ/yzqskz9dcMmj2B
         pkFxdGwCFs9e4XLhDvnms4bmhSX39cH7dWzUGnj+vsHy0yxqPlkdVBqqhH7NuEo1GZnG
         0kIJRxXePZzxY14UUEYoU7JAJYbfQBw0Ik+ZppaDteB6HySZtnGY/EQM+XHin+liBQpU
         7z4kaURYON/PCNnANWaU7Fc4iVD7lwsdmpWwLXJdzb3IuvVgNvpVivSpI1zJTI3rFxFO
         Oaaw==
X-Forwarded-Encrypted: i=1; AJvYcCUttoWV+b/z2/O9zT4d7DzyMHQNAk3IZbkbqyC7cleYFrDnxgQG9yMnqu7CpmLlxu7zRVQc7u3wPRN/@lists.infradead.org
X-Gm-Message-State: AOJu0YzRmtcV4SAfV/Gc4HJQi7CZOqkyIf/rF2QU158ruUAWZQYX1VGp
	2lFoqgEl1dLcsEzCiInTHE4xkvjQ6ADMlBYHOa4Y4kHnjjAlKyIzaGQ2
X-Gm-Gg: ASbGncsdWj4N8kgjV+hVxfG2413AmQhUW0mUf0blFxZ6+LZoHdg89oIslpew8kBpcra
	/mCzDwFWn3w+K8p0G7G4w6pDPWpmfNTUd5BJpr377u2lCZXUUCxy3cgawOFg1+QT+gcmKOQRxv1
	FulbPPAdlMTqt8ARoeU8DgXwr6rwdDuAs/WDBkecJEtss6k24O3mxExADYXYpNorxhvZOBgrUG5
	juQrQ5bdbPcUwiXoKA9Ij/IO4qUScs172QqSsHO7n8caq8CuRQgg2yYbmFfmw2WeLOTPSXGRpnC
	IQQHYi56WohzKx192RYzu/9ezZ3gzN+Nm1wQgWMBY/hNMcoP18dhU7KtiN1HKM1NWBclA44+C0w
	ygiMMQM4iiY+1VeN0aW09wAM7wA44+yc5qvsEh3Q+um8h4RQF5fm/4DBUloE9D4TmbKvOjbI2UR
	6j3BeDZrRwkbbMm0G+9tgUQw3fSFI2lXbb0Ltc6HdhiJRmc/U=
X-Google-Smtp-Source: AGHT+IH2vl9a4qHa0wFFFsUNbzMzey1IZwx6tJlzdt+jREZgI3T8WYYR2vo3qAu15ZJ2v/Ev109wPg==
X-Received: by 2002:a05:701b:2803:b0:11b:2138:476a with SMTP id a92af1059eb24-11c9d8539eamr4726588c88.27.1763953064432;
        Sun, 23 Nov 2025 18:57:44 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm65938624c88.10.2025.11.23.18.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:44 -0800 (PST)
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
Subject: [PATCH V2 1/5] block: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:33 -0800
Message-Id: <20251124025737.203571-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_185745_417645_FD95F47E 
X-CRM114-Status: GOOD (  11.88  )
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

__blkdev_issue_discard() always returns 0, making the error check
in blkdev_issue_discard() dead code.

In function blkdev_issue_discard() initialize ret = 0, remove ret
assignment from __blkdev_issue_discard(), rely on bio == NULL check to
call submit_bio_wait(), preserve submit_bio_wait() error handling, and
preserve -EOPNOTSUPP to 0 mapping.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 block/blk-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3030a772d3aa..19e0203cc18a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -87,11 +87,11 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	struct bio *bio = NULL;
 	struct blk_plug plug;
-	int ret;
+	int ret = 0;
 
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
-	if (!ret && bio) {
+	__blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
+	if (bio) {
 		ret = submit_bio_wait(bio);
 		if (ret == -EOPNOTSUPP)
 			ret = 0;
-- 
2.40.0


