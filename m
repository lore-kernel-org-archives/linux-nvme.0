Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39041CD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	Content-Transfer-Encoding:Content-Type:Message-Id:Date:Subject:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ncu5t36Rod2R6b5mp9ZZJmHAVezXgYV3dEWrg/vr8lw=; b=utFOSWuXlx9P9YKe5Mt0sEVWM+
	xOY32SI5gkilFT6doMdOqsUHYxOo5AvIvdG4tdPODNfAHxKLEj4V89qcflVWDQmQ41qQXQRDGeohT
	WYI6wOdk8GZrnRAhVdMYyMzXpvtGRJ05Q80K3ZUvEcD7o+3d2/MXWEN3IBKPTLYEHjtEGr0gHZDBX
	J0DWz6U92m4fr1PMV+bmfwi3XXpM9FLt+Xj/yKgsNVSdt5ECAies66En9CQ7RFgqBKqBzSjGXQePL
	sFoLDiTQro85nfkzU0eEZY7xe/OJq8YTPeNvXCHmb59OoQ5TI7gX8EDFEzCuIySeAMGd47ifYAyda
	6SEaYAFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKj6k-000000020iq-0p7l;
	Wed, 06 May 2026 20:44:38 +0000
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKj6j-000000020hT-2hur;
	Wed, 06 May 2026 20:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTzq1/QHI2hCTHCmUOpAyJbNTj1JgFH5XES7t/AfwQZVijX/3epFPLhsaxLE5wZxp2Sgu1KbqJkkhSt7aMdZxABF24FQCJf/pahxghLW8Sn1YvfyYNkgXaX2qNDrWm8zQlnU9DAMpwZKoKVwTkcw37ZfeG85lFEH+16cM6fVLp0ZqU9rLwH0D2pZE9Tfoy5xn6nsiPB/odLytuV1iUfwhMyxDdjppsKDKNcoI7/WrY16gwVTvcyWmC/X+mwLkORozR40Qdqtbig9qGMRTGY7bi0HjEX1foJHYwTjYomzlh2fV1YZsuMOYnCTpmHhxlgor7FXplfmIOgnYdjfE5JKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ncu5t36Rod2R6b5mp9ZZJmHAVezXgYV3dEWrg/vr8lw=;
 b=iOvjYW90Amp+uEZ4dWf+TSCajtE8gEvHzbGsgoBFhyAi37UawnVNSKc3hHcBICyb+sguiHMozRPjiLBMJjrke5on17KUWzlCqJQLajj4JbWN83N8qUoQAtsE1fEhiJfGae4l7rJR9l1S5pPEQhfccpI7kmghx14h2XMQYMmInBRXOxbeAs/fQXO/DTvUUE0SMIVgEucClbz9+RLKranqOimCKFBHl1S6Gsf5aC2+pHAnLRMo5NC/4ngnmNiONwZ0y6oAvxgWjJaVzPjvPgiGjGpkyO2yNypHxxIM25dcg/xzWtYqjhY96Ff+OEOwLQSz/dy7vNgmXCy0hNuDJOFtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncu5t36Rod2R6b5mp9ZZJmHAVezXgYV3dEWrg/vr8lw=;
 b=U3MtKphSTyoE0+dENN24EjTt4sVn8EMkyygYhD/Mxz66Uqf9PDzhdP+BvFHof2nNulQMXYN6jRc596J4f5JVQk2FM0qU5sS9enwsUFCR2dauSNk3Xq5NLx81tmwVTP70mmRrPT+7ogPWpUMjpLsv57gE1DV6K39CjtMF2HCzYZD8MjeJYHqENuG9h/Pel9/iK4+KcddxgMGI1M7DYwz0B/HXm39Nxf3XQgybRCMKV3CkPBKBTWHb5Y5UJ7SLxYMVOV/WaN4hMDI/w+Q3uvjmmKmhLoCW7RSnKVK5xq5sQaLtr/9WL4EsP1HAlkbJEHmpK/yYwz/Xm6uUu8a80qfllg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:28 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/9] dmaengine: Add new API to combine configuration and
 descriptor preparation
