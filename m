Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07813C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ImgEwA6trsuMCyXo3LlHGtuDJhn4q/I59exjPNbt9uI=; b=X/eIn3CHCUZ+8Flt1w6RSVSa4U
	3kXNbBC9tdHo0q0unGF8fi51Y4Ux6uB8q9F9RRLwHbJztlm/TsNOP+oQaaKVqhfLtYTVFI7uPTGdw
	bziE6qIpd0UNUfS8t68bOUEWzJKF7W8mJZhom77UHhi/neyVjNj9k2voxUOgbGZ/StRPyBTpd0xxw
	bjW7jy4tnKNSSqdF3ygtxS03BoDNZlA8/2wfcx80PzxrrMnL/jazPzPDMXSw7x4fv/ilt/cr3jdv7
	lKXGzf7y8fEc8Qhy6j7/n/5SIi0BvEvOo0GEuirBy6FyGNb8eHJA7XznrxtS1r0vi0f2grsgZL+Bm
	eAm2degA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSpJ-0000000Ajmk-1BJf;
	Tue, 14 Jul 2026 02:24:53 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSpF-0000000Ajm5-20ns
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 02:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783995889; x=1815531889;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4R3OZY4K51dx27WBuAaH66UzoTNI9W2SeVFSTULO2r8=;
  b=IHSvCafVY5I4MBLzHJIT8oVhC2IuYmkpbfHJbXWzJHFSs3tJyKK34OjP
   S1T8pWurvEHlQ5QQBBqncslwYiOt8JcCGdpnaEmrJze6YLfRHHJaVtj8t
   zG/1JMcLkahSHBFm2MZcvPmzqMyCMvtUXPJsBhRFoq433NvM40aQ5Z5Ur
   v2sI/WmL0U/9AuIm/FhINa9hYMyI6Gjy45kos+p4aQunTIcczkDA67ICZ
   AKysc7+pxmh6ab5TSBVpB8+HKRLmhac4jZm+6NkU+UKaa3Qg+xwUO9kS2
   de+LDOILdctY6+6YMi1ek7mB0EHJ/5iqZoVMAatRIq+AYkrZAyTOWWJUO
   Q==;
