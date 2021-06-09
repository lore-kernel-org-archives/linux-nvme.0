Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07947C47095
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:37:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C210D6124C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C210D6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RtlyuuwLR/lRj+GJL9TL50BleNB7RnvGM0orQOjwSQM=; b=l24iAHvYZxY3vD
	5AuEksjzeEJn+XZ0w8chOXuWr8Y4wE/bVcMq+1Vima5fqShU5QX0FETRzTELfaAVlLynX0JMrpBZI
	tDTCyEVm8w89mkNHPIsT0YO4HZgYlic2f6H2fJOYzRvi9Dl0JNJI7mMaeRhmQxw5jsU7YjDENnKc2
	xtLS9NKTRY+0wfGTFRH1+xGjhNVouuLOkbu3inSHOW04eIWfYiXwptybODhYo2BRXMTh66dHThm7L
	y0/vhafSfljwr4hKza2XQxCGe26oxepDS+FiQ4UYXR6bjtCPQ3eXZamcRjAJ7NCPXcnMogQqdd8vU
	LUD2wbtDhXostPjEV+ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqueC-00CjFE-Kj; Wed, 09 Jun 2021 09:37:16 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lquY5-00CgrZ-IO
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 09:30:58 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1599FZOe126813;
 Wed, 9 Jun 2021 09:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=YnBQKz3dqrUNxi9NhuYJmaFtMbuoNqMgRmHcuk+qdpI=;
 b=sRxE+MxijCFxqckZdPl516xZAoGyX4NeLSEsGHwHm/QVAm/0Bw+WjX4xTL2C/7NQVnZg
 zBk19bqzgQP7rN6UDxSba1m0HSyHL9gJYPemVVCczqu9MTVftCXXi5C9e9bG9t7Wdrfl
 3VAeuZLBtXH4J0eDRmuesh1HKYwP7WW4Mq2MOAHSqcrbq8psLlsRhRqXjj6b8RgSYAuo
 PaxaribDfQN3wQbDt6Z8EhJ3SSIVkUOCsZuKbnV9hA3LYobBlUQ1j7xR9WKJtIGFfVQ1
 qOoYQ7FQtfIugBcr4VxqxBGw22rtYZKGyzUB4aUkjkIYED1mswvaVzd+PbOJKby/yNFF zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 38yxscgnb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jun 2021 09:28:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1599QZRP051047;
 Wed, 9 Jun 2021 09:28:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 3922wuedkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jun 2021 09:28:42 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1599SfGF066343;
 Wed, 9 Jun 2021 09:28:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 3922wuedjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jun 2021 09:28:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1599SeDQ031727;
 Wed, 9 Jun 2021 09:28:40 GMT
Received: from mwanda (/41.212.42.34) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 09 Jun 2021 09:28:39 +0000
Date: Wed, 9 Jun 2021 12:28:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Shai Malin <smalin@marvell.com>
Cc: Ariel Elior <aelior@marvell.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Igor Russkikh <irusskikh@marvell.com>,
 "David S. Miller" <davem@davemloft.net>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme-tcp-offload: Fix error code in
 nvme_tcp_ofld_create_ctrl()
Message-ID: <YMCJv0sYKm+Gcwr7@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: dwTMuy1y2bpTs-2e3Ko8WmdLFuDxgBH-
X-Proofpoint-GUID: dwTMuy1y2bpTs-2e3Ko8WmdLFuDxgBH-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_023057_739322_A831B30F 
X-CRM114-Status: GOOD (  15.64  )
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

Return an error pointer if try_module_get() fails.  Currently it returns
NULL.

Fixes: 4b8178ec5794 ("nvme-tcp-offload: Add device scan implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/host/tcp-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index c76822e5ada7..c07f84a7e697 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -1215,7 +1215,7 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 	/* Increase driver refcnt */
 	if (!try_module_get(dev->ops->module)) {
 		pr_err("try_module_get failed\n");
-		dev = NULL;
+		rc = -ENODEV;
 		goto out_free_ctrl;
 	}
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
