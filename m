Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4310CC369A7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l862nbXfQ7llwmmlf2HlnMCZZw+jgpc4Nu8hPnZ2SSI=; b=2QNEpe+7wu8XB7iEoL0w+82xH3
	jCnd9+kq6JLU7asfDcmQ371eZhLjgtwsVqus0GB9/c4kHWKGG5Q3BAOAxgSJDhOWFgMUyMP+z6eMk
	PGVlbDS0NAP0AkfChIPDJpc03v11t8g+omaXf3N8r2F8HhBrXwqg9LvP+EHXwM/q6dsorxOm8AjFf
	VIDm4gIykiJCqhcIDwwuBwtSoSpG9WlWT/ZusD5ypm5Lkn4tJy/YLv5nvMajcG+J+8P61+BRalrgA
	X23NvQoSNdmYi0V2iA2/qPb8CTyvGR7tLVs99+2OMxIT883SSN1q3rwxans3LR8c6X4V0v3nfN5Ng
	FhRJbutw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Ati-00000004cRa-2PRW;
	Tue, 08 Apr 2025 15:29:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2At9-00000004cHi-2q6s
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 15:29:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AFFDF4A174;
	Tue,  8 Apr 2025 15:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEB5C4CEE5;
	Tue,  8 Apr 2025 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126163;
	bh=2Kg2F1UvaxPLtadqebSyN12HG3Ln8iAYi38zz3aODQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SKruh0wxaqHJpjAZk7Dj0zSDGUj1xJsvCR1rsKT42HC0WjdPDUQyr7tOHvUmiSKXX
	 +X4l/6IhRPkGmEi/D/gMQbGpg18xFI+9Ucz3mn2spGlwq6nx3n1akvkF4p6Oh5GGxF
	 MruRP74WLvdSIK5+ll+DnE41ru4B1NvCXamF/xeY2lkDkXqaZF3/bPVZSny7IBW/BJ
	 2OUbg9UHh/eicEsNQRWzp4S7OkMi2bwHxGlusvg3c59I9IhAXLuqRrBZCH4LbMsAMe
	 wkvomPG+1fbNdZKwgGGZkS4VBNCibx7C6FkQ8v/jAXap+Y2+dTMYd8zn8XsAz1i8g2
	 opMz1FHuLUJpA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 17:29:06 +0200
Subject: [PATCH 4/8] nvmet-fc: inline nvmet_fc_delete_assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-nvmet-fcloop-part-one-v1-4-382ec97ab7eb@kernel.org>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_082923_741754_F96A0B44 
X-CRM114-Status: GOOD (  10.93  )
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

No need for this tiny helper with only one user, just inline it.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7318b736d41417bd974f58f1ef66bce8640db422..6487c46ebba8d12e573d19fe8c39d526492c506a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1075,13 +1075,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	return newhost;
 }
 
-static void
-nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
-{
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
-}
-
 static void
 nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
@@ -1089,7 +1082,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
 

-- 
2.49.0


