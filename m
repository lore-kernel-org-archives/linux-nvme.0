Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CDCFD8FC3
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0pJR6i6wh9l1uqw3dBwccUX10q5dN5vkWepObBLARX8=; b=m0/DU6du2pkcp6PmUxKX/Xekw6
	GEZNv3rq6p0Hl66RzxPUs/y60tNi8u0Ob23u8Fi0QQpt/JHRpjtAaKW2orkkoyVozjdeY2WcC3Ghi
	+JhdAiG/sv2mQR/c6BdUpnjJpPEaNYKqo1XusxmaD5/anSrGwZFrdPasjmcD0Qvkjr8zH0Yd4vRoL
	UcRLR007wGdzo5MzbLr4ktpXf2FEUMJn9o12G9jdcbTrsnEELp7njzuJ3OoFT2EZsJ4HdrUk7IZkf
	SPKMGbxELGSZvzm26Z/AjNZeMrdY1J+NkwsTZdXSTHEcGzpg/wzcvgpcNFOhEqS8ar/NqUMU1sNCf
	XlB/11NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdDM-00000006Uzs-1Qc8;
	Thu, 26 Feb 2026 15:23:44 +0000
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdDJ-00000006Uys-0Vji
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMsffcKhy/5Vw1O3PfjsvSX7Rap5FbXXmPDqmK+JoPx27AUD4IociNwvYeL4wpWzOrSvM/GZYWmcNxUmMljAhfail8kIUz1Him3XEYT5dvFQJUr6oIXFUwoF1rZ7OOaPBPvaHjz1ps0hh8+pUf3z7FNzyU3/d65dRma3N4kHs0pJ7tNPxhjwDawR5EbLAaj8dCCXyfFY0y6Hz94lwDYmfuQG9qmVB9HW2UFil8ZfsNICe8f/wTsEY9EldQ9tSyLt1oBuDI6LK4hiQgk6jHKuV+6ZzI8imqLTMzIVnHOv7YZILRl39lRZy6TneUUQuznhiWIxGg+ChDl2bWhsd1HdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pJR6i6wh9l1uqw3dBwccUX10q5dN5vkWepObBLARX8=;
 b=JgAIV3qBYcAOuqAOxCRiBnK904XobcaDH9opgPsCP6Q8zfPXlOVKhM+0lGh/zeW/F9cLXikI7DS7gCL70RUOyxvpbtu1RE6MnLxYRdIApMwQdS72RtRKi1qdVq6erhb4qhzwfqrhrnstllfn1oTAOVGkJxcb40M+GspIRRGy0LZ24zVfYc5lq5hkYgZxtN0pMC4tEq7PZLZKq6vz+svd1F+AAAbyFhsOKZ9Mx6WkAWInOmsrrIzGwwd5VqvYk7R5Qme10x1XonQJ9MNObctPdw1KlOglxLS4rZOo/rfn1I9ukSFFwGoFpA7gS2LfR+f7xvKgnjHQfBSnxj0vHX0IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pJR6i6wh9l1uqw3dBwccUX10q5dN5vkWepObBLARX8=;
 b=mjRPjtACO8DaapemV0iSZoxNQgyViFByV8uBnwKlCn9s833XjXW0CDNqIJgSUGrZaLj3qAXnOCmDR0YuMLkvdBu7CTFDPUJtoEdPacZcKKvoHgbhsa8ipfMMLvrXBPDLgQlDDwJHu0R0zlxQ0krHJMz5xBQY6qaZZd8asl0DhyycQ70IIIHFMQxtrXlXKRturhUipcycApsoo2golmY0z+vDlgXuhs6844/t9LF9nRHPPop9zTy6GHFv3fNlZ9NUfLXWxy/Ks3djmcnODRr+Ib0C3zUeWIhfXCLniVeSYvAPsor2OFokyq6QuaspK1Hv6enhrlFBxnKo0ewAoVzJnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB11919.eurprd04.prod.outlook.com (2603:10a6:800:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 15:23:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 15:23:34 +0000
Date: Thu, 26 Feb 2026 10:23:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <aaBlb42x3qQxOYjk@lizhi-Precision-Tower-5810>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com>
 <d7mh5d2amod6uzmzib4qnun46al73r77uljzhizq2v6w5ame4v@et65inoxhexa>
 <aZ8aUcV4RN2EL5n3@lizhi-Precision-Tower-5810>
 <jjklzlblwbqleshgnhiedqioxskt45awph5rlkh5bymvitk3fq@blisaiwi3zor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jjklzlblwbqleshgnhiedqioxskt45awph5rlkh5bymvitk3fq@blisaiwi3zor>
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB11919:EE_
X-MS-Office365-Filtering-Correlation-Id: 5529b80a-e5ea-45d9-4aaf-08de754b01b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|19092799006|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: Naa2vWxhNVrZGDV4PIvF+6CYvkIjUPJA9dNgxlGv1J7LcEIhDcx3phsi/ZLKwMIXGfVZ0STkGZwnZOe0apZ0FZZkEuh9HL8+YtegbNRLTfg7QQJYkQy1s12WMsj3opuNaoOKX8n9gWF1Mo4WBbWvwlEaU5mK5Hj6qEAFHUf4VAVFwqLcpyigVFq20orugdPLsV+A09+W9xRuWvn8xbwmnFHmP+CT67LkR2yIcUivsqnyAlV168IRGDqO4K/VO3i3OhbU91R1Egu7ueMhSlgFvpu7uJ9HpAsKYRMhFCimak+bdzLD1Y6ox/0ADTuOzWII1/RZiPoaASuJuPMT6S1cffYpKHNBCrqDRxoqk1VlNTFfTUjCGARfDyZSJW0Z3TpS+hE1XfH4BHQ/9jc3eUSblTkErcU+ZWTyWrPxNmSG0rGh9ImT3LX1aZkMNuVbBhYspvtEht6H0X0MXlN4woKdCLQ6PA9v95KeqPYtun25K5cBQWjq0AaTw/muFwmRTeBHsjelX6p4HgyWmTZSVtZ3koBM3Y4g2RWeh8mjfOsPEzbWc6sgktAvAa+k0UGvACX7gI2qtNh3lk3xvaN38NXSGNlXn1J/BJMvkuxjUcvKM2VD1vUrtjrxFX9Xs+lV1pNC5oG+v17n2MuVR9aSTZguHTPTU42ALouERWkVzSn/zWq4yatoxdku3xJdRj1zak7WH63wk0doTPOlpZOx6OaTXEQxIu/IGhNq+E2aHtOMRzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+V0aoXgihSlCl9yqBtqFbntbIJomMWT08C3CCEjfu82t226o6D/+tovpXR6z?=
 =?us-ascii?Q?r1YsHQAKdxrj6cM0Aojf+W9kwlUAioAPBnv0KOJ6UNNbMZGTpEWV29+97XAg?=
 =?us-ascii?Q?3zwEUkMMbOXfCwqb+9oPZDsOddg+JFr/Y7yxFk1xVtxLyBwqudwCv5IwDkrl?=
 =?us-ascii?Q?odD6K64zPsyDuOa2/LJVTSJ7fE9pNyZUDlSQ1COnFR5ciUjgTYPmQUtmR0W6?=
 =?us-ascii?Q?HKtn+3o7Fd5urCoH1iosfgSHpxDOemHTpNYkIjjD+KnZo409DJTGCsALZ4SH?=
 =?us-ascii?Q?TsdJNhGbtoVP1sWp12gBT6HkIpszddT0g6kxFdKQ7lWzjgvyahFiR7PykTbO?=
 =?us-ascii?Q?kkYW5aZ8Wy3hEIoyK31MUBSV/n/iKn1vmoW9m9CQ4/hmQxsTI864U41T25Dh?=
 =?us-ascii?Q?GmD4WRomRCU/8Ne9wZqvbIy1eJ0wukLo5SjAiEi93mW/kNuux2Gie5yWhMbU?=
 =?us-ascii?Q?qBVy6i6hoTNV5JVsqsgMl2vxkvmjHFMf3HyZ4DfCQqgAAtRbnOGWwA5dGsXP?=
 =?us-ascii?Q?x6ZmtsOSMbllUb+7D/yofDDRffzmMQijNKJhhrh68m08rzObgkxg5XpVwj5L?=
 =?us-ascii?Q?ccTOOM4/zxJIbmAhePbCjMUen5CJ402OQ7Lb5iTqfVS1Y0dyL3KZneb5XTVD?=
 =?us-ascii?Q?dPw2slTLDtT+8aKy0EcAHCKX4fjdWDhvYBM7lIyYqCch4Vr3W6LEWHNNkpjd?=
 =?us-ascii?Q?i+O44ppG8/DJDKwhdumoLVkTes77ueaByJkeCyXwrsES3vdrDomSnevi548R?=
 =?us-ascii?Q?XyeRIOm3m5leKT4NSvF0KLiXbepy7hp5NrYhLcdKKP4yeyc3K12h3gnfL1KA?=
 =?us-ascii?Q?HztOHA0p0CgEnr4fcaaiW1ChSofhTjcZ6RsqPrtvtuZewOozbMt718tUxQKr?=
 =?us-ascii?Q?+hf600Y2r5tYoOVwj9JSt4EtO5T9GHGCnJvKsMTNmMe63NHb833BLv21ClKn?=
 =?us-ascii?Q?eIh05m8Q5eRMl9zIdlB2+uHMPZa0YZC4r/vmVPBiRZCkPe/Kov7Bl2vreWIQ?=
 =?us-ascii?Q?UNREsPn0HEpKccPRqvqgiHDbi8ckqZHKDAWzPLHdz42fmtJyMsKH27TlQyLh?=
 =?us-ascii?Q?276xjGwkEVspSDSX7K8qMbyG4m5+yeS8NXqBUMvdudfshwf6DZsrNa798Ym7?=
 =?us-ascii?Q?HrZiK0A6GCq647BtUr+uLjUX6IE5aE/a4oIiJuxOBsmTcz9h7zfrj0Aygs3J?=
 =?us-ascii?Q?bvuT+35ecrLibujLuAP13jKd1fBXQwwtUVf+ao+GJ3tmVaUHbXtYKFY+7tw/?=
 =?us-ascii?Q?erXx8D3ZBCvrGmjR7Ww5aaVM3d1Y0YfIyyzFg2Pr3pfft7QL5ntpuVbS+2pn?=
 =?us-ascii?Q?qvfDddQYYf49He5p8gr9pMsdLJVc3RO7I5CLSgMYy6W1TkCvDQy7Nwm/2Pay?=
 =?us-ascii?Q?7SQBVk66hSajHNSnw06Icxr713uz3l7uwL8DYRK+sFcO5WaG1977kpdAyJ+r?=
 =?us-ascii?Q?3u0D3p+ez2ddB1MnaXl/eWiuHbTyS51yR1UEFjv6K5tAJmOPArMi8N8dGfQv?=
 =?us-ascii?Q?su5QALMjrd7Rxc5kGFGxQVWaoY8mL8imewrG+khRVlEoYkHUa51JEEV0eOO+?=
 =?us-ascii?Q?eRmK51LX2UKK4WVJUpHfluofRlqy4V+zogs7NhdjnMfEiD9AEOwTEyfvQfDf?=
 =?us-ascii?Q?Tz8C9u732cVfmKuFWiX1pozvmnnlt+TEXx1y6ypLXQNUO31/wahrzDFR83UH?=
 =?us-ascii?Q?EQ6zsHDhxpHji81P48nNOfoJ/RfId6r5J6RijzbG/JkPfdDPnM6WMkqBnE5z?=
 =?us-ascii?Q?n84dFb5lfg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5529b80a-e5ea-45d9-4aaf-08de754b01b5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:23:34.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0pQZC4uXA+6gwBqKeZn1w+3+NyBIco7jwgogM2y8hIBQLEGEtD3mkImFU5wq6QouyCzYMJtFfJUNED10yJpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11919
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_072341_165767_CC0B4AE2 
X-CRM114-Status: GOOD (  36.64  )
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

On Thu, Feb 26, 2026 at 11:22:41AM +0900, Koichiro Den wrote:
> On Wed, Feb 25, 2026 at 10:50:41AM -0500, Frank Li wrote:
> > On Wed, Feb 25, 2026 at 05:26:02PM +0900, Koichiro Den wrote:
> > > On Fri, Jan 09, 2026 at 10:28:21AM -0500, Frank Li wrote:
> > > > The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> > > > channels, and modifying them requires a read-modify-write sequence.
> > > > Because this operation is not atomic, concurrent calls to
> > > > dw_edma_v0_core_start() can introduce race conditions if two channels
> > > > update these registers simultaneously.
> > > >
> > > > Add a spinlock to serialize access to these registers and prevent race
> > > > conditions.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > vc.lock protect should be another problem. This one just fix register
> > > > access for difference DMA channel.
> > > >
> > > > Other improve defer to dynamtic append descriptor works later.
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > >
> > > Hi Frank,
> > >
> > > I'm very interested in seeing the work toward the "dynamic append" series land,
> > > but in my opinion this one can be submitted independently.
> >
> > This patch serial is actually straight forwards. we can ask vnod pick first
> > one in case have other problems. put together to reduce patch's dependency.
>
> Yes, I see.
>
> My understanding is that the originally planned dependency chain was:
>
>   #1->#2->#3
>
> #1 [PATCH v2 0/8] dmaengine: Add new API to combine onfiguration and descriptor preparation
>    https://lore.kernel.org/dmaengine/20251218-dma_prep_config-v2-0-c07079836128@nxp.com/
> #2 (this series)
> #3 [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link entry during dma engine running
>    https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
>
> I'm not sure whether #1 will proceed, as the thread appears to have stalled. I

Vnod said he will review #1 in this week. If not progress, I will create
new one without dependent #1.

Frank

> might be missing something, though. In any case, #1 is semantically orthogonal
> to #2, so I believe #2 can be considered independently.
>
> Thanks,
> Koichiro
>
> >
> > Frank
> > >
> > > Even in the current mainline, under concurrent multi-channel load, this race can
> > > already be triggered.
> > >
> > > Also, with this patch, dw->lock is no longer "Only for legacy", so we should
> > > probably update the comment in dw-edma-core.h.
> > >
> > > Best regards,
> > > Koichiro
> > >
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > >  {
> > > >  	struct dw_edma_chan *chan = chunk->chan;
> > > >  	struct dw_edma *dw = chan->dw;
> > > > +	unsigned long flags;
> > > >  	u32 tmp;
> > > >
> > > >  	dw_edma_v0_core_write_chunk(chunk);
> > > > @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > >  			}
> > > >  		}
> > > >  		/* Interrupt unmask - done, abort */
> > > > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > > > +
> > > >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > > >  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > >  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > > >  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> > > >  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > > > +
> > > > +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > > > +
> > > >  		/* Channel control */
> > > >  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> > > >  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > > >
> > > > --
> > > > 2.34.1
> > > >

