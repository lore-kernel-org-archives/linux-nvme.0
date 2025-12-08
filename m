Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36ED3B7E2
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TRdCGT+eEdPdBw147jxorxPFEN3H52Xy30rmfdJ9byY=; b=mihJf44S3Atw+vFPER85u4NiBU
	dNBFPWefTL4bsRdmcGkpbDLgDTKpdEB6hhO9B8PEiVC+BQ+XOHH2D3r22lLLPXjE4mJ7NqfkdAjWQ
	9OUlTfrtQELy+ZEsRWmdWsYGpEEWG3n//pFaAP3Y0G9kpkloCBA9Kv7thYwoY3JvSCDDVC+0Ya3p+
	5/BYkKybbn6Cl2oQiKcpFUm6ESXCphPjyX+J2KejkAyP6rFAvezs5nfJOe4m2Ca+YxVVYXP4PpFdp
	QJgFsrSjLJaj5JuvjZX+VUks/ezEx2Uq1USdm709pP9U8w2mccb2s1ykrFRMgm56/Wbzl9rTLMTUE
	xJh1MW2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSeku-0000000DLeO-15FM;
	Mon, 08 Dec 2025 17:10:36 +0000
Received: from mail-westeuropeazon11011014.outbound.protection.outlook.com ([52.101.70.14] helo=AS8PR04CU009.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSekq-0000000DLXl-4BXn;
	Mon, 08 Dec 2025 17:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y46+LR1XUuv5RKM8b3pe3pNYXb+yJPZa8rq03RbN9I2N8x3hUStWYxGWaicb3rX6hgjrd3Z7AQAJJerWwsnZYKF5uvsHX85Vt/9M7sGBiyJ0nHvvfooEmsueEFpqjfAxYkNGIox0U9b7JIt9BuaShIZ59ir/t4YmcDk2Qg+O70kBjzuwhx6LYkEJe0UICGli4Zoh4CasLqomh6w4IYpgEP5piwSxK5QYAhQFJ4Ne79S/96SfhG15Vl4TWs9RK+qw0SVnb+3D/obP+An8fj0geHNp3iQtBPog7YCL/T2mM47u48e3UcL+dsjq/LJNTz93N4zqMc7aAffIrIYOdVeKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRdCGT+eEdPdBw147jxorxPFEN3H52Xy30rmfdJ9byY=;
 b=LO+Vcv8uYy+Ee81Eb9elwQqGv/HMbVV031MbppzCRIX2Pq3YEy2BIhsAXvCi/1yMBdWUxWH2G7QK4ATJ1BUDBclv733VNQLcFpyMNqGu8XhAsfFcWDsDHpZfqDtYCpWJAsW2pWTO5BBUma05qQHNl77N1QUR1pKgLKHm7f2AzmmbQkIJmnxKAhPxDrhH6TN3aLykZH2j5NbK2Z6AR3sKosKdAyMuRau4YmyCg6x3jfWHZjMsxjiPZssE8qXqA6lExnWFDPQIuDnzwHif78GTvgw+CN/uDtxfy1Ym4uYLg5W4JK962hLVr2RSrMRg9aA9JIPaOS2JcAIke5EjSBmZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRdCGT+eEdPdBw147jxorxPFEN3H52Xy30rmfdJ9byY=;
 b=IYLMs8t++TxL/inpQVvpwP8Jw+m2SnbhWXfgGBH8lYladBk5gLVGKqiqgzLB3abSE4D0yiktSRHhodVTSCbveRsmpIUETKq/X/CmHys7h4YqnMAstN4OfGLUA9+1R5BZbcuZUhdqlwLluL6ANkTyNfCki+RVRFv+O8F0bTdDriip9BWj816ZY87lUhJxr5On41mS6jheCkips2V/nZuZ5cc1Hi2S1WJYuBftS2Ko3exKPVDajF0VY/Ze7OIc/thFeE9Z1fqdN1WrRFn0+I+51HBnxzClgESEURotz2u0qzh2ojzVbUbOD+auAgkesS7cO4evn3BEbo5sZLQWs3EQqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:44 -0500
Subject: [PATCH 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-5-53490c5e1e2a@nxp.com>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=1002;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IJh1Qbp5W7RDpCr5dicrtDsd7uM0WGf9xOVKpHAHi7s=;
 b=X0Yamk5fkbfv3ZPG3HXB67rQka8olIH8HybMvei6F6aLsdTzv8nTR1X5kmWAmqN1Pue4d19/f
 /Leb7zrZgiLDQk152rRlCrK/mqgKTCr6TohZFteG34Ymw9np6aDAbcr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAWPR04MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: b1518120-00a6-4e19-6a1b-08de367cafc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WC9ZaHZDOEMwektoQTZaREpZc1lGeEtXdWtZNG1YKzg3MnVMMmdMYkpCWVJI?=
 =?utf-8?B?ejlxVkx3b0lGQlVURzVDdFlic21RdU1tSTNRNHRYUURIdkIwd0dISS9pdE03?=
 =?utf-8?B?YVdKZFRhMDlzNnBoRStIYmxyeVU5T1gxT1FpVlNaZGdIMGtnSnovNG9KZW5t?=
 =?utf-8?B?VGtXMDZTTlNJY0NaVVQvTlRSZ25WanRZdXpadDh2ZU4zdkxWZjM1NVpWMjV1?=
 =?utf-8?B?eEdodm1zYTlIVk94RFNUaDF4alBhUGN2cUdRYnd3ZFJnbDNUdTJZKzlSVFMy?=
 =?utf-8?B?ODc3cm0xVUZlVklXeGl3T3ZvYmQrd2EwKy9JbGFqckVvbytQeFc3WWNraU95?=
 =?utf-8?B?c0dUSVRjb1lNWmlLbEIycnl3c2RUbnI5bG13YmlhMEZ5TjB3eU53cm9uazZQ?=
 =?utf-8?B?VjM5MDlRSnVyQ2gybHFueXhraVgxUVZtYlZ3YmNrYnNqREF5MGpZQU1Dbjdm?=
 =?utf-8?B?UVhKR0xyS1EwTE9hWXMrMmgyTkVJWGt3eGFKV1ErWDkybllBeGpFcjVjUHQ5?=
 =?utf-8?B?UllzbVF1OStqRk0zYTRteUtyRG02NXBzbmFIUmpmbzJiTmZpSjJ3RFc4SlpS?=
 =?utf-8?B?NmNHUXVhVTlFNVhPNzYzdVhMMWxKQkttaGNsN2JxMEpKc2dwNXpIVGtxTWpj?=
 =?utf-8?B?NmRSMjc0ZFQ1elUvTkY0TjJ6VTJuRGp3RXEzcy85Q3A1UVFPRTBmYitGMThK?=
 =?utf-8?B?MlJIV3Y2WDlQL0NMcGdQcDIrcEJsWkRVdDBILytrbW1ySEFnYXM1eXRndjEr?=
 =?utf-8?B?R09DVWdwRTR4MlovUDFpcHZxUG13K0ZVenRmSWIzR2dJZ2NVK1RQSHZpdDdo?=
 =?utf-8?B?UE9XOW5DTXRGQWx1WnkxbTE4aFM0UUJjYTAvVG1oalpwa0R3WU43M1BTdkpL?=
 =?utf-8?B?ekFwakNEZThSUVBtTWxBQkhTV1pTa2ovM3l6SjQra1BHc3FpTEhtRnoxRFI3?=
 =?utf-8?B?WVVSNnFWd0xvbmtqSjJraTc1QlJkVXc0TVlzaDgrOXVXam5HWHBLMWRyWUVO?=
 =?utf-8?B?QjZCdjcrNWxYYkpYSlNyZ2txMkNnL2FOTXI1ZG5sOGxQNzB5SjRiMnJ6RnRH?=
 =?utf-8?B?VTF2U2xOY3FETE5MbWJxRithYmwrS0REZXJmVDFQK0QwaWVOTDZ6S3N2QWZF?=
 =?utf-8?B?Y2s1NDd6QitqbWFjM0hWZ1ErS3YvSmFPbXA3UVRkMzBLQnNxdVFKdk5KMWdR?=
 =?utf-8?B?RkM0ZWhtaTJWRG1RMW96YU1yL3lUbnBudUJLMW41cGRKREtaaG84Z2dIVDhn?=
 =?utf-8?B?dVZrK0Q4UG5WYlVvRTBTWU1DSy9qbFhJUm5yTHp0ZTRBQkJNcnJEOW9JTHhi?=
 =?utf-8?B?aVNidUMvYUJlNUVmQmZEOTc4NERXaldGbXQrVUZQTm1ONTdUZDBzNEg3bUc0?=
 =?utf-8?B?T3BuZ2s0Z0kzS2UzSkhNdGRpdFdzRjNsdmhjcGEzSkRHa2xzSFdHM25CWUlG?=
 =?utf-8?B?andBOGxyZlAremFCZTFYVVhuL2JaL0tJUDhKYUtySzV1WFRRUzZnZVRzei9p?=
 =?utf-8?B?dVNkUWV2cFF1eGxndmJqQUlWenZEVnlmd3AvSFd2NEYyN1hPanhVK2w1Vzlz?=
 =?utf-8?B?NHlZVG56dVdxb1d1YnVBekkzSmVBZk45bWxRVk9MWFZSWFl0NFBkdEEvRWVC?=
 =?utf-8?B?dURTT0EzVWcyMkdYYTVYTVB5alBBOUYzaHEvMExOaHcvbVRPV21ZUjZ2OTlr?=
 =?utf-8?B?anMzcHNlZUZKV0EveHkyWGVxSzcrWktMeHhiQ0thbFJteUJnQmw1Tkg2WThs?=
 =?utf-8?B?bzNZNStmQm9iSXBzQWNFS2lORStOOTVZODk2ZDE1L2FZYnhFZlF4ZmZIbWtZ?=
 =?utf-8?B?VEhwVHVHNlJlZDZMTkFGdE81aWlIVzFHZWh2VGdJSGVPSGxEOXBmSm5ZNG1H?=
 =?utf-8?B?VmlWTnhIbUVLLzIzSmpSc3YrWURhT0xtNEpJVU11L2FMRjFFUWtqTGdZZ2lI?=
 =?utf-8?B?ZU81VXV5OWsvbms0b2ZodHN3VU8ydEFJNW1MS2EvU280bWowcDl5L3h4dGZw?=
 =?utf-8?B?eWFSSEoxQ0JyWm1IQTBKZUJQaVFoV004OThHT25nMS9ZUlZiSVJEYjQrRW1Q?=
 =?utf-8?B?WW05NG51YWdqZHc0aSs3Wm15WTRWNFl3cUFNUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0l1aGlncHlxWEdoOFRjRDVQRnRwamhhRXkyZHhTZXBKWk9QWUVwcHpOeTQz?=
 =?utf-8?B?QXJaK0duTU5iK0pMemhNSVRzZXZpcFgxcXJjR21rQ3I5RWJBdjFtaUpmM1dB?=
 =?utf-8?B?V25ZUDl5M3E5andwMXd5bm5ISzl6M25GekJvOThZOUJIQVAxWFh6Q2ZsVFA1?=
 =?utf-8?B?OEpBNzBNSmJQNTMybTBtcGdMcGYyLzMwNmZKQy8rWWllUXpVTVNpWjBYVUoy?=
 =?utf-8?B?VzFFcE0zcjIzMHRjSWE1ZXJkUjlUcjRxUjRJc0tCNjFOZ2ZYMkJMSzFqcWdw?=
 =?utf-8?B?eVZEb01MTnVJV3Yrb3Q1L1pyMHN3YUZpcVhUUmFJUHZNb3BRZkxGZ1h6cWNP?=
 =?utf-8?B?eEtxVVVXYmNRa0FKeVV3bk5OdVBvLzN6eCtIT1dYQXVrR2dyQkVJWHc4Y2l6?=
 =?utf-8?B?QU9KMnNyU2xUNTZyWEgvTldjeDV4OGh5V3R3R0s2d3F2dklVdytVdjN3R2Va?=
 =?utf-8?B?N09FaXBWbitFaXpET3RYbWNCdU1HMXZkb01Mc0kwcmRwSTBxYmNJRXRCVUw0?=
 =?utf-8?B?bEhSbnZ6MzY5M29QMi9QdW1xUWVEcW40bzE5YWhYVytCb3NGdjYwc1YrWHZO?=
 =?utf-8?B?OEtvMGlodWhSOWMwclJIVmxlbm5rWkh0dWhETFlRMS9WbmZGWnVxQVZXcDJU?=
 =?utf-8?B?dCtMSEQ0cTZVeHdMUDJrdHdEUkNlOTdQOWUxT0VmT0JPcStxRk02UlhocVlE?=
 =?utf-8?B?LzVtTlMrU1Axd2VtUW9sRW9icjE3bmtqQW9rbHVvWW9qYVZVWG9xblJGcUZp?=
 =?utf-8?B?QlNwcUVBQjBNa0N1K2Q2Ykc3cWdwYmxyRXZ1dExYV3VzcmZ5RnF1aHRlTW5u?=
 =?utf-8?B?QytEcHlkRy8vVXA2RWhtc3dMc1VXV2VPOTFPK05zKzJ2VTc4RnVzSytIYjJ3?=
 =?utf-8?B?UmhjRmkxZHBZOTZUZ0pDajZyR3IvNE9NT2Z3UEZFbllFUlNLd25EbFZvK1hI?=
 =?utf-8?B?MmVPS0NBTERleVVseFlteVoyaWJ2L2dwYmNKaVNRRXhMU1VPQTFocUtzN0hr?=
 =?utf-8?B?Tmo4cHlCbGFWb3RlcW9taVlOZHEvalM5K29Vb0VqTngrMEhJVS9zWmFKcUs3?=
 =?utf-8?B?ckNWZzRDRXJUaVpQTzRrT2JjWnIzc1JLUHVvT1g0dW9sUE9hVW5VWmp3K0xx?=
 =?utf-8?B?QVAzVm52eVRWNEo5UGlJeHlCTlc2dndmakZldnp1VWRpTHNNcmUzZzJ2bWdH?=
 =?utf-8?B?QlFKTGI3MFFNdFNhSVNnODZmaEFQNVpLMEVtWWZGZzdNakVVOVNhTkFtR1ZP?=
 =?utf-8?B?cEI3YjBqUXcyRVREbzl6OTJqNktsSFY0VXB0WndKWDNJUVBkcjRMSkFaeHVT?=
 =?utf-8?B?UXNabzAwVHdNWEJKVzd5YmtaM1lhMHNYK0tmSmxMbXhPMWRQaEoxMFpqc2dQ?=
 =?utf-8?B?eFBoNzdpSmxwUkRoM1E2VXpnOWhOZ1YzQjlyaHpkVERSajdGVnlJNnQwQlhN?=
 =?utf-8?B?K0dmM2h3R0RGaGZjbXM4NlJiMUtMS016VUFMci9MRmtpOENENlRoV1Y1dUtP?=
 =?utf-8?B?WitxYUtNWWhDVkhndWsvaWdjUmh0anhINTBIT3B4VlJGOVc1UDg0UStvd0p6?=
 =?utf-8?B?RTlRcm1FUzdFejFRNGJOdTlWUWJSejFCY0wyWnVFTlhDOEdyRHZnejV1STR3?=
 =?utf-8?B?YjYwbjZoRDVtUTIzWHFUQXN4WFF1NW45NEhCWWVoaTcwTnR5bTdYSkJvb0JC?=
 =?utf-8?B?a3cxWGJXWGFReVErRlZOa1ZETjk4N2JNR3JucHE1WVl1Rm5UVTUxMDV5RWxF?=
 =?utf-8?B?NGwxUVJIdWNIYnRrQWZiYVhvNkNDalhxMEVyeWhIemRiUnIvNzdoYUhFL1pl?=
 =?utf-8?B?OSt5NE1mVy9nRXlWTFlJOXN1VmtxQnlWR3BWemIwcjd5MGpjYjhHeFk1cElQ?=
 =?utf-8?B?T3lyZkRGaDkzd045YXIxeEZXdGhMUUtTclk1YWNCU2lsZDB3cFB1SHY4R05k?=
 =?utf-8?B?NWJTU1ZrS3pQZDFrd0pBMDAwN1hSWUVxVkJwOVN1QVYwSGhHR2VPSWkwbmN6?=
 =?utf-8?B?ZVV1TGg2NW9oR0JkcmVLUy9XSjFNNU53bVY5UFB5TWRMdDVRUUJmMThOQ2xt?=
 =?utf-8?B?dVRienFoT0VoU3g2TlZzQTFPbTlORVo1aU4rOEk3OWhzTFk1VmVHdmFOU1Mr?=
 =?utf-8?Q?/fr4dHgJBLRnqbU7kA43PFIVm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1518120-00a6-4e19-6a1b-08de367cafc8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:28.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9TC5ElnXVA75UZC3awxVfAd0pSrSLnYCKwVlMRZLBDd+RZZnrfyLTEr3xQaCWH3607VU16JxSdLDNBxuhGzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_091033_047022_3DF7C234 
X-CRM114-Status: UNSURE (   8.80  )
X-CRM114-Notice: Please train this message.
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

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2e78397a7373a7d8ba67150f301f392123db88d1..85225a4f75b5bd7abb6897d064123766af021542 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,8 +420,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 		ret = -EIO;
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.34.1


