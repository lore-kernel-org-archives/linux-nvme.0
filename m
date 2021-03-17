Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4822AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B410364E74
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B410364E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QcwBFv+aVuMjbRJcWUOlT1Ts1pCrJjPV1jtIn5EDp+M=; b=MtyVhRrLUQsN1+OTmebD26Vnah
	QMP6wTQeYySz3fCwv1q8T9iLcKXGd9jkjjqp8isstgJGIthnj4K4ZE1M2HcLFyYy/oFbnzNWG0a0P
	ZV1ozI1OAhRbQMa7YXU8R3gExq8gJqYPgaZ53E8nWb9uJ1D5r1ns8nTNI/szGigaqPBg1Ojll3Am7
	rYUyibsedu0IdEeAFPneMHGSbVLhTiThFrCPp4DukUZMtwFNjPmMEIdGDNS0NhDH4OzjXV8P10XyN
	WYTCNcJbonfcGG13fcE3wlngrgNcJLj9pST2CJyAu+lqHPgvvsTAfmmjMuS+YhlYm5eEKsiEAjc5U
	ywjXPVug==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMd8J-003swi-2h; Wed, 17 Mar 2021 20:51:11 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMd42-003sdn-6Y
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 20:47:42 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HKfPxS155367;
 Wed, 17 Mar 2021 20:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=KeHOMw0AkghoUugZ/9YxQC2wHPZ6vu5PdwsZV8rTZuo=;
 b=JXuuIMH6YIhXpFB923x5uL7ruXFytVccIZ2Luqv5YDFrQ4pJyapLfPSacTFAtJL6XcEh
 lP0BbNTBeOVx+BR1a3jpnGbHA7V3PmnsTwizfvQVAtygxqb0WEYUQfOCCcGugfmMKBBm
 b1cwIYi+x4hewXxg95NHTJj7JEhGlAeGGQ55qkl6GVnHVjiuhCDev95f0gMvUB9QNTpv
 XPCB23eey9Fe6Ap9WLm+8JvD1dGKRm/5bdOlNwuO3nrE4GbMz42KLA5duVn5v6oTDsFu
 25QuNQV8b2RKlyoxDRmJZuw1qLkxylFP7YDzlfqOTBv8evYwNRNVoCcnku1sVmlmjaGe aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 378nbmdgg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 20:46:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HKjSVs074572;
 Wed, 17 Mar 2021 20:46:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 37a4euvm9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 20:46:30 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12HKkNdK001226;
 Wed, 17 Mar 2021 20:46:23 GMT
Received: from localhost.us.oracle.com (/10.147.27.236)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 17 Mar 2021 13:46:23 -0700
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 1/1] nvme: Export CSTS register via sysfs
Date: Wed, 17 Mar 2021 16:46:15 -0400
Message-Id: <20210317204615.13971-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210317204615.13971-1-alan.adamson@oracle.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170146
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_204741_297426_254DCB10 
X-CRM114-Status: GOOD (  16.08  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This exposes a sysfs method a user can invoke to request read-only
access to a NVMe Controller's CSTS (Controller Status) Register.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..7736b8b0891c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3683,9 +3683,24 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	ctrl->opts->reconnect_delay = v;
 	return count;
 }
+
+static ssize_t nvme_ctrl_csts_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	u32 csts;
+
+	ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts);
+
+	return sprintf(buf, "%d\n", csts);
+}
+
 static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
 	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
 
+static DEVICE_ATTR(csts, S_IRUGO | S_IWUSR,
+	nvme_ctrl_csts_show, NULL);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3705,6 +3720,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
+	&dev_attr_csts.attr,
 	NULL
 };
 
-- 
2.18.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
