Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C64CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=; b=qKZvnQJwjYV5U32XtoC+Vf5DYw
	HrNU0D3d3eFEr+DeSIqX6uDWCQhbqn07YqD3jptee6l9EHEUgre4l/OqUnHR6qM4wwqsSCrJeV2AG
	8CNsaUUI5cGVast+l+khFQil4zuclZiVLX6JFlW38woekmDKz0d+x5JpWu5c7A8piTtCb6lxG0KRz
	RY4y7V+Go5SzhB8IoGUE7wWm08m+ykFWkxyeia13SlWXdlE3hcLuazIZJV+6SeTtznWaC6ySekPtr
	hV/Q9WtqpcFj+et/FP22e7eDRHbzpebJV1YZvbsiSOG83JVaocSc5+BF0DkqcaWn/2t4lhAnOD+rS
	QXBQUo+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoyz-00000005ukh-2LcU;
	Wed, 20 May 2026 22:01:41 +0000
Received: from mail-norwayeastazon11013024.outbound.protection.outlook.com ([40.107.159.24] helo=OSPPR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoyt-00000005uOV-0RKt;
	Wed, 20 May 2026 22:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYDWN+Ik8+pfhm7iaq05Hpq2udRYUxCWUKtMr4cXyyiiOrw8ZAckN9Co3w0Rl/jODXScO7TE4r06/h9LEyBKsyFADMI7UUUvdt+x6kR5v3EbotSzzdSd5mJUlpOOyo/5WJ1vk6AKs+c03mkGaMLuqZsGB4SEW55wd4H+yys0eWx3LWoAwM9B64h3kkDpytZp3p1LCqxsqFLZpN8UwEC/huDGYSKaOLnpS9fs0+KYpjPmnBfqxgqNisA4AwysGa88OCgTC6eXXauC2KHciYvcXP8BtSayYoAjtRbeI4/nmMJC3Yk+ZEnBBZg3xePJGi9RuLVBx2qEv+o2C4fHutbJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=;
 b=FkyZRMzY7o6s6I0zfTdoJ8eZAN/PCCDl229+w8z8NnGZq8tslig825HjWtwOwkeI9NOgo+sJqcHwVjgawLzFdng8BzvFd3vExrhTX8cbczWN8VIVBeP6LOhjrryvtt4IShu7Dj2Wyi9wvtKUWzDnlKfU0UpWylLJS0ZZhq47tlTGvK9IdXhvCI67xbDeooh4QXaaQD2DsNx6O1auT0qv65IqAE+svNRVTSUxSeRGZNWVlAdMGagvBF8XL2Q9ZWnLiGBi1ZgZjHTU74z5sVlPpgTx0wHPgsQrpej8HOBT3MKmpUFCoqhWIXVGScGm+7Gv/5fgpuEnqKI4P2KBjZDdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=;
 b=gmASWly5kawtHwvBZjeoQMchonavAzaspatg6nwR7iRsJU6JeqxPSqNOSIcjNnm7i9QJOhxd+ufmHZuwcby4DWYr14LHJIsn23uP+qS1vNOC2cLAJKdtKtJ6mJC0MInAOsc2HUQ+9kRpbEdv3wdz+WCgr+Pyl0s5n0URDa0cF138m7sOp2mIEh8sN4UM2Fgo4u5czG7truuV+kZ/+54u9cJoLoz/UEMhpyYAVboi2g/UXZOIM5F4bNv5dwWbObDZ/F8AikKkfnsNRbVSN+CJK6yoXESkqXl+rt/oGCiiXg8V5D+hNOtQFHuWSIoT//9QX2DwvQCIBK+Uwmf9ANGglQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:25 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:49 -0400
Subject: [PATCH v6 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-8-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=4625;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mxi7fNpqhewVwhRKTp8TaG2mZKrM6GhpOzyIZjOPKlw=;
 b=LjVhMKG8WU3w+jODP15nHcOZC7i3xaVdfBIIMLsKUeCPRMn4XeHe54abrvL8peRTJgS7mRvbH
 fXI5N8vDeOkBpBhX1L4tBxbDuik15C213nHBev0fQ99YXPP+JY9oFw8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 8092f91a-0602-4d77-7ec8-08deb6bb562b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: GWP1Mv348hM/hAhM7HfP8BtrOif0DMWpHSQL7ckDaGK/ckceZIWiGjFI8NERHqbRceQ5+foaJQXoPmxmCLdrdFmpVRoN8VFMpLAz6lkgtXd16X3j6XxiEqaNmykKFhMVYkubiihAtN96r0aNNAGEtoVZ0357FnIiGLydSyB9r5blF/hptWBOgGGgbE808AOKcSQ/8imDXS1JhJxl4UwaJnMNgnU+ySnzgCj+Eg5sBizXhq4McHMcpet65VlOjGNb+Q/JQdpF+SdRKChIZa8hRXjGkJw/JpLMFvJyNv9ugziFKCTJFFXxPmFHXVtS4aC9CGLC8oQ/ud22IfK5cx9kSMxiHe5lMl/VEt7q4fsq5PZa+1I8BI0+ybKPhhNPG52ZZdozu106+1DUMNBhgy7omeBh354U0gsh8Gu6Uu+KhSEixRbXuH55bF6DbI0dSzHM06cp6mI0/q/UAPF7JQe/XHfiIMUA4yBF5kwzJwr77rDKRhVGdPCkCS3JA2Se6hsabW1vlXX2a3Q7Rt9OZ8KDbXQfC84XeFaVbKSoXHLeOs0p/LHqSnhYaBEYpIDOPm1UXmXI2QAr79ViBfBZxq96cqlkxE61dpF2Rud9AsHcWntwufizskLAO/KZn8+rkowwGmQzV6UsswF1q3samPM5zu7GWpDnlsY9kRsGaaTz1euTkXu2SPO1vX3YxO9fN+h4j/zzaWsxNPF0zJL8ycZZD2NOo0Q9I55F5chdiXd+Tls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZYVGpNRnlRQ3V5OVVSWHp2K1VHYm16TGVYVklsNzdEdmhvSmE4bkhnZ0Zm?=
 =?utf-8?B?OVJaRHpiVTZDZnZwMnpMaDVwSVRjQUFqYUoxblJ3TGttNnBydXlzaDE2U01R?=
 =?utf-8?B?NVlseFFIYVZTaFZjUG9mRFd6SjlDeHZxa09RbkhTa2hZQ1ErQXhlL3JlbFpJ?=
 =?utf-8?B?emROalM1eHgveDR2SmZQQ3psWDg2SmprdU9DM1BTVGQ3Ri9mNFJ4SWxJaDY2?=
 =?utf-8?B?R2dyUDZpRk9ZVmJudDVtc2hIVGFrNmRKTHVCUjBja1hCS2t5ZjNrWDRYQVJl?=
 =?utf-8?B?TDhhc3RqRndKbmh4d2ZLQW1peFg3QmM0YXdBeXlVNG5mSEErVHBaYzNCZWxu?=
 =?utf-8?B?SGx1M2tUQ3JVZE5UN0ZnNzlqL25qYVdpOVhoMmE2bmQ3VU9DVitUTEViODFX?=
 =?utf-8?B?aldkdlRteGJhT1lrSjZtMm1tUy9sN1RDUnRWbE9aVGc1NG8xdGJMVUw5aDVz?=
 =?utf-8?B?V085ZHp2SnVLRkRjZS9US3BGaDdYT29lSzdzNFQ5UFlsNm1mRFlqbzR4WDJE?=
 =?utf-8?B?N2JobG9wU0hDNVFZT3YyMndaTGRCb0oxaDZ0R2ZHajcyeUxGUkN1MFZtbjk5?=
 =?utf-8?B?ejdqOXh6RWFlM2hmOXAwWEx5N0xDdkxoeTcwamJkRGJzWlFvMkQwWGRiYWFo?=
 =?utf-8?B?K0hyRDhMN2RvOHJTZ2JLVTZWMnhQRUNKSUhYcFQ1alZXU0w1MW9VdURHWXMw?=
 =?utf-8?B?R01CU2dCV2syUW12S3FaSWpuWmhqTURpdDhEY0toVnlPUUdUMkZwV3dVTHRO?=
 =?utf-8?B?MlU5WXJISms1S284bURxT1k0UnRFeGlVWTQ5Z2pqL3pVbEgrb0J2NkljbVBt?=
 =?utf-8?B?TnpzQ2dhVmJUNmxNcW1oNVdsaldxam8rRlQ4KzJ0aDMwYnJwa2tGYmIyWmRo?=
 =?utf-8?B?M3JnUjNCTzVQcm5UUGtTM01QSEdUWXZGQm1jZXZCSCt2QWd1VXdiaHhKUTZS?=
 =?utf-8?B?MDR3Wkw1VDA3N01XZWEyYWx3a3UzOGNwbWo0RG5ldFhpZVNMZ2ZKUVpHcUgz?=
 =?utf-8?B?Y0paVmd2UklqSk9jZWRUblcxQjdrTzljbkNFUHNEeFVlaFpwNTZtMHhMVCtG?=
 =?utf-8?B?U0xpWnRlZmM2Y0w5RnpDWmdDTEFuNUE4RUFBcnFzOGJWd0dPRE5JaVFDUlNq?=
 =?utf-8?B?ZllLZzRjcWlKWnRVaVo2WkY4Z0I3di92VmJRTnVjbHZwMStRRGIzdzQxdFpk?=
 =?utf-8?B?aDRPSHp3aW8yc0tpUjU0eHJDbW1kakpxYlFzQXp0b3VPVFZZMHhhZDZkNTU3?=
 =?utf-8?B?Q0FXNTVQaGJxekJwVENDYS9KRnRGTG9ocFBqb0dwUjBjY1I3OGJINWVOb2F2?=
 =?utf-8?B?VitoYllYZ2FkSWE3eFR5TFVsWUpoY3ROMzM2eU80OGFnNTNPaXpObk5IaWww?=
 =?utf-8?B?M1FKZDNWSzQwME5ubU01WHRhLzd3eGM3TXFsejMvRE5WZG9CUnBEMzEzRHBt?=
 =?utf-8?B?b1gxZ3FhM0orNW4zcXNCSjhEUGRjQmNmZWdLRHF2aUlSRlRoL1JtaTIzUDhn?=
 =?utf-8?B?VnlrNVRnMzJPcERpdjB5bGR0YVhsT05sYVBxY1d5ak8vZHladE51bDBIVUZZ?=
 =?utf-8?B?SjlhcmZqVlU4Q1JWWldSWjh5V2dQdFpjRjQySWFRd3kxUUc2czA4WXhDUk1s?=
 =?utf-8?B?NTVOWDRHYjNxVEN6VTlvdnUzVG5qdzBwTGNrR0pNeGZGL0hPa05yUzNkUU5j?=
 =?utf-8?B?b09vUFMxS1NSM1NQSGtyMGFDUUlVdlN1REF6RmU3bHlOb2pZWE5tTlUxbnV1?=
 =?utf-8?B?UkRtRXg1YWVNV1htMWhlU0J4ZjIyNGdTUXoxQmoxU20wd0JkUVprRFRza0hL?=
 =?utf-8?B?enBncTRLZ21rVHM3L1FlZGhCT2FTNGxGd3l1SVNXa1BWMVpJL2ZZL0hOOUdy?=
 =?utf-8?B?cm9ycU5yRHMvd25TYS9JZGVwZWtZeHd4TnBHUFVMeDdnMXhjVlQxZWFUR25C?=
 =?utf-8?B?bXZJeXNXUWJBMnBOSktIZWxrangyYUJ2M0I3a0xjc2s1bEJJUEY1Y0EyRDVV?=
 =?utf-8?B?NnpvNUg2cVNPWXR3R0krVFFtR0kyLzJRL0p4OW9UUW9wUmZubmVIMVNXZEVr?=
 =?utf-8?B?bGpNb2FmeGR1blZhZGMwR0xZQm1RRlJvMmx1Qlg5SmZFelRZeDYyOTlKRFJF?=
 =?utf-8?B?VVM1KzdlRW0vdXpoekUwMitwSm5odDhiNzNROXdiVTJ4WjR5bVNDUkI3b3B4?=
 =?utf-8?B?cWo0RlAwK2JpZ3dTT215anhMYXVoN2IzWU95TERTYlRqUzdWcnpyME9WTm56?=
 =?utf-8?B?dkplSGpiWEZyQUxTcTRMYmVFRlo4NWJqMXR2Q2ZvWDFzN3ZVelMvTGdQMHE2?=
 =?utf-8?B?K3hzdU5wUGxpQjBqTUkzcUQ5a0JTTWxudlRmdFFRa2pNYXpWbDlrZVFUcFY3?=
 =?utf-8?Q?6xD9mj6GKxa/2JiLLBQJ4p82njhKfUXA+53Pe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8092f91a-0602-4d77-7ec8-08deb6bb562b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:25.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DBO24sNbporOjSe9QTNVCw1azi3+ZTOZ9/OhoPP6jk/s+njse5ZQyaYJYWh84Dbv8vXcybJBeoVzMspkMOQ04unRq3kw2UxGWaSKjSOA7l5rNrMl1Cc0TWDxyPWZYHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_150135_207910_EA27DA16 
X-CRM114-Status: GOOD (  10.37  )
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


