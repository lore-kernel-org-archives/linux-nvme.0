Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E68DCDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 06:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T9TmIodEecjXhOeeyVrpi/lTsL8WIjPMSwLYTMa8tvQ=; b=vNnw/2Hkmv6ALQIz8xVZ/1vrgd
	x5i2QuJ9aJoHTiRULhOHYzWG4zYFhHZvxQeUMOiUAKvf8+zHYMZfdu7UiOixsFF2xKwYG6NNU1jnn
	JxhwdOHwHmtDjoB7sNiMMl+P3pcYfni2uO+FwO3Z+PNKOJE+lSpCAvPfj93Rwrnl7Uq+fTpMVaUIw
	tc63h+RRuTDFOg6TLz8Nrj9gD5XG4meb7e+OCPFARkcu39JathU9wy142eOw92a8X9glght+rH2wn
	wDxz1LAIvOelA84vd7RhMqo/aLVx7YEzcjPM+A3JjS6PE6TvUTsOC/mqmdJy6fu0jJWlvMp20Pxo8
	kUZk5BUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrBbv-002aUm-22;
	Fri, 13 Oct 2023 06:25:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrBbs-002aTr-01
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 06:25:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F27E2188E;
	Fri, 13 Oct 2023 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697178313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T9TmIodEecjXhOeeyVrpi/lTsL8WIjPMSwLYTMa8tvQ=;
	b=JLCLMy6wswunI8hU6sPbjwoP/t0Ty/c1IeLSfXcWEuOBv28FvZWwfXG+kGX0L0Wl2ItZdD
	S3PaaGn1Jf6TSo1slBFf0sxtePdCdMP1uQXZ5fBfPCT6GRl4eaHvwuaBNC9Q1lFgsfbWyE
	3X81qg0HtXKG5100/xI+weOypjXniQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697178313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T9TmIodEecjXhOeeyVrpi/lTsL8WIjPMSwLYTMa8tvQ=;
	b=7AjiLkauuPFUix9b7kF2COHEbA56vaqruZLElPf2aJkyNCInFjhKjCW81fMGi8QcLuAW3b
	PJuVEysxjDJ3ihBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 713BE138EF;
	Fri, 13 Oct 2023 06:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bkqXG8niKGX/NwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 13 Oct 2023 06:25:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: update firmware version after commit
Date: Fri, 13 Oct 2023 08:26:23 +0200
Message-ID: <20231013062623.6745-1-dwagner@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.40)[77.76%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_232520_211371_F33FD1C0 
X-CRM114-Status: GOOD (  10.32  )
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa..bb15d878e8a2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4079,6 +4079,20 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	kfree(log);
 }
 
+static void nvme_update_firmware_rev(struct nvme_ctrl *ctrl)
+{
+	struct nvme_id_ctrl *id;
+	int ret;
+
+	ret = nvme_identify_ctrl(ctrl, &id);
+	if (ret) {
+		dev_warn(ctrl->device, "Identify Controller failed (%d)\n", ret);
+		return;
+	}
+	memcpy(ctrl->subsys->firmware_rev, id->fr,
+	       sizeof(ctrl->subsys->firmware_rev));
+}
+
 static void nvme_fw_act_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work,
@@ -4109,6 +4123,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_unquiesce_io_queues(ctrl);
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
+	nvme_update_firmware_rev(ctrl);
 
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
-- 
2.42.0