Date: Wed, 06 May 2026 16:44:12 -0400
Message-Id: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByo+2kC/23NSwqDMBSF4a1Ixk25uXmYdtR9lCIhiZqBD2IRi
 7j3RkHaYofnhu/PTAYfgx/INZtJ9GMYQtemIU4ZsbVpK0+DS5sgoGQIgrrGFH30fWG7tgwVVVK
 wHBwKaZAkld7KMG3F+yPtOgzPLr62D0a2XveWPrRGRoFKLi5gpWceza2d+rPtGrKWRvzS7I/Gp
 C3kkF80Vwz1r+a7VsBAHjVP2mihgSssncCPXpblDe/0BxsoAQAA
X-Change-ID: 20251204-dma_prep_config-654170d245a2
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=3149;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1QDS7yalgH2vXGPIIRGsyPJsCl51h+sJw/j4GkUhGQQ=;
 b=kAOgIhphFrp720OIy2SnK9em0kuGsw1Hs/tzzu0Sw6s3snRyg/EUwfSeAGtoLokAkpExeXDue
 zKrWSLFDZ8fBZSnvactMtYp2sZXM8k7DGzRYYmvEHG5VNskZAArEZWx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3aa655-ba8a-4c4b-ee05-08deabb04450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info: igPjOrxJLH6r613vpEY1gH26abxQ3DrSOvf76GyWCiG9dCnhi6y8jCshQFPyPuJQ/kGHA3/iSPO85e+U4lUPMXWDegOBYqathh1Yp68C7ZpZoE5LW88So0QyOuruLghMrXs2RsCDosj8F1XskJMKX7wuSiPKTEWFZJ6R/lCdIq1KMiB2MiiZEAEj0lB5KIYKqRcrsKCH7iB0l3hcA+nndI8qYorGGWtwgeCHpiA0FTTdcgR2taejBhTSv36YFDranok2+/cNwK6tqiKmRM7q07caAlPpP15/NJHt8KSCrX0fh8ySsTZpkh16CzRc9Ilz4AzXPWYv6chYXKD/Xc3LUT6CB0deTP2eDeYSqj/pZyo7m7oUO9zRho5hZWk9OVFIC7VchVY23yVfP3+1vxALA+165vVZgIsZsJMD0MRohFGUjqlNYt7JNJgLfBL3i99YCr6vJvug71IU6Jk5c3g9GOAK/LG6RimDkNNeRjxQ9CIWoL+d81PXFrwuOgkVkRDvhzbTTvIoPp+nSUvJvkuapYLDtENTA5heH38xaH0od4P4mgWvqmhtJMvw6BaN3ExJcyEUL+8CCxBpUTMuve1BLPwif7fkittlSaZ+iYlDFUbbUdz9aqxN7Rg4gfhJVCwH3nq/4L2g7+bvbAB85J3CUyTsYrfCCtSJ2UIjvtDDcq9eN0Ombo6qqCKt3QDQmzSoe0GD+D9o4pkthV9VGONEwk79xOeFfNAfrn8M3+rTy5CoYWlrMrjcW3orpQGGI5dU+ZXjJGMaylM/pqeKSRr56A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHk4MU55Q0V0cElOM0JETTk5YnZoM2N0NUZHUW9pQnNsYUJGVEhVYlMreTVK?=
 =?utf-8?B?QXYwd1lkeHZxSXhTb1UxbFl5QXFzaW9VRCtUb0Uwc3ptU2JzdENGZlkwalJs?=
 =?utf-8?B?ZW5xMkF1NUx5b2Fhd1FlS0VLSVU4Y0FKRVdmbVdsd3FreWhZK1NOLzd3Nk5U?=
 =?utf-8?B?c1pUUUlIZnMrR2Y3RlpGTzZkMC9wcmxUZTNVU2E4bnIxWFNtY2NBSy9UQm41?=
 =?utf-8?B?TEZQVURwc0tPalBWdkVOREVsTlhCeEo0aXpOVXZWTXpQL0FRTFk1UVc0WTBQ?=
 =?utf-8?B?MVNlczYzVm1sMjBJc2t1bXJ1bXRuTWNGSCs0S3hGbW9GNFBOdU1YajRmVDRp?=
 =?utf-8?B?VWVtbWUzNE44Y3hYMkFVR1ZlNktmMjVTOU5rdVRTNXp4WlBWYncrSDkxbUV5?=
 =?utf-8?B?RnduWHZKa1JabUF1dlMwYVNEbEdkeWpkei9oNmtGVktCMGxSS3dmbGJHUDBm?=
 =?utf-8?B?NmZMQWZHa2ZmUDR1SHNoZVY5bERQRTlOME0xZ0liZDRCdHBndTFQMnpndVB5?=
 =?utf-8?B?WG8rcGNvNGZWcm40U1BjM2NHMEt3bEVZYVAzdWJ3Nm13U0JtOFJVSzlFVitk?=
 =?utf-8?B?VXhNQkJvcW56NEY3b2tXb1RQOW9LMTZtSGlGY2J1REhyRE9nN1FiN2djdUt2?=
 =?utf-8?B?NHpqNk03OFZxYk1kcFo1Y2lBZE9MaExBcFBzWTh4aGowUEpOVENQR2c1c1NB?=
 =?utf-8?B?dnM3YkdEbTh2Q3plM01VNzRCVDZwYlN4em1tbi90aTJuRnY4WEFzTXVGWHIx?=
 =?utf-8?B?eHhwNG1kYnJqOEo4L0dyc2hnZmRGdWZuZG8vSUFZQ3VraEtpMkxKN200QmpW?=
 =?utf-8?B?SkF1WkdXeUFBSU9ZZXJuckR3dmdDd2lJTkJkdEdFODgrdENwYmw5dXpiUUhp?=
 =?utf-8?B?Y1pHZmZiVmN0SEpseHhKLzJGVk55bkRzZWFyOTJmakhUajV6bWwzeUtJUTVm?=
 =?utf-8?B?UjZwaEd0dC81OWJwaEd1OHI0dzdQbG1UV2k3ckQ1QzJHVjRMSnIwNEp6Qkpp?=
 =?utf-8?B?b3NydjFHZVliR2pMOWt5SVFkVmxuNUlTbDFocnRmYW1wNERUSmg3Z1VPdEQy?=
 =?utf-8?B?ajRnSW1qY0pwTXRWNkNWRWt6V0dMaGMvTmVzZlRaK3ZvYy9jelZPM3FCUEpV?=
 =?utf-8?B?Y2djdFpTZUszeVBCZFhFZUp4allSSmJjSHdVcmlobkVPclVBWWlyNHY3S2FE?=
 =?utf-8?B?SnVaRS9RQVIvR05DWDlpYlRna0hFWjdJYS90czNtK3J5cG50UVZGejNoVjJ4?=
 =?utf-8?B?VjcyaU1WSmg4SGQrYzY5RWR3Rzg3TXZCYWM4K0c0bDBPS2FtQWt5WWg5bDVv?=
 =?utf-8?B?ZVpaYm5VNS94UWZKY1hOTEhaSmowaFAzcEVMRlpqUHFEazNZSzV2V1hVWW1x?=
 =?utf-8?B?Qm0zWGM0RERJM3czcG1DRmFUN09pVU11Y0QxRExncm1IdWc1TGtRNzFHWG1Q?=
 =?utf-8?B?cEd0eDVEZ1IvamFTSFBSd1o3QzlvYkdjTWQ3S2pMcUl0bHoxaVh2NzByVVdy?=
 =?utf-8?B?Wkw2MWl5dnFMbVhrNW55eWdyRGRyZlVxaUlLMXRLdVExOFYxaUZKbEszQWls?=
 =?utf-8?B?UE5KN0V0REZVYlNxQWhhbCtReDdvaWlidU93Y3ZXdmV3QStIREUybDFTWHVU?=
 =?utf-8?B?d2ZJblBsR2NqV2prUXFOekdKbFRac3prRUhoaU5QTUtRL0diRzk0d0FxcjZJ?=
 =?utf-8?B?QmliUjh1YkljS2VaUnJHSEZSWkJ4dm5xdEZBWGdIUUROMGQvdVNVbWJ3OC94?=
 =?utf-8?B?dHp2TExaUXlldjBDNWdFT2hhcWxENm9rcjd3dHRmUlYxc0Z4RTc5THVXcXhT?=
 =?utf-8?B?MERjdUhPd0FBZDRZY0h3ZHNxSDkyZ3hnR0l2eHVoekg2c0FXeEhkaGZlbVZQ?=
 =?utf-8?B?UWw1eUZTUG83UUREc3JNOEhERkVXR0xSQ1oxZktRV2xFWEVWb2FUZUNpanA5?=
 =?utf-8?B?QUVKMW1JOHdYam5hTFZtM3ZSZzZkUTZPZmpKMlpuN2duaFZtb002WGV3M2kx?=
 =?utf-8?B?cmtHVk4yTlZSQTJmdkxBQXpialpWR05JSGZKZnlMSm9ON2FEZlNoZDNkVjZJ?=
 =?utf-8?B?K1Bwajc1MzIvT05vekhudkFBSXZCNUNocXR0a2d2enlIcjFSZjJrQUR3bDBW?=
 =?utf-8?B?WWk5a3VqcFRtelVONGpzNlMxVG5UakJITkQ4OStROGYyb3kyVVFBTldYeFhs?=
 =?utf-8?B?ZjJIRkJlODhobGt3eXA4aU5RbXN2UGtuSVFHaEtmdHBJTythdjYrUVM0OUpw?=
 =?utf-8?B?R0h5M0x4OTJBMkx4ZURtS2tCUngwcVZSL0ZZcWdBUGhxbEVmSmExbVdrSTJD?=
 =?utf-8?B?aFpURmFQTmJzazRhNnpQbDJBeG02RG11QlgydFlwbTUzR1RRWDVYdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3aa655-ba8a-4c4b-ee05-08deabb04450
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:28.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U8ip3M43oZPyDHbBne3ob64fYcUCG9ESplXlzYabktGegmt/e5hkVrzCumOeMJa432ZKSOXpSF1WRE2iSyTpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_134437_707311_1709293A 
X-CRM114-Status: GOOD (  10.73  )
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

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose.

	if (dmaengine_slave_config(chan, &sconf)) {
		dev_err(dev, "DMA slave config fail\n");
		return -EIO;
	}

	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);

