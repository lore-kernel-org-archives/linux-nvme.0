Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70853CCA488
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 04:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZdkRkYfz/m5LELzs8IlBRS6c+g63IGm5Kwf1FO17pQ=; b=YfpwvWgLLOCP5wdNA1k0ci09BR
	fLglGMfI+SSs6izrazDto0F+FPxZ1+2NMPm3MgT6UO9i//QYRu7+WsnndcgKoiWKNzLCkfb2EHcji
	BuEP7cKOQx1sYsQM2u1hPQ22fTWEdsaeONE0GjKO18KXEjdeNoc3lvGcDJ7FEKbG/xtSgKO+Lybvm
	SVMWm2q28P+nSHCl2Pcxo+0FEgkFm3DY96t40GEZ+ixzhVFbM7WoDjB0cqMltGH9eRTnS0NU4uYhT
	Ym1+2dRnBhJeT2f/L5ZBplfEEb2SjCUewClOJu/fsE2CGDu9d4UYUbEwtoEWTgQ0LLYpmP7559nul
	3YOD2p1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqOZ-00AbDD-QH; Thu, 14 Jul 2022 04:24:11 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqOW-00Ab8J-S3
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 04:24:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 880A9CE24F8;
	Thu, 14 Jul 2022 04:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB01C34114;
	Thu, 14 Jul 2022 04:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657772639;
	bh=CH3O+8rE7gc07cwtk2Pd8nsB1wVExVHVq8mfQlHMR5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6M4EdKKExuf7iUl//Eg88iTfzk5q+8XQE8Ip0eMiX6lsFwFwtrCYIN3q8K9i9FUx
	 MqzjJkUNGPjKg6yvwNiPT5Jb+PyvU9nX0CfFMWc272jHB/qm+JdHpEo0b2J6xQXjuP
	 0ocyEksL10sxSujsZFexlNc0n0wnvNyPruG6DzbNwAap0hDJi6wmPGdK+vh68/5ES6
	 KJzC/87JmDuQjvQUjUlb503CD/WhDR7JuUFkMAAtNNeoBjdSrhyKs62sJb7w/6vs/I
	 F7lLP2Dh6EZedPDmhUpA0KFdJIqTSJtHWhfXyr30pMD/25k2w3fdRPhahGI8Wo7A1v
	 2vOT/66ng/TKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	John Garry <john.garry@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 37/41] nvme: use struct group for generic command dwords
Date: Thu, 14 Jul 2022 00:22:17 -0400
Message-Id: <20220714042221.281187-37-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042221.281187-1-sashal@kernel.org>
References: <20220714042221.281187-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_212409_352936_2FA3A390 
X-CRM114-Status: GOOD (  13.18  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c629dc9609dc43492a7bc8060cc6120875bf096 ]

This will allow the trace event to know the full size of the data
intended to be copied and silence read overflow checks.

Reported-by: John Garry <john.garry@huawei.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/trace.h | 2 +-
 include/linux/nvme.h      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..37c7f4c89f92 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -69,7 +69,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->metadata = !!blk_integrity_rq(req);
 		__entry->fctype = cmd->fabrics.fctype;
 		__assign_disk_name(__entry->disk, req->q->disk);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
+		memcpy(__entry->cdw10, &cmd->common.cdws,
 			sizeof(__entry->cdw10));
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%x, cmd=(%s %s)",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f626a445d1a8..99b1b56f0cd3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -867,12 +867,14 @@ struct nvme_common_command {
 	__le32			cdw2[2];
 	__le64			metadata;
 	union nvme_data_ptr	dptr;
+	struct_group(cdws,
 	__le32			cdw10;
 	__le32			cdw11;
 	__le32			cdw12;
 	__le32			cdw13;
 	__le32			cdw14;
 	__le32			cdw15;
+	);
 };
 
 struct nvme_rw_command {
-- 
2.35.1


