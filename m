Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8A606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HDoqcur2;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HQxbKELX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=JlvxwwNyQO6n19Y10XHId6qvmxHt/ChSrZalCBx9Qp8=; b=HDoqcur2CGQw5I1dswpfF/DFjM
	OGCRSTZfCLKEYoDV8CPRxd3Pj+bBK+RaOSx3LH4zjn2CSuLqKeh1Qqm4J6PXIP4D5R7epPFjYCdzl
	jOFQUJMt7TugYdes8s8El0ruW1jjj165ubshxg9IVSLTdYs/LovJ5+L53MCUgKDjEMdPCQTH89L3X
	dicaNTMcP4uNZ7iJEGe3oqB/luB++ahvYadeRtYpns5a71OogIn3zqxgZlzryqcmtjz5sZTOaSAF6
	vXkf0siEtKn+tDqIfuvxvKKnOUO5xjI+o08TI44sks9yYh6wgF3w3c87xZsGAv4/czu3T7lFsegrG
	cePvp7JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSWd-00000009i1q-0JkD;
	Thu, 29 Oct 2026 15:58:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSWZ-00000009i0m-2hpM
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:58:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793289521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JlvxwwNyQO6n19Y10XHId6qvmxHt/ChSrZalCBx9Qp8=;
	b=HQxbKELXXHIZsgSCzLrasQOOdIRJO/8og1+Qiv8X0QgrNloP9r6ph013ct7NEKPNsElPM7
	4+EOIuYUgzUQEB/KE8fZGgj2B55iVSmF76Bc0br0r1wkRicF+6ucV91IV1PjbdIhCc5q06
	mmfdwdO+XHYEotUmCODN8nNkqJ6T+oU=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-c9UwJVeCNtW7QrdBxmfh4Q-1; Thu, 29 Oct 2026 11:58:39 -0400
X-MC-Unique: c9UwJVeCNtW7QrdBxmfh4Q-1
X-Mimecast-MFC-AGG-ID: c9UwJVeCNtW7QrdBxmfh4Q_1793289518
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso3780840c88.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289518; x=1793894318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlvxwwNyQO6n19Y10XHId6qvmxHt/ChSrZalCBx9Qp8=;
        b=RHiqqewRuOxW0THW9w34SNqiQMou8gSRySYKwmYxbiSGfFNO7j1SdCI5V7obSTPn4z
         jJo09eEFlNPjeGjga3Pl0TiBCXSPsm8nLntipZPbnFCF2qMOk8xJPuSWYBfOGzBzXZCV
         QHvlxESYClwvMwhVc0UIMTp1PM2PgfNf77FkZSreY3PQAHCCtrIOiNg4MjpxHXM75rW7
         dLNHgrqkB4ACPkjePbCF09l0g1YiTD1SCuF3WSpYpPpDGI2rrYfWFK9YYVTbZ66gtWsK
         m0oDawwI8d2jBSZgit95qa3ychQEetK6JaDHCo1tnV91NVrNdPzKTCSA7fuL25AvAC7I
         NIrA==
X-Forwarded-Encrypted: i=1; AKwUvBzAKGy9Q6Peb36ozh1wcBipUyPmfNOkifInKWu+gC7JHikux1RV+23KMUkmZKBliyD+PiL8ZX+19514@lists.infradead.org
X-Gm-Message-State: AFq9FYJBXr+q40r+by+oyfzbmRb+gnAqA3vqMRZKRa11iHvBEhkwKlPh
	YTn3Gx6YYsRDRKfmVtolZzxEgkYf/xyHcTKjhWkDh4N8NdmPBlpkTfJWGTFckcwD06z3JjVDsB0
	Q2nPYLcyGvFwrsuU4HiTvg0FwvgrT0Rh9xtZUnLqDCglFeJZGjv+1iuowFelAIOoiURj+
