Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1787EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:04:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE0461139
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCE0461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yONxiIXfD6TKTvJpfwQp4s3GTgyIujZBb/MCy6Fxm3o=; b=x2+otQ+komYQR2
	LgCGEBvrEaDXzY+QTTdpoYpWRkZNnWFm4fhwxg1Zz+Ha2ahwGS+xKO6DA6A0pjpicu1YazbOPpe0M
	MffXy6vicdAwO1rsJse7n07JLuXW1tkKCX3bUAA3jS69ouMkeVYoTsY7k7CY4KbqEBIynED1rt8kD
	ZQeCUk83ml9k8i0cHVAhog0hKEtK51mmS7xqoehuHSq4hRDfDzcB9S2oUWrXbepMhuuLQFfrtQ1NF
	SUlv15ZKwxgulWnTKnDiNemFQEc5jbYpLj6QxNg0a9gqYrKnON8bPmOjY+Es5tcFhrN1YW8+KZ0jv
	HZQGFXwi2Jp6ww8pKzRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY1uB-00DLMt-8U; Wed, 06 Oct 2021 08:03:59 +0000
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com
 ([40.107.244.88] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY1tg-00DLI8-Ne
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 08:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwR49doO25SqymCmnfLCE22YdQLV3I5dvZ1z8pG97LCzEpO1ZkR1B8uVw4vY7kkd2JaMqH+3FPzDlwgD1DmFuKi30ylfymMeWygYtwHiEbjqqG2YP0K9OxkaduRoj7zOZVs5axpVyzhc3y60YnrWV1Cneaho0Z/4B/AaDjmm4P6gNIUUTK3ieSe597qxrkufKTWFOOM189CmQ2PEWjPGv9Hyuglc3nAhfK74CmywBMAzr9gMoZncYZvN3okFWesPnr8Wl4vYknoWUOwsOIl2y0NtXRzrA3inC7qJXnbsP8TXILwU4JiKzvs8DXx7Bok/vg7nnINW4LaCG/mbAvE77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60umAXafixHMbdPu36hCGLmh+sW7DXCAsV2EGg8wFIg=;
 b=huB8cbKb564xlKiBVM11bbSLsHxDLOaYsbVH+ukX6UWh2j2S89XKaWSuC/eUK7jtYik0hoRs+xRWXK86qsjzd+SJeNZxqUvjySGzdBl+ithssMm2Ux18TGts7pqCmyqB47bSqA+lW4ILTzPSfwglOo89a+MlzuYqukcL1oxKS8ff0oEIrsrHiuBpOJoXkGoXc/aSWSqxD65Lv80UexSvrnf1c+fMvyM005zOrSZB5gPg5cb7/hosFXD8GX0ABZGIXBMGWtsShKnUgd7reElAHrZHRgDSUSuGsXmpxoPIir8Cln4CO6EKAaLlILofwoNTSJLXCg5BTwO5/HPmISTRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60umAXafixHMbdPu36hCGLmh+sW7DXCAsV2EGg8wFIg=;
 b=HyPx4ZLcWKq/Wo9wP1yQDju4A2hR72wyMxCAQ1luJmeqZ0cgjqxBXteuRA/LVSddpHp5ywVHNa4kJMt7u3U8QVz6Prvkmdt2O6JjzFwmt9JyEIBGPA6L6CvwXi0meyvY1lLV8bU9WRHxWWUgtlfcdkXkHrTK3/TaRJSm3vPWQX2TH4X3qgOimZ5lQJ0Uql8fq0Tnj421IZC6VZTABOmYBiEp6/3qvU2VzdCZKUh9RxS8O4CRuk/ntjCtepAxkKzz0n7Tp/6yZzmy43PpE8xBpVIuJof/RxDAEmc+vxiwM6tHlxqZACTakct/8BeOhC2QNpFoyRJQdpRniAKzC4WG8A==
Received: from CH0PR03CA0424.namprd03.prod.outlook.com (2603:10b6:610:10e::21)
 by BYAPR12MB2824.namprd12.prod.outlook.com (2603:10b6:a03:97::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20; Wed, 6 Oct
 2021 08:03:26 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:610:10e:cafe::88) by CH0PR03CA0424.outlook.office365.com
 (2603:10b6:610:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:03:19 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 6 Oct
 2021 01:03:18 -0700
Received: from rsws47.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:17 +0000
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] nvmet_tcp: Fix use-after-free when a port is removed
Date: Wed, 6 Oct 2021 08:09:45 +0000
Message-ID: <1633507785-10319-4-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
References: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483b2ca5-a11e-42f2-e79f-08d9889fc2ea
X-MS-TrafficTypeDiagnostic: BYAPR12MB2824:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2824976552923553F705300BDAB09@BYAPR12MB2824.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fta6ZjGrvvuIhg8vO8t8L2nQJQK5qZzt/kZIrSZEBxSxJ/fN+/rSbo4ODXt8ie9Kh9GRYypTvJcV9UX7P7OU/rO9zkVl7RZQlBCJbJDvm1a4UlR5wKKn7ZFCWUF/FvL2SFJqpN/W8BggacRJ0imqI8QuBK8PIA5PXxH3XAKKi44/afQRz5JE4vfE9T05QX5DWzipzwSPgyQyPbg9KKJo2ko9TLvhnm0nu61dvnzfjSKpkpzP8gVZqel8Gf7CHIO62RxnCK42spROlxvEFi+5FclRtYk8duSoV8UJLohAReW43kbSO88/Vh6KrXVg5AYJOj36sMgMvfIdL2BuCU/O9SQtgA+1AklWA1f6evMHNM4g395NSK/j5t8qCnxZ8dMV2HdX9GKiGx9C/dEy/k3Vy2aLxXy8J/zeki/UUg3NaR9Hr3kDz55xZ0/1pw4GKMCm1ejARGx/uDc6HF7ApGeOSvVlnEeYRf0l5lsDEW4CB+q3NKJ8bZhRA4MI4+peBvzGtezO7ZD8nJCJT2OivcemkicYXPfg7ylPryGOUfNVOimWO7ygSTe0IOf8YYMaK/aGiURknBKwMRaJeK5YUj5S0JAim4avq3Q2l8yM9UU58yPzOAPBjk6+MJD8Yk6wNx8Wf0kaHjWuKEkUY6+egyMcpehLxd2j3p9edF+5bmlu2nFLZr4oT4PN0JGvD8lOrki6
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(70206006)(70586007)(36860700001)(7636003)(5660300002)(8936002)(426003)(2616005)(356005)(110136005)(8676002)(316002)(54906003)(107886003)(47076005)(336012)(6666004)(86362001)(508600001)(83380400001)(82310400003)(2906002)(36756003)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:03:19.9518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b2ca5-a11e-42f2-e79f-08d9889fc2ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_010328_800499_A94EA157 
X-CRM114-Status: GOOD (  11.20  )
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

When removing a port, all its controllers are being removed, but there
are queues on the port that doesn't belong to any controller (during
connection time). This causes a use-after-free bug for any command
that dereferences req->port (like in nvmet_alloc_ctrl). Those queues
should be destroyed before freeing the port via configfs. Destroy
the remaining queues after the accept_work was cancelled guarantees
that no new queue will be created.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/tcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 07ee347ea3f3..6eb0b3153477 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1737,6 +1737,17 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	return ret;
 }
 
+static void nvmet_tcp_destroy_port_queues(struct nvmet_tcp_port *port)
+{
+	struct nvmet_tcp_queue *queue;
+
+	mutex_lock(&nvmet_tcp_queue_mutex);
+	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list)
+		if (queue->port == port)
+			kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+	mutex_unlock(&nvmet_tcp_queue_mutex);
+}
+
 static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port = nport->priv;
@@ -1746,6 +1757,11 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = NULL;
 	write_unlock_bh(&port->sock->sk->sk_callback_lock);
 	cancel_work_sync(&port->accept_work);
+	/*
+	 * Destroy the remaining queues, which are not belong to any
+	 * controller yet.
+	 */
+	nvmet_tcp_destroy_port_queues(port);
 
 	sock_release(port->sock);
 	kfree(port);
-- 
2.16.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
