Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E28C6379F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Abm5iAcgOYZHao4pIgDBAEukBJy87lHCccyyqJ8mJeE=; b=bV6ZUtBzuHPBd4S3YTV7aMJ9oD
	wAhGdF2x4ghoZVKOjn1J/Xs4tj55lsM953GCF+myFZ9q/nEzjqma90HyjTGRWwLq1qdZWjOXal4jS
	0WbuJ95VimucH2enVW+pazQO+mziZvYsAEaCvUuRNxl3OOIZIujltTE7Opz4cm8MNBkm81TTNQn5D
	nlQ8X/rkU+eZrFIgSEyqJOP2+nJjJv9Gjs/MKmf3Lz/ByXiBNga29UOyeCl3t/aT7ml5SjfovoPGI
	qJLUg9mRReP2lP/LOYpUABpEX++wB8oHN8t61s1vWCPHctoiAYgESn6RZGzOM3CLvfjGgTMfT06u2
	PyuK6XLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHo0f-00ErY5-G4; Tue, 17 Jan 2023 15:36:25 +0000
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHo0b-00ErWG-HK
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 15:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv/ZbomF7aY2uUClRwbnXealVj2YuzwPV5UnZWRgWKaMxMyMTBtx2tWcpcwWrNt1qBmNG+JBhAEOFafRHvCXb15fmhF6R7YdN8pi1YCkWRwjVpFMr/R3PTCii5Fm+INC0VNeczjfrr5jJQghrcaMvGQiElsFrZ220yNLx41YPDK97JhiGR/HuHEoz7QFSuyUeg/hb1E7ej94T9Y70h11A/5/mcUpwZiktWpU3shJbK/aWoz9HWdi5kNn5Albpk++RtmPWdbW0HbE9fj6EOzIiORudVBan0k715EK8K2z0VzF90DzSBMGSWSagfAJIlZXNz9eFCj6y12fUUGSIkJhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abm5iAcgOYZHao4pIgDBAEukBJy87lHCccyyqJ8mJeE=;
 b=iOplGgYkAOiQExDCm8pn7yCQElOs1Mr+CaQj5eysv4TW0lc4E3Zv2flZqlVScXK2IJCmYbdM/G8FYF/m7+EQFi4yB6/ADHFMIO3CljIQ3kigHyaCwgmESenNjPTjIo+EoZZAzpj+7Ie4Tl9wjf+KBHlgTWKbOLK3XY49S0OISiniyTcny+2TylbzpWRS0tDIo3oBnQjcbVrm+POFWJuOpsDvOE2p9kKTcZZKLHDx9K4CzkIP2POJTgFkjoWnSKQ42dChfLBqaN6hw9gTpnOqddlTJal01TCUw05UTrG2Z71r6RkofLgTui6SGASZh7sxkcevHyUpalxHz7tEedC6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abm5iAcgOYZHao4pIgDBAEukBJy87lHCccyyqJ8mJeE=;
 b=HfUPEIFXkvSO2bDEpoUz3ys3S6Um8lvfEUZLIaM580ZVxKDgB+zB0ZuTzg+9TCzMHiAFJEF+duuEDcqa7GBMSp2WXgNN6EQ77vtLgGTvgHde18gtzqJgpTLcvKEBM6jUMlgPRGCOcvtHllwuhZa6356cgS2OAPON3L/wUCQH8nXJYrHkxBQZqJFHAtjrVlE70wHUUnuJaXvgNOXL0vjO9szxtJkG2RjER2GzoYemk2JHfUtdrAZ28lDpRc2VRCIUJOsmRd5VzJ36V42PsWE3Ns3hhBnyiENjkx91TQTEEMsL7vDws74VgcAN1nFXCbRxl6bNacIeZeu2Cq5vBD0kVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 15:36:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70%8]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 15:36:17 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com
