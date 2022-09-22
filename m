Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F8AC6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vv5UjI3j5kTfHmUCKB5yDvliynUd62BQclXmsb+HwEU=; b=E6lr3k4dNymkryA5hWCe2JnADH
	3d+yDum8P4NO/Mu4oEYN7Kdqmy3G2edfqcfolbQk8enzMs33wk6HKLSQKpVsXSEmV40Ocp0Qxu0dP
	f3JEAHCVjV/3wNQXVdC7vS7RjBj17KzBQ6uFtuIl79qbaF6Sl9q80CU+9lhRXCJou0NusEzBz7tDa
	0HO7+oF/CiwWm/ec2f7UpL85e1SFVplmiZOt4tmYicUD+RdikDD0ybAoNOZD1Bn4zv3bY6Y3xOGAQ
	Jw65O0dk4v7KIXlaCOsC3NR6qn92/V/IAw0O3h0/qsfC2XRbTQ4wmvsHNP3eSWSAlYIuq/LQG9Vju
	vWRdAtvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHNM-00E4NZ-9t; Thu, 22 Sep 2022 08:16:04 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHN5-00E4Cp-NF
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:15:49 +0000
Received: by mail-wr1-f46.google.com with SMTP id n15so7302256wrq.5
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 01:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Vv5UjI3j5kTfHmUCKB5yDvliynUd62BQclXmsb+HwEU=;
        b=uO9zcmPFBhvElzP/vfy5OCRUJ95vx28GnNwCXm+hWHFnnWaRxaQlwrmbwGjAY12EWy
         LrJWPKmxjuIJgmaVwGUsBSEaUJnVyMDZFSKwWLifdZXMp0kMuO024+8URsWSzxDFT6Yu
         XNFq7Ivcy0InhN+2xvG2atzoXuYWCl+ZaDwjcRGNWtk7zok6r4C/bE7AX6/vPsQm1n6f
         0d2LGMM6t0n7VMw0wnfvRCWyf4c8yocZ3BeKd1F1kBYaqBn1aBtXqy4kWDTP0PomtCo5
         2ittY7ASVOS+p4lcylXOwGVbnnBTTS7b2Nnxe1q3RWLX+soxfk+bq89asmr+7FT+cNf0
         thow==
X-Gm-Message-State: ACrzQf1Dyq0tzAhlMQA/+ZtNGvfDAi9GbI9pB7X+cFqbyUSKeWafBzQw
	uM/ow9Y+yHY+mqvDAVVGeW+WJPfNPh0=
X-Google-Smtp-Source: AMsMyM5KZ19EqEQgl+8yZcOndybwpRRPsZ+on7N61B0qrp3gjCBRf19YbXeXXSvHskAgwzK/yCMxGw==
X-Received: by 2002:a5d:64e4:0:b0:22a:4997:c13c with SMTP id g4-20020a5d64e4000000b0022a4997c13cmr1222495wri.621.1663834543398;
        Thu, 22 Sep 2022 01:15:43 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t126-20020a1c4684000000b003b32aa0fabcsm5016997wma.4.2022.09.22.01.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:15:42 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 2/2] nvme: send a rediscover uevent when a persistent discovery controller reconnects
Date: Thu, 22 Sep 2022 11:15:37 +0300
Message-Id: <20220922081538.13364-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922081538.13364-1-sagi@grimberg.me>
References: <20220922081538.13364-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_011547_807221_F2F93D17 
X-CRM114-Status: GOOD (  16.80  )
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

When a discovery controller is disconnected, no AENs will arrive to
notify the host about discovery log change events.

In order to solve this, send a uevent notification when a
persistent discovery controller reconnects. We add a new ctrl
flag NVME_CTRL_STARTED_ONCE that will be set on the first
start, and consecutive calls will find it set, and send the
event to userspace if the controller is a discovery controller.

Upon the event reception, userspace will re-read the discovery
log page and will act upon changes as it sees fit.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 70ebf27ad10e..07a21e0b9cf7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4822,6 +4822,16 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 
 	nvme_enable_aen(ctrl);
 
+	/*
+	 * persistent discovery controllers need to send indication to userspace
+	 * to re-read the discovery log page to learn about possible changes
+	 * that were missed. We identify persistent discovery controllers by
+	 * checking that they started once before, hence are reconnecting back.
+	 */
+	if (test_and_set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
+	    nvme_discovery_ctrl(ctrl))
+		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
+
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fcf891467e68..2d5d44a73f26 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -236,6 +236,7 @@ struct nvme_fault_inject {
 enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= (1 << 0),
 	NVME_CTRL_ADMIN_Q_STOPPED	= (1 << 1),
+	NVME_CTRL_STARTED_ONCE		= (1 << 2),
 };
 
 struct nvme_ctrl {
-- 
2.34.1


