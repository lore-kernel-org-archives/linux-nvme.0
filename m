Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938FAC5CFCF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WqnVXxIcx1wr9o8i0PPirlXlFSnBYWYTtDNKy9g6Z2I=; b=BHReruTNWMy8IOzGVJAspqDHRF
	8+A1OWx1PyUYe9LcSN76TGaSGd54qAO1oYOEXOhlV1be3paQc+jNcwe/fp59YiEwWyFjk2l3754Tj
	u1ob/Bt6XWxrc0a/lVLPrx2zLvQaN1apO7plgsOTNPMD8Qct5ukKrzbJjLnuGYOkeqd8YvWjU7rRM
	YPMLsnWrO7tn2PDcIezsl+F/emvbdHT+B3mREgzzM0SYnaRmNxQPx0b6cjZW3Lu8xuh9ATURjpMXM
	MiBODsPknSbgqCylS3HEq4xCHsVK38po+tkCHSQGDooXLaeaK3ASR7dMs1gik4QtU10V4lFz7F2Br
	9jjIsAJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkYF-0000000DvNO-0O86;
	Tue, 11 Aug 2026 11:21:47 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkYC-0000000DvMx-1Yke
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 11:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786447304; x=1817983304;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p2RINcaI7oK8a/hqlhK+trGchYgZqdpAdigFozUgKgU=;
  b=bb39EMb/JdNGk/3Y49QLMfF40cji38GFJx8E8444RgwCpB3DcH93PIos
   ApBb1I3IXefDyk0lJ8Tebc/hh7BsxyOnoASUuWb3PZn4oN1TZq2JPhlZ+
   DBqh0zleumQa5wTsnx9pGbIFkS3Mn4MmkTK5qr6qX/ZMp80rr0myXMzL0
   oG1Dxi5bcPyLj1Pu5bOAi8bp8pHYk4j6AkuDKdkn/SsEjY6W9+tp3dfdc
   Of8F2+BKMxqDbsyg6LF3DvNxYm+ATr3MqDYU0cECHk4gcGWi1C8Vo2nRA
   9o4R/jcZHjtjedVtY/S8oIFmagc77720kJH/5sp8/OofipAZvRWKk03g5
   w==;
X-CSE-ConnectionGUID: MTzf9OupT+y8LYKHXB6z/g==
X-CSE-MsgGUID: jfmojIZrS2OehzCfdsfNIA==
X-IronPort-AV: E=Sophos;i="6.25,217,1779120000"; 
   d="scan'208";a="151964619"
