Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D082CDB483
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xjo9Xl3dXS4rFlLLnUY7vOZqEKJrLj4p7tYgG9NZ6xs=; b=fljFgf5DbbvVygCPDD+7yyrjRC
	rQWse2AybnjMcnFAq8Bi/v5lUz1ACVHsCOKLt171F9aPuodUIB3Nr02psBvb4Rh8fKH617H4DErAh
	aYp1mSBjjUBZxoO4AiA+z+x3VFctGR4xzF5mzlenKN7Wy1r5iy19PGQhO5XiMNh6VuVt0axII0UiE
	fGVL94/lMYQngnQ2PEFEqwVABcESXSaXC42pEISs7w/i5zvS/ASD8ew9Csj4T6Y0yQ3ur7/bjOUce
	OFhLPLX5AzfS8Hk+faHBDzOuTQ9QCBrLuCenjY3hsYAjir0V/ceweKQShfkM7BwOqZv+PjXZudTUa
	Q7gCcV0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrL6A-003sVB-0K;
	Fri, 13 Oct 2023 16:33:14 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrL66-003sU7-1W
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 16:33:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01D0F21A1E;
	Fri, 13 Oct 2023 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697214789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xjo9Xl3dXS4rFlLLnUY7vOZqEKJrLj4p7tYgG9NZ6xs=;
	b=c54Z3lYA/WQevQjKlzJYBqGQ+CWNEFTivoPhZOC+JOfO4RVGKUy7FriAzbXBTz0Xd2vAZA
	TPBb6dVBSmRTChW3H6pUmJpUSUYTa7Wu8sh+qg2JfMaWMagKF4kp+hih32wzKQlBiOtoFa
	7Ns01pr7LMKxXQs7NvyYUBOuSQcCqyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697214789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xjo9Xl3dXS4rFlLLnUY7vOZqEKJrLj4p7tYgG9NZ6xs=;
	b=ueCXVZSaVgSQ2tMcdMu/yMoWL7Y1ZxV0amB9SSNDvB7ZjY0qwUi4qvC15PnZ8Yed1Qq6Fu
	uYwl7yfC2q+2S+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D98D01358F;
	Fri, 13 Oct 2023 16:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LvkPNURxKWU/bQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 13 Oct 2023 16:33:08 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Daniel Wagner <dwagner@suse.de>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: [PATCH v2] nvme: update firmware version after commit
Date: Fri, 13 Oct 2023 18:34:20 +0200
Message-ID: <20231013163420.3097-1-dwagner@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.85 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.48%];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lst.de,wdc.com,suse.de,gmail.com]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_093310_655686_F0879009 
X-CRM114-Status: GOOD (  11.25  )
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

Only compile tested. So you might want to wait until I am back from my vacation.

 drivers/nvme/host/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2ee8e..686478555585 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4067,14 +4067,29 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 {
 	struct nvme_fw_slot_info_log *log;
+	u64 afi;
 
 	log = kmalloc(sizeof(*log), GFP_KERNEL);
 	if (!log)
 		return;
 
 	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
-			log, sizeof(*log), 0))
+			 log, sizeof(*log), 0)) {
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
+		goto out_free_log;
+	}
+
+	afi = le64_to_cpu(log->afi);
+	if (afi & 0x30) {
+		dev_info(ctrl->device,
+			 "Firmware is activated after next Controller Level Reset\n");
+		goto out_free_log;
+	}
+
+	memcpy(ctrl->subsys->firmware_rev, &log->frs[afi & 0x3],
+		sizeof(ctrl->subsys->firmware_rev));
+
+out_free_log:
 	kfree(log);
 }
 
-- 
2.42.0