X-CSE-ConnectionGUID: yj3vhwuoQYukQQeXi3AYMQ==
X-CSE-MsgGUID: 2Y/WhYFqTdaVya/jJiknZg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150014941"
Received: from mail-eastusazon11011006.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2026 10:24:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rolGB8pDJJ5WeOowGPHgnEJnHUTd1mYbKZYYVpz3tItlAcADWww2D0dtMSWoXFrI708b5Om+VCIMIBOaNTAqaydVv3ZjNXSl2OO6Jt29DZ9rsM2zUuaisaREm3V3KUnnpMhhFK42c86GpXs2ZXgP6Dspo2KFE5f+TUs151IlO/R3h9bYztVM4WThyxa/Hah32MMM8+5r3l5g4iXaJJK5AvGsDC3k5lltlvf7ON+txXc5nXvivJqLlm9P+EKk3d1rnDJMJkur0a5tEzJjv6D+mOGUe+PAemFEgVpAdZqvNvVz6wEJxXTaQ6XkKnba15Rvd7LJZedqMlwMXo7ekzm4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImgEwA6trsuMCyXo3LlHGtuDJhn4q/I59exjPNbt9uI=;
 b=A2sOtnhNhXPU5k0q5DFvnsKCSFRacvIEqMMOZrT37Ct39kSuTKQpr5SPZyXlZ6t+RxAxw2FR87UP10GihgSuTGmbvpvucyUgyxWWund0rqdoRmTJ3DNvRmppYMXCZPRDOnJK6nFScpyD4JN0LlMYCZwtqqjyrbCEN8WlOkPkEdzxVBTrDw1UiDuwxz4v4u9d/tjfXu/2As16TGz2QwpGcC3fx2k7QFcAUZ+483kjNiajHiP4euynMTn4Owc0lGxjs3GSKc8kI4VOhPlu6ZpiSajzU0APyksPDOjeoZbAOGk81W8J9/wVk2CSVOQ55a/b4JsxtFKARI6rUueY2Hq9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImgEwA6trsuMCyXo3LlHGtuDJhn4q/I59exjPNbt9uI=;
 b=G6XNcbP2nYnvEtwKDlWOQb7VfqZKbjsSUBnvTRY8KUgPUeB7OHSpjs3unDEYlmWqjkAQeo8Zfj/1PlfHoEGodaR1x6B1n7rVdA7Q+jLEunlY+IVna8BWu773qXJkxVofcSNGT3aIQIFEVjwpiUyF0zQKv3BKcePaI/DBiOp1BzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH8PR04MB8591.namprd04.prod.outlook.com
 (2603:10b6:510:25a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Tue, 14 Jul
 2026 02:24:44 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 02:24:44 +0000
Date: Tue, 14 Jul 2026 11:24:38 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvmet: pci-epf: fix use-after-free in
 nvmet_pci_epf_exec_iod_work()
Message-ID: <alWdxvJVXOuzCMBK@shinmob>
References: <20260713043250.75514-1-shinichiro.kawasaki@wdc.com>
 <43f0a5fd-e300-4d9f-b0cc-f0aab42fbb08@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f0a5fd-e300-4d9f-b0cc-f0aab42fbb08@kernel.org>
X-ClientProxiedBy: TY4PR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:405:379::10) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH8PR04MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e8585e-47bb-49fa-9ba1-08dee14f1131
X-LD-Processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|3023799007|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l3noUN0U5Xgpv/8N44OHD/Gwk8aHhsAElTJ4DwVAzhB+2XoBYDIqo8fMUmlzEduoXEIfTLhfT3RlntCpyFQ28Lg4FeT2DD0MB/refyBc5y57rsoM7v3KK2Ruve0IyE82OjRhp1HkUCg0NhH7GYytqiRSCKxDPjuv05g/QuyMflDHiPck8AdmuP2sGQwd4yrFAx7ZrSISsqnBAV+cpYnXiwmgej5rCPJ2SFkkPJyUQ8Ail+jqET4gZlUyNyaoIx/iQwdlEPvGLhwpUM4loQK2vwx2PAApX+3kTS4XVu+X4MX5GinXt29uWoMTCf0oIu7q3rGtDIoCzoJTsYf5JDYFPdvAyqvIxSAEVBZuA8GVtutNfJ126CILHjy+p869fB91vumx268+Q697LXstz4D87Cv3+JhfI++GnT5H+NELI1/oTfwuFU6RqQwfM6IW8QzCPpB3GEA/vctDUk69+jq8mUkVnNj8pW7OoXc+YMQs6sI/A/BGQne2lP1kwwzwiZrhLSG1luSd+mxhDJ+XXok9KKEK1+pCfxgWWPxav/dLEWVxi7XgYMxn1n9HhYpxF4/l+ZjLY6fuJixEfeDGlWeJXerZ9g6MsFxziXUJjcD1Ph/GW/ZuTaHJalIHj0CF/y7359rfsuLLhX5TXmI2e+6ZtKvMK5Yv33IPZAkfVB/jEsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(3023799007)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rL3G7BzCsKhNPyyT0eiDgF4BLCq3D7Qx84tx2tXNactDxOLQJUUlFHO+2hQx?=
 =?us-ascii?Q?Fxu2N2kaLXr9UP4R3yw7peQEHGZ4GmYYx+f6rKmge7pA9q6VOio9QofLFp+e?=
 =?us-ascii?Q?TzV9ja7DCCq3HZuUGZx6MmjbfEA5YsjZBBqxEpIVfQpPKjkiezJ99Fpo0Mpw?=
 =?us-ascii?Q?QQR96s/jN4Z0LDNoWtSqeebJabGPW/sNxbml68gpv3pI0/o030tFdIf3NiIm?=
 =?us-ascii?Q?6PpCfTf6n3WG0if4GAnqD155AlshavWbg1VIE7shbe4aeNgbGrx/2To31BMy?=
 =?us-ascii?Q?1lcsQ0c+VgC4OUYSnyCEuOQ0Q+a52SX3ZhiW1+Jmet6b6H3oxRUzFBBg58bj?=
 =?us-ascii?Q?rr1r2TS0uzO7p/hNAKD7tgjVQbYRplm8s4+iAuWGCkhD0kzaWO2IwVidgNip?=
 =?us-ascii?Q?MKK+BxQpMsGJtr5TnxaHOza2Bqys287S2hHuHBbjZYq5wbR+V2sN9q0uv8tZ?=
 =?us-ascii?Q?hGvPnS7iV1oSxITsyWwJilU7QbpYuBDn5Xg92cOpMfuvtrQz9wp/g3iOj12O?=
 =?us-ascii?Q?PmqC5W4yMt03bc5jEFDqOS5H0kmyKVJZ/9og+am3plnaj+bS65+E3+K00CQ6?=
 =?us-ascii?Q?WnrZ+HgeMOOPBO7Tla7HLwKxsThjlX7G8MiUi9cI7GGt9YF630PTM0w2AOqM?=
 =?us-ascii?Q?qMCkGgkmWybcTo+/KxKzwZ3SY0uxrhL6CmhXG+b/NZi2Kt9+Grd2SROpLKJK?=
 =?us-ascii?Q?q3p3eLVy+uIce9IvoqsO/f4MUHmjeiOi4+tslEceqPFnkxTpg4SNyn3BDlyp?=
 =?us-ascii?Q?WsYASA6agRWi7iitJvN8V7g3H84aRxe+j4eToSur2Di6d79/dsi3fdhraRKS?=
 =?us-ascii?Q?NP7vJwu3ivIfzMhq9iKFIN+u+cxaWJUo1Z2IR0N7KerOPGsaQHheZ2LW3BG1?=
 =?us-ascii?Q?4A6KqsLiozD4+IoX0agi72Sm1CEe3B1LPLOM/lU3FD3NDue3r9miKkVp1Mo/?=
 =?us-ascii?Q?GB+vlwkf2RDNTtPxeJFLB6iLbpA7YpdKpRkWVjf33BmuaXAk+MkGdUGUv7tK?=
 =?us-ascii?Q?ltmRRUg/7OeOcvyvCwCEl/bPSqwvup5EF79PLFX+q8hExpiC5FdQl8bevBuT?=
 =?us-ascii?Q?7WWb8TYzZyStQ3j9Y79E9wKPEBhUf/7+PpsPaTHTGOisO9mj+gxfoTf6OuyG?=
 =?us-ascii?Q?1OuFEjE1QjzhLlptv3K4k6wm1oWwDUxuYl6w1+kFWyE8DfugQCm4cs0SSX/a?=
 =?us-ascii?Q?K9ff8lKR2MPAnsxdxDHytTKHHEODQECcjg968ghyjuFsLSwSEmvpuFAUnN+u?=
 =?us-ascii?Q?rxQ6BaZp3RWt+F0evqyZTY+kLN8DEJrcvFSXOyzliS4I/u7VoUk5fPTMgPq8?=
 =?us-ascii?Q?Ppq1q5eDiALKq1ksn0udS2410uVlYVtuP+9NPh7jozXc8oMchnciyy1BJgMG?=
 =?us-ascii?Q?A151wa1kiLY2X3HYxGCi0N527WFk+FRDym/fP7zNGjNJNQIznCoTaFYnQ03L?=
 =?us-ascii?Q?5dYQW2aMoUPau6y0kwMupVwYtSbAUeRFOfpmgomaGa/2CK3yEKSAfs8lYJeW?=
 =?us-ascii?Q?NrF44CDe8o/WrIZayDN+62/Lf6sd2KO0EHeB7o7FplBS58xshDUWHhgaLoRt?=
 =?us-ascii?Q?b2v0rNoHoAN46rqIoHT1g/NX2Um1TnrU3n2j1H63PmiXCEdggipwuMidcv/W?=
 =?us-ascii?Q?0403auAALFPCLro/qAPx7I92FJ6/rb0hYUKaAfFlFyUxYOmpZNeatGYPnMCA?=
 =?us-ascii?Q?ilOGHRoK0VwJVNnHGr5L/MzfDBM9cpQa8pCnc1QhDVRM+B+iNPwQBSRT1mmV?=
 =?us-ascii?Q?9HCYsQwPQ2P5/y49qyT6sM8VZ9lLgwk=3D?=
