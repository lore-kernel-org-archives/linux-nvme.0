Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F278C44536
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yPa6c4nUVPvl2AfDWomDGQDuHSSHWzia3s24AFuNzCw=; b=aceSYEdz1220QwNhA55b/8F4qf
	wVonuUIKqkqz0hqXQ96ZYWg5ZXZhkhmSGvRIV7Xv+DGdKXPziKtZka0eYGa2M5tdJcPEqCKM8UNqK
	tuQV9xnSJTCpCJC+PCCKf5TdfShD1Xp/QAx3qF3E4ZvYFU6Lnlb6/o376uFrFKnvnKkULzkjgrbU7
	3xLLoyuM2YU6kb534n49HdlndzMHaECiPlO+JqMe+QTdsNapuUGrtqqGZ1tmY3vyAloAVwrEph+UI
	WAW+u+s05QITog+TR8+jWy5QgByUxbdlRaYP82RXDY6PPckrOr/p424RmqiVHl083LqXcfAHiCiI4
	PB38DM/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vib6L-00000005nhf-1g41;
	Wed, 21 Jan 2026 16:30:37 +0000
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vib6I-00000005ngG-2aul;
	Wed, 21 Jan 2026 16:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5yxRDTbwhuh2VI+ocoVUXDnPXyVPU85LLyrdkhfVS3Y0ScDUXFjx9zdW+5OgP6jvlK56sRcAWALXB252lGmc/eCvijqmLAPn9FGZHDbY6TbnfLjAfVWv4ydnqFeuv0MVxMbPbJNnoHGsbB4ZZOxAllBZ919zOPxeN6goUtyJy0F4x0OMpRYY4lXZl/m8cQGDNNhL1+47UpbvZs+3ZAKcfIBsiC2VtPKZX7BqCmbcL5cH6h/Uf/tyKSNReXAfsMP5cipt9KzuCPsMFSojW48ZPU6o1o+15xxe79XXOdivNCOGeU3UuweqomFYVD9JhU3Gdh83PRmVjBOrOg0khZnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPa6c4nUVPvl2AfDWomDGQDuHSSHWzia3s24AFuNzCw=;
 b=L+hk5av73Rayrzyolm8Eypw7Kk9BcvLpqBKXslGDT81CrP+jeceW77L9fPbnp+NHHUlSMdiNLFtJ5zMapEeu2U03vXNqooAhpUEaI5Z3r03juI3ImbxU5lGlyt4SC+4i832NkhhN5zL1QAYJF5o8I+TcI9QH3eV/aueoBaf3TTcqKzRF35x6Bt3Vt9RtJkR0gj/6TZDMuvzz4H67GO7BGU1P4SfYX2sQcHf0mraVKicJmtl9MV1lNL0ZlBS8coJU++Xt/18xMpPOk1otXoSWl8/cUE0f06k4daKM1SO9C8mvzw+VafxHD34/l1vvcbQ048rnNoNrTRMQFzr2BZrYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPa6c4nUVPvl2AfDWomDGQDuHSSHWzia3s24AFuNzCw=;
 b=Flv4vHc+lG5v0kJ8TX6pcpxM7DYsbHpPplR13fk96M/SNEpAL59xXJjuHGCxxVSn41E1I5wetuHcEI3HLYjkqxO2RiRJecTqBw14jHSGcpRA7EnU4nyqX9M5R4jDRNrkcl6a+h9yVRw3h5iEfk7N3XdlhHvDNsRkj7CwrB8PZkdQUuP1PYkz4uPnsmNSFY1OIkMJYVpzo9pVPK7/HaqPyNwNxKr105aUhjGHpFo53dr0whtEG8/qZIYDH3kicqobznbsNhmjkPgAxPRBDoVVijq+3UQ0XHXoVVhI54NNHNxq518DuyKVnAHrfQ6uOstAB39m3kMucJXUi01LminvWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Wed, 21 Jan
 2026 16:30:20 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 16:30:19 +0000
