Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B33C982C1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQmbrfLPDHkCVTc/4r7ZBJo0imQwgtinc8W+oZ2dXqg=; b=Jvb5UF6ex9zqH7PZWQA7KTXzrM
	x4kLuApCLIghNtoEd+BgBvMtvDnDuMfkk39QV7CuDN+J2t9uP8I25FJL0DvTcVHoEPCMv+y/SNrlB
	duMl5Ag5O8K1T8vFiX7z2JolgzJVY/J3dpZgZC9eqJhuO+xJA8AeOwp7S2RL+5fmjdI+AqP+BVAN+
	XmSAhTre1rVILI5fCt27o5c6/dh+K6maxl7/zrm5MiaYAaEfmHpeQewv8vsKRRyKAWk52X1igj0IG
	qBCuezUZnetJzCVeIoVFgVmDy7OtK0izIgQlvFTcx2gzBGd6PRjCHziaVcwfAvW5IRe7kpb8CW2If
	e97N8uJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7742-0000000Apyc-2pkm;
	Thu, 17 Sep 2026 08:01:50 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x773z-0000000ApxJ-0dHV
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 08:01:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789632107; x=1821168107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JQmbrfLPDHkCVTc/4r7ZBJo0imQwgtinc8W+oZ2dXqg=;
  b=iuW8/lXh8GoUlZvqD2+TJOto3tJtsTQ0YFa1FDSQwYMhoy5Sfy7++MIu
   lRlijuev8s9a4ovtyz988o89aJdKaIBJtqSK55393U7MSu7BkQ905g3SX
   1yvd8UeJ3WdEa1bEI/QvJWRFQ6x4Bp/6PWruT8YJWpRjMq2tDPGCuhCF7
   Zpy4deiZCDRgyobspRCifviIGKaeEc8AIKznqA9Hd8KzZZgnb3fRKfUQr
   eUbZCibVbKbXgg5KvpirCZ5CtLYDzg5+qUVetnrRTMZP9kOoomVrzTWpG
   2TxHKKM5SnLC8u3KTqfumMzTwNriwXWBY/GzFz63rWToSgzUuRbOffVqu
   Q==;