Received: from mail-eastus2azon11011006.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2026 19:21:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKeoZBUWaDnmCUnGAemUUNcbP+2UQvzSm8LbjiYCEDawTI/z6wjv2y063s1aKrKYcK17+kdPsk0ui5mIgVyzdgvxPWbH22hKQNI1Z7OGfns9I1iYu+oZlTURZMY/fhUfeCdAU7JTmyOYvT6Kwu6HyqnztFPE2pZ8XtYzhGVU+B/oxX2cpTdb0WwQqT97d/hBKAcuVeSw2jTFHxE2rSib8Myw9Ki8ZJc5P9b/hWsaCIvw2HraQcvpVTdDUhgdN9g/Gf35ERBnclX5qpiHDJ0dviDL6qEZsh368l3M71MWLvYacx9BamIthwoL+5rH3KQynI8KNowlLUAbGBrKoTQLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqnVXxIcx1wr9o8i0PPirlXlFSnBYWYTtDNKy9g6Z2I=;
 b=R8JCQ2RnObBp6sTjWBBAUxBoaHzSSedkYL8B57d4Fzkab/dhkDPkR0TfUJa9rSi48ATjrfExl+GQ1EbJm58FbbQHaut2OSJlOqO3jRxluVREUMzLQIziNsrmWtLCenaRXLBQJqmPLEBxQ7XeNrD9lb6AeLsZQFz+Lfm3SL9W0appQaa/GIvV46RXPYjXITR4amP2Q0X0U7+SH4fqIMmI22mvVGVMk8KUpvQ6J+RSGaEOcaYh6Mjh4lBEtneJHAoK6SmNvqCZP6JhycByrtFdFbq7vOmRgiZxO1TvKiadifQLdtesUWkt4YTntzUKUUSK0Ss1ebrk2mMnbZzpvf3f9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqnVXxIcx1wr9o8i0PPirlXlFSnBYWYTtDNKy9g6Z2I=;
 b=PBkCbEoUiCQMLjw8OobHeuDsbJVUgqobLiiGpMb4sYXRohThDTwbosCmf+VIB/HGgsQ8LkggG9kN1e4mivcOjJqdM9uTKyLCYOMsYhpacDXduX1jn23t7QaNyLmQwtA7MivYqGan8MCRsJ1F+fkUxjmy/RiwOkxhI7qRYUjP8BM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DM8PR04MB7752.namprd04.prod.outlook.com
 (2603:10b6:8:34::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 11 Aug
 2026 11:21:38 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 11:21:38 +0000
Date: Tue, 11 Aug 2026 20:21:27 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	nilay@linux.ibm.com, Chaitanya Kulkarni <kch@nvidia.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme/070: add a test for Identify CNS 07h NULL
 pointer dereference
Message-ID: <ansFVrVVtnxfhi0Y@shinmob>
References: <20260804024644.3830277-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804024644.3830277-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: TYCP286CA0292.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::17) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DM8PR04MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd13931-2ca2-4fab-2389-08def79ab60a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|19092799006|366016|7416014|11063799006|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fLf54szAcwlQ/9ScfMk1H7q+wQDH/fEWgN7tozrjjKVvgKK0/7Zod6lG6Zc232nqJFwjY2i5Kh+mq3b7haK2ki4W0mjgQa5IpWODdR3gfJYWeyms03IYisoytEblQJdTAa1CcJEeHYdbDIaH0arEfeLMOcCwiUF8meQJvjXA9OxGc18EKCxhOAfH+s/YsU6DwQCs0HUAHYVaAs4UuzabHEBUq24sCldDtUEToPzLErQny3H3XAU35rKihqRcjJnvAzLpCx9x1wQKA8L/xpRTn42dhdVCiYuAQRKVOorDXAv1S75HodguP92wuQMobnWHUu/LlruSSCgBfpzXhRXiwJ9/OrzClWXRFkmJl3jqiLRQRymkVTjeKdYC4bNhaj/gu29VvJvgcC8jLKSJk79Ih63/bImJHN82sqBHWfkoKEw/pekJKmA2g0UFCQB7wa2oP/SAI5BpoDcerJLZqWkv78jXJNztz9I9qDZCIuos3yET33aD/u+RTf5zCJiGtaOt3UxL2Q1OUg7DwMGLID4EcIrh6ZvTQm+WjBs4FN7tSNbYQ7wceYNDxtP7f/C7VfiV/YtW6SdzOJMFIz2yfGRqRGuY8n3YpsqiFGbqdEwsVT+beV7dJA9D6r2rmPtowmhSt1QYhSDfDUorEnUJYIipo9LSibXimwlXihdzRBmOyZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(19092799006)(366016)(7416014)(11063799006)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OUyJep5BvrzE5COk/lV3GxbXAJEQfpbKw1HE6FFxTA75rzSuQzB2xBqyQiun?=
 =?us-ascii?Q?kAaGeVa/wAQERjonhsHPisju/6UXM6LxE6ak2pCJvSMQ7SPbcYZeq0qLeuzB?=
 =?us-ascii?Q?PbpaKJ1PXFgZGoie2KTrA0pE9KW43F88JWOsUYGq3YR3td/vb5b8HWt6p5f2?=
 =?us-ascii?Q?P8htF8XBLAurIP+w5HcrGQWN/Bxop3QbeJshBZxMCoXG0nNdvb6QdV7uHJk/?=
 =?us-ascii?Q?s6+SxVVA73Uny63tDxgCloDK2dcQ2FHY37+mfiktd2LRVpy92acXrSK8YUG4?=
 =?us-ascii?Q?sDIkqbInGHSHzotuRQ/yEgwh1E8KBZpA/hfvQJUSYgdVJMTzo8P6yUbSqtfc?=
 =?us-ascii?Q?WTwV+NVDBnDe27l6SKu7mZy/9jvO9s2ZIzTgxmODvWHWWTBvl3wGu4JuSreA?=
 =?us-ascii?Q?CMpeOLB/ZXG2Ha1W+GW1u/VA/CnYaIMTrAxikZsrk3ZK8bXJ9HrAtb4jMx7l?=
 =?us-ascii?Q?gp3oSTrm4wtCpYJrVsWrwZsQZheU64fPkqVPLa+j4oWMp27UyTlRI5OMUSVy?=
 =?us-ascii?Q?pY4XNcPay+9P+k0EIe+KBpFFgGQcLc+QG1AEuRasKehl1byvDpVq6oRstZId?=
 =?us-ascii?Q?YuSpiKRV/j+IblcwvzGjoDIbhky4xibMVKWxvJvCGBzYgdGuUegDiuwzdTUn?=
 =?us-ascii?Q?NxwhP8ZDhbqqB945YTPx5IKuuk/udfwruf/9tgL3VR7vtmSxj92OsFtmE3em?=
 =?us-ascii?Q?9sLXJkOkb4xNYO4pF53Wf9/Zy+aLQF/Dia1ZRw800ZZuvLLuzMn3m9fcJ5te?=
 =?us-ascii?Q?ISwlQ88B/e/6jjo51Wi6rVZs1timvSxB123gRsJPi9t85y1NJd3mn85Md2zG?=
 =?us-ascii?Q?ijunbUk//+wLv86OQacr7OiE+s8AlB4Ht3KFOh3dSZiWyRhDI6ipd+O6HkEs?=
 =?us-ascii?Q?O2piLsmo5nLjYZ8WAUdCkn/cnfQNSFcuCHDTsPaPMPlN/GG6P9MtB1SSNu6H?=
 =?us-ascii?Q?ivUBpNzIufMvt9t6nJPEumq5Oi5mBFVU54SGSEqb6+D4l6EhpGu8Pb0NSbMF?=
 =?us-ascii?Q?z/npQYkdzpqXS8n1tL2GoEyxgj4QoTltUTHfETmTf5DjGx+mLWArwdAjm5ej?=
 =?us-ascii?Q?Y0MVAVHOhg8ppTwZCBiq8YKAM5askF2C+iGzJnsk6XpyzkWzBvtZQp4VAZBs?=
 =?us-ascii?Q?eK9cqAfO2KhC4k7DG5EcrwjkLZKy+cso8CdWGArmKSkQ5y5/voPh25/hWAcC?=
 =?us-ascii?Q?s18nS07DYsKkZY/j/9XawFOkGS2AkGcOpvqITsO0863iASkdAG9DmQBTP+yk?=
 =?us-ascii?Q?nQ7pNUwDA6pJM2qLFDCcKH7f+/OjP+CWIr4zGSlHKYJUo1IjR5XG7k/9Khra?=
 =?us-ascii?Q?m1yfpelBW5YwZuu3/Te7KbXqUSPaYSXbmP0odrxfW/RvTtf70Bw9Hgy93GvV?=
 =?us-ascii?Q?NKt9xe+JyhV1Bmlh5+rXdMWcvc/CX9kT1YxEjdMjdDVwpa+Py+9pvD5JDRBS?=
 =?us-ascii?Q?5GcaTCnIsWUGykyFD2LPdwkH2fSESA9EV7j3DzlFqXZaEme2wlVvFoXVS0xc?=
 =?us-ascii?Q?94eXyMhkXtl2CuOqvSOjplG1hjOLflP0MN2aXWwQVrJXkrsWSTH9A/euBjdR?=
 =?us-ascii?Q?VpbjMMKea1DB6avuMfW+wBEXL+X3KDOkMNCfv6/1b6DI79eghnw2RLN0Thl7?=
 =?us-ascii?Q?L0fn4OSfhcxB7wlJdKqWlicrjAZXPF9jj3OXnVcqWvFNuRgLbKVIf5TykS2K?=
 =?us-ascii?Q?V5V+1u4sKpUYEsZehUDjUZN1LfyaVMjaUAf/VV7t8dKfLrKmgb+nPwdPPc45?=
 =?us-ascii?Q?RoOQjnO3T+gUR/yEDZGUw6C4BX6p5I4=3D?=
