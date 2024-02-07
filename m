Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEDFC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1XgcwGNiLhuNbTsKsZPDlJOJFRrpCZjlNcF1/j0WSlk=; b=S2BkLqeLXt34il6phmC+T5Ibcj
	3rId/FXmMAYua3j+7espRCGy6wgij9rSMXCfVx9k3W5mU8mp9xfZrpjqwTyZcewbkWkiPTg+1KybC
	Ptn8rCS9qieWatlGWFiH333KMciA7dbTt1e3XUmDVm1SAymub0m/xh16KSxX800FDbUxWgsh/O5zD
	avjNc1VfJaUyhggZ3J+1sS/ewHu9xC8A2oqdyytIkP9fEj+0X4T8aznpS3ComeX4Afawj6AH5G8q8
	MLKzs94ubMb3Aenq22Flakw39J6wjjA2MwUB4ZRAyrXl8UnOdclv3uMtR/oB4BrWEiEytFfBN+Atl
	5j5yxtRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqSA-0000000C6zX-0xfy;
	Wed, 07 Feb 2024 22:31:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRX-0000000BtCn-00sP
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1XgcwGNiLhuNbTsKsZPDlJOJFRrpCZjlNcF1/j0WSlk=; b=K0IR11w86nHDC8J9G+KHBevKTe
	ccw2C0mbTLApb/vhFh3nCBHfSOxcrmwN6rh+CEB1Ej8FEohTReLRu/GOTrZ32zTPoJQck7BA593Ot
	lRi6E0CUsi1hs6AjaEm/PQiM4nH5BIKlOglukroPRJGeAzep+JNmCu07+UTM3v4xRjXw0mEz4WaR/
	yc4qisLN2sYBVoioWWLj41Li4qDxGLya0Nk3ZbqFr7MqougnlKEJFfbNrX4u/ckVeTaAodI5BrKDN
	j284h2wJaZbsPaCW0ZCS9owl+AuB93EltYJWml0ejSVg4C9ficRebeo+fvtsyrHVqe1Fqz99ZTtBY
	CKEgR/Xw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRL-0000000D8Av-1btB
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 42F1F61AC8;
	Wed,  7 Feb 2024 21:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E117C43399;
	Wed,  7 Feb 2024 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341200;
	bh=bNk4/N865uxd8oiyvt2u0F/rM7pIoJSR5LF6seU25Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdvbbZYOqpRz8ZWjExseX1PjW6RIe+5l5MWAYPwT3eYUHWCwHsCy+MbxkN0KdWk/+
	 ary78PhDZn0Fu2y2g8Td98oJ5f46pwcOQonqRgJgcWKO/Ih8Ht7DtViMOdMWygI+U7
	 PkdUZ7uoWRyvKYX2cdXgvdjRipIeEI8YY89976Q+2Gc/RyVq/3bYp4SaYia6SPYEl7
	 AqCtiwYKxIVPChVLYlilqAbng8Qo7ZAbXg3/0mAWdXudtb/ZtdRd7FCo1SllXmLJb0
	 6HKhHx3NjjHGNY2PVqnEjUUdxBi15vwizQaSlbAkjnD4uXX5pSEue3A4j18NWOgWO+
	 A+34VTXFhSONA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 15/23] nvmet-fcloop: swap the list_add_tail arguments
Date: Wed,  7 Feb 2024 16:25:56 -0500
Message-ID: <20240207212611.3793-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212644_264218_72F2F9CC 
X-CRM114-Status: GOOD (  11.44  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit dcfad4ab4d6733f2861cd241d8532a0004fc835a ]

The first argument of list_add_tail function is the new element which
should be added to the list which is the second argument. Swap the
arguments to allow processing more than one element at a time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c780af36c1d4..f5b8442b653d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -358,7 +358,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 		return ret;
@@ -391,7 +391,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	if (remoteport) {
 		rport = remoteport->private;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 	}
@@ -446,7 +446,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 		return ret;
-- 
2.43.0