X-Exchange-RoutingPolicyChecked: apca/v8K4pdS0xWQeivv7j1Eroxc7jmxi+E5+/mQypQ2HLnkUfTbSDe5vc+PSfWxWBTcDfzVhjoB2TyvjiqKs924aVFsVQwkjME511xrrVaNSxHjFmgtnJ3kvKprLC7MKQWOkkHsXhAGxrdt0HfC0xoVBeOedQFXuxmTSkLyCwkyvFlb2eE+9gl5ppXen+fsDg8MGfkxRs+BLBrE71wS1u7BdBjIIhvM6mUbkQWW4y3ROJdXUoPq77EBAJnLJea5OOjG2ikfKLqlwwx87AqbAIcBUVCtC7B3Q7KYprHbphCCR1he2pUtjaueLdrCd3Zpn9tjsZ9Q/XpZkAacX7Jbjg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: klH7PGbE3JyOYqQRUjMKJN0FfN1QrSEFFpBRtk+IiXApHyCI17InkrlU1GsyOrqO+hO3+6URRP6nTP3TIPortXKrfMl2kRykvRMFZFfUXUTs+L22juV9GVbkL/tZOMeLjhwEwuYvJ6bCTEohtDB4UNZ09IjyPjCDStr6GeSdMHpwmXYrZiAA6xcud9ixSfmO0pk6B/UyJb2IKHgQhw0bF4IdTSRP3KvsbQbxPz2c/d5+Hhx/J3qK0koBWLYjn4HXjsmSm1jPVkJiw6njVevOQmdAYzW17M/RYjMq1YeAWFdj+PI8JQoRy7NT31DmMhNoDIAEU8g62H4vN/W56315xI2kpiNp+UDochzJqVL2G6wqdGEiE1DhFNXE2I3Dq3+KItWPy5K1h/RhaUaJvwPu0vkISEYrS31LNUpqPR0/dEY8FD+m/OUhQ6epYOXwK/BfR8kDS2lc3VfalJfdk8CUb1VekVolL5szBL7Wnv4KSofBfKvke2z+TKJVIQ1NYMrvV+qcASzF6iJ/cazArUnLi4S7LjKybei4a8kt1H24f+1k5+y6ry6K74igKiImWOLTuF9Ir8UlpE7BjKAYD00d+F8cgvid//VT4z1sFRAogw/vYI5/m4tfPaz7NrM6FgCp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e8585e-47bb-49fa-9ba1-08dee14f1131
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:24:44.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcpREIFOFUV+FLnhAtJUQvTFI/pJhcTrbOLzhIGYC2GNMUgzA4Gtko5eQ8dkmFKyByahluyOelHKae+DnpRiyjUS/jBIRWxl2iFFU8MMzJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_192449_546311_4CC91353 
X-CRM114-Status: GOOD (  17.49  )
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

On Jul 13, 2026 / 16:28, Damien Le Moal wrote:
> On 7/13/26 13:32, Shin'ichiro Kawasaki wrote:
> > nvmet_pci_epf_exec_iod_work() submits an I/O command with req->execute()
> > and then waits for the command to complete and transfers the data back
> > to the host. This wait is not needed for commands that do not transfer
> > data from the device to the host. To decide whether that wait is needed,
> > it reads iod->data_len and iod->dma_dir after calling req->execute().
> > 
> > However, once req->execute() is called, the command may complete
> > asynchronously on another CPU. For commands that do not require a
> > device-to-host data transfer, nvmet_pci_epf_queue_response() calls
> > nvmet_pci_epf_complete_iod() directly, which can free the iod before it
> > reads iod->data_len and iod->dma_dir, resulting in the KFENCE use-after-
> > free:
> > 
> >  BUG: KFENCE: use-after-free read in nvmet_pci_epf_exec_iod_work+0x288/0x798 [nvmet_pci_epf]
> 
> Looks good, but I would do it like this to simplify:

(snip)

Thanks. Will reflect the suggested change in v2.

