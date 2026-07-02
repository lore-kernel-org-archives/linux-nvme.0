Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A28C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+8yUGznl67YQjRY6FbG+bDPmlxeWTKvi7M/44ESusg=; b=U21PwokG2lcDUQcX/Hww3DMx36
	1wWYZvU+eD8ychX6XNCF0nKxzVbRNTBFwg1XbAXv6rerpydP7lDowq7Xzy39BgN2yu73zuh/6a+6c
	UoQW3e87Byx4beBHPv40SJYs+TyamOBBsijD0bfAmyhwqA+R859JinJThkzV1cSWdxHeBBtNbKN8Q
	py5zwy79vem2zYxx8PpT/6FRA6LHNJ2lcVxk/kIYnBt2iU8WDDnTtRvJgkXRJyH9C8Ex6zqVl4kRS
	aHOpxO1rfv73oVEtwoGXZPWpbGM3OUM2pRxGJrAUo5GzS9Q9gb3bOryQ3qTHM7+DWrsnjvLRXgJB1
	dp1KZNeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfOrF-00000005W8o-1IJT;
	Thu, 02 Jul 2026 21:22:05 +0000
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfOrC-00000005W69-1Mqn
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 21:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r75oXgeWgkOElKSiRS1TQxdM/lsoDDWABL5YY8vZtDcN0WUf/I8KWkY5iptyBfBU0XuqYTJrJoGcrUpqml43aWC+ZoT/TfxGR3Pxjkyxfm7O5OFRwywEfn23TVOukseR9lm9qZ7IO9/IbKkyTQqJ1HJbnHbvyCtQ2H+/k1bryQW2+52m05OpbjfagKvT0OrEm/2BixdYITutsKYs8JkBZ7nCtn02FZgLYAla9ywy2bwbQVngJjkeeBvHnu7pOlk8f4xSRnB2bwPzj2Xa8P+bW7LjiDn7SfOWWhTy8HxIxiUrq5Z0P+hYSDOHG4XxnobF+zqnblgHDa3ZdRWFAiMc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+8yUGznl67YQjRY6FbG+bDPmlxeWTKvi7M/44ESusg=;
 b=OQIziFgk1pTFod9s3Kyk4Nb55k1/Kk+acw0sEZ/X4Zr81HcWgcoC/biL+JXtd78kigTQYU2IfXH5Msqt9zKH+7grhcy7xpDdYjEPc+zK8YjUouNsa2CZHNaWDuWerRTdGRDDrSp1fcpRL0QojOfMJ/GO6ZcTgubes6jGcbciLbUm5gqJUJ8WZD3cFXEFR46LBVrfSwV5Qgm+mTKPQWjeHGa7HzwMBOyD8Bzcx4OVk7Cdvb/YgDpNyyGRn9Klzdz903CZDR7DHqXe8dPIt8/Q54K+1bZj2mg9dLIdM8LIcFT5Hnj3F1FPobPSZlACoX0zyOwRmJWwXfddKnOalwKRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+8yUGznl67YQjRY6FbG+bDPmlxeWTKvi7M/44ESusg=;
 b=tLgCT2B2uLSWbxJ+obL9rB4Kr3gHghRpg3aZAhYnLJoLz/+piOyGwjpJlBxq6kOoa/3mm+J/itj+ogWOlCGSegVFJ7d66HkXWNClT/peceWaaBcSGbOzSkRXFJvKwIV9FUAsEehmdibTaO7scDMlHpYuVJ3zMTq0zPEfMc5lJLZzXiPVNxawc6XqddnUZvK7+iOFr9VBLNNTxQTTgxUO0vq38SwylS5XhiuK5TtjnXPD50oqx3hO8VLLX225ShyHMG5GtkRmOZ8joY1DE3K2f4TsOMA5UljgMpkoPI5D2fJyDOit6/xBHkdYNqpaidw3RMjct/lP0qtHknnOlIH09w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:21:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:21:55 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:25 -0400
