Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B8C3A5A0
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840842064A
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F8N/yksW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="djMSaJML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840842064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=10xoX22ieYBfCd/Zquf1SehE0kSIc4uFNcQuoYOwd04=; b=F8N/yksWas4LbL
	6aM0jpYJsDYpS0RV3Y8b7ftxRNdD6QtKqqhGEHOfY025Be7o8AzKiSL47pjHaOYvPq93xN25W0w/E
	nw2+OdP5K9SZx1QKxe2MsyQ1A2RBHAEE6HyLvTFyHY0NBCA0OFaDu6tVx04FRD2x2BqwCKkDJ25Ri
	EIu7Z+G3SrqsGGGCVBc7VAQyEVjx0YRuNq+fQgKuyKzVNrHYiJVerX8wBdmA4oy2LPDWMkBmasdnR
	LIWjU/OxouUw7r5O1hSh/+o5kol4qF8sLS8+2lvAz9qtGdepRHYQhG8uo/pxuSAEG1Y0geVE8GyBk
	MC1z2wsKKf1Ezk7XpMrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJke-00018P-Kl; Sun, 19 Apr 2020 23:53:28 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJkP-0000y8-Pb
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340394; x=1618876394;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9o35bobY+p5isBYQzb5GyCx3c+5Lx/Z0YzjLi40ntrI=;
 b=djMSaJMLT22w/nao9OKVkxcsWEecQ9g7xnjYHF0mAkXyw0jKSZwDOV08
 lnt64HAPBQ+/B80ZANAvSoOSrRaFEC8sj1vDsG99NmOTy19KUqa32q3Jv
 c8rcenOePSkOr3yqsi1DD3tn0Tf0ffnCnNUs7Ziv/zaKxgA6l0D2wNKXW
 aJbVqmTfXyIZAw15f9PLzE8xL2r2i4hm8dZrPkV6e8Fs6dVyY3RtvQLli
 xZlPZVTnxUSgs4Ggy3XbpBkD341iMnNyW8JZ2VW7T7j3eipNPJzYmQw4F
 qph5tSm9ga6hqPBLJXb1S0LWXZRVLlfWj3Kdix8jXbx2v+6yrrS4RpiuQ g==;
IronPort-SDR: /TMXHzyIIm5TwsoOovxBX6JCd3RjnIczAn/2PXcIVo1GwrIulvtOsKYaMSQUZ4DSNnzvBf1lq5
 tcn1C1lW0Pl3hcTAW68l/H/z0TMxGkZrkRhZCNl/rmgpdGg1Vme9usyx4/Q7StKCPgmFJv5Bow
 rMXAu2xchWIAtcNBJPpR9Uh/VAkBv33iZjYIkOiGnKbEAypxmYiPBhp6Vm9cxnkbpvvU8/tm5x
 v9U/o2m4H2igIyG2YO6HO8saGiMUXqVDFL5NRwOGW6r4UnIrInUmN0rSdx71qIhTzTCSo7fdpp
 i8w=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="140022590"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:53:14 +0800
IronPort-SDR: Zm1/WBRYBbWV0iLBxQ0yqgCH5qkXQfIdhk1wnh96pJKJo1DUNavdk66JOMD3t6hdCiKZxe/OaC
 RPyjFdyiknCygV7icjk2Y3Pdw5Z6OcQKI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:44:08 -0700
IronPort-SDR: oyRgUppdacbOm7+mOG55y7z1ayoP7eDx76zDKouEM/Xz04BGjFBryIZsvgvGfqo5DCD11CaPoq
 IAQWfJReCmnw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:53:13 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/6] nvmet: use type-name map for ana states
Date: Sun, 19 Apr 2020 16:52:39 -0700
Message-Id: <20200419235242.60355-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
References: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_165313_846745_ECE0BDA5 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Now that we have a generic type to name map for configfs, get rid of
the nvmet_ana_state_names structure and replace it with
nvmet_type_name_map. This also now allows us to get rid of the found
goto label which exists in current code and align code with
for-loop-compare-success-return pattern.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 67e8d53c714d..bb0810f28541 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1149,10 +1149,7 @@ static const struct config_item_type nvmet_referrals_type = {
 	.ct_group_ops	= &nvmet_referral_group_ops,
 };
 
-static struct {
-	enum nvme_ana_state	state;
-	const char		*name;
-} nvmet_ana_state_names[] = {
+struct nvmet_type_name_map nvmet_ana_state[] = {
 	{ NVME_ANA_OPTIMIZED,		"optimized" },
 	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
 	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
@@ -1167,10 +1164,9 @@ static ssize_t nvmet_ana_group_ana_state_show(struct config_item *item,
 	enum nvme_ana_state state = grp->port->ana_state[grp->grpid];
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state_names); i++) {
-		if (state != nvmet_ana_state_names[i].state)
-			continue;
-		return sprintf(page, "%s\n", nvmet_ana_state_names[i].name);
+	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
+		if (state == nvmet_ana_state[i].type)
+			return sprintf(page, "%s\n", nvmet_ana_state[i].name);
 	}
 
 	return sprintf(page, "\n");
@@ -1180,24 +1176,25 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_ana_group *grp = to_ana_group(item);
+	enum nvme_ana_state *ana_state = grp->port->ana_state;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state_names); i++) {
-		if (sysfs_streq(page, nvmet_ana_state_names[i].name))
-			goto found;
+	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
+		if (sysfs_streq(page, nvmet_ana_state[i].name)) {
+			u8 state = nvmet_ana_state[i].type;
+
+			down_write(&nvmet_ana_sem);
+			/* makes static type checker happy */
+			ana_state[grp->grpid] = (enum nvme_ana_state) state;
+			nvmet_ana_chgcnt++;
+			up_write(&nvmet_ana_sem);
+			nvmet_port_send_ana_event(grp->port);
+			return count;
+		}
 	}
 
 	pr_err("Invalid value '%s' for ana_state\n", page);
 	return -EINVAL;
-
-found:
-	down_write(&nvmet_ana_sem);
-	grp->port->ana_state[grp->grpid] = nvmet_ana_state_names[i].state;
-	nvmet_ana_chgcnt++;
-	up_write(&nvmet_ana_sem);
-
-	nvmet_port_send_ana_event(grp->port);
-	return count;
 }
 
 CONFIGFS_ATTR(nvmet_ana_group_, ana_state);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
