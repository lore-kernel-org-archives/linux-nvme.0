Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6548C43460
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:10:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EA1613BA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EA1613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BhrSqX2x/1X0XRpLAX7MvP2G4ccd+i//xJQsVqmt5bg=; b=H2NjddUn+fGiz+9KSQeyqENTs
	MPSmPUKVSWV/tjJTNQmcDJ4+2VAjYXeiwRLCsTF+oPgCF7S2iHnidoFkeSwOeM5AmaDRGNsw9k2SB
	mK00Zu8LJ3JEWhSrALrJYn9BxgnmWRUa9cESrjv1yxvDLIHJmHYn34khkk1R/bynywxIDGw7GN8Z6
	Zk70WRfhIW5lkPdRfTBvA28bzM7PiApq0cTmQX7zlzYRnC7qeL5yAVhh5ATyLvQYdwTEfU7ijVvUl
	jAjffRmCmLjjH62l5IRnlBZFORXCXSShg1V589zPUaSMiHcsuZRemVgsGTa0jx7nNmvrnRLMmq9Dh
	ix/aqghIA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lioFo-00Gapv-QR; Tue, 18 May 2021 01:10:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lioFR-00GamM-Cq
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 01:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=aG6+yv5+KzVvocICAYTbWDCBjSmhDOeRbVmA1Q0xCFw=; b=mh4TGXhhTiKt1WpAtj57NbEecz
 EWGw/L47YsS2GV2pXrS86i3trMq1mNb3O3CegKnO7PCZoDqme0MsVnaqQTW4DZHsEqZMJBNbjjYqQ
 TU8y2Cuhh5Z0CXnsplLPQvM/vXgHVm+wOrkmyxpVlzNL7XkRp1eHfJkZY29XUhR89IAJ6WyoACVDo
 fOTXoZkS9tQWK1n/AnnUJlU7+4Fv/Ow7pOLEvAUAPj9ajNbiQkOVeypyQQPzwLZx65StvBtpgfdOI
 3o637VJPFNHxM50Yf3+A/E0B8N6GPtTAxUOl7A0PCiYGis2rlagnzcXuO44HQyvM1XXHGZXacIBmz
 dluBTVkQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lioFK-00EFNt-EC
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 01:10:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AB3B613BA;
 Tue, 18 May 2021 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621300206;
 bh=+Ry8OFtRQ6R/dls8cjldcYfjKLo1G6vnoM5kpwSEqFE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MZJ5+KU2dZTlGdmBzwjnAEU9cfCjW3KdKZGrvKv0QBrXF/lkvZhj8M07YKpQJ/trZ
 Wfx7TUaBmmlwfpoUeRC8xtEyMxbv1/x3/aD7oITqN/AT4uSJxX7vzeuvPVDPQKtbgK
 xFunzee0zAQeAiHBazY38K38Gph7OBNh1TUXzco7xoz7Y60aU7TPIn3KpabQqiJ00e
 yzM/XGdBRyXhpIxHZpHXkpCibcthn2UzWWEzcYFTSpvp4NMkZAvDmTl63wLBOGpQ3W
 PpBw1sDGhbrxTb4b+4ADB2e383cobPwCqdCeiGqmjZQtNgknixSjyEDYWdLWctBT3D
 yJgWnI6iSbiug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 2/2] nvmet: seset ns->file when open fails
Date: Mon, 17 May 2021 21:10:02 -0400
Message-Id: <20210518011002.1485938-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518011002.1485938-1-sashal@kernel.org>
References: <20210518011002.1485938-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_181006_519348_5354AED1 
X-CRM114-Status: GOOD (  13.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 85428beac80dbcace5b146b218697c73e367dcf5 ]

Reset the ns->file value to NULL also in the error case in
nvmet_file_ns_enable().

The ns->file variable points either to file object or contains the
error code after the filp_open() call. This can lead to following
problem:

When the user first setups an invalid file backend and tries to enable
the ns, it will fail. Then the user switches over to a bdev backend
and enables successfully the ns. The first received I/O will crash the
system because the IO backend is chosen based on the ns->file value:

static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
{
	[...]

	if (req->ns->file)
		return nvmet_file_parse_io_cmd(req);

	return nvmet_bdev_parse_io_cmd(req);
}

Reported-by: Enzo Matsumiya <ematsumiya@suse.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..6ca17a0babae 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -38,9 +38,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
-		pr_err("failed to open file %s: (%ld)\n",
-				ns->device_path, PTR_ERR(ns->file));
-		return PTR_ERR(ns->file);
+		ret = PTR_ERR(ns->file);
+		pr_err("failed to open file %s: (%d)\n",
+			ns->device_path, ret);
+		ns->file = NULL;
+		return ret;
 	}
 
 	ret = vfs_getattr(&ns->file->f_path,
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
