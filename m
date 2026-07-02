Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA75C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 21:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJhGCNd/L8Wx4DWMiwpYcr/VGk+Z7O0Xp+9EuiYavJ4=; b=NZueKgn4kYOBxADY1YWDCwwWK9
	WgZgZCdqVUAb7wTweBZ9hhZNxvydeyK+mZmuDo2EfRWCEw6UcogQ/JgG+8Mrp83o8oKEKJzNPfgTw
	haj2iTU16WIk0e8+194tIM7DJov6tqlwRT4eV+ajZNagKQfNQ3mi3pAxy8aRo5XQB8foEfrT0Gbft
	z126selOu3149icAKtn+qSwyV4rFAYWmFhlpmPbFs8RsHk0hHdte7Abc6l6U1aBIt0jJLtHrbdPZM
	2OYSRpbOi6F//hh4pIaTDCBzZtLEFgbAl+dYcCUsoobcVxd8s8dsCGBrGsM4/CN4f4eGMA/Q0t2p+
	iYe+20dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfOrW-00000005WKo-0sLi;
	Thu, 02 Jul 2026 21:22:22 +0000
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfOrT-00000005WI0-3Ce7
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 21:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXyMI9YmQDWNv46AuH/b86GqKJ7FyK7/ZK5Rlp/a9EQ0M17jqrrErI3Nizm03qo8+YvRoH3W7ADgVJIHh2vjVBW4G/HbVHf4bSfirBxDtYgYchQnKyvXCcdK0KkUqe1gwxGZxp2cmU4SzUEuEJX7gY27fe4gk+foxG03bjG6qV9nwhXQSblOLtzn3nmOGozh8lCpBxyJ3HDlB/P5yV7YgAAaAgmH8awzmTg5Tdyjbc9LwFrHJzBotMJ2x4VBJhn9H/3lhMqnE7VLuLDwI5/JZWwx6riEgVLxH6yfS2KqVYN4/hWfrymt6q8XrAem1rW33XYm+p0On6ViwWP4Lf3z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJhGCNd/L8Wx4DWMiwpYcr/VGk+Z7O0Xp+9EuiYavJ4=;
 b=hKCGPZTbPXMheaLI4G/QB/4IU4mxjh+XxzrBH5/d+2RjYszV8PovVMA9yIT4kJkemgjcKazpaAGkUC7TyODDQ9xHeGo8KLnqQ+i4j2vJJE+cdM1GAiqg0EYyvkrMQ6INWSve6aPpByhovwvU7d17Q2KlDOhRNSB09RFzU8JfBvwzFWpk7srnJEPY70VOGwG4DzWSZN1uN7j9eY6KeXv8eezwO91SEclpnD6ecCEsWKMVd+fxw8jG4YrDBe+6sXQV6MONAFmrOX0zaw0Lj8nAznJCjWOTbF5ipIT79lK8t+lOVyirBLsPCMTR1q0DH6CK1cQSKElEh0M7NEZ37Xcr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJhGCNd/L8Wx4DWMiwpYcr/VGk+Z7O0Xp+9EuiYavJ4=;
 b=YZ/QEZOG/IMXau8w9uLz3N4eO0gCB1NAkledezacQS/NAHEucydb8am8vceUx+noPNezD01I026/PYod9irNA4ORgyiyRTewvOWhLw0raaXIsnrLjmBy+6+Be2xFZoavlbi7UVKBEr9arRd6EVbn6JS5udwqc2/uryweULGXx7FienFtRG3XsxiPUj6vLBZn7U91+68+QQE17J4zKRRKFf53ElM6ih1itKiA20SSFhGdhjeAHTs0BK90mLWiKWo/o/9FJHnjbbr1+bz5R7Qe6M8Hd9V3qYhNNJUh3myZUdYWWlpNIt94PaxV6T+5BOp34U/VD5kHiBlwncjk7043oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:22:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:22:14 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:29 -0400
