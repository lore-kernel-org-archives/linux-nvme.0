Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA6BD74ED8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jan 2026 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s+Fsp78axgwdL5lAQuDsX9tQIt3SvVFSvczUiQ8GWvo=; b=Ut61loFsBlbSSnivTm0lbs1L8W
	szaBy7nKwulDnQuRHf01WGQ0rWVNIdhOD4pK43YjCuJdniJMeYgftwZoLotF0GgTyfjI2AKcPZteT
	tWPRKdp2vuZFgalozQjdI4Pu1M3UPbmiCzr2OJdMwhoV3WutIySan2iyyP0YoRDBzJN9RMvNUxb9b
	Fdu5PWP4yki2Rt57fMr3KepEBDI04xXkQJ7FS7vGTA7e+PTR6AgEY6KujHetwifwfZXxzy6XbZiCX
	5XyrzFGzvW0vS5QUqwDCcF1atjOeLxyLHznhqQiXDTtTOxcpE9CA4oR+B9j57CiK7pce28g8kFjCp
	WLZl+u8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjHxC-0000000918s-1oJf;
	Fri, 23 Jan 2026 14:16:02 +0000
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjHx8-0000000917c-3LqY
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jan 2026 14:16:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRS9i1EG720vRTidiO4eXL2dywp9i3xyiLqdfVr2e0loW2ItvKxxtdJJ3VwaA6nxrrZqOxyfaINyWnJYIXAqEqCTwM3o/dA+HTmmaJFavleDQ53DK/m2T1fZAJSgM8eDClzNKJ/zU4qt6TOmmoGc47/fAw24D9Nqq236rYnqMZ5M3lnNdpSLrXcI/4BMDH1DmnvGuHSXrQg4oNGhUPvjnn/H7uPEzj4PbpOweVnaRy3qRSAg5jxdSZ0EuDAfIME51e4kz+aNCnewsvZssmQmocYtVH1GhcO0LmTWTVmEtDXJsNrgFu5YXMAVdRbMmGdib4jbUFg0AGNMzvjlTb/mCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+Fsp78axgwdL5lAQuDsX9tQIt3SvVFSvczUiQ8GWvo=;
 b=lr2ndwFB6lIiMtVhj9RA2TcW8rL3F54WoehWRcX5mYI1Ds74UjwVDTyXoifsrR3HzvMSuXcH74sXc6WZE7EMsqgQUZHMUeYwv+OOFrsZu1379/i66U3Vn9RQco7B98dRNocuQUvs6ol9JyseyhCmb3RjmFdu4PoNYxYARDAt+RYsbUTJoVdi8sziWV/+v4iFnwBnNQioECnVGsZUBno7yueoj2Rjo2ADMBpQKDDnDklJ/J1aoVJfpqSuTH0tiTRO1NIe50m91Bu3kKRdcRGjVFT37VKg/GuR6tL3wkVb6rKd+6/feplIYB8QplPnu+qSIqHdnsj2tqk13+qccrZvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+Fsp78axgwdL5lAQuDsX9tQIt3SvVFSvczUiQ8GWvo=;
 b=O+XvBg4V88vk88jYAoApOmCUBj1Atrh27gghquI3S6YVXHMUguGz+a+J1gWK4BeTMMkzHGD74SpcpfUCcaL6ZXKawuh+p0jLoGb6lRKnFmL5YIT2pkvWwrfXNwy6VzFEWKs6VNNOK7r2HtayxOuyRB35/Yw6+2XJKnop5n4URAj2KakdYkqQjEJPq5PT8dJ5BZmjt10/5R0BwCoW+HxDyG7tHf+8i0F4khIMAye8+VI1uLjNEyrljJ7DM7YFI9xJQv9sRS6KPTvrSQYW7MRaiGiBqofg+VyaedwYyFpd8r6KwqLrfMusJdCMN4qUX4LxJdxfovrZYcZEfJmmdbPbgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU2PR04MB8695.eurprd04.prod.outlook.com (2603:10a6:10:2de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 14:15:50 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.005; Fri, 23 Jan 2026
 14:15:50 +0000
Date: Fri, 23 Jan 2026 09:15:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH RFT 4/5] dmaengine: dw-edma: Dynamitc append new request
 during dmaengine running