Subject: [PATCH v9 02/25] net/ethtool: add new stringset ETH_SS_ULP_DDP_{CAPS,STATS}
Date: Tue, 17 Jan 2023 17:35:12 +0200
Message-Id: <20230117153535.1945554-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230117153535.1945554-1-aaptel@nvidia.com>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdfd72f-8a9d-4d3f-67f4-08daf8a092ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	5jb3zY5K+ECEafiOx/pzgACn8g74pxHv2K8ISnscHsmqdGIbYB+1UdKrFoL9+yh4JdqdazmIX8yFfIBvP+RAnjJRViuN/GrYL0ZRrx1G5QyYqOqDAuvKdghFzADwn5ViTxxDFisPxdQnld86OyVxAH0H2YINx9CjL5Iym4N5vcxPhzA+iAAg5BzUV7GH0kCN0lsFP9Bpzjhjs9r2+P/8iZYwnkJFxtVh1yRW6N0cRrcU4JRihld42y3+SIFP263VuDhCl4yx5KT6cfWTcZdnHNHBiZUCWq52c0PXLuF3sq47xJAJ2OWLs51Q3b5N5COcUeYztUg057+NSzvsthlfEiGlDfbWqvkhMZ/gj9wNTAcQYbfvtoh4NxcYiwixMJT/cUfyN+m5ktvxni6n5NVXujNJAaN5nruOn4sQgAap1lK8N7bEo6PWNOe4AOhOEdW2NpllGL2Btck3RYWBGoBqJpZFBJIJ8to4dS97R9eHJX2zo6X5t1Zw4HRqJTurZVi21UQKbXkrXbzTU+PKDjvdNKqdXYZI6vdLbCvLoC1TtAbgI+QxjOkv45we5QqxhZjtqEzIEe65lFXxCbReySNdn6OJuF6B2YMZIJ6G41mPhUtjzNxbMLPxPiiML+yBn+C0O12/AJsqBg1KNgpvGxDxlw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(66946007)(26005)(4326008)(36756003)(8676002)(66476007)(66556008)(41300700001)(186003)(6512007)(1076003)(6666004)(107886003)(6506007)(2616005)(83380400001)(86362001)(316002)(38100700002)(6486002)(478600001)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?HXP2F5Us2yhKytvuh6VQs9f1+AUEqWGNYGBnIiFB8wPuzZ1ljTD4USIdkBi7?=
 =?us-ascii?Q?BstGDjRTYXH+kQwmBIXhu1aK8W8Zk1eDtV3pXfUmWvHazr4NEmnOygPxHIUG?=
 =?us-ascii?Q?QGkkIALLqLEY5bKbupuLGzLku2q9EN1PmsDzbNlXYC5ryH41lzni0+rdIylv?=
 =?us-ascii?Q?5d0qYRp9hLD85nwVdk13Y6srgY3vNj6y2J0AvCD/mWMRdYzc+mQ4C9nJcQ5F?=
 =?us-ascii?Q?TsOwbelVQsvuJGz/T4lo3Buh+HmRUO7Tl9MHPHkohCYaJGzar9I9YAYUwFh6?=
 =?us-ascii?Q?l4x0Ks/S95t64fenHQx3cHKPO8+aqw9GA2HolFj4GfdcfxKTFl2kdwVfJUPQ?=
 =?us-ascii?Q?o9C+F3OcZuHb1nZYus2hQOBUdtFg+vuzMYZahYHrTac68bIzpI53sZYh5D55?=
 =?us-ascii?Q?cfCGBaDKe/xaFY3ecF7wnoWJvWuWpJEiNwIXjFMPdhNy3JKf46InzZgD1shp?=
 =?us-ascii?Q?ZsY/r1PULRJ4vjTTX19N5FZCFYoXxpMGAHYb+FFYJEAUd7NtM9d7U+wBTAhV?=
 =?us-ascii?Q?qsOD9HdUU98eVsBrYcZDAqYi5LlOtb+zLMu6SAV9SHeAMpauJtiw791mfVY2?=
 =?us-ascii?Q?SG9FUiNKU7c712tjVz/FUefuyJXsZTeqpIIzQ4cFZaQC45pzqgZ2VN151DNM?=
 =?us-ascii?Q?PzuGcmdqTVvWoMwN1q+o6ofhFzk2CcAGY6Fte56/DjlPDpw8qTaz2LjFQwhV?=
 =?us-ascii?Q?c0DEOZDgFcxzzHk5+hqdMo+sTCB0+2d9baflmszSsL8PIPE9s8HFVwQVzFbm?=
 =?us-ascii?Q?cIHLCnRrVx5JX9ZQpEkiW6JDR4PhN8BOVanKUkZV6WGr2fA7qfCdVZvPp438?=
 =?us-ascii?Q?QaduKsaEDr8uEUUywQEGHXM2r+5iLdN1svsgrY1sJ/tuhlmtjQNuLUEyty24?=
 =?us-ascii?Q?vLFdOfI82GVGuUFM8yCh5vw0FHM2aTVxfGDF34e1criycE5qL30bWA9A0S7U?=
 =?us-ascii?Q?ghUCkciRZpW5Etqp92SR+a1905zvv9y8Kb/AZpLVusExan5MVnBfFbnZh+Zz?=
 =?us-ascii?Q?MOAg9Hc/8e++IJ8keZdI8vpWqaJB7U+0jz/QucO9uGI9tF5JnEXmOcTkqPNI?=
 =?us-ascii?Q?ZbugcqRrMTk0mZrT+kKZffFdEXnfnhCtmI0uDn60P9NHz/cJh4mY2TJ2BiXe?=
 =?us-ascii?Q?WkFmL5H2CYUn0mRZSecWRPFarKQbP1EH/jVraqGL1yOqIHHkFh7yB9tD4ASx?=
 =?us-ascii?Q?y8o49gUs5ri4Cjny5R/GhxNFE31Fn/VZ9olMVP6t0yYGJVLcp+LLu0BfKGrv?=
 =?us-ascii?Q?DhmN43Nn3HOY4IEkG8UEj0G3Dnyn8mPQ2/CWOjcMcNPiAAedg/IxYCuQruWQ?=
 =?us-ascii?Q?J2yGHuU+mFyGGlhlZBB9ziOFX769Ly3eqzgSmbLkN6372gJRJUz6vZC5r03Z?=
 =?us-ascii?Q?VU4XR1wsYu1jGMBgu+a/y53YUVU4ct8ZIlrgzfyxAKL9Pv1RcsmCi8K5mSSl?=
 =?us-ascii?Q?B7imtMAJ8pYGiUUPW1WYq4fu2ukBIuErT99ffqyafkD9QMDt10VlvSdehqJT?=
 =?us-ascii?Q?UzabakQLBxVGiI3KDrRlzQSMJ858oye3EBKFdcYiktue56RzHuTB69Gz6r03?=
 =?us-ascii?Q?6d2cPADud7vQ01RgGAnC9lcDrDmqXRAF89xlxw/A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfd72f-8a9d-4d3f-67f4-08daf8a092ea
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:36:17.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3J//j35EFgC47br8A18OZ1eJoi+NT+du1gR7OiFLUslTAZR9xLB3peWb+LHB5/Yd82T2RN+HpiTu1c3r3dI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_073621_602515_B997C8BA 
X-CRM114-Status: GOOD (  15.41  )
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