Subject: [PATCH v3 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-edma_ll-v3-9-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=7927;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iDEfXkRYFIfNvfL/UTp+hOxaunFob8tLpQNwIraNjGo=;
 b=keT65LiqdMYAB3RvTchqd2QIDYOvDTEoCWCqFAcnP/ULUjNne2xB03/Xe8nS7Z5lMD6ZdRjea
 sdoP7zJ5ctHAit6aJRv+GnATqRAR3+a0SDELB8FVLYThmPK8tPmmhZS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:806:24::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 729c3c31-b084-4ba0-f31c-08ded87ffc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: wSRUOq1yrd/syjqid460aAgpQCYsfz8WfEGuvj922IWF3gNfms/aR/p4wTdZ57yj8SaJ1KuY5xdDT/JCRL/mwEung3XOH3hOsjsnSiA4WN88jQPNZJnA25muKPfdSjxS97WvxUA3qVrJYcFwhEDMJFC4Qm3TLUSo75HELsc5t8dgKDjbjnP5TnkA3Gr4YVKJnccmSb2W6SwJEbLjcpIp+F8sy42UMnEKtLw2IeaMDG9wp6uoW5IJp6iYv1BN252/pzAnOzVAC0latsbDe4sMCSDY/fTaAmwor84BviHLCJm+6iKRlQa+rubTLKzwsZRtKLN4cd/ThGcB6PdNaINxCSkk575B8krhyOLj8SuCZjYZqHjABvdksEI2BWLlLpBtlEUvOZAkJtGRTj5S7K9SIkn+HZwvKRO3bAmFDPxhoH03sQCEvYEBznSiGYAFDx+OK0Y9mdo7Zm++zcv1U/TxyZ9U5d2XkIbOid1Nh3NTV9AF4kHuSCqNkSIEb2qNDiZjtgfheLfmMYJna0A48EOJas3HdZNDzl7zksIC9NQnZrfMYNENORxjLymRn0JRM+o5iI+1KXOUYrSWA9vD/BHjJqplCmUCfLQ9lQu0WU5t8Pz/V8xtI4k3x6vac5J9zEbCWc6XyrHjetCpUB4Q0MNifaWBaQAUdjjaG9iyJll5tSsgHOlCNwFNl+1nc8Zix677VhuSUuiuKYlfmR6G43+zqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lyt0UUw5eldubkNDMXJFSHpJUXFQaEJmZm1tcXFYY1RZNC9PeVVpSlFXTEIx?=
 =?utf-8?B?M3lPTzZ4QTAyaS9sbkFNc3lFSG4xY1g1Q1Bha3o3WE9adktOUzF5ekdsTk5I?=
 =?utf-8?B?bk1QbURHanhFa1F6OTdWRWliKy93NUk2OGljOTg1cE9NaWxqdHQ5aTBhTW1C?=
 =?utf-8?B?K2pvV1F2cUdWb2FmU0wyL2JGVzJqdnJMNGF6cWU1SloxRXVGR1hFenNqeXJC?=
 =?utf-8?B?SSs0Qm1aMXZub29iRXNnRmFIQVFCOWhtRjRFbkYzeW8zOS85dnZCcXgzNlVE?=
 =?utf-8?B?NUpJaU9nQXhLNndCd2oybjBSUk1KVE5TUWZRNkdMbXNPNzMrS1ZYNU1kN2VV?=
 =?utf-8?B?YWRRVUkrV0QrQno3cHpiRkgxNjEvQ2MzL2dzUHErMyt5K3dSYXRpVE9iVCt4?=
 =?utf-8?B?VGNiQUFOcXI4M2lhVUFsclZrTC9hbnY1S0tMTEdvWXRIWTZwdWp0K0xpMnRF?=
 =?utf-8?B?aXM3c0Q0VXFsUEdJbnJ5QUlhRWtQeXNwaytVRVlvUXFYRENQZkZaVitDV1RQ?=
 =?utf-8?B?eEFMMlFaWFdPUEJxQTcwRU1Ld01tcHVVUlVvUjNJTnFMMG9lc09QdldIN3Rz?=
 =?utf-8?B?Z3BYZE1qR1VZa0kxcEwvUHBiSlowYkRlMEVRNjJOZ2ZCYWorR25HUEt5T0pO?=
 =?utf-8?B?aVA4SUN5dUI2bFZibEt4V2RiMkxHQXJNU3VPMkNuNVgwcDF1SHhVT2xRajFF?=
 =?utf-8?B?WGlWbG14a3ZIRml0Mnc4djBrRjZoTkpVZkREOHhVNFVuNFZMOUJvNmZZQ0tp?=
 =?utf-8?B?cnZiQjBaQ1NORm5BUGY1SnRqYlV3MmZVNlM0aUt3MmxQKys5VlhhTEVYa3N0?=
 =?utf-8?B?OThLcnVyK1kvUWdaZ1hBbFIxZ0Yxamh6Z2haN2hwTU5sOUhNeUxnQWl1SnJO?=
 =?utf-8?B?VFFpakFoQ1FGRyticWhVRkRsOFNHVE9PeEkyUXdwTHJWenJCNGxlYmV1S0Nk?=
 =?utf-8?B?K0ZrUzVrM2xvUTArWDdhcGc5T1ZsUUhkckg0MFFEcXNlTzJOWXVYY1dINGZt?=
 =?utf-8?B?ZlpuMWZqT1JmanAweDQ3R1NONXozeWdkVFNvLzVGTWlIVUF1VzN5RGlVQ3RP?=
 =?utf-8?B?M29JSituUTBlT1F4K2tNUFFVZWN6NmJ2dUNrR0dGWlNPaFlFbUsxUnBmSTBD?=
 =?utf-8?B?U3V2WW9IbUJ3T0hyTU1nMHZiek0zbkVGaFR1SHdKMkdnbWI2dnFLQ0wzbllt?=
 =?utf-8?B?bUh0QmthSGlRaEhrOE1kRFp5bG5GeG9ySW85V0ZlelduQ1hQekVtUGxzRFdr?=
 =?utf-8?B?RUlBTnlFdlpBNWdTV2hPelZkQWpRcFR5aExCTnZPeUJkRGFjS0RTV2lZdzF0?=
 =?utf-8?B?Q0N4eWlVRkNjNHhMMm5SekhzUWRmcWZFMkhkd1FhWnpsRUNrWnRDTXdoYUVW?=
 =?utf-8?B?cmVBZTNwc2g5OFIwVkpPYUhuWW9VZStpMmovQ2pNNDRub2RUVDZ5N05XakhF?=
 =?utf-8?B?am0rcjNmZmR2Nk5LQ3FCRDEzYXVIeThGamR6Z2JJSng1NCtWcHF3QVRMdVNq?=
 =?utf-8?B?NjBPQ25LZ1lCc2JNUFNKVmoxNGRueElja0RGdzlMdisydU00MkR2RWhaaHhW?=
 =?utf-8?B?dHNGek4yTlZESkttM3lKUmcyOUJlbG9BbmEwamNLa2lKUGhYTkI4WkZEVWVn?=
 =?utf-8?B?RC9DbnVaNHZxTDNPbTJlMG8xcU45c3N3Y2NOeVZaTXcrVVVEUk9nSHkxM3p6?=
 =?utf-8?B?WTJDVk03Wms4YUNiSHpmWklUaDJMODF6a3hPcUVNYnFDUFdvYXUxTXN3TUpi?=
 =?utf-8?B?azBOVHpHZGcwZnI0L2ZTbXhrREZiZjQwMVdWQk1LSS9YNWhXMFVHeUR1Wk5r?=
 =?utf-8?B?aGwxTDMrOHdsNUo5ck5hS0JOSWlzNG1hUm9NdnF1eVZBT3NSc2UrQlF3UGo1?=
 =?utf-8?B?bm5LdXJFUzg2NzBDZXphb1haeGJaaVdxdUc5UmlDTFpUS000c1NyWnFXRWN1?=
 =?utf-8?B?ak8yWWR2YUd3bzRVaEhQR1YwYXlGcHhsSlV4aGpCOHZOdDF5ZVE0Q0ZIV1Nm?=
 =?utf-8?B?MlkwNksvNU41YXR1ZG1GT1dKZm5Xd0w5SVEwVTJMZ2g1V1M3T1c3QU4rWGcw?=
 =?utf-8?B?NXFLYlhjOUdIZjBPV2pHUTlrdzNKejZEczVyNURjRUd1M21lRnRZZ1hsZ2Zu?=
 =?utf-8?B?VlphMXgyblhJOGhrUjh3ZVowZER4Q0daWWhrNTIyODJIOXlUUUxxck1jMkVB?=
 =?utf-8?B?SUJvNmVDQmNka0UreS8rMlpSTWJnaXRnZCtreGRLeFoweExacFZWczFZcE96?=
 =?utf-8?B?dzdiZGdpRmRodmI2VEhqdUdPUWgxVDlUUXUxWWg4cmQyRmM1eEVYK1doNDdB?=
 =?utf-8?B?S01RaU9uZVdGRnNRN2t6R2VNNFJWTnFBNTlYZ2VQMXlaS1FKTU1Bc0F4Ym1S?=
 =?utf-8?Q?m9jcJ4vMmIs2lv7u410NX8kjy6oQlCj/qSx/l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729c3c31-b084-4ba0-f31c-08ded87ffc87
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:22:14.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfr3Qo5LTI2xAENIDOet6EjJydhRrQV2qO3qfXGxNKVG+Z4BWXiAr82Vvf/ToecfPlm36suM24FJYCH4uhsmpqhDbnbnP1PQn8A9Dr1d3xpu9jJIKXBrw4d1qIbUm8Xv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_142219_948698_42F7D5BD 
X-CRM114-Status: GOOD (  20.42  )
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

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary.

Allocate a burst array when creating each chunk to simplify the code and
eliminate one kzalloc() call.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 120 +++++++------------------------------
 drivers/dma/dw-edma/dw-edma-core.h |   9 +--
 2 files changed, 26 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f52d9fd18e573..01bee22fe3b3e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,38 +40,15 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *burst;
-
-	burst = kzalloc_obj(*burst, GFP_NOWAIT);
-	if (unlikely(!burst))
-		return NULL;
-
-	INIT_LIST_HEAD(&burst->list);
-	if (chunk->burst) {
-		/* Create and add new element into the linked list */
-		chunk->bursts_alloc++;
-		list_add_tail(&burst->list, &chunk->burst->list);
-	} else {
-		/* List head */
-		chunk->bursts_alloc = 0;
-		chunk->burst = burst;
-	}
-
-	return burst;
-}
-
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
+static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
-	chunk = kzalloc_obj(*chunk, GFP_NOWAIT);
+	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!chunk))
 		return NULL;
 
