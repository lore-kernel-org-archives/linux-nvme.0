Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFBFC021B6
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 10:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=; b=Df29ugp/kt/who0LX75/Ondbll
	xZlIs3pJcnOA4RL6XbTuNPqffKSVC4AL1tY7Y/Bz/wgG3RR9ZRO9TL4z/54ZWaZERiUxYjlAKDw0U
	PjPGF1L5E2yxO+EgiAbbPg8M3aua70o5VV3WIy9huRh0sGcCql8Y4JmWBLZ6lsQ+y37H1hJtCCBYf
	5TaVMVCiJAbcUExOg9sFfkGEingr1mKfq/mmWt7ffk10TFwC/8fyuq4Zw5e+U+KhZhdm7plVZNcxG
	BBZJb/jWzhLfq6rQUPZXxidVHlczOpgpHxucaOlXkSUu91N9hbQQM2LZp+yShnxCEGZNID6s24M21
	ML27CuVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPx1-000000055ED-0otl;
	Fri, 21 Feb 2025 10:08:07 +0000
Received: from mail-mw2nam04on20613.outbound.protection.outlook.com ([2a01:111:f403:240a::613] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPja-0000000521P-41e2
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 09:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkjzfPkTswKRHZuBBgSkNhFmu3Hbm93viHMt1I34VoAokZxi/ifTXrzlR/pMIR0tKsy9Lmr5LeFvuHXJI9IwRENHywJvHQKSbQnplkKsI7i7VAWGmU5KYEy9/Qwy229/8rhWlAkpd0I5cgKRJ93Ks5l/Spi3ip39BW9SzhYjkrNQEbzEoZM6CIuHDg0MYYAssRxn051aqZY0Nl0diPfXgAzJz7UOBIsq648G1Wo1hMZvKjUYSzWRlaliBRIAn7qkJVfy+7QYYW6Jan2KPWvQ0GXJ+4/OrpmmfOOeU5/IlqYynzaPOXiEF2TSagipC3dCvU455UAnny8We1e42q/lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=wczixyxKYTnHuF6UbG2Xzz/Hh0czpmQ7YJUDPnQtbEm+RchcMD2faWj/FIO6IEWyOMGckFSNQNxO5/DrdFnJ6iSIY9JVHbKtwgnnfZwQ/jhTRCFjsMO1xLhh5qq8KWWSIyFpuJaupCnG7FcyPEbEKjeTDQEYOWsVhrLRA/ir1QmWm4d7d1TO/m03lVN+tMDgEHqzKKfbLacpJIyRA9GiEEhY1KBdpRrtG1EOx7d5K6Dknofh9lL8IW4k2hXI9yQMNhCXyTEmM5Aj08AurUTO8D0/X8hNkWZKf3lzkrZUHM/iVbmQQS9XysPeY3AL+d3VINu14HyhLYVXFNMDIh1meQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=IAB6ZYtPCofXfkvK1M6B4lM8ifKNyaPQidRLF1X9NFA4WMFMVNTJpLw69ieLSbhhJg0/W1f/kESz3t8ymon0WY8vZGz4btu9NkmPz60pbGOJcWYop6VYGY5moLiESNSLmBqONZY+deMdc8KhsVllHlWg28DJstO1VaXdHqdwi+QWEChtVZsUmWr5I4HBgFFkDQMFyXAZwa2M9E+VqL47O2pHxCGKtDk/BRuosGllnFZ1CuEOnq6uQF6zfpRgVgIaLmkfDbpkQ3m2kkkhcsIey4NcOEN9yUwTkTujFXZrXrDIg03W6OT52SUKsOO2e8tgqWH7p3NDNH6InkqTDjSTlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:54:11 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:54:11 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v26 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Fri, 21 Feb 2025 09:52:22 +0000
Message-Id: <20250221095225.2159-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0610.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::12) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec50abd-276e-4e97-9dd0-08dd525db0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VOxlTIykQEl/LDlJPcj/1TbEWvaQQJUbTkwO+vIJHhqOl6L0LkhlDNPollH+?=
 =?us-ascii?Q?uNcpUytVLlPmDUpLUeYhQYE/KKGcTFhkb/pF4xYcTmVNwSGuGZiASYa2w+UM?=
 =?us-ascii?Q?5uMC92zQSgIq2TfBxkbwgbA/06tC7b2DFOwQcsRf0yXPppSdc6eYTvB5eKrs?=
 =?us-ascii?Q?nHStXN/blQfEb3UCAbj/i+frAgzO9DMYaT10+p0HI7yn/J2/7OCMbfdNRkUT?=
 =?us-ascii?Q?5DeLBxNbTh/E7o4zEZk4gRpvZRToDhCcd4RgwakZBp6h0xi+GUXmwTlfFR+C?=
 =?us-ascii?Q?Gvc81Mmud2xiMt7gFN8RPWGEfNs8pejjIcXuqqN59LO1JHajvkdIyRITMshD?=
 =?us-ascii?Q?9JdKmG77U26T4z4zkm5cwPegYgEHTYVHVJSVGPA/ed8miu6vZBpfKQDLex7L?=
 =?us-ascii?Q?bYUMBWWivw+4CtzeSxoroMHqvtH1BRR5HbiHiXM2CyuLRssmFDIkQ1MLapUI?=
 =?us-ascii?Q?2lO78PZ/S2aZG604clyPwJ/6WBWuWxz7KAKrkOG5WbQ/W/W1QTTHFJ+9keO1?=
 =?us-ascii?Q?Ch4SfqH5NPgl2JgEtYR+E9TnPBrKgT79bzgy0AlAqaSyrWpprSn4PKxGQaO2?=
 =?us-ascii?Q?qJqlFwG99Qi+GwJMQAVcXUURaIwRcoJ/EaiDmonBA1PfRHJX1YRKtlqr1jg4?=
 =?us-ascii?Q?OTzSyeUfS3iF/NxFk+/NNzz6F6br7MxZb4vXvYxWmn2i9mqcx85+8+c7Q7d7?=
 =?us-ascii?Q?hfHo5NNI0ezqsdotT38F2Utmj6/M9O/Rp8yLaKA6FKAgkMcP+QDWRI790x3A?=
 =?us-ascii?Q?qgzWTHmi0R3qG2kwaMq/CKKjOFeMboUvRJTefMZXh6E12zimjZv92ES+qkN3?=
 =?us-ascii?Q?nBDXN2DUdOgMC16E+5z7qDxxgGQ+uXUuWgO7MqtyGV1qySJkmenWwAzd5rpk?=
 =?us-ascii?Q?zEsYAi47Udzustfw3ibjD31zxGPvhns5iW0OX2mUiLWqQcoc3bYmXAJpvsEO?=
 =?us-ascii?Q?KGe1SXZ+A+KDMD7dZNSrRrZk9QiD/5Q9PmQeq4MjgMouJRqxqjoczvi8QZqq?=
 =?us-ascii?Q?+kkYP86xg5i4V1+QtorpXhYRBJmAuLUzGBPFnwknmr7nwgbMrtAiYed/yOhb?=
 =?us-ascii?Q?sbsoIE9E3DLvOwNhnZ6IIbA0FMYAPGDz32v7bDQcqwdtzaldy6bQ/1bn0hyM?=
 =?us-ascii?Q?7ihq4pROvICVT80fEyuKGL9aoSOHyp743gjhbNaIzoNxmyun8fXK21qCAtld?=
 =?us-ascii?Q?HHppSd5N5tq22D7BP8Bg+gC45XKrpDEFw34daUvNsH+dEcsaYm1PK+Konx2l?=
 =?us-ascii?Q?MrQEcGSEAQGKn4Q4X8UAZ11azlAjLvtSTHh3Y+iYp/v3FP4d4bp6zaGp4NDk?=
 =?us-ascii?Q?Nrktn0xg5W8Of29sA8bZ9xXXHJZ+q+eTXFaIxREM6zcAUfMLx2CgkeQsbaKe?=
 =?us-ascii?Q?Pkv9eKDmG1Vk+RS0xcaVPOhtawWL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q9JPDVe/SffWhcZjzLY15RqbbHqxYJTsJmnOz1iwHTw2H+Wd8ZkSbhgfy5EX?=
 =?us-ascii?Q?CzNdyFlwfZPWVBo/zNDQfE+zbP+9ONFCbO/drlSsHgvQ9uatoti2PmcAXNu4?=
 =?us-ascii?Q?nG5J2hrI7/5YEBy0VltczE+r/i2rRJSpznsN++0JEv9vHs+zgB5O4y+KE/Yp?=
 =?us-ascii?Q?6AXi8WXXkPzUNBcXvdm+3g+nhPio7ukVYjG4fneaznFvoH2x/mVZhtnaL8AS?=
 =?us-ascii?Q?Xep4y7ngcOYdB8Ra74xPCowYZ+v6a6x3T2D2DZxsaXI1F5keq6XIANWKF8Zn?=
 =?us-ascii?Q?EXCXqm0x94L4PmxcbNIRCR22sWWB6HNI0aSo7Heh/mDa6uIOdIIhPgh/KBAW?=
 =?us-ascii?Q?kLA+rgmioMYWejj8uOtythhZFOpkVGDt5EUF1GghxCMWIV2ALngWMAZUxABq?=
 =?us-ascii?Q?TioYef8PFT1SS37AqtNmwyzIoXcKC6duHxr0fJ6PjDl3tAb+HQ0v/7V45ILb?=
 =?us-ascii?Q?XVc6NUg3+KAsCzWXMmrVi5PQCEWvU1WCVRZJDNwcosuMV3ycXkKnKCkwMivZ?=
 =?us-ascii?Q?A1Ufq8+AuR9DCtn0zdlzUvONNyNpTrOOrV4ac0erePL8HyEjvNleOoKzds8U?=
 =?us-ascii?Q?Lxv4ue6GCc0uNUKNUhQjVDwXRHZPIhFXJs1wCgFm1/w75qLpC196nRIj3OiK?=
 =?us-ascii?Q?qQZErEwARe0mXmN/vv8jm++9Ys16d1Tz6jtYvJDfV30CAAQhbI4+g4cJ6s97?=
 =?us-ascii?Q?SNXeN8e223MTzh6QiB8v0UwcIcxyXoMilx8BcWygJ5ssr//KsUKg6heWtuaO?=
 =?us-ascii?Q?XKzcGdEc6+myzyQ8n2zgydbOb4eW98jDewA5i1vX8ubOrFo+SpMo7xi5eg/5?=
 =?us-ascii?Q?J3qBgYkAI6sFaGhCpvJFLp6S4Glv3Z2zYjfi6H8wM0jwZe20qtnlnSL+zQmW?=
 =?us-ascii?Q?fjLOmwt7iL3O1hjvDQA+KpZd4eoWosiXm5XfIWDz9QXaQ0YP+r7h7gj4kbWr?=
 =?us-ascii?Q?jTL4aowykYtZqQBmISwNv2RhYTai438nCEDWSt5wdpyTz9FL/4nlQBELc3vq?=
 =?us-ascii?Q?GxfmXUhb2yOf84LNaYDKseq6aWBj4s/8A14KNkI1xe/FgauEbi0R7UPlpUx+?=
 =?us-ascii?Q?XEQuMX4v+wgODb3X83XCPtpc5+syp9+EBvEMBmzegqSYXOehqzSBGHnjhcNt?=
 =?us-ascii?Q?p4UrLhKgyEXRcdHAohXoMnH4PMbZE6negONsf0rqEm5o8ly2XQUk795A8ZYJ?=
 =?us-ascii?Q?r9d4SkYZV5ps8KU91k339g+dWt6pScE38eWK4u9aaykJR+6BOWq7jgI4vI25?=
 =?us-ascii?Q?PbcI23/j19EXahtohuefTGPlzG/ld6Hhb5ewuwuiibv4SNyf2om5u65zX0DM?=
 =?us-ascii?Q?uUe1gXN1qf31USMCmfWKjp5/gnkkcKaJRG9q77QAhACEk9uUmUBZxeItGRiC?=
 =?us-ascii?Q?sc1u+maQSWLuYgu0vq1FRlMPT0rQybUP5xLs3+rKQHly7cy/npEMlgo5DlKX?=
 =?us-ascii?Q?fMCiPfVaO419KbpU8PUlv0hiDVKvD8dQb8yeJC0xwa9Qcf/dQBIL0QIOHC+Q?=
 =?us-ascii?Q?wPtACkokZUZdXweao4vrOciuZuPApXdlzwxt5K36ALbmO2F7fLyT4X5/IPBv?=
 =?us-ascii?Q?MHYeWkO7v2eDEaCwijUi2zGq3MCr1Nbz1tNNR+QD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec50abd-276e-4e97-9dd0-08dd525db0de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:54:11.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFKrqvmNIVrYPaNgrj+0T+c2cufrxjP/u2NQdxoBelk0EUdAK81z7NnpJnu8oSBT7BjxxO9JKskSBGP3ZScmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_015415_028787_E113279F 
X-CRM114-Status: GOOD (  25.11  )
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

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 479a2cd03b42..9b107a87789d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -719,6 +856,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


