Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A6BC3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VEL6hOi5biXMbAumzUf4VlMr5JS39ptocmafl1MdgA8=; b=A11cRv1UcqQR6hxoYsV+EVZI/r
	EVHDJ7MDHNMejFai8mkU6/uHG5Fs2Z1cPCd7qK8dN7zt4s6neZPpvGOevsTovRSMpVTu+ShroLP0P
	W8CXt1T0FZ1vJvsey2j9GyFyZpA3EuDGzOXSVXm4HYzya5EcYRD9vj1tDRkpwLZ+YXZAR0Zr+kv5Y
	pQthk9iwuEJqVVFMOrtoPqbOTVmuFejGKomet//j62Z91dEKYhks9hJVveqZXuziUqOUL7MRZ9dd7
	wSEwN94uURGx1GAuNSjlpbW6nkr1m3kTf2AzRQm+1TPSierNWc25THHzg3dNOHgdh00GkULJtfPY7
	/yP0L8FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1Vm-00000001RbC-2TQi;
	Mon, 19 Aug 2024 12:29:26 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1Vj-00000001RaE-3vn0
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 12:29:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 247C0CE0A55;
	Mon, 19 Aug 2024 12:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01384C32782;
	Mon, 19 Aug 2024 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724070561;
	bh=RMTdoz9CpRGOeOFGauWES/rKsK1K6T5jd1WemyrzgDI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZULQy7t9HZ1RTKuqa6mfTor+T7lsXZmfD467WfHNucjy1H/BjCkePityJUpwB+ukA
	 OrxYOv+HqZ1SRqtjeRtJ5z6lLquwIUpyhHIzFusskmHVvBPif23KNHG4sswUKxAo2K
	 JhzitAKSYfYczzW900nn2Fc1Zyf3WIDh9xkylN1R0xmMv3Tw+nvnNGzbSg32fDKwgG
	 xLbD4MENdd7A4jRDJb+kjV3LPg0DF/vmOMNaz4hBhpsczpKNLXHaTVpU2/1BrkwNlB
	 cPYQcFQt990rF/uq93qTII3+NZdL7Q1TejZYNuPufVCv/9nxsaoqdoAiVzOx653Sw0
	 GlYA5LK9YDvCQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmet: return 'namespace not ready' for disabled namespaces
Date: Mon, 19 Aug 2024 14:29:17 +0200
Message-Id: <20240819122917.65313-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_052924_166964_8CD5B076 
X-CRM114-Status: GOOD (  12.72  )
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

When a namespace is disabled from configfs returning 'path error'
is quite an odd choice; the actual description for that error is:
'The command was not completed as a result of a controller internal
error that is specific to the controller processing the command.'
Which is not the case here; once disabled the namespace is disabled
for the entire subsystem, not just the controller.
So return 'namespace not ready' here to clarify the problem.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ed2424f8a396..d9ce1326f4ab 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -444,7 +444,7 @@ u16 nvmet_req_find_ns(struct nvmet_req *req)
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		if (nvmet_subsys_nsid_exists(subsys, nsid))
-			return NVME_SC_INTERNAL_PATH_ERROR;
+			return NVME_SC_NS_NOT_READY;
 		return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	}
 
-- 
2.35.3


