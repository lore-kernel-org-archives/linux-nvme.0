Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6575DC3DA41
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/igliQWJKCd3brB/IjZTesVzuTP1MieOVjx3L359jo=; b=Ar6vdrSnjbsA+yf+MhNPVueS+k
	DKDf/5KKkhlOmvutFdT7dSToBvlT8BaS0JsUpsWhHItoP+s2z072KWMXPJngO8qW1VTNrs10C6ovf
	XZ0nLMD3pL6BTCqJn4AqCG8KuwlAYAB82+e0FnRxxh5hUYeQIdlXhzhYmiBJGUCEgU0NhMUp4ul4V
	kZkAdLxVogf4ShRjs/4yWEPsQvfRiVRGWR9FhBxHXcgXL8irYXvUv2huo9Wdc2iPy1v7/XlkqngwK
	Tmxl4RSjfjDAHJYKPhXaLIrQkzrEsgmyDdH0sksCVXGbf4MNEqPZJWy+ymP34/tE61tnwXae2hTii
	8Cw2/A1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRDaI-00000007ue9-1LUF;
	Tue, 09 Jul 2024 16:20:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRDaG-00000007udH-0FkA
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 16:20:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 18090614E8;
	Tue,  9 Jul 2024 16:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9823C3277B;
	Tue,  9 Jul 2024 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542050;
	bh=D9H8wdEEMOSwAlm1ZCn+yMnYzuqGdKpm93UdqURfZfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwAvnTniFZ6oVBzolUUeNduZnFJo7g6FWClL73ooNCpxhPpf4/eqQhEF6KnaSniXU
	 jgE+r3xQD7rOVk1l5pahwOtv9mPGljr5ZUUhfUUtkN0mEs+iESyTR84vBpUZBcmuT+
	 tikFzre2C5G0dT4vWK7aPgxbhTyoDG+4JBbY7rZ8xJn/H3mxHIwRIRalIznrCo2QdQ
	 uNDYuNf53FmXUiJnL64uliMHjAMiGZflKccJHbbQ1n+3Ph75uZYrYJ6NcuQ0Ibd4S5
	 NRkoTpnhFWvqBQrEJGz8m5kirU9hSsVebpX+LpNVLA6ayabPLpz1Lp2gRwLEGZpbCa
	 OgOFyFVBkCJMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boyang Yu <yuboyang@dapustor.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 19/40] nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.
Date: Tue,  9 Jul 2024 12:18:59 -0400
Message-ID: <20240709162007.30160-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_092052_187820_9530B621 
X-CRM114-Status: GOOD (  10.82  )
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

From: Boyang Yu <yuboyang@dapustor.com>

[ Upstream commit 9570a48847e3acfa1a741cef431c923325ddc637 ]

The value of NVME_NS_DEAC is 3,
which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS. Provide a
unique value for this feature flag.

Fixes 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes command")
Signed-off-by: Boyang Yu <yuboyang@dapustor.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d7bcc6d51e84e..3f2b0d41e4819 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,7 +503,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
-- 
2.43.0