After new API added

	tx = dmaengine_prep_config_single(chan, dma_local, len, dir, flags, &sconf);

Additional, prevous two calls requires additional locking to ensure both
steps complete atomically.

    mutex_lock()
    dmaengine_slave_config()
    dmaengine_prep_slave_single()
    mutex_unlock()

after new API added, mutex lock can be moved. See patch
     nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- remove void* context in config_prep() callback
- use spin lock to protect config() and prep().
- Link to v3: https://lore.kernel.org/r/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com

Changes in v3:
- collect review tags
- create safe version in framework
- Link to v2: https://lore.kernel.org/r/20251218-dma_prep_config-v2-0-c07079836128@nxp.com

Changes in v2:
- Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
- Add _safe version to avoid confuse, which needn't additional mutex.
- Update document/
- Update commit message. add () for function name. Use upcase for subject.
- Add more explain for remove lock.
- Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com

---
Frank Li (9):
      dmaengine: Add API to combine configuration and preparation (sg and single)
      dmaengine: Add safe API to combine configuration and preparation
      PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
      dmaengine: dw-edma: Use new .device_prep_config_sg() callback
      dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
      nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
      PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
      crypto: atmel: Use dmaengine_prep_config_single() API

 Documentation/driver-api/dmaengine/client.rst |   9 ++
 drivers/crypto/atmel-aes.c                    |  10 +--
 drivers/dma/dmaengine.c                       |   2 +
 drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
 drivers/nvme/target/pci-epf.c                 |  21 ++---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++-------
 drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
 include/linux/dmaengine.h                     | 121 ++++++++++++++++++++++++--
 8 files changed, 180 insertions(+), 84 deletions(-)
---
base-commit: b9303e6bff706758c167af686b5315ad00233bf8
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


