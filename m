Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04AFC021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dQGpVcZiBbNKocwnNlsQwtY6SB+VlsIqOo3qZynx5dw=; b=eSHDnlP6Z+Xfbful1ErpL4BXvr
	tgQPz9O4BE4ZzzvvZVrekErPOj6Rtv1jfMzO1A3DpHGf1M/OqOGY5ldGW4ayQFKcloUdqAVxcBG0b
	dpHgug+h5AKEBdi1Qzjy4+BS+OXvL0Fpa/e5U+NrKHfal8ZZ7DK6SutItI/E4UgEa3Hy2GLzIX1J2
	6jB2rjj7F4mZh1iEZadwMMTz+xtR2BJhXDXZlnMIWeTmWxW/J1zFU2KfQ5uFmUD7dLT6defeFB3GL
	Q+D4CpUkxR4EVtilQc0g22dddfwOFjSEZRvfsnkIrXPa2ZF9rlbw6whZg8DxVq2LBhJY+e6+t/KMs
	HhHPwqZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl58M-00000000etQ-2UcT;
	Thu, 20 Feb 2025 11:54:26 +0000
Received: from mail-northeuropeazlp170110001.outbound.protection.outlook.com ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl58K-00000000esG-1DL0
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 11:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4ZsJF4f42CtEVg6l8EHML8fXnlHAG4LG5pop+0LHPdMosWtk6XfWTzkxoXQpPS59vLS753Anp58iqLM/tEXFVlZz0HRGjy144OByuxeR9k/ODCORDuCry/OT/+kszrMy+G6hYnLthTsacg4reX2lcYgdJES4ElbXUypM1H7k1H6JpWEjRSFmJOqVSJNR7V4lOJ2dM08yJkBcDPvGNlZVnI3DhwmYlrWoV44HYLe05gG0WWN/6z80RO3LLzYEt0exi5SVoPi8t7VQFcMwUl65nlYS2MSwiL2/gJYeJQ89TCgvfRGWT3/UlRK17ZBqdqP6DIGFcQeOYK2Oc+L6kl2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQGpVcZiBbNKocwnNlsQwtY6SB+VlsIqOo3qZynx5dw=;
 b=voMkkTBgbeCPuazfgLeDHJN47oh8yVkQbneGtYkIu3huhdaWUEFFWUOHyLregD2Wp13SVHULCOQEvDHQoI8rvX75l6ywCaiPUhAFuZa+cLNIRQKaSMRi/r3yDJMD4DOFuFvX9/qZFFyUGnuTvq3nGpsQdWXwVk/gjBYCVp2FhY8f2+Aj5njqrAIISDVfL6aGPbhpSwRe320QiyuzNarGA2ctKWOzGeZ7nqHznj4GtdWHUPl8qB+9kohE4NsNvZIH9mvfMMiZ2iknrtwHRgXaWmoIK+Ar7RGbAFlImSQdEo2vW/ZPJQsGrABhqbeKzpORuWy3blJRPFKaMXI7hmuSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQGpVcZiBbNKocwnNlsQwtY6SB+VlsIqOo3qZynx5dw=;
 b=ENutehOn9t1hq06hEeEpkE/DgW1qPPZP/BJJoOCaqOegE9c9gsouweQeJI9+pRaOz3ipoobZG8XzxPkMwc1jVYCL6WSrYOQ/7pevZ4Usx3MnHxdhj/KEFfMwk0/ubxi7MDljdd4b5gSxKOrJZRjcejhTQTB0yDRBTygYweNZN0Y/bFv9c/gR0cVtodyLaZbqwBjrlPCNXhSTPu/xBeqlEAzgzr0fmKa38HZ+w1AVPdjlOzeoMkPfZbqG9WRYhypEyUIJ8ESc5RpPSf2slDh64gcfr9MKKI6DeymKwNAAlHV9t6b/HS5QzUDzZcNWWA8UGxMVY4zcCGJvDoZWze1YQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM9PR04MB8081.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 11:54:17 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 11:54:17 +0000
