Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEEDD609D2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eerFqCSuKTzTrtCDIlgRIN3DVr6VOq05Cuitq+Wpm3g=; b=Um7Wyzij3634jDs+FFjHmijB1a
	nvehEhHH6+KPIDTC1PKXtKVpWVfsUFSo3amFS6yZKniwgLxxo5Oei5xC/4xCdK431V4HYbyAbkCnw
	bAwRA2BxcXmaetjFAGYRTDAAd7k4IDKY6/8+4aqidXm157lVCzToa9vbhNBewIOQXEIxPxPPEHxuL
	pD2TznfoSbSWEU6iLxginHX8shAh6RRk3xi1AmY7N2X68/aRNcs/FXj0hFxZC1QiQ1yuS6agpqdyq
	4hhnSReUyObuQrA0gcofIbXUxQ9caHv2PBAUp/320euDP8V+0zN8Lf9Oxm3VhHChybe8R/1on+tmc
	pnol5dsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVYqj-00000005byS-2BVt;
	Tue, 16 Dec 2025 17:28:37 +0000
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVYqh-00000005by0-3IYd;
	Tue, 16 Dec 2025 17:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP6MMeZUkHaUoEV5UOwEAnuILk2GVW82I3DUeAvog7an/gQrWFaIO4MFPAYQMchlCmEaXeF2L+P3bOZRgqSg9/qClppIU9Apc1laj6wJo0Xh+SulIAR6pVEEpExyh0DRQ4ocMSkZnpG3D70WV3i27VD2k8J/thtGqmiTkJ5sZeKa6BQnASClwctUV1s0UCIA6LuBSMbbVEnjBgICMsJDuWo/Fhp83Guzf1Ncr58XCb21G0HX7jxPujErUuYsuVoSZrMUq7GAl8I6B7uMxgZ3VvT/59jxBr+zVMMienY+/XcKHXewlA9iCgJ17jdZNvibh7jULFpOqa997swjbFNHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eerFqCSuKTzTrtCDIlgRIN3DVr6VOq05Cuitq+Wpm3g=;
 b=w8VJKLXIGKULzNJylEniQOtbCNX6GZvx9DnFJg0cUMqPIAe1eVXPwKAAhnU9E5oAW38sRmrhXptqNf8trR2L5mVOBStAkPx36XH4i+0pTgGi/6Qz24VIT5HLpAnHkhBLjj7h0oHORUpmW7GOv8CrSmJPADmD51RSrRsDudKUEkPB2LA5xLCATd400zl+gm9vjZk7pT304EE12DK+3j6dvGL1kLEA63caTpKPfO9yL+4eNxXc+3+mQx1fFLO8a4EUpsyu0gdDhIrmNgkwb9pbgnn9+oYYUsU6uFAPuPcbEt0Ui+tj9t6AIRRj/2rev36SHEOhaSfYBXbaO+RV98Qorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eerFqCSuKTzTrtCDIlgRIN3DVr6VOq05Cuitq+Wpm3g=;
 b=SfPI7NlxLDrmkYdXZaKEqYTa5zCT36fZbGue3JvnnGvhZEd+57WW8nuCSe9tRIKIdO32wfuU/c6g9x3ZBO9L7T14HzKHm5ObTyTuu/+Zq3NM+eJXzi9581YrMUIjVscwY278F86PLcgNniEeW1ndQU0Beqcbt3FVVhQ8rYrP7rdse5B4RRzhQkrykURHLLJ5c761NJRQne7vXV5ezuX+R70h/JGMqA2us9RtKpb5OYs1JpJezezyvQp0AxFZOj7oc0tXoE4nIOtEc5pN+3YiVOOX5SObumoDhL2ksAagflYRFI+PxxS+r04M9fLYhACee3xizoE32VmrcmukF0C07A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 17:28:30 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 17:28:30 +0000
Date: Tue, 16 Dec 2025 12:28:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Message-ID: <aUGWtarjFNNy2KyZ@lizhi-Precision-Tower-5810>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
 <aUF-C8iUCs-dYXGm@vaman>
 <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>
 <aUGURVuW33WSTuyI@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGURVuW33WSTuyI@vaman>