X-Gm-Gg: AYBFou3AndKR6RDs8v0xIdwZ1P0VKvUD3lWrkH+L4zsRn6s1SwHqehWAGuvHnYduMig
	CHGTsO485gy7LMk3LbU04MOTzVXTs9HCbKmUHwfIlvB4JyVT3DcABcvkg2AhdiZls+iPXiQNSht
	IfwMMP5a7LzbCepFDoD4mu+IoxPecQTgvEhLYMbmz3kUEfAUl+FY+WbtNQadFaxp/cMCcmcBAFa
	1K6HJd8iPXaxWxnbeiJN/WeeBiRgek4WzwIhiNPxSXwSvduR14zx9QHddhJ1lWafsJDf6o5IJr1
	fgj4JUxBAlpeYLEmaBvYu8gekWPWOkSD3MhlI8xa6n2e6FrWx0rX0aQW/SViaYwsS7R9/xtgfUw
	8jEfnEegw9cZWtsQNEAEGHBPU3u13/4bSObuL
X-Received: by 2002:a05:7022:ed06:b0:182:9071:3249 with SMTP id a92af1059eb24-1a6ced8ec45mr7441630c88.30.1793289518125;
        Thu, 29 Oct 2026 08:58:38 -0700 (PDT)
X-Received: by 2002:a05:7022:ed06:b0:182:9071:3249 with SMTP id a92af1059eb24-1a6ced8ec45mr7441587c88.30.1793289517483;
        Thu, 29 Oct 2026 08:58:37 -0700 (PDT)
Received: from alpha ([76.166.245.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1abea527afesm23753c88.15.2026.10.29.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:58:36 -0700 (PDT)
From: Kyle Bader <kbader@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Kyle Bader <kbader@ibm.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: only fail dma-buf bios that need block layer PI
Date: Thu, 29 Oct 2026 15:58:21 +0000
Message-ID: <20261029155821.2983229-1-kbader@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tMcTrjT1WdXTjmtbhRZE5wbxuE9WaGzLw6eKAwjaZ_E_1793289518
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085843_777500_109C9F2B 
X-CRM114-Status: GOOD (  16.68  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kyle Bader <kbader@ibm.com>

All dma-buf (P2P) I/O to a device with integrity data is rejected
today, at registration and in blk_mq_submit_bio(). Only a bio for which
the block layer generates or verifies PI needs that. The block layer
then walks the bio_vecs, and a dma-buf bio has none.

Reject only those bios, and remove the check at registration. Then a
submitter that attaches its own PI, for example with
IORING_RW_ATTR_FLAG_PI, can do dma-buf I/O to such a device.

Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
Assisted-by: LLM
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kyle Bader <kbader@ibm.com>
---
v2: a shorter commit message (Christoph), and Anuj's Reviewed-by. The
code is the same as in v1, so the tests of v1 still apply.

v1: https://lore.kernel.org/all/20261028181412.1919506-1-kbader@redhat.com/

 block/blk-mq.c | 9 ++++++++-
 block/fops.c   | 2 --
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7fff1305b..3fc9fdeb3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3138,8 +3138,15 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	/*
+	 * The block layer cannot generate or verify PI for a dma-buf bio, as
+	 * that walks the data pages.  Only fail the bio if it needs that, not
+	 * if the submitter attached its own integrity payload or if PI
+	 * generation or verification is turned off for the device.
+	 */
 	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
-		     bdev_has_integrity_csum(bio->bi_bdev))) {
+		     bdev_has_integrity_csum(bio->bi_bdev) &&
+		     (bio_integrity_action(bio) & BI_ACT_CHECK))) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
diff --git a/block/fops.c b/block/fops.c
index 01bc8afe3..5c8024011 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -947,8 +947,6 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
 		return -EINVAL;
 	if (!disk->fops->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
-	if (bdev_has_integrity_csum(bdev))
-		return -EOPNOTSUPP;
 	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
 }
 

base-commit: 45b716456dd99488a0cef58482120dc0474aa696
-- 
2.56.0