-	INIT_LIST_HEAD(&chunk->list);
 	chunk->chan = chan;
 	/* Toggling change bit (CB) in each chunk, this is a mechanism to
 	 * inform the eDMA HW block that this is a new linked list ready
@@ -81,20 +58,10 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 
-	if (desc->chunk) {
-		/* Create and add new element into the linked list */
-		if (!dw_edma_alloc_burst(chunk)) {
-			kfree(chunk);
-			return NULL;
-		}
-		desc->chunks_alloc++;
-		list_add_tail(&chunk->list, &desc->chunk->list);
-	} else {
-		/* List head */
-		chunk->burst = NULL;
-		desc->chunks_alloc = 0;
-		desc->chunk = chunk;
-	}
+	chunk->nburst = nburst;
+
+	list_add_tail(&chunk->list, &desc->chunk_list);
+	desc->chunks_alloc++;
 
 	return chunk;
 }
@@ -108,53 +75,23 @@ static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
-	if (!dw_edma_alloc_chunk(desc)) {
-		kfree(desc);
-		return NULL;
-	}
 
-	return desc;
-}
+	INIT_LIST_HEAD(&desc->chunk_list);
 
-static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
-		list_del(&child->list);
-		kfree(child);
-		chunk->bursts_alloc--;
-	}
-
-	/* Remove the list head */
-	kfree(child);
-	chunk->burst = NULL;
+	return desc;
 }
 