X-Exchange-RoutingPolicyChecked: kz4mY7LnmlOTr5pxyQQk1257oob0q7PN3Py3r3O6GPj/rDYkDybNGM5y3XHp4xXDjUnp66ZUHDGNuB9EWD8xrylURmGRrSFDKZ16w9fmvobfhdqWGf1eBj1j+s2S4nQ0WBeQ6/DjUOc8q7LXUfuZvp53vhCzxGeuPAUkZ56qL5vQyEjUV3T0GcnctD3bshuomgbnjTT9niO4J80379WJ2zrl09j2xk2FIQUVkOhjD/M8NQ+EmwFr3guvGswEoT0GqS/jO8OCcYSHap2dFwt+FidtyEvvz24EpzLagpUWVhHgLRiHNw0zTp5ZKdULa/jONtig9miv715aCumcKzbYSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bnDQEtk42XmTtvnWyvZRTDpkUk/FoojrTWRRCg/s93CnZ/vnnQTBGVj39IrpTzo8Rcr8ZXaTyFmVjIuAyGVI35w6/6sLXYcALhE7XM61lfWDNsSdt6k9cvXVk55K9shtyG6QzEdjD04+h+F9o1X7IUhaSKYMrf+IipOeGFPWSnH7udsqk+FchvhVUU9eA+HB54ygv5Uwd5caUUn5wiUI04mX6KLmDagQX+LDpyHAPNJ3ABeQ+i9Tgmkcgf8gbdprMMzMbLKxAhIV2DSztG5hkMdG6oTUJGXtEyxvx0DjgMUxzpMhJL40uqEx9jOdD1Da61DlrCIdtTvMnsni0K26tymYC7x3CIHLv2QbazltLvuXqUJRl03h57KKbKoll1hCFMS+pYbJsXXiZ2HLwepTetJjMlDpfx0wNRYl2S0jtErwdJ1CJxsL3GV9wDYyf4EWofYTLho34jtPnqJQ5ynHh1EWMobM8/ebPzK/Xx0DvFwgRX9F+03AU55UVQcVQNe8lW/VMY+TCQ1ESyOQmMd6Ljnv4JfNFSX1PhIEJw3o1//FzM+EvHkU1RGnKIvlNeY9F4SEMp6jlb5vNVupi4dRYPbW6WBDBXERmLsEk53jerJ9QdSnywuUivv0JQHNVsTw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd13931-2ca2-4fab-2389-08def79ab60a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:21:38.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApO5icspgMps31IHYQEo0IB/lOiOiAtMWs9AgqyrIc9Z+HId12+9r2G9dp6rpVyYUAfbD/0dCPdf1PTUcrhLt48+myY3Etg8XGL7wiB4K7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7752
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_042144_436562_8C8F6DF9 
X-CRM114-Status: GOOD (  19.48  )
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

On Aug 04, 2026 / 10:46, Guixin Liu wrote:
> nvmet_execute_identify_nslist() handles both the Active Namespace ID list
> (CNS 02h) and the per-command-set variant (CNS 07h). For CNS 07h it
> filtered the list on req->ns->csi, but this handler never resolves
> req->ns, so it is always NULL. As soon as an enabled namespace with an
> NSID above the requested value exists, the target dereferenced a NULL
> pointer and oopsed.
> 
> This test connects a target with a single namespace and issues an
> Identify with CNS 07h starting from NSID 0, which is exactly the
> condition that triggered the crash. Without the kernel fix [0] the target
> oopses; with it the command completes normally.
> 
> [0] https://lore.kernel.org/linux-nvme/20260730043105.3071328-2-kanie@linux.alibaba.com/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> v1 -> v2:
>   - Use "nvme list-ns --csi=0" instead of a raw admin-passthru to issue
>     Identify CNS 07h, as suggested by Nilay and Shinichiro; it drives the
>     same target code path via the existing nvme-cli subcommand.

Thanks for this v2 patch. It looks good to me. I will wait for the kernel side
fix get settled on Linus master branch before I apply this patch.