Message-ID: <aXOCiqeJtx5rmo9M@lizhi-Precision-Tower-5810>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
 <20260109-edma_dymatic-v1-4-9a98c9c98536@nxp.com>
 <aXNQcowVEMaE1xr5@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXNQcowVEMaE1xr5@ryzen>
X-ClientProxiedBy: SA0PR11CA0201.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::26) To PAXPR04MB8957.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU2PR04MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: c787c872-7217-469b-390b-08de5a89e8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Gvw31zCQcGcr+X/G8aRKLZO3d569ZgGtU/x/naahXkF9ojsU2ZXEtj/ekTX?=
 =?us-ascii?Q?zY4zdjNT/1wd8ySTYZ7H9FWX0vOhYSnLT+xe9mE4Znm0GU5JSWgxgQY+WT9M?=
 =?us-ascii?Q?IHEU8pExoB7IwJ8QHPWS1ulb6sTlo4DF8ukRNezvqPCXMAgtZs+lYLmI60TN?=
 =?us-ascii?Q?/+UyKZHaPxjuh4DekVWx4+iQtZs69P/vHqxTBgt2xHHuouXmH6Vz/uiwC/Ef?=
 =?us-ascii?Q?qXF/yXnzl2AoMT1IejNgoEr7ZpA4RX1jm69FcOnxh2QNMmRaV9rw4ZNQDP1Q?=
 =?us-ascii?Q?zrz6qIi/SmUfZnU1DVmTDSFZpu+8e253V6clj2ebkT09+AxBJu3B9ly+yfK/?=
 =?us-ascii?Q?gTiSCpaVEtynsJZVWnJznt+vEd7fkHkL5/5CCE00XtAV0f8TDHLCPV8oymUC?=
 =?us-ascii?Q?3kDDyh1d6yAUkYQI9325zOteCLCrCRWqCBz00QOfcJM0UKWHiYkvHsSQqYw/?=
 =?us-ascii?Q?B9okZeFQc4ovz9X50PkyeH16SYXKwtODhEARKP6Es5BIYmXY5x0V/lN7d91W?=
 =?us-ascii?Q?z/eb3oXCHZ2xhpE/o96B7pPKPi2tXuV65JB143Be+2HlKWpJ3AZVNOobsEPX?=
 =?us-ascii?Q?/gfBZvu3ziBPD5u5SETLV6uxJmwEZXLEoBAmWtcJeHN/xEYYSTIGrNo0sCVo?=
 =?us-ascii?Q?/SIxlfdEVJNXZo+JcZJU2QWPoriESw0MrkNAkA9mFCUcFVG+FQKNvqkvOLcH?=
 =?us-ascii?Q?sgelamzy3YwJE1ifAGOzFqCVMal8ElzT9E71zuppU+Xl//pQ+TzeItUdnIC5?=
 =?us-ascii?Q?VnwmraHHbJib+luedBepXBham7YdPuBqhJZwqlCdVM3mKoppFb3xMpwRImi2?=
 =?us-ascii?Q?Z/UViO04oSImVdRmkbNg2hmueGioIm2oKPV3kfqlaK/AD0wud48vT6hdgrBE?=
 =?us-ascii?Q?UUp7ooNQ9pmq4vCknhjrcXxU4e6ja4OWcSxfdsymfAMd2wj2DEfG5v1m56Fe?=
 =?us-ascii?Q?xElfhXf+6L3DKQbGgYlrj/viOdG6GIOcndKVulk1tnVL6r7SvcA/0PK60BEc?=
 =?us-ascii?Q?UI4G9EmQQQFof9MVFu6vB0mA5lxJrbDTeV6jhhYOkQF7hOOYJEACvPbdSCqn?=
 =?us-ascii?Q?cXgCC0QYM68H9IkqQqYwRsVOnDnBRMT1p76v/9cUqVuoWti82FnVYefWrFQ2?=
 =?us-ascii?Q?dW+7MJYEjMKjzHrDA05WQ2CK6Z68YJFRxCLNc8J9Pssp/L8++AxtwseR6wWm?=
 =?us-ascii?Q?NzIfBGcxiJBw5ulQy8rZv1m8uQ/PJdSQXEyAKWvse/HcjP6qvaa8rQzfFKY2?=
 =?us-ascii?Q?hvU/0fsxlQzp34MixQYZdq+4b4iVpeTaHj2kY6AZq2dD1R4TXX2EBGFbUhze?=
 =?us-ascii?Q?5Uz+KRP6/t8cZSI0pL/ZlqnhP/E1kSbkexzJ3Z6UiRIXhueGjMmtWwK78h3a?=
 =?us-ascii?Q?ROASDi+bgfcvJuzcyL+y1KvcnWnBxmD5Z87XyPu1GV6dFe/mcsQFQ4yiRoa3?=
 =?us-ascii?Q?1XTJlL/tKeBBmjetcfHIjFv49e8LsLImPyhbUeFPGayZS3hscIrOcUxcIYc5?=
 =?us-ascii?Q?m3V7r8Pbtb6Jg5q2h0lj3lRIrZvvsPoIo+X7N7m+yD1sSGP0pkviTEhedTYj?=
 =?us-ascii?Q?WqNTEWp49DFpkFPc/7yl05Up6iF7gwr5kdtNJYsCYidsoYXmGnE17iXTHJwm?=
 =?us-ascii?Q?7ZqMmgi6hSfe6OAmHkFC0oo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjGGSMOvNXxgvG0sFkhXGDg+h1P1sZQxDZS+wasnS7QXCchbSS/JfLsIURQj?=
 =?us-ascii?Q?qANrXZHV/CHPhD5zmrbeDE0ACGWVe/l+RjYRpeE62D+2UbC1r97hXGSUtehg?=
 =?us-ascii?Q?UmRlry8Ek9ZrPuqnDDZ3x0RMtYWcubPQmRIT+fSaeajQIuonXwr809H5AYzB?=
 =?us-ascii?Q?mfGkQgkzxzxXnMZckyYjvp7plHK0Y4MVMymXPquK6TrzaCI4/UuQ6JUoNpSt?=
 =?us-ascii?Q?lt/Ya9ypbPS6vAOrnLFqYPPD21x51d2AOGRUkadcrX/4XaTsHjho93B6RcBV?=
 =?us-ascii?Q?9b/7qD5MHecnJFL9iv5ea2MPrfQ7NrRLElucjRyTM52xQUjGcdWJcCuBuqEn?=
 =?us-ascii?Q?1saXEkupeJNQvOdJ6yWzDlj62OxygNy3JgtdhzZSXRr4oViZhbLewwhKe1de?=
 =?us-ascii?Q?Vtb76bXzuo+/djD6pxz1QCjafktYyEdXt7ut4Fd8EHg9L8n87bBgjTC6q8QP?=
 =?us-ascii?Q?MnaMd1DDPlEcNzxBswI/OIQXfRQ4gLZI/7CMr4wn3RaNsmCsUqaI9adZKBCQ?=
 =?us-ascii?Q?DawhMeEAsyBxUWtOt2w/V4ouGVk4QJJ/2fpQXTMBRYMgp+NLC70dtdRBunTU?=
 =?us-ascii?Q?GX1PFmiX3G6e+r00oxAvaELBLXc6JouMlmOCGwHa16JThNKef8UwIocl7kZL?=
 =?us-ascii?Q?PQKVr9DcbhXKiydEaXQ4PLBGxmSvziic48wgbikcY00MRrU8iI9b5M7MdW8p?=
 =?us-ascii?Q?h1HkD+sJYVSXOIj1Jyz3WOwhR3TwmbZj3b0+UZnJc1qnmgCQh/YM9yE1+g3c?=
 =?us-ascii?Q?+Bwunh4EtT0gsQpjKTW1jLArsdD+M9YzM4JJbh3kmAIUqvNF2QQqPkb3yANt?=
 =?us-ascii?Q?HPzHn8qIP6uPpeguqKJVPOYECv+qM+2QWg+DFNZvuFFoE2DGV/yMU9bHEPls?=
 =?us-ascii?Q?gfd0ihBPvLmQdIfvpKLEMY2aHfKxpYM6ylb4eOUVpFNVBYIkmZEijy+qkwMc?=
 =?us-ascii?Q?puPjvYVIzE61H+zO0rRShE1yA6dtqw4YYAvFpw93IomiJGQ1cZ2wnSA+X5//?=
 =?us-ascii?Q?LMdKY2vE8VHpSdDmnx4Pzs5zZZlQn8kXH2OnpEhUkNZumYUSrpKpdycHI++B?=
 =?us-ascii?Q?MpHRbIpskL5aU+KjVIkHq/NKL1nSCGuwkSpvhSFxqa/wGM6eAJvD2/bEiV/l?=
 =?us-ascii?Q?cqwcIzTtZhz4yv1roDBRT3sCLScy3iemuA8cfuKteRPEGqhnzntplAF5sK9A?=
 =?us-ascii?Q?XCt/56Hl+EBCBGjT2MfIhlLpKvXfJ6vPxgBJLz4N2a+FESIahaloVDFcj08O?=
 =?us-ascii?Q?NIXEZy7hgofqw07ddowI4XTkmTgAdbJ179j3E+K6prCa/V0bME2wHUvrJdYC?=
 =?us-ascii?Q?uvBjc/inFofnO7raOCkYrKUDnD+EqaLWDI6ZyL331LwCvCHhuoNZ3c0nwpzh?=
 =?us-ascii?Q?2XvW0r5cbwjf7h2EcDhvhVmVBWChlduJQkR9DgdVAONpNR3zTyP328/CVYC2?=
 =?us-ascii?Q?O7BaRhKLmrBR7FrHQvOtnRyBDryaS5H7hwf9AMOsnxy6hJyln2vXtQAQy5vE?=
 =?us-ascii?Q?PjjdphlzWOxN2nv3LWNYKkzr5t04H9qMdmcJsm2tDtAdC04bV3lGBp+j5En9?=
 =?us-ascii?Q?D52BkT2xzD2C6FJj9c6zNLuLJ5+1RNw7m3BknfN6UGIHHdHzz2tGD7VaRD00?=
 =?us-ascii?Q?nQemB1efa0d6J8+x1zWj7yYh7PlkmITv7sghwrSK9YXlklGQbjEIea6SMXHq?=
 =?us-ascii?Q?YjNbrf/CSWyIgxS22MgY01H3MPMmb1WpX2/qfcP2azO4twqm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c787c872-7217-469b-390b-08de5a89e8ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:15:49.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbeCoUCU34zhtzbwSxtoVG3J765fRjs3F+DEGJXKCCoHHXpC0vl7KMrS5CtEkVq9l6SHl92G0Sc1GxISS09t9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8695
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_061558_837658_D9099163 
X-CRM114-Status: GOOD (  17.75  )
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

