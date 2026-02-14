Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B432EDF15A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+voUH76g/Pq9YBKjG67uJM4aaUaY9JLa+bj+ayVk72U=; b=gI1TznomBAPiQU40xiJmmgiP+I
	tJ9ITbgYpHm+bHv1Y1OtSlP9nYTaWcq7qR5Ub1xAdZFK0msiIgONqsxwvt9hQN7ut7JgZt8EzbInw
	Ll1wbjsWWaM8V5VMg9qg5MMPmQVb+hQ2Js5HAz1SFYMR7wlpY2GirjuyoKbrvDUxQOfZXEzk/l8Gx
	uM7wIjGWoiKUkE3+HVSviwuEj7cqIz2Xzv8RRghwUhxDFJCmSu+NcNuWgqygMrBncXK0O3uN/PLTS
	wuVTsa8z/rUeMlW78u1Mr0XhAIp2Y+OrxV4vBMroJNl+WSqq1y05WvpJ4DACyYfMuTwwodVRtqrZN
	bgR5LzrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Ge-00000004EyV-1SYm;
	Sat, 14 Feb 2026 04:28:28 +0000
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7GZ-00000004EvF-2huy
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:24 +0000
Received: by mail-dl1-x1242.google.com with SMTP id a92af1059eb24-1270be4d125so3698150c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043303; x=1771648103; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+voUH76g/Pq9YBKjG67uJM4aaUaY9JLa+bj+ayVk72U=;
        b=cHAGWGq1VO+PeJXt5eoQtrOA8dkjIAeadxh4JOKbJq1rXRDS915HDrpCK91UInW4H5
         YxA2xjfVbTeVcsC5y7J8sNq7CJb8241RNXLVtV+/RlkEYe5zmdUt+xkFtBPSu0agLBp7
         AsjTqcVj/lUwhZgm6s3Z0gAtzzib4rTq+iOz+ufMMP7bUjb4pYiouq57iP+pfibhMsXi
         SXnwSoD63aNhed5hwFvzjPuDc+pVmkvCBHxJs66H7rkDtMZttbiLGDFQJYIbWtSkjYDd
         HmOb7KzFFL3hz0kwTw+fjvePXvFZrtA84cXDcrgjDsxNOlVoH7/eyQDh0cEfYaYU4fEv
         GVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043303; x=1771648103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+voUH76g/Pq9YBKjG67uJM4aaUaY9JLa+bj+ayVk72U=;
        b=o/lZoSJ4Nvqfi5wYJE0uRE/HkCZFzK2useZGcTiB+exwq/PhC0zbYeY9lXKcJJQTdB
         gikHddvwXRkGlpDHdCcZzxCQ2K8Mp3b5+qOl57YGgOaUcTq9jq8vqN831m8BqWzTK0Ln
         7hSI5seqc01BOvSCuLZs2qTfeKTUGDS7oeDR3r1rTnLNIlwrd5pmgFxjde2lRB/0dF1S
         SmHUMiFjiN5uUh4RUGas/yMmL5Zj7gPPeCbmbJdgH2yZVQsOgBSjOZjAf+7af8cO56MH
         82jxMK7ahc4wrEvQseCHJy7hgcGv5K6legSaBK4WXBHaZsUJyO6tSrB/3Ly/Xqy8xQIi
         /tag==
X-Forwarded-Encrypted: i=1; AJvYcCWTDElkqXpLqhrOB2h/Gp76OZfOC1w/kB7TE/AeURKRd6uWlbdjG1Ltocwh/GoDgfL+W8pfFwLJobWz@lists.infradead.org
X-Gm-Message-State: AOJu0YxdvXCceBgON0VkYZ+bbmGchOr4tWebtKctvHQfiN40bth0RAv6
	C/M4B5YEKA8filtRR0OfWSljDZ8GcqWyrwHJ1CJjYICtHfbjUO5KYqD3HdwSl+j09oI=
X-Gm-Gg: AZuq6aIRy1/bq7RqDFM04b4uHwQ563DWD57G5lTPS2coOJT8dtCmDd2bcDHFu05o3Gy
	tdEoCO36RRJxm8lx9P3awndV8NfgCans9uNi2bwHW4qLTQit2jxpw8RO6gJ8QnDgxp04+pbTeCw
	BXYT5d0fHSPIcRAxBTS8m8moX7DpEb5qhUCoNX6u/444LlFO3q4cUkLNTb7rA2JiHSRb/SkDS+p
	ZzEFlNdlplQsyzcOAefQ2SYdzJw/S26Xyzhfk2EUqnJ54+h+WnBoMBRBialLFC6xO8e0WIe9Xtu
	+QxKQCWgbeVRRkUrO222vqVIhAVBEOyHjqSlg4cor9YBA7vlKxH27/jrMU34MmIGHO2ATndIEMY
	djSu+jhyX+OMLUoyWqM+QGphPMyb0mujaM7n03+xrFfvxVBNGbmBlr+OgL6G8UryvzV2fSbOUqx
	Ne4mrswijYDNyAZPnEjRfuN2aQduEW6XWMG2qVvxAEcRb88w==
X-Received: by 2002:a05:7022:439b:b0:11b:9386:a3c3 with SMTP id a92af1059eb24-12741bea9e8mr875209c88.46.1771043302619;
        Fri, 13 Feb 2026 20:28:22 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:22 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 02/21] nvmet/debugfs: Export controller CIU and CIRN via debugfs
Date: Fri, 13 Feb 2026 20:25:03 -0800
Message-ID: <20260214042753.4073668-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202823_682077_DA5BA3F3 
X-CRM114-Status: GOOD (  10.50  )
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

Export ctrl->ciu and ctrl->cirn as debugfs files under controller
debugfs directory.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/debugfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 5dcbd5aa86e1..1300adf6c1fb 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -152,6 +152,23 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 }
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
+static int nvmet_ctrl_instance_ciu_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%02x\n", ctrl->ciu);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_ciu);
+
+static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%016llx\n", ctrl->cirn);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);
 
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
@@ -184,6 +201,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 	debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_tls_key_fops);
 #endif
+	debugfs_create_file("ciu", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_ciu_fops);
+	debugfs_create_file("cirn", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_cirn_fops);
 	return 0;
 }
 
-- 
2.52.0


