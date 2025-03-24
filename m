Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC57AC36008
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbKikyrkuQKAbVcAqWwtL5MxvKjcnNKUJ4bcGpnldxg=; b=xzscyAIUFefOntigFKkzgXdrB/
	GR3dHiKZkXxjR0SQGq/btf1kl3/LTMXbofrf8z188M5MZm4dmFUZ1nWmkVStQy5vRTbHTyuC7J/6e
	/uzGQydtAO8oicvfURyAXF/PG+H506UvNnIPYQl6nrOSLFKr8i8PYKuNyVICdmMfHlhyuDRMVkOfo
	yzQepa/wIE5QaFKqfE7wkCvsyP+ZBaMjQDpFmHphorYvRweVEvvFi7EyMAJQeD297nWZLOd3beDYu
	13QY2gHC1XhNGqu3p/pXqDdWMBgeRnUjyonnSV5jxCOv9jsClACSv/VCbgtq0eEWEzhtIj2nyYAqs
	ze/wJzSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvf-00000003rJr-0vfq;
	Mon, 24 Mar 2025 17:49:39 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvc-00000003rH7-2r4n
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:37 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-301493f461eso5648614a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838576; x=1743443376; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbKikyrkuQKAbVcAqWwtL5MxvKjcnNKUJ4bcGpnldxg=;
        b=RFMnnCSRuIqlYkIWyDlE37wv8fJWOF+Gj0JMefWkvy+xpHqeTw9mGJR1Qfiwhb55Ls
         7juTlnK7vC9FzQ1y9J3rsn4QcqwWhIYmh4gsH5fucbiFprDvG9RQcVU075/Twgy017GX
         SVYKihZoA88+XQ61y6sIN4boCdHiRA8BUCgToRiNUmY9Z//qmbfredii/32VTq0z3AK6
         dkRHV/2TSawapdSurRsWZcqKAFs4NCA8wNNpSPdTEEsrKI/C7qAZcl9Kl4VFhV5P8ErD
         /QVSSk23HiUkex22eAHB1muLbpy11Pe8EY66wNMkHi4C9cD+03N/ku7v4pIK6qfj9d9m
         cU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838576; x=1743443376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbKikyrkuQKAbVcAqWwtL5MxvKjcnNKUJ4bcGpnldxg=;
        b=lMn8uB49c/qr85X0zTFwR9CtNf2pThp2badQs/FaRKDcKAFuvDM5nK5mtd9feZLG5s
         9mPl6ngV7CbGRiJQ9sUeQlRSPGC7UkjV+biun67HOWsdTJ2ET0+cqvzSgk7/022wltnl
         HCW0yQrA6FKrUks3GIuJLEBvM6V3GhHT+tHDBLcwX/+d+4AwvKXmTX3y/r8LpF+o5uDh
         WfXM1D7LPsuHH4QqlAruQEp5EbEFemr14ajdcUlVpwyxaIE+4DkEBDYwfH7jPe7I9n5s
         U94AF1qrAoCfHdt4CcqTlgXa7qrZG2V8gwPWNKnLiK+bH0cxO1bn7atagppnvRbL7X4y
         tL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+N1FKS3e23q/iNn+SA9kmSwJPuBmDKSaWluPoT60TOfmZc4jZkeqK6mXT4Fi/MEMzJWqZSjzKRV51@lists.infradead.org
X-Gm-Message-State: AOJu0YzsZnxAHIAA5wNd/kYHEGf5DSafQfPa/grwUmn45fY1rFUTb37I
	LMrYHp/k/YlIzCx7C56cp5yKxckLl9CHQozKaaU/CwmEpcbkG6F7ZqISIzI/cWI=
X-Gm-Gg: ASbGncunRy5DC2d221kRIyR/HtRDTaEKB8VhAAi2zDPmjpLzz9EHZppTjRSxMcQJ3S3
	/1hjFNW+ieCmaEPoMtbS2O/EMrtUXK2ndlfGPH25AmevqYv1AX6UKg+TM049YeyiaasQ2D02eCN
	yjFzTHRMAfvauR56KInSyy3LzhZKfuah0qZqb5ctg4q9fprG8zRP2nKH80WNVitSYW5Z+HOG2UF
	aqG7bBTc8mGpTdIvY5+jDfaA3vEUpQC3yLAF0+vEcHJwC/KQrgWgmwQZIQP/pm4JnS9+a3uNB1n
	BybZPv/LJBSPEcIiHTbodkwdlakqrTchscLs6O/2qn4ld1qrnLI=
X-Google-Smtp-Source: AGHT+IEa1vT6cpVDLe0ags7PxHVLo5gJ1K8CS9xAHU/xWCcEk9aWqc+j3Ou83FOXQmtPg3nh0oY0xQ==
X-Received: by 2002:a17:90b:54c7:b0:2fe:dd2c:f8e7 with SMTP id 98e67ed59e1d1-3030fe94fe8mr22634637a91.10.1742838575561;
        Mon, 24 Mar 2025 10:49:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:35 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 3/7] nvme-tcp: Move freeing tagset out of nvme_tcp_teardown_io_queues()
Date: Mon, 24 Mar 2025 10:48:56 -0700
Message-ID: <20250324174909.3919131-4-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104936_717869_BA40C2ED 
X-CRM114-Status: GOOD (  12.45  )
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

Update nvme_tcp_teardown_io_queues() to only tear down IO queues.
Let the caller take care of freeing the tagset if needed. This change
prepares the code to inject the delay described in TP4129 after IO
queues are tron down and before IO tagset is freed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..d12b51ed1a9e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,8 +2271,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	}
 }
 
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-		bool remove)
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->queue_count <= 1)
 		return;
@@ -2280,10 +2279,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
-	if (remove) {
-		nvme_unquiesce_io_queues(ctrl);
-		nvme_remove_io_tag_set(ctrl);
-	}
 	nvme_tcp_free_io_queues(ctrl);
 }
 
@@ -2417,7 +2412,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
-	nvme_tcp_teardown_io_queues(ctrl, false);
+	nvme_tcp_teardown_io_queues(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
@@ -2438,7 +2433,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	nvme_tcp_teardown_io_queues(ctrl, shutdown);
+	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
@@ -2447,6 +2442,10 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_tcp_teardown_ctrl(ctrl, true);
+	if (ctrl->queue_count > 1) {
+		nvme_unquiesce_io_queues(ctrl);
+		nvme_remove_io_tag_set(ctrl);
+	}
 }
 
 static void nvme_reset_ctrl_work(struct work_struct *work)
-- 
2.48.1


