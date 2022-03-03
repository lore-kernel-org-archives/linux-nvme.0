Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96265C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTq9IjWsjsmO08kTvU6354DQ4aL6OV4+8Pq7GTObIkA=; b=BXJjK4pCmwBRyAKxz8/VH6tSd9
	ZWD15fHVkrFoJrzLAeMF+ehZLzLfyoacqfb7MLVQ3S9VmRZBHthXCyMVsgLEaeE/4yeY3fBZ9pkWJ
	8Af1wC/hfEIjqq6Q2u5R2ojCEggpZmh917BrblDhYtKRhOfhyDUlIQ0SIdHAIjsTu6x5MgY4Lzf9D
	AalWF5zas8Fsv223I13eiKNxGw2SvbS9h3gbKky90zQdx1172ZMbLFtvfUb4OeSobhtKYHcMVBRj7
	X0fWfc9Us1oy/eQorfBuLKi5HODZHgDCIKhDaq6OROHFrqzQC4cMNbDJnTP0/wyR33ooCUCyNvJS9
	EeW7qNbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPrpu-007fZw-7F; Thu, 03 Mar 2022 20:14:06 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPrpD-007fFl-1L
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 20:13:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AD25DB826D5;
 Thu,  3 Mar 2022 20:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C32C340F1;
 Thu,  3 Mar 2022 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646338400;
 bh=z3/R9w70Bu9dBfiawHudSlINUX1Tv3ukTkQdVZxpKko=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b65dP9xSQ7Fuff/lcNr6j4QM/x9FowDNeQfK+XRKSj/e+mn6WmpIGEXTndsVzx6eR
 MHKeJen8M8NG7GcS65GVUXhr9tbjzNxVSU77J3SDlN2dfkTZB6Aw6qQoHgmJ+MdT8X
 P4ZxXZTJkRrRdfM8iXiY63HU5CavQsChZf4oWVpheBsMxFEER1n/OSREAsQ7mFU0+V
 QMwz0M+hzGEuSHpzTL5U+fk7FpxCt6CliC4YZbzyEpZAbQ+lvyuKnr5aWIsvE7BVTf
 jMxptSG9ojNA+JF7+lVhvL/9sAMKrzl4rW/HpP4VDmbIzzo40/fpE/mzqPn3nzoYkh
 ZLnezYAavzkUQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCHv4 4/8] linux/kernel: introduce lower_48_bits function
Date: Thu,  3 Mar 2022 12:13:08 -0800
Message-Id: <20220303201312.3255347-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_121323_246408_E43DCA03 
X-CRM114-Status: GOOD (  10.04  )
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

Recent data integrity field enhancements allow reference tags to be up
to 48 bits. Introduce an inline helper function since this will be a
repeated operation.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/kernel.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 33f47a996513..3877478681b9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -63,6 +63,15 @@
 }					\
 )
 
+/**
+ * lower_48_bits() - return bits 0-47 of a number
+ * @n: the number we're accessing
+ */
+static inline u64 lower_48_bits(u64 n)
+{
+	return n & ((1ull << 48) - 1);
+}
+
 /**
  * upper_32_bits - return bits 32-63 of a number
  * @n: the number we're accessing
-- 
2.25.4


