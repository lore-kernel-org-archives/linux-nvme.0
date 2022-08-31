Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB1ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wUyH78Cv8OFyVIUJshB5aJvzm56GaPwDTZRmuG9O/GA=; b=DOKl0vnD7ARzeDc49VVPcZ+clM
	0PSVaXCyZftSLXfKWfCx5onF9oMakhs3TJnekz9L2DRcy1g1zzpoHdWg78e/ZlsbRwBl5rH9zbzIt
	e6AdaNvjiSeV27oOK8QaSK80QMJLIZYDiu+GecDGRTdlgP9gv1Pg6SvX33Sg1O4xGl6IKN5MHSDx+
	/RdmBdNqcAceL9XGEdQuj+ElSBs+Q4RUAQOrQy1DkzBUaCw1XBdtOthx6cjwKTCxkvPEuJZ2IPeBB
	EcRyMIZd77DyCvdTTCi63B1l5522hN24yAj+nIvD0hY9rc3zHx5C8/y1iyA2xHH78wDJAXwpGhLQo
	qUlY9idA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTTY6-007vSB-0Y; Wed, 31 Aug 2022 19:38:54 +0000
Received: from mail-dm6nam10olkn2069.outbound.protection.outlook.com ([40.92.41.69] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTTY3-007vRQ-A6
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 19:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMgWGInWMHxdbXE/OKooUxITXaLzUYBSyhZfjsR+yKJm9Sel90m/7yDH88Ryt+FLKOdzwWwtk0ch51/MrmX4BPAIjw1zEjuP4teAZ5MBYe6Qejip8r91Lytb9y/kuM9OniZ0CvbzCPe51kjKHq73fXXBFmNW4DaliYA+JurUBk7Nh49rmeQPhZf976q+sGBLG/wAZlzSekCuC8a6edxmha+dUo7dWwjK4C877C4VULfxcVhFDKZyk3Zj/2hn6BsRG0nX99FBylUOgv42Q0vEE3nHE5tCvR1+271/i59zPC7OWvgW8kS61K4WBpgs5QNPFvAioe6Q5+0+AYOnp70e+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUyH78Cv8OFyVIUJshB5aJvzm56GaPwDTZRmuG9O/GA=;
 b=N/I4mI1qeiEOVy9sLmMLcHtvAyhbLd9CQrhCL//BaawSnyY4frTU+m8WUMx8w/byhBgkEBiNDbcDi99LDrcOZHOXyjEq7pQDROa2GFPlQIgNoESQyGu63Nus2p5kdPxv5TY6tvn7aXBee19nRHqRDOOUndAPiKZzX77DJlJojQKzgah8zE+PuZUktKx5/N+5YQ113f4vBnIz2vJYHRL2XWEO+US33sm2VWgncJ2jdazH0yGsarfYlNmE1jRWzye1niXEANZ8UMc+YvBCwXUE/eYuUcT7wNK+1QD2ZGeKwdJpXA+SrCCwgTPWkGWM4F5CqpyLVSzZ72Ij7n7xuEinag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUyH78Cv8OFyVIUJshB5aJvzm56GaPwDTZRmuG9O/GA=;
 b=jbZBB3P25JPVic96h+lMhFnNVHR1wYvMDBn5/iFiOSTpKxNSZ1qC9ZIxBFNi4bgdOQ90vJAlECSaj3fvDBU/SiXICaHyZXIjRyko9yR/XjbYQyRHJjyYl7LBw4c/INd1UI08eNSkbOssHaG7kwMXlk7EbGNchNX9o2mvkEls/bjB2d6P6oPRq7ULFIQD0hYNnAzeLSnqE2zrTHLUGk5tNfEwkDKYRqYCWFUdFe9eRFEbrHScA2s0adziKPoGd8DOgheinYDNOn4kAZsxvpsnmtg1R0NDlASdlqcgivghTOuciFYEvbDpv4HBHcvl/PR6YTUkpsCiKXrZPujwM5Kgzg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BLAPR13MB4660.namprd13.prod.outlook.com (2603:10b6:208:321::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Wed, 31 Aug
 2022 19:38:46 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::99a0:3364:b3a8:f5fd]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::99a0:3364:b3a8:f5fd%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 19:38:46 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hare@suse.de,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH v2] nvme-tcp: Print actual source IP address in address attribute
