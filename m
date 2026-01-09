Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F19D26D6A
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=; b=MrQVqWBLCBgLe/t31+Lm0VkvZA
	ffct3qawFTD0NBN6bREz935IevYp+3bYx6s2Oimj3Xs56cDm3tjEMRI6xAq7d3z8g0FTPTZg4k8Ty
	lftjrf9vHPgIJgmYcl1wr0/DXEYGO0U7d30K+wAvuw/8yWW9dU4V599DTI9UrD85kUhEJMMg96c3w
	y07zJcuclpmyg9+GVd3uWc8lN6DKrOtcyVHOefG86u4Uq+uTYshQbmRc/es4aezlaA86pOZKj0ge0
	IOheF+bK+BiZ/eqIaipFoNjn8OE/lxoT60OrXnug1ze1lvIhNAUItI2beNsF51jg7IE13aB1wImZw
	jNbzPS8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veEQR-00000002UMA-3rGE;
	Fri, 09 Jan 2026 15:29:19 +0000
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veEQP-00000002UIh-1VUu
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 15:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d84heULISTaO+kXGo6CwgxL6MvsfJgnxbVGBVKIHl5py+qDcCGVIE9Yz/jBKr65Tllx1OpXQSwxwf89jTUzt4QR0b1pIxNs3CnR19wH5UpNcXsiKsY0Os+lLrbl2KIqr1pnwW1XP17kEp5KRp7ayTVH7sc6dJBOfGu3+RCWw+gjUc616gAVnCD2+ZtUD+0O5cSsIIA+ZNajziB83oek933yVaKilxNdWMVrU2ybN39mODZj/pmtZFau7svIViuFJ55pvZ8B0RB7zEw5eoJ6BWGjsZ20rwzwRA6PX3lTPfXF9Uhpp1qsZkA2gaxkeXPDAA9bqgddOwU3OYjv1JPqOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=;
 b=IZEx8qKDLd+e2HzjTVixl5mic3AgqzJc8/sW32SHsWJlkqjxdtqeMQYhcV+jvrADs4d/dcvCeG0aXTbjGenB7xc1tUGlznwBdze8k+4c8zsuGGc9uO6QqgLv+KVdEIhDh34udZrip8+GY8+smm8zDR/5s44/GoOnaLaCKEfDg1S70htttSLmHKuPiiVwmJnamjEaxhAmxZcGgx87eefs4eollKw9nZKkoeyY1nh98mRL/aLcIkyFVQTcAMN1r9pWktLBLthGrMeNF/5qm/2x7rfEJtyoWi3etn+vHwj0DxRBjLWonCkJHOJ9lvnAa6qtbZu/HxSTyamtXBglj7DBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=;
 b=CDvcN1XkmIRObIVXNDNXnWjfmDyftHuNRyWZvifm2Qkj/bJ/YH6eadIX5egcRVDeU6tA3BJaB4MNcJuoEJfTdHDwr4BPNMtiyxlLatshVh5bV0hUsgpUyKt6qRCgjl39jwEtDUaPsjkA0XL7XWXSQK5AruvZtl4z1okY/StjFOdhLgQqywBXcnxWDtWiRgVLbykI3ZMQPnxuD6NUoivohC960Ui7i5lW0u617YayeDxP7plDcI0JhDjgR1bn4puS1zwavzGwB/w5k+BJrdgkVu4fEoNeMx9FIxfjfSmnWsvArECPHKKcfRVXAnxRdLT+1VLLtFM72ReqoxKv6hWE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:13 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:25 -0500