Date: Wed, 21 Jan 2026 11:30:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
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
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aXD/EYqhhRJEN8oy@lizhi-Precision-Tower-5810>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b93377-01a9-4ca6-00bf-08de590a5dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1UPKYGRC3JCX8vTqxqR99BBEcQy94W/RQytFisVmzYEIugLZ9XPRGXLTZj/+?=
 =?us-ascii?Q?SOdlBdtlnL3EtZyYQFf3HErHLHcfTGYgyUTBwo5laF/c57AKDorPOwErncqv?=
 =?us-ascii?Q?Jhc7m0iM1ne4ya88fiR9g304I3G2j/D3cNRHE9EsVg2jIEeLp/LzfmcFHyJq?=
 =?us-ascii?Q?of5jMF6YSfhZVQeepkTph4vvnVy1cVe0CA5ZHKxrsPvGM7BzoslraEVnaxCY?=
 =?us-ascii?Q?Wk/xz2SA+VVDSuW8pbQGYBbR9XBT4UGqBoXJFdNvgAJh7WRO4ccOrWuq4IDQ?=
 =?us-ascii?Q?B8jhV7UaX4oS9xRQkzMBvq99CUVWFLJL/OvVyO3sPb1WVf/+UXCMACq8vtsz?=
 =?us-ascii?Q?Dd3SGcfro5eZUfsODwaNo//HMp3YVWRTvcqjrbgb39yKKpVun0ZVO6ZZwR1W?=
 =?us-ascii?Q?CgTQTwtHpPBGNii9ZweZVy2F/3+iwx5ZHv+NIDzQT2p4sStDVD+35Q0Ni6sx?=
 =?us-ascii?Q?rbF8MFcQ/Ie8nzdw6BcBH0Ecpeh4nHphttx8XwY/LFXleGFH/ikv99zr+rKj?=
 =?us-ascii?Q?NbL/lIcrNfCYkeEBm9FpwSulQQRVz6zx1c0wevxrHSzqEYOzUGD+ND4NxMoW?=
 =?us-ascii?Q?7tyJ8w/kpXBWdAY1PQdP0cYRB/YAqsbQ0mpAfxPo0Rqrsar65DCOrM8C9dXy?=
 =?us-ascii?Q?tmsRglpr/35alhC8BKAB8txjCdFJZZpw0wn6qKWe9kST/f6wHwzETLV22PVE?=
 =?us-ascii?Q?1a+fWMp0j540gKz5itXknS9cYp2076EzRx209PZhQojclyUAoZ9NskepB85O?=
 =?us-ascii?Q?30PD+SnLBwukJi6KMkpVMSdo4KPlQtkJBQcdVekkAl//ibFZq3+bO4iRE5r4?=
 =?us-ascii?Q?nZxaj0LlXeM+wm9udEPybwmGiCSC/VeXnR49mMARKuvUTmi37dHz4RW2GS0n?=
 =?us-ascii?Q?EOzeySrmEaUlmaU7mDkkJ1QuyHQ0IHxVXX/9rFcJHbC2f1m8Vo1p3EbG3H8v?=
 =?us-ascii?Q?FrnQbo46UjVbEKHOIjG3hYAKT0B9xq/eKZ8LH1fy1fbzQcClMbDsae9v1sH5?=
 =?us-ascii?Q?QAWEte06ykbFN8xc0e1snlXvkHw8quX7MsyMAFrqCGSGImSzuVO4dxvYdZTp?=
 =?us-ascii?Q?wyqd6G7+RMMNtOG55upCaUbSayvWRlE/RDoVzdikDqc5+BxzZ5dUkDt3nz/R?=
 =?us-ascii?Q?VF7Ye6Bb3OB7Ec8kddNVA7/zsEJ3Mubw2U59g0GS1IhYfHqSQ4zIIwBR/7Sm?=
 =?us-ascii?Q?K5fqUq9HsjkqNaz6SF8ecPs6cGOv85sn7wriM6Jweq2lGpt3d4qnc2Dj3gXq?=
 =?us-ascii?Q?78zhvT9NgEuQrWmt9ovpHfpqHELQ+yLZdf3t98UcbTFFTpasYZ4yKcxtCpt0?=
 =?us-ascii?Q?5TZXud62DXECwPfbPx2Yspri4i2Zgmq6Y+ozdISwTOsZMfETvRATfZh0I1PM?=
 =?us-ascii?Q?edbP3rPp93d2qUh1aEyK5fg+V+MH+Py8v+tXM3HgQhqO6G8HRRZ79Oejf08i?=
 =?us-ascii?Q?FX/TQwzApaC4oMpuxlFuX7dugW4ZRLtVA2EtOM/QCvh3XNSVTxKZnBn1SwVb?=
 =?us-ascii?Q?yGSOP4gqtjBpnTUDMZvYu3pHDn9I6UJ8Q+0jMo4fcXTOJZF9IM+unYQF4RaS?=
 =?us-ascii?Q?XSWac78uZVnN0ZtJOp+l3MGtXVDOXQCLsCwcp1e2rnCNQcnTf4/69jXjrf3C?=
 =?us-ascii?Q?vMyxLsZb86By9Xntzhr70B4nm+Fr9TbslhURlf5XrBPp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?csqkhSw2MsoEZJ+xTuhr6S6wwIVqn7S+83Xe1wiBPSZRMgEqNssWaYc5qObu?=
 =?us-ascii?Q?9xAp2icZ0q4fvfn64P0+dLCMQykbDxBO4nJB4d7cY2z6EAddDW9wxN2E6Hsj?=
 =?us-ascii?Q?j6u91l072a5lN78ds8mnTgCixAf3FDotFlUVPCZBc2k/xX+ODOlqM+XfS5hF?=
 =?us-ascii?Q?IC67bL86w7sMcV1OT6maA4Pf6W5zNVvIxKXjvjGPk6Iv4+7xf78kpR4a+YcY?=
 =?us-ascii?Q?YG8/I3KCqrmk5GB42eInS9DKQAb0jynFQFUpow2ZXUImmjm1mojLWFKz+oG1?=
 =?us-ascii?Q?xOz3FK01Iws4qwpFma5jeB1aI2VHOHLD7f1LJHGgvrx3pJZ63PJnlCEdHtiQ?=
 =?us-ascii?Q?zhAuOz8BUhejj0MLfXiqihQrxf3exC5u0Mnjb492dOV8/jwDn+cLksGjgOLO?=
 =?us-ascii?Q?QeG1FH5Pbwj1gw25HTNHr4ltZjzN5h6DrHiiESsdeE+HRNMCRsx0t+ou7Dbj?=
 =?us-ascii?Q?iufba6dlayODhYnJKk2t90phFnJ1h3hhQBggn8cgNWCeeABlYeK09fzkpFPw?=
 =?us-ascii?Q?DAAVujK3I8q0uUs9FKNUfM6LCEQ/jon69JeYz8GTCtHzZheDowQVxW6wcP8H?=
 =?us-ascii?Q?h8V01atY5ViE4vuPDVhtid+yNOgpAZDQGJ/tkNivsns+04QR26TQryyONK+N?=
 =?us-ascii?Q?TGgQk6KGqMEW8Mt/FqBvaGRkpb1STIQR1U6dyQJzXvuhUx+3kcjgz1gYTiPk?=
 =?us-ascii?Q?FA+kofPYOQq5W84s9axazWDwjlu5ftcdG9LNqZwDLf+NeEzNsJWOMBGvHqiF?=
 =?us-ascii?Q?EkDGHcQ7iCmXSbDKSIzgMedIaZH8yNctt0AGhlq9qi8pVgAUgUsHWD6SU6LU?=
 =?us-ascii?Q?m/2zWY3KYzmn6yrO/pP9kFJ8U6uI/pQ58aTe65dKId+faWCXYz3xndHEjfe9?=
 =?us-ascii?Q?MbxP6iyQjg1N3JhFqI0SLYB987lTNf5vJTGCgqdDPeNNjs1T9UMmwXsiw4E9?=
 =?us-ascii?Q?XUHaU3Mdg1JrIl77FWYfsRDKGLBn35fLNF1ASjFopSGeNaDYHHIuu4kmiK95?=
 =?us-ascii?Q?8b1BdT4fCj/PFsaFqZhTYa3G9IY4xmlL5FbyvgjS1v5t0aCzNO12TnH+Tt5R?=
 =?us-ascii?Q?HDn0s06O0AK5jqw0abVK75fZj9uR8mMS7c8m3rpB0cc7yZWPqUCmVWL0N4Ss?=
 =?us-ascii?Q?MnhhHsJrb8031qaFajM9UOaH5WIJcPEdAHg3Q3I2+Jk77f1Cxa365PG/CHXG?=
 =?us-ascii?Q?8/7lzFmg6kvUSiytfVfvpwEnQboSfTz8PGislWIaFJCJ6vGSKdV1kHf83TjN?=
 =?us-ascii?Q?EBcW6G7fsF09VJTnS00F2qscDcg4DkA6fVt7EppUcI7CBvCdy/3P0X6/icVe?=
 =?us-ascii?Q?87W12WP8lfZFggzfSl4iicUU8W0yTnvFg+u1sr9yZiM4bFcJezG6BgutdfdW?=
 =?us-ascii?Q?J6p+hNy3Z928ro4Nfs8M7IcXnF+PfeV2iTMsFfA636P8ic6LzXPe9O+rhUAk?=
 =?us-ascii?Q?pM4aOfQPRfZX2/+yxXdEeNU4z5FwtCXrDBSC1Z8rjaCBNrzxor4FXY+fYjEJ?=
 =?us-ascii?Q?+YTbFyGyviVTdZl7kyF7CqsxUQpvhNMj2M3K//D8bstGk72I2CiyvkXvDnLD?=
 =?us-ascii?Q?RSpvnuihME+SFsEDTDzWwq93xjqjMhrbg+zdA0nVJi4taPrLNfQgQBXzSJHN?=
 =?us-ascii?Q?RjJcr7gCRAOsWmoT+3AtfxKYmffvPkJ6W8V9hVNEg+HJxCpfpyHEiz8PbtUE?=
 =?us-ascii?Q?Ts3PWxrTlaoKZluL8LHMv8B95D6ZkRLl3dhQWGLkOAcm0RH4Pu5OrDGrXpb+?=
 =?us-ascii?Q?jrrpHlASDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b93377-01a9-4ca6-00bf-08de590a5dfe
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:30:19.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSolUvmJg8Uzr9UQyijFgYgpj4o/9mH1nNPJao51sBnKdo4hKZxcnHVrYHWw6U+zNa48lF5k5pp2usdaDeu/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_083034_660730_EC8AB8EA 
X-CRM114-Status: GOOD (  20.24  )
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

