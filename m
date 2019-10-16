Return-Path: <SRS0=91TP=YJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47510ECE599
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2019 20:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1009E21835
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2019 20:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SuTTojpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1009E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/mVxUNPtMAN2WcVRJig5YHk/kpw93rcN2es+DB6WOdw=; b=SuT
	Tojpmra3zz7N43xw6Gu0J4dROB68zeRplxHfwPBQ2iqP0H+BWY9yolokOg1mHUrZRMNdx94C7up1d
	/ltUfPC24LzOB36BLUpmuT+Q2p5FdCGcDi/OIGPq0bWT5ziqY67M0e0DYjAxKzZMzhJbjgihvBq8u
	D+qIibOkCxpVFHXtWR+NHlnBUfjIigB+eXHkcBtVt3r6UGg0dmqyENLTCw4LTowTqh7p+T7/NNtiD
	ds4XbJuedgOsemopeqyH72qDduGr40UUD5g6ws0BSF55ezxMy4a5RQuws5XmntI4r8l2UhGlVj2nD
	WkTGI2On7EQsYQjZTdaeIhmwylwkqjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iKprc-0006e2-IT; Wed, 16 Oct 2019 20:25:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKppM-0002k8-Ok
 for linux-nvme@lists.infradead.org; Wed, 16 Oct 2019 20:23:48 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16938C0718BE;
 Wed, 16 Oct 2019 20:23:23 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-116-76.phx2.redhat.com [10.3.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82764600C4;
 Wed, 16 Oct 2019 20:23:22 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: check for dynamic controller model before verifying
 cntlid
Date: Wed, 16 Oct 2019 15:23:22 -0500
Message-Id: <1571257402-15747-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 16 Oct 2019 20:23:23 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191016_132324_845025_8D12F07A 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If controller supports dynamic controller model the cntlid returned
from the identify command maybe FFFFh causing check in nvme_init_identify()
to fail which results in "nvme discover" failure.

nvme discover -t rdma -a <target_IP>
Failed to write to /dev/nvme-fabrics: Invalid argument

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd7dea36c3b6..235aa1811446 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2812,7 +2812,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		 * In fabrics we need to verify the cntlid matches the
 		 * admin connect
 		 */
-		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
+		if (id->ctrattr && (ctrl->cntlid != le16_to_cpu(id->cntlid))) {
 			ret = -EINVAL;
 			goto out_free;
 		}
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