This commit exposes ULP DDP capability and statistics names to
userspace via netlink.

In order to support future ULP DDP capabilities and statistics without
having to change the netlink protocol (and userspace ethtool) we add
new string sets to let userspace dynamically fetch what the kernel
supports. This also allows drivers to return their own statistics.

* ETH_SS_ULP_DDP_CAPS stores names of ULP DDP capabilities
* ETH_SS_ULP_DDP_STATS stores names of ULP DDP statistics.

These stringsets will be used in later commits when implementing the
new ULP DDP GET/SET netlink messages.

We keep the convention of strset.c of having the static_assert()
right after the array declaration, despite the checkpatch warning.

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/ethtool.h      | 43 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ethtool.h |  4 ++++
 net/ethtool/common.c         | 21 ++++++++++++++++++
 net/ethtool/common.h         |  2 ++
 net/ethtool/strset.c         | 11 +++++++++
 5 files changed, 81 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 20d197693d34..1783a4402686 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -477,6 +477,49 @@ struct ethtool_module_power_mode_params {
 	enum ethtool_module_power_mode mode;
 };
 
+/**
+ * struct ethtool_ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ethtool_ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/* Remember to update the enum below when changing this struct */
+};
+
+enum {
+	ETH_ULP_DDP_RX_NVMEOTCP_SK_ADD,
+	ETH_ULP_DDP_RX_NVMEOTCP_SK_ADD_FAIL,
+	ETH_ULP_DDP_RX_NVMEOTCP_SK_DEL,
+	ETH_ULP_DDP_RX_NVMEOTCP_DDP_SETUP,
+	ETH_ULP_DDP_RX_NVMEOTCP_DDP_SETUP_FAIL,
+	ETH_ULP_DDP_RX_NVMEOTCP_DDP_TEARDOWN,
+	ETH_ULP_DDP_RX_NVMEOTCP_DROP,
+	ETH_ULP_DDP_RX_NVMEOTCP_RESYNC,
+	ETH_ULP_DDP_RX_NVMEOTCP_PACKETS,
+	ETH_ULP_DDP_RX_NVMEOTCP_BYTES,
+
+	__ETH_ULP_DDP_STATS_CNT,
+};
+
 /**
  * struct ethtool_ops - optional netdev operations
  * @cap_link_lanes_supported: indicates if the driver supports lanes
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 6389953c32cf..cf26c082b1fc 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -681,6 +681,8 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_MAC: names of IEEE 802.3 MAC statistics
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
+ * @ETH_SS_ULP_DDP_CAPS: names of ULP DDP capabilities
+ * @ETH_SS_ULP_DDP_STATS: per-device names of ULP DDP statistics
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -706,6 +708,8 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_MAC,
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
+	ETH_SS_ULP_DDP_CAPS,
+	ETH_SS_ULP_DDP_STATS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fb19050991e..f79e510d671e 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -5,6 +5,7 @@
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/ptp_clock_kernel.h>
+#include <net/ulp_ddp_caps.h>
 
 #include "common.h"
 
@@ -465,6 +466,26 @@ const char udp_tunnel_type_names[][ETH_GSTRING_LEN] = {
 static_assert(ARRAY_SIZE(udp_tunnel_type_names) ==
 	      __ETHTOOL_UDP_TUNNEL_TYPE_CNT);
 
+const char ulp_ddp_caps_names[][ETH_GSTRING_LEN] = {
+	[ULP_DDP_C_NVME_TCP_BIT]		= "nvme-tcp-ddp",
+	[ULP_DDP_C_NVME_TCP_DDGST_RX_BIT]	= "nvme-tcp-ddgst-rx-offload",
+};
+static_assert(ARRAY_SIZE(ulp_ddp_caps_names) == ULP_DDP_C_COUNT);
+
+const char ulp_ddp_stats_names[][ETH_GSTRING_LEN] = {
+	[ETH_ULP_DDP_RX_NVMEOTCP_SK_ADD]		= "rx_nvmeotcp_sk_add",
+	[ETH_ULP_DDP_RX_NVMEOTCP_SK_ADD_FAIL]		= "rx_nvmeotcp_sk_add_fail",
+	[ETH_ULP_DDP_RX_NVMEOTCP_SK_DEL]		= "rx_nvmeotcp_sk_del",
+	[ETH_ULP_DDP_RX_NVMEOTCP_DDP_SETUP]		= "rx_nvmeotcp_ddp_setup",
+	[ETH_ULP_DDP_RX_NVMEOTCP_DDP_SETUP_FAIL]	= "rx_nvmeotcp_ddp_setup_fail",
+	[ETH_ULP_DDP_RX_NVMEOTCP_DDP_TEARDOWN]		= "rx_nvmeotcp_ddp_teardown",
+	[ETH_ULP_DDP_RX_NVMEOTCP_DROP]			= "rx_nvmeotcp_drop",
+	[ETH_ULP_DDP_RX_NVMEOTCP_RESYNC]		= "rx_nvmeotcp_resync",
+	[ETH_ULP_DDP_RX_NVMEOTCP_PACKETS]		= "rx_nvmeotcp_packets",
+	[ETH_ULP_DDP_RX_NVMEOTCP_BYTES]			= "rx_nvmeotcp_bytes",
+};
+static_assert(ARRAY_SIZE(ulp_ddp_stats_names) == __ETH_ULP_DDP_STATS_CNT);
+
 /* return false if legacy contained non-0 deprecated fields
  * maxtxpkt/maxrxpkt. rest of ksettings always updated
  */
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index b1b9db810eca..6f71ee24c786 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -36,6 +36,8 @@ extern const char sof_timestamping_names[][ETH_GSTRING_LEN];
 extern const char ts_tx_type_names[][ETH_GSTRING_LEN];
 extern const char ts_rx_filter_names[][ETH_GSTRING_LEN];
 extern const char udp_tunnel_type_names[][ETH_GSTRING_LEN];
+extern const char ulp_ddp_caps_names[][ETH_GSTRING_LEN];
+extern const char ulp_ddp_stats_names[][ETH_GSTRING_LEN];
 
 int __ethtool_get_link(struct net_device *dev);
 
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 3f7de54d85fb..2818e1f0687c 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -2,6 +2,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <net/ulp_ddp_caps.h>
 #include "netlink.h"
 #include "common.h"
 
@@ -105,6 +106,16 @@ static const struct strset_info info_template[] = {
 		.count		= __ETHTOOL_A_STATS_RMON_CNT,
 		.strings	= stats_rmon_names,
 	},
+	[ETH_SS_ULP_DDP_CAPS] = {
+		.per_dev	= false,
+		.count		= ULP_DDP_C_COUNT,
+		.strings	= ulp_ddp_caps_names,
+	},
+	[ETH_SS_ULP_DDP_STATS] = {
+		.per_dev	= false,
+		.count		= __ETH_ULP_DDP_STATS_CNT,
+		.strings	= ulp_ddp_stats_names,
+	},
 };
 
 struct strset_req_info {
-- 
2.31.1


