Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E6C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fmdxDCqYzaVvw6/Q74bXrhYczR1nHD6qwmiJWKu4mPQ=; b=3GhWFbk0XjU0tF91DnJ4xkFpbv
	T9vARQuzTSqBrMtV86rEeLaQDuEL4x8cWi+V+CT72U2z7364o2V9teQAmWaiCD25EY5YX+bWWBgxK
	wnPW3iecrMbuHgdbY5mPR97nBAPB+14uCuS5ZZ+aP3t2l3yD6/Sr4S37j5DfNolJmaVXrAOt5pWq/
	9yJ/xfaDUljyv5YRjRakXIDr2ZCmZKzCBHY5SuMyxt5FVjSrlnF6oThGleXtha1/xAsHOAX4qmDmY
	UF1BNLoo3JNAhFqUkbp8KY51M99QFpDNyS8XfuyJZ7UlkOqczPIXxeK0d0e30/RTARYwN4uMwY84c
	4FqA0bew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7FO-007y8g-0z;
	Thu, 10 Aug 2023 15:06:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7FK-007y4J-16
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 15:06:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id E73D621860;
	Thu, 10 Aug 2023 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdxDCqYzaVvw6/Q74bXrhYczR1nHD6qwmiJWKu4mPQ=;
	b=xl9AWQYeOqVi1myswujta0dy3TeQLii05Num9BBdx1MckivxrF5vUXWn+93bsiU+L4r8Jn
	vonMnD/uzzz4g/stz/q+F5HxDzIxR2z8WyCFhMFMWIgfXGA8LbybIjcCvavIu/pTQh3nsJ
	hgqfbnl6parOvdYUavTBA4R283kDfx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdxDCqYzaVvw6/Q74bXrhYczR1nHD6qwmiJWKu4mPQ=;
	b=LA3qE9IbzERnufTOvf/Bbxxtvl53bTZ/3qF9gMGjBbvXfpCq0WMRZ0Xbt7joqZMWkPFcBc
	cPMdYc55JmuulBBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E74342C14E;
	Thu, 10 Aug 2023 15:06:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D956851CAE42; Thu, 10 Aug 2023 17:06:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/17] nvme: add TCP TSAS definitions
Date: Thu, 10 Aug 2023 17:06:16 +0200
Message-Id: <20230810150630.134991-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_080642_533635_67C166DE 
X-CRM114-Status: GOOD (  10.15  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/nvme.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26dd3f859d9d..a7ba74babad7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -108,6 +108,13 @@ enum {
 	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
 };
 
+/* TSAS SECTYPE for TCP transport */
+enum {
+	NVMF_TCP_SECTYPE_NONE = 0, /* No Security */
+	NVMF_TCP_SECTYPE_TLS12 = 1, /* TLSv1.2, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
+	NVMF_TCP_SECTYPE_TLS13 = 2, /* TLSv1.3, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
+};
+
 #define NVME_AQ_DEPTH		32
 #define NVME_NR_AEN_COMMANDS	1
 #define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
@@ -1493,6 +1500,9 @@ struct nvmf_disc_rsp_page_entry {
 			__u16	pkey;
 			__u8	resv10[246];
 		} rdma;
+		struct tcp {
+			__u8	sectype;
+		} tcp;
 	} tsas;
 };
 
-- 
2.35.3


