Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE866C3ABA1
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s2Fq8Xsjo3BdzxkBCpDy+IJs3ujOX5gUKaxX/9NRmf4=; b=G6/7SbIaY41nRMaPg7iU4jIp39
	NshDO4A1nZL8H/TeL9AKgvwvDjWzLRXxUcFFsvhI9/IhLruMSNYwtTEar0QD8HHJCuA+vzdXbeYWh
	qQB+7X9zFIYK5USVDdqbHuH+TnZCsBkhpv4xpobUwqgqVwW6HUD/h2Xt+pBRGsPcQHoeQiGtlkUVK
	WjSuV5UGt5gWjzwJPM2ezMPp/axjF6oHqkMvbWKEIUhsS/DZSOTJxWYcJq3DAAyBOkQIZBizVThk1
	Pyx4txKZtLz8MnYEk7ChCtEnGzpfiBA4Go6cc2JQkTaWfdtlA1eY+hpZpj4LTOf0AZdJkOzPk1jvH
	aU+SgoNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6q-0000000576L-3N8W;
	Mon, 28 Apr 2025 06:36:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6k-00000005743-1gAe
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 06:36:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A55405C3645;
	Mon, 28 Apr 2025 06:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35011C4CEEA;
	Mon, 28 Apr 2025 06:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745822209;
	bh=WUI5F54Xi8Ie9+vgws3bNB9XLu9vb5Di2jDNrpeAuh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcuUVr944JJbVz0otO7vJWit8aaflYz+qI8+H9AgE8QjkM/RHw4SdPXw4H4DNOIGY
	 jtAEFKZdpQU0osfzIInZX0C52otDprkJQikKFFFqXjDWUd462XGQG3fM/Fc0h5nBio
	 iKwt63YX9xCqi2qFXcBH9iCSAidyE8bxkbjPLvc1baDdS9hp3/q9fPScLkQ40KDz6K
	 GK6MyShOgYuy+6hshBOPcz6utpy8yJbTZpGTrZDg4QxWWec/RO9JYQcXcUkGsFKpQ2
	 JJ+eFskbEiRcPd/pP8ecLfcyf3RaVXBJXR2mKgigJNHhSo40GFDoBq7ECxiP2FiXMN
	 hGnxKtKlHtprQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/4] qla2xxx: enable FPIN notification for NVMe
Date: Mon, 28 Apr 2025 08:36:35 +0200
Message-Id: <20250428063635.125879-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250428063635.125879-1-hare@kernel.org>
References: <20250428063635.125879-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_233650_488649_EF2E239D 
X-CRM114-Status: UNSURE (   8.22  )
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

From: Hannes Reinecke <hare@kernel.org>

Call 'nvme_fc_fpin_rcv()' to enble FPIN notifications for NVMe.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index fe98c76e9be3..87b5b5e73a6e 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -46,6 +46,7 @@ qla27xx_process_purex_fpin(struct scsi_qla_host *vha, struct purex_item *item)
 		       pkt, pkt_size);
 
 	fc_host_fpin_rcv(vha->host, pkt_size, (char *)pkt, 0);
+	nvme_fc_fpin_rcv(vha->nvme_local_port, pkt_size, (char *)pkt);
 }
 
 const char *const port_state_str[] = {
-- 
2.35.3


