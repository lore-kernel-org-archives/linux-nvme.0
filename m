Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A23C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 11:00:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150E0610FC
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 11:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 150E0610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ge+DHcxOKyJhW7sY4Bjx4Z/7QWZHWkazy11BeueFjRk=; b=wSOxWaWk+ugDxDgiIy6p80+uS7
	Fdh7HLtskwRXFyCCo8O8VqTfgGrX8sWalxucX2lsV8X6GLEaYPyl3CJFmyEFmHk95jb6LR7J3ryQY
	Sinpb0xS6HwGSJXmTdhVWL5QbJZoTQ1PnrAO3ZS78ixY8Tz0cZfgaVVLtxQBiWuF9geuXMq/wxtdl
	cxlPCvS4XZ1iF2S95NY2CTpIkxCOhbbSHVvgESul69MBwmIf6E74QJzCWy3QgIOq7PGuxIU/TEKPB
	03vZvOCC1uHCYbahgerCE7f23KEV4UGu2D55w9sNDeiyQRVZuXHV0pxj7KOuY8yenCZNUCgCU2I3Y
	rvyf1qWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ml7oG-007ksC-Nx; Thu, 11 Nov 2021 11:00:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml7oD-007krg-LN
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 10:59:59 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4D12721B31;
 Thu, 11 Nov 2021 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636628394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ge+DHcxOKyJhW7sY4Bjx4Z/7QWZHWkazy11BeueFjRk=;
 b=j7xCmQkUUkrjpfQaFpxW/qcQAAAtu8/wCpoj0jspkMUhkU6e3iUEW9HOMdRU0Hd3h3cO1C
 xCNevSX0InVqXhkPHf7kQodk9cdsI4HROlCBh6r+ezMabUTKQBBil/hb2lUsh7mV+Xcv3E
 sEUenuI6MS7fsap/cE6SwWFATipr6bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636628394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ge+DHcxOKyJhW7sY4Bjx4Z/7QWZHWkazy11BeueFjRk=;
 b=hD0SfJmBkQdBK/yAkH2Ivsqm9iNecQez7nX7IjsIyt/oEZZv5tWGi09H8L/6R7m6snRKxT
 6IM8LVarZhwdpwBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1C5F1A3B83;
 Thu, 11 Nov 2021 10:59:54 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 0A09E51911B3; Thu, 11 Nov 2021 11:59:54 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: honour O_NONBLOCK during resetting
Date: Thu, 11 Nov 2021 11:59:53 +0100
Message-Id: <20211111105953.63072-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_025957_889007_E493E3A0 
X-CRM114-Status: GOOD (  11.99  )
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

When opening a controller device node we should honour the O_NONBLOCK
flag to allow the device to be openend even if it's in state 'resetting'
or 'connecting'. This allows user-space applications to use a call to 'open'
to figure out if the controller is present, even if it's currently
undergoing a reset.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 74980a1cf89e..67cde3eaf5b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3136,6 +3136,11 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	switch (ctrl->state) {
 	case NVME_CTRL_LIVE:
 		break;
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		if (file->f_flags & O_NONBLOCK)
+			break;
+		fallthrough;
 	default:
 		return -EWOULDBLOCK;
 	}
-- 
2.29.2


