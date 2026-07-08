Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEF5C44501
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxheSaLiwGk/Z55GRV8TcDjvGiFBVTuuLT0jCpc35Iw=; b=KeTY9HZjrCyXWy+xQbe8JWERT+
	U3i/HcKYvfzlLpBEXwJA4EweVDZArZdg0TlHuzsYehgZ2551vxTRida3fMHUsp4H3Kp92U9/Gm123
	srGPGcYVMMvbpqxh58mlWcsZhtK3p3auRLe94HDZqbI9SfFddaTS5ozEuBYiXo+8Vk4pg/6w82t4t
	0cDGQtBJ5AotgnipbyZNfpfoW9pPYuw6eCCsbg4fMM6p0929kDawPQAnwroWd+lRr0UueJ771DUft
	QtnxYF7rck8f2yiYex9rP2ObyKEx2pVtTT1jF0exv4Nqoc53Z3LSP6QK1HP4VGKTlPHE420FejieN
	Ufq/vl6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX7a-00000000BSs-2EuQ;
	Wed, 08 Jul 2026 18:35:46 +0000
Received: from mail-westeuropeazon11010031.outbound.protection.outlook.com ([52.101.69.31] helo=AM0PR83CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX7Y-00000000BPl-2PWS
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 18:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAMO0DpXSEGi8+dgyoAlymNIIOlSyeFFMksS9JlB5+rZVu4Q3t5l2FknpHocudfgmjxO5Pg8lwPu1ltrxNlgkYj0xh18E51HhwbMcJgRIUo0HW/ip69yTfsbRCI73w4VXtcG5gARDt+50GdqrpNGEEbTv+lgfBMfA9uEK9J+3dCtsas3IlDVdkDizug0eoFLJQob3P6wcAIkbK9u3ETM5RHVphgPPT1eql83Fm7ke8NT1vIAQ1GuSNlnrRj4QLTu8pHyIAa9H+rx9vIK87eCEbylVsA4U7ObCAcxsyi0xdVeW29ghNp1kv/m9dF3LwfcUE2F12f5Q7OLURB9mwgUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxheSaLiwGk/Z55GRV8TcDjvGiFBVTuuLT0jCpc35Iw=;
 b=lbwXN4iouvKdvECHS8uoi1e9oUTAqg9lW8GTZPYbb7jYIBjCCDYv++8z7kP6auF+ekN3bkISUBz+V2eHCejl3t8o+Fc/yHmHd1lyKbi20YkPxc7cDWqR3V4PopJW0r8Ir3r6FcIAhXsyaY5kqDnsjGaU0RNwyMxB25cU0TVEInVuuq9uCxmqSPF8PLKYC9NmMXc0SmLUmzC4okvZmjqfWFS3bBl+TYhZ9LpNg33a3ZlJ16wEtWXkGTwWzv71ftW/L7MmHzKeKzLjWeEQWp+RsgF66a93LGP4ZVvfec241tkNEiPnhOxFpGNUzSOTbHBzL7/pTeImID8bNtzHfm2lKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxheSaLiwGk/Z55GRV8TcDjvGiFBVTuuLT0jCpc35Iw=;
 b=SHMXa9Nh+Q3Tk/KjOReFCLUrRi0wmeBuLrQPWbmlHvjgMNlNL/JueL8QJEJPbFbfMxA4DF5e1inrPHiU7iu16Tjloaoqxin/waEMzv2uV+BqRTWPDknrm7Zhrcro7Azcmz5Q1k2k1yX0/cR1esbH6jsID3Lb2LKgQ3KcPylaYds3FEj1kaHsByfvqUrgBEHbylLS918CFLZge8br7k5YxzjDACSey982orsY9DOoZ9sN/YACXGdA704hPGaCSBhziFR/wHsxK0WyCVQVO1AswHSyVI7eX3LhtTj5PU66ciT1pT9hitBvvNomt4o7/hxkA2tYFTw8YkyKBeFxVh3sEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:39 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:06 -0400
Subject: [PATCH v4 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-6-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=6410;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nGpsMS8wEDHjpy4/wW160YouUvzq4Rld0wqWY/q9z50=;
 b=j5zj071oh6jkgQs+koi79ixR+77uJWl9yQsKWvSfnAUddNsGdadDGl24ITy9F7Pgf4As/PvZS
 bSBfFhQwUI2DnazeC97joR3bH79xzZbOCWr0EDNlTSzocRzAPfyMIY3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0136.namprd11.prod.outlook.com
 (2603:10b6:806:131::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: db46316f-f69c-48ac-bd16-08dedd1fb5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: MXmjf0mj+Ai2LSXh7cDPE0lMJKr4VndIOw9rykSfOE+4FNp2dBIxu3mrqXZBDTOyi/xXwQ8J2plJbSoomOm/OGlClzl5jbuznjSA24zwhGUxRUfTHXLvX7yVDpXIfJc/cwWRzpqLmWZvITBIALtSlOF6+gttVd3kP87NQHsvJfrGHN3kzeQw+Arh52A1AxN3DwBTMoUlC+KYTdqMRXy+3g5GMesf56vInECAGgvwNkUCTfQ/x7uNJNuE3tqzs1SmPCZ4vXPQrdk4OFxS6WNJfZbV+Uo/tGIxdQla816zH7SsF6Jsyn2x02XiLdvS7SG6OHFn5NVQv8HTLnA/A0Tl2YHGlbrOBblaQAJbuuahG7v4tqrHEBGu5iLyRwTl6PMoNepFQjLVU0RTDX38rLubp5HtW3pnPErc3naChPilcQwn5cPJPc9uqJL6oS+ijl3Wo9pCKp6wsJW3BYgRv0NdilfaJS/HK2jN7D1jPvubBCBB50KuM5+Eo8VS4pDMGHqxRx5rh1pc3HLL6MLp30tCYFYG9sarYrveDvUBrXNuzCItfxaNem8Bd2hPMRRxibLxfqd+qMQxSuQaMp9uTlmhovkarHhSC95u0dKeUchM/H6oGQROnEmIY4Fajjq6NhezNomzyLyScTc3E8f296PTkdnFxtMs6CvirXqFnF3a25YVfhVWcoa7E4RR2eQtioQGDBjUH1GS6sN2LJwe2FV7QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBIb0s3UkJMSXhXY1BWYzFkOS9kRnRiUURVWTkwWWxLYmFvbEpYN0V4WnNG?=
 =?utf-8?B?YmQ0Y05TZ002S2Q3WWl6bER6L0V0dGdHUGI5dWdKa0wvcW5Qd2RyZjhtSGM5?=
 =?utf-8?B?NVg3ZkRyM3poOTdxc2F4TGVvOThLS3E5Zkd5a1ZlelkvY1BkTG5lbmpuM3NG?=
 =?utf-8?B?Z2ViTi80T0FVOHZ6bHE4OWlzcFkzQnNiRENWS0FGNDJETU1XajNWNnh4dVZI?=
 =?utf-8?B?SmNQQWZEdlpZVWU3b21QcWF4clk3cmF3TmQ0cVdWNVgwUE9UaWxXQkVMWjNR?=
 =?utf-8?B?L2dmK1ViQzZMVzNQOUhXaWJaWXdsSmIwWVVqYlRIMzZPekFnaHc5U2Y5YXBw?=
 =?utf-8?B?Skx4aHhGdVJjTTczSlovcmN4RXJPSWxqT21GbXlpYTRQak16ZUlCWThpZkhV?=
 =?utf-8?B?WjZSTGxRa0pIb0NTbmZsL0NoSCtna3hyaDI0KzBEak1Va3hic3BXYXlGbm9K?=
 =?utf-8?B?aDZrMGJvNXFXUnFhdTB4T3RtSC8vbkRZRE1uT1F1SVJTK3B6d2xURnc2QSsv?=
 =?utf-8?B?b2hhWk5HSEY1Nm5UMlZHTmpLdEc2NTBOZmVXZmVHTm5Weml1ZFFVMUpId2pM?=
 =?utf-8?B?S2FHc2hibS85T1RvRWdSeWdJeW9kWVpBTytlRmgyMTBvR3Y0NUJYUWpFcjFI?=
 =?utf-8?B?ZzhqM2k1OXJHdmIybXNKNDR6M0VzZzg3R05PRlBVSyszanpkRzBRYVJWaklY?=
 =?utf-8?B?UHNqTEhncTR2L1pBRVorRldCYTd6V2s5eEhvRU9zSUx0SXR4M3FjY0FZM1Fv?=
 =?utf-8?B?YU5BWWpRc1JtUzlocnR2UUNMbnNZTVdNeCtZY0NQN0liTHlhYmo2ZHlZT3BV?=
 =?utf-8?B?Qmc4dUZxd0FWTXZsei9DMUZubnBoRk5hTnc3OHhpYVJNcjd1d3BkaERROE95?=
 =?utf-8?B?RENkUTFNMGwwK3hqMWdrN3RyWUhZNDV1VkcrbHAxVFZSTEgwK0VlVkR1d1o1?=
 =?utf-8?B?dGlZZy93d3ovNjdQVmJ4d3lWVm9TRG5YaitCQTlNd1A5V0QrOFhrSUJwY01O?=
 =?utf-8?B?cjg5NHZzUWJiMHhWdEVxUmExaWRQRUd2VTIxN011OEJnbHVqSmVOQ2dvSVc3?=
 =?utf-8?B?UVBnVk5BYmhGMFRIaVcwR0Z1OGljdGY3T3FueEJaM1Jjd1B6Rlh5TndzN1FC?=
 =?utf-8?B?Zjk1c0NNcncxWU9meWpQWTRiTWVXckdhSzM1Sm02YmVNdWFaU0RPRG9zZ2tP?=
 =?utf-8?B?TkFqbHM3K3Z1VjA2LzZ2VjQxQnRUSDVOTU1vU0JlV0UwQURFNG1BZEtPRnhI?=
 =?utf-8?B?cDRuRFdKMk9GQ3VSck84Z2RUR0hzMjJTY2pPdmphN0M5TXFvNzN3ZXVyZjhk?=
 =?utf-8?B?L215N3ZMclFQOEdkcXVpcDVZbllwZ21ZQ1ZKZms3NkJPQzNpNHJMdkRubWxG?=
 =?utf-8?B?T1AxSGhTVDFvYlF6Yk0vbXZRallLUGlJaUUwaUZGb1ZnYjVjdTBVN0RzMWo0?=
 =?utf-8?B?YVFEUGlSbGllazZ5bUFrMU1uaU9lRi8vQi9sVTh4OFB4MlpveVZucDJzOUNS?=
 =?utf-8?B?b01Na2Q2bVFYZ0EyT0c3RlpuMURLMUJ4QWx6NkwyUzNxYXljSkwveUtaYXB5?=
 =?utf-8?B?TUxhWS9iSEJJMGhWSm45eG1ZZWF2YWx3bjFiSThRb1l5aVZqRXJDY1lLOHRm?=
 =?utf-8?B?NFlHVUYwUXNodDY4VFRwcElOeWpFelZLT2E3S1FveEZqOCtSeDlvYk1ZOCs0?=
 =?utf-8?B?MHhSUG1QVHNyc05EOWY5bGlrb2VUeVhGbGd3MklVZ1hLc3Z0bUxQMTNpZGFZ?=
 =?utf-8?B?RWI1dHFFV2Zlay9xdHJlY05pWWtEZTFDMUw2Y3RYenhjM1BJamJqVUk4WFZB?=
 =?utf-8?B?VmIzaDdXTHp4Rlh0OHNXRnhJR3M2VEduYVZyTFhWalpieDhsQXZuSVY2M2VM?=
 =?utf-8?B?dlZ3VWNiL0lGbXo4bFo1VEEvd2ZzblBkditRRnlEczUreVc5bCtSY3EvQXRL?=
 =?utf-8?B?N3pUciswV1lJdUpudWQ3Wm42dklwdDkvU1FFSVlKRFQvTlFvbVJLbXV1WjhD?=
 =?utf-8?B?OUswR1RxR1NsL3ZrclU1OUhaeVJQMExIZWUzVWVlQVF4UzlSd0N0Q0FuU0E3?=
 =?utf-8?B?cEY0L21scndVMkkwVTc2QWZ6YVFGRzdING5HTGliTGYzRHRxbTA5RW1vK2R2?=
 =?utf-8?B?M2p0Z0FVRVpTSWlPb2FJRVM3NnNNaVJ2YjFZTk5uV0NhbTNIZ0VFRytQcTdz?=
 =?utf-8?B?aldvc1ROOUV6S0cyV3VQaFdWbzhHVWpVQzhhM2xUMnRZOUxodEx3OEdNSHVp?=
 =?utf-8?B?ZFZBRk4zakwvTmZvKzloNnh4aTErYko5UGZtZEJrVGdBRW9SSTc5MEFHZUQ4?=
 =?utf-8?B?dkF3emRBSGU4UjIzMUZ0d085ampxZVAzcG5UamgvbFFwNjZUTnlwR0dvZmxY?=
 =?utf-8?Q?6mCZVza2ELQv5zGl2/ePLLg8c4CUXzxR2JkG4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db46316f-f69c-48ac-bd16-08dedd1fb5bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:39.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eklt6a4cxh6/X0g1LsErN2Km2QO+sj8MWrP/C9nZgQDtyVgs0c6ucEQYsUU0/zGi442wsMviHu4YG5sy5KeRps9M2vtYtjlbcLaVvfKJTM+4meb+QPf5F4kDE3+Aj4bS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_113544_629248_F285E480 
X-CRM114-Status: GOOD (  14.65  )
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

From: Frank Li <Frank.Li@nxp.com>

Introduce four new callbacks to fill link list entries in preparation for
replacing dw_(edma|hdma)_v0_core_start().

Filling link list entries is expected to become more complex, and without
this abstraction both eDMA and HDMA paths would need to duplicate the same
logic. Add fill-entry callbacks so the code can be shared cleanly between
eDMA and HDMA implementations.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- use argument in dw_(hdma|edma)_v0_core_ll_link(addr) to set link to addr
report by sashiko
- Add Koichiro tested by tags

change in v2
- update commit message
- use eDMA and HDMI
- keep inline to avoid build warnings. dw-edma-v0-core.c also include
dw-edma-core.h
---
 drivers/dma/dw-edma/dw-edma-core.h    | 29 ++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 38 +++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index b96089baf0f9c..bab4d49c92feb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,12 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq);
+	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	void (*ch_doorbell)(struct dw_edma_chan *chan);
+	void (*ch_enable)(struct dw_edma_chan *chan);
+
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -204,6 +210,29 @@ void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 	chan->dw->core->ch_config(chan);
 }
 
+static inline void
+dw_edma_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+		     u32 idx, bool cb, bool irq)
+{
+	chan->dw->core->ll_data(chan, burst, idx, cb, irq);
+}
+
+static inline void
+dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	chan->dw->core->ll_link(chan, idx, cb, addr);
+}
+
+static inline void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_doorbell(chan);
+}
+
+static inline void dw_edma_core_ch_enable(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_enable(chan);
+}
+
 static inline
 void dw_edma_core_debugfs_on(struct dw_edma *dw)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 8d38867cd9983..c0746e5351410 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 	}
 }
 
+static void
+dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_EDMA_V0_CB;
+
+	if (irq) {
+		control |= DW_EDMA_V0_LIE;
+
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			control |= DW_EDMA_V0_RIE;
+	}
+
+	dw_edma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_EDMA_V0_CB;
+
+	dw_edma_v0_write_ll_link(chan, idx, control, addr);
+}
+
+static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_edma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -540,6 +582,10 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.start = dw_edma_v0_core_start,
+	.ll_data = dw_edma_v0_core_ll_data,
+	.ll_link = dw_edma_v0_core_ll_link,
+	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
+	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 31bbdc6a40642..16fe3ef43948d 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -348,6 +348,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
 }
 
+static void
+dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_link(chan, idx, control, addr);
+}
+
+static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_hdma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -366,6 +400,10 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.start = dw_hdma_v0_core_start,
+	.ll_data = dw_hdma_v0_core_ll_data,
+	.ll_link = dw_hdma_v0_core_ll_link,
+	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
+	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
 	.db_offset = dw_hdma_v0_core_db_offset,

-- 
2.43.0


