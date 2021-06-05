Return-Path: <SRS0=5W8M=K7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7494C47082
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Jun 2021 12:49:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E26A61357
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Jun 2021 12:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E26A61357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1ZAGRNyDqyPntAZCqspHWacyEv7F5NZam6EO8cX157w=; b=wmrYbKMtl/L0c9
	a3kxHtzrKBcpaBTg1RVxnsaaYoiQSkbWAz8axPv6g0WacG/4tZUKkQcESMjSuEd/GfEGzJKi6lH6t
	nqMzxsvXLCIdRwmyFwFpApZwtKm5SlV8pH7RzZjqma0gyrYQxshAxgxcLdATqwvu+9ZWKEAQ1o7AP
	Jg3miMbEvNyE8qFa36EvvngtWNvKdRQ432XoHukc8w62wEcOI0nbHqNs55a08sQlSnw5HRK8HHWvK
	l16GWJWAF2rxYns9XCwza7zo5LGOpxNiy9UiRikNxgxCfE4RbxYi7ifA2CE+wD+klzUSWUWBOf0fi
	xfKKf7ej6wHIn8vuMQuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lpVjT-00GZUw-PC; Sat, 05 Jun 2021 12:48:55 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lpVjR-00GZUW-DG
 for linux-nvme@lists.infradead.org; Sat, 05 Jun 2021 12:48:54 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 155Ci19S112138;
 Sat, 5 Jun 2021 12:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=07BOHHPaJrmXU5W7/AFSyJRb0cJYxMTbyObPQAH3yd0=;
 b=mGX/IO+Z5uRjA6BmSCsJIH3EHN1cA/bFccMo28wvQn0j8IUKsDqExKMVADpCJdC/z7Lp
 6zRGxYM8f43SX1E3tUSViJE2EKutMpZWFaj3b4CFsMKnGejg8C9HJLrn2Xe0SbmaIWRW
 2Ocyi/2GNw+spmCOsFvyrFWTfjA3lCtoUHj7FeEg6lK1gSM1clVYGYblku+c55CH2syu
 smp15iY5RjKRcfq/TF1fO5kwN0z9B4SEy/NKkdmTQnoGwyEY52mORs2Uqp/YEtkLrl4p
 MOfSPOqvr//GDBwC7T3M552JLcDSgCanAS/eVEZqN1P+yuJqV3nqe0yECGMymmwdy6sO xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 3900ps0cm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 05 Jun 2021 12:48:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 155CkOwo135464;
 Sat, 5 Jun 2021 12:48:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 38yxcsjrq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 05 Jun 2021 12:48:41 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 155Cmem4137233;
 Sat, 5 Jun 2021 12:48:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 38yxcsjrpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 05 Jun 2021 12:48:40 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 155CmW3p012720;
 Sat, 5 Jun 2021 12:48:32 GMT
Received: from mwanda (/41.212.42.34) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 05 Jun 2021 05:48:31 -0700
Date: Sat, 5 Jun 2021 15:48:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Roy Shterman <roys@lightbitslabs.com>,
 Solganik Alexander <sashas@lightbitslabs.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Message-ID: <YLtykIn+Or0l08oV@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: c7xZCEaeYkskdruWm_5pWeTmldsdxDrL
X-Proofpoint-ORIG-GUID: c7xZCEaeYkskdruWm_5pWeTmldsdxDrL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1011
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210605_054853_607809_09E96251 
X-CRM114-Status: GOOD (  14.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

These error paths currently return success but they should return
-EOPNOTSUPP.

Fixes: 73ffcefcfca0 ("nvme-tcp: check sgl supported by target")
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 34f4b3402f7c..72e9d34c3092 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1973,11 +1973,13 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		return ret;
 
 	if (ctrl->icdoff) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
 		goto destroy_admin;
 	}
 
 	if (!(ctrl->sgls & ((1 << 0) | (1 << 1)))) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
 		goto destroy_admin;
 	}
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
