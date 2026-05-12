Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C082BCD343F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 20:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nw2U42s/VI87iPCTul/lm5lFCoe9+CfWf/oSE6s9m0M=; b=RQca0dyxW1AiIfKgJD52S+RZGH
	QpjSXPyFED2M6JOV3DKOCe7T7Q1YvQihly0q4hlvmEvRzyI6nq3EfaiBwxeyld4QW/xg/z9rsM8Yg
	bwAOotBFyBJERxZzsxzNlgv5bEOAtUb2ZXJDZuz4kkr65iTFlOuxIjFBPiZQrUmEg6P4je+WdiPhI
	ZKGdBJMgXugaaaEXjUQlHnllspaZvV8uttpkCGlqa2bS8TGWcnqx2QFOPIBAGeve7SW/9VFLqrHRm
	a0ZXSqfi5h1HOzvYHsqR1sMgln182tCwJJON6MrBzG1ai8yNbbg6lquzLLmYFx549vUpx74JngSHd
	dnK1AYoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWd-00000000J9b-1UL4;
	Tue, 12 May 2026 20:16:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWb-00000000J8u-22el
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 20:16:18 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCHueN2606870;
	Tue, 12 May 2026 20:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nw2U42s/VI87iPCTu
	l/lm5lFCoe9+CfWf/oSE6s9m0M=; b=piTggowGxwFkBZb2h/h9YkiUEXFoqIvz3
	Qovj7GIuPvOYbe9yX4uOMDp0hRZsWYALOR/fxmsp3LhPyYLnaNF/VRFSO9ocfvnu
	upsix/xxR8jIoOtTSXFHFEcNp5QD5GeQhOIw0CiXBtn/+7bTAjloGzoXyXnStsFw
	T2tRwKOUJv1vm/Q9DR5hM2RUtNtGLWDjpbZjfHqGq2aNv40tapmdqUUyvffRjAjr
	8PPiHBg95fuV5OT4Pm1RJVyoO2zehm/0lR/zoLfkqSF2CKaWYC8CKrI1xwkNPNXV
	g6PfdB7F7SrnejnZXkZDASn/SPKCbFgPBguYCB9zuoWi11Crw6nBw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv54us0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CK9cHG018121;
	Tue, 12 May 2026 20:16:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgcrjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CKG7l330016218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 20:16:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 399622004B;
	Tue, 12 May 2026 20:16:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39AAA20040;
	Tue, 12 May 2026 20:16:04 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.87.130.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 20:16:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv3 1/7] nvme: add support for unsigned and long types in table_get_value_width()
Date: Wed, 13 May 2026 01:45:46 +0530
Message-ID: <20260512201559.3057514-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512201559.3057514-1-nilay@linux.ibm.com>
References: <20260512201559.3057514-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwNyBTYWx0ZWRfX2oHQWBamEvEu
 iI3bdoSJHCMiYLlw+IxOeuJqNoNsUHqNoTB7UeZ4lRLuq7M477v76TN/jcn51Lsv2tUbDuV7c7C
 dNtHf8VShDlMW5DBJbp+9dSF21wmQ8181RpQeNhp5zdYWbuxBphyw7ZixDAniO/LL+ZrySid7e8
 A2d+mlk6oFhsSoX0disxqJjfzve8XUQoqWds2LqK7BdQWzkKGXyhMVKj35FMY0zVFs4k/S5QgoR
 8HnkCNg6jvEpxBiDsXp3dDD2F6D7mh5Y5civ0X28e1zLmCKkdzXAScJN0EWEipB5isU4ljESUdq
 nL9VfeGHkflygvMIrbz16nGDTrRJeVCHD8r7s2p1LvmD9dfhoQ2ux6ID6C6Eot/aSgWpCPqM1Kj
 o5N9o5ysTIUI3JHKiyEqZFxIKrkjGaLKjAnhMqfsgiQbwBAB5YhioWy1xjie7Ls4uh3sNOfJ508
 JikFbn8+9TAWEYz3IlQ==
X-Proofpoint-ORIG-GUID: n59mHCGcFYU3XvTgGlekqVRBAjNzB9hi
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a038a8c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6AqdkEPFk3lOkO0276gA:9
X-Proofpoint-GUID: n59mHCGcFYU3XvTgGlekqVRBAjNzB9hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_131617_522939_AAA8CB51 
X-CRM114-Status: GOOD (  12.28  )
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


