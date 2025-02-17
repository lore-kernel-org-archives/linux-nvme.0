Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBE2C021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A4ZnQrwUdmWft7s/kBlYVsHwV//zkBhmzwbtTAlTuUE=; b=O+thc//StAGhpkAQcB6ckedUfU
	4fpOkrcoL+KmXZ3zjKnmPYCAz1etg0B5RoKFmZHeMzjb3pAbPG4coUB+NsbSan0WqBMf9PbEk+Wme
	yI9RttsULOYNb0lqWjd+hMpyObQBPOXq+0Zr1NombEaIjRQkXbWtW7bHRz6CvQcka5cQzrcjAoOdF
	/A3Zu+9UEhfbA6GXIxh4H8k/1a5vr9maIl3fEq8ByE/bnexwtdLIFE/HHD3sLag8UWhrdLF2/qktH
	HhlR0hSfFKNEtMP3UQpifV59UugQvE5j2/zsCJO+FNNhSNrwOzU7aE8Vm4ipmBH8TQ1z2BX81LDpU
	dNLOxT4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjxsJ-000000040xa-2p3V;
	Mon, 17 Feb 2025 09:57:15 +0000
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjxav-00000003xdt-0rQP
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 09:39:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii3AGp9dj1FXUQC/OGc14G1ymd9GfKHekGcWPYCDeLaeOqBnVPYJk+VRJljUSvuidI9qcTQxReeI1MN4zc0MCwjKfgrYqHfDPMTm+1yys0sngLquJYqF8iOkTTqHSz4cGQ7gHZXSkMrb5HrpZZbWxRbBlp2cCW1lKb7GTQhiChl/JezPTpCSVq1cwsqTLlhI8MSk6Kj3dmugYiNWm56QlAMeFL6cfy3U/gIrMdsaSU9pBIxeSk8kEwtvVNup8zjDUEt7FSLgxSp7RH4Qqcb0bHzCebX1NXdA+DiuPECL1jeZlug2qsWE3zebGulSiWucu8XRVlKUNlz87Yt1HFqHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4ZnQrwUdmWft7s/kBlYVsHwV//zkBhmzwbtTAlTuUE=;
 b=aYI+GYvOhBHuhQI9tvljqc1dpqWVVVYVEjI6WqXUATyJbemCJXqqnIikmX8G74O8jb+Zz16jWqLFA2FUHuUHuySAIwUlhFipRrE9raisogpN0p+pVQeKM5J9M/R4wCIMeix8IClxUpEq+ALpQv1s7lZ3nnUrA30yBLKAbtWV5fOZG63pjmHRH7n3s1n1z2idOV6ODNSdm4HegiKZ3D4wbo4PVsWTeVxnusxGXmU30+Xn5fGXR1kmo8g7F2zdJBGB5LerBgac71c5VLZxW4cVMN4TWUMHbJ6ZTFt4oVpRGuXY9X4FmmX+CXUGSvMwL5bVkhnnX9T7XQxKb7eXHSj8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4ZnQrwUdmWft7s/kBlYVsHwV//zkBhmzwbtTAlTuUE=;
 b=CsSkt55JSbiNYol++EoS+khRuPG3S5oWbk6dXQDPU1epqbjh9v/1DU+WfbypPRDYWZXjYML7oiwh1XeScHZgaGEyNLYIi4T0oEVQtGSc9CtTHbmKvU4vZ9kcZDSnO/oO0lLudYQpPn8mntIGUguTknM0ElQA4Q8cBVWYxsxH4dRcQ2HTIBTxXPbNzBrf/uefpgWqXJ0f+7R4eZnk5cL/lHhXL/xcODr9vdH1HtK8GoSScS/mczSeDMBaZXFAcFJBqh308nDIk6KMJ0rzdlVXQNRTmS/rX5Kn2ULhtLrbB6S+j8FCvd+mbUNnDlWkHKzk+5wlyT0zCvfXzG5e7cutdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:39:10 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:39:09 +0000
Message-ID: <2189e14f-ea0a-4370-be96-50a8293bf3e6@volumez.com>
Date: Mon, 17 Feb 2025 11:39:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: Enforce update ordering between queue->cmd and
 rcv_state
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250216150804.1542552-1-meir.elisha@volumez.com>
 <4ae86f5e-e684-4f5f-9331-0c2b83ad49cd@grimberg.me>
