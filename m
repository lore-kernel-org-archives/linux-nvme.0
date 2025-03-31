Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F04C3600B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Dg0M25LmJlrKmemzpRFcg/4NQv//VE2eE8J4mbDASLA=; b=iw00CRzkLkukJqcJ9jjkb5RH1v
	CZsAJSs9zfRalFH+H2X6TlTlSKU5pnlYO5TZuUnB7OkjGvXnJyhNYlfsUYW9qm+GMj7wjv0ZbPwjX
	0L7P88X5Cum6946gZV7d5f2XtRGvhCFXXL8sY4B9rHm0Xc7/udhjwJ+3fM2rSmZWQYZkCK6KhXJnX
	+YDm+6npq27f70FaABtxpEpmXG+XbBYphN45/xxmdiKDRZmj+9CRBt4RkN3jwz4wUOQORg0G83C+Q
	VjSWbOTH9etjOy4jh1BZTlQ8lKqgMkJAskDwk46zA2VVepYJPYzdhvg3Hs3aDF/VqmiMl97/hZ/WK
	exQ6Axhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzKhg-00000001Dq8-0VTz;
	Mon, 31 Mar 2025 19:21:48 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzKVD-00000001CJR-2UlH
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 19:08:57 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VImblu012422
	for <linux-nvme@lists.infradead.org>; Mon, 31 Mar 2025 12:08:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=Dg0M25LmJlrKmemzpR
	Fcg/4NQv//VE2eE8J4mbDASLA=; b=GXuFfeTpiN2cDzW/eAOHl4tkDfDCPigAnA
	invH4YzTNDeJkmNaE4S1CqhHMEbeHuBEeHT6p+lM3NdPcM4uqHosRG4suAqfsTSL
	n3ec8TKG9C4DknqjnbCV7NrFexRkEnCLRRg9jxuLRl1EFq4fN82Vwp33yDmHS1k0
	myMwIwtkvyWP+agmUdeBX3YQ6sUnCbBqDAokoC+IPsdhwyYzWKmUTm+QS3XN3+Do
	3/iXc8LrItpX+G9dKWiZm8njUCJv1YkUqI+TQPrLEjsAhCPyBjFzK8MFIOxbPV6o
	Pvb0Ews0JhuXmlPCmQmnB2BsZZPnptDLDDwZ/K9Kg+2s/tFAYqlA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45qsdbkfxh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 31 Mar 2025 12:08:53 -0700 (PDT)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 31 Mar 2025 19:08:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B25FB19B83FE5; Mon, 31 Mar 2025 12:08:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <wagi@kernel.org>
CC: <hch@lst.de>, <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
        Nilay
 Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme-cli: attach ns to local controller if none specified
Date: Mon, 31 Mar 2025 12:08:43 -0700
Message-ID: <20250331190843.2431830-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JFPpOEsHZZy2notISpe7SSAXNukSEKOv
X-Proofpoint-GUID: JFPpOEsHZZy2notISpe7SSAXNukSEKOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_08,2025-03-27_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_120855_831560_3A16E86E 
X-CRM114-Status: GOOD (  12.39  )
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

Assume the user meant to attach the namespace to the controller the
command was sent to if the user didn't provide a controller id list.

Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 nvme.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/nvme.c b/nvme.c
index bb412843..7a2c2e9f 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2953,9 +2953,6 @@ static int nvme_attach_ns(int argc, char **argv, in=
t attach, const char *desc, s
=20
 	num =3D argconfig_parse_comma_sep_array_u16(cfg.cntlist,
 						  list, ARRAY_SIZE(list));
-	if (!num)
-		fprintf(stderr, "warning: empty controller-id list will result in no a=
ctual change in namespace attachment\n");
-
 	if (num =3D=3D -1) {
 		nvme_show_error("%s: controller id list is malformed", cmd->name);
 		return -EINVAL;
@@ -2965,7 +2962,18 @@ static int nvme_attach_ns(int argc, char **argv, i=
nt attach, const char *desc, s
 	if (!cntlist)
 		return -ENOMEM;
=20
-	nvme_init_ctrl_list(cntlist, num, list);
+	if (argconfig_parse_seen(opts, "controllers")) {
+		nvme_init_ctrl_list(cntlist, num, list);
+	} else {
+		struct nvme_id_ctrl ctrl =3D { 0 };
+
+		if (nvme_cli_identify_ctrl(dev, &ctrl)) {
+			perror("identify-ctrl");
+			return -errno;
+		}
+		cntlist->identifier[0] =3D ctrl.cntlid;
+	}
+
=20
 	if (attach)
 		err =3D nvme_cli_ns_attach_ctrls(dev, cfg.namespace_id,
--=20
2.47.1


