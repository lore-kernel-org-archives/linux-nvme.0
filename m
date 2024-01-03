Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6498EC47077
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TLBb7DQUElgXNvrClvdksa5Uy8ZfaNeQxv6yIl0GIds=; b=ewmscE5IrZW4+OIKpjeXuz960m
	9cbJqD2anU2ZL4UWII1FR70BQB1gf4Lwc8v4Ix6i5YHze/gtDI8X9iJ7HyHycFBFcaJ2y1+QJwKlz
	W4SB84MpW9haPGN+CZc4wq4x3LKv2O4DXGMW6tB5HIjHwd0osuHKxNamDqp+q6TlOGPJo58WdOG9i
	vtpNk4vlNWVtCcXpqEiD2AnlD4w5n4Qcj0SCtZYmiR+ccHtPVqWPpGHX+1Gi+usJhgDFPK8RIdCh2
	rcO9w7RnXbZ+/irrOF/sPKdZvy+nK5Nwxetsd9O7zZ2ZXimcg3f+bA76zT78+lE2WBK6zvbrD0eBl
	tPSjwvJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3cG-00BJRO-2L;
	Wed, 03 Jan 2024 15:57:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3cD-00BJQX-2S
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 15:57:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 590A76126E;
	Wed,  3 Jan 2024 15:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B40C433C7;
	Wed,  3 Jan 2024 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704297428;
	bh=NpPuzQFBGbgeu9AeAOqJOV1DXdhIz90+Va4NzPBZOdM=;
	h=From:To:Cc:Subject:Date:From;
	b=faOA7cXYIXfg6x8l7HMNTrgs7Nbr/DyiDw0mx6ONZ5H2KlMWcmx54k8Gx+Xwi16gz
	 0W9fvhrfuIbCevzLuUA+4IV5SSRSCT6H45ldbvYJ1PU4d1/iTC4i/bkEJ7RdSwTgVR
	 u80wcRWQnHpjXylTi3JdpOyLFKl40YElLrvZXuOje7RijnPVP+ba8RlX8Pel9U1c60
	 CMIoa2ePFb37x0xNySPhjXmSf4fA/2yX4rvadYY3f2TMaBfcH9Rcyu6tJPljr2eDk9
	 SbFnj04EgcDwbiNhlVlMB7E/gyHXO1s8J2mG2PVqX+Jh82+aABEsLsDdpTtBET5N3T
	 H0N0q5+gvut8Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Date: Wed,  3 Jan 2024 16:56:55 +0100
Message-Id: <20240103155702.4045835-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_075709_861907_A14E8DC8 
X-CRM114-Status: GOOD (  11.73  )
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

From: Arnd Bergmann <arnd@arndb.de>

An earlier patch had tried to address a warning about a string copy with
missing zero termination:

drivers/nvme/target/trace.h:52:3: warning: ‘strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]

The new version causes a different warning with some compiler versions, notably
gcc-9 and gcc-10, and also misses the zero padding that was apparently done
intentionally in the original code:

drivers/nvme/target/trace.h:56:2: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]

Change it to use strscpy_pad() with the original length, which will give
a properly padded and zero-terminated string as well as avoiding the warning.

Fixes: d86481e924a7 ("nvmet: use min of device_path and disk len")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/trace.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 6109b3806b12..155334ddc13f 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strncpy(name, req->ns->device_path,
-		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
+	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
 }
 #endif
 
-- 
2.39.2


