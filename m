Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAF2C04FDF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=; b=Yh9I9lznloZSrZZdDVEtVJKsbe
	gd60wmCpK89HCWhTQI5FlO6PbxEy1NjU7TEN+FjjmtM8J4N8bGDzITl/D4bt/lkqabHiBFFHIY6sm
	EgJRwD0eSc/55kOPkJY5OTMy6K97+l6pQvW44kZWC5cp8sn8dECYbceQ/IzyIlEaW49ViVtnC/8C6
	J1NTXbBuFj7m/mVI7cW5ydnlbxS0zmlwTE/c/i6XNeXz09XUsQBA4lf+Zy9cayIypYezT2SVi/skP
	p/aiU0ut3hzNxCew3D1kaqVE6gBnNeAxfkvre84bGB5QHaVWzPCnx+ukk00XMT0b22B9if7D1FhmL
	rfBgsRBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFII-0043qM-08;
	Wed, 16 Aug 2023 12:06:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFI9-0043iH-3A
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 12:06:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C26F92195F;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=;
	b=WfQBfQakShoBEclX+OxWoqq2lJo8fZvIsM6QhOO8ntOgzMTsH7W3NPQcDADmNkGISjzWC+
	4u2hYrVi0ZlmIGcyUShWsEcIN8KJh8L2idSlG8uKb6uQAQTJJiscQy/SZn14A5/np2VShS
	IbMyxDvPEf8Qn9zSjVgJNXG5SRhl2Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=;
	b=ZxpsdIc9A+HyisQQ5rb4Qy4lbG8jenamaoDs3+p2vPlR3S3sztI4QbAnB7+4G4GqpkDfVO
	EMERWE+ZWiAhFDDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A73D62C153;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9372651CB224; Wed, 16 Aug 2023 14:06:23 +0200 (CEST)
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
Subject: [PATCH 04/18] nvme-tcp: add definitions for TLS cipher suites
Date: Wed, 16 Aug 2023 14:05:54 +0200
Message-Id: <20230816120608.37135-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816120608.37135-1-hare@suse.de>
References: <20230816120608.37135-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_050626_162508_B6846C6D 
X-CRM114-Status: UNSURE (   8.98  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/nvme-tcp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 57ebe1267f7f..e07e8978d691 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -18,6 +18,12 @@ enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
 };
 
+enum nvme_tcp_tls_cipher {
+	NVME_TCP_TLS_CIPHER_INVALID     = 0,
+	NVME_TCP_TLS_CIPHER_SHA256      = 1,
+	NVME_TCP_TLS_CIPHER_SHA384      = 2,
+};
+
 enum nvme_tcp_fatal_error_status {
 	NVME_TCP_FES_INVALID_PDU_HDR		= 0x01,
 	NVME_TCP_FES_PDU_SEQ_ERR		= 0x02,
-- 
2.35.3


