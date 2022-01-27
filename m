Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878B1C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O9QO+GuOwuNfCQAL5X6kgAbs9JlqPuUL4SKyZ4gCtFk=; b=TA7UtjWDni1IqVR/5MvVbLzJ5I
	/b/CywNBGpvO6W/p+TrshJw9xXeSEs5ulzmV6Iep7+D/5edq41Qp77xR0p6UsLmEe1/Jpp6LUBEhr
	dOrwOS2NuH394JfAS71mA2CzyITNbR9WwTwrft2HNR9Sk2pfyh50Nd049VmGYqqoLALguCgQ7MtaP
	yaS8k38Sr1V5xfQ7HZaKK5cOP6X9XPH27X+HIxOwUwKauPn7LV3yunl/2oIu9aaekEsmEs4lOQs55
	cQatkN+x0PUUYWMSRjlKoee5wVFbMFdMt6dHadUY6Lu3MjG5QGlBoVdNwfe+g6XXFY5inT6OlsH5Z
	PTmtqbAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4xO-00FvKs-2i; Thu, 27 Jan 2022 13:36:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4xK-00FvHl-Te
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:36:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8443B218CE;
 Thu, 27 Jan 2022 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643290610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O9QO+GuOwuNfCQAL5X6kgAbs9JlqPuUL4SKyZ4gCtFk=;
 b=QYaek997c5pGHBy5TBaos7w+eHs4u2gf+NndfKaQg7gz0kxFgI7c20g95O2H6lMYGycnav
 wqcGuiYiIE/ZwgBeUkLfNLPGXk1Pr0LkQ+JtatlDrIRKCy2C8BPX3n8IMchjdR0KtkSeEq
 dQqF8sbwlmPZVKVwFculCR5fkIiGKEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643290610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O9QO+GuOwuNfCQAL5X6kgAbs9JlqPuUL4SKyZ4gCtFk=;
 b=3V+c1YSBRZbizUpOK3QrjutsbkQU/u64evuTAIMS6QJD4OjohwAG0NVNIRtZxdPt8Niax+
 zM2EEuaCTBVXTzDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 7DFC6A3B87;
 Thu, 27 Jan 2022 13:36:50 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 71F435192D56; Thu, 27 Jan 2022 14:36:50 +0100 (CET)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC] nvme: Do not reject dynamic controller cntlid
Date: Thu, 27 Jan 2022 14:36:48 +0100
Message-Id: <20220127133648.8201-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_053655_152397_4221C658 
X-CRM114-Status: GOOD (  13.50  )
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

The NVME spec states in 3.1.1 Controller Model there are two types
controllers: dynamic and static.

The nvme_validate_cntlid() check ensures that the newly discovered
controller does not have the same cntlid as a known controller. For
the dynamic controller model this check doesn't make sense as all
cntlid will be 0xffff. In this case ignore this check.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

I got a bug report with this:

 nvme nvme10: pci function 0000:00:19.0
 nvme 0000:00:19.0: enabling device (0000 -> 0002)
 nvme nvme10: Duplicate cntlid 65535 with nvme7, rejecting
 nvme nvme10: Removing after probe failure status: -22

From reading the spec I got the impression that it should be enough to
ignore the cntlid check if the cntlid is 0xffff. Though I might be
completely wrong here.

 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..918abb54771c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2701,7 +2701,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		if (nvme_state_terminal(tmp))
 			continue;
 
-		if (tmp->cntlid == ctrl->cntlid) {
+		if (!nvme_ctrl_dynamic(tmp) && tmp->cntlid == ctrl->cntlid) {
 			dev_err(ctrl->device,
 				"Duplicate cntlid %u with %s, subsys %s, rejecting\n",
 				ctrl->cntlid, dev_name(tmp->device),
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..ed75245263f5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -539,6 +539,11 @@ static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
 	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
 }
 
+static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
+{
+	return ctrl->cntlid == 0xffff;
+}
+
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
-- 
2.29.2


