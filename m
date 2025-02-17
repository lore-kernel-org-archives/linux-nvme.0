Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF54FC021AB
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iFzco5MzYjpC7y5aXFQuLn79AxFGxAlBXK2xgGVbCfQ=; b=f+ftAyXHoX5nUEO0LFlBvsLpwo
	taRITpeUWQGPANZZdBETn2F1T/sV7QPRY96yje4FBY2atsBXf8RpInXiXcsYllyI4Xktuhfm6Mg24
	o8jLBXnsOoJhY85nNHojVVldZmM7pJHYHksEuNNy5VIjPNnTmJmKcj1Z88rOzO1M+aW6RsfQM05wD
	6hFUIRxbKTD5/PwQUrJz+FM/IMI7BIez0g9O6dzze6FInRfbT+7vSnnvMvGwjm+xP7TVU4tYHZM4q
	VXKE/Hsmm0gnXORduFKDFfxBrbupDcwu0YZvOBH+WoclBKcdZD4Ys1J1yzla1T/eVhZt1W6W5KQLL
	om3/0X4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk2LE-00000004uHn-40rH;
	Mon, 17 Feb 2025 14:43:24 +0000
Received: from mail-am0eur02on20709.outbound.protection.outlook.com ([2a01:111:f403:2606::709] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk20z-00000004pgN-0eAi
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 14:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x39JfaG7v4aWmt5DlHFRg673qUH01IBV+Zp0U7VTk2NguMn6ye/nCbcLVffLHbV9J7TNeiV2kTMPtQwNlCeZo+WfsH4dSn/XrjwERZDNDhWRrpSDcfITI5il0xeWxFY7NC231C93E4RNo4BJv2HupXfBWsaf0ZHBnY9bBedTf0wnMyU2NqHxJVaGX1pc0mXy+gD36f4EWK+7bfpigzun6UTiPNarmaqHwv8dqeTY/sTAGwwLqQZt3HvxWj31odIHziEejc76R52ipDd38U1bMxa9x4G3legaw5bmqHaUfPNS/vwglouAQ+X+FHjEjkIpD9OI8Rq3xKwABFWNEOlThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFzco5MzYjpC7y5aXFQuLn79AxFGxAlBXK2xgGVbCfQ=;
 b=XJSy6xKYdYQSlWS/7QJ87eXj3QRLHC2H6Db8T15rsnpmvEvQS2ipTu8TvBq/3yk3uj5rf+RWmxiv+Ez9vax+tcxRt1N/+6U1Jz2qK/iOqq2uow5mpZ50KtejPvJ4hh+gO+oObvue0GdhBq2rotZOBY0CPNJvrSghzWawCjkzg8UM90ZiJQ36RFB0vk+U2a3LWw3OGEabT0hxNOfEPCPRp+tWEEJq34HSbjtL2BWz/pLeFkGSol6/2XqD9qkzc3igW+LzuP9uAGqUcSeLNte9H+KkhA0QgiiwA9tzHNvDIYBTRq/9ItOX12rRl67XEu74DBwinRjB7zzJImenUmBXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFzco5MzYjpC7y5aXFQuLn79AxFGxAlBXK2xgGVbCfQ=;
 b=Hq8EngmbcOJzKcXjhffPs5oAIUJ2OAtLIP4hcZSJthhLPgJ2Bb4QmkTCE+uhIDv3mf8ZpCxBTaO0vs71Xc9MC1XCw+o/Wlv+xxr/aNGwLfoulhVXhMI9+vA1fY/iYxltZ6oNhvL+LEcqSxXAnZJ+hZwhcRRiQp1s81A63UBdLTNyjfBVlEFCUYFdUQ6Md8YbO3j9+tuEunWGJEjrCRK4CmMG8/Tff+hqY7236TfSBFEylIjTIfxw1JBOwlxMuFnfLyxKGzr3FKicKCB/p4dGb866Y1TXXDNT4FzvgU/ZhIIrLfl+CBSdxdwOdRFqDir/ntVx/8TW+4tBkuEVHDmLCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:22:19 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:22:19 +0000
From: Meir Elisha <meir.elisha@volumez.com>
To: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Meir Elisha <meir.elisha@volumez.com>
Subject: [PATCH v2] nvmet-tcp: Enforce update ordering between queue->cmd and rcv_state
Date: Mon, 17 Feb 2025 16:22:10 +0200
Message-Id: <20250217142210.2144548-1-meir.elisha@volumez.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|VI0PR04MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: 965501e7-943a-4bc0-c171-08dd4f5e7c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HT6gG974TmASJhIY1uE6duTUWdd8dvYY3EwmoVeig8Kpi50MicS+bJVIZQdy?=
 =?us-ascii?Q?EFOPGZq/mu1qvCsoPqU/y3FQCDrPMrB1SisOT9qGaRgMn6HhrUZDgB+b2u5h?=
 =?us-ascii?Q?CBCDuUiqye2ShejdV7JEMaXUi7zee4dix8wXxdXBnGOIQ0OCfcyC8t8q3vf0?=
 =?us-ascii?Q?8VhnJJ/dQDKNzvRMRXt47qPDTkCmb8OKjNrdx2bLRjspeW2JlaXEqMQKkQB8?=
 =?us-ascii?Q?/soyhZHEKAQVBGXeylMRlpGzQIdKtwcGZod8457zDjYtBgcqqQfZA+tisyux?=
 =?us-ascii?Q?0sLUSJxiuaAsQNE8IlW/3e5w54DF8ScSEnGrQf+Xhp/KhSsfUfB09VoqEhlR?=
 =?us-ascii?Q?SedyOd0b6+MBk65flf7rhbjEjoffY18wqSOog2XE4JrenEK92BEjY1n1gfHs?=
 =?us-ascii?Q?G6n5X3O8pEj+HIglRYrrOxnYsOG5tZHyWQtiCMgDgMIBIZFVAul5cr2wlDcn?=
 =?us-ascii?Q?cUCOgThj8nbeMkNOyj+9L+VWnqx1gnI3aqw0aXYUDIuTcN++pAd7PGLx9xyD?=
 =?us-ascii?Q?36T+mKCbjTgq3LVoZOIDXQZHAb6K0mLIP4xIyK3ETe/bpGHF2RUnrSgeRKvT?=
 =?us-ascii?Q?NzQWGcPMrDzq0zJB5oFLYsN/q+KDd/LFJrNm24phhV5DyiuZYtWR1qxL6+YJ?=
 =?us-ascii?Q?IWMUh8f1qbqT5JauL0XfCb22MYf7F8NHCz6KQd9qFNlHlgqRI9PLRVvJvJfE?=
 =?us-ascii?Q?7syYLioetZevKEPcQ2rpbvJxPTRGcf+DjfOqGp2np9a0be6LpsXmJ8muupHx?=
 =?us-ascii?Q?LkfJ2tR38J/eMkTaWhwLE4hnq5w7+Bob4lM40sb3pCdvkIqpbWgnsmNipYvb?=
 =?us-ascii?Q?QpWW6OuanD3vqf9+skZmrUrSDOSws55QHSAYprbAx7lkhBWOmCfW4nQ4zO6q?=
 =?us-ascii?Q?XAGG1XbKnEanAs0Biz9AVVjEchKEU5t6qxhhH6PtqnD3Hkg0NnC4LGXH+l7D?=
 =?us-ascii?Q?XSHQlpJPPcxjdNRKiKZoxsXvaGfMN9FA4BjRBFk2fIZqb677wayqGtolFhQC?=
 =?us-ascii?Q?I8GP9hnbyPlqUp0Dh5pd0PD2NFPE+EsuJqfY3ZMHkTM59TyF9rFENucE1iCl?=
 =?us-ascii?Q?UodSe4WLRewt0NRbiBR5/jyWn1reZ8xy6GN2D9R4Koy9yeaAltsMO7l7Tm8h?=
 =?us-ascii?Q?TEwBU3tYmPej4amoAJu02JfzAeK00SGgaER53//a7WZhwRD0PBHqBDbHw0qr?=
 =?us-ascii?Q?xHkzKY5T5xhNH14LMGa59QLgyZNx9YpDq2acisEWk5EOl48olKveSMZx8mIO?=
 =?us-ascii?Q?V4MzeY+L0Pv0vpgdcX9DgneF2BoSVgC7vhwHZUI/+wi3pbu9vV97IxoZLuN8?=
 =?us-ascii?Q?31JMzQdApliifOs7a42Wasd9mN/Q4NT/rcFlpVXEXz6JZ8HPWiCePEtLfV3Y?=
 =?us-ascii?Q?rr3BDSTDdnaYpuel8WQizUfstLiUsMMV91ra12a3PuqUet2bNt20NGrafapb?=
 =?us-ascii?Q?yLoa2t0kpY8hBfyfwQEHRTo+4bpKXmFv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHBZWzRMrVWKg2A/VU95qntRpAzrZ75eRiEbzLOnlYb/DEc6d/nrFs8hLoRY?=
 =?us-ascii?Q?z4NCO5Xinb+5us3J1e8MXZrVtNS+y/ZHR9anoQgt9O+YovabbO+Xt8vW5HYA?=
 =?us-ascii?Q?g4LsxQovSNa2+7PFRNZnKYmP3YmAZPY6K35Wnwlpr3neHsOLGX1KOn0eiEOY?=
 =?us-ascii?Q?Fh0009GpYWcTInxUszzpTA52KZ2yqdMS4CXMo+DdQgoAA4EndiCyjv2FZg+L?=
 =?us-ascii?Q?3R2mGxFcvyqyyWO4R+wwc3SjB600+UfF+LiRp+nDRWCc9nSTbE+TvsDN+Gj1?=
 =?us-ascii?Q?cmYP1QuxKj7Bw3Se/JatNdPFqy4GkqrGx0l7rbKthqaq92nN2c9Ba4MF8iAi?=
 =?us-ascii?Q?so5MTEzIMRkHMSlfLKZcJeyDUSSXmkAT0yhL2zvkxx0zpTF0rC2ueZ1NcsKK?=
 =?us-ascii?Q?BgZG9wVzXft5b5AgLGkVGrrp0iTlM2rcvUeDOdpuoYvM8POCZf9gWhqHcCew?=
 =?us-ascii?Q?lnQE8igqmWS/gMPIUZ+QoQUivRocQkkXWCkjUAzh8qgpfsD1lY36iCV3M0So?=
 =?us-ascii?Q?f0Y0xyYJllyqrT3IiO1G0oAhtGWc1+elk2zurvtUFMRgGCkvQ3uYuO+JycGE?=
 =?us-ascii?Q?RAEvZ9ODM5ROXdT+BAKaw3cbNG/4oe9zzBonIxRAeXLMKKUvWI8bvktOKOd0?=
 =?us-ascii?Q?OIDh379C00XYGV4t3QcUFwNWaGzctBVR57lAu7b6Ub+ijPd0FekX/d8KIiSY?=
 =?us-ascii?Q?LXq52zE62rK/X1SxsjX9kHb20rb1qaCJGLFZmtxlpZHMNBdRFml5yXra2+RM?=
 =?us-ascii?Q?RL0lAMLLTL5hZI1BHH/D0kv7mx/JPob2DXNZaD1fmNht0xjFIWV9EmFZafjV?=
 =?us-ascii?Q?SRgg5L2uuiIqqEIl5CSG3Hn9zuG0NB72XeNxXa4EPQJZzpZsu27Nica+0cCt?=
 =?us-ascii?Q?ATbldThMABfaeLZKxnNff6bV4JLhe7PeM6cs3dcu9KccxSvEi0HJhNkVy5yb?=
 =?us-ascii?Q?RHbZd7huUikRKgdPrmArqMOqNwenP802JcDd13I3cXm5kkSJM3+PGr18S05o?=
 =?us-ascii?Q?TEAmXYphaKEsmR7y383YijwbU3sdpOVzMtQHl6lNXS02OkXfgN2me82DNqhT?=
 =?us-ascii?Q?PMW+EIh5XyoIgQ5aYWvdKAnJf7do0fqfRQdGQcZh1HNRankj+jLIC7y0RCUk?=
 =?us-ascii?Q?PPdupCKchuBoguYDGQqtx4xKg7SyDbv/T9of1hz7TQsBZGYnCj1uVzBNQdiI?=
 =?us-ascii?Q?xHIklb7ErSXkrFVG8cBfsPbIPLKXa/R5QEPaKwJzuHRFtlvnDErldKiRVurw?=
 =?us-ascii?Q?BufACjQhMizlK3aiTLmFPzxFCFwWeUyvoHO0U/WGcA6goL8ZhmcAVvayzAin?=
 =?us-ascii?Q?vkPwVwN+TfEZbSIBN0UcFf6+TCchp1n/3+wRiPs5cWi79MU72BnL2LtE5Sqf?=
 =?us-ascii?Q?sU1M4xEr7Tgf0TKxGu1P6Evu5DtkWWWcIy6lniFvf9I59YD81guQYHwULcUz?=
 =?us-ascii?Q?WSygH1gnFQXkxNNSBBytAf1Wo5tiIRhspPghVc4QTbxLGKbOMCoN2HrE5l1i?=
 =?us-ascii?Q?QTGP8OlgabHfd93H8/ajK7xe+gICMn3n9zdR6cKqSlT3nKFK4VdtvTeoKUNn?=
 =?us-ascii?Q?pbK1phIS9ZtiOMsowTNerv13fsrqYjzyoDghc7jiL/dfx75pAmaSIgxko/Qh?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965501e7-943a-4bc0-c171-08dd4f5e7c1d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:22:19.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie9uVpszoXTnsb/52dhbuxlUTyglfCh2hJFonNarQ6QfKh+r6O3nw+TOtW4mOAntC+eCRtOicxALZBQzowLXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_062229_210413_D87AB6F1 
X-CRM114-Status: GOOD (  14.94  )
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
v2: Change comments to c-style

 drivers/nvme/target/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..49ce2f9ac6c8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -848,7 +848,8 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
 	queue->offset = 0;
 	queue->left = sizeof(struct nvme_tcp_hdr);
 	queue->cmd = NULL;
-	queue->rcv_state = NVMET_TCP_RECV_PDU;
+	/* Ensure rcv_state is visible only after queue->cmd is set */
+	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
 }
 
 static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
@@ -1017,7 +1018,8 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
-	queue->rcv_state = NVMET_TCP_RECV_DATA;
+	/* Ensure rcv_state is visible only after queue->cmd is set */
+	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_DATA);
 
 	return 0;
 
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

