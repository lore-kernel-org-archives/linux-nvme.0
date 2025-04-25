Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBD4C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 10:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QI2cEW3F5h52iZc9Ehoq+VJxwqTbDjwmj72cYYMyc9I=; b=J98v8CPzIefM9sGOahDQyiszGr
	1I5h9XavzOs86iXnfX7+fDIDFQKzwCW/yqvX+USGn8H/KJQnzgHBLN2iaDlPE5ePtQ+4UeNKZI4eb
	+OkSTWIs8dXCHj4f0dki+I+pn25feHuOScjTE7Tc/5Vr4GHAGuBK/y+CCvyuuWRMEuKP8pTNRHI/u
	tHnJF7vMDaeLGyZaycETJTuFh4+LayBTuhB7wH7LmBgJDblhSUJsaUNzulY9lX9hVEbYX579hZNDt
	cEuec4UiOlYX724IqEtXhvVm3pzHCHRxGfjONmoMrmQGf0w8ZkUEdIeQAPvmxYPUKiPH5xLyeI+Lo
	Ts6/ooNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8GeS-0000000Gop6-1wAw;
	Fri, 25 Apr 2025 10:51:24 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8FSH-0000000GZ1D-2JnD
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:34:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5B8BBA4D052;
	Fri, 25 Apr 2025 09:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC31C4CEE4;
	Fri, 25 Apr 2025 09:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745573684;
	bh=eF/09S/9IBNPld7zX3f0A47z7FRFSqrO+3+PW1APB/E=;
	h=From:To:Cc:Subject:Date:From;
	b=WoEd6HKIogY+K7TbklkYk6Zw6pcaYtCjkk0N6FtEG1gFgNWKG+q0+lgjwbhoJJyX2
	 WjoUmIskxrHODfOmnS71GViqAOcI8rsgbeeyaH7kyJ/Qn8r8+6ZOnqlLKTl2qVhVZI
	 HJLeXEjoa+sNjE/cX/iogNssfQcka5V5IhjS2xXpPwCSmxMTKVL525q89CQlzOcAfo
	 3pg5+IhsIvMN/vSsOlb9+Mikpilys6KatpapTIUvj+HrSRydY1czbSaRgKoTEcCcBk
	 RvV5UmGfC1H+c78zM4EjxzUNTcoGoLeInJRC6IZgMDV/wuW6z5RkN7bpn4Aox5QCVG
	 w1WvIi47iFx4A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	Maurizio Lombardi <mlombard@bsdbackstore.eu>
Subject: [PATCH] nvmet-auth: always free derived key data
Date: Fri, 25 Apr 2025 11:34:34 +0200
Message-Id: <20250425093434.36383-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_023445_648338_E9DCCFEF 
X-CRM114-Status: GOOD (  10.65  )
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

After calling nvme_auth_derive_tls_psk() we need to free the resulting
psk data, as either TLS is disable (and we don't need the data anyway)
or the psk data is copied into the resulting key (and can be free, too).

Fixes: fa2e0f8bbc68 ("nvmet-tcp: support secure channel concatenation")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Suggested-by: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3f9fad732350..8f67fc21149c 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -656,13 +656,12 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 		pr_warn("%s: ctrl %d qid %d failed to refresh key, error %ld\n",
 			__func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(tls_key));
 		tls_key = NULL;
-		kfree_sensitive(tls_psk);
 	}
 	if (sq->ctrl->tls_key)
 		key_put(sq->ctrl->tls_key);
 	sq->ctrl->tls_key = tls_key;
 #endif
-
+	kfree_sensitive(tls_psk);
 out_free_digest:
 	kfree_sensitive(digest);
 out_free_psk:
-- 
2.35.3


