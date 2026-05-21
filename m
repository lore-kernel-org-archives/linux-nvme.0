Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF81CD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=; b=HJjJMq0w6Yj5Mzgz6VyTh9SbG2
	4kLJlZJ/AA1moyGRhtRhowYbnu5Lm+zLk/orsKEjLNLByHmALQdMKt28g2795gIkEo5UKnbSWHEEB
	KW8W5Vr2csRvCeVDn5jr1WytlBABTVcM3TycAS4WelirlBGSinzpe8RTEn55auh9XgLZwvnbnyGUl
	q0YJoYgVyTgGAHbdDlCE1y+a4Gr91MoxGzRljgrivCUBRCwKshyDkINaYzGQu9s0j00od1DafXd+j
	ev8WfzcZ7krMWpen9SsCpfGhMhogzlfQhguO9YOSdzlko227qQHsPNkcQqGZBk9//+4oIS0sUSOPU
	WZ3QHFkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5PI-00000008KXe-3VYp;
	Thu, 21 May 2026 15:33:57 +0000
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5P8-00000008KPr-3oLv;
	Thu, 21 May 2026 15:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNqB4GyR29kVnjbH9BKTNCPOZxp2+D6IEKI0IuZGiN/3NwqiiqotdALQHWTSA1brQw2dcegXDlLW9j40B6IVhpbpq69+FkfW8bthKlQb3ITizEF8GG+AtqXsiVrPiu97OXgypc72mK6pomy+vuH5pDxVVoD83c21eBfM5lgCYspRXCdU7zBFoGwLk9daRz7AAHSa6y7mbmZKd3Diyw0y+WPci4hxYrfXFBzTXU/BOhM5sWfP+EjNiPtgA7pI8FPcpb7n5jAUxzIR7wj87zasEP57XupE+fEo5O+SW4DvjouHUtGkveucL5b5grFUXYao91SweFSEDtEnj46z5+8sdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=;
 b=XonwS/r7H6KxC8HVhesCmaezp4ZWfWmPTdzsomnxbF9qOABpz5fg/BV81GDg5BkTIa6wo/s5QMVrINH0zTQcXRnBj9mI4+mUInrfJYYO0uwnYhiOedCDisS/akXIe4iwiS72eZk+mGnQ9ILakfMhsBET124PTodGkCzNfWKby2FEUfY+X9cwwwZqF8hxaCgVk3Gu5nN9+9LDJy0kySYdcOjSs1jIWd3qx/NoAfvhhsI4DIZNhk58r6c4KQzGr3ezKkqHF7vRlf/F8liFP8qX4+VHY9B+0XJzo8aOIWTUElf9Hfa28P1I4wTPa+2YOgB4/k8BW4YrmEfP7Q4L0fqDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=;
 b=JaLimTrxEc6FeiqsaN0AW1xPtUnNNeNK2axHl5MRGxD3YJEr+b6zoXD/4eLnPuUFey4/IFE+Pa2Ta3TvPXJapi5uRewyHaN6Nlu48SPh4rkGDEfMub3jEYIGNkJpnaazisF3dedRRaeyLLu54xInAf1wic7gsd+T1ITANHK8aAcVsrJkJVqxERGJogutl7tqDTkV5dcshg8/1wJ/PK8iYqKi0u0v3LbCU3cb6VRhHPp/NXyZISK/u68HtwqR6do9Y4lga2tIaH5rGKRmGeHDIexA6Pj0kS39DxaFyqN4qHVKw8rkUcJ1zX2F9BoqlNc7xzc8urfzC7K8Tt0DakSM4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AMDPR04MB11581.eurprd04.prod.outlook.com (2603:10a6:20b:71d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 15:33:41 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:41 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:54 -0400
Subject: [PATCH v7 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-8-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=4625;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mxi7fNpqhewVwhRKTp8TaG2mZKrM6GhpOzyIZjOPKlw=;
 b=aOMuFXWXNh4L0OlRTQRGq/QM8tS4GKdVFxYEW5gPVy8XPN6OInYDkEQ/7VboYBlfxsRnAkQQ+
 T2lE1pPeD8EA1C666+TBgqEYx3HUlfJipaECChkBAHGRkzN7ZllUwdi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P221CA0084.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::35) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AMDPR04MB11581:EE_
X-MS-Office365-Filtering-Correlation-Id: 25edb1e5-7396-45fe-da2d-08deb74e55e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|11063799006|6133799003|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: pTcNH6QmiFMxeeF//Cg5QhQwOLLUrhqPLD7GIRJnXHsabsV0MbeE59a9CA3LplZPL+HPNtxeONqpLh03LQxhI3DoIIlTCcmdOEJ2mrD5t3d7VB3mAD2hgNyxRvmh7OkBSuENJ6gETtJ1ifjgGzaVCpJpwU8WWyqGJ24l54+nREFMdRUuVT3buQ4ClO2zvCFz3Af5eN5ItaQAtyFCX5FqTfu0aC15IzcTb47+rDOu1zj/RvBjynf8WHNmFQpw3LvN6JNUYUhTY0/Lc/lTraA7Rb8Rmpd9edYNLC+UsvtCV2nvc4kPXIeqHu+/GnJbO0trFb7OdWUxxmaYV5eqajhChoCqn57KVw2yZvVBCuD2CO9pMjcktF5Njcvabu3hjQORGCAkUx5dAp+ESfdt+WNniuq8CdHNaVOqWui1PPPc6iBSBk3oOBCh261MsIE/xzgGVaoBwbwNen8vT2LmijaEMmNRfpw81R+ZCIrWwAFxO5/aRdaZoCzfo/a2pBoy95kHkQlE8LRinMn+MAgTRgDHpk6INuWRxZo9s5psI88Ja5Prk+CV4m1fc2fymtJNxpKQFjXB5flbpde0pUPwY0gz7osz6iTVi0F/WmMT+TRDL/fnzXCE1wpiw/x35xoBUKoCS8yOxtg+pMDmemwJwHiH+LAOJxZJu10p0xN6OwLvowIW1uYdoJSYtRhdtYuIVWOCtMYiFCrUhHOkk6Hoi8rDZeK4MlFRKExMuLR77Qk90hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(11063799006)(6133799003)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGMzYTUya1VsYlVvOXhjcHVEVzlqNWMwV2V2NGQ4NzZ3aW1lcFdFbERRWWN5?=
 =?utf-8?B?NXZlVm9hQVpNTlZIVnQ3d0ZqMDlmcjF3eEFzNE14SlRaWHIrMHFrd1QrM0lR?=
 =?utf-8?B?cGtEa2lXMmhlZk9McnZTdWdTbjdtRSs5YkJiSVlCRU9VaE55dk1HNlpBbjd4?=
 =?utf-8?B?S2dZdUpsQkFVblNPQXlNR3VtbkVYYXEzSkdtaWI1UlgyL0lJRkl6WThQb3g4?=
 =?utf-8?B?b01ObVpkY0U3U28vclhmUU5IMU9acVlPeG9OMkNaRkJKcW9wc3BHYTNnenFx?=
 =?utf-8?B?dUlWb3VReERBbGRub1d3S1FKa1dFSVZtWnhEeUh1a0dvTnRhNHR0MGZUT202?=
 =?utf-8?B?dmJhS0FjNGpQTzJ2WXEwR3Q3emFxVE95alYzVGcvRFVsVGc2R1dLSzQyY0Fp?=
 =?utf-8?B?ekpWamMxanJjbURmSGl3cXo3UEdzQjcvclJlKzdGN1pxWVZHcjU4YmFZNjRC?=
 =?utf-8?B?YVpyU1JqQWpFYzdoejlyN0U0RUtJMDZZWXkvaTA4WTF4TS9aSlg3L080SHRS?=
 =?utf-8?B?WFdHdm8vdjFUTmwzaGtEQlozcjJyNjdFTHFlZ01jSEcxVVNKSEpocUltOUN6?=
 =?utf-8?B?ZE9MZ0pHVXlidVJlTkV0Y1hCemlEQmx5UGYwVkxBRnpyMEtuZU5pcVFBbFht?=
 =?utf-8?B?Q2F0ZUErSThkakpPL0MzcFJyV2hZRE02aFVxZ3ZpSlMwWm9FRFF2ZGQ2eXJ6?=
 =?utf-8?B?NXBWcWsrVEFaSVp6dHlnQytMMGdOQ3NDUHZodUlCSHduSVB0RldNdmlSWFg3?=
 =?utf-8?B?SXdxZExNemErZURTcHlWTVI3YmMrdHJyYlBLRC84RGZNNE9HemhTbWJYT0pt?=
 =?utf-8?B?bXdMSkM2NDdnUjNRTk5FNVJTcmVsVCtVcWNsREJzVldOL3dRbWYzMEprQWhX?=
 =?utf-8?B?RlZMNk5mdWpOeUM5VG5tSEp3N2dRSkVaWHJVNVQya29jZUc2Y2p5Tk5nMFMy?=
 =?utf-8?B?Z2RScktkNjlWN0l1b3hDSmJxK0hyMmRMSzZDQ201d2ZQN3JsZ0dEMm02ZW8z?=
 =?utf-8?B?dDBKSldjVGM2RGhvcjdWTEdlWk14bGZ3NlNyYW12Vm9tZWhnLzhDQnEyd1lk?=
 =?utf-8?B?blo5akUzTkM4a3ZPMjR3V2E3cGpScFI1NWJyTUxSZGsxRCtaY3lLZUROc0Jx?=
 =?utf-8?B?RVdTQWNVYlZYRmZtSEwzMk9KQnF0RWNKMWVvblAyRnZFcnEzc3FLWnpLUENs?=
 =?utf-8?B?N3YvK2JNK0pjd2k2Z2lYOGJReUl4aGhINGFTbE4vblhGanBQcnZnWXZQOFRP?=
 =?utf-8?B?cmhrMklFV1BrUTdOeCs0MXR5dk5EZjhGNE1CWS9SOEZWcmtQTUtzZ01QNFU5?=
 =?utf-8?B?SnE1NzE0Z1FmcFVBZitseVZieDNsVEFRVjRvV1dpSSszSG5vaEtTVGNjd3Iw?=
 =?utf-8?B?T3hjQWJ0TXZTRjdqVTRzeXNrQ3JzajMvOWI2OEY5alYwdVE3UkJIeGkrNHZS?=
 =?utf-8?B?bXh1ZGQ1UFBTQ0RwdVZZUnlUeGVaMVZvSDFienRTTk9YdklXc2FraStZR2kw?=
 =?utf-8?B?M2FmUDl2U3c0R3FiV0Z1ZGE3MjdJdXAxL29nYmhjNkFqL08wdHkrYWpuampM?=
 =?utf-8?B?WkNRbytKVHQzZ0ptZVV5cjZzQzhiUnozTXZKcDdYQmNMdGYxNmNsU3k3K1Zy?=
 =?utf-8?B?clcwUVVaYW05OElscUJGWlBpQXA4blRpLy9aalpPNUx2NEZab3QwQk5iL0Ev?=
 =?utf-8?B?YUtZUzhObU9KVGRBZCswZllZYjdDdUMzNWo0aUM0ckdrMHB4aTZreC9RQlJL?=
 =?utf-8?B?MmRzUkwwN2FJdHhhVVA0L1h3bWY5QUdrc2xPZXdsU0ZHaXUrU2x6bDJuTFRE?=
 =?utf-8?B?SHVmTXZ4Q0ZQQVh4ekFWTWp5K3UvOGlZYnZ1TTdSd2VTZUJ2M0h4cTN6NEpk?=
 =?utf-8?B?S3owRWh1OEdTY0hoTmZ5MGV6Mk91VWd0bXhPRDBWaU5OZm9jTCtCVDhYdzJs?=
 =?utf-8?B?MXF5ZC9wekh4TUtuQnppNXNzVUEvTjVZR0JFTnowSzU3aGZYUnZ0eng2Q1dm?=
 =?utf-8?B?bktQdDBzdHhVQkI4WjRsRCtydEtScDZWMUY0YWwrYmNjRElwU0VJdzR3SjQw?=
 =?utf-8?B?aFdpTG9FTDVwL1lMNjdLYWh5Y2ozaHIvMHJKaG1pMHMxdmlIbGlOZ3VldmRS?=
 =?utf-8?B?amlQcmtPeXRHUFpGOC9FTVN3aHdQRko0WldoNFNJaEdBcUMzcFN1U09RLzg1?=
 =?utf-8?B?bnNEcTRiK282R0xDT2hzUFNJZHpiUUw0RVJhcjFFeWN3SjZ2dU9HZjZwU2Q4?=
 =?utf-8?B?b1VnMXQrYlVEK0lkTzhiM0FBNDBGQ1ZRMTQvdU4rTG5RMFhJRUxQZFVMcmE5?=
 =?utf-8?B?eHVGNUVGcWZvZnlHQnZhemFsS2IrRWUzSy9HU212bXBnYTRqOElBYnB3RXp6?=
 =?utf-8?Q?10SDN4Pn7hbSTBaxixPxBx3A0yTYv0A8P3ww4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25edb1e5-7396-45fe-da2d-08deb74e55e5
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:41.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0g3cg48jgJ9hU6mImAxE4cP985KFZxS9U0Nry5pLOfeChKeznHpAVKz0b3Or9y4yQI2Cw30za1su80FSbpmCNjdJQaTz8uqH5WDhm/KEdMABHLV5k15MZkiwsxX1FkAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11581
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_083349_008859_42879815 
X-CRM114-Status: GOOD (  10.12  )
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

Use dmaengine_prep_config_single() to simplify
pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Keep mutex lock because sync with other function.
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7f5326925ed54..c3e3b58fb86cd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -401,12 +396,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -415,9 +404,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -506,12 +496,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -520,9 +504,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -585,12 +570,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -599,9 +578,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;

-- 
2.43.0