Subject: [PATCH v2 05/11] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-5-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=9173;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BVei9oaxixdZN/1lIiuFf7ag2w89A7PX0bp9V32XQPg=;
 b=5eO8Z0dkpBcBQy8oSqcK/jwkQKaLVfH5WhDn7ooeiiUmHyq6E6LvWaZoSAlCcNwHB2xyffZsG
 AuFoh45rXqPD6EXGDSiHLjND6n6enjvRcxWi1a1amkljWS8Xi+WFhf9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d62b5f-e989-4e88-1558-08de4f93d7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1h1dEVuTVlTeHdqSUpLVFowclRzQTRodGpVekorRmtUc3VzL014ODVhVW0v?=
 =?utf-8?B?ZDIvRkZmM2srQTZxMmczeGZQSjVmQXFvbnQxTkh3djRsbENlTGNuUWdzSmw2?=
 =?utf-8?B?RnBFZHg5MHBZdStpS3RXclhwNURMMXZ3ZThoYnFKeHpxVGE1NS9Edy8vSnJK?=
 =?utf-8?B?Uy9RdW12Q1RSSmpmYWxjd09zb1phR3VnK2xwNTUrVGdGNng0bTVKbmRSODNu?=
 =?utf-8?B?dEp0YXhiQmNRNnV5d05yc0tScUlXNXhvNFRTU1B4a1k3WHpvNjNJaEFoUzhs?=
 =?utf-8?B?K0wzTGZYYmRzOGYvTjc5Rkw5SkRtV280eDJLSk5GclRsQnhkaEpJT3BvRCtw?=
 =?utf-8?B?Z1NYSmI0NXNIazUrRi93cXV4QTRVa3JYdDRmN0lzdnl5bTIvRzFYZmUxSC9V?=
 =?utf-8?B?azVSdm4wTHZvMHBpWXFtakUwaXZ2UEdRYlRnVGJGNThCTWdTaVpSeXNkSlFC?=
 =?utf-8?B?d0VqK1kzcGZhdUQ3Ymg0SCtqdGs4N3Y1SkozZm9rSjJaTSt6YkNSVm1BMXRH?=
 =?utf-8?B?RGhEMzRMNHVtSmtveG9OK3JKNlRWY0VFd1NMb0M4MXFIUnp0aTJDakFtZnhP?=
 =?utf-8?B?bHBybXlOR1Q0R3NudGxpakpUb1cxLzJiOEhzVm9BTGdJcnRyUGxSOGFzTE1n?=
 =?utf-8?B?UWlhb3VnNFNkZ3NUOUc2TzUvWm9ST2M4ZnJIaVdqY1h0ME1oVCtBaU9qY3VZ?=
 =?utf-8?B?YUFpdDFnNytCdElDRzJ3dnM3eFNsVzRpN0d3WWkveUFDRjU0Ykg5ci9zZ0FQ?=
 =?utf-8?B?V25FeW0rODdiYmVHSUVRK0txSXpKM3Bxd3RQb3BxN1N4b2R3RHpDNTYzRFMx?=
 =?utf-8?B?TlFWWkY1bDh6cytKY2FOS2l4VzZUMlZmb0tkcDY3YkRFY3EvYnkxVWtxUHBT?=
 =?utf-8?B?RmdmYThDZnVTN3J3Z2U5M2FBUG1UVERnNE50ZUlhSHNza2dHZTgrV3JDNWd0?=
 =?utf-8?B?NmFwankwZmxKZkVSZUdvMGMzSjFpR25jOUlmUFBVdDJnbUgyalhtbUVBUW9C?=
 =?utf-8?B?dm5lWGtBV1BTbmp1R3l4ZnFqWmw2MW9keXp3U21hQzhzUFdPR2kwMTl1QkpD?=
 =?utf-8?B?Umg1RHVMd0JqbHFJTkNJeXh0RTdOSjRUTFNEZjFlb3o1Zi9qQVB0N0s4eXlj?=
 =?utf-8?B?S3EyVElvZTNVaGZyNDJTK08yUHZhUWJpZzlkZVpCYUpmSGxDQ3VsRlhndEF2?=
 =?utf-8?B?SndnK0xiYWErcU9BWHE2dllKWDc1bER1Y2M2UFc3QkZGM1BZNVdHVy9mUnY1?=
 =?utf-8?B?TEVFa3lka1ZPTWhKcWRkRmF4THV0YlVESFplUzRmSU5aTC9OQUdSR3QrMEY4?=
 =?utf-8?B?WDNYV0tvbTdTTXBjeGRnTXltQmVZSE01OXhGRmFHcm5EVGRyVldkYW53NzVl?=
 =?utf-8?B?ZmFEZzF4alMwSnByRXU3TExYSXRSbVNSR29mbzRtdFdGa1p4TWVhV0poVndj?=
 =?utf-8?B?U3hLU3dPT3hkb2NPd0xHbzhDUkRyekxYbmp4WEh6TDVVS2t3Mmd6YVV4M0lr?=
 =?utf-8?B?bkFzTmVmSFBrSEc4R2tKT2tpR1lvdjZvOFphSmhmbjFoWFkwcE03ZFBaeHBC?=
 =?utf-8?B?Yzd3d3BneVZGZzZlalQ1WSsvM2ZDV0QrQXJPaERPSXFtc2JIa1BIMTVyWEgr?=
 =?utf-8?B?TXhGOFBmRVJrR0ovaWlhY0N2M1NpMnBMVkwyOTVma3NMeFRUTVYrQzhlWURP?=
 =?utf-8?B?Ump6c1pldDRaUmd0SmR5Ni9pQnVHVjloUkIwTW1LNi9qWThjYTBaOVVtQUwz?=
 =?utf-8?B?RDV3Tk5TaW1WM2NQKy9DM2RFNkZKd2tEcmtRYTJSZXl6aTJKbjZRbmM4cjM0?=
 =?utf-8?B?em5xWnBKKytGRngrZHhveWF5RnZ6bGJXa3ZXK3Z1RFlEMm42K0UzSENhQkg3?=
 =?utf-8?B?dUxXK093UStYbVB5Wjk5OGZQUlp6V1FwOVV1dFNxd0JEWXhMYkR6N255WUU5?=
 =?utf-8?B?cmFieHdob0I3Yk80MHAySWV3WGd3ZU9aUU0vWmRGK2xrK0VaOGRad1VZc0tK?=
 =?utf-8?B?bU5TN09rNnZweDNEdCs4SmZ2c3o0ZlVHUEw3OGk2NVN3WklBcngrZ0FJZm5j?=
 =?utf-8?B?Qk9qZUllQTZvOS9qemlrcWlrZkhZaVJpNEJudz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2pHaXJlczBUcXVFWEhXNk15d2dmYTh4Tng3SDlpY2V5blZ2T2NzcGNpL21t?=
 =?utf-8?B?aEhITDdkM2w3b3BiK0l5L1FPVmhST2VMR3dqRktLT2wwY2JzZklzR3dROTFq?=
 =?utf-8?B?Vy9wSXQ1Znhpdkx1UzIvSVVVUkdmdGhNa3I2d0hubDIydGZJZUNidnA5NnAv?=
 =?utf-8?B?eWI0R1BCMUZLM1Jxck9SbnRtcHF2ekIyUmRSdThpcE0rRXhKMmtLWWtpQXNM?=
 =?utf-8?B?azh4aFpLRXR0NWVKS2FBaUg1SEtvY28xRGRqdW5WRnZRamRkRjJ2ZUJCRUsy?=
 =?utf-8?B?MWV6SVhnWVZIZ1NHaGpXZCtoQnBrZFBOVE5LbW5ZK1d0SnFnNDhzR3Vnd1Uv?=
 =?utf-8?B?TjZLVThyMlpocmdmSitPSlQzT1hQT1VuU3l4aXA4N2RDajhVcXFsdmdTQitW?=
 =?utf-8?B?Q25peEJxenpYR0UrVUlZNlZKT0p6eXVOSDQxejd6NTNFV3paUWNzYUs3N0xT?=
 =?utf-8?B?RXBWa2g2NjdXVEgzQ2xoTFBiYjlIZm1uRGpQRmZaWk5HOEsxTElEWWJuWnFD?=
 =?utf-8?B?Z0VUeS9OVVEwOUxEQ3cvQkNVZlBmS01JZTBBK2pqUzFrbmhQOE93UlpmelRC?=
 =?utf-8?B?VXRjdDh6M2tDTVhxaTdyTHlFUk9jRjhhZWdRY1ZndUFUaS9WMVYxd1lJSXlO?=
 =?utf-8?B?ajE2OVRJbmwwRVZOWG41a25TTWhJanQ0bWxRaFMwMnpHSVNjRDNKc1RHMFVM?=
 =?utf-8?B?N3NkWU1hUEVUSEpDSnhHZWxNaTNwN2JFbVdmVnhLVW9sUlFmM3E0YXBxOTJ0?=
 =?utf-8?B?NXp5cnhUZjhaMElrR3phVEwyNFBZeWI2a1c2VE8xcXVzTE9DZ0dwVmp6QXd3?=
 =?utf-8?B?Wlc4UVQvZ0ZlMzdQMjZRYTZGMnVnTUI1WE5TSzFteDY0RXRCcjB4d3A4WEZ2?=
 =?utf-8?B?bDNZN0J0akdUTXF4UXU5Vmx6WHN6YlpKTFNEUTFDZVFCcERrTmtjZXBFN1Rp?=
 =?utf-8?B?SmEvQ1RvZWcxVXh2ZTFFVW03eWE5YnBTbG9XVmg3Z3daN3VFSEJIS3NZU016?=
 =?utf-8?B?S0V6UlBhRWJzMTVVQldvQzRjelFxaWlVN1FnZmpKQU4wNTh0alBWY3VOZG9F?=
 =?utf-8?B?WkFVQjA0cDBvTHUyaHl6RmFsNnFZUUFBMCsrQzFsdXcwcWdrN2JLbUhkMk00?=
 =?utf-8?B?bE8rZEFuUDJtWER1a3FGaEpONTVMLyt0akJyNUZndkh6STIrck1sU05WWnpo?=
 =?utf-8?B?MlJMcml3SktGZ1MxcFg2TytsdGZQdTY3enByMWUycG0zN0pyamFvMDFNZWox?=
 =?utf-8?B?VzF1NGNsY1FXVVBkeXlDOFU3Wll1dDZhdDVNbzZwQ09lOHZqNDRaTm4yS0p3?=
 =?utf-8?B?VHQxelhJUjhrNlhHMndpMmJmR2owR0YzK2U5SkplR01laWgrcCtWcGJOb0No?=
 =?utf-8?B?Q1Vzd3pZVW5Fa2RWZnpFL0RNQTlNWXNzQU9XbGs1YVBzRys0Qzg5djN1aTZz?=
 =?utf-8?B?MXUwQnZjd0JRR3FlZWI1SjB1d1pzbXg3N3BwOFVFUFpObkRqaHRSeHMycjE1?=
 =?utf-8?B?bzkremwwUEN1MEdPK1ZCTDhnMEFrSy9IT1hNZVhYTGdvY1prbWh1VS9rQmdP?=
 =?utf-8?B?MUV4NTVJRkhadE9rVFZOajM3NEl0TWU4U3NqMFB2d1h2Wm1KQUg0N1hlSUZI?=
 =?utf-8?B?U25weVBIYkFhTmp5WGpUM1V2ajFzaHRQZDUwMkxZM1phbUN6ZVVZSU5nc2hp?=
 =?utf-8?B?SW1UNlhMR1h0TW5sdTRramN1QSsyQkp3aTZtQkxhTFFPblp3UDFWMW9tRnF4?=
 =?utf-8?B?SjhMNnkrZGMvZ3l0alJZTVhSZGtLb2pXSUUrMDg5SjBKbjdDL1VSUEZ6MUJm?=
 =?utf-8?B?ZkRZcVQrM3psd2tHdVZVNW1tQ1dHQkN0K2hMNmRTMitEM3J1S3dTK1BEbWEy?=
 =?utf-8?B?ZVJld2pTSGRuR1pvMHR4djN1cFI1b1ZHYjdSNHMvWlhNT0FmWk51UTRiK3BY?=
 =?utf-8?B?WmpJNWRkSDIzTnVQU29pbEZvN216d1kzSlNwdXdBU1VCMlc5cTJGTVRKcjF4?=
 =?utf-8?B?ditJRzQ1ZG1pdmNnS2FHd3hZVjlqaGJYcmtkWnlxNXhxOWRtWTVNTi9FeDcv?=
 =?utf-8?B?QVVEd3pBZmZ1K1A0c01MeUJtZm5qSEpPWjJ6YnRBVGNveG1xN3B6SkpoTDBP?=
 =?utf-8?B?cEIyLzJDbHhIc1hSaTF3b25ONG9NVWlYNkFQTTJSNHJsejdxMjRNZFlrQnVu?=
 =?utf-8?B?Z3VnOURLWUxQR1FDdkRhN2l3VVY2YjkrV3dkUWNoRzU3emRKcUYzQTlYeVIw?=
 =?utf-8?B?aVV0OGZZQmQxcnV6SVdURGE3SU5CWGowWWJtb0dSNGZJNCtNU2p1OFBySUZn?=
 =?utf-8?B?WDFZUE53ZGp1MW84MFBnOTVsVXFTeUZ3VS93c29RYVNuZEZxeE80dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d62b5f-e989-4e88-1558-08de4f93d7de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:13.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biMjwASfsApzFfahybSiFQEuXsveA56xSs6qxrfYXBHHUOIEXrugrDLYF8dsUbH+U0TbdROJrTsMaX2c5HjyuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_072917_575040_07EBB657 