From: Meir Elisha <meir.elisha@volumez.com>
To: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Meir Elisha <meir.elisha@volumez.com>
Subject: [PATCH] nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch
Date: Thu, 20 Feb 2025 13:54:09 +0200
Message-Id: <20250220115409.3271289-1-meir.elisha@volumez.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AM9PR04MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca334c5-8053-4524-f65e-08dd51a54dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zPfYLKzldRD9nDCW2Ao8ZYi7nnWPTUq9wFlebWGuhDnG3lBCIe54VIFNNCpG?=
 =?us-ascii?Q?BXNPvdbaV2Ht0zCXrFqnp+15ZfoeIQsVnZ13y14LGlCZB7jwPHPMm7cKOM+t?=
 =?us-ascii?Q?lnYBlFfsVj+M4NtUI/iTvSzKXqg/hbi4MuTjzh9aYOidrNbC94hmNo0/qwvr?=
 =?us-ascii?Q?qk2LQcXZHM1bpP6rF4L/1i61QQUXr0aY07q0cnNQ+bzE+edGT90QezR36IvT?=
 =?us-ascii?Q?+FHXr6ILLJCrntx3i951bY3r8opmWiM93MBnkyt8sr+hlTo6LWkcul857jn1?=
 =?us-ascii?Q?f1ctKjCmC0xw+TiF3R8dELdyZ/Zj3QJSiesf06nkNSwuUWbk5+JnljViIqxv?=
 =?us-ascii?Q?xzQ09PQnDnB91xEG+t0OsX9BVYochczWykjTKFolb5QvMpjQbOKdgUulnB0c?=
 =?us-ascii?Q?GSxuxylGQJhKpcOSCDwy0s0eiMSVpcz3Xn/YMygJ4aLArhbZ32c8DuIPlYsx?=
 =?us-ascii?Q?evmI8hBrZXBAcGU/sHR0IStY9r7gCjJRRC6le+DpIwX+mySwx1tAfHgnNC9x?=
 =?us-ascii?Q?5SGqqij8ahuBOYWSgbuFOF+K0oh9j10VsF7h5q7Kms2V5fd8iyfoPfh/t7M3?=
 =?us-ascii?Q?a9JTf1AFNFTOJfRqCv1PdD3FhMDg0AicmNLRbswWw/Y+89WEwnnKLsIlMWiL?=
 =?us-ascii?Q?+BDcRSN3T+0m+OEUF+M6L6AeE/x6xR5ypYWKSIH2GMhOTwJIUk71hUpASNlK?=
 =?us-ascii?Q?Jf01bYdTlIYQ4G91b6Ekwp9sI1Qe/g3DklWSPrVzKNDFnwHVd7t1orolP0gW?=
 =?us-ascii?Q?g9/IzqnP+cNRUulUHV19ObfRMElz/E3UrEkhq+/Di8huLRfq69AJpIgOq62D?=
 =?us-ascii?Q?V9PpRDm24mrMVkk3zKDjFMpLoz9l1njVEze4gzSjiFP2Yd0ekMEPoOm9YmhT?=
 =?us-ascii?Q?QvMlOxcEXy+Z6gU4lR++9NYXS/51UH17uZijIXHCXYcOCUO3bNe/9yT3L4Vi?=
 =?us-ascii?Q?8HkB99psnYKhgYaNqre5+oxWKrrlz+xI2dxRXwaSeA4ETO7vBqTEyzNQB33h?=
 =?us-ascii?Q?0kuM6Htx8+TjNP0nfO4hB72N+f87QmeINpueia4ZGuX15/jXS4pWmdOjkbHD?=
 =?us-ascii?Q?epCAUOUnqFFjzAk3Zl3pejE+cJoZwpRe8+9pnfzLz8niuEl8/9rBb7PouGQ+?=
 =?us-ascii?Q?whkMBbDpNHCA1he8NCWd3iz3NqzbTHVYrZq6XHGrj7N/Rea+Mqa8b4zsr2Bw?=
 =?us-ascii?Q?WwVS6db95SubfcADn6WNwGrdH7Fsn/ygCNTq8ys5w8l4es6Dt5oV1K4TQT7m?=
 =?us-ascii?Q?k9vzLFGKQC4qxZdGzdGc+o5c3RvHHKeIJkyxQzrczV7KHMAqMlPGi5UjWsCm?=
 =?us-ascii?Q?h1mdfgnTpQ6bSkjFbjy2dvXNKmVjbIMVIOVL9iULP7PYeyv4Fo3HvL6xMzp7?=
 =?us-ascii?Q?ko5CRwwX0ipJOHLti29K0pplXF2DzwxRknCGoEtq0rDbFCiF9Z1EaGj0E4mA?=
 =?us-ascii?Q?ZtC0AAi0B2u3q9X6pwJZglZXs06dF3Ld?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GRGuPrh7YUOpJjS6ryMzCL+7o7S484y1ARR6tV6MLgY0gzwUf1MDU+qiD66f?=
 =?us-ascii?Q?njNp+/D5AFmzuXJHYkh5LXWjBCW+TVEysek+3ndDYxuV6Xq8Jf9/WmYYUYrz?=
 =?us-ascii?Q?iagmEh8H6AD5FPmKRZrOFlXPZ18mfAeN+nNw03ddO/427TcfBACvbFo4az7x?=
 =?us-ascii?Q?MKBmPqSEuAUWzhmBaTmc2932qACV3crjsvwYCDBZrcNuZZnwDaecHZY1PDMk?=
 =?us-ascii?Q?gctU6iC0A89craN9zdmLHRhK/k3zlD5iJZpLUO9+gLCMMV+zwDvakObmVosq?=
 =?us-ascii?Q?hTqknv3LnSPRWzcvMyLXOnGBPU9Bh6AA9ghlR6D8rDKndLGrEu8T/KyQdC4E?=
 =?us-ascii?Q?l98HDGPSbmHX2ZV++HQulNzJJ8FELc/X5yvZrZTCL5FMg1DGrPK/mkYoeX7w?=
 =?us-ascii?Q?x3HJDko6puN8FEkG3hR/zM4aSAZWnQ2T+4l8nqy5O/At7yPCs6O3vNhFj9MN?=
 =?us-ascii?Q?KPvkQg+K0aIXG3FtMz/TrRkpXTkNx8KmFyearOxrhoYVANhDzA2+NlwFh7TE?=
 =?us-ascii?Q?RpFdjNjK16Yjy5jop/CJiYdkH8y2kuK1lGsYTqUCJcjUscgGz3qeZdE5xUUW?=
 =?us-ascii?Q?UV1FkBZ2tpJvw596jaD4gRw08HDitmoyfpZxIhAN2ecDhvRdk/bVsmsiEx0+?=
 =?us-ascii?Q?74pmNFnpQLDTCANYMOpBzoBdlgcKpIjZyAhACeOweA7KwWsj3ip/oSkcuMTW?=
 =?us-ascii?Q?2b/RbaQCBT7DtgLkC01jzHaqVWLan/60k4PNlJswPfoEq1UNrgdptrFHVpcA?=
 =?us-ascii?Q?hYkI1ixo8JYZs2SC/1f14pSDSWpANJ0NHgIcsdGVV6EeX3+f51p9kyleEwZq?=
 =?us-ascii?Q?2sIwHi03L4VoBDd/GpjY5AQ0fJwML3/l+QM+zPvOYZpVJS6Ffmly/9rhEBPD?=
 =?us-ascii?Q?U0c7HWpyjzY7n8ZdpuHUXjDPVDDB1l/vAGn7G1uuYMdZj5LrX2eGYHXkxQN7?=
 =?us-ascii?Q?db6MZgKVqx4pFomga11lycH/t7uYUZqWiQ3uJJ5freFsaGkefUk4/QCphZN/?=
 =?us-ascii?Q?+Qt9aozF7I3JCTF3ZDUSg61rA2q/khXyHsdcyTzvtpcfCorh5fEgL0sR2K9H?=
 =?us-ascii?Q?wvqqV8agHKzO6/HxRRiVfg0cjDHKXbAGDY2/dwwJvs1z30vFlAXzwxjXJjHi?=
 =?us-ascii?Q?MKtA7g9j+w0klU+PhLmStA+eSaonf6YTK+xxME0vMB7i7Q5t6It6VZM3iJJJ?=
 =?us-ascii?Q?K5JzF0u2WGSx7df4WpC+D/nak7bA6fqU6HS8XZgXFTpRznxDONQHKi67Ick3?=
 =?us-ascii?Q?GsiH/oqzDT4myBEzPFVEy9s0eKMT+Ae4CHuxggorCUHheHU5wJ95+A6bXv66?=
 =?us-ascii?Q?mUWmDqycMEXgSRCf5Xjq+lBW3XVzgT4+g//vf9R6DyP/VvUThM2HVrv3oQm/?=
 =?us-ascii?Q?y/22dOwnGFILgyEAj0MEdYNp4zq2bML0NYiB8rUZq+hI2XulsgQ/zhWl65Al?=
 =?us-ascii?Q?rYUlambF1XPQYrNOSrzPFCzAB16yHtVyelMkX3qohjmvqLChuXt3DCc0MEEL?=
 =?us-ascii?Q?eOKs27GnVCmmmmL5PvSyX6LgfVfALvRJQSWdNWw+jeoWauoy/Px1vR1sxgZ1?=
 =?us-ascii?Q?jD4LniM9wGiofj+81NL1pX1p9ybdRRCKs84IwrwyQePi/Wa4XjzIAAo3LTTg?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca334c5-8053-4524-f65e-08dd51a54dd4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:54:17.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdsVyl3kDgF8JNGeBCGnmej6/dct0uZjJgaPwOBXt3pr83SpsVQ4w5RJtxfYVuEM7kPdmZ1gM5E0Wk9NsGnqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_035424_341479_6BDE6201 
X-CRM114-Status: GOOD (  17.99  )
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
 drivers/nvme/target/tcp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..4021468c8857 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	enum nvmet_tcp_recv_state queue_state = READ_ONCE(queue->state);
+	/*
+	 * Use an acquire load to ensure that any updates to queue->state are visible
+	 * before loading queue->cmd.
+	 */
+	struct nvmet_tcp_cmd *queue_cmd = smp_load_acquire(&queue->cmd);
 	struct nvme_sgl_desc *sgl;
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

