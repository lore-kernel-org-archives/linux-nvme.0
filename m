Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545CEEDEBEA
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=opdxGJM13ZFy1KCnDwkudhw7lgp4YhVPho/P8SgqAqE=; b=OnpmVLS/WkDDQ0kUsXSal7wkAt
	T7NMPBDV+eRziwuEgZjCh00GsLLGRuuteWmZs4hWIVcGeHOM8ZezqvhClqtGvbUBgMjeBNMW9qY1a
	3MO+YBDC9W8zC3kHcHb+4+TXxKRI/WZQzX7+U2NoiA7esUIYuowY8kLhqf2/Q2WWbcsM3gRTJi2SR
	+BaCejThL74oWpdYAmM6smaE381nwVzh96IbV6dPU7wdVAXeoJx+zsJqtbTZvmx9GatmRa+vn/vVd
	k8lIpjHeT844AwigJaq89sc/DEaOvVJZynhwxEn1CbxCGvSyLZwBJ5mCJeeYsbRKnkiGYXH1UP/YU
	93bPqh8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxV3A-0000000Fjyu-2QUL;
	Tue, 03 Mar 2026 19:04:56 +0000
Received: from out-173.mta1.migadu.com ([2001:41d0:203:375::ad])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxV38-0000000Fjxd-0RqW
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 19:04:55 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772564691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opdxGJM13ZFy1KCnDwkudhw7lgp4YhVPho/P8SgqAqE=;
	b=Tiu0oRniwgyKa27X9c8I5pMzcniRKdYo9/3j//kRwN4ghRreWQSAgJqfk8y+5K5DFAtaAN
	xFQIdk5CuLxStdWGDByWg8KhxW1OVUvlG+I4KeUApAjbOj000E5KQoylaVy3nzyTRqZwp9
	Z9lMGxpiL0EJdifpTZm9/qVsNXo0vG8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvmet-auth: Don't log DHCHAP shared secret in nvmet_auth_ctrl_sesskey()
Date: Tue,  3 Mar 2026 20:03:52 +0100
Message-ID: <20260303190350.78705-6-thorsten.blum@linux.dev>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_110454_291688_71855EBA 
X-CRM114-Status: UNSURE (   7.74  )
X-CRM114-Notice: Please train this message.
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

When debug logging is enabled, nvmet_auth_ctrl_sesskey() logs the DHCHAP
shared secret. Remove the log to avoid exposing key material.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/nvme/target/auth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index f24add0bb86f..f62fed6bd897 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -544,10 +544,6 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 					  req->sq->dhchap_skey_len);
 	if (ret)
 		pr_debug("failed to compute shared secret, err %d\n", ret);
-	else
-		pr_debug("%s: shared secret %*ph\n", __func__,
-			 (int)req->sq->dhchap_skey_len,
-			 req->sq->dhchap_skey);
 
 	return ret;
 }
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


