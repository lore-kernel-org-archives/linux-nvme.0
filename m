Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F49C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PB8/YtHBPQk5a3e7JWVUtzLfY2h5zWegFlMxxdIAIsY=; b=E3kiiOsR5YwE27giIM/y0d8eE2
	KJK9FG36qv7o0o33C52BMzZMh4aEyEQD7GLcusgXYwWe5qzYdi7+C+I4Uyz8KFdoDSn1y5FzTj2nI
	MKYOkWhEboDxOVj1Wdx0uCxg6/OI0l1avSruMaSnvN+6P1A8amLh01cnxKwOTqRj0GP2YUejjH18H
	wv85cfJy8X0T4gW+vntecca0/n2L2Gm9CMFEX2KPQwhkKiax7SMwVvipTqi6ekDupCqAB6aSvogjn
	iHgh4RleoPjaNOMo8z8P7BIbw/VRBQwR8+vMvLnP2RjAOOoAqtWQT+PT/SVQH57ZInQuiFAjJt2LY
	ud7/SGsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFp2-0027ZE-Qr; Mon, 06 Jun 2022 16:43:20 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFp1-0027CB-2e
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 16:43:20 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 256GflUA009580
	for <linux-nvme@lists.infradead.org>; Mon, 6 Jun 2022 09:41:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=PB8/YtHBPQk5a3e7JWVUtzLfY2h5zWegFlMxxdIAIsY=;
 b=dbKQadhIIdpUejXfBH3IFlGYK7WrXlr8QvQSbjjPuaYE3yF1f9lLzsrdlTdTSyM49fM4
 9zlTQXfh/uCfp7eeUICCMq3TMbPKD958Aj2uhZM9nGysjlNQAx0LI3zYVUQokJ7xQYmi
 8aQxkip8j7rrv+EyBi9QOfULROZS8F6LZA0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ghe1ttgh2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 06 Jun 2022 09:41:51 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 09:41:14 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 794944C63035; Mon,  6 Jun 2022 09:40:48 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: add bug report info for global duplicate id
Date: Mon, 6 Jun 2022 09:40:47 -0700
Message-ID: <20220606164047.2549647-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vPoe_UItqSVnYNDyXjeYapIAK9Q24tTo
X-Proofpoint-GUID: vPoe_UItqSVnYNDyXjeYapIAK9Q24tTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_05,2022-06-03_01,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_094319_281229_2AB37E35 
X-CRM114-Status: GOOD (  14.23  )
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

The recent global id check is finding poorly implemented devices in the
wild. Include relavant device information in the output to help quicken
an appropriate quirk patch.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..4cda5024a352 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3852,6 +3852,13 @@ static int nvme_global_check_duplicate_ids(struct =
nvme_subsystem *this,
 	return ret;
 }
=20
+static int nvme_str_len(char *s, int len)
+{
+	while (s[len - 1] =3D=3D ' ')
+		len--;
+	return len;
+}
+
 static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		struct nvme_ns_ids *ids, bool is_shared)
 {
@@ -3861,8 +3868,18 @@ static int nvme_init_ns_head(struct nvme_ns *ns, u=
nsigned nsid,
=20
 	ret =3D nvme_global_check_duplicate_ids(ctrl->subsys, ids);
 	if (ret) {
+		struct nvme_subsystem *subsys =3D ctrl->subsys;
+
 		dev_err(ctrl->device,
 			"globally duplicate IDs for nsid %d\n", nsid);
+		dev_err(ctrl->device,
+			"bug report info: VID:%04x model:%.*s firmware:%.*s\n",
+			subsys->vendor_id,
+			nvme_str_len(subsys->model, sizeof(subsys->model)),
+			subsys->model,
+			nvme_str_len(subsys->firmware_rev,
+				     sizeof(subsys->firmware_rev)),
+			subsys->firmware_rev);
 		return ret;
 	}
=20
--=20
2.30.2


