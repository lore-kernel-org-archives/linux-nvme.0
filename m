Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66EDC61DA3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fOkugDVLqgrE26aysraErddrFxpBPEtgw9aU/DhXOFQ=; b=gyyANzxx2aTxW+MOX30WQf2yXN
	KwQqB2JrMbYGKecyjwqQH+I9h5dnv0ZyAo4P2LT+3zeasZpFTXHy1FPTFFPxleoa8gA4tPT9uc4e8
	3A/nycFNeooIFmOWM6GLnG1XjNE5C1AFwZrfpHxTJ/mH3RrUj08+7TD7uLAWGdtqKyWS8IZj3oDQy
	8L6st5Bckt6XVdU7PNgnHLCt36iYucMJHEMyGy1Y7OwPkGv0V+tRqajwOEs9Y8FnWsO00RIMAMX+V
	b/iuBDTtgXRMdjiPjSrL9G/8mDo6pNlI0Zp5VSdhcw+8kdOkOlG6usIHJS3KqYyji1AOTrFI0OZpz
	Kpeq1ocw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUVrP-0091Wx-2X; Tue, 21 Feb 2023 16:51:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUVrM-0091VL-0N
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 16:51:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3407A342FA;
	Tue, 21 Feb 2023 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676998274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fOkugDVLqgrE26aysraErddrFxpBPEtgw9aU/DhXOFQ=;
	b=Ec3w9GYfs31b83gkJNfbA9ek1ffNvuIqMqLS7janB7awy//L2fZZcdkgthf7CJcP7UKWi4
	fuGNvj6IJPrH0NRngz+lan2wdhH8vP9d9y7pzLmhfZLa9jzbJnH3yb0y3Waaj2YMT7w2VC
	Vz4aQt4phYOx7n2HULHxscIpV+7vtvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676998274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fOkugDVLqgrE26aysraErddrFxpBPEtgw9aU/DhXOFQ=;
	b=KAhR5WnVRp+PauwatbpD9CRWKEkNtoVEy/eXFr7xPiyMADjYgEcfWInxEXWQ4OYDBql5XY
	nQtL8gMWz9RVLJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2744F13223;
	Tue, 21 Feb 2023 16:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OluFCYL29GM8JgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Feb 2023 16:51:14 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-fabrics: show well known discovery name
Date: Tue, 21 Feb 2023 17:51:06 +0100
Message-Id: <20230221165106.21326-1-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_085120_243438_0C9D91D1 
X-CRM114-Status: GOOD (  12.19  )
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

The kernel always logs the unique subsystem name for a discovery
controller, even in the case user space asked for the well known.

This has lead to confusion as the logs of nvme-cli and the kernel
logs didn't match.

First, nvme-cli connects to the well known discovery controller to
figure out if it supports TP8013. If so then nvme-cli disconnects and
connects to the unique discovery controller. Currently, the kernel show
that user space connected twice to the unique one.

To avoid further confusion, show the well known discovery controller if
user space asked for it:

  $ nvme connect-all -v -t tcp -a 192.168.0.1
  nvme0: nqn.2014-08.org.nvmexpress.discovery connected
  nvme0: nqn.2014-08.org.nvmexpress.discovery disconnected
  nvme0: nqn.discovery connected

  kernel log:
  nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.0.1:8009
  nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
  nvme nvme0: new ctrl: NQN "nqn.discovery", addr 192.168.0.1:8009

Fixes: e5ea42faa773 ("nvme: display correct subsystem NQN")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a6e22116e139..dcac3df8a5f7 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -189,7 +189,8 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 
 static inline char *nvmf_ctrl_subsysnqn(struct nvme_ctrl *ctrl)
 {
-	if (!ctrl->subsys)
+	if (!ctrl->subsys ||
+	    !strcmp(ctrl->opts->subsysnqn, NVME_DISC_SUBSYS_NAME))
 		return ctrl->opts->subsysnqn;
 	return ctrl->subsys->subnqn;
 }
-- 
2.39.2


