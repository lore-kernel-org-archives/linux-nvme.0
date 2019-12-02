Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E1EC432C3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 14:48:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7768B2073C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 14:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gvqNNW5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7768B2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HtIS4Kf8nCzcZRXOWsj+OBb+D4BsT+f9s25mh1/uoBE=; b=gvqNNW5Qo6UxV9
	zRxxyo4LKFSdYA/L7RQ/PexkJQXC1U7UkmaAQMlS/kpmc47PSubt3gchucLHfDJZ0JvvH1OirjNem
	+YUzHbKh5wJibTZkTMorbbvcvqiNrkYsLF11E3GjqZOBCRo3A2C/uhTMK6tF9xB9I5+EE2RShw5sP
	I1zMW59gG72MCriPnWOwXtlBqdmOozBkRIZVc76C3lzuWmpobJs1fCQ3WVF8cyY78Sw5qVm91JykA
	PRpHHummlCFCg+G36TxqFeHRDOz3KzF7jAAvxld0X0TQ0evcs3GpgUQNqX7jCWN9uUlGDpYJWdUzT
	WbY54GsGOzcUQ7gov9gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibn0B-0005dd-12; Mon, 02 Dec 2019 14:48:39 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibmzx-0005S6-Bc
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 14:48:28 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 2 Dec 2019 16:48:13 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xB2EmC1w004689;
 Mon, 2 Dec 2019 16:48:13 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 08/16] block: Add a BIP_MAPPED_INTEGRITY check to complete_fn
Date: Mon,  2 Dec 2019 16:48:04 +0200
Message-Id: <20191202144812.147686-10-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202144812.147686-1-maxg@mellanox.com>
References: <20191202144812.147686-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_064825_821809_9D60ABDE 
X-CRM114-Status: UNSURE (   6.43  )
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
 israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

This check is needed in case some other layer did the reftag remapping
(e.g. in NVMe/RDMA the initiator controller performs the remapping so
target side shouldn't map it again).

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/t10-pi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index f4907d941f03..92f86f00bcad 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -193,6 +193,10 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 		struct bio_vec iv;
 		struct bvec_iter iter;
 
+		/* Already remapped? */
+		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
+			break;
+
 		bip_for_each_vec(iv, bip, iter) {
 			void *p, *pmap;
 			unsigned int j;
-- 
2.16.3


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
