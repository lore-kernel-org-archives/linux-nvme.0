Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE3CFF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nw2U42s/VI87iPCTul/lm5lFCoe9+CfWf/oSE6s9m0M=; b=LhyWajme0R6m1U1ozaS9WQBARD
	tavXaAYRNHVs57pbOhWccgaH8MJ7Fspf0pUB5CycSLGW3cRL89ixr/n33vtqWXqzulHuy0lxUzE43
	bo+e1d1fC2fUpSghy7xK+UNbpjzxEmOO0plFrJbjNkogU2RzHI5Mn0i64eZITGCggEay7n6OQJr6Z
	RozuVFfVSfgjB+S8U3Qk19XuDu5gI0pXMhM3uLzsvgXvq6pA3DdVXL9FpMGOp5rpMfl3PJmdO9Qam
	8T0pVa0vAqZYG5DkH5sbbjumslTYVNG/kG7N/UaCfoBIxt196SxSxwvxo59Xj1YGzl13qlImstPYs
	jGblBX5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0r-00000005E1Z-0Ce9;
	Thu, 30 Apr 2026 10:52:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0m-00000005E09-3PDA
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 10:52:55 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U7SUxq996575;
	Thu, 30 Apr 2026 10:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nw2U42s/VI87iPCTu
	l/lm5lFCoe9+CfWf/oSE6s9m0M=; b=KV8V7J7fGkMm24rkFCwgKmAOCkkr/6xzk
	8NVvgvBitIsKIXgldDcJ5ZVxePPOGhAD49PFAEvkALROIPzYTqFWGxy6T7p/f1fS
	UTab5GP2qC/LLH6+Y1yfbk9Wz4Fjb1u6IsJZkI3dR+z/PXOWwJY1C5TokyrfzmYq
	EZj4t945eC3jdFeVRdo80TZZiBq9gNRUCZiDiMr+VRXIO8r6+JnsLUhmxOP/hNRl
	oBq1kx+ad9QAjuL3RGrbXuHtq1DPFXnTKfRx+7dzUj3ImaZpMWEmbzpcV3GlyGv5
	mZXapAKLtv1BrnR6IwVU/ZJ//R0PM7F98uz/7YpavOtLbWUc4DuuA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vnhe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UAcrSf016531;
	Thu, 30 Apr 2026 10:52:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw2p4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UAqjHB53608820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 10:52:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 832AC2004B;
	Thu, 30 Apr 2026 10:52:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF4720040;
	Thu, 30 Apr 2026 10:52:41 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.102.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 10:52:41 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCH 1/7] nvme: add support for unsigned and long types in table_get_value_width()
Date: Thu, 30 Apr 2026 16:22:22 +0530
Message-ID: <20260430105234.1172446-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f33482 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=6AqdkEPFk3lOkO0276gA:9
X-Proofpoint-ORIG-GUID: BCURicHivywKbVzboE283_EGRn5nmyoN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwOSBTYWx0ZWRfX50i+T4cBTcRp
 n0VpIdMdA+SBniy9Iy8Vy7Ke0vQwhfPehlLHsrgROHEmq7qZpFdztXBRXrbu7tAN0AEbfLka3C8
 cq7H9yC+9yCZKFe9whI4xvlBJBYRg8Qi5OsSCOpHjDu32p52+4BBaJSSo13469+AS4Z4ojB0tqD
 j/7IGFnvy17/rtytlXlKXpdBx3Ex+dOpqqtsfyMF9c3nO+BcyEDeAIcgeWOFI913e6z12zn3KTM
 cd2/aS8x502Ro1rSnNo2l7XUZosC2T8/2umkG1BHtPnHfruShMz4aKWhDMGwHy+B3xYQgcXXeDa
 TXE6/F4kbuMjfUk7oiB6t1ZsmZ1CBII0T5NesmaMRiN3ShNFp9kwx47vWz/pWWf45J9zJEWU5gO
 cf6f5MTFERrz5DTALaF+IPOQrG2ZPWsbCIdJkOpDoM1HX8ml0YXngUlwRnC4SAGaEEiQW27MI66
 WkBWlEO3AVeXWVbY36Q==
X-Proofpoint-GUID: BCURicHivywKbVzboE283_EGRn5nmyoN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_035252_986007_BD7DB95A 
X-CRM114-Status: GOOD (  12.96  )
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

The table API automatically adjusts column width based on the width of
the value being printed. While table_print_XXX() already supports
unsigned, unsigned long, and long data types, the corresponding helper
table_get_value_width() does not account for these types.

Add support for unsigned, unsigned long, and long in table_get_value_
width() so that column width calculation is consistent with the
supported print helpers.

This will be used by the nvme top dashboard, where several statistics
are represented using these data types.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/table.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/table.c b/util/table.c
index 76366b93d..cad88d39d 100644
--- a/util/table.c
+++ b/util/table.c
@@ -34,6 +34,15 @@ static int table_get_value_width(struct value *v)
 	case FMT_INT:
 		len = snprintf(buf, sizeof(buf), "%d", v->i);
 		break;
+	case FMT_UNSIGNED:
+		len = snprintf(buf, sizeof(buf), "%u", v->u);
+		break;
+	case FMT_UNSIGNED_LONG:
+		len = snprintf(buf, sizeof(buf), "%lu", v->lu);
+		break;
+	case FMT_LONG:
+		len = snprintf(buf, sizeof(buf), "%ld", v->ld);
+		break;
 	default:
 		printf("Invalid print format!\n");
 		break;
-- 
2.53.0


