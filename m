Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE4DEB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JNpQE+qPZF276zR7ezvKU/MlawZQXTCnvgqTPIFToqM=; b=YYFrp1G8q1n7zA7THdKF3NySgz
	xeFOp4/RqWSA+Kp+gJCAbuwaijaLDWomJ7GPwc1/pbbNhBw6vzn+ey/N76qk6TO6NYnceCmoGUw5q
	QdgQov71pMNWgTtcYQaljBvXAsCIXUjutRSkadNKAHMnjaiw/2FmNZzMAJtqwb/d2rUhpRuoaN9fO
	ZplwNqQbnvzytOxCP0PHJcnQBa/fImSZqdqybbOs7GjTnSlhU8fPV79mWFH0qhGyiJQGF1WbCNAQP
	qby1aeRkKErQp4E1S0dLaAQl/4mTi+4ZVVYpoO9CYYZZ5M+Ff4L9Vp+ij64rFgCfkgQMAfa1m+oyl
	W87epbmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbKH-000GuB-2J;
	Wed, 12 Jul 2023 15:00:21 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbK3-000Ghq-2S
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 15:00:09 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CDivtU032501
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 08:00:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=JNpQE+qPZF276zR7ezvKU/MlawZQXTCnvgqTPIFToqM=;
 b=c+0VCyAy7H36G8ez9m5ruPNeBMt6/0AmvllstRWy0LeXPhrINLWKlVqX8iFOncjP7Jq9
 ne82QzjSVq5rh0dR/ovHP4v51GfIZGo1/1F+V4suOBvQrD4jT3fYR0UL/Zy1+HOXewJ2
 cZMzeKqAZ6TqhJFo0SI+tpqm0Hax+40XtJr4sitJSRYT3UAUMcaiR10Oj6Tb+Au7IhEW
 FmWl2ItjO+3M1HhIhmd3aE9KoUjRRgqrM/bIoP0d/eRXKl6MVY5gbZujy8JCVFERSnHj
 zQGQlxpjRu5Ak8XQOppD3nMLnGvsOrbbH/PZMNemp+Od4qqJfbXOyqVnj0DDdqYMvsb5 JQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsg8tn9ct-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 08:00:00 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 07:59:34 -0700
Received: from twshared2335.02.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 07:59:34 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C3E7A1B7D518C; Wed, 12 Jul 2023 07:59:21 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn
	<johannes.thumshirn@wdc.com>,
        Breno Leitao <leitao@debian.org>
Subject: [PATCH] nvme: warn only once for legacy uuid attribute
Date: Wed, 12 Jul 2023 07:59:21 -0700
Message-ID: <20230712145921.85333-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qLv9vTlmEleyRMgMk7qj-dKTU80MWFxa
X-Proofpoint-GUID: qLv9vTlmEleyRMgMk7qj-dKTU80MWFxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_10,2023-07-11_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_080007_978192_9A8EE02E 
X-CRM114-Status: GOOD (  17.59  )
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

From: Keith Busch <kbusch@kernel.org>

Report the legacy fallback behavior for uuid attributes just once
instead of logging repeated warnings for the same condition every time
the attribute is read. The old behavior is too spamy on the kernel logs.

Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  | 7 +++++++
 drivers/nvme/host/sysfs.c | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47d7ba2827ff2..6984205b3514f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3597,6 +3597,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, =
struct nvme_ns_info *info)
 	nvme_mpath_add_disk(ns, info->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
=20
+
+	if (uuid_is_null(&info->ids.uuid) &&
+	    memchr_inv(info->ids.nguid, 0, sizeof(info->ids.nguid))) {
+		dev_warn(ctrl->device,
+			"No UUID available providing old NGUID\n");
+	}
+
 	return;
=20
  out_cleanup_ns_from_list:
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 45e91811f905c..0c636d873e058 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -88,14 +88,12 @@ static ssize_t uuid_show(struct device *dev, struct d=
evice_attribute *attr,
 {
 	struct nvme_ns_ids *ids =3D &dev_to_ns_head(dev)->ids;
=20
-	/* For backward compatibility expose the NGUID to userspace if
+	/*
+	 * For backward compatibility expose the NGUID to userspace if
 	 * we have no UUID set
 	 */
-	if (uuid_is_null(&ids->uuid)) {
-		dev_warn_ratelimited(dev,
-			"No UUID available providing old NGUID\n");
+	if (uuid_is_null(&ids->uuid))
 		return sysfs_emit(buf, "%pU\n", ids->nguid);
-	}
 	return sysfs_emit(buf, "%pU\n", &ids->uuid);
 }
 static DEVICE_ATTR_RO(uuid);
--=20
2.34.1