-static void dw_edma_free_chunk(struct dw_edma_desc *desc)
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chunk *child, *_next;
 
-	if (!desc->chunk)
-		return;
-
 	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
-		dw_edma_free_burst(child);
+	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
 		list_del(&child->list);
 		kfree(child);
 		desc->chunks_alloc--;
 	}
 
-	/* Remove the list head */
-	kfree(child);
-	desc->chunk = NULL;
-}
-
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	dw_edma_free_chunk(desc);
 	kfree(desc);
 }
 
@@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
 	u32 i = 0;
-	int j;
 
 	if (chan->non_ll) {
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			chan->dw->core->non_ll_start(chunk->chan, child);
+		if (chunk->nburst == 1)
+			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
 		return;
 	}
 
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
-	}
+	for (i = 0; i < chunk->nburst; i++)
+		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
+				     i == chunk->nburst - 1);
 
 	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
 
@@ -206,14 +137,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk->list,
+	child = list_first_entry_or_null(&desc->chunk_list,
 					 struct dw_edma_chunk, list);
 	if (!child)
 		return 0;
 
 	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
-	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
@@ -425,14 +355,14 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
 	u32 bursts_max;
 	u32 cnt = 0;
-	int i;
+	u32 i;
 
 	if (!chan->configured)
 		return NULL;
@@ -499,10 +429,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == bursts_max) {
-			chunk = dw_edma_alloc_chunk(desc);
+		if (!(i % chan->ll_max)) {
+			u32 n = min(cnt - i, chan->ll_max);
+
+			chunk = dw_edma_alloc_chunk(desc, n);
 			if (unlikely(!chunk))
 				goto err_alloc;
 		}
 
-		burst = dw_edma_alloc_burst(chunk);
-		if (unlikely(!burst))
-			goto err_alloc;
+		burst = chunk->burst + (i % chan->ll_max);
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 27415f3a2d04b..4950c57fca34f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -43,7 +43,6 @@ struct dw_edma_chan;
 struct dw_edma_chunk;
 
 struct dw_edma_burst {
-	struct list_head		list;
 	u64				sar;
 	u64				dar;
 	u32				sz;
@@ -52,18 +51,16 @@ struct dw_edma_burst {
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_burst		*burst;
-
-	u32				bursts_alloc;
-
 	u8				cb;
 	u32				xfer_sz;
+	u32                             nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_chunk		*chunk;
+	struct list_head		chunk_list;
 
 	u32				chunks_alloc;
 

-- 
2.43.0


