Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24352C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:41:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54D120706
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAK7BB+c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PIdosAro";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="FEJdUmHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54D120706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FMfwt1kIXD/KQqXfetQktEKu6DyEY53SY6IIEbZ6KAk=; b=LAK7BB+cFmxpP/r3J1an7TwZU
	S58AZt8xK2gRG0QI0VzsUdN6GXK379QZKi/eYywrZIjQex59P+h6JQN6AhqiuvkR/xCPSAeVMy3N4
	3RJuK/j7DniMRRAbM5PvgKORm283wDaeWRVV0fB+EhRxOerNs9/ZUfZnDddB9QbkuD3GBW/HeIDNZ
	MwU/GIzt1bv56Iixaevt/GkUldknM0pLSwtvmgBAIU6l0iXHycQe67H7NGLgszORu1dsvqmin8t47
	Mxay48KtSOa5j2A1pRF+4DNtIUfSDUe9KtgvB6Lx5vgRrehdqKKkW+9X+Kem7om/O1FE6e6NuBsnq
	akHDUwKDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joqTH-0001LU-1m; Fri, 26 Jun 2020 15:40:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqSv-0001Go-UQ
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 15:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=W8C3oZCNAwI/CU7LQFgGNfn+5UNK6YrtFMNuciqpWTg=; b=PIdosAroyKOTmNELSe60KrhsK9
 ElmfJe9T8p2VwBbWr0wWGWj9LaTtD9OCPrW65FEDzP2EOl8Z/6TR2wwPjUfzfEIrJtDTgoHZQLb4T
 sASR60L/YXb3O+/RnfSjktEv4Q826tMBIcSuznI+c0p+iSzuFm7yEbOksD28VPQaIKIitP0veoKuS
 0ZHkv+1jJD7uOPaOFy35tZyF/txkbLoI2n5jEA1b+uotU1ImZicXOHuZsUy7OPuZ6k5EA5MfnI82e
 bF3tILvPo+DV8JkONvlpaWKKcC4r3Jx1gwg1zM3fqfqKDR+GsuKX40HhHPKU7MIcmCzwU3Dju5LKS
 uRnJsnZQ==;
Received: from ale.deltatee.com ([207.54.116.67])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqSX-0004iQ-O1
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 15:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W8C3oZCNAwI/CU7LQFgGNfn+5UNK6YrtFMNuciqpWTg=; b=FEJdUmHppv8osOMZhma2jxs5G0
 dh4SU0QarSGdE5UXPn9LNMflraxw2vhZ9MfE/8ZWu2d/HHI0H4nQtEstRnQuIwzpGf0MRCDI/7p3/
 2Fgc62svRofyDRweubLqqVmZuzri8rj/reovpy5DXlg80YLJsLveNTUO6wMAqpgiQfEncACKtx4Tq
 7jxAKreSoTKswbq1ncqB9jsYBmE4KuB2OBpX8k5AhSrHOZ7+hKSAk5s8vL54mvfg5Icri0B0kNegl
 sKGxlJ11yEO/xlMBkhAj06aSpXEJreFMdoMabUGkkkBdX/tvUPExdDi5RJRzM+I6M4M9CQAspBKRA
 srkzQpEA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1joqRu-0000oR-4A; Fri, 26 Jun 2020 09:39:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1joqRn-0007HW-5X; Fri, 26 Jun 2020 09:39:23 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 26 Jun 2020 09:39:13 -0600
Message-Id: <20200626153918.27929-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626153918.27929-1-logang@deltatee.com>
References: <20200626153918.27929-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 maxg@mellanox.com, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com,
 chaitanya.kulkarni@wdc.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 4/9] nvmet-passthru: Introduce NVMet passthru Kconfig
 option
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_164018_838603_87EB09BC 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates KConfig file for the NVMeOF target where we add new
option so that user can selectively enable/disable passthru code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[logang@deltatee.com: fixed some of the wording in the help message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 4474952d64c6..b885a9fe38fa 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -16,6 +16,18 @@ config NVME_TARGET
 	  To configure the NVMe target you probably want to use the nvmetcli
 	  tool from http://git.infradead.org/users/hch/nvmetcli.git.
 
+config NVME_TARGET_PASSTHRU
+	bool "NVMe Target Passthrough support"
+	depends on NVME_CORE
+	depends on NVME_TARGET
+	help
+	  This enables target side NVMe passthru controller support for the
+	  NVMe Over Fabrics protocol. It allows for hosts to manage and
+	  directly access an actual NVMe controller residing on the target
+	  side, incuding executing Vendor Unique Commands.
+
+	  If unsure, say N.
+
 config NVME_TARGET_LOOP
 	tristate "NVMe loopback device support"
 	depends on NVME_TARGET
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
