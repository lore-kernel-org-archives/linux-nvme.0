Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6AFC4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 23:25:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C20206F4
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 23:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zd/3Obo6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b5h5JYJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C20206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZYaM3xrlYAk8WCPuxU9UJqVpD/r9e5jfoJEBTIM955U=; b=zd/3Obo6mjGm2McnQuupL6zee
	oqVxZxuFS/880qrlO/u6bt87Yq+F3oxdG4rlsIqhTNUxwV0XkLQi45rX0bSGV7+yE70Eu+1HCLeJV
	vgV/A2g02GA9mWB++pWmgC9QdauiZRhIoIA95xJb1nx4BmL10Lt+EeYRuWwyJuY3v5m75BckXrfv/
	czOF3fblhmSVNHA8dGCv8uq4VNF+nTt8tF/pUuo0X9/I38IsSPB9fa6to+Nf2Ucfb0XBK1pszK5PX
	4AnzzoUWPj4Qs5o8T5q0XC81MdRCd3GidJrL/AKRHcnusSZFog/5YnIt5gUoNkW6nyuDm+VwSqcr2
	PL4Sdc1yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNlTE-0006Zo-R5; Wed, 30 Sep 2020 23:25:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNlTC-0006ZD-Cf
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 23:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601508310; x=1633044310;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jgbgXOZzISAmfbAqQSzfZb9SlSp6JbSfN8YiyqFrnZY=;
 b=b5h5JYJ9Xp0AMgigfpgxW2C0Buc1DosjPq/1uw39wuTeR8PTPVzWUIdU
 GsG89OTuAicTxlq3/1gAFudjxz5HTgOKjUk13W6rSXS8vL+dgxyTsnlab
 k09h7JckI37+lKkqsbJTNQFrO75Bk/F99vN3Of3BLHwuijNkn/OQVIqXD
 2/ajjjv9MjlRGzeLdTtgJf+zQytQq0szQ+Nk/eNyX9CNvTB8+bpIYfP/I
 uAy+kMfOdl4VqKDAf0GY7HquWsIZlrbSQQaQXp4w/BgEsjlaotdDTeqk/
 z/DTms/fHrFSAhfb12jw/8KN3grOGgbzHtPBsqs/OYTtQihFk0qaM4KJM g==;
IronPort-SDR: 6ozkptnm6OsVpuznIgLDnDZQYyF/JyaFXOiEBpKERjcWN4837DJzgqGpJIDePiqBhmzgJw6IIO
 B7iny/aRsO1LptYfybIoOmR2TZ7rr/nk3Tj1S4zrnBypIlk1hGM36+TiIyWqp2gKKCFETNq0mI
 Y2AtfFQu8ZyJ6JC9yQ5Zg+sNn1evVIZFXA6BkdC4ncDbfVe6KoNaXTnGQctTEkZ+cr0+LWWFgs
 FCEmILqLpCfaycgE+18FFDsCRlcaturFvT3Pjv2YpMRzKY+CjnHzGHzQ1H4TYEh5Ds0IFRijDv
 ySI=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="149917802"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 07:25:09 +0800
IronPort-SDR: 3/rWKiQBF125Iw5iYSWB/Jaof9CcD1wnwZB9EBZ+0O/zCtSFPDtJwMZQyi961NQhrawF5Y88s8
 Ma/eE/S2uLMA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 16:11:07 -0700
IronPort-SDR: +e6CK08qMi8lupNi/rQzFklfM/HGi5fEdLVmpRObzK4cZ0y3aLLJNQ+sGA5yUBfp9hL5e0+BCq
 i0a0WuOShhWg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2020 16:25:08 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-core: remove extra variable
Date: Wed, 30 Sep 2020 16:24:46 -0700
Message-Id: <20200930232447.20677-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200930232447.20677-1-chaitanya.kulkarni@wdc.com>
References: <20200930232447.20677-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_192510_582392_936A6BD7 
X-CRM114-Status: GOOD (  14.89  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_validate_ns() the exra variable ctrl is used only twice.
Using ns->ctrl directly still maintains the redability and original
length of the lines in the code. Get rid of the extra variable ctrl &
use ns->ctrl directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 96dc87ea07b3..9a565096e072 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3931,20 +3931,19 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
 	int ret = -ENODEV;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
 
-	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
+	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
 	if (ret)
 		goto out;
 
 	ret = -ENODEV;
 	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
-		dev_err(ctrl->device,
+		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
 		goto out_free_id;
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
