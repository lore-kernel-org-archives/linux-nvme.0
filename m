Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0828EC6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YpHjQo7xlhoYYr74GCWp0bdLkdHysgHQqZqSV9xIwTo=; b=njh4Tt6yO+dOx/WaEErYL+SGj4
	9RupaXLrzDv8dK3NEc6WeeJeQKPty+rOPLJRLUEgFfSsDwdDK/JWaMM4jH8rAPPgaKmbhow1agTe3
	XkZZJw2KC4Jmgpoh3KMfM6aMjDm1GXVJSeOuLi21MRdexXTVnIS7DTO7hab3h069xHs2v9HTyVTEJ
	qtjmYem5OF7vpQ7+jVUUXxvH1gLxaGtATgTpwWXnhqNyoK1QusTxomIyyxpilxvvKm1VSDwggM2O/
	huj7ct2GBjFHh9snEh+pBmm/bjb/TquQM+mNE1ycAGFXlJmKy6aHWR5yIiBqoFcY8k7aNnhw/0CcX
	tcu/pYHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peDac-008o6L-2Z;
	Mon, 20 Mar 2023 11:22:10 +0000
Received: from baptiste.telenet-ops.be ([2a02:1800:120:4::f00:13])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peDaa-008o3s-0f
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 11:22:10 +0000
Received: from ramsan.of.borg ([84.195.187.55])
	by baptiste.telenet-ops.be with bizsmtp
	id abMx2900d1C8whw01bMxVl; Mon, 20 Mar 2023 12:21:59 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1peDZk-00E1jv-VC;
	Mon, 20 Mar 2023 12:21:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1peDaP-00736z-OM;
	Mon, 20 Mar 2023 12:21:57 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] nvme-tcp: Fix implicit padding in struct nvme_tcp_term_pdu
Date: Mon, 20 Mar 2023 12:21:56 +0100
Message-Id: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_042208_398550_4D5D55C4 
X-CRM114-Status: GOOD (  11.70  )
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

On m68k:

    drivers/nvme/host/tcp.c: In function ‘nvme_tcp_init_module’:
    include/linux/compiler_types.h:397:38: error: call to ‘__compiletime_assert_723’ declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_tcp_term_pdu) != 24

Indeed, on m68k the minimum alignment is 2 bytes, not 4 bytes, thus
triggering the check added in commit 7e87965d3807ab1f ("nvme-tcp: add
nvme-tcp pdu size build protection"), and indicating that NVMe over
Fabrics TCP on m68k must be incompatible with other platforms.

Fix this by adding explicit padding.

Fixes: fc221d05447aa6db ("nvme-tcp: Add protocol header")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/nvme-tcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 75470159a194d97f..ba8f82672e39730f 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -115,6 +115,7 @@ struct nvme_tcp_icresp_pdu {
 struct nvme_tcp_term_pdu {
 	struct nvme_tcp_hdr	hdr;
 	__le16			fes;
+	__u8			rsvd2[2];
 	__le32			fei;
 	__u8			rsvd[8];
 };
-- 
2.34.1


