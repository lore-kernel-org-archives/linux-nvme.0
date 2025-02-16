Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBEAC02198
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Feb 2025 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cyTUaRdZQwcaRgQk9hLJR8DWVhshD3rU43Dw1pWes9E=; b=ZLQcBI8s7tIMFNASkOITR+i2sO
	Pe/lqAe242GJDeO6eQfPic3/LUKY0ZmUzj/S5KtGrr3ko+dy8EO20Z5YWdTLD47A4k2edH0cRZKpQ
	WJ20nvBs131xXnYKT14gD9d9awAH4VipnuQBdkjc4Q3Wy3PvjPYf3tSVCxpqhCOlYbuJWzyXSjKa3
	/YZpGSfIM3Q4nF+gRu++/yU6nxQNSV36rcjS42EqIz0i9Acg7egzvMW5JUfMj+BhqBlSRBlQ+WzWF
	zv7uW2mC2mlChxPZ7VCvePIT/YYUw1VoDzeWp/9IJHERiE5EgHirj9VMDjURg6+P2kILjRDKShKGh
	bBwvkSHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tje6W-00000001oD3-1PJa;
	Sun, 16 Feb 2025 12:50:36 +0000
Received: from mail-psaapc01on20702.outbound.protection.outlook.com ([2a01:111:f403:200e::702] helo=APC01-PSA-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tje6O-00000001oCa-3iFl
	for linux-nvme@lists.infradead.org;
	Sun, 16 Feb 2025 12:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA0K4voc6leLkOaJiXIf7YrKdiCQUjDQE1FuCeVnmBgWS9bFFbK13uUMNbELG72x5Sk53PZg/J0ltKxSwMpMuyhfcdkOIJhivQkG/iNqvKfvlJYTgatkeBncqmg3AJNuEil5VjgQ9wGsvIyO01o95zoMbujJsol2+PDLvCLf8xmArHOmLeVt8qeIApamndiP1Q1V5gntOz96kmDCSF08wGkmTGjUXoR2c3/WKzuhEgB/1JFAvMkjGF+jum7WzqFxZgkA02Mtz/8jpoKLMw+hvqcZgsCyxCsZYshgtzKM+YyaXjPntXNdN2UsFrhkonaDF0fPmLo7p4JTx5P/LpijEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyTUaRdZQwcaRgQk9hLJR8DWVhshD3rU43Dw1pWes9E=;
 b=s3y+2/6dM2f5Sqfg/FA5it4tCNfY/JUeK0EzAIvUsgsOdN8J5yELSGzvhdETVFrzOqpTMiH7u+O6Ql5SeVo6XftwSYuUIXR+VgSb5hK+fajmWTYVcnSSCnJ10JTFrO7iTtv625qlqulIzQvMHo2AYOUqVSipK8py6knAFXXbEMQN3kvfKWjes+9k6k0uddLBpgUaTKWqwe6GrKp3UNSUN5uzXTpBbBE0ZDN/G29RtK2tJU52YzNO/3uwiaiu8dgStsw82mfFsfnU0VrxKGu9GLD9L9w37LHhswF10XoE8gaix0k1Sow/tjIBJt/HNCNn6vBXdrVwRRY92hv9nPGR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyTUaRdZQwcaRgQk9hLJR8DWVhshD3rU43Dw1pWes9E=;
 b=o1QxKEIgHnB8Nty0xuVWkJKTdKO0YIKXu9fmeyOpS5NlbeeViu6TSAMT44lyVbPZIN53rvxN/GdKyM1N+QyXEXc8ubfoI2zOBNdE3BWl+eiePS9EmaRrZqr34bx6/qcyAn7dJx5YYK9q0XyBCYhn8XEpBWeC2A4Vlm2BTDYH7MM0xQawWBexe4+vnXS7kaqv4thLIAlrdeS87Uv54NCY8y7x202Rc8tTUkV++4goU+MwK2fZDVeUXP1nQa43lfOEeO70D7D0C9b6sgeQ7sDqUCnc2cVTl6BgSvYVFsW7hHuqH+nr/EgfY/OS38VlV01vQPvY/WHg540W5V4gNC4Xiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR06MB6257.apcprd06.prod.outlook.com (2603:1096:820:d1::11)
 by JH0PR06MB6631.apcprd06.prod.outlook.com (2603:1096:990:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.9; Sun, 16 Feb
 2025 12:50:11 +0000
Received: from KL1PR06MB6257.apcprd06.prod.outlook.com
 ([fe80::ea4e:11dc:3350:b520]) by KL1PR06MB6257.apcprd06.prod.outlook.com
 ([fe80::ea4e:11dc:3350:b520%3]) with mapi id 15.20.8466.008; Sun, 16 Feb 2025
 12:50:11 +0000
From: Ruozhu Li <david.li@jaguarmicro.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v2] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Sun, 16 Feb 2025 20:49:56 +0800
Message-ID: <20250216124956.3881-1-david.li@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To KL1PR06MB6257.apcprd06.prod.outlook.com
 (2603:1096:820:d1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6257:EE_|JH0PR06MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: f9746773-6b4b-4dab-e24a-08dd4e8872fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mBY4mW609ll141Gejhbvof7mYZMiIbqpSfGfFziYglDZuSXa5+qxUaCtw8bP?=
 =?us-ascii?Q?di3iV7tAQ8R5ALAgi83NFHOxNgwN8jk0z9jc8kuzvKWya4AvfCI8qw2f8y/v?=
 =?us-ascii?Q?ZWf/Fr29PRZhf3YVkb7evU7YRmsgQVzDSOK2E+SvTdICFdtcsZwGYPoq1iSI?=
 =?us-ascii?Q?js6ZteFiENL0xQETyB3vNDbbsslnlqv2pug1up5Do1lfu8L/SwqS5fRyGxJT?=
 =?us-ascii?Q?3wKA849YpyewACkUWLTtQHe3wVnBbP4l1cfoLoqA2CDMbJj2+IJ0PqySyc9Q?=
 =?us-ascii?Q?X4g6lgULfHl9b1c4c2PmKjucYQ5sQqMF1eIz5z3cXUn37jvaQbn6DpJ+VYVh?=
 =?us-ascii?Q?EgepEMC96RBQ06buCCiHQ2dAKD3aqr6uxXuJkbTDjJbXWcxOvbxHtMI/+7KW?=
 =?us-ascii?Q?aamSqO/SC3td5NRdiS2gM69aFXXPE9x29kbGtHmNYLOLa3X4zvEWMEFti92i?=
 =?us-ascii?Q?4Gkc/MQ/+XzbfHRrEgh1ZaYBQMk1TQfGv17RkJklkRSNFpUAgpfBjkljreGj?=
 =?us-ascii?Q?tOT5OPEx8D8Cv2aaAIu3/zqC355adP5Z49B/eB1ORrvEUZ06MtIQOn5NZB4g?=
 =?us-ascii?Q?3H82IJ+m3ShlJUTMPusU9+FYSLzvcUXwI89HCvAn1jq1w4v176YOQDfnnRIf?=
 =?us-ascii?Q?yrzvoE+bSwyma/l8PLmFFnqmbKRC5S5exObVFXccj8mw+l0BMqDJYPq1MNgV?=
 =?us-ascii?Q?fKZGIsJb2Yqms4/3AHHGRQMsVLk9zIf0DIA7TZzk5Gt9Ru8L6A4Bol3Tpora?=
 =?us-ascii?Q?iRhZItWsi9igxbB/SfyiLc4qLGboZa01wCB53igg+t+6yb97f6iKIjOdJRSa?=
 =?us-ascii?Q?Vt2JbDJOElVU7afGou6GUvGsGO0MGou6g/KW3O1ZE2aS+K/2H7WwdXB6XT5W?=
 =?us-ascii?Q?Fa+VOav5gqOUhb/W9BQ3XRNlTJ5DD7Tky5wnNT1LDpBw19OWJpo/HKnhFVeG?=
 =?us-ascii?Q?eYQpwwLNgmZwU+K7LkXAuiwyS5pOSTREbSordRqpHobUeRa8Bg9+wmlbyThg?=
 =?us-ascii?Q?UBqSo42rbchNFaKDqjR0lz0VAQpE2xoROvc4IjjHYdzGJaRtIBTI/EjqMAs0?=
 =?us-ascii?Q?pHWVtnVuKJmlgOUQQzxi2gkSEA+CBMVbEC0XUcpasvuLZcDkQ9DM+JxLcIHn?=
 =?us-ascii?Q?M2RUGJMp1345kIRKlEHDuws5rz1MYwQJsPmRoVdrtTwn0NzrVsTxqRuPP3pk?=
 =?us-ascii?Q?yiQ7XGwrBYGQCNHiakkK7Q8jefhJMzOFqM+EMSOGN6QKreXbCbcYVmMx94Hl?=
 =?us-ascii?Q?z3RVd4gP9qmk2L381n2ZDknzwjZkOSkvwiHAa2Nao0DgbZrV0t7x7p5FB5KX?=
 =?us-ascii?Q?xFDy0+1A6Mwozcs0SYVXy0RIi+BdwwaOA9S5qzyS1GomAwRkpJV6bPUorNn4?=
 =?us-ascii?Q?83RC7ybTnH3teiok3tGw1sgH0jDk8IRYWerzXVqst3j229PdG8l3DbdXR0Bd?=
 =?us-ascii?Q?KQ3cSceXrw5gN4uRRWDNm4M67Z8RkxYt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6257.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+aIg3m1VeZBLNd/xVozAhdQg0aGwT21JR5/uUPo/TAYH92HYaMG9Bx0OPxOZ?=
 =?us-ascii?Q?KFdeRPMg9toSH3c5G6Pc9fJxR7atl/+X7Rk3Npw14d5Pfldp+1Eh5MGE96+E?=
 =?us-ascii?Q?hE/Cf6qiTR+VxkXWI9m8JmDLdjGrPyJl8g0IrdsxZRyexsH4rddX7gq3O+Kx?=
 =?us-ascii?Q?WV0cIhQxrkjsZiR9BTvqDFr3DYsZ+1jy3DhJsmhE4z3xywogyBhav/X2jlKd?=
 =?us-ascii?Q?sIfRrNPaG/ayr35SA606l1QjhZEm2Zymh5NugfrFx1V0lTKqli/f+7X13RPr?=
 =?us-ascii?Q?hl+MARxhOiyTjfcwibuqXpB1ri8dRgQwv2hit/rGw/0N/tgUVNlNG7y/tfzG?=
 =?us-ascii?Q?iJEmE4IkDUwepAToJj/47/qYA51Pch6SOhEkNuTv2glORgkxKkiUiNG+0dDN?=
 =?us-ascii?Q?FXB8z3N+GRPq0Iwj0spcLc/uf/tERUQx6XpxxIF1s8IL7stLT9Y7rFH2Mbcx?=
 =?us-ascii?Q?SMGnu0qwwnBOKVBf9HIPco5ayHZvoNNoE3/2I/UNpbtO965xlp0rRe5d50bC?=
 =?us-ascii?Q?RoMY+XRCxb53QpaypfyL5PpR8ApR1B+P+VFMz8VDxnxZUNOOI56yGL+AA9zl?=
 =?us-ascii?Q?FgXFGLA+tNqSwxiwaquhMkEpxeaqVLsGt3N7pWQ9vN2Zm1HEmtgU6/S44wgr?=
 =?us-ascii?Q?2X4QHvpWUhVR2olXjPxnWXCjbeT3VCJgMMYhvqwG4fiQKor/rxHpXW/W3V0I?=
 =?us-ascii?Q?ZbIjBMXuPRKK4I3jFA+F8GLFYIl3mv70L0c18/a3Iq1g2aoHJdpHRwC8Ylno?=
 =?us-ascii?Q?jr2e3tNH/WE94Ylt1RkM9s2SP6GLENGt+udGuWs4gmdP6W7Fo4R57+c5QKJC?=
 =?us-ascii?Q?giONZXuSar193yOV3gCgz2PHNPpmafEcFb5qDCx8z57UjbtedA1OWFy96kbk?=
 =?us-ascii?Q?iJTC5Mf2uM0NNMaiYkf8/qBCiEMC5gD0s7MjPJ9sASOQzTSMOMi2HDUl+ozT?=
 =?us-ascii?Q?iX4Elil5ZvKK9Gw/otfYY4HlZ6Jx3iNQsyKFK2APlp6pzxl2GilklhInxYpK?=
 =?us-ascii?Q?K3kD19uoBwLoCASGY0eA5Pidp8KyVrO2sRykmW01Vcbn/dztis1UaC6h4ISa?=
 =?us-ascii?Q?jrXTxj6m6sZnILfEpitEK0sR2xvkxZ0NNYBJcIaY35yKmJk8w7ZzP0tKqsHG?=
 =?us-ascii?Q?BbBfTA1cz0WzDkuPpzlem2H9tAFh/i7O2rpbcBFmO1nfimvAB7AOFlkoEGLo?=
 =?us-ascii?Q?H2y5sRKPDtd+0dTCtlwuX/R7LSoKIgUGwbl53EPCvKZ3UnrU6b9LuJMGFbSF?=
 =?us-ascii?Q?ZHxcSGd1QBrj9ObFSIrYPEt3cEkYbcfHtaPMwKvPzDS7peuKfOQE6Rl4gq9A?=
 =?us-ascii?Q?abvKN3FxWikR9Kf1RojJCZJIgEvNCz8MCTN+g0GyvHNlSYFdjkaUCSeS0Es6?=
 =?us-ascii?Q?cFI7vbFx0ORlz+yuL9XOJYY6uoHexBdDoYncxxY3N5NGen4hiOEv738+quGs?=
 =?us-ascii?Q?BBKRRSaI5uxvVS3Jx4gmxF9gC79+vydTv4MLZPzTsbEFSkTjIZzyiBQSPVjT?=
 =?us-ascii?Q?26YDwpfBkOdtJUER4FkinXzek2YlHbqHtWHh/wg3nxkTBu07q6I5mhu1BuiH?=
 =?us-ascii?Q?lbnofhiieAyyu04AH031BlHqh+dRXKhyVmvO0HDgG8dnbSK/xDuj1V9pLKv+?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9746773-6b4b-4dab-e24a-08dd4e8872fd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6257.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 12:50:11.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DJPZWSsBYBt2/CYokOc4QDCdn7JqYS3ScjTFVrcrLHsIJLm81oTfVPMlkjJ20/3ncl3aY/VsOvRPXbaDmxzRXK0DvuB/UTA3iSz2L5aIuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6631
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_045029_319751_63A83BB2 
X-CRM114-Status: GOOD (  11.65  )
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

The queue state checking in nvmet_rdma_recv_done is not in queue state
lock.Queue state can transfer to LIVE in cm establish handler between
state checking and state lock here, cause a silent drop of nvme connect
cmd.
Recheck queue state whether in LIVE state in state lock to prevent this
issue.

Signed-off-by: Ruozhu Li <david.li@jaguarmicro.com>
---
v2: Add comments and modify the code structure as Christoph suggested.

 drivers/nvme/target/rdma.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1afd93026f9b..2a4536ef6184 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -996,6 +996,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	nvmet_req_complete(&cmd->req, status);
 }
 
+static bool nvmet_rdma_recv_not_live(struct nvmet_rdma_queue *queue,
+		struct nvmet_rdma_rsp *rsp)
+{
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	/*
+	 * recheck queue state is not live to prevent a race condition
+	 * with RDMA_CM_EVENT_ESTABLISHED handler.
+	 */
+	if (queue->state == NVMET_RDMA_Q_LIVE)
+		ret = false;
+	else if (queue->state == NVMET_RDMA_Q_CONNECTING)
+		list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+	else
+		nvmet_rdma_put_rsp(rsp);
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+	return ret;
+}
+
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
@@ -1038,17 +1059,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rsp->n_rdma = 0;
 	rsp->invalidate_rkey = 0;
 
-	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&queue->state_lock, flags);
-		if (queue->state == NVMET_RDMA_Q_CONNECTING)
-			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-		else
-			nvmet_rdma_put_rsp(rsp);
-		spin_unlock_irqrestore(&queue->state_lock, flags);
+	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE) &&
+	    nvmet_rdma_recv_not_live(queue, rsp))
 		return;
-	}
 
 	nvmet_rdma_handle_command(queue, rsp);
 }
-- 
2.43.0


