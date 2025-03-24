Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B95FC36008
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zI9pTE09SEnCUUwuhvk6jLvhp0JjIoGziaSbN4eddKE=; b=ECIJu06iXneemWESKexc+BMCfr
	RK9DvAVFXh+2rYRnaBBgvvk7doZjb4OfjOgcxY70f/30ZqGscF2XpKK31Ge1O90GCo+ZHpxBkDxeI
	NrMmPG/qkKJPKHsYfE+/qUvQEuiwnXtrUd8U+RMrydvGTNE0At1XytV0dCRNgIiSYHCUXy+hyB61b
	blXCGkReXZHFj/9XkXwaxVtvOszsrvxFHh/mLDwi5qzpLeYBdFMJ/Wk5EjbkSodTUCYebUo8f8/Um
	DpxWjggqSQSzIYpHwqXu4dFXDSg3aU+goTVqc2nOqAITlkaVxZ/JedRpX2nhRz60meeEEoN5XuIrI
	0X0JSpcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvi-00000003rO9-3XOL;
	Mon, 24 Mar 2025 17:49:42 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvf-00000003rJy-2zIK
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:40 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3014ae35534so7276560a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838579; x=1743443379; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI9pTE09SEnCUUwuhvk6jLvhp0JjIoGziaSbN4eddKE=;
        b=GAX+zpRfL1mytq3Ez0jdr7ZVld1yApgBv5Uen1yhRLSeSGSMXM23sLH1x/tIfivR4a
         L57qjIPreThYx7tIubqW5EdaKpkjnn18fh+lq5sSkLcI5Qf3R/4HfDx8p/PjASjyCCWK
         k/x/KASk48hQtQQnz/wwdfAfnCmCo3MrOtcOFYhrLnwFlzLJ9qEE7Okl43l+8OI+lJXt
         YYwrnhfakP5sj5+CVIC7NtbFnH0tMeiW8yqN9dCuzwdXAy0MBWg3yMD9/tqqWmrkavFy
         1ZeFbZY344CicrFSLjmLtC6pszmCS8l0V5TgfLxPoAIBYCAw+Gt1D23Y1A6REBtZfnLN
         H2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838579; x=1743443379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI9pTE09SEnCUUwuhvk6jLvhp0JjIoGziaSbN4eddKE=;
        b=mGYHZHXq8m6m6tbaDxgeBqDLuy7GSJ8mN1iiKvglCjxhpm2lhavgjJD3vtD3vclCaO
         F2VE3iYd4BMXngRGXSv4D3yE8Sq7bFMOi1J3XJ/cm5flStshbdhAGEeOaBofC2tFuVAB
         kV+/p0U/mPfoo346GKE3ROTu0CNV8/9fbGEDJpf/hlandNlm5xVDNP7GOoC5ZH5KrS7V
         6tY+3s8gyjp7PtcT1lcwdETi+g8hKR6tesyTng35FSw0BUV2zCHXCk4yZzMnD+8ZcpEI
         NXpCkHqRF9oXQam4U46smnWb0WeaYT/BLk4Inktm+6mLH37L4nIiHRqGzwKlzYKlDVBy
         zGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJB2GIs8TEhdsv9nmB9mfyw7Hmp/PYeZN4F63y0DpRwDL6aA0iaRYBlv9QjCoJVS/MHCkVhy53Xeuo@lists.infradead.org
X-Gm-Message-State: AOJu0YzMInKPfY8BPJy95rWga7iSL5fPVcBnQrC85BA7KdYTjyh1dxQI
	QksjQdNmKmGFalC8N3f2FmcwkVBSDA8Arl2p8GLW+vtHQ6MjeX0qX0TEqiBPs/c=
X-Gm-Gg: ASbGncvUzmHeVhiUndhYy6WvwA8DiQaPyXBokdktGnoZvgKvmauhazt460HpbVoOM6C
	W28dUqy8dsp4fjte7O2B38uzeyCh1uXNANk1E6PAZL8xD24yMJoENioOHfaSrDr4zndPJy+5oq7
	oEz42ESIer532NFgaDRGheJCgGcWcP+p2byQgyIvqnFrYfD9Sco2zTGDqfbJQd9fsflFinX5Ke1
	gMNOh8Y8mSdaITzAk81W2swvY4dEMmpi2m62FLoKfxKyDvf8EXdZqW2spAfr832gRN11C0vnrsM
	QhFTdLH8h0y7E4wTASPHRcGIxfZzSR7QqiJNWGKWhJBiw938/FE=
X-Google-Smtp-Source: AGHT+IEizjkumELeU6R9jqpR3Ax4p0YRM++REqcaqTU4nNn7wsmzFTI5FqCg8QkO6jKcVZ9UpRwPhQ==
X-Received: by 2002:a17:90b:5408:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-3030ff10972mr18601100a91.27.1742838578680;
        Mon, 24 Mar 2025 10:49:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:38 -0700 (PDT)
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
Subject: [RFC PATCH v1 5/7] nvme-tcp: Split nvme_tcp_teardown_io_queues() into two functions
Date: Mon, 24 Mar 2025 10:48:58 -0700
Message-ID: <20250324174909.3919131-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104939_769333_DE7606C9 
X-CRM114-Status: GOOD (  12.00  )
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

Move code that quiesces IO queues out of nvme_tcp_teardown_io_queues() in
a new function nvme_tcp_suspend_io_queues(). In a later change this
allows us to disable nvme controller without needing to tear down IO
queues and canceling inflight requests.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 99533ff1ea20..327e37a25281 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2266,12 +2266,18 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
 	}
 }
 
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_suspend_io_queues(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
+}
+
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->queue_count <= 1)
+		return;
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
 	nvme_tcp_free_io_queues(ctrl);
@@ -2411,6 +2417,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
+	nvme_tcp_suspend_io_queues(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
@@ -2432,6 +2439,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
+	nvme_tcp_suspend_io_queues(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
-- 
2.48.1