Date: Wed, 31 Aug 2022 15:38:36 -0400
Message-ID:  <BL0PR13MB429186CED76BA96A2AD3D7AE9C789@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [WofNvyxsTXpSqC+KHYT8y06rbsF+5ebm]
X-ClientProxiedBy: BN0PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:408:ed::32) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID:  <20220831193836.36301-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79586404-c018-4c7f-7205-08da8b886b35
X-MS-TrafficTypeDiagnostic: BLAPR13MB4660:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	oMfvc401oiP7/ITvibaVKkOwZ122C2/iRGVCq7apN54UQsT2tsCFE+2Hx+bjB6x+bxn6TMkCgimA9a6LUjtsmaAnVuLnYydMjb4GZL02ZN5sRuVkELq7Z9koRtlEWYOvEi87zjxCAu+d4iBuBf5iRMNARvdJK/EbPDJq1rRps2N/xrNeMeTaimg2eWXAEkbyavNnJHBgiQRQvBz++sdweCxKHvVZ5Ixe1pG7Mti5MOruqR8bS30usB2b3YQPvN/Bdu3mYvB1WA1t/r+lRU7KKtDDxZIHRzhJHUsmrdBHJoTTPK9Hs75eKly6V2AOFak8z/dWR4oUq6mrNksFCsMD6atIcuXBWHzCBMtRE1i3LuNokbo6916fteBQDZ7cR9BIkmhQ2/9J+zafVUW30OTeyCkcwENsY6dDXO14hzVyj/Re2GxCc7zvqC6VK2DwpeMMVvvcu5zy+7pBaLl6unrbsT/+JV0Z4lAJqpCXXuXoilC6vbyeS0KE05BeWa1tx1rHuNWxdSZ9Rr1CQhzjmzrt72FWZfsu+gIerSpBTAzVjeNpmms03VbH5Z+HzlXjkLYf6b4SivPrmz7vFMn2GG04ckjPbaHIOGHfWvljJZKdq45+PgT643qPNwI4C17R3KV5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?wJm/4h+SC80jUfP+PLzIZ99m6LsGCbpZC72lgoborfZbONTw7tWUJHu1rSyd?=
 =?us-ascii?Q?DmWtZTTbErzF2EhlEXrTfNIAyLultagoamYrIkBne0r+HZlU/TkKBTrI1TB3?=
 =?us-ascii?Q?B9PSkWMcKMhJyOc9ar1XFKO1Yz7nUEyCQzm8nIRBVPGrtc2SvmmJN+N8Xrm5?=
 =?us-ascii?Q?j6K3mbG6EG8PYIyxaW8H4pMPW+IWY0B/g5o2kF7/87lrWihFJEbD22m6XqYU?=
 =?us-ascii?Q?U46bJ5NjT2kzSxhkAxfP4ND91igtVH8/qsDgghHn5tIzj2bn6ZQg3VAoFyzg?=
 =?us-ascii?Q?b3YCR6lcLhgXhnOGfGle4EETxq4CVHgYq9ufuIQLK8hbKbTCByP5y4qYZ75X?=
 =?us-ascii?Q?bV9SKTer3dsnbxMxWYku1hAkddT5jRzEuV5u8PFJ4Xlo82kXg9QaUe4z7wEf?=
 =?us-ascii?Q?h9osYVN80+LCXxf+H6W+LSdJcyuAgZoM+PuQWYAPrkgxVjfuAo3RBkwIHoGm?=
 =?us-ascii?Q?KF8h3mcN3UpqPpHS3qsUftyiYsBqIzpIjHyKACQdTH2vc8da1dBsrPFNOBVZ?=
 =?us-ascii?Q?6vOQWzW7FpaIVfZn98r1a+4Ki14oR6n0h2c5D4Wt/POk5V0tYwSiFqI0CPGi?=
 =?us-ascii?Q?B9Oe4/nk4NtkEwwGjGldyGUmsyOMV1RKRBFWS108BtcBDIwRUbYar9Sdf/s9?=
 =?us-ascii?Q?dccsMGEX3BJ8PcP1v6Tc8kIFOtepnF7sg0Jo3MlsPlvdIiJGOMY2vDPvQsPC?=
 =?us-ascii?Q?W0tF1vrtPapNbaQKh9efeBO9Ec3073NeGwjVTBNFuFNb1x/OelB3KoisyFNg?=
 =?us-ascii?Q?P2d9E0a9UrIbA2nEHAH104sUb5D38JLvHTC5BQJv0zQzcUow4GV0FrU8JTZj?=
 =?us-ascii?Q?dommfdRWh4uwthuAABepSpNtRaPHwjpk0P7L9J7sSvPajfSqLXjph5SUIGs9?=
 =?us-ascii?Q?7FxMLMKINsTtfOOhMJCVRltzzSku31ofSIoBJ4wAVBSRNARiFYzXHa2nb7y4?=
 =?us-ascii?Q?ZY3KmJToQkjghLxZQWvRCDiN7gDc+HEbISnbkX1jPA/1zFoufZM9mudEmxB6?=
 =?us-ascii?Q?o4jyejplV/dUgR0tRNfkCBaAu3ll9ehxfr6Q4bIXthj2VwnRgmXM2VWTaZzh?=
 =?us-ascii?Q?PMLe8bkWPMsHdb+lKpWvNDsblMPrhBjEjMlSuW6aCw2jPE94L6LRcS6OlYcf?=
 =?us-ascii?Q?J5q6EahUpwRWyXbIpOLxtGOE7H+edajpPgYJbi8VIxgNb89NWPkEkIRaQX4Y?=
 =?us-ascii?Q?diBJ86WEqhm/pIMWByHo4K+Qi9T4Q9nobux/AxJJl43rtjM2b3MWM7m+a0zt?=
 =?us-ascii?Q?v9FSySU9AAKc7rRPcVp4hFD8PbT6P+5EzQgtiF3nfw=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4660
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_123851_384704_96D1DABF 
X-CRM114-Status: GOOD (  18.54  )
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

