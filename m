Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC37C7EE29
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tYonR6LNuZCooEmlmgTKMf28bl9/ZTlTCygYn5q1Cw=; b=ckgUjpThniGKuAUVjUDBRLezRa
	bZLlck0q/1OhkijV4Rgywzb2CmwpskxLI9cgcIdAtXeP9irVPHcC0lfVIgbCqYWsrd6jSPsOGm7eM
	apx+HM36K8cxGEboO6ymMcmyWzblR6C4Nz1K3Su6s445nbnyKCUEgIZ5+c9TblGzbVScVOTUSEfEa
	VSiUhw/I+zfmqKOSInhv1KmSTrUcytBMTLAK0V/BcmYoaCedclkR57up3MFJpc83WeU3PwBKr5sK4
	v6WV95jcbOYXQKlI3W3Zc9SyzzH5T0/fCBXUf0hI2WwJYkMOvU5N+3/3XHgJ4w7vd4GJ8CVFlDWvZ
	RruDE3CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3abA-00ACyb-1s;
	Mon, 29 May 2023 10:59:36 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3ab7-00ACxH-2R
	for linux-nvme@lists.infradead.org;
	Mon, 29 May 2023 10:59:35 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so2309056b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357972; x=1687949972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tYonR6LNuZCooEmlmgTKMf28bl9/ZTlTCygYn5q1Cw=;
        b=PSmEwZz643pnW8Xse8tY1hqnFmGInOC5b4zZrlmoZFPpZqkupjDpaW0LrQGo32BJdz
         D3swe/ZRiykdDI52GI9N2wuHsVJRr8A8/3hLLzaYua7xRDSzc7zHYUfFUxqSEQRDX6UP
         5lbDKZJXhwnj0sy6UezOo11WA4GLf/hZ/uCT+XTXMu3F24J2h5L+zc3Sq2BrXBsYldVs
         8uaIGxKQ9zgSj5Dld/rykhraq95m+PLW8Ucxs0Gu5MZ4JDcm9JAisnQxQmyc49Gszvio
         340nBpOxwIVEYY2nEEhhrjoM25k++YkFbTDzTWZXzbLjFRGRLb8P5f2EsRs+c+DivbMe
         4eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357972; x=1687949972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tYonR6LNuZCooEmlmgTKMf28bl9/ZTlTCygYn5q1Cw=;
        b=bKCQRJOmUMKuQRIU6TrDWc6ZMpY6kQFwOcJaC4Ns3JfEjQL9FWr1BWYpTvNcJucNuY
         g0QLoeFFDP+TOQ2l+Wq4P4Glysm7axi81QIIgBh0BY/v+a8QYI95alWKxCULsNgaz+3L
         kjA/gFDhmtPww6ZZ/ecCvzWGG9qwoVJprCw2yrNqSZNjphvBeR34z/LPm4xXuG5Tqe/f
         I4RJIsIhXMMzAbOw5S7bVU/um8ULGpD5TPotrsZXVsRogCiEuPq8bwxi1S3sWf7lEG3U
         /UzsRuqxp0O83AePuDMih7TsjtAHRmlWtRQiVARsDqB39Ytgngclwmu/Qk1WwFmwyDzf
         2FBQ==
X-Gm-Message-State: AC+VfDyTuRRUdjbnwcR/TuDukv1EnwiHH/6c0x+xggmSImkB5nxAiNiN
	dhIkAS4Yf6SWfEpEFpTBLiY=
X-Google-Smtp-Source: ACHHUZ4ygugDxsqcfbKWLBrVviCK5pvhu9JvUr44CQ8V7ogK9Db/5jSaRcvpGuwthUjh+dHPoY1zgg==
X-Received: by 2002:a05:6a20:12d6:b0:110:7edc:fb50 with SMTP id v22-20020a056a2012d600b001107edcfb50mr7535813pzg.9.1685357972097;
        Mon, 29 May 2023 03:59:32 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:31 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] nvme: unfreeze while exit from recovery or resetting
Date: Mon, 29 May 2023 18:59:23 +0800
Message-Id: <fd205548c8102ebbea3d09a7020b9b1fbc4beefb.1685350577.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_035933_792930_EFD06EF7 
X-CRM114-Status: GOOD (  13.61  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

Remove controller will interrupt err_work/connect_work, leave
controller at freezed and IO queues at quiescing. Then IOs
issued by scan_work will be blocked,  nvme_remove_namespaces()
will hang on fush scan_work. Try to fix that we should unfreeze
contrller and unquiescing IO queues while exit from
error_recovery or resetting.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..cfebcae7fc9b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2031,12 +2031,24 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
+static inline void nvme_ctrl_reconnect_exit(struct nvme_ctrl *ctrl)
+{
+	/* fast fail all pending requests */
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+
+	if (ctrl->queue_count > 1) {
+		nvme_unquiesce_io_queues(ctrl);
+		nvme_unfreeze(ctrl);
+	}
+}
+
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 {
 	/* If we are resetting/deleting then do nothing */
 	if (ctrl->state != NVME_CTRL_CONNECTING) {
 		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
 			ctrl->state == NVME_CTRL_LIVE);
+		nvme_ctrl_reconnect_exit(ctrl);
 		return;
 	}
 
@@ -2107,13 +2119,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 destroy_io:
-	if (ctrl->queue_count > 1) {
-		nvme_quiesce_io_queues(ctrl);
-		nvme_sync_io_queues(ctrl);
-		nvme_tcp_stop_io_queues(ctrl);
-		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
-	}
+	nvme_tcp_teardown_io_queues(ctrl, new);
 destroy_admin:
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
@@ -2166,6 +2172,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		/* state change failure is ok if we started ctrl delete */
 		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
 			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		nvme_ctrl_reconnect_exit(ctrl);
 		return;
 	}
 
@@ -2197,6 +2204,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		/* state change failure is ok if we started ctrl delete */
 		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
 			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		nvme_ctrl_reconnect_exit(ctrl);
 		return;
 	}
 
@@ -2213,7 +2221,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	flush_work(&to_tcp_ctrl(ctrl)->err_work);
-	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->connect_work);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
-- 
2.25.1


