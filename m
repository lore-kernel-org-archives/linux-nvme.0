Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929FECFD31E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNwYZl+W2fvcXiK6f1dLRuPmVDUoM4hiP4tOVDl+CUs=; b=vv9g9xW+TOuUxgDd8MzaO0NZuR
	MM8h8Y/kZBgbyBJ/kDTzSPphk9n+8auviVmOiGod+90cyzd97fZ6QMz6cJ37lyZf6CSUv+QcgKxp7
	B5TGn5p4KcOCgkRbF+kBQQgDorplLeRY0aFmdt2c1G2hDtADZWD19d2W9mQ8bWR23RVh3PwsjhrT5
	S5A29YTNQ04N8Vmg64gqYwhDiC1HWq0l7BFumKjl/QOe/G7Ce0o4wToowTMgNzaQ8BpiIj6YZnvdL
	TZhrmv99TK5YR05fen/LN0jFd7P6Sykru92h3Zb2E3zLpWn0SDMdfmaZX0r32lfEI23+8SO9xVp7p
	/Sti4yUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMm1-0000000B00b-0CjS;
	Mon, 24 Nov 2025 02:57:53 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMlw-0000000AzxL-0h6M
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 02:57:49 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7b75e366866so1602870b3a.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 18:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953067; x=1764557867; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNwYZl+W2fvcXiK6f1dLRuPmVDUoM4hiP4tOVDl+CUs=;
        b=lvMrsE0n2snEAeP++CdDv7p4bqReTca2ZxxCuQ8WiP2a42YVPZZEKdIHMqQqAk40N3
         GcgbiJxN7qnoVGk1wS06qVUaP9ZYf/WV46zs2awu/9KSsmLNM2hn4JdX87ZpgFy1kYEz
         2qC01muNnXpjqxGSbmENUeJsP5D743KfKufXw7zfjeogVJriRXrOMw1R4ijnJQTcZua6
         AxmGz+NsD214665ZENsmJSEKzJg7BGFmXyBK+NT+PkS/MzmNZsN+mCvH+lZ9i4mNBBFz
         U+obWTBi5xmMsOintbH0FU2OPYZhn9sRHQsCT2US2BefmkSG1Uvev4SN58mzTBEGb18m
         L+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953067; x=1764557867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNwYZl+W2fvcXiK6f1dLRuPmVDUoM4hiP4tOVDl+CUs=;
        b=Uv8iZTMX2xtbUWve6Jt8R/+JDMOh/RG/PnM9ai7tuuiSTKkqU5D22lC66yacyfgXm8
         FyZVi+xKqMX2n3B7N3Td+KvIDEqGiGoChKLP2H2tmKjn6L2AiJTl24uDmEWhkF5xiEpA
         u2B9zxujzNraxaZAGXM7miFUCZNlPeveUa9xYLuy/yIXB0S8p9IlSeuTOPq9pQwjjZIu
         FNWIOFUZZkJQu+T5kQfhtJs9dhLO5B/ZgOjisUCuqxgZ0CFN5C1S7AZsaGdXsCJQrPeR
         jM5A+rSsvBdkGAXtH8llSkB4qln3fhjqpBykX5MEk9UpDsqobwgjkWRCBT9zhB7+kMHs
         cmAw==
X-Forwarded-Encrypted: i=1; AJvYcCXqqumhgwe0s8ympYxaM00g3U02ty4NrPao8iTk8Q9mKGlDGoxHtu98rj/bL8E/qf9L+IlRiRN3meZe@lists.infradead.org
X-Gm-Message-State: AOJu0YzqAjCjVGSdu/qL+HD/k5CnqNfGtO0r/BbdVBGmgEVEHoiuWth3
	4T0GnTXrJseiEsWN6gRD9iL6VCTN1v1ZVEjlFvIYCI/BjJ3Hlz/Ie5iC
X-Gm-Gg: ASbGncuSDuJ3vq5ntlSEh/TJjMlSassk8UaF1no79f/lSHX3QN8dlysWIwnxxI5/Lgx
	GGXs8AsvbLjhPUfa9ICLSkUNbon+FSeqTbEsFlzgR49j0JtbeqXyMnox0PxqyTLS5E9TlpdIUrJ
	CCVsaZRqD7CIBZBStcSAx9TJhR0BziqFLV7hIAie9EEGpidfreCxLK3NRCXmMh7Pz3xRe0s/J6F
	bs3cYXqrXAjoKwqCNp4qN7V+MYwXvMxQUShs8UEjj1U6ex+/9R/Y7bIbt1KO6iJSBu/S/2tb+sa
	knMl7fuu1yb/9dgI+s7BlGpWPhSpK5F7Q7RLuuiq7Wh+u0B1/dcFrekNSAPtpkguwYd/bZdoMLE
	t+t1OjOVApg1878G1goRZVkHf2V3Rc+e8LtpI+QQhfuECDopLfUgEZQOpZHDz8l4SqP2LscXP4w
	NDxRK8aV14Pu/7mhMMzwuBOYvtzDBZj4EItORDtyi8CldP72k=
X-Google-Smtp-Source: AGHT+IEZXRFduMWog8lY/WEBRyb3MZQs6kfaoxzTi2A/dpYZvd44wI5EVbBBu8fatXwqYTbLGqTaxw==
X-Received: by 2002:a05:7022:6285:b0:11b:923d:774c with SMTP id a92af1059eb24-11c9d613979mr6980540c88.4.1763953067290;
        Sun, 23 Nov 2025 18:57:47 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de82c1sm45441687c88.3.2025.11.23.18.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:47 -0800 (PST)
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
Subject: [PATCH V2 3/5] nvmet: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:35 -0800
Message-Id: <20251124025737.203571-4-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_185748_204625_B578550C 
X-CRM114-Status: GOOD (  11.13  )
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

__blkdev_issue_discard() always returns 0, making the error checking
in nvmet_bdev_discard_range() dead code.

Kill the function nvmet_bdev_discard_range() and call
__blkdev_issue_discard() directly from nvmet_bdev_execute_discard(),
since no error handling is needed anymore for __blkdev_issue_discard()
call.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..97d868d6e01a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -362,29 +362,14 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
 	return 0;
 }
 
-static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
-		struct nvme_dsm_range *range, struct bio **bio)
-{
-	struct nvmet_ns *ns = req->ns;
-	int ret;
-
-	ret = __blkdev_issue_discard(ns->bdev,
-			nvmet_lba_to_sect(ns, range->slba),
-			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
-			GFP_KERNEL, bio);
-	if (ret && ret != -EOPNOTSUPP) {
-		req->error_slba = le64_to_cpu(range->slba);
-		return errno_to_nvme_status(req, ret);
-	}
-	return NVME_SC_SUCCESS;
-}
-
 static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 {
+	struct nvmet_ns *ns = req->ns;
 	struct nvme_dsm_range range;
 	struct bio *bio = NULL;
+	sector_t nr_sects;
 	int i;
-	u16 status;
+	u16 status = NVME_SC_SUCCESS;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
@@ -392,9 +377,11 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 		if (status)
 			break;
 
-		status = nvmet_bdev_discard_range(req, &range, &bio);
-		if (status)
-			break;
+		nr_sects = le32_to_cpu(range.nlb) << (ns->blksize_shift - 9);
+		__blkdev_issue_discard(ns->bdev,
+				nvmet_lba_to_sect(ns, range.slba),
+				nr_sects,
+				GFP_KERNEL, &bio);
 	}
 
 	if (bio) {
-- 
2.40.0


