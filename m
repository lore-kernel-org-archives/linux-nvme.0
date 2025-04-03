Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9286EC3601E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ESBhNVAFVq4zKBzrWIz26Kk4gbq8vjp0Pwxl0Jp8hS8=; b=cwvHy/gHns/o+K2QYI0L2Uj58a
	mi+r7ED9fpdmvw7FMkVgOoeUxBWbS0TfPPYXCngSN5W1jc7xLkuFouPDtqrNt+gIcLYSUs+L/fW3D
	4IRFzjI2RXbDqo5XB8hsi4QOzJp1zJKyW7BCVtiaPieDTBqJDk6S6TG8cP0k00ihHwgWTs0CIcg8V
	fkW7LyOIL44JhSfKnylsxCsKKxUhqQBkXtH4+NOyZfl1gtsE2Pczgrb2veX8hiBcXghoOTBL70Q24
	h5SmbxJymczd27lviZ6TuDfdmksMIOqo304Qa1HUd4UQ+21TBlIaOKIY7vgBbq8Ut5E60+avIX/S/
	yNFpJHmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LkH-000000096SQ-2VTj;
	Thu, 03 Apr 2025 14:40:41 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LZb-000000094eY-2eBo
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 14:29:40 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533833q3021664
	for <linux-nvme@lists.infradead.org>; Thu, 3 Apr 2025 07:29:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=ESBhNVAFVq4zKBzrWI
	z26Kk4gbq8vjp0Pwxl0Jp8hS8=; b=eRZivz4S022GcizYpaBa1IyIxdlG3Nqn/M
	2uNsz8T7OIAokpDhPbdHLUJowBlTEOPMbv6LW66RfW9gJQ0AQU/3YgoPvhU04LHf
	/rmhT+324oJdGhGzlxMDHf+OROVvxz/Y0xJBJzGbdzv4DmJgqjEN0KSaKqs60jMS
	Rf8vekMZ5nebIZLo4vbTaXvEFRj6GSA1R1nZDxhx5rrc0lZQObQvLhNRWjBq+X0K
	q+YRWeoKbIdECYIdzwWMCSdKMZGfwt1V2BT3b0vdLM/B6FQkruxGNCHkr7EVVedR
	BkEPanZ226WT5Eba8VNFjLTzQBfIFX0e+PUeCqfK5u3TbeqKc7fQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45spfg1x9f-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 03 Apr 2025 07:29:37 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 3 Apr 2025 14:29:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4362019D586C8; Thu,  3 Apr 2025 07:29:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <wagi@kernel.org>
CC: <hch@lst.de>, <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
        Nilay
 Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2] nvme-cli: attach ns to local controller if none specified
Date: Thu, 3 Apr 2025 07:29:26 -0700
Message-ID: <20250403142926.2510305-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cIpmgPhO7BiXej5TF_xWT7jqIYllhDMQ
X-Proofpoint-ORIG-GUID: cIpmgPhO7BiXej5TF_xWT7jqIYllhDMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_06,2025-04-02_03,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_072939_776627_FD68E1DD 
X-CRM114-Status: GOOD (  14.96  )
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
v1->v2:

  Added documentation on this behavior

  Fixed the controller list length

 Documentation/nvme-attach-ns.txt | 13 +++++++++----
 nvme.c                           | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/nvme-attach-ns.txt b/Documentation/nvme-attach=
-ns.txt
index 1d507593..7b544a46 100644
--- a/Documentation/nvme-attach-ns.txt
+++ b/Documentation/nvme-attach-ns.txt
@@ -29,8 +29,9 @@ OPTIONS
=20
 -c <ctrl-list,>::
 -controllers=3D<ctrl-list,>::
-	The comma separated list of controller identifiers to attach
-	the namespace too.
+	The comma separated list of controller identifiers to attach the
+	namespace too. If no list is provided, the namespace will be attached
+	to the <device> controller used for this command.
=20
 -o <fmt>::
 --output-format=3D<fmt>::
@@ -43,9 +44,13 @@ OPTIONS
=20
 EXAMPLES
 --------
-	Attach namespace to the controller:
+	Attach namespace 2 to the controllers with id 0x21 and 0x22:
=20
-		# nvme attach-ns /dev/nvme1 -n 0x2 -c 0x21
+		# nvme attach-ns /dev/nvme1 -n 0x2 -c 0x21,0x22
+
+	Attach namespace 3 to nvme0:
+
+		# nvme attach-ns /dev/nvme0 -n 3
=20
 NVME
 ----
diff --git a/nvme.c b/nvme.c
index bb412843..ad1eb461 100644
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
+		cntlist->num =3D cpu_to_le16(1);
+		cntlist->identifier[0] =3D ctrl.cntlid;
+	}
=20
 	if (attach)
 		err =3D nvme_cli_ns_attach_ctrls(dev, cfg.namespace_id,
--=20
2.47.1


