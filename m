Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B80FC88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Kp1PPhIlq6Vnqb21Ms2cIcDoPucU2EEYF4MXHE/R+k=; b=Wt71mw8Nh7W+cYDLzzcsBT30Lj
	eCBPUxnojkESBmZph1g6hB2CtytzrrP4eb6tU9Aczdtds6Vr2wJ5tcS/5W8Ni1ZO1nDpAnRC9ovkE
	af4otsCgv3Ad9JCHkjHT3+Q5r25Y6rvDqg8BMQ2YksjYcPqgkktf3yVCr77b0j0YK7+gcTZOVQErF
	dFVqDN7lbbQghOAjMbFLvJqDC58UbIGjJnAR7THRy8iUYgwYoy0AYzaDnxRitnvMs+E8F3O8B1oTW
	bJFhHK7R1ut3OrOZNOIOquOMTKKKdzXbaxYIu/U+hEYtTEGEEJlOP+O4CakibWhzqF2DaBk2K/t0J
	WQWOUIEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67QG-00000003wgO-15I8;
	Mon, 14 Sep 2026 14:12:40 +0000
Received: from mail-japanwestazon11020112.outbound.protection.outlook.com ([52.101.228.112] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67Q9-00000003wfE-0Yss;
	Mon, 14 Sep 2026 14:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTKU/SXmPwMi4EIbO33yhdo/MjvwImXa7iRZZOSpmEyMR/xexlSR5gIGwWpCVexXSs+rr3vzy8tff89hFx2XOZ6YSRIyv3qN/2/EP/jFkNwUExotvjUqCIg2Psv2DQERQYoEC47nLY2tg2GwwoIIrMlDCLPmsw/wNAFqmIXohIGe3P6OKOqlRBqqm/pdlBAYS+jB/KHSfftIZUb1qnbJoXrSW9gnGtmq1/9jBMnd0m2KaAGY9mdUPSeEVzKcPWcxM8E73HV73ujsBPMX/v/UPs3vHq/dB2aIYK4COuXZDnAlPKKegKocR5kh4VKhcKu9efjc57Qm3OARIiDsOHo9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kp1PPhIlq6Vnqb21Ms2cIcDoPucU2EEYF4MXHE/R+k=;
 b=F6B3PFWLgjZjiACp9XfjfIrhkQk9DhjaW+biO+gzt6vhL/7LvVFV0FctqRsXg1tJW92Ueh+Fs/sRiF6hq3/Pqa5RDctZX6MKPp7/9bJ3ipJ2fXFYzUaHcfvGWPoRmzhQPMGFJDZBLF5RaEX4ddlyF6lwXsDocw/mnpDMymhxUEipIGwrvl1LZTT8yZkLG3Jnx2Y/ils4UAw4wVOQfdhsrgjlwjE4wgjRO/0fOwKGBoHqIfiw0w7erVFoginXhHYq9vt0tNQcO867KJnQdpYKWyXsWNBunewaFTZvczqdPltr2iiXi6DOIMrUuM+vyk9Xzz2f5Hv4pe/w+xsHc9WBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Kp1PPhIlq6Vnqb21Ms2cIcDoPucU2EEYF4MXHE/R+k=;
 b=JjaksZv1cAhilfCnDWc65lrX5pJWdq4kQ6AB/9PoBXCBwpRDJzl8gufxZYQfYuG6YD+YHdlK6tXM0yLQrZzsclqGzHjH2T2MBC3NTsIximyxSLLv7Gldrnny1S/lionvGIjhJBO1mg5XuO0N6RAXS5MuMU812Bc8gJd92H+d8AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB6191.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:338::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:12:24 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:12:24 +0000
Date: Mon, 14 Sep 2026 23:12:23 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <mmcripxdekhktnn73ikylthajkdnincwu7p2nelcpcqzexpf22@rrmmzr6hfvzf>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
 <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
 <apXdm2I33edo8kpZ@ryzen>
 <sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd>
 <apfPWc09CY2o-P5s@ryzen>
 <zxyr55h6s3tjc6pe23wzwb77dxppsljxcagpqhp4u24cqka2ne@fesick6sneto>
 <aqff0CqBIDeMMTke@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqff0CqBIDeMMTke@ryzen>
X-ClientProxiedBy: TYCP286CA0365.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b745c1-edda-4f93-aa46-08df126a333e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|23010399003|1800799024|366016|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ulZysTGRaabIh6inww4YPu2KpV52ws3+4wuUMRg+XwNAL5fO9ztTxM0WPRz/EzjXAT7rP5OlOtVNo9ftPiP/aS4gjfzJ0hhvMgM7dXvzPAJmxWmiA2K2SGV6ByeKYiSIh/z4jLR2eMcD4oP/jWn65x07ex/rSE+rlGINw+Wqxa6kkczQcP6rF1jSbz0kL+YVIJjTiBKlw2Sx52P3yKXObH4R7mIrtK6yMpNQtxlrO/liCDUkbuae9VxnVWk0Qx41NvCcSF30+PzR4bmdPUM/lGZiPa7WEjPwPJvj+p2FeGL0m1BbkI8KyPZGZEUpzxeRVk7+MlwGQ4w7Lc/CmGn1kCmOXyk4TxD+JlsrYj/qBc9uaZKsOquE/+CG6HBb8YV/jy1S6Mkna2rjrUqnUHFuUl2Zy0VyuWWFKiDCf1mtq2ho7x8u8NXAEWCJbsky+zlL1iJa+FmrdVhd74HdEKfZC+t8DjaiJNGTxuIQaafv59kNbhxGkgmTZXbubMtDlW10YkkUCTrypiGE2HJ77vXi9+l1b62LtuDo5AzLDF93BJC/rtiJ/I3ab8emDbhmEYB8BSRmfYbEBRqB9uSLgLIQGl8zQEwXpypSjK7Rz6XRjV8Izymfsx+Xb9er0S4YYP5ASuuA2VYtFuW3gQldUfy9952IWXaVmS7IpgRd9fc9ICs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?la0u7LKqTVXBP0aGBPFbCEE3mjfwxhZzYmxahPxGhoFxMmyMbsAldaDVcBV5?=
 =?us-ascii?Q?vHQ1q2AmQV6VHS1k+jqALhkPKSV7lGHje5b9L/4NH3D9ZxOI6ECS+8+tkwOm?=
 =?us-ascii?Q?pFZW8iSo6TR94KKTWWHWZt8J9pC3M4I0t5Jc9YTJwX4+nYPRKnuHT2k2S6jA?=
 =?us-ascii?Q?QjDnP9rksc3CiMTxce5Oc3CzEqdJf2v8lTKKRnAa0oyalWDb3CX3pmMKJL0A?=
 =?us-ascii?Q?PsHBSM/E92+Iap88zF5R9k8pGMVUDvpnNRy1PUllEtHmIrUogERB8ZGRakTl?=
 =?us-ascii?Q?oUC7rWTHaxsoY64lwi12f16DYROOsFI0fm3Oh94ETcFbCbghO205KIMYesJ8?=
 =?us-ascii?Q?zaFp7XlkhvE4WSQu8Kl5mKV7GsrQe6c/u3u1VEdQuUWE+LhTioFM/3FBi/Xy?=
 =?us-ascii?Q?SI4edyBSxXhTdK/pkM5cnoert6Va9J8LNxAcUapwXA/dSLP53JidVSN47zxm?=
 =?us-ascii?Q?2esSsoDWVotqM/cXS756bwcZl72dWLOWhWEGNnHqZcwBk+ikfLvHZ8jG+a1n?=
 =?us-ascii?Q?trtKer1bwUOfRufQvJucyjovpa19tNpH0KYP1b8Yst5mGo1vogH8cbDfGzac?=
 =?us-ascii?Q?feIJUls9ZK3YhtYvr45WGudNH68305PoqaTmKuoeJ2kM11BmugV+kclf0Apo?=
 =?us-ascii?Q?foiitbLzSlabO9LxMxWHUtflHG3tNrArFikLrCQOxExkJ+775ZqkA+Q1kwte?=
 =?us-ascii?Q?PAfBaJ5/7eFW7Vj2fOjuIAaFOTwgv1+hyzMk2E2JIGtQ0xjnBhW9R+tn3MVo?=
 =?us-ascii?Q?G7VRCC4Xa5lpkXjN6pvV9ayWttQnXVR4SXs4zjBdzDk12QDgSKCSf+ZMP0e+?=
 =?us-ascii?Q?n3z51UGN8hPYhZ3j6yMsLHtqrBNd/7GIBoyJL3EmW18jweu6NfHkzDqLL2TE?=
 =?us-ascii?Q?HrOBjvecFHznmZi/TxZZ66IQp2T08/Iw85NazN9Zzf5pL26lJ6sTcIqwXN4y?=
 =?us-ascii?Q?uNjbeFvSNuCSbHXVDZ1fTf90V/QwPzRozQ0AMu2tbMMY2PUFrLkNZ63c6Rfv?=
 =?us-ascii?Q?Ev/zG0OBZKAkMIwMiMVyWuX/mgcW3mPumYugI7vzbPmf82vE6Ss9x9dFq860?=
 =?us-ascii?Q?GZSMrIVTA3ir+J0VlofYNX1/v7TX5e5mZXDHargxOBJSkpVjwYAx+8k4sTLg?=
 =?us-ascii?Q?q59CJzLqlllCw67nywp682f36xP2+U2K5NXUB5aKfQWoELPRIfhWikv8bqPC?=
 =?us-ascii?Q?YeXBxt+CI5dFuF/wClxwFj3Vv6KYRUt3IaA6VS2RIpXtiqOgzjgEfab3k627?=
 =?us-ascii?Q?JgvATdQIPIGV+qQ+X2mvAPlWMlGFlNu/KNua68uz4xYz8jcVNvAYfvRy7IXT?=
 =?us-ascii?Q?TghEEwVaJrntdqrRa6nLBQ7//FYvE3lg7UHyfM6yT6bjn6UpT5YIHVK/q+eh?=
 =?us-ascii?Q?DXshQGkJh7jwndMy1O2ElbBY3ko4BrFTgeSL8iy1xBwMURVXLnQ/Fkf3UmZy?=
 =?us-ascii?Q?vtPQC2ntICLFt3xWMo0Mkk3NYSojQaAwT6mn0tzjTAsYG3Ix9oTONmufdV+r?=
 =?us-ascii?Q?ajXeEx2pksAxAmjn31qPmGJpQYl+UTiPRR/60gUTE+ofPmn1S6Vn9rrPvGNZ?=
 =?us-ascii?Q?kgdeK1D7IPBmXMfFsNct4IunqTckaolSzpRqFtxQG1TB144YRG/s260tVli+?=
 =?us-ascii?Q?bgqbWtS6/MTx27MRS6B0RwDjtCFUeFAyEINUWO18c//Blou7a/RSz7SKaQmz?=
 =?us-ascii?Q?0DO4yoikfKQWvxNaxRn5KplilqaxjaYwbpY83zOCXEaF77EfjFwlzVk8rlhs?=
 =?us-ascii?Q?uDN3HK8x9pZRjBimDuAkPoZ3BI9mUOKheTC/OGmWV2HM6ezEi8Qj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b745c1-edda-4f93-aa46-08df126a333e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:12:24.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3hm8berPchmPnBii9dKIzQHq7X8hdrFib+E/W8akiaG+LfdpsQiFp4Tfco9SwaEPP2oGXLRSjpy2LRjRU9tQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_071233_190799_B85B516D 
X-CRM114-Status: GOOD (  26.91  )
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

On Mon, Sep 14, 2026 at 01:51:44PM +0200, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Thu, Sep 03, 2026 at 04:56:18PM +0900, Koichiro Den wrote:
> > > 
> > > Please share your branch. I should have time to do a quick test.
> 
> I did test your patches using pci-epf-test.
> 
> EP side:
> 
> [  105.770736] using HW-defined MSI-X layout!
> [  105.770763] MSI-X table BAR: 4 offset: 0x4000 size: 0x1000
> [  105.770777] MSI-X PBA BAR: 4 offset: 0x5000 size: 0x1000
> [  113.634512] raising MSI-X doorbell for irq: 1 msg_data: 0
> [  114.650505] raising MSI-X doorbell for irq: 2 msg_data: 1
> [  114.658509] raising MSI-X doorbell for irq: 3 msg_data: 2
> [  114.666499] raising MSI-X doorbell for irq: 4 msg_data: 3
> [  114.674508] raising MSI-X doorbell for irq: 5 msg_data: 4
> [  114.682498] raising MSI-X doorbell for irq: 6 msg_data: 5
> [  114.690508] raising MSI-X doorbell for irq: 7 msg_data: 6
> [  114.698500] raising MSI-X doorbell for irq: 8 msg_data: 7
> [  114.706508] raising MSI-X doorbell for irq: 9 msg_data: 8
> [  114.714500] raising MSI-X doorbell for irq: 10 msg_data: 9
> [  114.722508] raising MSI-X doorbell for irq: 11 msg_data: 10
> [  114.730500] raising MSI-X doorbell for irq: 12 msg_data: 11
> [  114.738511] raising MSI-X doorbell for irq: 13 msg_data: 12
> [  114.746498] raising MSI-X doorbell for irq: 14 msg_data: 13
> [  114.754509] raising MSI-X doorbell for irq: 15 msg_data: 14
> [  114.762499] raising MSI-X doorbell for irq: 16 msg_data: 15
> [  114.770509] raising MSI-X doorbell for irq: 17 msg_data: 16
> [  114.778500] raising MSI-X doorbell for irq: 18 msg_data: 17
> [  114.786508] raising MSI-X doorbell for irq: 19 msg_data: 18
> [  114.794501] raising MSI-X doorbell for irq: 20 msg_data: 19
> [  114.802507] raising MSI-X doorbell for irq: 21 msg_data: 20
> [  114.810500] raising MSI-X doorbell for irq: 22 msg_data: 21
> [  114.818509] raising MSI-X doorbell for irq: 23 msg_data: 22
> [  114.826502] raising MSI-X doorbell for irq: 24 msg_data: 23
> [  114.834509] raising MSI-X doorbell for irq: 25 msg_data: 24
> [  114.842502] raising MSI-X doorbell for irq: 26 msg_data: 25
> [  114.850509] raising MSI-X doorbell for irq: 27 msg_data: 26
> [  114.858499] raising MSI-X doorbell for irq: 28 msg_data: 27
> [  114.866510] raising MSI-X doorbell for irq: 29 msg_data: 28
> [  114.874500] raising MSI-X doorbell for irq: 30 msg_data: 29
> [  114.882510] raising MSI-X doorbell for irq: 31 msg_data: 30
> [  114.890500] raising MSI-X doorbell for irq: 32 msg_data: 31
> 
> 
> Host side:
> 
> #  RUN           pci_ep_basic.MSIX_TEST ...
> MSI-X1 returned -110
> # pci_endpoint_test.c:168:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:168:MSIX_TEST:Test failed for MSI-X1
> MSI-X2 returned 0
> MSI-X3 returned 0
> MSI-X4 returned 0
> MSI-X5 returned 0
> MSI-X6 returned 0
> MSI-X7 returned 0
> MSI-X8 returned 0
> MSI-X9 returned 0
> MSI-X10 returned 0
> MSI-X11 returned 0
> MSI-X12 returned 0
> MSI-X13 returned 0
> MSI-X14 returned 0
> MSI-X15 returned 0
> MSI-X16 returned 0
> MSI-X17 returned 0
> MSI-X18 returned 0
> MSI-X19 returned 0
> MSI-X20 returned 0
> MSI-X21 returned 0
> MSI-X22 returned 0
> MSI-X23 returned 0
> MSI-X24 returned 0
> MSI-X25 returned 0
> MSI-X26 returned 0
> MSI-X27 returned 0
> MSI-X28 returned 0
> MSI-X29 returned 0
> MSI-X30 returned 0
> MSI-X31 returned 0
> MSI-X32 returned 0
> MSI-X33 returned -22
> #      SKIP      MSI-X33 is disabled
> #            OK  pci_ep_basic.MSIX_TEST
> ok 16 pci_ep_basic.MSIX_TEST # SKIP MSI-X33 is disabled
> 
> 
> There seems to be a bug that "pci_ep_basic.MSIX_TEST"
> returns status ok, even though MSI-X1 returned -110 (ETIMEDOUT).
> 
> If you don't look closely enough, it is easy to miss the
> "MSI-X1 returned -110"
> and only see:
> ok 16 pci_ep_basic.MSIX_TEST
> 
> 
> Perhaps this is what I missed when I was doing the same conversion as you some
> time ago.
> 
> Anyway, I do see the same problem as you. For some reason IRQ 1 is not working,
> but all other IRQs are working.

Thank you so much for testing, Niklas!

It's unfortunate that your RK3588 setup shows the same issue too, but it's very
useful to know that it reproduces in two independent setups.

> 
> Unfortunately I don't have any ideas.
> MSIX_DOORBELL_VECTOR is 10:0 so msg_data can have value 0-2047.
> Thus, it looks correct that dw_pcie_ep_raise_msix_irq_doorbell()
> sets msg_data =  (interrupt_num - 1);

Agreed.

> 
> FWIW, I think you should send out patch 1/7 as a standalone patch, so that
> it can be picked up ASAP.

Sure, I'll send it as a standalone patch.

Thanks again for your help!

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas

