Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE4FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9hRRMfHK7NbYo+pPiy2l8e+ZVTCB/C2G0ZuXG+PAiGw=; b=X8y2zw1QAgsMQNo09jnrTrPx2u
	JWM6WprefCxRJHS/cM0GidU0TkFzMZhik63iwHlgH001/qh/ypp3AJMryMy0EeDjQmR7YxfL5r/9N
	YlNrr6hiBvZp9b7qwKyjMRZOhSOhF4EKBVedvwPHqJk0jkL6ow14DCyG4lPTkpsiWfextwsq1nkOI
	Wwf3xxX2DgS/VEgftVQ9ngpV1he7DUYTk4jrYB2SJcWlWvHvp1MInfhfnhvtZXw5XmrSQ9YyarQjS
	gdVruBQNIRXN5BamJV2+/04pd444Ifh9ynu2aP//TXCvX/pOxzgtv1oieMW19Mg3tcXR/6q5h4PG/
	jVMaYU8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0u-00000005E2q-1diE;
	Thu, 30 Apr 2026 10:53:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0r-00000005E1d-2eTW
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 10:52:58 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TM1fSl3466265;
	Thu, 30 Apr 2026 10:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9hRRMfHK7NbYo+pPi
	y2l8e+ZVTCB/C2G0ZuXG+PAiGw=; b=AOGDZ3xRyBxrSvkd+eRyyVtnZPzV1dt7v
	9OB9+j5VRriC6GQB+yFaitWaVMfj+WX9xpNB0Ej3EmRd0wINIV0XgY9s6500dSb6
	HYkF49gQcjuVeg5d6dJly+IboSYC7U8JBZedt4w6YT9IQKgWdeXxIB0i7gUBV410
	H4LGOofHY9ai34lzWRYrG2Q2AghJrfv2faupwBLcYRs/X588Itbbq72bBJcxaqVR
	dm9/ZBtPi9hVzzUvbTiyS7jGod85nVp+40qGvoDiENYnPpmnl6nsuVYq7bbJUTVL
	1XtwmD/ma+CwgV/ZqS4hLLCifq2ni86CmI2zOgWRrMeN+OXO5DXkQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jwrkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UAcm3P016345;
	Thu, 30 Apr 2026 10:52:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw2p51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UAqoov49676742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 10:52:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4767020040;
	Thu, 30 Apr 2026 10:52:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DB242004B;
	Thu, 30 Apr 2026 10:52:46 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.102.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 10:52:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCH 2/7] nvme: use table_get_value_width() in table_print_centered()
Date: Thu, 30 Apr 2026 16:22:23 +0530
Message-ID: <20260430105234.1172446-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwOSBTYWx0ZWRfX6K883nw1KgKy
 26y3hUTgHVfIcLpp+DwD7ZNLnC45xF68M6DC1NBGNxMrRmGsg2RqvL4X8ZkOpff4hIW3dRudCDJ
 wXoGhATYnwHg0CQwBNlNJPMNThA+mkSNr6RFTyy8lovzr+PyQZHHEurxUN5eiKw0jPdPWuXfuXM
 qxhIQqN8r5jMwme8RfILSUMYzpPbxFUCPBbyz+DK+cysy615qXxBeoA5ALXw0DlHOUpxSXQpjl6
 XmzcPNia27EeAwD3O1le5jvurCgi6RAnnHoTCjHVkVCDtBCbRnj/EwSyfWYBvXDeFR6atmW8V0w
 v5wXnoZLKUZh+vHKTQx+E5ph5awlzhYKPvVweELYv1+r4Ip6o9RSgDUHERFhC3raO7pT8GYIfRT
 FpZ8U4VguUk+W1pFye9WgKsa5DP7pmqPajnGw59FYz4EPlMzN02H/jZpIT6zRMvHgfys+WUyTnt
 IKkA7+/7zXghk12lSYg==
X-Proofpoint-GUID: Tj6O51IRZUmpdh7e_lYNrzcCWu12rUkY
X-Proofpoint-ORIG-GUID: Tj6O51IRZUmpdh7e_lYNrzcCWu12rUkY
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f33486 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Q57MVcLctxvAXHQh0DUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_035257_790514_57C22700 
X-CRM114-Status: GOOD (  14.04  )
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
consistent across the table helpers.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/table.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/util/table.c b/util/table.c
index cad88d39d..1a69cd39a 100644
--- a/util/table.c
+++ b/util/table.c
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
+	if (!len)
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


