Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734ADFD8FC9
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0D/A7SW4Mwvx2UoSWSexKB4jtT0jW106esJ4ejlO7ms=; b=g72uvPdNyzEKEQMLSDcy0GZqvR
	W3JONvtJpVywC9rHfpZkC2s875bh0qrQnZbSfDa/JkOdV1NuzrAfTy/uNUoPaCW+Cyx8dwBTlBCod
	rY8W5slUeDaCeAw1lH+BDgfh930Fzk1jVJwiDMV0jShH7isCn3fQHzGbiDJOmGX30St/jrOeuyZD7
	P+GVD/erpB6YyzV+PiXCqbrn0VRR79FRTvutuAJ/06Al9rumzXMxXQ4pnSQQyS2RDe4YCJH+ufvWr
	fWxZXjpCkhTz1bEGr9yT+fg3/hkakFxnQGdDN0KzIJHJsN67+/znfbBGK1+zNyCI9hjFD4usJXTRi
	cUPQB9fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdBR-00000006URK-15Ma;
	Thu, 26 Feb 2026 15:21:45 +0000
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdBP-00000006UQe-01XB
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZIa0BnN6g5/1rZcXsN8C2KAMtiHsyueiirBG5mFsQlRg+Y0/vGkHroBplzhUEwzUxbQvTWo/p4ybIl8pkY8Sqzw+AEmocPE2ufZaVQOy54mzLFXys6l+rT4o/nnGtNSzpcFiQTogjbK/yzPJyudKb+DMBd0FQXruAPQGk8nygaEST1vQTiwUEuoXgjPzX/0vfGj+IR5dXOjJbJQJrSbXz6CgHEefPsAd/u23zb4soD9qiFZCJ/vZbAQOcIP4hg4gP45sGBaDUw+4zxVQAFx7ZzjGUKlboC/Ql4brj/9g5V0MPalvoBXtATNNTmx49cA9POZ94QIxu2TUAnPArCdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D/A7SW4Mwvx2UoSWSexKB4jtT0jW106esJ4ejlO7ms=;
 b=tv+Vk1RPuDYicVdcwLJpscqjj9zWy4cXe1FJ2wtU6yVhv7+ALMTgjRhPKS6Ap5jXJl3gt4q0hLlIw7r2xnbksLaFztOLeyUNixEUeYNh0e2BK3tWcxEjlg2rYXOuL3AItwn1mj07wMCdtHkyopXbzu5Aep86FP1yWgrf+skXsIZTZjEQfFQwx0ie9OBU+YqV+NL1IFeISNJL2Skf3KK8gVZHf9AqHsXQQUliUZTbOc2Ek+MwBQojHePeZnnsOxwxV2cKD27uzJHe1+mUdCUC1T7N8c9YqvW20ax6pjEBIMKsA3Y15dES2kDKVU6Dd+IB8Uvi0CUOd6rheXLfx+YN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D/A7SW4Mwvx2UoSWSexKB4jtT0jW106esJ4ejlO7ms=;
 b=OcQ0B2diIhLLpFpIrob/vHKrdWojLOE6yEVZkZvZMrHON5I16vyUobdBH4qDd5sdw+ToqvHaun/UFHKwc1vXyK3qJuz68QWqtBqpBrS8gfuf182WxiS6chEYuKGXeXfWSwVAh86Z/dVtRPETkOUQz9M6mUT2ev1ezVEkv78F/PZpE9cIA5QVKCZxKZNJ+wsD9Wy4uz70ePbjR4T9ow7xVJL1RA29XBLZ82WbJGpQyVaUQ6RmeyxfrSCXh5zwt/TQzeCRylGm5IYMm0wJBtiGb8AnAsuVgPYRaf7HXB6sz2l0K1eT0cGsTlM0bAZ6igO7tbrXUDcdyltjxuzHlYUxQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11263.eurprd04.prod.outlook.com (2603:10a6:102:4eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 15:21:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 15:21:36 +0000
Date: Thu, 26 Feb 2026 10:21:28 -0500
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
Subject: Re: [PATCH v2 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Message-ID: <aaBk-I5jrut5wpT7@lizhi-Precision-Tower-5810>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
 <6d6c222faypvbo6fvs7tad2gtzxqqzlsjkrbefwmgxodt5thbc@lylpaqxozrg7>
 <aZ8YpKPqSjzDtomb@lizhi-Precision-Tower-5810>
 <esdpmy46hffpg577hd67rxmpkfm3agrzrginegi2rczbwvdnlb@urqmwhh3kuff>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <esdpmy46hffpg577hd67rxmpkfm3agrzrginegi2rczbwvdnlb@urqmwhh3kuff>
X-ClientProxiedBy: PH8P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11263:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7c4e8d-50a5-4e8c-c5b2-08de754abb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: deP5GJtsG6nvgAFFHO4mvui2q7Z8rR31I7q82K4xf3SSYRVSrHRlDWS2aQfxHMz+Prv1xwQg1u7OIwIl/67h2waiyowvF7z1rSjx1gDHCbPYMHZzr0edOfMKqUv6IrB/8v0bKbE+GT0wGVdAY8IB5G+TR++yk7BEUiQC2du0EjqatoGW603AuYyzbx3811l9+/E1Xggk/Xtx6fF8DThqRaWbdmV/9OBlLHcYE0kZybuYk1ue8IcNCwwCPFxRSOFOK7th1CmLoI0KPWbxejRctuREfGQpT/+VovdYQuOsG44QFcJ3YZk/mcTMTEFTt5wb528JauxeRDzPjt9EYpaHz7tksIYOwUUFIkZ+XQmVs2v+OOIlnjr6ZR6ZXaAQBs4SvcBZmPvOb1samypWZrC0Gn6/LWQDa/VVPvFqY+5DlKrchTztMP+7eoOPVwS6o6zQTysu0SEFSfGm+PQJI5K0yHH7G9Z7OM6vtiOskfj+gCj+96BRkvAUUDl9/iPH3szahOpsmONq7TJ8AUxJ/K0gj9rJYDJtMZ2mmi8R1zDidPTIpsx3CcugRBIhMoGqqnyGpPARMZd35sMpq4wipgZ9tGtqtp0iCIBXyN9ojcj9iTDJ5L9DWB77vDmgz1OAlihlDwV/dhNntHRZx7aiIuOKl7k8wW0aKA6id14IApTro24qk4O9U4qf721i01aoPQPKpmapm+RUdIjXRAEXv4tmbI9VMCPXuw2NbPD96BXIFeFwXV0cqgDexnlEh/1pYaJEBo5+kxB8xCiqtoMOu1p5YD278pdw08CIRmM605XYbSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XkS7+JD4DOKY22lyF2q5maJGR7IU4j2YnUfXw+FKc+XWx05b2VX074VZ+TRx?=
 =?us-ascii?Q?H5IyaYC+8PaCNb+Q9/L1cvLNAq6jdjmmHa8awLWmC9qoXPK/n6xmOFPHznUR?=
 =?us-ascii?Q?UqgvAmOaH9kgWoJFTr5mvtZFM1/gxrvcJu+emCuShYWwUpzEEfd1kZatCaWy?=
 =?us-ascii?Q?rg0W1KOQRNrneVLGphorT0T/fuSZi9LAycsmgPzoz1NVsueghfO0zxeG6CMe?=
 =?us-ascii?Q?YG1LkhSZt/NjScEicRZB1bjYX3ShQkgIh1mhi8FrqARCzdBNYqO/B/M/egOS?=
 =?us-ascii?Q?fGD57q1C+VCiYlsc3nv/En8WZxS898pOGQc5ABeymd6zuv/E+WY3yWsyc3IJ?=
 =?us-ascii?Q?pMvmF/D2HaJJmewVV3zd9Z4wu3gHrQWGBt+3Vn3zycvTifMtFTDIi0qg7h89?=
 =?us-ascii?Q?eZ4em//6as/e44rkdHe1o9UnV3G8F/I5zA+VhmDo6D/rFeU/4vpkxyUolBfp?=
 =?us-ascii?Q?tbdfynjP+r6Dw7l/cpWVr0NzH9ZIMmJ+OYrL2SFBAWd4dqNfdChGi/f4Hgtu?=
 =?us-ascii?Q?gQl9qMvfP7UcXllrrZam94zC3BGmzKWI67HVum9NaBJLcJRbOTcDpNdnFrLw?=
 =?us-ascii?Q?83mP2cp/AMoAHw/DbJXl0yJTjd2P99rdvVcYIEf5bxmTMYZIqJFz8W2B74g2?=
 =?us-ascii?Q?1iLgw5ioq4z4E8UMOp9NBXnRM4XnyieL9d/0xVk1n0Lw6R9qQNmlnZGxAc3A?=
 =?us-ascii?Q?wFp36FmwuWixrj6jF0Ik+iybDlQFG11uKikCRXgwm+XK2By/rBTDffk0ej1I?=
 =?us-ascii?Q?X1f60ole5S1uE79nWmeNb+G4qO7H7RlPb0pack31rKS7worNh26ePxUHJZHK?=
 =?us-ascii?Q?c4sYmfQDr1hpB+xK/SueYEVgHMphafn32knsGGUWtUjQvAuY7SQdZUwshMPC?=
 =?us-ascii?Q?D6j46/aCIX8aCLA1xdVIZGSMv6xYbQyqJ6Y964IgZMBFuP5oWyhRiVz7rLaN?=
 =?us-ascii?Q?iYg+DEK82wmU5MplLUBdIP9/yzeyGolVembeumX3QaoIAK7grNrBUlMT1yNY?=
 =?us-ascii?Q?3DtBeUEBT2OlTx3qjVH0Hs8Yo9CUkDi3kxBElDnLLvsC8W9R4aby0lrQCsSA?=
 =?us-ascii?Q?5yzbhIaC8ao5xGf3EdJqGP1Sw3SUYEFDgeF0octbSxPqGiBY4aC4lR9c/X0z?=
 =?us-ascii?Q?oj8HW1TFmc2bdlLYzngC/UdPRdB24WKt9bSYgJGL8382kkjUsywVyBGjsRRx?=
 =?us-ascii?Q?ntxU4dyPL9u84+D28HTh3ofhIpiJi0HhEmItN5mkJOI7JZwCxMJppY4gNIdU?=
 =?us-ascii?Q?wvCusBEzH6MkY8BZ8H44BEvhmSgh3TKEDvZU7nXz2SEjheVF8QH1vvnAS0RV?=
 =?us-ascii?Q?+euVFXlQF05NFoO01otw9jNscOQcAV9vIG6yXCUsxnqSLrPya6CXHkMr1qTc?=
 =?us-ascii?Q?pafWqgqRtexVWN+GjGDFWMpwJUGtYN/ziYE79F37PjAf0huXo9QRQPSfek4B?=
 =?us-ascii?Q?a3XWnZrYeSaPPCTZK3xvtPU0aEwIVQb+9ub1vFJG9NzSgyOy0MJ+E42im5Cj?=
 =?us-ascii?Q?X620Enace73tluhkJjNGx5V0K4hgXEAog2Gu4G85P1ycBn9tT65QXg5ZcM/L?=
 =?us-ascii?Q?ZvLTaYtMYhDalYccW2WMvIX1FpGRwZ5jHweouGow95Pz70tOi27nd0WFM74P?=
 =?us-ascii?Q?yrbCVB2CB44knV0DOIPObV5ZRzSBlHsK6H40oYOylbRTLUwVxd9tb+yC6sxc?=
 =?us-ascii?Q?IvsE86/jQERpTjmDz/TyofX+ktHNl5vAwV18ZP4DK9hQVcOs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7c4e8d-50a5-4e8c-c5b2-08de754abb58
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:21:36.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB6QmJekq7ZyiuXpXIGh+k0Kqytzk66AoKzUbyZfhVLmF5+LuHBRhszPV21UnrSEfdNCa6LEg3q39diNLYe1pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11263
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_072143_047463_30112B35 
X-CRM114-Status: GOOD (  30.07  )
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

On Thu, Feb 26, 2026 at 11:16:26AM +0900, Koichiro Den wrote:
> On Wed, Feb 25, 2026 at 10:43:32AM -0500, Frank Li wrote:
> > On Wed, Feb 25, 2026 at 05:30:33PM +0900, Koichiro Den wrote:
> > > On Fri, Jan 09, 2026 at 10:28:24AM -0500, Frank Li wrote:
> > > > dw_edma_channel_setup() calculates ll_max based on the size of the
> > > > ll_region, but the value is later overwritten with -1, preventing the
> > > > code from ever reaching the calculated ll_max.
> > > >
> > > > Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
> > > > It is uncommon for a single DMA request to reach this limit, so the issue
> > > > has not been observed in practice. However, if it occurs, the driver may
> > > > overwrite adjacent memory before reporting an error.
> > > >
> > > > Remove the incorrect assignment so the calculated ll_max is honored
> > > >
> > > > Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > > >  		else
> > > >  			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
> > > > -		chan->ll_max -= 1;
> > >
> > > Just curious: wasn't this to reserve one slot for the final link element?
> >
> > when calculate avaible entry, always use chan-ll_max -1.  ll_max indicate
> > memory size, final link element actually occupted a space.
>
> After the entire series is applied (esp. [PATCH v2 10/11] + [PATCH v2 11/11]),
> yes, that makes sense to me. My concern was that before the semantics of
> "ll_max" changes, this "-1" was required. In other words, this seemed to me not
> a fix but a preparatory patch. Please correct me if I'm misunderstainding.

Thanks, I found I make mistake, wrong think it as "chan->ll_max = -1".
I will squash this change to patch 10.

Frank

>
> Thanks,
> Koichiro
>
> >
> > Frank
> > >
> > > Best regards,
> > > Koichiro
> > >
> > > >
> > > >  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> > > >  			 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > > >
> > > > --
> > > > 2.34.1
> > > >