On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
>
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose.
>
> 	if (dmaengine_slave_config(chan, &sconf)) {
> 		dev_err(dev, "DMA slave config fail\n");
> 		return -EIO;
> 	}
>
> 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
>
> After new API added
>
> 	tx = dmaengine_prep_config_single(chan, dma_local, len, dir, flags, &sconf);
>
> Additional, prevous two calls requires additional locking to ensure both
> steps complete atomically.
>
>     mutex_lock()
>     dmaengine_slave_config()
>     dmaengine_prep_slave_single()
>     mutex_unlock()
>
> after new API added, mutex lock can be moved. See patch
>      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Vinod:
	Can you take care these patches? At least first 2 patches! So
I can did more clean up at next kernel release.

Frank

> Changes in v3:
> - collect review tags
> - create safe version in framework
> - Link to v2: https://lore.kernel.org/r/20251218-dma_prep_config-v2-0-c07079836128@nxp.com
>
> Changes in v2:
> - Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> - Add _safe version to avoid confuse, which needn't additional mutex.
> - Update document/
> - Update commit message. add () for function name. Use upcase for subject.
> - Add more explain for remove lock.
> - Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com
>
> ---
> Frank Li (9):
>       dmaengine: Add API to combine configuration and preparation (sg and single)
>       dmaengine: Add safe API to combine configuration and preparation
>       PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
>       dmaengine: dw-edma: Use new .device_prep_config_sg() callback
>       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
>       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
>       nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
>       PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
>       crypto: atmel: Use dmaengine_prep_config_single() API
>
>  Documentation/driver-api/dmaengine/client.rst |   9 ++
>  drivers/crypto/atmel-aes.c                    |  10 +--
>  drivers/dma/dmaengine.c                       |   3 +
>  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
>  drivers/nvme/target/pci-epf.c                 |  21 ++---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
>  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
>  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
>  8 files changed, 177 insertions(+), 84 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251204-dma_prep_config-654170d245a2
>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>