Subject: [PATCH v3 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-5-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
In-Reply-To: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=7972;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l49mJ8yRJQQ+wrhGEsWXPZBxZXrZnWz/nKfG4HsBxLw=;
 b=ahJjBMD9P8QQWg8D7DNWs/yOk+JH56GzPs8Glmex6IS37mcg9/cOR4UHOoS3gD0rN6cLd5nC5
 XCIj8kgf+MOCYTQ53+I4WkXrxFeO4Ec+WVBdl3/OAK0W7xgqIl1NYv0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0148.namprd11.prod.outlook.com
 (2603:10b6:806:131::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 178ecfa7-f405-44c0-39e6-08ded87ff155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: nZLrf0UOJVyr62F/XEC2ORltx5JLoLb2s4w8fg8TERvnOFKg/g0B7XK52IXmOrpAukFo9qHAjp5JYal2wvEJE1OVGQX2P4c43CDLikvbYifhGSOXYa2bF5Qkpv92lL/wJnetrRkP76gnE4juPdEQPdlivet8SpCT+SZMKP4h5L1cUuK/HjPMJO3XJqVm9J16soIe2w0C3yPHuv6Q6v5wzZmegtcekgf1hgYZz/vgv98RuhQCGbjVp4mxHiCRxyiFda2tnhTZ2JWwm7TXTpJ2aPk8gpveHvYUp9voqacm5wg76N5b6RJ65K4uDc/nhwe+YF0QA3kLB+w+YYApmb0pfnvhCH6aenPde0PCLR0opQKerQZ3rOfDX+XBKmr/5MQvU6i6lAwVZmAg0AVr+i06/jkPmoadEpDB0dYIJQQJRpRqeJviGful5qXouVcgjcunLfZBz4KhejNmbshoGHgLTKhiZa9WPyz9BZ9A+1fAZjqppw3xELIqXz5Paonum1Dto2LaLuhj9zsZslgUHw0oHe9XxCPq7mAO//Asz7/WDhh+fWF7DWwC0hy97P01e0ywbuduhv8CuzJD9jGnwvrUVM773nRW8lQLfh9KAjOTxXV+DuRGbjPCU/eqwoeIJkxEw9FlSAumw/uUQE0wlekZqbkwed+99dclpZ6T/Rc1H9KPlyzj9hnGvGZjpZeH4NVuDtCEAAW3/C/Vz+YX36Dj7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29yb1BLL3pmUEg5dzVvSGJEdGZ2RkxHV09WV1BhUDliNnVMSGJLK3pmZk9T?=
 =?utf-8?B?Z3BLaFg1SFBCYVRhZXhHa0xKNnFzWHprYzNsb2hyS3JuK2NsL3FXNHRRTmg2?=
 =?utf-8?B?eityNzFyWlJkQ3RKV01vNkpHelA0MXlhMGVldjhvS1dhT3FSTXczanRoNFlu?=
 =?utf-8?B?MjAyWFd5OUF5UXI3QXoyNUhNNVgzWFlURm9VMnJNTUp0UGpFQWE0ZmVmQWJz?=
 =?utf-8?B?UDB1clBuOEh4T0R3M1BOUXZMdFhhaGxOQWZqUE0yRVRkeXV0M1JqWDg5am1j?=
 =?utf-8?B?WDlEaWNYUFZITklNcUFjOHNyKytCZVVXRWlBRUJ4L2wzeVNuSWc2WWt6MSta?=
 =?utf-8?B?SDkzWmpleHdKOUFGTFRjdGErdTNBQ3dIVE03aENqVEpOS054R1ZidUVWZU9t?=
 =?utf-8?B?Ui8yVVB1czhxWjM4aVp5QkZ1ZS8vem1hSzNDeXBiQnlOYkcrOVozTWlBaGhu?=
 =?utf-8?B?NnpsZW83YTlUMlZZVjkzQmdLYUlkV2p5MFJZMEVCSXJOTWtjZnpVdjZvSEVh?=
 =?utf-8?B?cy9GZ1UrclZKbzhHMlJONzhHY2pNWUJvRGJNZGI4bUhCTFBtK1dFT2RkTERq?=
 =?utf-8?B?NTIyQTlBdXh2bE9na2ZsMlU1K2ZTS1BEUFFhNzZlb3VkTEg4WGw4SlpJTkpw?=
 =?utf-8?B?elBKYlFMUVdsWUEzd2lPcFAveld5eFk3ejJrbm9QSnZ5VEhKbmdEcHlFT0dw?=
 =?utf-8?B?Zzd5Ri9DQXZyWjhZYTEwL2p1c3NkVXpmbk4yaFY1bTNpR2dURlRwbmhWTmFw?=
 =?utf-8?B?ckEvWk5MSkRHajREdDdTOGJ2VE55djdpYmNETGZwM0pGTFFmZjF0YVJIcStj?=
 =?utf-8?B?QkJzM3pMTEpUekNjMW5teURMZkhjUVpqVVdnUEJqUnVLcUpOUC93bzFzVERD?=
 =?utf-8?B?cDlPaU0rQTNoUEhwaS9Gd2hXV3d2TXIyU1VBajkxb1VtOWZMRGxXYWpjamk0?=
 =?utf-8?B?a3VINjF0Q2RHSVEvWjRKRWliUXZwTWN1UHhzZnNCdHRscUd0emZpRlp4bnVS?=
 =?utf-8?B?OWwxQW1IRXJ1QjJHZ0ZBWC94b3Z0T3hFQkEzb1pncnFSY1dTbFphanZINWxj?=
 =?utf-8?B?c214UXhVNHNOTkdvai9KaWVidVN0UVdPMkMvR1BNODh1NGpHWG01M29OZU1S?=
 =?utf-8?B?RDBMSnl3cGhOYURMakdER0M0UlplOERFU2lyajFnWFRkeXBNQjhSQnM5WlVR?=
 =?utf-8?B?VEI1MG96RlljdFNyU20wOG9Jc3NaT29xMlh1R2dPOStLTWVqbmhZK0dOM0h6?=
 =?utf-8?B?Q251aGxkWHVaWmJpTkVwTnFVNHdkazR4emx5M055NjdKYjNTYW96UDl5WjZ3?=
 =?utf-8?B?Y3BEZm1aWHdoSmY5bmZlSjdmREljOWlUZXY1TmhUaWV4eHFhZVR0clpqYzQ1?=
 =?utf-8?B?NXJyUk05UXhaNUxmd29LWWJxS2FnSGIzdjJadlFXbGRCN2Q2a1ZjL2lqRSt0?=
 =?utf-8?B?bzZUeUNybDVPTkpMTUxkZ1hkMFJHSUpUWUpzMnI3WnBEV3VMZndzeXRwUkpY?=
 =?utf-8?B?bmtHb1B3RElaYjZyVlBBVTQ5dG9naGJDWEwvbmh3Y3NtYlZIV2htSnozakkv?=
 =?utf-8?B?R2phTnlzbU5LYUZsb052c3FLaE1WN2J1bmlER1ZCelNXekgzdjlmbWJnNTlU?=
 =?utf-8?B?S3dLUkc3c2Z3dHkyelZiUXNhVmlSelRLcDlXYW9vUWRmb09mOXlCajFpYlk0?=
 =?utf-8?B?ckRXM3MrY2ZqSDcwZ054bWhWZ3dNVGNxTU8zTWJIakphMTVYTnVhU0g3UFda?=
 =?utf-8?B?RmFnSnhmRU1yQVZCMnp4VGx5RzdLd0EzSURENnZlVjhDYVUyWFNtend4eXd2?=
 =?utf-8?B?RUtpeGo1UFhkTTMzWE5YWnV1ajB6QWFIQVQyMFdOK2p6SFRSaC9DbFQ5S1hO?=
 =?utf-8?B?T3R0MnBvMjgvTU5IZzNlWjRZTWloV1VJQzlFdjJnYlhiUVhneWNnalBrblNW?=
 =?utf-8?B?RGI4cVYxK1prc2Yyb2poUFJhNXMwaE1FSFdxeGVmUHVUZTI1b1lrajFLNVVw?=
 =?utf-8?B?dzQ1THBWV292U0grbktOTUlDMGJtclFrMm5OTjRHY0lOWHZWZmhGcmFGRDNG?=
 =?utf-8?B?MkJ4S3JUalFjb0kzRmJuYUxFeG1ZWjIrNUJqMERqU1RrblBxN1U2cU5JV05K?=
 =?utf-8?B?THZjSVFqUE1Vb0ZqZFdNMW1yTitqWVNRZmNYNVY0d3daUTI0VnpUeWpyclpj?=
 =?utf-8?B?d0pxVExyY0RoWFpxem50aTdqNlVLNnc3ZC9xb0dSRFA0N0hkMHZiMmtQMVpp?=
 =?utf-8?B?a0F0UUlTeFJkcE92aFI5MWMzL0MxYndBNUJ4WUFkQmFhaitCUVZNeGhBVGJB?=
 =?utf-8?B?Wit5MHhOZXlGcUxWUThDZDN0VHRFWFBJaW1KSG1YRXVnYkFRS3B5VUQxRzBC?=
 =?utf-8?Q?MTRqfoy6HhaMyQn1DQUsczWyEvRjlcAlseZnK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ecfa7-f405-44c0-39e6-08ded87ff155
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:21:55.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xySvBFCtJLXG6M56UMItJ4tPY56pG2kEwwAuXLOER6jMOfBtkWjjqG0V9Ybz874Kxem88OWCC6KDlhBlKzpZMDf9/GxTjgHKcWUMJ6V6U7zNnnYrsz3DNTg3rvDZacZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_142202_379598_4AE5B7FA 
X-CRM114-Status: GOOD (  13.48  )
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

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 128 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  54 +++++++-------
 2 files changed, 93 insertions(+), 89 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c341aa5343417..8d38867cd9983 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,67 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
+	u32 tmp;
+
+	 /* Enable engine */
+	SET_RW_32(dw, chan->dir, engine_en, BIT(0));
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
+		switch (chan->id) {
+		case 0:
+		SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en, BIT(0));
+			break;
+		case 1:
+			SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en, BIT(0));
+			break;
+		case 2:
+			SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en, BIT(0));
+			break;
+		case 3:
+			SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en, BIT(0));
+			break;
+		case 4:
+			SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en, BIT(0));
+			break;
+		case 5:
+			SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en, BIT(0));
+			break;
+		case 6:
+			SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en, BIT(0));
+			break;
+		case 7:
+			SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en, BIT(0));
+			break;
+		}
+	}
+	/* Interrupt unmask - done, abort */
+	raw_spin_lock_irqsave(&dw->lock, flags);
+
+	tmp = GET_RW_32(dw, chan->dir, int_mask);
+	tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+	tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, int_mask, tmp);
+	/* Linked list error */
+	tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+	tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+	raw_spin_unlock_irqrestore(&dw->lock, flags);
+
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+}
+
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
@@ -366,74 +427,11 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	unsigned long flags;
-	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
-			switch (chan->id) {
-			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
-					      BIT(0));
-				break;
-			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
-					      BIT(0));
-				break;
-			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
-					      BIT(0));
-				break;
-			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
-					      BIT(0));
-				break;
-			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
-					      BIT(0));
-				break;
-			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
-					      BIT(0));
-				break;
-			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
-					      BIT(0));
-				break;
-			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
-					      BIT(0));
-				break;
-			}
-		}
-		/* Interrupt unmask - done, abort */
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
-		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
-		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
-			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-	}
+	if (first)
+		dw_edma_v0_core_ch_enable(chan);
 
 	dw_edma_v0_sync_ll_data(chan);
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 156b1cc225091..31bbdc6a40642 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -194,6 +194,34 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	/* Enable engine */
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+	/* Interrupt unmask - stop, abort */
+	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	/* Interrupt enable - stop, abort */
+	tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+}
+
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -232,33 +260,11 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	u32 tmp;
 
 	dw_hdma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-		/* Interrupt unmask - stop, abort */
-		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
-		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-		/* Set consumer cycle */
-		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
-	}
+	if (first)
+		dw_hdma_v0_core_ch_enable(chan);
 
 	dw_hdma_v0_sync_ll_data(chan);
 

-- 
2.43.0


