Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABA9C02198
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Feb 2025 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QJ/nnyMumZYQKW+SWLO0aSrhTdfwhR/GBiU1JeQdQ24=; b=Mr6KPSKw016OwnyQdTGCh3NvdG
	7IlDy2I3J1FntSVPQBHMU9xuF5RfuU6MEtNkLXPhyN29lmmBkurlt/R2u9vV8E4dT0o3e7mosE23a
	gzkJOgo5SsecTC+XoKezBVnx5Fq5MCAe5wFrgPIC2ePTGmeLt5rfE7NfDPfpJdiFe2ozvipiLHStt
	VG2wUeaS9dVfFC4GPCqPUfLNOIdsuf4c0t5oIS1qeJ2aa2MDCDRZA9HhdcDSNNm3Z+ZIs7DYJBrIP
	QopcLzjIwGbLfSlcug4gyKN1Ge/WIZyTtPM6W0fME012TG4DWvJzr+3paPvJHp+XMLplQm/R/GeCO
	Pewh1ONQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjgFy-00000001zVu-31eq;
	Sun, 16 Feb 2025 15:08:30 +0000
Received: from mail-db8eur05on20723.outbound.protection.outlook.com ([2a01:111:f403:2614::723] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjgFw-00000001zUp-1kiY
	for linux-nvme@lists.infradead.org;
	Sun, 16 Feb 2025 15:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdHdJNjc6SDPX4Cs9zbRCVpofW6wuPS/BatMqvr28UK27MwaXgumjBJTHAydL/jzLHJHqe0PP6AZcpJwhy1De4HKPj+izrnCHeSTrTcpclSCLdIGsnNuHf9gynJ+9p1u/lpa30hegUVc6F5puoIzGD1BRPfwV2kNHnI+zob/4gyldo9AgYX7/LAc6Fv39EUBwZ6bttjPtDa+CnFNLdv1T3yOxGvB1yIYDsP9YtT8Njyhi0FfScBMK0jDXxnip+zUtX26e9iMxWCS/NJjxkqLO48JdlEHJMZBBJOA5iMd67yP2bZ3rS+6bCmPg+CIc3PsdCzq8VA9mUIIvxWOqr/uQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ/nnyMumZYQKW+SWLO0aSrhTdfwhR/GBiU1JeQdQ24=;
 b=hcBNMexMYlkIo5BGXut1GBsiUawNRSyzoSG9+24fB3q50vxOTH6K3X4RM2o/MXuomw9j1zjy/aN4dLqwGoHk3/LGe7yMZHTPkjbX02F1pkY6LrfY4B3trDzyIuDAciklav2R6CV1fGgfBzU0z+R7F4WgPSOgrQVBqRwmcFcjTU8ryVgB35q0MrhEeRv7GhgygZxCTeocOs1wet86JL2uMR4KEh/OQjdPkd4fpxEARwSyXRL+2wu6n7It6o9gmaKKR8YCGYnONq6bwxzp0JsNIC3/CSJwGwZYiE7xNF2PWubTOptDeLwPuhHMLs1dsnBAWnl6+112nKuljKEsJQQa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ/nnyMumZYQKW+SWLO0aSrhTdfwhR/GBiU1JeQdQ24=;
 b=KNAfC/5zdmqa4EhSd/zQFiEEcVPsBwsbIpSmk8WV4piNrkRAVZb2xDaRPfm15SbHutrXjTD0oUNr1O0Tm/B6vA50TjRE/zOzfMI8K7jYyPFQ31WHLymK6Y4bDbXZk6RlXstV4sAswA4FWemvRZMKoLa9g4Ir5l21cReELVdnbIE6bFtium9AKBJ4xTdnGmHBU3xo4vKeJb+sH7UqFJA21xoOwb8WiXJC7b7SblvxwijY2Q5unTnZFhiO6NG7luOclGlONsnGF1wRfO0Di9+5EVARfffRIb1AlqIbyw2V5jz9It9guyKHacOy5Bp8LGCiEFqctiLCg+WGODrdLFVJ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by PA1PR04MB10602.eurprd04.prod.outlook.com (2603:10a6:102:490::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Sun, 16 Feb
 2025 15:08:19 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 15:08:19 +0000
From: Meir Elisha <meir.elisha@volumez.com>
To: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Meir Elisha <meir.elisha@volumez.com>
Subject: [PATCH] nvmet-tcp: Enforce update ordering between queue->cmd and rcv_state
Date: Sun, 16 Feb 2025 17:08:04 +0200
Message-Id: <20250216150804.1542552-1-meir.elisha@volumez.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|PA1PR04MB10602:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deaf504-cd1b-4c08-c356-08dd4e9bbf13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qA7dD75wINbiECeS17T5+JBrNaG+5yDl7JYtDIPQLM6o38sclAJWa3Nx3EsH?=
 =?us-ascii?Q?hMbkeTPLceJouunaL7UUZvXMm6zmUh07A/MHmMQDiB3vWaoadWQEP9bg/RQ9?=
 =?us-ascii?Q?axwJRtGr/c/J/FG7zXWjZYWnIDKWRqIweHNzuY3zEusaUZmS7DAjUYfypyOM?=
 =?us-ascii?Q?iD5xPfu64H6Lqab4M/QcAbImaLETZpGLKFrEqdbS4wZJq8U7q4LNeakx8w+R?=
 =?us-ascii?Q?NdOKWAoznvcewtVUe5Eokh9NgujYzpjHhJ5laYa4o1DTOcQEzZ2nAMca9KGC?=
 =?us-ascii?Q?58y3Ah6mh12slCxAWV5QvHhUr+DLOIciI0jTgqDJnqpzWPXuxiwebD1vaGU9?=
 =?us-ascii?Q?1tRX+i54Gle7/881R2BbCRoRa88nB/TpviSXnKgmxmRsJCM38fxENm4TNHC2?=
 =?us-ascii?Q?psy4gMY0FqxDbnAiuWlJoYV8ll3A6Qa+BujAZWe/c4XkcYvlwdvD82mA1ptq?=
 =?us-ascii?Q?Ki1nDRfjkjzcFVHMy6NYqNasVHQqVe5zQrK9HbWTlXeFP+iDtKNonf6AdTdb?=
 =?us-ascii?Q?aG1v/e7DNdtRUNZ+k5oCeUGecG4rfjw9z8zk6hy/jGif7H46Qt42tBm18dkQ?=
 =?us-ascii?Q?bICG8z3Pn3ibf5X+opUK3cSiG7+Nela5zZT4SDzsMOhgfnLm2nHxPzjMu9qR?=
 =?us-ascii?Q?dXrmjbQ4c1Mg/lvDOhQR5V9O8gz8W6t8CmxolBozawDxYrvkCVhRc1CiaKIW?=
 =?us-ascii?Q?5hjqtdvB2frwF5bo8DoQECSpo/IjtZTJAaQ8KTvHlCZjRM2oCahXN+Os4zvY?=
 =?us-ascii?Q?0APAURQTUUuiTcHx0K2zASVyMpKNJQOm4LpPXkDSTPxwJiT+zNFBkAByLflh?=
 =?us-ascii?Q?ZOYN/ZcJD4e3mJqyammAjuzGtQap3HoG5rZtJ7ypfNm3eZL77puZhFpRy5NY?=
 =?us-ascii?Q?g+VMBu1W1MiHs5m5tGd+H7BxfmmpoxzFBTFqAgglJMEtnwVI7VqNw2LcfGfq?=
 =?us-ascii?Q?JUmeVpqGvs4+jZ1y6z0plCXx6VREHHrsKUIEDCIJ9gMumXKG2lJIf8dyBvIk?=
 =?us-ascii?Q?0V7+0LYk9L/MeCN1n9uSGkZv9N93n6r3vaz4x3EcGv15iIuANKFQUnN1YRlR?=
 =?us-ascii?Q?79ut05dC8s7SZR7O3PlEkYzFx38WCcoWJN8tmSw2zlHqOXFFIGHmXmCU0sau?=
 =?us-ascii?Q?4v6IboG3FH4ncmEWhCMm5C2bhOo4Fb/0mKUMDYxfR+UoWXgn/5YV3obeaMli?=
 =?us-ascii?Q?iQzrKSWa+l3frWIixhei/KP/1pyBeona7qYYNU0NFUZUCITj7zW9NGd26XGr?=
 =?us-ascii?Q?C/beFHP/WOifK1lN9pgpTjmTuunVzO8drJ5Yr8m2MrMYjBDCYZQR8TFB0GEq?=
 =?us-ascii?Q?KiymjIlQOY+6gtFHlp0CG0q9geySXmxla0V7mQRe+KGVZP2HHCFIHQgy6HgB?=
 =?us-ascii?Q?nP9OOn2W92bcV3vDqd1aPlA/TBHdevp10fevygyQFhNED9t6CjLisjvvVRoA?=
 =?us-ascii?Q?Zqk3ZBCx2qW8V9ijBafoUDok/nV6q+5u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A5LG4xqk6gw7QB7QmAz7nbhM5cO8L8XhwZluDLn9IpcavhqMW0aosnL2uj5Q?=
 =?us-ascii?Q?htCsvd1ZFCiVm6YtzCQPJzXjwWlxa3q2GHJCRREGyUVp/4ErPbqhCq4zT1Bs?=
 =?us-ascii?Q?bTZF8v3BPDFrJO5i1/6k3XS6EjuapNdSW3XcvRa6GLHiShzrmKyis7GKy3A7?=
 =?us-ascii?Q?VcQg4XuwRGFqzgJszDWV37jBVZKB+KBwHJecmMl8fm9ngs4F+CfzmGx6GqyA?=
 =?us-ascii?Q?vVqHIEVanZiQ6smeKw+MjCVIzGgHJYw6mRiLTT/2YvuJd/caRVVJloLHjEPm?=
 =?us-ascii?Q?wK6zfX4/hK4rhWvO3uAMzAdQAsEtew+0Xk0NZuWwXEI7HAWkSeOASsdc/LAp?=
 =?us-ascii?Q?B/CYhy0fTa7j/Xwo0sjZncAFUayAPeKFtI/ZF8DIFK9AN5EDbwI0pGezMaRW?=
 =?us-ascii?Q?VgddO7EWFIFVAHMw4dOuDd4zjkc4zKjl/c6gq2uVkXbLDX/k4H8MatnpBmh8?=
 =?us-ascii?Q?aCFG1jacQuCPB3rdMK5Bl9v/A6fjD1ZRWk8JCxwy3GjcvLA7x3l7kKqitObp?=
 =?us-ascii?Q?76jkiE+p42cpg6gDRrjU75IHJ1Ae0hGXTK//Wd+FqxRgFewLlQaVjLqanlAP?=
 =?us-ascii?Q?cbJX4T0AuNr+32jcqiYUqw2wtXBxq7WfndBHUNX82liQfoRGgcsXtRB8CrgG?=
 =?us-ascii?Q?mqBcT/T/NJgloO/mB4jOl1eJT52IyIojcqJZziRPGSDpZ1eG50bG/5nBUFQs?=
 =?us-ascii?Q?fAVdeviFawHE6VErBKR6zjRihLYdcb8sjndqfH1e+t2yjIY0y8S9s247e6Cc?=
 =?us-ascii?Q?Df0ID5qRcSbAdTQgnkowRWnqpLUIW8YZxnZ531txpWCbeKudxjVTRvak1N0Y?=
 =?us-ascii?Q?rNgzIX3bn/mgZKi6aGjotc49RYBCp+3l8RnDdRZtGuOjtS5fBsjUlPIksqhx?=
 =?us-ascii?Q?HK6ZWGCUgvj+hcFBgg4FV1K9/vcnQb9ZGkSWWE1ApmX8I/tO6DDS32BaDRM7?=
 =?us-ascii?Q?J7y1hEXi28SUcRUvk+QG2luxjvuc5OdH9FE3siTjdKZ2M/JFWvEVUzhmKd4V?=
 =?us-ascii?Q?SZapsALMFhLy6Mb7kjdZIQNfmqvA0PRvIMYn1q6DrB5FVY0zZJYs1ogcy7S4?=
 =?us-ascii?Q?U5cvrC/P317attv3/VmLx/obbE+3KllYSUJca7HiCKEA7vAw1tVdlWeNyvkL?=
 =?us-ascii?Q?fSlMZVserMZf5UYRYBTv/oTJ9/0+cvs4oeIG7BCM8x+mrD4xI4aLBUv1KMyL?=
 =?us-ascii?Q?vWShlEBEh5bQ9OZRGUQ5Ijr5tJ7jGFdESQ8e6a+JFoP0IHvlS5b0CH7Onq7z?=
 =?us-ascii?Q?svSrSLBiFHRceOlgGePAvyCAvumgCJrRzHD2sZyHaIzX6b/wNhItRk0BkaRI?=
 =?us-ascii?Q?1cHqHN9xDpRQ/+fpyGbnsHgRoGGX2K2i9OZ3mEqHZEIh2/zTSxEQGu0zIub/?=
 =?us-ascii?Q?wHvq0Hf1fs1JAmYu7BhUGxnmMeeEhXrhY7QsHyB2E7DMMMZzX1Lzat4Wvy0T?=
 =?us-ascii?Q?JifDAAF38pCph7Gh/GmXPM5F0NuM61kM7NibLglfdaWkFlYUTdNPpfb2M5ho?=
 =?us-ascii?Q?2IMEBeHYbmrioAAqiClrN31ZI/HeKRyg+swzxvj94kUyKZTxJ5M9hX9bJa4N?=
 =?us-ascii?Q?VmXK2PKcVUvjiC0X0kPxoXrY7QFP4A6R9fcc4vZtTCft4K32H7RAh/5L4Ya0?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deaf504-cd1b-4c08-c356-08dd4e9bbf13
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 15:08:19.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFo8YKqF9kiQW2DWqH9uttU3KiznAlWMVZXN1JZhh6gLB++y5jEdMz0sUNo7d0ZaPfOsL85eeB3Le6eYoGMm0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10602
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_070828_465584_C9A4255B 
X-CRM114-Status: GOOD (  14.52  )
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
 drivers/nvme/target/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..b66aa93baaf4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -848,7 +848,8 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
 	queue->offset = 0;
 	queue->left = sizeof(struct nvme_tcp_hdr);
 	queue->cmd = NULL;
-	queue->rcv_state = NVMET_TCP_RECV_PDU;
+	// Ensure rcv_state is visible only after queue->cmd is set
+	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
 }
 
 static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
@@ -1017,7 +1018,8 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
-	queue->rcv_state = NVMET_TCP_RECV_DATA;
+	// Ensure rcv_state is visible only after queue->cmd is set
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