Content-Language: en-US
From: Meir Elisha <meir.elisha@volumez.com>
In-Reply-To: <4ae86f5e-e684-4f5f-9331-0c2b83ad49cd@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS8PR04MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: df5ab38e-d50d-47c6-fe18-08dd4f36edda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGdXZDE3K1Nsd0pIK2pjQmxKQjV3SXgvVjNQd0tUL09ramY0QmFkdE0zN0xG?=
 =?utf-8?B?SHJsMXBuMllqL1BLdFhDVXB5Zkt2WDZwWmxkbWFzM21UemxKZ3NJU0xqcGdr?=
 =?utf-8?B?UU1qYW15WnRackd6QUU4cTFKUlNUdXMwaE1uUU41UTd4RzZzbE1BMm1EVzh2?=
 =?utf-8?B?UEdyZDk5d2xIWEI2UUEyWDdwZTF2dUZVWjhWZmNDbHlKN0tRallUTDFjRzN2?=
 =?utf-8?B?WTJ0Zkc2cXdJQjBYWCtrdmFvNCtLQjZ2a0FOeDVNSU9BZHJwUXg5ZTBHSGFl?=
 =?utf-8?B?c2UzQi9SSVA1UHN3QzJOUG82SUFsK1ZQeTV1MHFadHNrL2c5aGt4NTJDMUJl?=
 =?utf-8?B?Z2poeUJiTkREU1BLRG9mNmtzRjdLcDRBb3U4RUQ1bDNjZWZEODJKNmNWd1d0?=
 =?utf-8?B?dkE0UHBraUpHTElkZDFXUjBqK2VNbkE1NURDV29uZ0pzUDZkb28xaHVDejE2?=
 =?utf-8?B?RHpZL2U0b0h4bmNZd2pPaTROZFVwVHlqWkFpWC9wd3J5V2Y0cll1UHVDYmhH?=
 =?utf-8?B?L0t6NmlmM1V3R2dhSkwyeW5DdEtJdlk3UDN6cDJ3WUpscFAwTXYwZWRjQUJq?=
 =?utf-8?B?RXRlWndiNlkrV3Y2TmQ0dGN1QWFRUnpiUUxFR0kzUFhxZGdlazhzT29Vdzgr?=
 =?utf-8?B?dGFuYStSRGY0eCtNdE9hVG9FbmROSDNGRFhJT1BLSDg5NGR1QjBKaExTU1ph?=
 =?utf-8?B?ZUM2VzdvaHVSM1lwN2dUamdHbXFqdnJjTTBXOUlVMmlkMEF6VFgwVFgrbG5r?=
 =?utf-8?B?b1FXcndjWGdSdFhlSXh1Qi8vSVc1L2N0eGJmUGVUQU5FL0VFM29Ua0JWdlQv?=
 =?utf-8?B?bUY2VExRMlBVeEdHZXN3U00wRTN6b3VBemk5UWwxN3I0WFNwcTFreDVxYnZa?=
 =?utf-8?B?M2F5blZ2bk41djFNSW5HMUp5eEVFdUlwSG1jQ2RRZkx2WU95YTJManB2akZ0?=
 =?utf-8?B?T1cvelNxOGQ0KzBGSmJ3U3I0RHppMWRreVJQZ21ocDVJYldhem8vczVNeTBB?=
 =?utf-8?B?bmFjWVdhc2g1RXBRc1dXSTZyS2VrTzNxYTR5M2dEZGE5RHNwWmVUbDBTVVo1?=
 =?utf-8?B?c3JmVEg0QWxpK01wQ1I2Sy9BZHBGSXJ1OGVRdEMvMzZsVitLdExUSDM0VThT?=
 =?utf-8?B?SXRScjJYUnB3bU1rTytyOUVHd0wyY24ydm5adTdlbElKSXF1TWMySk90WWQz?=
 =?utf-8?B?Qm8yMVMyaFI1R29JRW9jRDJpNmUzTXV3RXNaQnlWMmZDQkZvWWtFbEJwSjdQ?=
 =?utf-8?B?ZFNEb216QjdZUGpDdURaWnhHZ3B0a1dKeUtKdXM3K2dORzM0elZ0R3FCNDUy?=
 =?utf-8?B?UnJ1VmRtUXpkcDhBb0U5L0ZPV1hORW9lUGpIOXdmdWNBdzNqZDhEVS9jV1Jl?=
 =?utf-8?B?a3NTUmVVRnJJYmtkM090c0VXYXpZNlNDbVY3REZ5WWxNS1d0MnhuTkJpNElF?=
 =?utf-8?B?KzlQY0dEZTl4bUVrU2lPOWR1N3A4Z3REZ1RLVS85amNxTGp2TFBTUnZGTkQz?=
 =?utf-8?B?VHZBS3I3a0F4VDZlcUFhRm4zTHpSdVNrM1F3aDlPV3JaM25rSWNEUXJwSlNt?=
 =?utf-8?B?Z2Z6cU45ZmpjaTZ2Wkt1VE9oaVFxdE96bTJ4aXUvQXNiUTgwUHhhcTMyeDdw?=
 =?utf-8?B?OTdTa3RmWFB5alpHRDN2bjZoWkJNdVNMeWF5SHN2NUYwOTZTNUozSlM3WnFH?=
 =?utf-8?B?ME90d1ZpdjR1Zzc0dHFNTjF1Z05TVVhoVUxidnMyMTBJQnZmRXJpTFgxQUx0?=
 =?utf-8?B?TmxPTnJveGdueUNaUkhPSnRhdEhoMmszaEE4bjM3djdoMEViMGN1Q0liUW8r?=
 =?utf-8?B?MXNsak85ZXExcStFZ2lESkZXUzVpbHFLWDZHODNkMitvYU00THMwaE13UmVX?=
 =?utf-8?Q?NWuKQn4PWGnaO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTFqSnlQUGZyRGtaUUlVWDBsSXlOd1J6V296d25WbmhHOWQ1K2ZmUGtzQmJi?=
 =?utf-8?B?bUhLMkJXTWlTOFBQOVZuSGE5VTJLMm9EK1FWTjhMMTd2T1ljUElzMTRWNkRh?=
 =?utf-8?B?N0FpajRyaGhzUmhyMXIrWllTSVBweFE1aWtMS0VId0JueW1tSGtvY3REM0Rx?=
 =?utf-8?B?bENUQzlEK0tSQ1FSVFFVY3hNZmQzSmtvRzB2Z3hFSTYza0VvMlErSzdHNDZP?=
 =?utf-8?B?Qml5ZS95OThqdzhaajlCU0VBellHeUdsOS81U24zTzYyUGdSazFnbXMrNTdF?=
 =?utf-8?B?NGlkaloybFVwYnhxTHhLTGxPQlM3K0liRHlFTHhlNFlCTU84YU5zZzgxMWZ2?=
 =?utf-8?B?a3kvcnB2THcwL0NyU0lNRkdaVXhBMldzb1FsYkJFVUl4RmwyZjZKVHoveTJt?=
 =?utf-8?B?a2ZMK3IvSk16RU5yQ2c1OHpoSnpycjlqVURNRmwrdzRKWDVDU2pzNUwyeVo0?=
 =?utf-8?B?RHlXaFd4VjM4TERWQmx4YnRCQzJueTN2ZXJOYm5CZXIwYTMrclNvRXFzZWlX?=
 =?utf-8?B?NWVGOUFNem5vbmxDTllueVVaWE01Vjl6K2ZTNFlpZ3U5OEdaTVlPRmlCNElj?=
 =?utf-8?B?a1MrUWlwV3pGL3lSK0lGd0VDOEg1eGppd0c4ZUZwLy9PdU9DSUJscnFLRWo1?=
 =?utf-8?B?UStIU21SaUlKeFRGeElEZEJDRnZoejRxYjV4Qk8yS1BRMmFEQ2xZZHErUXB0?=
 =?utf-8?B?L3FsbEdFSk9lUkVOREtnSW5tZ3JYeDZFdksxVmVzeTNiT0FScVdCWHJjYjh6?=
 =?utf-8?B?cy9aNU5OVkc3aUhqQWpkR202ZXRuUTdJYk40aVNvT1l0SUVFdllacEUwMEx6?=
 =?utf-8?B?SFRDWG5XUFh2SjFwRHQ0YnFtRi9xMkRBR1E5V1UxUTNLZW9qUjhxeFJYTHNK?=
 =?utf-8?B?Z0lZWGlrbHFHd0Zxcmw1Y080TFdTeTByUU1nOHlOcURSUFpZRGxheFBQVzU4?=
 =?utf-8?B?alA1Q3lxRGMvb3lIWXJheFNvTHZYaXd5dHRCSXRaRGhWa3ZDemR4UUE1cm9q?=
 =?utf-8?B?RkJmM200VDZUakU0cWZOempCSWkrK3Mrb3RSQVYzVUxBNmM4b1hGeWtBNURr?=
 =?utf-8?B?eXJicjVjL01Ec29FQVJhYXdtQjdPQy9mK2FJRUlXbXVUaFVqUy9ETjFqSWZ5?=
 =?utf-8?B?SFRSQm1xc2dKdkMvZ0hWNFJ1WGNRSkNic2dlcFIxcHZVWmxmMDJUUFJJUFg1?=
 =?utf-8?B?S3FHWlhwRkxvVVRiQU9nSk5BY2NrWDBTUDFrQ2l0RHJ5Z2Nmc1lpVTIzNE9o?=
 =?utf-8?B?d3ZQODgxWVJIMjVPWkRYU3FJV2ZGMWZyVU1nYVZXcDBiMGZraXpEOXd5VmE1?=
 =?utf-8?B?Wnl4alRldXZKcnFSdjdKS0E2U1hXT0dRTFNDMU9VbTEvWmRKUEZpZk1ROFN5?=
 =?utf-8?B?blpwcEhVT3NOa2tLYVRqTlFHTjd3M0MzUDNCSWR5Q2FFaHV5eHFYUzl0WThF?=
 =?utf-8?B?NWNjcGJqY2ZVWWpJeE5KTzQ0N1Y0MUprc2V6ZlF4cHp5Sk1UR2hFdXRXdGpO?=
 =?utf-8?B?QTV5bTRvSGp6cHJFZkl5Nk84R3FDSjd1TmNzNVFDczU0M2RQZW53bFgwSjM3?=
 =?utf-8?B?UXRlMXVwSFduNVpGamJ5YmNsaDNET3RIbDhFc1g5azZQanJHWXo1WC9yWHdH?=
 =?utf-8?B?NUFMOUNJVXYwbjhQbUZRY0pJS0xMSnJLT09KcFdEVmZKT21vRGRGYzRhd1h5?=
 =?utf-8?B?ZG1lY1A0N3l5ei9RZFpaUEY0a083YzJCbkdibjlmVGxMMXNmdm45RFBHQzYr?=
 =?utf-8?B?U045azBvYWozZktRSXFTeXZodWp6b2xybnF0VDlXUENRemlxaG5xUmlMeHJL?=
 =?utf-8?B?OFlCR1dTeklJSUUrNzhpTlJTZmorQXRFYUcwMWpOdXRDcVpibUdMRTM0Z0Ft?=
 =?utf-8?B?Nkx5V1Z0QzBTZE1QMGkwajUvTzVWTEw3Rms2bjhLT2NHNUJxRkxnRnh1OVJI?=
 =?utf-8?B?akVRRXpQL0o5YkdtckxZakJFOWZGNGczRGFPU2txMWFxdDcxbGdIVjF5dkcy?=
 =?utf-8?B?MXJ2RCsvTFVYQlY1dGdpcGRsQ0NVcEJBUDlHTFRvd1kwcmh6b3o5ayttZUdK?=
 =?utf-8?B?WXlyVTJnK3kxWm9BS3JzWG53aW04V1lxazQxNitxaENJeVY1djBMaTVXWElV?=
 =?utf-8?B?UTBsWXBZb2IwNEE4clA1Qld1UjZNWW1Vc0dHYWJESThCZUIrUjFYQzdYYlo2?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5ab38e-d50d-47c6-fe18-08dd4f36edda
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:39:09.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeqD/QbnY/JtnS91AnhxIDWWviSyac6r2ed2qM80gg7l01w0wuV8+2JVVCAR3AHeAi5BRIcCZy0rzHWJbawLBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_013917_255050_65264747 
X-CRM114-Status: GOOD (  13.88  )
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



On 17/02/2025 10:23, Sagi Grimberg wrote:
> 
> 
> 
> On 16/02/2025 17:08, Meir Elisha wrote:
>> The order in which queue->cmd and rcv_state are updated is crucial.
>> If these assignments are reordered by the compiler, the worker might not
>> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
>> the correct reordering, set rcv_state using smp_store_release().
>>
>> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
> 
> Hey Meir, thanks for addressing this.
> 
>> ---
>>   drivers/nvme/target/tcp.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 7c51c2a8c109..b66aa93baaf4 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -848,7 +848,8 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
>>       queue->offset = 0;
>>       queue->left = sizeof(struct nvme_tcp_hdr);
>>       queue->cmd = NULL;
>> -    queue->rcv_state = NVMET_TCP_RECV_PDU;
>> +    // Ensure rcv_state is visible only after queue->cmd is set
> 
> Nit: let's stick to c-style comments.
> 
>> +    smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
> 
> Isn't WRITE_ONCE() enough in this case? We don't really need smp barrier here afaict...
AFAIK, WRITE_ONCE() along will not guarantee ordering of those 2 assignments and not
the visibility across other cpus therefore not solving the issue.

