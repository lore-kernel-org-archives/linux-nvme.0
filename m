Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAC1C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:11:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3405564F18
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3405564F18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qkRHL1ukxLHVXpJaHBdtH6eqMTdaip4vPvXFWob1OuY=; b=mKtxt6Ofw/THn2pWFI57bw6g0
	ka4HVEeDII0kFxuItwemCH9r79hWpsvnN9C3z/+s+fqx6Ti/R268MEdFoYaz+U0w06H8Ew4POgfS5
	hJKwZTdB5dcuNClBpmitjKHKYE7u6i+iadGJPDCWBaqnyzld9JgTm40U0gdibzfaz+ZOjXV9xapW1
	NThU53xJYQ6NG8777TlY62FOO93H3Y3WNkuPG6UTtQwbusyz0shJGtZs2evP1IkMnFeO8g4vSLP65
	vYpTwU2Mkgr0bVyTImxcb8NShntICwEB9BPVdEIZ/rb9kWFUGeqKQOWILVUMYw55p2mbPlm7q+Z97
	JBUHWHfTg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeNb-00406n-KC; Wed, 17 Mar 2021 22:11:03 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeN9-00402K-RD
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:10:37 +0000
Received: by mail-il1-x12c.google.com with SMTP id r8so3022913ilo.8
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KXdzUFLUCDHdfDsIznvuoA0uu3nl8FyVDRpspxY/atM=;
 b=bavdqq7XIp3pvZBn+YGZ+l1AbkOZRJEEntcltWtut2UyLeOPfi0w6q2ExCTse7hO7I
 Uf7ga26zRUjvYYX+BKtNT8xq5mF0zsZHKlip48MKpUGDOtwhj4Q9ZBzVNJoR/EJA9Wqo
 GUW+UyN3tr4Rkbx5cJ6f5+WaLnBxPKRo1LPNSSj9Ml1BkGJ+bfMduCPR2tnW87pQSr34
 pBjCkxsOu2AOGvWI//vVKLG8tEVRToSmtJ1yyZaivic+CPLWK14h9gsmpjPfwq9EwXd/
 9lCRMR3oRJyP5ZPibUzsUHHlvN8jnHi/2RosIcQfZKIbjLAwZyA/5grxUCM0fpzBmBBF
 p62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KXdzUFLUCDHdfDsIznvuoA0uu3nl8FyVDRpspxY/atM=;
 b=Kuqbi1aJs/jMtd3ZHxc58SSYciuhKORd+BZM44vjOAM2nJy9mVjZU0PHaCpNjxWVAd
 ad7gk54nW9QoSAf76L/9IP1vw9/M19bwBWWFkWtQW1Pd+tag+5xnF6frxioikBkCBjmL
 k/du+nQevp8F6hKfecdBjAznJLnZdTems0bCaGSRkDj+Nnp37QpbxTeq10auSDOLEf4a
 JMMoY+DVeL/DVZzDntN6GRuUlIZiiy+Yhyi0dfbR1KVFywqXp7dzctDXJwW5+LBOqQqy
 c8oF1Xdu9D+UHLnSSfH9Pn5LgnYGHj5a6ygTuHnBailE28rDxt5TYuf5UXyxAYO0oxvF
 GhNw==
X-Gm-Message-State: AOAM533US211zifC028TzNbQ6WPc37bsEVbEK/CjcKbiwCCBJHzF+CdS
 Eo5+rpXe/ls7FFN7YlBTYv1kmQ==
X-Google-Smtp-Source: ABdhPJxVzW0VPqqNQcW5cqznbA86x9///BL+YHxNMkwD/g26zMUYALWyNB/jFbw5bvCzR2mMn2fDEQ==
X-Received: by 2002:a92:6f0b:: with SMTP id k11mr9346052ilc.53.1616019034619; 
 Wed, 17 Mar 2021 15:10:34 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r3sm160700ilq.42.2021.03.17.15.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 15:10:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: joshi.k@samsung.com, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] fs: add file_operations->uring_cmd()
Date: Wed, 17 Mar 2021 16:10:22 -0600
Message-Id: <20210317221027.366780-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317221027.366780-1-axboe@kernel.dk>
References: <20210317221027.366780-1-axboe@kernel.dk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_221036_020238_1869810D 
X-CRM114-Status: GOOD (  11.36  )
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

This is a file private handler, similar to ioctls but hopefully a lot
more sane and useful.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c      |  5 -----
 include/linux/fs.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a4699b066172..fecf10e0625f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -188,11 +188,6 @@ struct io_rings {
 	struct io_uring_cqe	cqes[] ____cacheline_aligned_in_smp;
 };
 
-enum io_uring_cmd_flags {
-	IO_URING_F_NONBLOCK		= 1,
-	IO_URING_F_COMPLETE_DEFER	= 2,
-};
-
 struct io_mapped_ubuf {
 	u64		ubuf;
 	size_t		len;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..009abc668987 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1884,6 +1884,15 @@ struct dir_context {
 #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
 
 struct iov_iter;
+struct io_uring_cmd;
+
+/*
+ * f_op->uring_cmd() issue flags
+ */
+enum io_uring_cmd_flags {
+	IO_URING_F_NONBLOCK		= 1,
+	IO_URING_F_COMPLETE_DEFER	= 2,
+};
 
 struct file_operations {
 	struct module *owner;
@@ -1925,6 +1934,8 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+
+	int (*uring_cmd)(struct io_uring_cmd *, enum io_uring_cmd_flags);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.31.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
