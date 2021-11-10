Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C68C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:19:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CDC61221
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8CDC61221
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Vx7Jq/3ygdLtgCNIWs2uX60JH95t2qVuIdyOj4xUtA=; b=teQeVygn8BDEEuZwcj/r/q2LPv
	eavTxpwUBOy9IuIQ5aWLBoVMdQ8N8cahUIsZSAfsYn+4BtjaIbDFWXhtQOyCW059Ie+utjXmbZCKu
	m8yJy+pSAGGHu5PWWpSLRUdlyMXrIbyHQBfHMwN1cbf6Iuj3Y58Ylh9alsKVRS3uJayrPm3YQSD8a
	Vk2b6W8xLx+lM8n1IWEG6HDqOYW0GJEEb71jz0fI8wMOobeKLvAk1eqN/F0QuFBYFl6EK7dnHMy+9
	WYtVxAs/29Ra3QjlIoCAI97NDMIjP1jOWRxR6fzpnTgeTAHydcxz5acGlqC1Ecpl7opjQmqsgys9F
	5RtGVRuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkjlA-004yMU-Fm; Wed, 10 Nov 2021 09:19:12 +0000
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkjl8-004yM1-Bn
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 09:19:11 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 757523200A2F;
 Wed, 10 Nov 2021 04:19:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 10 Nov 2021 04:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=4Vx7Jq/3ygdLtgCNIWs2uX60JH
 95t2qVuIdyOj4xUtA=; b=hMcdhu6DhNINAStaSvRMFyrCr0m3lf8eG9VVkvcZrk
 lCKnMYaEpmO4+/3qOxJIdnRAnJQM7TtYADCGB1JhKzvqILyPzGyH/TQ5sfeDH2DM
 NbWZKqdXTgFq4/PeiW1DJtd++9wm133f7lWvN+5iHVrrXTXB/BQkK13lgVvRMIm2
 LrTE34vIePLITLbTFN1t98E1t2LlrfCYc+c1v/yjqhKX6AZZnkyxcdV+FwBaTu+o
 nXgi8lPN14zir3Asf3EAvc4bOkFZGsL+gHhHVuvfESh5eVymydWdydhKQ5CbKItY
 1Z6RCi5bH1UQUJUjc3wwMvrKBbU3L0kkIdrjdiFWkxHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4Vx7Jq/3ygdLtgCNI
 Ws2uX60JH95t2qVuIdyOj4xUtA=; b=ew/cZYORECEutDEnGTrywLYcGYbRpKBfs
 VSIlX9f99dYXu1vf31gMD1MMBVtoLnr5ApR4R1OaF0gByaeZ1Erh7DNeaxqYfQZZ
 T5p2GGU4hLv2549tvzRfQmO9xg7xtKoe2HmG7zTWFWrjb7v4X3pkWDMMNFYTfObN
 guWwruRJT66sm+4egDRYxbgk11WH+JlCgYRuRmLHxLduvJD5VOwE6DTyfjxNzZOl
 XQzhlhH2OEm91MSu0KeM3GCQ6q1+1FuvVQagNn8EFqGhEX/A7onffnSXYkw6zwfW
 DjSrDLHU2pQzkouadEJTu5xzkGin/oGbCauLCyVSQ54CPINCVjz8Q==
X-ME-Sender: <xms:jY6LYUSdzS0_7J9eeRmuu5LTvXgKFP9XelzinDnAYue3Mu1IEMSQYA>
 <xme:jY6LYRwqfXbZbJPQIszBSSlDmZFDXrxCo1hR7OMmOG7Tz1jgjHTvN2YponB27XzdR
 pFqGUIuiG7KlXcLvmE>
X-ME-Received: <xmr:jY6LYR1uUPiY9ovt7wTdXS9BsUYxC8W8u9T5AUM-Y-3ilHdKiQBygagLLtCFxNIg0U53ltR9dIxdgKi7Zsh5P-LhQDTSe5fyjhMqcGzrIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:jY6LYYBczOpUGb7CMbSOzvq6jPPB8Q5m3ruhlLFLZJbEa04V4QuHfw>
 <xmx:jY6LYdgmYhYisu2S12UraAwiA7J0QciTou-fHZKq-ZcmDj0s_OsjPg>
 <xmx:jY6LYUo2t1Yx9dllKau2uarJ2OsOpM7-PU5rXZtEfcKn2BVuw9cRaA>
 <xmx:jY6LYbYl3TGWpFWtnN27KfWLG_eF_7yP1so7JbQHh-f2N-2u1z1BnQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 04:19:07 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v2] nvme: fix write zeroes pi
Date: Wed, 10 Nov 2021 10:19:06 +0100
Message-Id: <20211110091906.20958-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_011910_449773_0B01A062 
X-CRM114-Status: GOOD (  12.73  )
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

From: Klaus Jensen <k.jensen@samsung.com>

Write Zeroes sets PRACT when block integrity is enabled (as it should),
but neglects to also set the reftag which is expected by reads. This
causes protection errors on reads.

Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
not check the reftag).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
v2: also set PRACT for type 3...

 drivers/nvme/host/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3825b596ca16..41885ecc69fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -914,10 +914,19 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-	if (nvme_ns_has_pi(ns))
+
+	if (nvme_ns_has_pi(ns)) {
 		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
-	else
-		cmnd->write_zeroes.control = 0;
+
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			cmnd->write_zeroes.reftag =
+				cpu_to_le32(t10_pi_ref_tag(req));
+			break;
+		}
+	}
+
 	return BLK_STS_OK;
 }
 
-- 
2.33.1


