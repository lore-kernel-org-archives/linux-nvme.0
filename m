Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1100BC3A5A7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yShdAoXgZBX5aIg/OBlqPc9UwGZQ1NePNnITowFYtmk=; b=Vv0TVgx3wI/AF/MLSYpDNTnoLN
	k+FHmFcmPzSldkex5dzXjtg7JZr4ZJsYpXq32WOXh1M0lryWpAf2dkSibV5e7Tbl9XZLCWCDEmlcb
	RapO3IsvMcMbSk51Z1DpbQymoQXi0t5ChNsdt5VMK0OUdKlm4m8zblBdszu8PXOmO3VRQbBaqiFA7
	LODmT//nhYwTFWxUHhul7YfYloTK4O3sfrgoXPpM5Cs8/85RsrfXzuKdq3ZAYDGA6pK0hqZiUNmuj
	E+ymfdgHOJWdPDsFITLZRR4J4L+wUo9pwU4H+dphNhPM5uwOENCPwb8pfjRggDZftBQ6m9iex1v/O
	+EzLZAcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Bew-007wtT-4f; Thu, 08 Dec 2022 07:49:34 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Bes-007wMM-L7
	for linux-nvme@lists.infradead.org; Thu, 08 Dec 2022 07:49:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4CC6A20737;
	Thu,  8 Dec 2022 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1670485766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yShdAoXgZBX5aIg/OBlqPc9UwGZQ1NePNnITowFYtmk=;
	b=LTwWYmZ4n4LfLwLUeGJAUkOJzKdUp0dTPlhDXopVRszr1gQYj+I/x0Esjm70XTCeSSm9Ur
	I4nyE8NhC2bbywVlKICv9qmGt1mlmZUl4sYdJKwxzJJQgfPVZeskHITEqa5JZBb5tqCe36
	ZUChzKbEU3VSIysMyG0HNUVx5/w1VAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1670485766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yShdAoXgZBX5aIg/OBlqPc9UwGZQ1NePNnITowFYtmk=;
	b=zbAGRhD/6Fc1lyT7SexUTE4b6vH0E3oxLCjhAhF7rbYNfTei+t3coGtQZG6o/0LVizQd7m
	KHbDuw9id040zBCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 1D7792C141;
	Thu,  8 Dec 2022 07:49:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 087B851B2895; Thu,  8 Dec 2022 08:49:26 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Mark Lehrer <mark.lehrer@wdc.com>
Subject: [PATCH] nvme-fabrics: clarify AUTHREQ result handling
Date: Thu,  8 Dec 2022 08:49:20 +0100
Message-Id: <20221208074920.43828-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_234930_882491_C731A73E 
X-CRM114-Status: GOOD (  11.86  )
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

The NVMe 2.0 spec defines the ATR and ASCR bits in the AUTHREQ
connect response field to be mutually exclusive. So to clarify the
handling here switch the AUTHREQ handling to use the bit definitions
and check for both bits.
And while we're at it, add a message to the user that secure
concatenation is not supported (yet).

Suggested-by: Mark Lehrer <mark.lehrer@wdc.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7b64357ecd1d..a9ca286c381b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -410,7 +410,14 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	result = le32_to_cpu(res.u32);
 	ctrl->cntlid = result & 0xFFFF;
-	if ((result >> 16) & 0x3) {
+	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
+		/* Secure concatenation is not implemented */
+		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
+			dev_warn(ctrl->device,
+				 "qid 0: secure concatenation is not supported\n");
+			ret = NVME_SC_AUTH_REQUIRED;
+			goto out_free_data;
+		}
 		/* Authentication required */
 		ret = nvme_auth_negotiate(ctrl, 0);
 		if (ret) {
@@ -485,7 +492,14 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 				       &cmd, data);
 	}
 	result = le32_to_cpu(res.u32);
-	if ((result >> 16) & 2) {
+	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
+		/* Secure concatenation is not implemented */
+		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
+			dev_warn(ctrl->device,
+				 "qid 0: secure concatenation is not supported\n");
+			ret = NVME_SC_AUTH_REQUIRED;
+			goto out_free_data;
+		}
 		/* Authentication required */
 		ret = nvme_auth_negotiate(ctrl, qid);
 		if (ret) {
@@ -498,6 +512,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 					 "qid %u: authentication failed\n", qid);
 		}
 	}
+out_free_data:
 	kfree(data);
 	return ret;
 }
-- 
2.35.3