X-ClientProxiedBy: PH7P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::22) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad93bd8-4068-4988-0876-08de3cc887fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y51rnVttSK38zlNds6NF5fKA04qMr0u0cPi8SZl7uzGwswlMiM3ngsiI0eS0?=
 =?us-ascii?Q?mrgfll+k0fhdvr6iyGSMlvSkz5qDd9L0u0jhHNKQbF6XqPWeCUYmbC4xo1Gz?=
 =?us-ascii?Q?KAP3D8eaFEMF7v3qBSvLiS+blHvg92HgHU4o9f+CScG+HjDtZgnys/BwFpnu?=
 =?us-ascii?Q?EDF9v0KpHljxB+xh1hGPxDZzh9jK328KTORu7FtEMCKq4FTsJy08fwwx+GQI?=
 =?us-ascii?Q?VSON8LJKtkfmz84DptXB1IltfF22evHrARux4jFNnZdDnBULH5Pux+UqRCFY?=
 =?us-ascii?Q?AsQq1c7+MI5YVoFSbt7CIW5GmeNQqxfnyZND4i3+Xt0SiIXNXLDcXvR+CfYd?=
 =?us-ascii?Q?9jR4oFCBwqIVTQTqvPgUH7/FSGPY+WUnEaqBCUFFMTyX4aEO91r02aFzGKth?=
 =?us-ascii?Q?iZeNarO22uTQgIIwk6NWtibzCesaYqxwxtJRAIqT8I5+pm7GH+hcF4w/7dAv?=
 =?us-ascii?Q?o3Ti5cKCrEeGNLfde9sxAeH/h4cH1R7LyPnfQR+TsKoGB10swp293Qwm9wZo?=
 =?us-ascii?Q?AtkuX4dHNfOGxof7rSGe8n+Co6m/6jx3NqJfqgBfXAFzmLhcIlF4VmNZwzrH?=
 =?us-ascii?Q?TpkLjz4RoPlSeXYwxvatqv1sywr1bjByUBcTqHXKgWt3TqyVBWDJqa91fwLf?=
 =?us-ascii?Q?zZLNXq3QBLE6+wIaExNw6zKoBvZrHs7vkO7R/DeL3abc/mqZLLZ2PCsMgc9R?=
 =?us-ascii?Q?FOm0RPm/PRm36K606go9zbiCTI9qrtNje+Zq+HhQbx82hAu2HGJ+gCI1Q9ku?=
 =?us-ascii?Q?E8oB2i1G6m5y3HMBXil7tIOQR7mjkaUeUzlWfCgT6d/A3p1MhKZLXQaB5f61?=
 =?us-ascii?Q?y87YzeSfcRfW1725k5rsPRUrCpImYhobyR8OWON0D5n86gutMvcsKhzhxCj7?=
 =?us-ascii?Q?Y+Ux/W1j8R2+WGLkr//4seWi43TMyCG9WtnEdCaz1lRsPoYBRX1ofWBtWJ3m?=
 =?us-ascii?Q?ZW+fuAJ/dBZUx5k5oUWzExaTlV04BaW/1APpgcjTKsUMnw4YnekJjmCVcx/0?=
 =?us-ascii?Q?ePMC8wDVisk+XcwielbNnjk70qXX+GzPihI4K8D6l/26WrFhSZXv/gLLqjax?=
 =?us-ascii?Q?NnTSLXn3a49XLgwyLPPc4/DB89UIijNaCICLXbFofOzm3nMwPfHBT+yDvILl?=
 =?us-ascii?Q?KfG9DPBGLbDqqfO/qO5NBWaU6MF3WKSp0M7h345e2mYEjGJOorhTPw1U7m4Q?=
 =?us-ascii?Q?9TbUHwTsObWvlQU0yN7VHmrixQUObAaXawch0oQmE6n5IFx93IzgGPtvLeYj?=
 =?us-ascii?Q?ItEPl9ntBSMBIbNHsDeniIrWwkKc9ez04p9MM3qyRt9690xENGrF2MTTikU0?=
 =?us-ascii?Q?8TJvITlHfPFe9sO/XpwmPJC+Qs6Q0eEGQtAVT4lEh9PXHbWAAwInsoG1OBYG?=
 =?us-ascii?Q?wBN0xVHQEWu5Xkkjy++URCsUWuJC3FhBZ5zHsH1QIGuMV6C5OmK72jUEDZW+?=
 =?us-ascii?Q?amA7ZzGw/o2YG2589vX4TP1A0tah11MOPg5JVPkm7SRtEuevgG61Kw8uYQb4?=
 =?us-ascii?Q?IfdxjkJ6lTAlx4Q9KDDL+FSFsWB4YYjvlakM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JSisyBU60SQ2aze5IO84ANsvRcmSqZTAAknRbe20wobdJBQVqsBPBRWvn37g?=
 =?us-ascii?Q?S7DPvFaGFgH2SWCPgWghqQZkHG/4SKalzqhpGFCVV84nTBrEQMcAHvOiBh+I?=
 =?us-ascii?Q?8xbgyAQRP7gNZEaByzz+DMUXCEokZwsestp+tGqSdrcTKc1Hb9CtgBzdCFmW?=
 =?us-ascii?Q?8ZEYI9oBTW+z8gj3zW4Nh3YYiz+nffUWX+qZ5xqI/ERszAReZfrSXxPUZtuy?=
 =?us-ascii?Q?RhLV5mHH6VRA0XJ3HCF1Hu3GBJOCCP6Qj0n9XC+jirG2HbQ+NhJYo0ChD6St?=
 =?us-ascii?Q?DsoXy/sU53i+BRn6sAHKQ4pdq2mJug/iqouMMiaoVJeEW0Jsu4jFtMC8V5Hz?=
 =?us-ascii?Q?iBchD0FMSTpUEH11z4z4LzqjZ8UTpLodldhzCrJ0Rk9/V9igmHIrBvr6tXrp?=
 =?us-ascii?Q?x+gSVi7a6rT05gpd+rpjscms0zedGuVksvTnmrl4KPCGgWAYjHrqMPvi9le1?=
 =?us-ascii?Q?YWpP0ZLzrqs3VjxMN966PCdWHwxzRz7D73117aqeNhphXba1uFYumynzKzUB?=
 =?us-ascii?Q?qzIPsXJ3w8lDRlT/a8TvQiCCdzmYkyeAeExg7FUH6sSiSFXo+pfpCndZ+0iS?=
 =?us-ascii?Q?KWzMJfQhhXrrwzJzloVQ9ODidHO0DFOxj1X0iR9rXTkD+JPWLCvZxPV1B6bh?=
 =?us-ascii?Q?6K65/tqK7YhZhXTBiYT1CMDwVsam10Y4yxu7prlLnCZ96b7rmAblTDXgXB+V?=
 =?us-ascii?Q?4M1hY2/bBRY8C9+FnuU2Al5OVlrfy2Xikn1pk5aRTbgfTYWsS1vy7FZPiyoI?=
 =?us-ascii?Q?dGH5pFOfYJJ3RI6MWaU5e7pB1ExGOoAvr7r0JzopsHZc2585FkAKg4pxItus?=
 =?us-ascii?Q?+BHgugswqf1//ulQmGciSOKYMydVzFDO5fKnHGPAO/gKjh3I+AAWLgg1XXL0?=
 =?us-ascii?Q?VSnaz1ARpxrsDpUb4yqIdDIIBh7LuxJCdjKMch8DgDEWf5tsqv96Vo20FYr4?=
 =?us-ascii?Q?hL1AhsVph6yhpgw/IWnG1Vk/QjqonLXFV+Cl5A8PWVeHtd1ebTotYKuBRMuc?=
 =?us-ascii?Q?QI0VEIWB7Ln/d+LhwN9WZQdqhOmUjv4P/HoNjMi0rFxo+sHzuBOZeWyLuVXa?=
 =?us-ascii?Q?5vBH4Ub38RI80esc/4D3gTRKyOKoUAmi/CgVW6msE4QwjnLgRW7RvgEVnMTs?=
 =?us-ascii?Q?fCSi9Dzw+7V1WzZumiWe5u//ejv4v6KJ4mHc6CXUVrVeqOnZoO/nwFUPLYM3?=
 =?us-ascii?Q?0vbK9ux5qCjEjRIN6A2eNWxFroV65ZDYfhK8uW5g0ldYMux835v68nIt1HEs?=
 =?us-ascii?Q?wODxp2A9LBUxLsuRyBxc1DKRdl6xxhuE0/VYeFlodIsDBA8Dy0g8nSBkm98L?=
 =?us-ascii?Q?H9t3u7e6SunFp6X0DNIUxD9uvBS4pcL4dv30pOT+ndmFKhQ7Shuf4FHRpI9n?=
 =?us-ascii?Q?DWiRrerlegTcQepvznPBLAT25F9TtUIGrmod0munOApUpAzNwDXl/ZGB7FEF?=
 =?us-ascii?Q?WfGC/HOj7MyfWMEu+Kh+52XeKU4L8jKO7uzm6QR7Mbu4gabXGQZbUkB1d5cl?=
 =?us-ascii?Q?FKN6e9yBSVvy3QMba7ZnRoL3a2NH1+3RFALA8+wNQvM0C1FAXV/zQOsA4F0S?=
 =?us-ascii?Q?xw7mXVPK1FgeJE4TjmjFvImAeEl788kqLlIWfNca?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad93bd8-4068-4988-0876-08de3cc887fa
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 17:28:30.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRp7v9yV0f9d0kPmnC9vvK/l6iSslhK/F48MjG5KgppAJF6z3e7qhqfzL5SNj03nQet3QYEEpx5il1WN4bodwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_092835_831973_0C09EBB7 
X-CRM114-Status: GOOD (  32.47  )
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

