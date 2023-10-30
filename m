Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA55C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZeP5LZNPVgCOVDKGuBqMoGJSW7piHcySROsgnm697W0=; b=P6EUkqCsl0GIp0zAgadY4OiVWs
	DFLMII1ClE2V0eXhb6Mvl9iD56nQBS/eV1K7/zwmVbbEd/wspKs7D2p7rOjG/2P7iqeLP7Qf3yh4f
	kLTm0weKEW+yKWx/CF5YdF4ev4Ojeu2rxUl5Tg9icw0u7+8zU4uQEXsgYRG7fGleqsxKqWJBZPR0u
	LNhuHHnoN5Z2FaLMCUanXdifmzeEjpj7ocdkI1WUeHq9vrl/Tm7j/ridpsU3KipFQJl5SrQngTt2B
	KLLuzJxrK3AidcGNCpnEW/vkNTJ/cGJgYbDunQ0o7la0Vl+bjd+UTZnIioNsx/oaWEzj8RiAv02Hq
	VA9jGOMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxUfe-003aru-35;
	Mon, 30 Oct 2023 15:59:18 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxUfb-003arI-2v
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 15:59:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B1DA210E7;
	Mon, 30 Oct 2023 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698681552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZeP5LZNPVgCOVDKGuBqMoGJSW7piHcySROsgnm697W0=;
	b=J44VmEqcZrDXMGx1wOc89obvtxfjsdVZFguVq7pP3N+MPb0pe0B/voCzU/h48z6UYLdqAd
	JrrwBBdSJ51wGxjcU52tTozeIPOTIeYO6K83LJsE13UrBkjW7gzzBTIHZuleo5PHBsWSPr
	mc4LXuvDuRtO7cv1vo31gEo+5jM37Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698681552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZeP5LZNPVgCOVDKGuBqMoGJSW7piHcySROsgnm697W0=;
	b=YL7UvprAyY6BY8MIOhFh0wB9Pj1IPK/1X6jXBIm7IGrFc6sByhq8KnPHL77tJtfMmX9QmM
	b2DtEclQYbF7nDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D9F3138EF;
	Mon, 30 Oct 2023 15:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HV0FD9DSP2WufAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 30 Oct 2023 15:59:12 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Daniel Wagner <dwagner@suse.de>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: [PATCH v3] nvme: update firmware version after commit
Date: Mon, 30 Oct 2023 17:00:44 +0100
Message-ID: <20231030160044.20355-1-dwagner@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_085916_086757_D5DB3162 
X-CRM114-Status: GOOD (  11.54  )
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

The firmware version sysfs entry needs to be updated after a successfully
firmware activation.

nvme-cli stopped issuing an Identify Controller command to list the
current firmware information and relies on sysfs showing the current
firmware version.

Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

Only compile tested. Asked for testing.

changes:

v3:
  - use afi variable directly, no _to_cpu helper
  - fix bit mask size

v2:
  - use fw slot info instead issuing another identify controller command
  - https://lore.kernel.org/linux-nvme/20231013163420.3097-1-dwagner@suse.de

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20231013062623.6745-1-dwagner@suse.de/


 drivers/nvme/host/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa746662..e8511bff78d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4053,8 +4053,21 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 		return;
 
 	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
-			log, sizeof(*log), 0))
+			 log, sizeof(*log), 0)) {
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
+		goto out_free_log;
+	}
+
+	if (log->afi & 0x70) {
+		dev_info(ctrl->device,
+			 "Firmware is activated after next Controller Level Reset\n");
+		goto out_free_log;
+	}
+
+	memcpy(ctrl->subsys->firmware_rev, &log->frs[log->afi & 0x7],
+		sizeof(ctrl->subsys->firmware_rev));
+
+out_free_log:
 	kfree(log);
 }
 
-- 
2.42.0


