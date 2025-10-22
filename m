Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA8BCCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uyfcEZ0RREHNOhs6x6goigk756DHk7VNG9Udf6ThOBw=; b=3BlYn0PadSMsQG4UAiHadAMj7k
	vRG6DF6qedXcOWGmjn46Cg2I+41zEQvwFvsy0XWI9FdaRNHncyIo7i6nD7K9mGpg6yQMJ9XsaeSW2
	Ac6ruOq0Y9n5Q7Q8/Tqwms/P0HvxCole2AMz95hkjYTot3E8vAraPFG5+rrYHJqQDRVW6eexOTrPg
	+/U/Ab/3QdA+w6R8uDJTukr+9zXJuFWg1uEc5YHk8LGgVD8aWEmKkfPPIXjbQBIAe7YSXKoNji3jY
	1XA0crRsOLXVLORPSn3Nv04MhejXuBArV/vy3QF4Vum5oaKM+afHlpCAR2uyRVBVDD+F9e1R3qDJD
	uN6gjh0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTko-00000001yUn-46ID;
	Wed, 22 Oct 2025 07:59:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTkn-00000001yUd-44Mc
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 07:59:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 319F0628BD;
	Wed, 22 Oct 2025 07:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F30C4CEE7;
	Wed, 22 Oct 2025 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761119968;
	bh=1H4qKi4OUmPPhyxCBlj9sdSHK/xPIf2jXCgjloP6gLk=;
	h=From:To:Cc:Subject:Date:From;
	b=s1DmnmnUI2zeqBZbLPlklHkQrOA3CuvUfaHJ6sJDs94YFBrHcBzgoKsc/IAx6wJ3K
	 dbzDFaoiBjGKpTl1zoPPxaMtWbOPXLZsgguB0ar8xhNw2gMfN8To5Mcocp7tpUCxRe
	 4GCq1AioIJkljnGvv7SlNxsUbhbVWxhwycTm2MYQNBUWW+f75BuuJykiOUf5S9Wcig
	 eGSutxVkO46Cph5iGfddglEwumWcZiKM+Arn8BkqM9buxtqfVTTveBQ+NeJHg/KicI
	 RrI64mbl5NTk+Mlf/mw7xEISlIUazB7dbTFogzU9mRsQCPnjLDE+9h/LdUjZIYdnJZ
	 28N/4P5Oi/sKA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet-auth: update sc_c in host response
Date: Wed, 22 Oct 2025 09:59:24 +0200
Message-ID: <20251022075924.117162-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@suse.de>

The target code should set the sc_c bit in calculating the host response
based on the status of the 'concat' setting, otherwise we'll get an
authentication mismatch for hosts setting that bit correctly.

Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/auth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b340380f3892..ceba21684e82 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	const char *hash_name;
 	u8 *challenge = req->sq->dhchap_c1;
 	struct nvme_dhchap_key *transformed_key;
-	u8 buf[4];
+	u8 buf[4], sc_c = ctrl->concat ? 1 : 0;
 	int ret;
 
 	hash_name = nvme_auth_hmac_name(ctrl->shash_id);
@@ -367,13 +367,14 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, 4);
+	*buf = sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
 	ret = crypto_shash_update(shash, "HostHost", 8);
 	if (ret)
 		goto out;
+	memset(buf, 0, 4);
 	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
 	if (ret)
 		goto out;
-- 
2.43.0


