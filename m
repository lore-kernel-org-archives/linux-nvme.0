Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB67FC3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ffeRTPecDQ+lyfpDGynHxw6SpeG7MLUbja8xX+csL5w=; b=vu7e8Jbb2LI4JG9hYaQQS9IPb8
	ngZ8yQ5sC7mbtzVY13Ncw7P9lQvgjGadOVX+JsQY/Thf0EZpJvsc+2tKgmC05+MPBd/6XpWQZvoxk
	/G6WXdKmSZu7jWQdU6f8BRfPcNLEOnoWx93NDPhgvrpGvmK5xnOGzkGGFHkU/BdL90fHpzAYY1AfD
	cR1hoZl6xF3E+PJUeOBn30WS4xx+jIX8k2OpXYaEEUJrhC4iNxqoxzI4mwysYV5DvMab5xWkFpvvw
	yPz5J2ybOt6qwf4ziaPwF+db6ch6eDZEynUEqlLiC2o2MK55LTg8eJdQZR5jKE3Cyw8fBt0nXxbHX
	vK/w48lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHTSM-0000000E4Xl-1PxI;
	Tue, 20 May 2025 20:20:58 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHTSJ-0000000E4X7-21NX
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 20:20:56 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KIfXab011887
	for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 13:20:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=ffeRTPecDQ+lyfpDGy
	nHxw6SpeG7MLUbja8xX+csL5w=; b=LqYkfY9udxe8drpw2v3UdbQtOcupzglh6E
	HrYgn5hmETqLXo/RTbyXwgyBWxLk60QL5JIlMOOxWws90yj4S0osjle4GxXxIdmg
	AJ0Wvkzo9Dh67tOdPoHg0writ0qFZ063fQmV0/3qoTOF03Xt/gYw6VbstLW/XYP9
	VsF0B9oV9DQ/gcymJCwG6GrZ5uAFcMJrE9gacduZwmgkNVhTr4QoADF8dwXkeNgx
	CdTFdkiUBY87Q7R/hsjbVAtP6nUvUYgBDhrz282Qj5EJRIr+1k8PHojK6/wacY86
	FzS2w7i7ddj8zGuQ9SQZfOzwsccHJBJJu6F/TjwJ3WtF0HwTokRA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46rwfbj0t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 13:20:53 -0700 (PDT)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 20 May 2025 20:20:51 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 553621BDB8ED3; Tue, 20 May 2025 13:20:38 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: [PATCH] nvme: fix command limits status code
Date: Tue, 20 May 2025 13:20:37 -0700
Message-ID: <20250520202037.2751433-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE2NCBTYWx0ZWRfX1qncw3vUCTEE /fWu29l/A6eIi7rXiUjVKQsmxc8A181dS7ehT+pQOfLQM6Im0ZgEHBgX0GyYUzfPCDzWQyixWDU VRXClAnFXPqkVtr6eme5Zhy/fIWTKiD7Yod7FKSVJ21vtpbHKvywhDToeaa6zz4j0WwNPjfL5qH
 vukHecTEMChHuUvsT9jlzPrw5Tq/QJ43wYSKG2uh7/PET5ZNuGMWXFs7pk9s3SWMXdlPhHBRQym IK7pDwuWtdmmCR45zHnwNz5qbuYnijI6qMgu1JvAOqXpDLp4aiKGpgrt6GMkh7MeLXPMz1kFmkx Ydez4gbkJprcPS9vs9z2UbiKu+SHSsoTAKSOtEluAEMCZyWhlPniqCxyXchFTr+ufcBzlJFqUTU
 mVi+ZFzfiTJqa8qng5jWtUO8G8uOs55TBSNK0BU8RbZrI4UBCyRbCWqhCN8tJtfCiSVQeOsV
X-Authority-Analysis: v=2.4 cv=RYSQC0tv c=1 sm=1 tr=0 ts=682ce425 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=4_lMw6p75YjuIjONPmcA:9
X-Proofpoint-ORIG-GUID: Jj-ys84UJ-4RLpcBNZnIKZFXhDJtXOSJ
X-Proofpoint-GUID: Jj-ys84UJ-4RLpcBNZnIKZFXhDJtXOSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_09,2025-05-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_132055_728637_2004CE9B 
X-CRM114-Status: GOOD (  13.45  )
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

