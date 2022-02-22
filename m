Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EC9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/D2PK6+/cfWn+SCy45HN5KBWgHkNQFK3LmX+dzqRT4=; b=Ncv3TbU9tE8mrmmnqncvbvnNMZ
	MqY9sagInr9p5IxUHBdRApravVKjlExHuVm0gGHR1kpdKwncsAJOeGaH3FOma2M2tlAlcuNTzeiSo
	V9xsZeLCUFAuGDLkz26VtLEwUjm+6CSQsDZ6a8A+GPMgr2vro3szY0QAIWYyG65IC7ud37Noc7ob1
	jS6vaJmlbf/2w6kjzX1Nha0eyTlPZXoQOvqqe1czcGa/WTK86K87cOsnGrJQ/iHGJAoUCgKUssyfU
	mhv+rfaL+rkQF5s5lrnzlGhzRSUa2QgWMiHZ4Lk41uwRZiXUJqkVEZ3ljAwc/4FUlRZFsQhT15/7e
	rdf6CaeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMY91-00Afr4-68; Tue, 22 Feb 2022 16:36:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMY5P-00Adqa-RH
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:32:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 63EC760A54;
 Tue, 22 Feb 2022 16:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709A5C340F6;
 Tue, 22 Feb 2022 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645547543;
 bh=r/bd83ebHmk3oq087sNFUNNVtBRYLznJSmRLMlpTbUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GCSf5tRNML33gIhC3sIrrGWNIgk5kvVblmBu4I3xUoYSfiBZQ7ehJCYaFMnjgfYrh
 OEya2ydwEKX3H3fD0dwoZ6w+H+uVTnLvXdVh13m4ZYJeOwoVOR8FpM5mREFIghRXun
 Hbo1Vj+fgL7RwAtA8rRkuMSwCelOJIR8YWHIIT259xvZllYv4OVf9/3czpEuPPVy05
 LfWvNjQZxOLoyJOF48fW/B6VWOY4CLWhcn4SoZpbDixEkczclmp/n15F/B5+EtU2/C
 QIy+oT0tinibuGXLKZUog8+xSn83qCPVsd+HVtOq+tDiYftWhlgYVwby4IeweuNnAO
 rEhXiElbv4AFg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Date: Tue, 22 Feb 2022 08:31:38 -0800
Message-Id: <20220222163144.1782447-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_083223_943337_84D3D1C3 
X-CRM114-Status: GOOD (  10.25  )
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

Recent data integrity field enhancements allow 48-bit reference tags.
Introduce a helper macro since this will be a repeated operation.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 33f47a996513..c1fa9fc2b5cd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -63,6 +63,12 @@
 }					\
 )
 
+/**
+ * lower_48_bits - return bits 0-47 of a number
+ * @n: the number we're accessing
+ */
+#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
+
 /**
  * upper_32_bits - return bits 32-63 of a number
  * @n: the number we're accessing
-- 
2.25.4