On Tue, Dec 16, 2025 at 10:47:57PM +0530, Vinod Koul wrote:
> On 16-12-25, 10:55, Frank Li wrote:
> > On Tue, Dec 16, 2025 at 09:13:07PM +0530, Vinod Koul wrote:
> > > On 16-12-25, 10:10, Frank Li wrote:
> > > > On Tue, Dec 16, 2025 at 06:15:19PM +0530, Vinod Koul wrote:
> > > > > On 08-12-25, 12:09, Frank Li wrote:
> > > > >
> > > > > Spell check on subject please :-)
> > > > >
> > > > > > Previously, configuration and preparation required two separate calls. This
> > > > > > works well when configuration is done only once during initialization.
> > > > > >
> > > > > > However, in cases where the burst length or source/destination address must
> > > > > > be adjusted for each transfer, calling two functions is verbose.
> > > > > >
> > > > > > 	if (dmaengine_slave_config(chan, &sconf)) {
> > > > > > 		dev_err(dev, "DMA slave config fail\n");
> > > > > > 		return -EIO;
> > > > > > 	}
> > > > > >
> > > > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > > > > >
> > > > > > After new API added
> > > > > >
> > > > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);
> > > > >
> > > > > Nak, we cant change the API like this.
> > > >
> > > > Sorry, it is typo here. in patch
> > > > 	dmaengine_prep_slave_single_config(chan, dma_local, len, dir, flags, &sconf);
> > > >
> > > > > I agree that you can add a new way to call dmaengine_slave_config() and
> > > > > dmaengine_prep_slave_single() together.
> > > > > maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
> > > > > cant drop it, as absence means something else entire).
> > > >
> > > > how about dmaengine_prep_peripheral_single() and dmaengine_prep_peripheral_sg()
> > > > to align recent added "dmaengine_prep_peripheral_dma_vec()"
> > >
> > > It doesnt imply config has been done, how does it differ from usual
> > > prep_ calls. I see confusions can be caused!
> >
> > dmaengine_prep_peripheral_single(.., &sconf) and
> > dmaengine_prep_peripheral_sg(..., &sconf).
> >
> > The above two funcitions have pass down &sconf.
> >
> > The usual prep_ call have not sconf argument, which need depend on previous
> > config.
> >
> > further, If passdown NULL for config, it means use previuos config.
>
> I know it is bit longer but somehow I would feel better for the API to
> imply config as well please

I can use you suggested dmaengine_prep_config_perip_single().

But how about use dmaengine_prep_config_single(), which little bit shorter
and use "config" to imply it is for periperal? (similar to cyclic case?)

Frank

>
> >
> > >
> > > > I think "peripheral" also is reduntant. dmaengine_prep_single() and
> > > > dmaengine_prep_sg() should be enough because
> > >
> > > Then you are missing the basic premises of dmaengine that we have memcpy
> > > ops and peripheral dma ops (aka slave) Absence of peripheral always
> > > implies that it is memcpy
> >
> > Okay, it is not big deal. is dmaengine_prep_dma_cyclic() exception? which
> > have not "peripheral" or "slave", but it is not for memcpy.
>
> Cyclic by definition implies a cyclic dma over a peripheral
>
> --
> ~Vinod

