Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC7C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:12:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66F464F20
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66F464F20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WK7AeqVzkPO3NlhhkOat+E6qcc7CUfm88hTPaayFqm4=; b=bFSs5ZVpIYiCSKdhbH6YIudH1
	pjqj8USlertJ3rB6sO+VFSkT85jz+Ee2QxqRrzIxzrJvXdWCr11LptbWPeI8J2tRqgFKRQysSaMcP
	wCo9jyVUjZ3LatLiazcaMPmnEA5r0v3zzRPgEQEO4JqN539NbQXvxLBotjLFdqDw0WWUNlOewBIW1
	vuNN/tLioncGpTg9LhcnjjElEr+RgaLg8xgp+LxQ7yTcV8GGCRy3FaS8vii91qCh66fVBYN/vga42
	LIqkVIhQKc/c2IzzhAXkiBZ2G5syPO87sgN4XXLR1eZyx4Ut0QbxQWrofmPNf5RAUQSgs2YjsZCXu
	k0sta7OoA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeOc-0040HH-7n; Wed, 17 Mar 2021 22:12:06 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeNC-00403H-Fe
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:10:40 +0000
Received: by mail-io1-xd29.google.com with SMTP id v17so190148iot.6
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KkKh5SY71C+FvwTcfh8mE1DhvpyfUkn9hUkYbs4O9uU=;
 b=nEyiuMdV54j/OgsEdoViDD+gQi+B9sV1e3zfAB3arkHDY7GA7Zeo6EF/FUiJreDWAo
 Q7bq786vic3McMUEWzdYRvTCdHZppXIrzx3wq9j9mKOADxNUI6kY8/F22keFh1vUaR2r
 IRPoA+jGceSwfF9vVUdZVkk3G8OGGTsb+4nxN3R+okKdNN0ZlSxqOIv7BBjn/HrqwG8m
 mP3vRxrE42ELmoanHkEo+KREb8u0jk/8N9Y6L0GPX28gZb4NbBNCnIOJDFHU99l2PzVS
 8gGdRk90EEDqI+1rOBEZazMNtwXfcz3UzntzW3VgVGwwiGKJ9oGHGHbdB/lAoXVTehos
 Ui4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkKh5SY71C+FvwTcfh8mE1DhvpyfUkn9hUkYbs4O9uU=;
 b=XAsYyDx+RW1BV5w72WRCCIzoJbPy0CJN/PzoQg26ZssxI1+NdgydQsX42VnEAXJHJv
 BZKZukKH8DoirF5yZVwiM61WEt1KK2kzXi1JwGJMRGNffglDlT5A6UnX/3xWOTzBV0GJ
 k1Ge54SU+vlBsBJ3O/31GuDr9rjr4Kd+VLf1J+EguH7u35OUzdE6kO0GIL+4q99i832F
 pG2CMBMQOQhQKTIp6gnaNmcnBzngXLPN2y//TSdceQMTzfYpjaOWITjrzLPHLN3dFeod
 XM7zlcO6TYOUxnSSlQnLk/nQyvtSr9dt3F8cBjMafQZmoKfhuTxgWRO1fwDuJpccQe63
 imHA==
X-Gm-Message-State: AOAM532cBd36erZqIbzRE32JQJuBkq5wg8uoJEy7XhPgCV/xWS02R4Vu
 MCXclcG+v1OPr2OFwnGt0xFVdg==
X-Google-Smtp-Source: ABdhPJz8fvnnw8RlLkr9wLoROMXmX9ahGpPVVL8curGupYjnD/cCG5gAjx0Qt0fqUKhBN4l1blBdhw==
X-Received: by 2002:a6b:b447:: with SMTP id d68mr8124145iof.87.1616019037237; 
 Wed, 17 Mar 2021 15:10:37 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r3sm160700ilq.42.2021.03.17.15.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 15:10:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: joshi.k@samsung.com, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] block: add example ioctl
Date: Wed, 17 Mar 2021 16:10:25 -0600
Message-Id: <20210317221027.366780-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317221027.366780-1-axboe@kernel.dk>
References: <20210317221027.366780-1-axboe@kernel.dk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_221038_676176_146A49B3 
X-CRM114-Status: GOOD (  12.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Grab op == 1, BLOCK_URING_OP_IOCTL, and use it to implement basic
ioctl functionality.

Example code, to issue BLKBSZGET through IORING_OP_URING_CMD:

struct block_uring_cmd {
	__u32	ioctl_cmd;
	__u32	unused1;
	__u64	unused2[4];
};

static int get_bs(struct io_uring *ring, const char *dev)
{
	struct io_uring_cqe *cqe;
	struct io_uring_sqe *sqe;
        struct io_uring_cmd_sqe *csqe;
	struct block_uring_cmd *cmd;
	int ret, fd;

	fd = open(dev, O_RDONLY);

	sqe = io_uring_get_sqe(ring);
	csqe = (void *) sqe;
        memset(csqe, 0, sizeof(*csqe));
        csqe->hdr.opcode = IORING_OP_URING_CMD;
        csqe->hdr.fd = fd;
	csqe->user_data = 0x1234;
	csqe->op = BLOCK_URING_OP_IOCTL;

	io_uring_submit(ring);
	io_uring_wait_cqe(ring, &cqe);
	printf("bs=%d\n", cqe->res);
	io_uring_cqe_seen(ring, cqe);
	return 0;
err:
	return 1;
}

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c         | 20 ++++++++++++++++++++
 include/linux/blkdev.h | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index cbc403ad0330..9e44f63a0fe1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -318,11 +318,31 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
+static int blkdev_uring_ioctl(struct block_device *bdev,
+			      struct io_uring_cmd *cmd)
+{
+	struct block_uring_cmd *bcmd = (struct block_uring_cmd *) &cmd->pdu;
+
+	switch (bcmd->ioctl_cmd) {
+	case BLKBSZGET:
+		return block_size(bdev);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static int blkdev_uring_cmd(struct io_uring_cmd *cmd,
 			    enum io_uring_cmd_flags flags)
 {
 	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
 
+	switch (cmd->op) {
+	case BLOCK_URING_OP_IOCTL:
+		return blkdev_uring_ioctl(bdev, cmd);
+	default:
+		break;
+	}
+
 	return blk_uring_cmd(bdev, cmd, flags);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7eb993e82783..fa895aa3b51a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -44,6 +44,17 @@ struct blk_queue_stats;
 struct blk_stat_callback;
 struct blk_keyslot_manager;
 
+enum {
+	BLOCK_URING_OP_IOCTL = 1,
+};
+
+/* This overlays struct io_uring_cmd pdu (40 bytes) */
+struct block_uring_cmd {
+	__u32	ioctl_cmd;
+	__u32	unused1;
+	__u64	unused2[4];
+};
+
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
 
-- 
2.31.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
