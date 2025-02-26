Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D2C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pJeG/lTHA7fyFSxYo9l1BDPAJtxZARNHmpiOcq2UVoc=; b=ahweynjXWau0lbB9iKGih1UApu
	87kvuPEebNwa1z0njhBFWdFSNGQ9eUQh+6zahrKWhwiNSpIFSRbWVPfrf5krIHSdyWKSXHTpVXiVN
	Zku0sN2NFmf5rikVZEHJHI9zcQ0f6Ywei+fy4eyq/Sg9BlRddZm2reTOZ1QSObM31RSlmioqC5cYO
	q7vcknNI7K/8PptG0Hi7GcCRgD8iUXMxJj7rXovgfkQBl/IoHWDzecFGyx1eaM97As/2w/b0C0i7Y
	CssVR4OTS+zMCTKwMJZ79yT4w7HmhMo/xn8QABJKpVRrTmyHVNxOmo4S6jHmlQEcxH3AstQDorsIg
	UKvO7ucQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnBqa-00000002gtk-3XSX;
	Wed, 26 Feb 2025 07:28:48 +0000
Received: from mail-vi1eur05on20704.outbound.protection.outlook.com ([2a01:111:f403:2613::704] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnBqG-00000002grE-3HDB
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 07:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjcfaHAKuEinkMD/DrFhIYTnvblr80R3rwAh/qcH0gIx1jZCj0pG9q5JxKFfxN3BYNz+BaEwXU0AH9kFJ7c0JDHrI1a6DiNLRx0QUppETa+OcrufqGae7Vz6MnaEJM07WLN5CCVb3FpGypJ8GZZtnqDt5/rgXSbji3W3SzMa5ZXIEHIXLel8+MI0u7eIAT8Tj2G+MqeLY6WosGf78eac1luujAQBDQcuboZ0MpGgVkGalXc75Y4JHUolANtb6QTnBu46VipK3aYdBvXZo8IW2qKhh5mve9dOk2C7isrAlFQqrhzbho3hipfBc3HWUrz5Np3Qzji97xsbOPdJAMNe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJeG/lTHA7fyFSxYo9l1BDPAJtxZARNHmpiOcq2UVoc=;
 b=QngtNtFcCyokHy9p3oCQnSsQbrXGfs/J4LH6vFwcBmRxsB+KS/DiTyivF73Ag2Axal2jtobUEnM/LNmm5j4yyR4XC9VeQnrQKX1E9E3/Hdo6XchL+C9VQcR2NaqjpN6o35GyYDRaHCAuXMR613ab+HZJs89RRLhqGdKBYKcXEb81+3Ooo426rrRSUt5slDnLGtvQWjs62qr4t1VbIyKlr73Yv25RbC6x1eHpZgJz9H7wYEeKBxhiEki6t094H7KUstCjJLhgQh7sAilkGdZHeqzy9p2wkyUVXFwguQWc67yDriAyXFfJuIQioiK9a4To0EiZQvgTMOkTxOvl3aRWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJeG/lTHA7fyFSxYo9l1BDPAJtxZARNHmpiOcq2UVoc=;
 b=RocmPMwWKDXYSLs+IGwf2jve08FIwoRGjlOxl/XcmuETQOBJ7obe2qimhmE2+6+HiDNIkIG41lxlL2/K8CeyfEvtfdaOz6xrxgZD3Pg2TfNi8Leq1sJSdRRZ/G1sVBIPQdpbKKpQJfa0qbb1xLiACh6kY0k0ivtaaATWQPA9o2ph9eEEgLWmsDn2Gb1b7FRnFEyWTzFnxI9lKDPuEmknTBrj/v/SZlkr2Xc6mGUwyKtMPjYE2oEWTibEhVBxstfKZXyjTg6KCXtx+qV4WpZc2z4f1ljBhwZO7I7nxzPTcohNk5yur5QHMNL401c2+Oc3mTth7MdUuvo7cBA/x3nqPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by PA4PR04MB7662.eurprd04.prod.outlook.com (2603:10a6:102:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 07:28:21 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Wed, 26 Feb 2025
 07:28:21 +0000
From: Meir Elisha <meir.elisha@volumez.com>
To: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Meir Elisha <meir.elisha@volumez.com>
Subject: [PATCH v3] nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch
Date: Wed, 26 Feb 2025 09:28:12 +0200
Message-Id: <20250226072812.46089-1-meir.elisha@volumez.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|PA4PR04MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f60b24-a1f1-4c1c-2add-08dd5637258c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8JhyJ9ZFjzcOwwkV4KD/5pgIxFfpunIBDr2kWK90XVkDV7n4o9RkDLn1K6ra?=
 =?us-ascii?Q?Qw/stNTT0PmpUChmhvI7ox3IDU/Vm6fBcZsYKsnRRIiNeMYGvhqJL3tv5yGS?=
 =?us-ascii?Q?lu+cvpPstQjU61GNQDL8OSx2cXILF63TL9kyDFN8bt2ZWUfLoCtrIeWQoNjo?=
 =?us-ascii?Q?yMiR3asdybx7EcGvT5Af8yERk3z4I6X9EheNmdhQSDRwf/aNRlyt4NjqUFo+?=
 =?us-ascii?Q?TpNxH0H+U3U49JqHHsgULehoSTSnTWvWHT/qDCZsoKMoG5oS/Tr76/ngdcnk?=
 =?us-ascii?Q?MF8BznTQ8s/TJEUWm7e0agiFK77QpiAXTysJW2vhTVcceTz+e3SMTBx67Y1S?=
 =?us-ascii?Q?UFrLrjEq9CgGrh2xAGAiL9kcO2gb5PgCPJ3PdFrfaKO2ceeTkRrTu0RWdwVN?=
 =?us-ascii?Q?618bwfHiKIcwdruZZpcdoge1w8r4ssp3QNIcZXg/Cxz9yxozXZzEo+/uhyv3?=
 =?us-ascii?Q?+T4DjbEVDQGp3PYNjwwam8xyXIq8OybFln8veGAxhwvUwbJo/hda3rXrzwSd?=
 =?us-ascii?Q?2aA1iAo+hhxVGzkI+TODhoGssPsQ3wuy5jazAy3lQv37JvBo0snZf/ToJWw0?=
 =?us-ascii?Q?NPBSiN5aZ7p6yoSUQvEJ2djuhyHueS3454xNHHm4C3FAJTnN9hkiVEkTc18M?=
 =?us-ascii?Q?dV2HSvBoDp9HPdWKIJfUYM/Phbmy7rlKp+9jG2KWoo5LauEy0t3mClGgb6nl?=
 =?us-ascii?Q?EGLo+1gyGGr61G/Nc451m0cPb2jZbcsskCmde4jLsnROhyT8u5+V+/OZVcJn?=
 =?us-ascii?Q?/rBcPGd5chqoeTtpOh2GXzmAHQV5pBIkjco2VxpPvh4EwFJndsHh2griGYP6?=
 =?us-ascii?Q?YAbvzfJz2yoVyAJPRhxhKdRvn5FpQGAsBlhsiJcUIzVMvQbq/SOGEQTFgy9f?=
 =?us-ascii?Q?pPkQU0TFajchMuKk6i3QSfTCyC/fcAEfv3MM6eUvNxrrRAQRuO6kQXvmFqTg?=
 =?us-ascii?Q?8W4z3UCQZyFkp4T80lvt7iCnof1HE5KoptvAJCv3m2rxD+KK13rJk+bCdHo4?=
 =?us-ascii?Q?bBWJUzmFbzIvHpXdlxIM9sw6qr84iT7lV0QJ78saVwVLVT21nXajED5F+hgG?=
 =?us-ascii?Q?STpAKF1iFTw8snMp0l9jvj69/JEcLyGi2azbAYTg/OYt7RuAHphac1ajgNrs?=
 =?us-ascii?Q?0s9681GFt1xhAK9VWxrXLGkV5VtvxwNPhS0Z6IkvbklIVg+1QRzhGfPPP5I+?=
 =?us-ascii?Q?JNvrqfz08/xNFmHrmwPVggdpX1J4AZ94ZItjM8OP7I+vrn5IM57ogCxsnn8y?=
 =?us-ascii?Q?akUVVnMaqUFY47Idk6ZVa00WJ8V/I6fgLljqHxyi011zzt7UznDwTEgQoS1G?=
 =?us-ascii?Q?8EB+VJRpk/ppmMnyxnHAJdZV7nxnpIb4hmz4+nbyU6LxFXWkvutQr5zFajbU?=
 =?us-ascii?Q?uNSfeMkeWKMcH4pRY3wcA8nVtVp2J4x09YSFH1+l+0JRJ71BZgCgvFPwbnjr?=
 =?us-ascii?Q?614/Dn4EP+0ARNV8O7lgy5eJhlz+SMwD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r6G8iZFz2EV/FKg5BOYMD8td+uS1vP86iFT0goLmAllpCFELQeIIL56Xqkvb?=
 =?us-ascii?Q?QKaqtbwXua9wL0jLrzgHvumAimvzJRpJGupq2+qTEiLUaH8/mYiPn8h849DF?=
 =?us-ascii?Q?gURxSFNW3NSqTF6H56OZ+++xeOJ32I7Ulu2YJ4FhS0JLlOsXmOxNC7lLruD1?=
 =?us-ascii?Q?p8ZmpyWxPe6wMliiqYE3buvUvWtpu+w2gFBcNG08QNoS4b64ot/u7P7dG87a?=
 =?us-ascii?Q?XYLSgKEyjfhlgPlSNs9YdcD13oBuaDVvmNJ08mqEzyMsGxwRcc74bkma0Dsu?=
 =?us-ascii?Q?o768R6foXsONORO3GtBt+3zyi1k8jdqyNWYPjt1xG8qPAcHEZsC5o7SDAaty?=
 =?us-ascii?Q?DXE1mcQhy45eR9sEp5S56MIfKxPiLzS044naRUSkQAqs7nk5/IdrGMKxk3PR?=
 =?us-ascii?Q?nPElM8LVn4ZeUxPIWbtaMynq6JBCwyW28XsW6wYwFDqo+Wn12yn+omuE4yQL?=
 =?us-ascii?Q?E5FwYBgjztImDaSfohKF0rO19vpF6h31SbDImy+Hjb14RgUJMXD7rCLUChKh?=
 =?us-ascii?Q?OjsXzqllSXs9lHplKPSBVbQA4/l3r3RpNjOP7yJWJ+EDeLqnaKVQerXEY8x4?=
 =?us-ascii?Q?4jlQbzMqfvuL2BoU52bQVdE4a+8rJwfn7Kak+498YUAckuZviNnBi/mGCVMU?=
 =?us-ascii?Q?eupWLwMj/YxCK+4AQyupnH0VNNZE8vrEDr5MqKGKk+IfxBP8V04wewJf52K5?=
 =?us-ascii?Q?JhjeuNnTVvi+r4jLRT0CnwPafFzCecoZ/RBPSDM7qtnyHE1Gnx66rffML7Hx?=
 =?us-ascii?Q?3njOpqForFx5aStKn36E7YmEUHZsWuaU1xoR4yecD0CuO48VWDdbkFdFGxko?=
 =?us-ascii?Q?BiWltQ7YhsSvNDFAw/TSS1bN0+AJDPWNR0LyaaxU3QUxv0vQHqX0Vta3hfzX?=
 =?us-ascii?Q?kw/6d6vy76kMLB3lwI5r2zUREi5g56s7XxgKEegZP1Dqvb4UPncMuB1Pvky/?=
 =?us-ascii?Q?2ygrnOF5VUQn0WDVi5G+eQP6y7PZd+nPOtLLd5MQFXApTqHcxsRSb1eEpekP?=
 =?us-ascii?Q?rL0dfGBgX4aEHL/H5k1OM8zymIo5AbvNnfVS5Z2BDX1jPoLZsTcYnDwSvcpn?=
 =?us-ascii?Q?WtBUO28ECrcWs2QYPAEgAR72OvV8XfIVpbkh54BkiXrPa5zvfjPrMzhnYOFz?=
 =?us-ascii?Q?/zafM+DPbbftTbLG8urins2w7cR97gMp8UXutZPXD8FlYca6t/+3gYoOpl5O?=
 =?us-ascii?Q?9hq4cPQJvLtUjr2Nn2iRwvGtGXY9YDcddVRPYRN+7LdRcgoNc8/XOhtK/BYo?=
 =?us-ascii?Q?1VSUzrU0rujL+cDCzIG7SlT/OIZu8eP82IMINPnDnGCC90djOK+VJvKqZpjE?=
 =?us-ascii?Q?FPkJQISXlN39cND5bH1ZCrJJN4qGfN5KDx/CxNz+lAbgNwBpjSD0S+Ng+Iie?=
 =?us-ascii?Q?udLyXVfKV0aKzjoR4odfKPf+Oj3lqf5cyg42hopRtxMfBkJBpkM7p2JjKxJ4?=
 =?us-ascii?Q?jAdCK10yRdrJzhW9Y0dvXD+3mamgknZ1NrqoUxALOb43F1aq1K5WhtSeRKhP?=
 =?us-ascii?Q?+hsda+RPK23CdMFWA/vuQnn3tsUR71jFpn4x3qPU9SZz++oGH1l7z89N6m/H?=
 =?us-ascii?Q?8N/J5mvp/isaKa7I3H6Jvy3EB8k3o/NWR1JUp+jNXNXMNKAOeSzoL1/TUHpT?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f60b24-a1f1-4c1c-2add-08dd5637258c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:28:21.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IIldIokHRcu/DveMoqqedJ4wLktOnoOeAabgelg1+5/+yWXkb5965/tBqpIyRTotXCjakVGY5W62wYHRL5E0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_232828_831121_534D2298 
X-CRM114-Status: GOOD (  17.57  )
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
	- Cosmetic changes to queue_state declaration

Changes from v1:
	- Fix barrier semantics
	- Use rcv_state instead of state variable

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

 drivers/nvme/target/tcp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..4f9cac8a5abe 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	enum nvmet_tcp_recv_state queue_state;
+	struct nvmet_tcp_cmd *queue_cmd;
 	struct nvme_sgl_desc *sgl;
 	u32 len;
 
-	if (unlikely(cmd == queue->cmd)) {
+	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
+	queue_state = smp_load_acquire(&queue->rcv_state);
+	queue_cmd = READ_ONCE(queue->cmd);
+
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