From: Martin Belanger <martin.belanger@dell.com>

TCP transport relies on the routing table to determine which
source address and interface to use when making a connection.
Currently, there is no way to tell from userspace where a
connection was made. This patch allows exposing the actual source
address using the host_traddr field of the address attribute.

This is needed to diagnose and identify connectivity issues since it will
allow us to tell which interface and source address is associated with each
connection.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 044da18c06f5..adbb76483a74 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -165,6 +165,7 @@ struct nvme_tcp_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
+	struct sockaddr_storage sock_addr;
 	struct nvme_ctrl	ctrl;
 
 	struct work_struct	err_work;
@@ -1597,6 +1598,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		goto err_rcv_pdu;
 	}
 
+	/* Retrieve the actual source address from the socket */
+	ret = kernel_getsockname(queue->sock,
+		(struct sockaddr *)&ctrl->sock_addr);
+	if (ret < 0)
+		memset(&ctrl->sock_addr, 0, sizeof(ctrl->sock_addr));
+
 	ret = nvme_tcp_init_connection(queue);
 	if (ret)
 		goto err_init_connect;
@@ -2532,6 +2539,31 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return queue->nr_cqe;
 }
 
+static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
+{
+	int len = 0;
+	struct sockaddr_storage *sa = &to_tcp_ctrl(ctrl)->sock_addr;
+
+	if (ctrl->opts->mask & NVMF_OPT_TRADDR)
+		len += scnprintf(buf, size, "traddr=%s", ctrl->opts->traddr);
+	if (ctrl->opts->mask & NVMF_OPT_TRSVCID)
+		len += scnprintf(buf + len, size - len, "%strsvcid=%s",
+				(len) ? "," : "", ctrl->opts->trsvcid);
+	if ((sa->ss_family == AF_INET) || (sa->ss_family == AF_INET6)) {
+		len += scnprintf(buf + len, size - len, "%shost_traddr=%pISc",
+				(len) ? "," : "", sa);
+	} else if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
+		len += scnprintf(buf + len, size - len, "%shost_traddr=%s",
+				(len) ? "," : "", ctrl->opts->host_traddr);
+	}
+	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
+		len += scnprintf(buf + len, size - len, "%shost_iface=%s",
+				(len) ? "," : "", ctrl->opts->host_iface);
+	len += scnprintf(buf + len, size - len, "\n");
+
+	return len;
+}
+
 static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.commit_rqs	= nvme_tcp_commit_rqs,
@@ -2563,7 +2595,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.free_ctrl		= nvme_tcp_free_ctrl,
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
-	.get_address		= nvmf_get_address,
+	.get_address		= nvme_tcp_get_address,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
 };
 
-- 
2.37.2


