Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A398C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLTS5yiG8TKmAITE3heBq1+8BgWlw7JqUza1Ur9xHMk=; b=bPLDWFN90dNXRxQdmV+swMJa3g
	WDu9wwbL36vyWUCohrnM9fRASHHOpzYDit4PhqmQZivuyIl8UlaaXfrPt+hdAJ/rlFDo2+Hm+8C9u
	Rgpp7hZZ6YK1NptsZgT+yN978i/ASjjFsDopz1eLB25xHN9OYj3cGXlUZ24ZEndNm9wRujXtT7JGt
	Tqji4dC8Q9xf0Dsd1yGLP5dPI/Ozr8H3a8DB7/3qLDIc6ZuUsYlrLzA2OZL5tqeS0Tb3hH+AgV1wT
	vu9ElxrJXYM3Q4dtODeo/gz7z7Ls0H4JFQJ94kawjXKpdiVdQYbRAaJ4ZIXcgS0C+4ywmSAjso82Y
	eXV745jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwad-00000005GBT-430Z;
	Tue, 11 Mar 2025 10:11:59 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwab-00000005G8p-2HNR
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:11:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B7378A46A53;
	Tue, 11 Mar 2025 10:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596A7C4CEEB;
	Tue, 11 Mar 2025 10:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687916;
	bh=WuWDNDHHzrGny6+h1sSdaUEL5TBI+E+NIa9o1p6FHAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mimU9cS+iBZ6gq1l225MeyExGzBL28c+J84+zWNSAb+vLCeSc3jQGEfQ9PhGXx3vL
	 CkId2rgb3mvQwAKn4KM39jwiU1i2KMk5dm2IUy0C8nDMkHDLlGNBlPpZv4euZ1VuW6
	 CQhsOfalIHm2+DqI6a0OSCY8v1CzfkNzmKDaJqnQfb8Cr7PgQbcOUsI4jP7Wo6sr5X
	 9rHq9oNswUSzX96j98hL6LbK5PsQ7nPtolZpX8E8WBWBTgBbNh/tMuLPgexP21Vzq5
	 OSYhBX7Ese0cDRcMVJogjwhsMDPvKotuPx19uQ4RMNzTuf6ZOam8l1OVqnomThgxlQ
	 BL3pATp303xWg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:32 +0100
Subject: [PATCH v2 06/15] nvmet-fcloop: sync targetport removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-6-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031157_653405_0DCDDE27 
X-CRM114-Status: GOOD (  12.95  )
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

The nvmet-fc uses references on the targetport to ensure no UAFs
happens. The consequence is that when the targetport is unregistered,
not all resources are freed immediately. Ensure that all activities from
the unregister call have been submitted (deassocication) before
continuing with the shutdown sequence.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index d7c1a0beeccc5778977e4bc5836345e401adaa1c..2ad213c9041ee19893b2f7e8d8c82119ba412a46 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -239,6 +239,7 @@ struct fcloop_nport {
 	struct fcloop_rport *rport;
 	struct fcloop_tport *tport;
 	struct fcloop_lport *lport;
+	struct completion tport_unreg_done;
 	struct list_head nport_list;
 	refcount_t ref;
 	u64 node_name;
@@ -1079,6 +1080,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	complete(&tport->nport->tport_unreg_done);
+
 	/* nport ref put: tport */
 	fcloop_nport_put(tport->nport);
 }
@@ -1508,7 +1511,17 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	return nvmet_fc_unregister_targetport(tport->targetport);
+	int ret;
+
+	init_completion(&nport->tport_unreg_done);
+
+	ret = nvmet_fc_unregister_targetport(tport->targetport);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&nport->tport_unreg_done);
+
+	return 0;
 }
 
 static ssize_t

-- 
2.48.1