The command specific status code, 0x183, was introduced in nvme 2.0
specification defined to "Command Size Limits Exceeded" and only ever
applied to DSM and Copy commands. Fix the name and remove the incorrect
special handling for it.

Fixes: 3b7c33b28a44d4 ("nvme.h: add Write Zeroes definitions")
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/constants.c     | 2 +-
 drivers/nvme/host/core.c          | 1 -
 drivers/nvme/host/pr.c            | 2 --
 drivers/nvme/target/core.c        | 9 +--------
 drivers/nvme/target/io-cmd-bdev.c | 9 +--------
 include/linux/nvme.h              | 2 +-
 6 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.=
c
index 2b9e6cfaf2a80..1a0058be58210 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -145,7 +145,7 @@ static const char * const nvme_statuses[] =3D {
 	[NVME_SC_BAD_ATTRIBUTES] =3D "Conflicting Attributes",
 	[NVME_SC_INVALID_PI] =3D "Invalid Protection Information",
 	[NVME_SC_READ_ONLY] =3D "Attempted Write to Read Only Range",
-	[NVME_SC_ONCS_NOT_SUPPORTED] =3D "ONCS Not Supported",
+	[NVME_SC_CMD_SIZE_LIM_EXCEEDED	] =3D "Command Size Limits Exceeded",
 	[NVME_SC_ZONE_BOUNDARY_ERROR] =3D "Zoned Boundary Error",
 	[NVME_SC_ZONE_FULL] =3D "Zone Is Full",
 	[NVME_SC_ZONE_READ_ONLY] =3D "Zone Is Read Only",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cdb806b2c89c7..05445217dd6ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -290,7 +290,6 @@ static blk_status_t nvme_error_status(u16 status)
 	case NVME_SC_NS_NOT_READY:
 		return BLK_STS_TARGET;
 	case NVME_SC_BAD_ATTRIBUTES:
-	case NVME_SC_ONCS_NOT_SUPPORTED:
 	case NVME_SC_INVALID_OPCODE:
 	case NVME_SC_INVALID_FIELD:
 	case NVME_SC_INVALID_NS:
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index cf2d2c5039ddb..ca6a74607b139 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -82,8 +82,6 @@ static int nvme_status_to_pr_err(int status)
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
 		return PR_STS_RESERVATION_CONFLICT;
-	case NVME_SC_ONCS_NOT_SUPPORTED:
-		return -EOPNOTSUPP;
 	case NVME_SC_BAD_ATTRIBUTES:
 	case NVME_SC_INVALID_OPCODE:
 	case NVME_SC_INVALID_FIELD:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index db7b17d1094e8..e824f149746a7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -62,14 +62,7 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req,=
 int errno)
 		return  NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 	case -EOPNOTSUPP:
 		req->error_loc =3D offsetof(struct nvme_common_command, opcode);
-		switch (req->cmd->common.opcode) {
-		case nvme_cmd_dsm:
-		case nvme_cmd_write_zeroes:
-			return NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
-		default:
-			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
-		}
-		break;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	case -ENODATA:
 		req->error_loc =3D offsetof(struct nvme_rw_command, nsid);
 		return NVME_SC_ACCESS_DENIED;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
index 83be0657e6df4..1cfa13d029bfa 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -145,15 +145,8 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_st=
atus_t blk_sts)
 		req->error_loc =3D offsetof(struct nvme_rw_command, slba);
 		break;
 	case BLK_STS_NOTSUPP:
+		status =3D NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		req->error_loc =3D offsetof(struct nvme_common_command, opcode);
-		switch (req->cmd->common.opcode) {
-		case nvme_cmd_dsm:
-		case nvme_cmd_write_zeroes:
-			status =3D NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
-			break;
-		default:
-			status =3D NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
-		}
 		break;
 	case BLK_STS_MEDIUM:
 		status =3D NVME_SC_ACCESS_DENIED;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 51308f65b72fd..b65a1b9f2116c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2171,7 +2171,7 @@ enum {
 	NVME_SC_BAD_ATTRIBUTES		=3D 0x180,
 	NVME_SC_INVALID_PI		=3D 0x181,
 	NVME_SC_READ_ONLY		=3D 0x182,
-	NVME_SC_ONCS_NOT_SUPPORTED	=3D 0x183,
+	NVME_SC_CMD_SIZE_LIM_EXCEEDED	=3D 0x183,
=20
 	/*
 	 * I/O Command Set Specific - Fabrics commands:
--=20
2.47.1


