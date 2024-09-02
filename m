Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E720FCD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DS8x0zCgr+JrLN1k0oEvqiPeYlRgJUs8Clt4dA43DI8=; b=3won+fLPrER8i2WxRKMLtVX0pe
	Ys6Nilco0he1mWWrpjWc4O/5VhkxpKnFIf+AgFxnWqFlN/BsFNSepBguWId9Mkxe6TuaqoUnWr3zv
	1lOxk1VWgJQJwxKuh7z/P2rEZBzXFtzj3KcDZWYQdjZVPJZnLM5R84AyhLg5U2zKAorKbysbaEc9t
	rbO4F6WnZyUXIQ5cNpwKlb98nDe/xS1oC/55U3viRdYwvArlZMt0o8d41lUysAL+2B4xrHg26lyvG
	wyWjoWlE2e+JoCVGaSx5/eOgJ8r+y3XlXIHi6i2fodcRpfbRv33dkwWlWduZ++2QeM2sQiw0SJkUE
	PD+487OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52R-0000000E5AF-2Mx7;
	Mon, 02 Sep 2024 11:16:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52O-0000000E55r-1Fzi
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 11:16:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BF91F5C580E;
	Mon,  2 Sep 2024 11:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A057AC4CEC6;
	Mon,  2 Sep 2024 11:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275759;
	bh=Bukhp/kBEFyN++c063MXMiz02BNLk9Qp5DfB1NPAOno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFzzW8vwFAvUD5MhstxgzBUzp3/REQJ85gUhK96JYI5grH2JY2h5pCNJNTPy4pscl
	 q3uG4YZUAYZOWoNERbQbDCWb04Otvr5YKNkwqDB2udgm1iheHJOJmDkkCQQ2n6ZZQZ
	 XY8oTFAuarcTj6jeqH81W8a/rPHttH0wWsysvmVCMThFRFvUsSF2/y3M/9swsvRneP
	 kWA6VvsLocJP6Mn8Z6M1ix2Ran3YLP2OP13C2iYfGOhNfdaO8NdV0hZWA6XdhT2fGB
	 iWDHEZ7I9gyZZ7ZkQgEoYk/kYujCgjnBuSsagC8hUbiS6GYZ2gtYeBVfmFoGZ8fEY8
	 sSnC6MUikGHrA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/4] nvme: remove existing namespace on ID mismatch
Date: Mon,  2 Sep 2024 13:15:48 +0200
Message-Id: <20240902111548.41430-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240902111548.41430-1-hare@kernel.org>
References: <20240902111548.41430-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_041600_411517_735F863B 
X-CRM114-Status: GOOD (  13.78  )
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

When the namespace IDs mismatch during rescan we clearly ran out of
sync with the target, but we really can't know whether our local copy
of the NSID is correct, and that one found by scanning is not.
But clearly something is wrong with the namespaces, so we should remove
the existing one, too, to avoid accidental data corruption.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..626718bbf3a5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -136,6 +136,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
+static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -3746,8 +3747,9 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
 			dev_err(ctrl->device,
-				"IDs don't match for shared namespace %d\n",
+				"IDs don't match for shared namespace %d, removing\n",
 					info->nsid);
+			nvme_ns_remove_by_nsid(ctrl, info->nsid);
 			goto out_put_ns_head;
 		}
 
-- 
2.35.3


