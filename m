Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ADDC433F4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:00:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8846D207CD
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h3APa0HB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kw4uvrnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8846D207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4k9kecX/zggVdOcEuYGjDV0j1lh58pY3onz/FJTabag=; b=h3APa0HBjiYii1VQ74ca2iA1Iy
	z9WZrStcEcBewdaSyB/jpynY6UoEV+xV/LLWMiD9QZSAQfj8flybf6tEbZypm1hUk0lRP2GH1Hx01
	Vo0RC5LRe/rYH4EQnTb70xT99M1wNwtaRbFlr3+rFJ3zJg/Wx/o8vvh4PSzsJ48cGy/oEjRUvF0Pz
	LACkaeL2FTnHVmsi26MKcGSfrHrFxb2NRDi9ovbFLIoRgZfM2TPf6S3qVhTYNz6miQDbYqheVkO+A
	xf5/5p0o1mGbpiqbS+iUPcVDRbtNZNSSPW+SVtPPhdgu91AwUHgffwEjvf75LE7OLYeBfe9yt+SIR
	Dxn5dxYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvIfV-0001BM-2b; Tue, 14 Jul 2020 11:00:13 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvIfQ-0001Ap-S5
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 11:00:10 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EAutPp077213;
 Tue, 14 Jul 2020 10:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=1x6qwlrKTPePi024w3X15nL5DpllLeKkUGjkROHYtT8=;
 b=Kw4uvrnzymlb90KBHi07zkkSPrLT4fIr5u1kmOAECAjsi1kvliA62FDGeByGpzUBZmm2
 WUQnIsoiXmDxJQcxuVSKSNEXlG1ntqlw+wY6uyseKegDCd+7eJeudidIkjGVxCgMnfIC
 WVAMSq3k4wyG3KAXvGvvy+L/Zan1P4EgjrNXodtj30mtQaABdYWgJehmkTAe61WK3S4X
 TZD9se17A/OqC7faf80jAVP9Ck3u/AT3FrbB2phUoOcogcnABMqpi47hAkdw0gyPjRdR
 4J3pmoHJn8w6S8hCidF1sXbaXzMvjvGsTJWvhp9hxetEaX3pquI4OgkJXLO9U3op6PCz RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 32762ncj23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Jul 2020 10:59:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EAva5t109870;
 Tue, 14 Jul 2020 10:57:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 327q0p0mcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2020 10:57:40 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06EAvdhT023500;
 Tue, 14 Jul 2020 10:57:39 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 14 Jul 2020 03:57:39 -0700
Date: Tue, 14 Jul 2020 13:57:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: remove an unnecessary condition
Message-ID: <20200714105732.GD294318@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_070009_091883_BB4ADDC9 
X-CRM114-Status: GOOD (  20.55  )
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
Cc: Jens Axboe <axboe@fb.com>, kernel-janitors@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

"v" is an unsigned int so it can't be more than UINT_MAX.  Removing this
check makes it easier to preserve the error code as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3d00ea4e7146..5fb5e8ba531b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3586,8 +3586,8 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	int err;
 
 	err = kstrtou32(buf, 10, &v);
-	if (err || v > UINT_MAX)
-		return -EINVAL;
+	if (err)
+		return err;
 
 	ctrl->opts->reconnect_delay = v;
 	return count;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
