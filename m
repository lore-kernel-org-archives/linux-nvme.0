Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B034CC4451B
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xCkYbjx2cQyuHcwYogCXd80/iygZG2u+MVDPY/mY78g=; b=dfCsQLqOUy/gcbEBTbpyWKH/g2
	/ICzg4k1NDVNaWhE2rDyJW2Fvzev96cJyqyfU/iv97Hr2dLuX1r1nUUyQ7LXlCq3vjP+gdZX4+T9z
	9Kgaz4UGyNn7lHBtX0EQrY6679DGJIcoRjgBuWgYaEdPhAvmQT/KOSl/LGC7qpFsbi20VESv9pSkb
	h+XOvTpGVjBStD4cgLZpa+rKszIXz92z4e2ZPJkWM7I9+zyYOycT5ugGamdnMhHprg1o4iXEvNjAq
	We4QNM+9I2o3emDKsAcJ6tGWH16kQEjtdNkliJjtrj1gam156z8zZDh4rSdMKEV23cVZGapVhr1BM
	s7TRu8GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkjnO-00000002Vax-4BB8;
	Fri, 17 Jul 2026 14:44:10 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkjnM-00000002VaM-0x3Z
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 14:44:09 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so5209816a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jul 2026 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784299446; x=1784904246; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCkYbjx2cQyuHcwYogCXd80/iygZG2u+MVDPY/mY78g=;
        b=q+lmGZih9uiRBThC2VWGTFapTES8UMtEJT1CqLNzXzrMhgTDjnnCXpS+ne2aUXZPQB
         FJqimIdiNzu3t8wSUErcQgkEP1+dmub6WnmfoN7bxcoUgJgh/yh31E5zjtrPVY46htcF
         VnzhVbrRL2RwvNpaoyXMSKsKVP8rTShUfQGhfYM6I+80SZKDle9liafNZOqBut51eOvw
         PNlnQ+MJ19L9T7YRp7QfE1xXnsbeEMstgiuzQaT0P4XvAeD2q2CwjHXFJqE/bgcYda4e
         RMID7knFePci8u9jCM5rPQQpNyKht76CMqoKOzKsW1yZdJgSVSdw/LDPwaJj1AlLN7Im
         z0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299446; x=1784904246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCkYbjx2cQyuHcwYogCXd80/iygZG2u+MVDPY/mY78g=;
        b=YziocQJj/UD1UXark5HNL2JUsOxf+quvSVxCJzdrIx4rO9RkyborO/g8GNC9r59Jz1
         4v14bJTju4Dici8+VqT5sua6eDKjY+qX3/zOqqg2cZtQIJfAzQt0IKjlvPilLunQG1Q2
         RcJ5AC4L96UTXAJV9yciX0j1UjhXAkOR9d5paq5GVqpLb/+W7q71yuxpZgDOuakBuN4Q
         Gm3cyt66rWtpbZ2I44JDi8YaioR5Jz9ghZ243Ec8sohGQl0LmoN10USJUySOdqk0J7MR
         KDq34IT9bv0vF1S1LPaWw0TuGIChUW9fVxx+CMkLuXr4ZM67LJ8VOVCV3Hi8mOF4Er5e
         JfOQ==
X-Gm-Message-State: AOJu0YxlppRFa43ZgYkCdRZkeDjLh82b4tZAJVBVwKaZaa2qLUZfMBzU
	z51Edy0rWjOQqcbAMAeK2iaEyGyB6HdHJ8cPjDdpkhCzq15hK0V6GNAw
X-Gm-Gg: AfdE7clQsO3n/likAdACLek/mJSknHjGFPdsFvz/++QmRkN/ssIIUdQwO8gXaGWxhnD
	JKBVnLO0ogLsgOhDGR8uSvpq8gcAYXkdwSsQV7sfpJ4UE6FPb0FuA2wKCxLSuLYDwLQOthMRnDC
	44hz1mSEhTO8rmx9uriEFbG30stUh/fivLrr9M+ZKjPiPLFqtW0UzAlz7jt5c9qzERV67zL7zb1
	s38YFgPl3eujWuXwC1DZcfvZ1zRWyFeGc7T+36+TndZA9medJM9HYPz4v8F6Gl/PE8nYi5BxZ25
	4gqIei2K488O2/TMOEE5zmukxmoSg1iM5ZRwCPQD5BhQafMx/v6HohjJKwGNFObpYjXT02NOUj5
	buzmYqt0wnXglP2fzzqSMC7+3s7hKaT3rpPgRJmPSH1Tda6Ks/k19pu/29RktGEmpNoNwRhqZPm
	QFX+j4bLVGQedWEYzkuB2s2QzayQxsgDwDFWXHjkt5g20jKQ2f5NIQXdCw2glAHc1AEzu/hzwoH
	U+1
X-Received: by 2002:a05:6402:241f:b0:697:d4ee:ab97 with SMTP id 4fb4d7f45d1cf-69e652726d6mr1158331a12.12.1784299445870;
        Fri, 17 Jul 2026 07:44:05 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-5347-776a-5ef9-a909.fixed6.kpn.net. [2a02:a463:a071:0:5347:776a:5ef9:a909])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fef2477sm829324a12.7.2026.07.17.07.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:44:05 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] nvmet: passthru: fix OOB reads when parsing ns id descriptor list
Date: Fri, 17 Jul 2026 16:43:53 +0200
Message-ID: <20260717144353.19436-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_074408_281785_030F951B 
X-CRM114-Status: GOOD (  13.19  )
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

nvmet_passthru_override_id_descs() walks a namespace identification
descriptor list populated from the underlying passthru controller's
Identify response, which is device reported. The loop advanced pos by
device controlled amounts (sizeof(*cur) + nidl) without checking that
the next descriptor header actually fits inside the buffer, so a
malicious device could push pos to within a few bytes of the buffer end
and cause cur->nidl, cur->nidt or the reserved field to be read past the
allocation.

Additionally, when a CSI descriptor lands exactly at the last valid
header offset, cur + 1 points one byte past the end of the buffer.
The unconditional memcpy(&csi, cur + 1, NVME_NIDT_CSI_LEN) could read
that out-of-bounds byte and copy it back to the initiator via
nvmet_copy_to_sgl(), leaking adjacent heap memory.

Bounds check both the descriptor header and the CSI value before
dereferencing them.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/nvme/target/passthru.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index e27f84e3cf2b..7ef02958078b 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -53,13 +53,21 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
 		struct nvme_ns_id_desc *cur = data + pos;
 
+		if (pos + sizeof(*cur) > NVME_IDENTIFY_DATA_SIZE)
+			break;
+
 		if (cur->nidl == 0)
 			break;
+
 		if (cur->nidt == NVME_NIDT_CSI) {
+			if (pos + sizeof(*cur) + NVME_NIDT_CSI_LEN > NVME_IDENTIFY_DATA_SIZE)
+				break;
+
 			memcpy(&csi, cur + 1, NVME_NIDT_CSI_LEN);
 			csi_seen = true;
 			break;
 		}
+
 		len = sizeof(struct nvme_ns_id_desc) + cur->nidl;
 	}
 
-- 
2.43.0


