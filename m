Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FECC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D74A60EFE
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D74A60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7aNoEpqOIL/OYCKWpqjcsKW2cz848LEgNL9MGxK8b54=; b=qZ6ar4/IH/lMxL5xRadCLWwgmP
	lsb05SWCQckMM+IrmcvrOp68PE45cFzohZeBN63BxfIuurBfGhFx0u2MQr0lOlBw6RshTVvqlnE1X
	WRktD1zQuyy5sEKZyuGJIG7lKLtbUXuT3+k8N+iHb97VdEDeUK4xvWq7eLckYp1TcZG9mlUhYgMe1
	bk6newTvRFb+hzgeHll0BcvCIJs0CYLFCMwLVpVgjv3WI6BeegMI5UWOMBlmzZAGHr5GoQvFsutaR
	IYgw2XZGJ1SEDesEFn98nWX6TS3q40dFZHP5tmdbpcJxZxZNM8oBemTfeisXDL2ySLXoN5TBc+mtL
	uwtddysQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcUSk-00GHlj-94; Mon, 18 Oct 2021 15:22:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcUSM-00GHeY-Jc
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 15:21:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6A93621965;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634570499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aNoEpqOIL/OYCKWpqjcsKW2cz848LEgNL9MGxK8b54=;
 b=1ei+BiM+k/STaM9v/OADKGy/4xKlWM3mmDQd2zYbelRImV2yYefutOg9XHX4TFhXgPgRHX
 CN51if3hTAQ29TtFyd2/bpqX/HcpfasruFensbzA5vAJ91btlrBRhskOh61DRg5Q0RObah
 OnYKdo43hUSFH0dhekingDtlzgtXKXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634570499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aNoEpqOIL/OYCKWpqjcsKW2cz848LEgNL9MGxK8b54=;
 b=pfj6qvU1qAfgwTXz0uU8FOTKMn1b6zfGSE63scUlV64IkTPTymoERCgVodcmCNICDyrAZo
 9q0uf1fG2eG17fCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 38C97A3B92;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 21FF6518FBBF; Mon, 18 Oct 2021 17:21:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: switch check for subsystem type
Date: Mon, 18 Oct 2021 17:21:36 +0200
Message-Id: <20211018152138.2128-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211018152138.2128-1-hare@suse.de>
References: <20211018152138.2128-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_082142_826292_9B1856AF 
X-CRM114-Status: GOOD (  11.40  )
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

Invert the check for discovery subsystem type to allow for additional
discovery subsystem types.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f31dcc4fb1a2..af193423c10b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -579,7 +579,7 @@ static inline struct nvmet_subsys *nvmet_req_subsys(struct nvmet_req *req)
 
 static inline bool nvmet_is_disc_subsys(struct nvmet_subsys *subsys)
 {
-    return subsys->type == NVME_NQN_DISC;
+    return subsys->type != NVME_NQN_NVME;
 }
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
-- 
2.29.2


