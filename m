Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD14C77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KyzO4zzg3fbvkoe5Py8PgbHJHxsStxtqkj+qewtTEyc=; b=W7Kx1ci0NXU6xJpHZd53uoXBXi
	lHz6TjvsbYJri0x+O/drHqQlx622rnbQGz62SJTtMv9WI3CIG7PsyN2ncJzGxun8m4K8YxEpt3kS/
	w+OnOaxz/Wui+VUN21Tn4uH2kR05vCGTwJjysIZqlBYEZmwJUxF8sFH+X7orPMYdJ/HMLXj0uVPkr
	ubu9jX+/tvlSvkHR1TKjJrnoDBONgwokQB9MkfS0hJct04fJV7L39FJjt1KMJOyhk7AkvGrA4WOmX
	l/D2AeazfdwDgWvsPR/b1EPAqPmQWWe9ATROyt8TEhEF5nVFIj5TGbK0VE0mmeS7SpRPogD9VRbyo
	1YJT1YGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pppEK-00AmIE-2S;
	Fri, 21 Apr 2023 11:47:08 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pppEC-00AmCm-2I
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 11:47:02 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-2f6401ce8f8so1016092f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Apr 2023 04:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682077619; x=1684669619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyzO4zzg3fbvkoe5Py8PgbHJHxsStxtqkj+qewtTEyc=;
        b=X2Fa4CpPx/uptZjyz1i+/IfmgCEiS2kAEl4pn1k2E3iH1zFpItwAblz9pdn/hCQX5p
         MHLmhazMzg6i26+x0flsV7OyV9dL3JGfm6dbrgzxlqGn0XuV25pF3pLy+VQTn2Kg1ehs
         avKxauc45VrKIP6aSpk+6InwhqrxMk3eXxm/Pq1ooEJz/dF2c7JVWwAMXDkDTpZ5qvAo
         u3Rsn2DQhB63XhdavQX97LlwVgAqTocUZLlHUydnWVqwA5GJnmySTBY7+eWjUILgJ4Vt
         ait7mH3a7z2V93pFZbEUvr+VRUJisYvElwYk/VIEys1RoS19eKPB3/gwAUqPcJGHKIdM
         2F9w==
X-Gm-Message-State: AAQBX9dtN3Tg8o468RNngyqRHVgvjDMA86fpRei/EkQIuj8SiKoo1QPU
	GSy+g2KApVkSut3P68ePlhc=
X-Google-Smtp-Source: AKy350bQy/d5cllAu41FyjxA49IDgFPvGdIXlivDwHh6nTQZvGv8ppizRoQul+g2+v4oeP92qA5o7g==
X-Received: by 2002:a5d:4f81:0:b0:2fe:c0ea:18b4 with SMTP id d1-20020a5d4f81000000b002fec0ea18b4mr3916354wru.24.1682077618931;
        Fri, 21 Apr 2023 04:46:58 -0700 (PDT)
Received: from localhost (fwdproxy-cln-031.fbsv.net. [2a03:2880:31ff:1f::face:b00c])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b003f17eded97bsm8075706wms.19.2023.04.21.04.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 04:46:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	axboe@kernel.dk
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	ming.lei@redhat.com
Subject: [PATCH v2 3/3] io_uring: Remove unnecessary BUILD_BUG_ON
Date: Fri, 21 Apr 2023 04:44:40 -0700
Message-Id: <20230421114440.3343473-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421114440.3343473-1-leitao@debian.org>
References: <20230421114440.3343473-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_044700_897533_F1D2E83F 
X-CRM114-Status: GOOD (  12.48  )
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

In the io_uring_cmd_prep_async() there is a unnecessary compilation time
check to check if cmd is correctly placed at field 48 of the SQE.

This is uncessary, since this check is already in place at
io_uring_init():

          BUILD_BUG_SQE_ELEM(48, __u64,  addr3);

Remove it and the uring_cmd_pdu_size() function, which is not used
anymore.

Keith started a discussion about this topic in the following thread:
https://lore.kernel.org/lkml/ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 io_uring/uring_cmd.c | 3 ---
 io_uring/uring_cmd.h | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index a1be746cd009..743d1496431b 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -71,9 +71,6 @@ int io_uring_cmd_prep_async(struct io_kiocb *req)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	size_t size = uring_sqe_size(req->ctx);
 
-	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
-	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
-
 	memcpy(req->async_data, ioucmd->sqe, size);
 	ioucmd->sqe = req->async_data;
 	return 0;
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index 7c6697d13cb2..8117684ec3ca 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -3,11 +3,3 @@
 int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_uring_cmd_prep_async(struct io_kiocb *req);
-
-/*
- * The URING_CMD payload starts at 'cmd' in the first sqe, and continues into
- * the following sqe if SQE128 is used.
- */
-#define uring_cmd_pdu_size(is_sqe128)				\
-	((1 + !!(is_sqe128)) * sizeof(struct io_uring_sqe) -	\
-		offsetof(struct io_uring_sqe, cmd))
-- 
2.34.1


