Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCC0C19F4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eWMaiiKkeAEbU5BHEDLXaAjD/fEbfSYnx+mwVM57k8Y=; b=PcnBCs5wwLlscQx7AmqUigjjYO
	d3aAbVH3DOSw2Jk6jYjPh1S4TpZcxRlZEGipFBeXNGpu+gmnsyBeMmI3IbI/h+2VEaWBV8o54rdkl
	RWrZLiNV5qT8qnG5Kj17STqcCetXv0GMXpWe0mRq4qGcEFYfPdEBr/51fJsOrLDxEQb2Rv3iKqotu
	w5PGbVC4K5ns13y38b5n6cL5/3LVEvr4AKAVXpSxkDIkBTca8G8j9Tf286FFtGevESu+jbFUrEGS5
	s2FrtXhoRMGPZLstWwMs0o+5ZUQNIKpEPHTNmZCrd/ZVQoFckIrY44cHOmBpQjy0njjC7Y6sGvj89
	eBrvyh+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Twc-0000000DA9F-234G;
	Tue, 07 May 2024 23:09:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4TwZ-0000000DA7S-0wrM
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:09:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A180361681;
	Tue,  7 May 2024 23:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B633C3277B;
	Tue,  7 May 2024 23:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123394;
	bh=uiAzBqoKilL7XrDCrfA109bLqKJzCbNHim/HtuZpb4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S26LMnI4pf/I/FLhHgdjYKRTWjWLSa417nzETJ+s5Q4VPqw3W1BEnfeCKfMwD1NDT
	 hwr2a4P2V34QZXfI8envXosMfPbdnuVcU3TjBftNclakw4n9Pb/+szNUG1gen6DoPw
	 7ZOKCo7XjCVHo/kfXvTj/4dWXSjlh4q8N+m762jN3ewhkqPxi+IcZy+ciT+8FNIWmT
	 ROZ0vbqG4rhrSyKNsGNDB8m9AItNU1md2ijx8tQr5baJapGZFFoeYlRJJ0y2GtaPFX
	 scOEAHk8nxWdz85zVuMTigznVEUPdVJXY7KxdEWeMMv58RleeHCs/0aL9pLH67I9MT
	 o/iTzfAFCnDyg==
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
Subject: [PATCH AUTOSEL 6.8 46/52] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Tue,  7 May 2024 19:07:12 -0400
Message-ID: <20240507230800.392128-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_160955_331340_099670F2 
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
index 3ddbc3880cac8..9e51c064b0728 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -370,7 +370,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	nvme_auth_free_key(transformed_key);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
-- 
2.43.0


