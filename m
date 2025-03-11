Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5DCC282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vFBd+KMb/xHcG4EieahsQb9ioFKZCup6vxKbQbF/xc=; b=CJ6Dbd8TY/7G6ouhv0fUsKBWSO
	bGg7DKVRP0nm7eY7uDuiwO6mE0hAAlRxwecjHBQo7Y/P0SeSgh3i9dzyOw5ZPKshkZx6pIqaXZSZf
	Rg+fBtHMlUKv42k8KxfM7VOy4GsTB1FJIgh6NQAt7TJLleD9jU/BlIz5TzoRlSg/G+kAS+UXHKNY2
	FaVhU5AxsdtCBOgh37v3WRInKD0A1UJy2VgbcFmnuIcaSdVolDxWLp72uBqbEWw3OZugnTS2TwBYV
	cySreLqxQ6uiHHHzpNeWUhaS07mQtKfYzNae74LFbzPjJzGn+0AsJBFuExWKWDby0mN8KsZFNGKXw
	RNOg16Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwam-00000005GLr-11L5;
	Tue, 11 Mar 2025 10:12:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwai-00000005GGs-45wy
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2FBEEA46A59;
	Tue, 11 Mar 2025 10:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0BDC4CEEB;
	Tue, 11 Mar 2025 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687924;
	bh=flQexbYF3QilRpaBp1cdduWN7JQejk/TogRhckVTrgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p2D1LHtTuMyBgwVrL57gwsUWRkerZp34wJnjMKv2HjV6IHtMy3o61+Uq7f8Uq7lCx
	 QZEdl/KcKYfYaphPztRdChl5Ss+Bp88fXgdftUDboYvWKJ/XnrFzmIoej9opFhBaZA
	 7/9XQYqnzeT2nwYHiaF4HE2uE2d91prv5vmixDmTNBqGnBbmBuTEpIBE73R7QV2MHS
	 1AvSG5Q6EQxO8kHdTXqLGm4SM2vL0A+vObAMghRRq0N5G+e+19uF9KhnskBzyoelW5
	 QCE4Sel+KPPQAS2DqUDv0bIebpActlGkE49PZhL89NhY7ipEsXBK+frwBABIaoE9Q7
	 9NYnZ0jLq2RjA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:35 +0100
Subject: [PATCH v2 09/15] nvmet-fc: update tgtport ref per assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-9-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031205_087495_84F11894 
X-CRM114-Status: UNSURE (   9.13  )
X-CRM114-Notice: Please train this message.
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

We need to take for each unique association a reference.
nvmet_fc_alloc_hostport for each newly created association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde3257147a59321e8f13451326302de0..b807b4c05cac7fe4764df3df76f8fa50f4bab6ba 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1157,6 +1157,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		goto out_ida;
 
 	assoc->tgtport = tgtport;
+	nvmet_fc_tgtport_get(tgtport);
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
@@ -1258,6 +1259,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *

-- 
2.48.1


