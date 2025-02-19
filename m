Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198F8C021AA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2025 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RMWgeaxY3cEHFb5bmELZpMFxZmslBB58qWPHcu8rwZg=; b=x2Pnvkj3WEyIZxf6iyyGvhGhNY
	YHm+DXSavEGBK7YC776m4GSTXyfwuhWHWxMfucSlmTpdhF1SqGoppL1XwMV+lbGxw3cMnJBTbOAjC
	RjsFFQVxcuVB22IHCQ7NL93iS/OfEntI5DwTvi1lJShkD0yQjI7III3MLtBViVKY0RfMgAM1074fU
	S+KIYUW9xpPFgZFXG4884cPhvm46QqwMqbWxbbPhEk+p+tevn6dyA44iF9hewsRP3q2QaEaL0JBYR
	v6L5g3zk6gum3UXwNy5NFvbpj7b6yfohjFLh12r4vxHd4mvVbzxgN/9f5XoZHmmgNfZabWiXKVeVB
	nuh+ihtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tknbN-0000000E1a4-3DV3;
	Wed, 19 Feb 2025 17:11:13 +0000
Received: from mail-am0eur02on2071f.outbound.protection.outlook.com ([2a01:111:f403:2606::71f] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkmSz-0000000Dg68-2Czu
	for linux-nvme@lists.infradead.org;
	Wed, 19 Feb 2025 15:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STbmvSG4C9ToYARRsjPnjKq8qcwRPyNV45F1rkfVhkg5Q1snZDEnz0V6xEkGorkCulbM9iL+qoxo39vT/8xYzN/jHBuDeg3iG1V7WdRE5VoC2346ySQtYPOS9M6ZhJfXJ9PpttA2z8WraF9y4mGTOehKGsvO4zFYhvmJg3D1rON6l/ZmFWCZ6i1R9cVMZRdHdWr5bewBMC9o9UpZbntUxHY5JzcPFsmlD+bCkxfnVKFlzXq/c1ouGrlUGuDviEZfktWG+VD8/VFTm31zeLpLkxhNlrH2Z7Bxxn+HMNx83wwWKr9x+LlKlWz1l6k/SziWn7tFVHn91fEQNU3SEKai8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMWgeaxY3cEHFb5bmELZpMFxZmslBB58qWPHcu8rwZg=;
 b=F+XhuC/Z2I0UdWLlnKznh/zZZ3uoVn8GiuGZLyakUtoGwjor6GFJ8TkBb9T3dmt+mzusBG5rQz+klaaRCh5sn8pcxRD3QuP2mt7G1wPXNAUXCIfG4X/tB85hHNzXBAacxB2ItcMQaUnm8yET/Qohb9X28SNKOKVkReVPHZnRFZsALB1o7WFL0m24wBfru2GvMEGz7tzlrMYRmEirCXOOjEuOpUALXtMEkuNp14IB5c/gwef1FtN6ENl6eCThQrtvahLp0XyXYkxLX4b2D0ONK5YXt8i/ZvGm/TZyspT7YcnvoUE5Dv/dVpCv0Zg1oc+iZFqM0nHkFfkx7oIwVFh9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMWgeaxY3cEHFb5bmELZpMFxZmslBB58qWPHcu8rwZg=;
 b=QDulwZEu1eUobuYYSd1g2N5flbaTTwSlB24VDleP7yKG9Sek8emApnyDRsgkm7PXTOmolEzg6nTkHlukfvfIXVkvsp4/xwcrZIYhP47oQYJTtje+OZ6SP25SF2CPqgEKBo/VJ2Ty8O4+/o8iiHdt1uYsM7Le3OFPmrZdZDQlKTO5MMKzmNPDoEpfy1+T8oTGOZqmah8sbK+dzVjYLClydeEAWz0OVpeo7LwNmIdXg0MUzeaZ/1Wiqk6k+YJklH7pnJ6wXstMnGRFHOvYKAIphZPvQ0xA8WhXsoUXA6H1G3sI58Wmbe7FIT82QwBaczHYEBvIPF+jvoo23+opZeF3LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS8PR04MB7589.eurprd04.prod.outlook.com (2603:10a6:20b:291::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 15:58:20 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:58:20 +0000
From: Meir Elisha <meir.elisha@volumez.com>
To: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Meir Elisha <meir.elisha@volumez.com>
Subject: [PATCH v3] nvmet-tcp: Enforce update ordering between queue->cmd and rcv_state
Date: Wed, 19 Feb 2025 17:58:09 +0200
Message-Id: <20250219155809.3077375-1-meir.elisha@volumez.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS8PR04MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: d09fbd67-e280-4020-c8d3-08dd50fe3b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6f5nb6lgzaq1fefMkuHxg5SNolGLoew0Of6PGKHrgR5pnAEM1z0HF7FTB3M0?=
 =?us-ascii?Q?X4Ewcbl7ClR0fJJLflYbOHRW/9XE7Hy2++uO2FQs3OEIKRC23yFPE/Eo8gTv?=
 =?us-ascii?Q?Zu6KihHn3EUu1yofkBF4q/n2N1fRqLAgX0nWrhlFAvueegfQDyf8p6fCuDqD?=
 =?us-ascii?Q?+3Mx+rf2r0WsX6oNCEVHeqks0YJ6i5KT0ID+o7Yxs8NwNRZUWTlISXsZ7f1P?=
 =?us-ascii?Q?KKXNQaSWWN6zuaU0jATPpoXSlKxUSpXmAKALbjfHlQXo9+3PnFPilV5V8V8L?=
 =?us-ascii?Q?U5iz+yROrYNxvI9wFNSlgx/skOcOoBwRG52o/wsZaPhlNn6B6YMWZyDyKOL8?=
 =?us-ascii?Q?vTr6Wz3fd/IQGUlmBSRZXu3qE+27hca9bT3qLC2CC7jqF4qG2pOo7ZMLqhBJ?=
 =?us-ascii?Q?NSXKzfJnS6zlMPTA52/dxB182scOIT+lZnv3flAzoN347r39M+aH2PXmSRul?=
 =?us-ascii?Q?TulTs1Hds5uUzX+d0WWJg07IftGMPo8IA/yFrJR1W3iOgUig6wQxaA6i5cYE?=
 =?us-ascii?Q?L4fAD0UF4j1kuLmd5IqTXsz3/9KfF+hESs0hWp7h8xInCyqvTHhlJlnW8++a?=
 =?us-ascii?Q?Lwa3wU/yVxn1bMRuuLwT9gkvDXdzTF41T8kki697vV1Sml98F53sgJ7GgWKo?=
 =?us-ascii?Q?hBOYVjs2j365flaRmoaX9DbXtMEhZrwln9jh23b+H40Y+gFiV00o0Sw40TGm?=
 =?us-ascii?Q?iX61NgR/BUkljEcaUsi4NHu3FIqoLylxNzTKYoRPPL+4iDDPBwQ22uSI2osj?=
 =?us-ascii?Q?jDunfoTmuNoA0IS0cofi5a2VtVW0s7gu3UcWhegEppmnZ1esW2/SQd0D0KfB?=
 =?us-ascii?Q?RCPwazoRWolXgvZ0YwwQxwfrRmc6ytJZBdWm84TySXjjTZu5jhNPSe7qPy0W?=
 =?us-ascii?Q?hER9xhJIt5Zfzeb+MibwmRBdlJ2VC1b39LMTAZ6y4iMKtj6hvel0S3hiXyio?=
 =?us-ascii?Q?uavlUTFdkeIRoY4ze6GJ1024+1u6jRFIAOQW01VcvuhM0zdnPjqgk0bYwKHM?=
 =?us-ascii?Q?7Uj7xRNcfyCRmBAnesP0nCu+rbQAsO3GzCjNH7UvfltrtB8XaZa18SFwZl8T?=
 =?us-ascii?Q?+BYtoJSAN8LBtjmUgxQuJOzzGNRJXUfTuNewU8phCaF0SnezZHSI6zV5O9Ad?=
 =?us-ascii?Q?R6NJuG1vXt2dtFuZLhp4ChL85lv5yrP5RQkpJOpVksoGUcLDEaeQVu6Swk9i?=
 =?us-ascii?Q?Upyn0651KbKMLxdFPZEzdwJdhbFF+OPVg88emYoLoF9tNjcz08kHurgPaM+8?=
 =?us-ascii?Q?YehxIVoVJVstxZ7GCygoDY3VAv3H0n3s0QZrAF6eD7NQ+q7oTx+o70T0AN1i?=
 =?us-ascii?Q?+H5V1ied/DHAY2+EE0YYlcX16W1UBUEBobZomeZBti44ttUu7opMsw5rRhL0?=
 =?us-ascii?Q?9RqWa02bHAfRztRaDu/6wM/2VXPRMTF7j7WZzR1RLXQyHyKnXT/V0iR2M3cE?=
 =?us-ascii?Q?Y77oewVZFsW91muU+cIjBzaXnkEAtaiK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PZOLGiIeLYvqn3rwteM2C+LXTsg7FRiRe8a5ZcHJzxGUa1o+peZGDQCYIFZU?=
 =?us-ascii?Q?2o/wwZ3F4g4xWQYnMy4EAIe3+iSf90Dr3ZkF9rH0c0hzizWcKBWyIMiuoSLt?=
 =?us-ascii?Q?2y86SMbnfAZbYiOJFK4YlVSSZQWbWyve9ULplyxxc8h41bQIFc7GHKGA86un?=
 =?us-ascii?Q?PifnELfOB47PpBZdEscX5V2ibTT/0ogUNyYHShyDv3R25D7lfj7X6Ar8Yyua?=
 =?us-ascii?Q?7v56Z3mxhEZg6sgvQN4tZxItu6CDcJU+XELy1gL7XUMwHLmbxUaO0jjZPafd?=
 =?us-ascii?Q?BoYKufbfhZvTi2UHUarXU4tVJ0pzmG20kmwAZJHUEaNMD1m9+j3RAV2PDRRq?=
 =?us-ascii?Q?gF1AZLcwg2ehX3hmkCX6uIsObP/LsRKVV5oXaW4Uin6Yn4A/j8YsNEWJ7qGr?=
 =?us-ascii?Q?4yxJpYa/Hi4mT1AsevGNAxZJe3L+AVQTfY382HuTjT/QrorKL/DxjjKW/wgh?=
 =?us-ascii?Q?mksUqp4F57O9RnodjGMOqDiUATADuEN3IqIVFjSlNv9PGf30l0PcllPpJwIi?=
 =?us-ascii?Q?x+4CAoFZ6aJmqoQXSp9fwZgcsuf8K+6eYQTx+HBukLIuFpWI1YDYhkxSdhen?=
 =?us-ascii?Q?EKZioI+cxLcieu3Y927fixTcPAPJ8QDLm0iR6vl6sJcx4m8g+OCeUik55kjk?=
 =?us-ascii?Q?rGchYWZJCyBveAMKpKf7/SR2pbpHPl0ORAeTTe9NXZO/D+ufWJDtD/yFW3Rn?=
 =?us-ascii?Q?f4XEwMyf9/N2X3P3cCQqozPyoIFJXiFj89GFkp+vebaB0VySs2cT7k1nbeLT?=
 =?us-ascii?Q?eZ28Fg7C82ty8VpPD+5i+KVmPRrIWEvv6cPJzlWra0V4pi7BFyOisr0nwUI9?=
 =?us-ascii?Q?a+6+P9zR5GbFOxj4MC57NAqpFQ9DuL9EmNzA3Bk3nX72SF71/aDV5fQCt/4a?=
 =?us-ascii?Q?4ZO5qV3XrkSpd02XKWNuXf2WIzuLgX1ay1nzVjTDkf/pvPraSQEKtpuX6Z6q?=
 =?us-ascii?Q?27wd4scldMk7e4z5uTJFmhLh/qzyVT+MXQ9bnD/pE3iMPvQwy1C6bwOqaMpc?=
 =?us-ascii?Q?DDTYFa+QN0OHWhq58DU3hN57B1IGly48aeteutJM+qvcHZ1grN/0k3T1T6/Y?=
 =?us-ascii?Q?rTyDuRKDqGvK+GwQtq/7JdiFfQmpZH0PnIE95RBaExnJ+xJRuFJlorTX8STG?=
 =?us-ascii?Q?/NxYBzCkPpPbQtckuug6hYslVZEmH59eI01x45fdH34i2RyJlslCpAGr9aaw?=
 =?us-ascii?Q?i/53cI0LNv+HjHKbDs8mW43C4dt5dKBBNmKv7USffMsehdxkEVE9W4bPg8su?=
 =?us-ascii?Q?19pgeZJBVGfd/zVhiinfhGQGq7nxya3auOxym1mSKzQxUAD6+oU8X1NZlJrD?=
 =?us-ascii?Q?QQeMsLTL6Bn8Gk4OkDMMhknbiF5LKD3W05NqDULTXOF5Gda8oVNNEm5yMZ60?=
 =?us-ascii?Q?d8f/FH3CjtY8hUcgo+djqy4bwW2w19X2ZRP3WjNlajdiiyDVSdKTAVwMVeld?=
 =?us-ascii?Q?243jOHjo60NCZ15m9fi4wVxEWpOdNNhvOqHkt9hmgTWVggf33ijRRk5PdCFe?=
 =?us-ascii?Q?8UMMPHvZejgPBevrICkn1xbwJTEYfzgQgbPwmNK/L3LaCbk9YN2Zsa6F3kMR?=
 =?us-ascii?Q?OXARHpyOS7dTKsBkB9PBBuyHJ6jwF8+6r6voZpSxYH/F1LbVptbnAPCL7m83?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09fbd67-e280-4020-c8d3-08dd50fe3b2f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:58:20.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HorjHLhA4vr6IWVRE36O6DL6IC3soSQQ7HOHpQ7/zIohwthbZnYNLOTM/P+CJ/kRRC0Oh+WePxMqQ2Ib7xTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7589
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_075829_581542_DBF55E9E 
X-CRM114-Status: GOOD (  19.09  )
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

The order in which queue->cmd and rcv_state are updated is crucial.
If these assignments are reordered by the compiler, the worker might not
get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
the correct reordering, set rcv_state using smp_store_release().

Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
---
Changes from v2:
	- Read queue_state and queue_cmd locally and use load barrier
	- Remove unnecessary barrier in nvmet_tcp_handle_h2c_data_pdu

Changes from v1:
	- Change comments to c-style

 drivers/nvme/target/tcp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..20fc1a27b720 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -572,9 +572,15 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 	struct nvme_sgl_desc *sgl;
+	enum nvmet_tcp_queue_state queue_state = READ_ONCE(queue->state);
+	/*
+	 * Use an acquire load to ensure that any updates to queue->state are visible
+	 * before loading queue->cmd.
+	 */
+	struct nvmet_tcp_cmd *queue_cmd = smp_load_acquire(&queue->cmd);
 	u32 len;
 
-	if (unlikely(cmd == queue->cmd)) {
+	if (unlikely(cmd == queue_cmd)) {
 		sgl = &cmd->req.cmd->common.dptr.sgl;
 		len = le32_to_cpu(sgl->length);
 
@@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		 * Avoid using helpers, this might happen before
 		 * nvmet_req_init is completed.
 		 */
-		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		if (queue_state == NVMET_TCP_RECV_PDU &&
 		    len && len <= cmd->req.port->inline_data_size &&
 		    nvme_is_write(cmd->req.cmd))
 			return;
@@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
 {
 	queue->offset = 0;
 	queue->left = sizeof(struct nvme_tcp_hdr);
-	queue->cmd = NULL;
-	queue->rcv_state = NVMET_TCP_RECV_PDU;
+	WRITE_ONCE(queue->cmd, NULL);
+	/* Ensure rcv_state is visible only after queue->cmd is set */
+	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
 }
 
 static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
-- 
2.34.1

This ordering is critical on weakly ordered architectures (such as ARM)
so that any observer which sees the new rcv_state is guaranteed to also
see the updated cmd. Without this guarantee (i.e if the two stores were
reordered), a parallel context might see the new state while queue->cmd
still holds a stale value. This could cause the inline-data check to
return early and ultimately hang the IO.
Additionally, I reviewed the assembly code for ARM and confirmed that
the instructions were reordered(unlike x86), reinforcing the need for
this change.

This scenario was encountered during fio testing, which involved
running 2 min of 4K random writes using an ARM-based machine as the
target. We observed hanging I/O typically after 10-20 iterations.

fio config used:
[global]
ioengine=libaio
max_latency=45s
end_fsync=1
create_serialize=0
size=3200m
directory=/mnt/volumez/vol0
ramp_time=30
lat_percentiles=1
direct=1
filename_format=fiodata.$jobnum
verify_dump=1
numjobs=16
fallocate=native
stonewall=1
group_reporting=1
file_service_type=random
iodepth=16
runtime=5m
time_based=1
[random_0_100_4k]
bs=4k
rw=randwrite

