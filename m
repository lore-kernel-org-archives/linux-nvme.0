Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A669DC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:51:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF4820639
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SH+yWaui";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="KRGk9R5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF4820639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jbRMdF5UeqGTEzgq8gc9RKv6WL6YSOvQ420B4HJxWvY=; b=SH+yWaui2zcn2qyCMmH2071OcP
	d3Zw3U5dlg4aL6LKdMx7yiOrRV00VeXFRjiy6KAGqDmPZLIzvb9NpKKKvWtdMDNekS5AbJVVJhVPH
	mqlpn89l+bQq1u5HnRuok1maYE3HCLL1HSrX9Q7Ff8vMSODWryGv1ev+4vnKMFRTiHZrhLfdWByU+
	9r478YJz+fJGOEjJ+/iqIAmmDF9+yu4H7f6U7Tv1OD25HB2gEylVcqZrFU8CY5o2JyaEkJgkgyNCr
	qWZuiiUHn5+o5AY1Ld+0wCxe7eWGvsQEAtKJLd1Q8cloq1UA6txkwYRTRh8tl8Ur4cPdPs7QkA7MF
	59914f3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vTC-0007bl-5x; Tue, 18 Aug 2020 06:51:42 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vT9-0007ai-6S
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 06:51:40 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07I6g2Hm005812; Tue, 18 Aug 2020 02:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=4Czj3s31flC5dqFwzhFsKBXYwQ3LiyFoIESTsbpmCUs=;
 b=KRGk9R5QxYLEGcgH9tK9zPb0hHVJReInz2xWEdg/i/1Fnf/+Ked0UWcqdY7SsxtrfFuW
 4SMSZIDRDRQx1v7ruUGRXPxq5wQEejTHgeq4D6VA5Okol/G0YLo102jb+z2AoaY7w8UR
 uaVHga3VZLrVYHVYHrxftwrANqZkViRT9One0yWz9w/MRBQ01RxYL7yAgo+ZRpEMWoPi
 jlMYLisd3F35/BsXpcwUH4PmLtlQjbb2Ab6mM4OeZMTwMR40HD8893oPwd8UsBnYOi2r
 kvoVSqN/b+qU7Yu8h1VX1xyrQEWw4YVFFOpqvZg51TCXcu6KNhKZnL8ko4MSpFhBplmm eg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 3304emgxxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 02:51:37 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07I6jDBP118825; Tue, 18 Aug 2020 02:51:37 -0400
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com
 [168.159.213.141] (may be forged))
 by mx0b-00154901.pphosted.com with ESMTP id 3304k8un4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 02:51:36 -0400
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd01.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 07I6panR008757; Tue, 18 Aug 2020 02:51:36 -0400
Received: from mailapphubprd03.lss.emc.com ([mailapphubprd03.lss.emc.com
 [10.253.24.70]]) by mailuogwprd01.lss.emc.com with ESMTP id 07I6pJ6s008698 ; 
 Tue, 18 Aug 2020 02:51:19 -0400
Received: from vd-amite.xiolab.lab.emc.com ([10.55.225.210])
 by mailapphubprd03.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 07I6pHRX016236; Tue, 18 Aug 2020 02:51:18 -0400
From: amit.engel@dell.com
To: hch@lst.de, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Date: Tue, 18 Aug 2020 09:51:14 +0300
Message-Id: <20200818065114.57532-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.16.5
X-Sentrion-Hostname: mailuogwprd01.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-18_04:2020-08-18,
 2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=622 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180046
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 phishscore=0
 mlxlogscore=768 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_025139_388515_16D81A23 
X-CRM114-Status: GOOD (  15.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: amit.engel@dell.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

We want to avoid starting the keep-alive timer with a zero timeout value

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b92f45f5cd5b..b7883435c5e4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1363,11 +1363,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	ctrl->ops = req->ops;
 
-	/*
-	 * Discovery controllers may use some arbitrary high value
-	 * in order to cleanup stale discovery sessions
-	 */
-	if ((ctrl->subsys->type == NVME_NQN_DISC) && !kato)
+	if (!kato)
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
-- 
2.16.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
