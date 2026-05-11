Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BF8CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nw2U42s/VI87iPCTul/lm5lFCoe9+CfWf/oSE6s9m0M=; b=pgtvuA/HZZFxCN9CG0GtxwhrLv
	TQ3u3aIlWxbmNA/pXtcB6fapA4OKfs3e4swI1JJRpjWmhtQM9D0+LwVjtgtkR2I4FuMvQh+kQQAhG
	A+bWLZnZ5IXNJmC/cH/aZ7CAYOihYo9HktrgoSxMbzzmhQVYgm1HjYtCWEk/VWiwIz7dptLYxVeg2
	f29QvTPJFacpZE7Mfjlmar6m2IYKTdxK79X7r9Bu3MdyFNfhZmbM44jcXrQ2wUQbPSoTKB7GxdYTV
	h+duVp1gD0pHoo1czByjmDMubbuegKdf2MESvrn2XPrSRk6z8rVrRfLWL3SaevMiU2JDracLuJdda
	kVgr+ZPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPF5-0000000DQ5k-1RDr;
	Mon, 11 May 2026 11:56:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPF1-0000000DQ3o-1pwu
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:56:08 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ALHPZU225566;
	Mon, 11 May 2026 11:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nw2U42s/VI87iPCTu
	l/lm5lFCoe9+CfWf/oSE6s9m0M=; b=lWmJqg8HAlwq3c269wovHGtRhxQ0j1WJI
	rRY25ARPUOSh2kbyC58n9GuL0ColJY/+8rlkekQ6yn8R43H1uJ1kebVUkqGykRRJ
	MGpwb2brPBV5poPCjcNfEix3XHLc9KVc9NJJ1LM6R+PFbj28wbvF/WwdMaSyWNUW
	DkC6yDqkWE1pi0Ufm0abqXlLsMKI/vPV3bc4EgK8hYE+8v+0VPUS+qe6izhYT3xC
	QE+6rbgiG1u5qRwSK24lzkcSuTawwPg5HsCvXA5zmXnb+Q0cujXBt+a2zZ4kP+AI
	cZ4YyI6k0/21+ENpm+Wlzdu2T3qI53TfKkC+TaTQEuHt5Bq+98jEQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhqrm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBsONt007315;
	Mon, 11 May 2026 11:56:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jw2se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBu0Zx51970464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:56:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E13020043;
	Mon, 11 May 2026 11:56:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7349420040;
	Mon, 11 May 2026 11:55:58 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:55:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 1/7] nvme: add support for unsigned and long types in table_get_value_width()
Date: Mon, 11 May 2026 17:25:41 +0530
Message-ID: <20260511115555.2638335-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511115555.2638335-1-nilay@linux.ibm.com>
References: <20260511115555.2638335-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01c3d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6AqdkEPFk3lOkO0276gA:9
X-Proofpoint-ORIG-GUID: l2k-1HClS0r9XtAJEgO_1EzQS9UB0VTO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfXxa41U53Acacx
 w0Cg+tLOwrc8zsCOr1lrHDqpK5alXU6RpmeEj5f3VpfrE+VVsLc1CNYwgFm/VtgNfhJ6ncr4a/x
 ialOqLwSnZ7jyhlxPl9SJx3voE2VjSjwnDoJsbcdMyoEyJW/qdmG26JccJ8EfFVoKZWF2arzEBc
 Num0pZia6T3XfJkiOse6k8yTRW8oiuXcd+Lk4uex+61BNWgF7FhchGad0dxCsu36B0w1YbCV7fE
 MTVvfMHqJzk2rYw5RLCWG36Y5M0Lf5jA1K3A+Vn6rIsbot5WNNk5RzcsQz/792w6wj9b6/DDODm
 J6bK3z4ePuiWX+8OSd5idMl+cPVPYGCvfZb+pxDsN5XVLqk4I0i7U96ZlpGnlSxJOwwcQR586OL
 gJuoquMdVftU/PSeVjf98urdPL0aoaZYD4kYIDUae6jcyn+TGmiZfOIDAHb5LY5/Q+8ElEYdyol
 QqNL878jHl7aCWzcRoA==
X-Proofpoint-GUID: l2k-1HClS0r9XtAJEgO_1EzQS9UB0VTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_045607_900176_8668F431 
X-CRM114-Status: GOOD (  12.33  )
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


