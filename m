Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B20CD4F24
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 20:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+D03eFtOVNUvGEm11a7PD1cTvXoRi+BJmBsnY6PYJ8=; b=q9XTyfXmOFlQzMKNzFmIZR3HCe
	C0N9INX+uTxlFtuG8Q3gmPzPaIVWd1QyXPv/sbZCBzWs7GLTOMpk0Sf3WEpZqUonHTpiaV1+6x552
	vwznxDHiLkl85Dj8du8+UQBe4XC/mVcLmVH0eKNZ2KvPl4OpsiolCpn9m68xel4IbRu9xApo1HhWr
	Iaa2JrHYmWbq5RDvTT2aw4hzlmTE2j89O+4J2tOvXyKbRPFpEN9MqLZicpF/ThGyrD2GXBYaFwbRu
	l0dJr562QkvHtTVKUmQx5yP9AwPRDHuu+YzC/KpQJpe3L5WDWeZCrxDFFLmBCWsATT8LkVaB5L9Vk
	OZ7Dw5vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWg-00000000JB4-1uxf;
	Tue, 12 May 2026 20:16:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWe-00000000J9l-1nOH
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 20:16:21 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCVDHD3177726;
	Tue, 12 May 2026 20:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I+D03eFtOVNUvGEm1
	1a7PD1cTvXoRi+BJmBsnY6PYJ8=; b=iKcR7jq/2jLCtU30t/tmrfeXSuaRCiisl
	RC9e83+7PlWHBjfNj3xXXhFCQekPvJNiCGc4rLruftobMEhESXX/Tysbqca+GGaE
	nuyznEf7Swkmjui+OoQtE/FeLNy+Oy46feygvHmo/lIZujGFyYfqHhunjTA6vlza
	m4HkrWHaWAM45l6Ou9wp5XmMNphdzLAg/dTCtsSLJEIs+5fgyuaLFVKUu6SHICb3
	I5e5RAxnQyGbX8AVkYPgKGOMm8GH4v5v0fwTPD4QAaJMaz/W8PUZq5C3e+gwX8fW
	SjYdfAUtCNloJwDjwGsXrUvqZ3GnSVRxUPx2zfu7BMetMCc8rTCfQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6mmeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CK9c3k027739;
	Tue, 12 May 2026 20:16:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgvrxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CKGBmn53477870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 20:16:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E579020040;
	Tue, 12 May 2026 20:16:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF9CF20043;
	Tue, 12 May 2026 20:16:07 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.87.130.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 20:16:07 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv3 2/7] nvme: use table_get_value_width() in table_print_centered()
Date: Wed, 13 May 2026 01:45:47 +0530
Message-ID: <20260512201559.3057514-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512201559.3057514-1-nilay@linux.ibm.com>
References: <20260512201559.3057514-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a038a8f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=uiVMTqFthIFOwa1QBh8A:9
X-Proofpoint-GUID: s6hC60pb4-Hx1DGhtOXgxwBLVAgRJxfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwNyBTYWx0ZWRfX0nURXIb6RNAt
 YGidsydNNQ9S1Zh4yhgu02RT/BINj/8s9v706EjW0rSsr3QZEzzrxdMMSZ9lpWmfXHvae5Sa0wG
 maLfLRTC7nJ1b0I6BEfIc9YYtfTTGzvyjWzXyvNtVqOj/DkOAVxqtB8yaq6mUyfZaB0JRSufQK2
 6eCISpAqN3xHhfMdovgRjHlVjlUUpFXtflD8V9s9zSOgyyb8KQBuCfpTrJZaSCrERL+Nmz/duDP
 N6BhOOLdeIcszHW4Boo4RfMy3tqMGV9JYPBSwtNq0mR/BcMc6P8F7c02Usf0yPQeFdU4Fp0ebdH
 IXcnUn7NxPmnA8t+ncjhM+Yb38xJYjOK1CHFk2zokr3rTCWFPjDyUskqvSWMiezZaN2R/1k0TX8
 B/9xP2nMeSlQngaVckTcvrNVcFXoUb5vNk42HGFC76Yazw90bQ6xc5g5FsZOmdknomwyoUY52Yt
 06LkF58QZ59Qjdq53YA==
X-Proofpoint-ORIG-GUID: s6hC60pb4-Hx1DGhtOXgxwBLVAgRJxfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_131620_583364_1A800B8A 
X-CRM114-Status: GOOD (  14.33  )
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

table_print_centered() open-codes the logic to determine the width of a
table value, even though a helper already exists for this purpose.

Replace the open-coded width calculation with a call to
table_get_value_width() to avoid duplication and keep the behavior
consistent across the table helpers. Also, ensure that
table_get_value_width() returns -1 on failure so the caller could
then handle error as needed.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/table.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/util/table.c b/util/table.c
index cad88d39d..1fed89db8 100644
--- a/util/table.c
+++ b/util/table.c
@@ -25,7 +25,7 @@
 static int table_get_value_width(struct value *v)
 {
 	char buf[64];
-	int len = 0;
+	int len = -1;
 
 	switch (v->type) {
 	case FMT_STRING:
@@ -53,28 +53,10 @@ static int table_get_value_width(struct value *v)
 static void table_print_centered(struct value *val, int width, enum fmt_type type)
 {
 	int i, len, left_pad, right_pad;
-	char buf[64];
 
-	switch (type) {
-	case FMT_STRING:
-		len = strlen(val->s);
-		break;
-	case FMT_INT:
-		len = snprintf(buf, sizeof(buf), "%d", val->i);
-		break;
-	case FMT_UNSIGNED:
-		len = snprintf(buf, sizeof(buf), "%u", val->u);
-		break;
-	case FMT_LONG:
-		len = snprintf(buf, sizeof(buf), "%ld", val->ld);
-		break;
-	case FMT_UNSIGNED_LONG:
-		len = snprintf(buf, sizeof(buf), "%lu", val->lu);
-		break;
-	default:
-		fprintf(stderr, "Invalid format!\n");
+	len = table_get_value_width(val);
+	if (len < 0)
 		return;
-	}
 
 	left_pad = (width - len) / 2;
 	right_pad = width - len - left_pad;
@@ -84,7 +66,7 @@ static void table_print_centered(struct value *val, int width, enum fmt_type typ
 		putchar(' ');
 
 	/* print value */
-	switch (type) {
+	switch (val->type) {
 	case FMT_STRING:
 		printf("%s", val->s);
 		break;
-- 
2.53.0