X-CSE-ConnectionGUID: ij+9WDvXTpORyx4FywLzOg==
X-CSE-MsgGUID: GQn3eM9oQhiyV6vs1bux3A==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="155890333"
Received: from mail-eastus2azon11010013.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.13])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2026 16:01:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5TaW1QrVYSW/OGB4FGsXfHqzjuAMUI3jRh4Bpqd0FYKoOGPtD8afhchhvRy+Y2bgGkX4Fwwoe++5In4vAilpYv7mgoVyk1ApiIP2/xcYl8AgN2cGpLgWuirggdlcfLc0x5jjBfQ5aWh75bCb3sWPox151FvpJPwJ9EY62pTN24WcKVatbxm4lefM0WsPY3m42g0G/seoCG+mTU3UFO1GotYVnta5r5mz1T98d23bHvTYOl/EK28PexTHdOyooEhcOerdCHAk8IL1O79lr9GWElMd66os/CmzX4zRh/BOD7NVF3EKUq+bXwbgw0ubmK8ltKvpHYDH7Ec4kkg0dFyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQmbrfLPDHkCVTc/4r7ZBJo0imQwgtinc8W+oZ2dXqg=;
 b=TOeAuIx/gMkXEHvB6KyUK0BqDGmiDzPYtpanwM3mk4lvqTj8lgIrO9nCviJRE7Sw8T9G6lArEQqQYXPt2//8uy8pUbLPMZAirANkAPBPdfbOhejKzD8tpHgrDFjWLTBCY/lDWPANxoUV3IkiQbKLxmNvEc8gDtByxL16vSxFqRzC1aXrdtl0W7uSyHKtw5t32AdSgOOr/2ZF4clNO7pys+qHJzkmQo2RQatrBE9uiW+r4/8+1VYMus+Czp/5oXUtqZ6POZIiCA+z7aQzxl/8DAB9r7NvGvoIq0jEuFgwEta2h8CSPinFZ/WH8t3C/NMpsw86739cTBvqs+jvmmxjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQmbrfLPDHkCVTc/4r7ZBJo0imQwgtinc8W+oZ2dXqg=;
 b=np4ke+9JVoAobTkL5mZXLmvVKQM1O4aHXicACRa7idCTI12uBIYoJSJhul5B58eHkNwh4OkgQajiu0hYWdx0EcVgrU9WbBmEuwXg+DeflKwpW78GaV4PcyCP7u2H2fY5FgYMfZ9mQNAZC6ZwwYCd9LFVujWkeVYpWxsbx1ZPieA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by LVUPR04MB9976.namprd04.prod.outlook.com (2603:10b6:408:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:01:44 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:01:44 +0000
Date: Thu, 17 Sep 2026 17:01:19 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	nilay@linux.ibm.com, Chaitanya Kulkarni <kch@nvidia.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme/070: add a test for Identify CNS 07h NULL
 pointer dereference
Message-ID: <aqud9KgqgUHLE-FU@shinmob>
References: <20260804024644.3830277-1-kanie@linux.alibaba.com>
 <ansFVrVVtnxfhi0Y@shinmob>
 <c31cb0a3-cf24-458f-b77c-a97530963914@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31cb0a3-cf24-458f-b77c-a97530963914@linux.alibaba.com>
X-ClientProxiedBy: TYCP301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::8) To CHXPR04MB10060.namprd04.prod.outlook.com
 (2603:10b6:610:2fb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|LVUPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6a8c53-d23a-4d2d-2577-08df1491e9d0
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|7416014|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fdg0mdbk+YynKLz7JOLf+VbvZmqU2k+9NRBrPCN+toS7iyFRY17U8cQdmHi8E7rHF5xV7aHk9z3KSC5EBpR+dnlDbYXkOK5f7zWKpttu2GTMWwfn8PCJnnjrrzd8ymzSVPLvzSYYGA6icuBpQKXTQiPxNAZrLLJomRP0PLK7GpgkdKhNmlinuj6KFiOiHmlI/nSHmPRjoKEYclVzl7lyIu5Ad68pJN0n7T0HWKQS+4ZIVkg3NqBeVdCyqmhd5O/yHsj9PrIQtycJHZHaDEitaJT8xhFe+qRnTqiHn7+EDdXpQG1lc0MqXvwfb2ZUF/vTXSNkeDu10hg7npjYBkFP0/bp1hJ+VcxJZYIN/NGjtrePevY+e8XPZeLcTmlYZbAZGVitdKt6oArVY++M5monNNV9E6pibCnAPYhI+ynQcuypE938rihonM0e/TH14qnVQrHe3aBRUd5y/2ktsSsFSncd4mJtw08hAvLXEROsIzhJCCNo7iUnByj1+ZPDkfbYyaRBkec9ZwHiefjI9bo84wFpjRb+GaW9FncFs78VUXYQPXiuvpNh9seTkTUkZNxMIR7l7kS5d6tfgCfQp6WCo5QXAWsDNhquB7/daDi5BqAl0GdCQCGk5/T/q3agEsnTTIM2oGT3BmX30ID8tTLJf38k2KKnOrlqj+K14l3Hw4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzYiSma3VUvGa6sKpYZL/WtjLl2vNW4cVHQ0Ul0QzWJ/mI+dSk6jZNnOI7bh?=
 =?us-ascii?Q?ReXAxuM8TVARSkuqSc3+aXaA8mZumKdDaqZ9NmyuCLjRUT+mHpZQ2PcUDZTX?=
 =?us-ascii?Q?eH10XPxZgZmfL+M9ODB4kpb15z6Xaczk2D2a/43h5yonnU/SfIrNFhOMzbr5?=
 =?us-ascii?Q?u6U1pCAn/3ph1ObU8bpom/QzBy79DhzHrpSkkEESxa2CZi9jPucEGZhUQXiI?=
 =?us-ascii?Q?eAZ2n5rAMSQYvDlxTNR88peLUqILqAu+gPGJ86Z40XQB0ojTZTlJm8DiVNa7?=
 =?us-ascii?Q?ly5jG7TRNwZrSoOMsyFzg36E+UMAbnNMKj5g1LaVqJSQUG7oqwQqjXfYGIs4?=
 =?us-ascii?Q?hQh5mfPa/8LUvZzgWNFG69yCiilCje+L6emAUSJv3QA704HvqgnM3AncAWZb?=
 =?us-ascii?Q?M6d5luwWbsSG0NwyPIxqOnuI+H5JghSflljDUey25+xlnbvnHWIItAepznx1?=
 =?us-ascii?Q?OUSnLSKMQ15ufKLDU6kqiAe1fKTZZDodZxsWJ30oqrlCUC2lSaglE5kfeJxQ?=
 =?us-ascii?Q?wesY+tMcgAmn12uU/PA4TIg4zOdNuKYUzJ8VnJ+NZ9hExueidSb8Gj2IRrtd?=
 =?us-ascii?Q?LkO+YCnepnG1cDXjvKnKkQs6u0/5TiZ49sd+G9Y4mr9T1U1yG8D9AVEpSikM?=
 =?us-ascii?Q?MuQKUJnfyyz3Z5hNve8ghfjdQgs6XMcYxy4/aTPJZIQvpcsXHuhzjFhhTDbh?=
 =?us-ascii?Q?NoGFvcEV9z9eMQVp61lW1r4XspeA3Mtoj+FfprjrI22QkhM2HbmnNpr3B1HZ?=
 =?us-ascii?Q?IxJIESogSSrIDwZLfDqK3w0Gr+i1a6RwKaJSR5ThEKcv2OE55k1obZyCYJJS?=
 =?us-ascii?Q?KUN6l3Q0tq+ehqCtyaq4ZE9EsMlkZNWIV1y0OV2YAVZt8bDoL0Acfoa9eQCf?=
 =?us-ascii?Q?4dtrDmMdqYJAnlO2r4gjRG6kM6mBeiOkJTNmBqM26tuii724H9nnnQfwTxTt?=
 =?us-ascii?Q?PhM7F29btLe0oGrU4aQUi/68AX7tgZkb/PA5wNJhX4AkxUoU7lffQCFhCDCU?=
 =?us-ascii?Q?uxJq2TpIT3+L+ULd1TkdbGvXfRk0KUSmJCqANlG9nAHfW5zs0tVdt5izT7Ol?=
 =?us-ascii?Q?HhEOfG4TyyN+XlcszYmyPENkAVm0fHOPJbb2Sua5Okhnvz/gblwE5C8usg2y?=
 =?us-ascii?Q?9HPCjyraAlPKPswYw+JBok4n/L847IPUVw2rGcc7eWEvgyJ0heACktGOxfjq?=
 =?us-ascii?Q?sq8x/fMqnAT/mrQ/awbdtyLWwyyxggXAr201TF2aITiDdRXomJzwCY0V9k0B?=
 =?us-ascii?Q?FpYUiuO1FZDqM76mJVlPQKr2f7KoUunWgC1ehWpbFuCqAu9sZKNTBVUnerqv?=
 =?us-ascii?Q?RWTVUDCzPgPlMNM83tKTgUcrZivqwetGjB0QfFjMtS2QWppYlwxHrRcGCPHB?=
 =?us-ascii?Q?i8mcg+CG67fahEC09h/L5rVsSSEVqrmIQLjbkKMuTHSThAdO8KHX9YU4hv/l?=
 =?us-ascii?Q?jODThzkhMZdYDElul3Br+fosDPPWOnwneTJRDiK25EdFs1LJt1dhtTn7Nyk/?=
 =?us-ascii?Q?kG/cZgILhEBF16M6BWxV6DHFSiNZWh5nDPnBcAiUHVS/mCa/7wrcCeofOEHM?=
 =?us-ascii?Q?gibtxa5UZNWt/kO+Saod+bYIADB5ij98i+PtOZhQbcNg6cOoPzLZ4NyXZkQV?=
 =?us-ascii?Q?WVu7MxEQpqBNdZTXYu+iTNiV2oaHtswDte9eI7NY3y0CSTUPIwfQWKHjOXo/?=
 =?us-ascii?Q?xEWyWly0vKGvWy1kbE8+bsiSaOBcLMPleolpE0swaRValAKNI43CcTETSlfg?=
 =?us-ascii?Q?TWybaZPNLh2c1hEnM/qIXYqH6erH2Iw=3D?=
X-Exchange-RoutingPolicyChecked: UppBFbiYwwRhXbqjQL7qP/JSMDupivUO+CxSDqw+rwQgBgFZWIqK2g8o0u/3jsxErgv4/iwFscWI46qP2aHwX9PAtjXonPtA9PPoXEyDIsFwJFE3xPBLsii6GEe3ZT+LRR2dBgCtRvuzv1sFOln5z/ShL4Jvyx78lAyKfoKR8nyJywq/YiXR+/8cDq0U0fNW41YNvimyK31RQ6OcEgjDIsv/tb0Up16OHX/4voowaWX+mSQP2CLhJGDeUymgll5MJISDVT07db9sUGyhY7+hOCssB6JwP9HTj8f45weL3FXRmVHxS1BQkCc0A6ekrA8YIVpCO/RIYu7RMrcD1nRI4Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qKYu4Wyn0UThUE2/zOVY4VBpPD8jQAVrBUNGHSmUURPBLgQswM1T3AcEXazArKny3BCQkNpII3EbdW6nU/WTUObY0l0Xl4Qb8SgNGnelYejr+FQCqJ/pE23n41KBuuKyVLMVsffYcobYFEt0GQREju2O9/yAWLZXUQAO398SsyMk8sbK4vQOV0noLDPTi5d+O/wfLyCW/zCkNroR0w4/+rw/sucqPqEWezbH+Ucd8GYNxCnhr00SncEJ/me7Jwi3IR05skoF9Ob7YlTA/oE1U7dgBqjPbjoK1d6sBMlWG/5Gno8qNZSf6Bmld3hCBPbbkEld1pre9BAjhc1go7gk4c/fiXsWjdLA3Sn7PgmfKta23DPq7Pb/cXqwSiSyTyuSAp7Yl1Zw+/mHaJWTsS6oGWaSG+0kgl2qsE4LJyvmTpaDP1eEgH7aKyr1YAdUFvZbvuV46iANzmBckNiuP/xugiMlyS5cd/mstlhvjUN2633XUzFIWmRC+XkjvdAaNok3l5anxJFOkWeE482z3QGpA5PDVrpNLganvs8UFM086ClT20all9P/7NRFp61WUrwJafUmkb86s0DBQg/7unJhHWLuX9zhFgWQQHj25k1vkXKzKq1HxVCHyXGw9a29gDih
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6a8c53-d23a-4d2d-2577-08df1491e9d0
X-MS-Exchange-CrossTenant-AuthSource: CHXPR04MB10060.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:01:43.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3qD5pIQBfu8Hlj16+oVh+TwCD1+B+fnFc1YGmrypi0wCHdhvFCJi5fs9iuYfXTyNkZ+9eGGz3Cis0fNsAn94pI1GqS0WKA194u2PVF5Yqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR04MB9976
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_010147_219988_DD147F7C 
X-CRM114-Status: GOOD (  12.26  )
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

On Sep 16, 2026 / 19:40, Guixin Liu wrote:
[...]
> Hi Shin'ichiro, the kernel side fix patch is already applied to master,
> could you please apply this patch?

Thanks for the heads-up. I applied the patch.