On Fri, Jan 23, 2026 at 11:41:54AM +0100, Niklas Cassel wrote:
> On Fri, Jan 09, 2026 at 03:13:28PM -0500, Frank Li wrote:
> > This use PCS-CCS-CB-TCB Producer-Consumer Synchronization module, which
> > support append new DMA request during dmaengine runnings.
> >
> > Append new request during dmaengine runnings.
> >
> > But look like hardware have bug, which missed doorbell when engine is
> > running. So add workaround to push doorbelll again when found engine stop.
> >
> > Get more than 10% performance gain.
> >
> > The before
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> >
> > After
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
>
> Hello Frank,
>
> First of all, I hope that your:
> [PATCH v3 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
> series will make it to the upcoming 6.20/7.0 merge window.
>
>
> This RFT series however breaks pci-epf-test:
>
> Before:
> #  RUN           pci_ep_data_transfer.dma.READ_TEST ...
> #            OK  pci_ep_data_transfer.dma.READ_TEST
> ok 14 pci_ep_data_transfer.dma.READ_TEST
> #  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
> #            OK  pci_ep_data_transfer.dma.WRITE_TEST
> ok 15 pci_ep_data_transfer.dma.WRITE_TEST
>
> After:
> #  RUN           pci_ep_data_transfer.dma.READ_TEST ...
> # READ_TEST: Test terminated by timeout
> #          FAIL  pci_ep_data_transfer.dma.READ_TEST
> not ok 14 pci_ep_data_transfer.dma.READ_TEST
> #  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
> # WRITE_TEST: Test terminated by timeout
> #          FAIL  pci_ep_data_transfer.dma.WRITE_TEST
> not ok 15 pci_ep_data_transfer.dma.WRITE_TEST
>
>
> After a bisect, first bad commit:
> commit 352fd8d5ed468ea616eb4974b5ac19203528b207
> Author: Frank Li <Frank.Li@nxp.com>
> Date:   Fri Jan 9 15:13:28 2026 -0500
>
>     dmaengine: dw-edma: Dynamitc append new request during dmaengine running
>

Thanks, let me try to fix it.

Frank

>
>
> Kind regards,
> Niklas

