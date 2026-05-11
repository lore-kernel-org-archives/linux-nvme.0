Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C69ACD37B9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+D03eFtOVNUvGEm11a7PD1cTvXoRi+BJmBsnY6PYJ8=; b=RU8jm68vGQYw/n13GhYfs15xOR
	tOcAHuqVYbgYyEw6XEOC2ZpBbn+YBBlHL1mpdJvWQCFnWBxNhcsDSVcpjIPyFHHpZnXzGEDjnXQxt
	j2Zh6EsrUB/2l4zmPnJm/yrfsUZgq467FOVgSOsxqB+/5C12e4gCvwtnRFWEOS8cgr6JohtxE7iHc
	hXSIaGm43hW6umE7Cg1jR6y7EGW0BjgPrthMJpGbMjiSHUgnVn3r4eCU0gm0guYL4uFjL0mO4vxXU
	yFs5R46ejB4PljcooIhnOSyAwD16xOQL4RIg7GPWHSXv9Kg9C7PFtXGaNwqnSBpUSW2mrtQN+MICL
	rc5NeQqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFP-0000000DQG8-1hFn;
	Mon, 11 May 2026 11:56:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFJ-0000000DQCs-444i
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 May 2026 11:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=I+D03eFtOVNUvGEm11a7PD1cTvXoRi+BJmBsnY6PYJ8=; b=cV1aYJ0I/qQKIgzzWAQfOIQ7j2
	7dEgoS1e3Zc7mgeX7VJl2qriIuGfLMrBz040hFdnvdQQgeKzdBnCQtZGBA0nrMz3OoD1yALxI0y/9
	Da3/tFY9q3FJ8DlZqiC96qtROogDLp4GyKCkHtyi+ATUdiY+p5XJxNwuhjXVt+2NbC1MQVTxM1FTh
	Iwnn2FAu24kmWZNexopKG41ShjFeGY79nOVBWRMapKzNU5KUrhZ1giZ4MLZhdXj4QvOW1C/7rK0Aw
	H3g4t+V77q3Ram6Y1yABvkTNDZejDmJUVe0nUYvrWoEOG50uccSPKss023Ry0S7lXlmy4tMdH+zRU
	IZfuPnog==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPF7-0000000BXgj-1Plj
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:56:23 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANuQgW523107;
	Mon, 11 May 2026 11:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I+D03eFtOVNUvGEm1
	1a7PD1cTvXoRi+BJmBsnY6PYJ8=; b=tGMR8VfKFcNBmyTDVoTPlSqnNSEBvfRAU
	zybIwWL0voNx34fYQdPkZY3SHOnJoXURVIQdvyXNEBfm2AeDVmiUJzfGkIY8HJnM
	bvKoa3JxomJwQbQo6k7wnzEFVshOnd1yZqHpTv6sXWnUoRoRPJfgKcRfi41g05MG
	cqeq8uzRlGWzlXL3esriCTL2lM0QxKPYIGzJYL8sJNcURQOtGHRJQo6iS8Rc9T7E
	XXA9Eflq4k4jLMLk0E9sbzIKp7ovsJ6WLZInN7mK/njORiMyQf4lLB07xCMoveH5
	NI09uoS3XF9MhXPfBNCO5WqVOnuavGwda05SNRjveK7s6aKg1M7/w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhqrmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBdT6u023519;
	Mon, 11 May 2026 11:56:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvw5vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBu2lJ45744566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:56:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 722B920043;
	Mon, 11 May 2026 11:56:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0CF220040;
	Mon, 11 May 2026 11:56:00 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:56:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 2/7] nvme: use table_get_value_width() in table_print_centered()
Date: Mon, 11 May 2026 17:25:42 +0530
Message-ID: <20260511115555.2638335-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511115555.2638335-1-nilay@linux.ibm.com>
References: <20260511115555.2638335-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01c3d7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=uiVMTqFthIFOwa1QBh8A:9
X-Proofpoint-ORIG-GUID: WgKYyr1mVtX42uYhSYCEsOXO0WG0oaw6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfX2xOwJrObF55x
 keLmHRLeyz3JZosdSLuCe3/eG95clMw5SyGp+t3ce6PQ1XX5ilicIwechuEc3n0COiyNye+U68/
 PP6G8XqUQAeFwzfjhWu4tTEJDPJBQ3/GynnODmVdGxAlc7mtshlL2cSV+z3IRSvKW5Nz8hQ7HVz
 Dfzr3GTBk7c+TyngY2wMmSbtUggKpD7MCvDsI0Eqpbuquj6GfHCYYMlmvQwt5aHYz90bXx9ZNMf
 XRtnLVNFsRhayYY/dXDzqIQugMfpkBH+ks6HBUY8qHIHVLjJpmBNArQ1NKRJUJXaEvesj+pI4Qr
 jl6HrVHiHZeb87jo2DBG/pgr+vIYjjZ1qIswBFC9wvFwv47bpvNapDapiQRCcEXrtYKnhQyL56J
 9w9J5mIM+kPs1Dyonf6DIQneEgNNUrKzQsIsUW2fCXJ4TjijP/AmhZP44EHAkT8McxLO4OLhbQm
 TymvL592CGs83ZqBk9g==
X-Proofpoint-GUID: WgKYyr1mVtX42uYhSYCEsOXO0WG0oaw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_125620_206660_7CA95EED 
X-CRM114-Status: GOOD (  14.12  )
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


