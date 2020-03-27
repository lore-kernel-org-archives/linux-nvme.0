Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA72C43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:18:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DBF20578
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PofeYqsY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blQc0USL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DBF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EYInCnDETZuLVhw/5cEi4HU5WqxafkOlhD/hVpurczM=; b=PofeYqsYGjBifl
	WYxpvLwOMSNG1o/bO6lYpWlBOdjOLdF4BcfjvdiAqBwohMymjs8iWbeGjNDAwuMbsa9tAa4T9OA6H
	sQ1jEzSPRCAwwn8geQ5RSg5bmkaRp17WJL0nAEh/0SdlOIZcYi6YnbpxDCIazDbqHHc4MLLc4dd0o
	+4yEuavpne0uQMPbc5M6wTr4tZXvFzkUnEcojYuM6PauAkmrxaxQQnuYOhZLTHyBfGQLmy6KqD+yE
	zQ0fwDUkcN4KeDlHdheRYeUFbM3oWvNEBlWp8ic2OWBduJxrMsNP6aaxmuP+pO3xQRFPV7QLzbuXx
	byvMDABrcXCcQHjL9hcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHsd1-0001rc-Kv; Fri, 27 Mar 2020 17:18:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaS-00084O-Rx
 for linux-nvme@bombadil.infradead.org; Fri, 27 Mar 2020 17:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=AY/o/LzWbQxe/uzEdJlNBX4UbhgC1KQASdsM7uHk7rE=; b=blQc0USLi8NhAg68fWQJ+QLCOo
 Cng31IJiEqqF3K8yN1hOkPfoHWYJK+/vNPG74Jnf8H2yaMGJR75mi80J7JkyBZB0SVJmpsFr8HyS2
 im2u8VnfniyJWEbPzUa8Z0JK+3yqmzzpyG4Y4c2aCIiYha7Xsp0akmPjar4IlUxDOaAalMIYMVIho
 IbsU3ptEFWUv14QBGSlQIowyDIbGjnsLL0YPL8LAK+/YpbWoDdcXFmXO14kz0aFqT/WLxXBD0vOhM
 wrzJjqNbaqS4nMz12wxk9iY48S6Km6AQ5kxCcLB/uIpix97jqI5t8rbKOvYGLZ6Rl5UXHjkWdsPQN
 Dg11s8Dg==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaN-0005Dr-BU
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:16:03 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:48 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjG004869;
 Fri, 27 Mar 2020 20:15:47 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
 linux-rdma@vger.kernel.org
Subject: [PATCH 13/17] nvme: Add Metadata Capabilities enumerations
Date: Fri, 27 Mar 2020 20:15:41 +0300
Message-Id: <20200327171545.98970-15-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_171600_077818_A661F7C1 
X-CRM114-Status: UNSURE (   7.95  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
 maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

The enumerations will be used to expose the namespace metadata format by
the target.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 include/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f..4e968d3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -396,6 +396,8 @@ enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
+	NVME_NS_MC_META_EXT	= 1 << 0,
+	NVME_NS_MC_META_BUF	= 1 << 1,
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
