Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5EDC10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6iUXpbNehVZ+sEsrdI/HDKEc1ZelrTx4nHFR+wTQBk=; b=vxPC6mrgNEBJ79p+HOeiCOCbUn
	/J5KQz7D/DdBfsAwA4pV7EyDaa8cAgiItYiqJ0LcslLHRgHmQYwc6cmSGAr979PEqqHReUTr7ndjI
	US0rDSAqT9b59smiObfbHGm1FQda0ivtYdbWolI1veKMtylDEG+07bVLwMgidsh7Q3a90SXOm45kW
	7tw2202f39j+1WraghjCtMQ/ooSW7CQmYq3qvOURI9HJl05vr1IUDZMi7fSTEqmIZWiD7dbjq8b17
	jN75vvYuacxkG7G3hYC3DfsNt5JoVt9Mx2b1wNbJZvJyFRoT1nD1ZiA5m16sD7vMdxrgU0ZFJX8yx
	qz4VGubg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4U05-0000000DCQb-1ZRk;
	Tue, 07 May 2024 23:13:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tzs-0000000DCHN-4Bjr
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:13:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 19EEBCE10C7;
	Tue,  7 May 2024 23:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5945CC3277B;
	Tue,  7 May 2024 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123598;
	bh=y1rhdDOxe21+WMY9S2759/oEbYoQ9ExkWEChZFtqQuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5poKbz+XIfeWAuj9CL0E5nptCBZgdxzevG6xlVtCP+5vLTjzQy0iigkbh38waqLi
	 PWxH21PCMlXxH+hU/bMi5coWgsUtUs09wbQgJyXoNItnGRYVcwPWyFm86qU0v26HfI
	 g++P7qTaJpbBWYJiZXyxLQaMkYM9P0Vg7yJCJ+RwwxQYADeVncX4uo5XlS/eLw/t9n
	 rOcYDISGsXZl2lRRpy5LBbfiCrUaGzFhtX4Vdaq0mzjtECz4YXoloOr7Bc64BPPO8r
	 WSybXCKIW5dTfDplAljB9caSdmWKjhDdaEceUnVj9tENHvgHGTDBvfwMo7wGyPdzyt
	 devtIrrOthd6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 21/25] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Tue,  7 May 2024 19:12:08 -0400
Message-ID: <20240507231231.394219-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161321_335956_1A145590 
X-CRM114-Status: GOOD (  11.09  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 46b8f9f74f6d500871985e22eb19560b21f3bc81 ]

If the nvmet_auth_host_hash() function fails, the error code should
be returned to its callers.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279b..1f7d492c4dc26 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -368,7 +368,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	kfree_sensitive(host_response);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
-- 
2.43.0