X-CRM114-Status: GOOD (  14.85  )
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

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 14 ++++----------
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 18 ++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++++++--------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b154bdd7f2897d9a28df698a425afc1b1c93698b..5b12af20cb37156a8dec440401d956652b890d53 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,7 +64,6 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
-	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
@@ -81,13 +80,6 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
-	} else {
-		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
-	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -767,9 +759,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_wr[chan->id];
 		else
-			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_rd[chan->id];
+
+		chan->ll_max = chan->ll_region.sz / EDMA_LL_SZ;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 722f3e0011208f503f426b65645ef26fbae3804b..e074a6375f8a6853c212e65d2d54cb3e614b1483 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,7 +58,6 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	u32				xfer_sz;
-	struct dw_edma_region		ll_region;	/* Linked list */
 };
 
 struct dw_edma_desc {
@@ -79,6 +78,7 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	u32				ll_max;
+	struct dw_edma_region		ll_region;	/* Linked list */
 
 	struct msi_msg			msi;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 1b0add95ed655d8d16d381c8294acb252b7bcd2d..a1656b3c6cf9e389b6349dd13f9a4ac3d71b4689 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -280,9 +280,10 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -290,7 +291,7 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -303,15 +304,16 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -345,7 +347,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
 }
 
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -359,7 +361,7 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -430,9 +432,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 
 	dw_edma_v0_sync_ll_data(chunk);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index f1fc1060d3f77e3b12dea48efa72c5b3a0a58c8b..c12cc80c6c99697b50cf65a9720dab5a379dbe54 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,9 +156,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -166,7 +167,7 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -179,15 +180,16 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -210,7 +212,7 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -224,7 +226,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -251,9 +253,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,

-- 
2.34.1


