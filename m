Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36682C021B2
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Feb 2025 07:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5udn98WThwh6d0L6TV2MPtSxsqq26dvFDd7Yz2/H4nc=; b=Flj1NBa/tFHeWZo2WltvU8joXA
	1iIZMs/k8h0+SMEPCkOpwFlgqzQJIfv7nOd9td50nqSx7VsVzMP/8vlSOer3FvCJOaJd3HVCFK4pZ
	NVKllcyfrCmc9VN32W8dQMmCjhuwtML8VXzNQW97+80qYC4OqcWDQNbnSgxP87P0N9wamn5KZxvgV
	zVYlEf3OlB5/18zZgs2bNfjhnhPsUzBD5sWBOuqGlN1d4w5qzY7BARox/RRB1JUDFkMkFARvk+ClP
	fnECp0dbM/oDq60joQDNe6/B56oD7cvB2VAELMiZzBeOY07ou3Zr3Cj1sjGgRPzQ2AfaCrKpkM6D0
	lzLC5/XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tm6QJ-0000000Aast-0Bah;
	Sun, 23 Feb 2025 07:29:11 +0000
Received: from mail-db8eur05on20729.outbound.protection.outlook.com ([2a01:111:f403:2614::729] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tm6QC-0000000Aas5-0HfP
	for linux-nvme@lists.infradead.org;
	Sun, 23 Feb 2025 07:29:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYj97KA/FHBPhOBAQaPQDxlHvATH1A6Ly8JkIJgxOylB5LwoNj0rq4R3mn/Eh32Wn9Qt7JaFJw8UqO7KDn0WHIoJ8rJH6m6fFHTkTFO0i7dnW8TwEe5OR9gpvQ1RPFLZLvdFLW/O3I50kEDuE+p+KbxjNIyaCTLvJzALTlOgBaKhuKCl8RIej9jt25OYC2E7ZyVx4ZN2Hysv/yf3D4RUE0s4RjA8ObBHep3xvHYkheZui9k/Z52I5qgBOJS2HKGECWA9a7id7QWUXjvJQ0CcJMWpzGO4L5fYY1na+HNgVi/9wonE6BsXAMX4E1Be5DR7iA8ri+t6Bhxl2CRoMki8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5udn98WThwh6d0L6TV2MPtSxsqq26dvFDd7Yz2/H4nc=;
 b=AKCj7fVlSB/0wUhDl9Xv4RMSJugHHf2M75mTE/0hfjnlv+MRIHmt8PDFNHXCASH1+sJBhrmoXzPIS/AbkJ/g5QmhLY0DKir3XKx2CvsiqLyI6qG75O66LJ4l7RnZQsjYvgNgc5mVGfnVVJhz0wp7Op+92anDyFroEW1ggn8a7ZWZldjQjngWknZuB55YIf18eqyQJnszJjSvHIqTcEW3SsZyRTjUt4QtqU7ef30I6elieTdx/AeiK1E1FFy3IHDSGM1Dxp5frld+urEzN9LSVrfKpD1oUMzGKAV/DCyv1iOltJay+dFvThuap4DC17lEFUAGMcVdPezVhOLTP1TfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5udn98WThwh6d0L6TV2MPtSxsqq26dvFDd7Yz2/H4nc=;
 b=MHN76gsSwbTvD+wcjo2vOec2x49xHaWbCeqrKmqIwCvsVODIhZsEQoQJijAioLsb8pKcMmxOre0vIkjWDfrjrGgMkxN9IwnKT3H97u6wOG/sOJZwTQ3AKwnZnTLCZf/Eo7QlpJ0zneaqD0XLeQPpDWOXxPSY/wo5UsouOn8a7YlE8YKKM6pr9yLuQeBybpYetFnjOVbluK0wYLe4ASbn68Vbz2lV3+C1C9crq2OqY2stsNyS/PhG5TtJ/mCa1NoTTWUZXK8eWmfpNWCfuihXREhHtMPYzPMdYZmjWVRxJeRJ+qD0hvjuPmRAO4Ysj4Qj48VJbuqZhEGskA2eAmXawA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 07:28:54 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Sun, 23 Feb 2025
 07:28:54 +0000
From: Meir Elisha <meir.elisha@volumez.com>
To: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Meir Elisha <meir.elisha@volumez.com>
Subject: [PATCH v2] nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch
Date: Sun, 23 Feb 2025 09:28:45 +0200
Message-Id: <20250223072845.3470297-1-meir.elisha@volumez.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AM9PR04MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 022af2c6-bbf1-42ea-5986-08dd53dbba0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4r9ao1B2zoHSGGqdMHJ7rLpqOgjWHIPWu47STX0+p9KR5xfzXH9lvqDyjuj?=
 =?us-ascii?Q?l+lt4lgj2iRnZ7utCYbt+KkxXScPuHyBabbIwoseleKoakEs6JGFj4KPXR9c?=
 =?us-ascii?Q?YNmEDqPzrMUutitvZNieAKEGhl+CZjP1GlME/vUIEMWM/yLj6W6EPXgsZRNH?=
 =?us-ascii?Q?3GTpm7rW1IUQqg1fl3oXWlL96gNYYuu4ny84wqfaLiGD4jeqgrAFjqbRAFPL?=
 =?us-ascii?Q?27vNpWm+18NPPAieN2tgl8ilsPsjsTRWzU0tV1miiSKMonglYktJGsri6ME4?=
 =?us-ascii?Q?7Qi4QcD2cI6DWAcQ6rWimuG1H2Jxveyr5KQPxLMiUuwRgNp0VUG5I4AgmSl+?=
 =?us-ascii?Q?f/2SKCwtho4Qti7iWV8nqHRqttaiRVocbanE41IveKHZbpVYREQgMrV6lpAU?=
 =?us-ascii?Q?infvLa9dQ/kKN7Qu2BBuHYTn6YXp100F48YqqQc+Qi3/BIMuP160IBwaznj5?=
 =?us-ascii?Q?f8j6FBYutYUfZiQT9fSdtkVuUlAGazQEL5M31+SWcOgNbRN2ZnJYzQQa4AiX?=
 =?us-ascii?Q?la+Rxk+tsdWUBBSBNna38Sh55dGuxcG528BMObAuE8rpo9dM08iTBeBXealI?=
 =?us-ascii?Q?9cz+Z9IARwJy9nIdwnbthIXfti1zdYgSEoZfoqBWgV4KrHK0vpCvKwTo78Zg?=
 =?us-ascii?Q?nsLFtb3SXvP+NFHTegCnjWtl/XBDEu47f4TLew5EvoQzYu1my/LKMN9hD0Sb?=
 =?us-ascii?Q?L4c3psNLsGauD6QJiPBw9e1YEygg4QpNo+TBh87ocdLaCBkjmHnGS6VUae97?=
 =?us-ascii?Q?CKSApz3+9UH6InSYw4N43ZrStLV9+TOAnUxMGf5GGHt22WjtAmF7CUkgZ6uO?=
 =?us-ascii?Q?gtWU92BsIwar4KTq0R5wLV/mD2siWHJo/fgGL4E+/glaqSh6ZRkfWPHprq2n?=
 =?us-ascii?Q?IDV0B4IgYboCwRuVCf9/Yp4nezKFcjsi6rWQxaRQu80nq+tfhL8C/BzXRybP?=
 =?us-ascii?Q?2jP5bdunWvbUlAkWE1M8FJDA2hNMYxMlWeemP8z9BPFHhIB62F8GcUUa58mf?=
 =?us-ascii?Q?Q6xUD/3f4wPSiZIvrI5L71oy6jl6nYuRykMzbPqyLP2byPliemwuFOLocJ8w?=
 =?us-ascii?Q?wWe184aHDgnK7lLzGfQSNqRZL2aCxTO4vfqb3le4UxvAwgTt152tDpZ1QFo2?=
 =?us-ascii?Q?2HXffL1xbfPsNSGiEiNfv4lrVvjL9Rj3PtxiDXufu4gWPSacmk2shkteqOFs?=
 =?us-ascii?Q?gBf6skgiKBqm0xrMPyCJJ4pJ48S9pBu/XqjrL+j5iDmOaQW4QnEuxJJPwt/K?=
 =?us-ascii?Q?romC0ntqqVsvx7Che1LHBI53r8CAbFbG2/83yexE7Zh64z/aZoAg59qCBB4X?=
 =?us-ascii?Q?blFwlKGfJxD1yEoLeJyCG0HiW9yP/DFRndDeGME8Z2qMERmkCsTsRpDUNhGB?=
 =?us-ascii?Q?ngO84K1sJiMRaqkRWJrduEQnj0P5NA8aovjl9UCVDNg8On/SWIt1JlPs7rNv?=
 =?us-ascii?Q?T+4/j38N5+QSWZog2lEVXU0sBgktt5D+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jaQyahdk0TrqO6ov08TlilKqa720N76RFG/Aba1zv+BfxieEQ0rHVi3I31Af?=
 =?us-ascii?Q?pr1qhZMhDs8LIPEjlI0BvBKGeHFpLbGQdJo1sG8FPvpj6eDrz81Xd2bANoql?=
 =?us-ascii?Q?YrNu9AsFpoK182JPU2KokU9IpRhpGP7xQFNxnpoKEx+QoLot7g4MVj74j8S/?=
 =?us-ascii?Q?9wle8jbYoTdQRK3uHa95ziYRkZjkqfCQN1ikyxm5239z1VLbvoydWTM5HVN4?=
 =?us-ascii?Q?x0QCeQwwwwUO/8lvBu6+t7Eo8uyUGmj9yBnf5zBk7+MaHOU4jsju8ufTRUId?=
 =?us-ascii?Q?qfu1NrLr4QssqBbBpHbtydO2ucYKwR2/fvKezlNrlRcsfEHtUgbN3E2cWuJ9?=
 =?us-ascii?Q?9CggzC5F0obChYSeFk2tgYHXL/wu16Co3zCxelRGesEuenMTS9lR1xzBfRtG?=
 =?us-ascii?Q?YpGgPTYZd9zXIl9u27hNWaWfwObP/HvqONbgnzJf26NGyZXmuTIh8JQ7zPhB?=
 =?us-ascii?Q?ThleS+V+iLbWQTFZ70cIyT9APvp66TomA6r04fZtZlIeZb4Lg9p1D1xGPi/S?=
 =?us-ascii?Q?aBqbbbCdqnxJ2bzOhOwiEMi12rRzD9nRPmTLXm2haY17yaHkEHPlfpS5Tv4S?=
 =?us-ascii?Q?5S/PEeIL+yodwbfcp4FDF5SXDZg/uuoXWkObTXp/vXwoU6LdMZ/JgYD6xQAH?=
 =?us-ascii?Q?4RIAxinFFH+34xUvqoG046zgWl5nJvFRDkxEyCM9XQr/EzfKdzN+9KsE0cy8?=
 =?us-ascii?Q?LJvIbpVGhARngfB4v7kjXkovnQkViKHdhA804iUyrlxoGHMZs+toinSyyAZY?=
 =?us-ascii?Q?Cw5AJNvdgQSe+udzrcOIR4VyNFxf7Qmz4l98lPrvcHMFTgdZUJQwkMDDr/EW?=
 =?us-ascii?Q?4TMNceahtzp7GB2GeajdNr4J7lTpfjCNAGMlBPMfZWPuxq6hTA9Sw406x7zA?=
 =?us-ascii?Q?z5/bkq3IM/1Phyhjlio89Z81TdklpnwCry1l6MiIoPA+e9eVL4tUvWMuiL4R?=
 =?us-ascii?Q?uOj4/ufIAdIlXS+AeLg2cfECevjmNC/sIdy8wO+CaY+szjR4iQ2gnmmrUTU/?=
 =?us-ascii?Q?aOeQ+n+8bqNm3jajd7W0q6m+x/EIRyWxfTvoqtbT8Q0d0YrHCC3oGGGxeZdV?=
 =?us-ascii?Q?Kh2n43EC3XF8+sRa0oJry8ZW/dcg0V+If2jyatm8t60XDQdScF18wpwr0zm8?=
 =?us-ascii?Q?ufKS7rGod6EjQOks7upSFv1IR7YgPkLUGi80UMzruW/hH4YTRgVMidK4kBuL?=
 =?us-ascii?Q?iLKbkfOAwyxywx7elU+tihoSFQP0G3w37B0JucN/k9zo96oq3AWAcjt5907t?=
 =?us-ascii?Q?0TtjN0uAgTueATMWkWQRHdFvoCXtaTHdnljQBW2hR2Zuci2Kv/egpYYioRxu?=
 =?us-ascii?Q?mgg1MqoC/d3mgzekKOPh+dL4qGkYF2UgLW2J51v1KrUh3N9jn/9spuaKyJQN?=
 =?us-ascii?Q?1eaZ4g62o/uLS6BvblzgsZ6X7fnxqZASscuGKsCwJvKDzGbIg+nft0UWgLAQ?=
 =?us-ascii?Q?Humzku0wk6NclGJj7JRgXb0DsigqtmmzpRoyru37MAZmsQHNHIaRWuVtEjXZ?=
 =?us-ascii?Q?wwGFQoAUSsU57bPmZrKAa+u44YTQtKoeLWrwfuOIiSNqcDE7arpUN45VgTvw?=
 =?us-ascii?Q?96pTvPNmDjuN0J8TNxAAGGQpNwgd6hr2fqg+cl9t96qh2fBIG84SkG/ZiGas?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022af2c6-bbf1-42ea-5986-08dd53dbba0c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 07:28:54.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aflrpHehHyye5I52vflJv1o8YpEqbYG2BtdHSoe5YLCToOFFwqznZHm8I7c1WbBu4OU6qjWA9KZhgzWaZqGANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250222_232904_134492_F3F51A1C 
X-CRM114-Status: GOOD (  16.97  )
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

Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")

Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
---
Changes from v2:
	- Fix barrier semantics
	- Use rcv_state instead of state variable

 drivers/nvme/target/tcp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..714d920d14e1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -571,10 +571,13 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
+	enum nvmet_tcp_recv_state queue_state = smp_load_acquire(&queue->rcv_state);
+	struct nvmet_tcp_cmd *queue_cmd = READ_ONCE(queue->cmd);
 	struct nvme_sgl_desc *sgl;
 	u32 len;
 
-	if (unlikely(cmd == queue->cmd)) {
+	if (unlikely(cmd == queue_cmd)) {
 		sgl = &cmd->req.cmd->common.dptr.sgl;
 		len = le32_to_cpu(sgl->length);
 
@@ -583,7 +586,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		 * Avoid using helpers, this might happen before
 		 * nvmet_req_init is completed.
 		 */
-		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		if (queue_state == NVMET_TCP_RECV_PDU &&
 		    len && len <= cmd->req.port->inline_data_size &&
 		    nvme_is_write(cmd->req.cmd))
 			return;
@@ -847,8 +850,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
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

