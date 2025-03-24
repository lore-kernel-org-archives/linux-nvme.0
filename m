Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB41C3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bdW3yhIavKxDtwyT7Mr5D1pQc92natuyzMUQokQ2Wr0=; b=GsngUofWO2BnPEjcKyc1579hgG
	Iu1kiq+GyL4evLLiyt8FEVALek8Zd3aieZ0Ty7F4Y0edjh65gl40L5yBC63tUwQUxTOLvvUk+qDoN
	X/Gh1sLxicGFjmRQHTuejRlWW01iaLNUSVP/wTLphDXnkWFrl7vDRgoxGc7Ft7Trmi7+DX2CcmwNz
	oZktkYBoQB3iDjSLmBEm++ZbjC1XitGZdKQDlfz3LOw3usagb/E2l/nlA2QO+Jom8Bi03oBoj1Ryd
	vn5/WhwCn2uNU2YbEefX9XsJAP5+AL0MKNaIlt/zLWd2sZnMPmDEcscMLG1Cs4R/3oHnDpola9CSM
	Qvmk1hpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twgbF-000000031Qq-0kaI;
	Mon, 24 Mar 2025 12:08:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twgbD-000000031QH-22w4
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 12:08:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C294961157;
	Mon, 24 Mar 2025 12:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D81C4CEE9;
	Mon, 24 Mar 2025 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818090;
	bh=MN4jerD6vCbfxLMpurlATwpB3u4sbGBPrL6S0ay1MPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D7uiS0r/ql6VYylNLycK0St8J0Pi8ApnBeggQlE3SbNMgbbAe0G6Cw+HRK3m66+si
	 dpPkH6BF8spn/9IdDsaYXjQJzhN7qt3L2xtUnpZQOmuCrv76Gkqzw+T8tbg0gnBqwO
	 pvB4Hm92iBUJyAGGXkgy7Hk+Fn/n4ule7n+pfhBLRx8lrquVWbtbZ3qHvAzOyFpVci
	 vW6FlqoaHZP2cW+NPlNnpiAg/pme9GjcuD7ukm4I7pt3VBDYnCrSUbYkvyLfHJlnnF
	 6N35ThM2i7rJD3HxaWym0ixHzhwpOXxiXYw4cOmtdSeBj9qQFrD0ZaMSVrX0xUw5iD
	 JDCC08PAmzP4g==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 24 Mar 2025 13:07:56 +0100
Subject: [PATCH RFC 1/3] nvmet: add command quiesce time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-tp4129-v1-1-95a747b4c33b@kernel.org>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
In-Reply-To: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

TP4129 introduces Command Quiesce Time (CQT) for coordinating the
shutdown sequence when for example KATO expires.

Add support to nvmet but only report CQT is available but the controller
doesn't need any additional time when shutting down. In this case the
spec says nvmet should report a value of 1.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 6 ++++++
 drivers/nvme/target/nvmet.h     | 1 +
 include/linux/nvme.h            | 4 +++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e670dc185a967dc69c9b7d23930bb52bdcc3271a..09ac5a43f70dbe3889c1b404d6b59c0053337192 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -733,6 +733,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* We support keep-alive timeout in granularity of seconds */
 	id->kas = cpu_to_le16(NVMET_KAS);
 
+	/*
+	 * Command Quiesce Time in milliseconds. If the controller is not
+	 * need any quiencse time, the controller should set it to 1.
+	 */
+	id->cqt = cpu_to_le16(NVMET_CQT);
+
 	id->sqes = (0x6 << 4) | 0x6;
 	id->cqes = (0x4 << 4) | 0x4;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b540216c0c9a9138f0913f8df28fa5ae13c6397f..47ae8be6200054eaaad2dbacf23db080bf0c56c2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -671,6 +671,7 @@ bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO_MS		120000
+#define NVMET_CQT		1
 
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fe3b60818fdcfbb4baabce59f7499bc1fa07e855..983b047e7158dcb33da66a25c67684b8f1ef5a7e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -335,7 +335,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__u16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;

-- 
2.48.1


