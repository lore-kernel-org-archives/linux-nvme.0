Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7EDC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2EXjxS7ixUmRoIpF5VO5udin02X/FPqpvg2SFUSmWE=; b=OOn5AycO5rEzovsjPKwxyYLiWY
	38jmR+9N+cfhlZSCKsI+tRuIAw8sha2YKfbvRYZGlSEk0icp5HxVYF7PKe7saGpVfZBWdN56s9q+K
	rgAlX3Z0yqIMWuUZHTWBqbZHGAduIYCorCV8RJWC1Jyg8oLz0pR+6VbImlsv95+P23Knm1FkbgVnT
	0SSkImS7cAxixrJehikHStvt7cMi9MY/nvCJiosUh3AqUoNkiMaJE1bho51CXBH7rUDv5yDXAbidK
	HFPJl0W6GIOsuhyEwexPG3BtUIlOD5HeSgmZIiExM9sHR3afzEqvW3xh9JNHnDz0JFjjFL4qsMort
	4/PwPzkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weNgw-0000000FgVe-2kac;
	Tue, 30 Jun 2026 01:55:14 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weNgu-0000000FgUl-0r56
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 01:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782784511; x=1814320511;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=msYh9lZ0PFInGS8H5g+6ADc/GH+crNHbuIQe+7CG+84=;
  b=nwa6gFWguWx4+Qn2Yue8iPAwiHUX7w4kHswOv4Ip3mZi1q3rq1M4hrzD
   4FT//e5FmTAw8C+vctx1iQYNSrBQIyF2EBU6MyGlHV5z9/2k9iX3i/pyY
   itrdjoJu+B3Nd+ueDRSXN0gvQ+I60Y6jjUgafF5v2yS2GQsTHw90/hJUA
   adaDvq8RlYHjcajyxtc1oY85ieWctd3erWTAkRzHu4gDpKhQpsGBhEFyW
   G/XZoxEf8sArsfuemEGDEdmEVVZeab/dom+ILaIODO/LYtk2XP/dh/mNK
   lkKXtX4/4jjCZ2eBUE/KN+WfPMxzNjKtE9iHtv7bbS1XxIKOBlnxvz+7y
   w==;
X-CSE-ConnectionGUID: mM6+Wju7R+qGgYSMDc2+ZQ==
X-CSE-MsgGUID: gREhbBN4QrqXeEPWQTA+Tg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774281600"; 
   d="scan'208";a="150973798"
Received: from mail-centralusazon11011063.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.63])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2026 09:55:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duxx3CfhPr2T/DKWZYj0aJOh4fKMqdqQYU5iMnzuGundubfD48i2OI5+O1Ha8ydl6fWi8ajkpIYYF2Cv9BoyJMGPbnA450DuKAj7BpfaCYXqLCGzUpcnjlYUVja/TFvO3bztvFYiiqWBWsVY6E8HD06XlCGRGGI7o2b9KzWwUVLgyzZ66TRJ+saLpiWsHXzWKB5LOG5JPnY3DNS54lj8ju6OyvzeyvMCyxvcQ212EqrZR7vfaB0kwLOMgl/7nW9tigmmWnfoEUAv4tDJrlbW6nVsArerTh+/t0ashOgVNH3/og+674co5zFY0JNq8CTqYdtrPk7KCFZgwK2qxpBtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2EXjxS7ixUmRoIpF5VO5udin02X/FPqpvg2SFUSmWE=;
 b=YjhtCEcfKJ/rWWPyHa9fPlGrI68C3ylU7bORVPrf2qCS9xBarYhB5W3SWtpkTYQcatHIJ5nExmi59rScxqHrxctAgd8d6O7gX1fxprIAa6n99bLcTUbK8PwrZZlQsuNVTT06/XSkWFJepR8zgsz01d4c1JtCYJ1/qSJuT+LFGrBN0yiqMbjgGho/AXxZ2trCQ43Tpd1G39yPZowZI+KlgFAIqsPMQhMA0nKnLjC5YH3o1mIYWuTySF0jy7EUzjZ3lvjhCjqvoPSmngwPDvV2rTkr4e+5Rhm3ywZYI1WdSIZJpHY6FIJcfSl/+lFp+R6up6fg2jM2f7a7oovNKg6Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2EXjxS7ixUmRoIpF5VO5udin02X/FPqpvg2SFUSmWE=;
 b=WZRaCzcRonH7vNAKVKYAnWXcGc+aSrrns7voEclD2WlqF+XbddTli/9k2yfHs4UNXusAeXvwDuY7Q0pgA8fKuhMeq5e9fVroJ0Sj1pqRF3OMk3eeZJod9LZd87SyDWXQCiEAq0rsQ12gEKk7/MYYdgfW3RRBmEBgyGQoEaNCQkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV1PR04MB993596.namprd04.prod.outlook.com
 (2603:10b6:408:3f7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 01:55:10 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 01:55:09 +0000
Date: Tue, 30 Jun 2026 10:55:04 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: nvme/039 intermittent failure
Message-ID: <akMhmoaARgetCTJJ@shinmob>
References: <0f6beb6f-3d3e-4408-be8d-5ed36cdc2c56@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6beb6f-3d3e-4408-be8d-5ed36cdc2c56@oracle.com>
X-ClientProxiedBy: TYCPR01CA0207.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV1PR04MB993596:EE_
X-MS-Office365-Filtering-Correlation-Id: 996ab261-dc85-45c0-282b-08ded64a9d80
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|19092799006|1800799024|23010399003|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: QFVuoxozh6cyPyueMGYs6AUYLBH1eQhPKwFAzBQhzc7CPxPZpfj5/gjI4NI4sWJLGG5KUIVS3KBrCGnf++QGwn6cs5brFU4F7K78+T+T1XbfhqVP96VIJwnrGtYYhkueVvH3OcMZxPY1fJXnK0aXaK/A1J/AKBpsOkb9EKH3678XE/DSbDttIvz7lVgISlUnl/thdOo9iau15LmajdUpiQAskFrmCjUGdUyOOPl7JLyfGslSnBJ4lNBQqMi1TvtnBgkph0KfgiQ5sbwyXc4M4y4C6iNAgH0+YJpT4iUfvGP9VFTJ+HFt1rTKD4csjgkWb4X3W6GuOl2waWKmCIeo62XRrbGP6p5fUH3if79kNTUfWmeiav+KX/A9txnt8NKwJXwRcIhaArZr8UAnRn6nwq3Eo27i81wqcOzIBmcZv0y4JyA2pRcI3sAFNA+CgvT7ElH0fJ3ufqvIyTvE694epGcKWpA2kLNtU3L/kSE2Ik0dkYBX5zLy/QuTo7AEGFnPuhvym5a4M2zA+NPO3QdH0sWznCQWou6eEBUGl1zOXxNJJiIoz3rkO1xD6NSLHJbiBzb698VHZ6tWjPe1qNihboRQScd/uDLhNzQ3E+qQBgBr2TY+5g6ItPBwBQi8/b5f8bPz1Vd7fpeIGxwKcjIMcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hv+u269mQoefHUkB9SIicIGTfbMDUjk/4uP3Ou11EbU6NPLG3LbcCibhYJh8?=
 =?us-ascii?Q?WJsR8HFDY7K5un2Pp/2zdSEoZRUjgZZdPH+O+nuojIg652Bq4ZxXd/9kUVLj?=
 =?us-ascii?Q?bEGACEvnF0MY/8XGPT8WZEr6WaFyXNRGbQO63lDwZE9Et1F06m8PNtC8MCHV?=
 =?us-ascii?Q?BQuZI3M8TeBUBJEymqQI+TLG1Pwy8/BLPioc7J3Z8TE7/kO5EmNRPKQ/Sy3p?=
 =?us-ascii?Q?5RpOti9dnmmQzCsvqhrSxL3ghbtKXx69LlxDbZe1CdFbZb9m2+UfegsLAI63?=
 =?us-ascii?Q?mAGkuZTI7dVedpxo7A1PrmZ34J8PGGcpScH7z74d1oeLzGx/I+pxslkQg/Rg?=
 =?us-ascii?Q?vgumNadEIngfkm+0K5EMflTDkzJx18ES4lUqHd3xJUpIhuknUxFwu2acO9D6?=
 =?us-ascii?Q?vV1zlBMLiCl+X4qkyse8bdj2a9u1YVUHLVGhtwksVDsJnAdlgnlO9sIgs4hE?=
 =?us-ascii?Q?NU/jPMW7Z6fOPahn0uWt1fvKny8Cw0iZUs6CZ7GR4H22wgjL1aSlObKpygAO?=
 =?us-ascii?Q?LHQNFzDMryp++8V+PEnfucugyslLUiREoqjhSC3XeHr3Tf/qOULs/HQw668J?=
 =?us-ascii?Q?prUYDrtgkhVvD04oggHEBT6yw/JdXg0mTRS3yVMspl0vzXtNU3uhANkMnIye?=
 =?us-ascii?Q?VoNTjE9AyJR4bDcsVK42KvsfMP3WhTT+g6LGf8xskO9HdFjfVpRSDB/itet1?=
 =?us-ascii?Q?+GDGthrgTlo8WK+R9cDO+8zS/TOeL3HhdZsAeRVFLrAWsqJMDNDKPOkVS+y1?=
 =?us-ascii?Q?Evb8Hrdy6xWXklrXuNdwWdZIqiRK9+xTDGOa/4ngltHi6gdrm3EljuupHTym?=
 =?us-ascii?Q?PGg9SMQKvd8OceIVjQeYbF0XS6geAdnupK/MhBCN1KXHn12/N5Yk60GIKKvP?=
 =?us-ascii?Q?oYV7qRltDddYbkRi0t0PfAyutYtNVFM8qtqHfXcErQZRsrmAn2tuBoGeMYz5?=
 =?us-ascii?Q?C1yOBCJw2zRrp4vzE7etWxUaMWZu7a5SQG11FajjxnEmhqLY5t3BvINgdS3V?=
 =?us-ascii?Q?BmqyfdIruu3Su9bmpZErfGYHDgZ9/Ittg+KGIBySTCPEBoyDTc5zLPsk7vpN?=
 =?us-ascii?Q?BpBV02mLAL5cfCqd49Ex4MpbtGcWhZOIBan0yDOHmyGeJhEisk6IoFS/A0Xz?=
 =?us-ascii?Q?/wuwYFx79fNNRZz8ctbALY+4yyTU7xME7GUpBjdJf74XU0fqvzaSpmMY6sb6?=
 =?us-ascii?Q?hrzzeEsDQzMaM07VHOhIudHo/O5WVinFZ7hndljT0USkUFPjREVG03/B/RPC?=
 =?us-ascii?Q?3/501r7JSE7+vYf5L2hXhYP7ToCWb/rsbAkYPoxzEIAHRB18pt+qAX6w0ahR?=
 =?us-ascii?Q?NdgmwyI4MIHlWJjGsbHayDqfXhuuXqHdprAm1DEQ/O6DLfSZ1R++PqrrzrCw?=
 =?us-ascii?Q?x90AGD7kdFWnxgnLLnN1KcTioA/kSA2e8sJCtLNoR4/hYyIi3OfqRTeJcuCX?=
 =?us-ascii?Q?waBA+6feAzKeYPjVCKl4fsPmCzwQkHOxgXp2lpISuMB0WI06dsYuvIrOooyo?=
 =?us-ascii?Q?oYpkGCtrUipfvgh/EONd/UWPx0jNAZqC5UJxVoH6K1/9Kscw9e4o+W1BZvg2?=
 =?us-ascii?Q?8QiHwhEN6ZrKhPfp2xzJYnQKXYDce3761OqDg0jchv4ofYwh3obDmx6LYMni?=
 =?us-ascii?Q?zbVubCyJJ9uaT3G853Eqf10bkeRTWKFQ7cF+fCPgUbjZertn9YfzsvzRdDdh?=
 =?us-ascii?Q?8MCqB9wz/j8t5ZpO/ROUK7XQ32hEmINiSceC2CE+/hsB4UcVfn062BdmzJ48?=
 =?us-ascii?Q?esfAaZQyRgeOSjqyxg2b5JDndGXCHFU=3D?=
X-Exchange-RoutingPolicyChecked: jY4zdTVski5o5vL40P2k9PkLgwK6GRfxXiBPvc9u30ps9TrA4YQS3fH5EjnBwu+ujrvYCAuYvy/ah+NUkJLFTRsJK4up9JNBcxFD9w2At2r5tugSuItU1KnDeD/mFkNhOKigBILNY3sOVotIEZS2uWpQJSsLim6QFhLp58uz/SUXSpkxBjrOzb++QxT4mrbw52yJKh/kNvoispfxbvWY/1x41b8X4c4+KKFugf8KDjMYz8c1Ynq6bXV56Cg0FEIf3bvASeKR9n0Wq5EhPlv1QVx60IWq1ZKFxGOchx745F/sCJDlrSlysAp/3IAYQWGrmzn1Fr3j/Tv/sdeqEd6AWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HSEpZK2uAIT6D/t65XKG8hq0tY6DL9I3i6KmUYRCgQIdpni2V+V2wvxOJ22894QxjhbP0gFYtQJBKf0WPCbePJUNEs8nCapHF0fLoEabfOWbc6iNIFbxH2xmWqFR5ED5NLrVz+4ujzufeNWWGzF+YY3vqwRiJUkj+ahV3R3EHPQOPET3l35zgHyJKXADuUxlF3MuDHqpN5qtXPXU077RaGu9DsZy+PDhHII3eR4mSWl4PyvlXUaV/uhHetJRrVFI0LWWg2SDV515xYvh0SbFQMDLe0LaPCB8AS7l7RsgLwiQdWvSXh52TzwesZzCCsgGBJQiAXB1L6HgbCm7wJZ/8akvKRGh6LMn+eNv/qsIuxzLNuxccXDmuLm0uh7jzSbCf3KbnPuRMSauJByRrR+8OazW3VFTYt9IdOfjxAS0863earu5AKpo/G9bcw6Rrh0ggg/aOwbDxuGdX8XmwiN7p+No7ldXk2Nht153jqicXmmMy8fZuoHMU0X0fcXmWNTQ0zwg0Iw6hAaXqcR7cLDVotOWTxUxRr91bAvAp51tNTjNj3omLo1DCIKmJvMAA1V9b2+KNGGWH1VBlqx6aGRr10MKgAtRripkA8N/rjApWar2KY4cb93Y/eaTh3UF4V8N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996ab261-dc85-45c0-282b-08ded64a9d80
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 01:55:09.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX4dAXIjsZkCORP5CG1HqH2I7kXUbBwDGDQjLSiM4Q8WjSZx8tN3DxwifO2L0M5laMoQ9lksFItJJsiFFa+aTnASGNg60t2JnCxy+RS0mSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR04MB993596
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_185512_338100_7F2ACE65 
X-CRM114-Status: GOOD (  14.79  )
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

CC+ Alan,

On Jun 29, 2026 / 15:30, John Garry wrote:
> I have noticed nvme/039 for passthru error logging intermittently failing on
> v7.2-rc1
> 
> For failures, passthrough kernel logs are missing sometimes.
> 
> I had not noticed this on older kernels.

So far I do not observe the failure with v7.2-rc1 kernel.

> 
> I do note that the passthru error logging kernel code uses
> pr_err_ratelimited(), so this can hardly ever be a reliable test.
> 
> Is this a known issue?

I wasn't aware of it. Do you observe any kernel message that indicate
that the error message, like "X: Y callbacks suppressed"? If so, the
test case maybe able to check the message to see if the test result is
reliable or not.

Alan, may I ask you to share your thoughts about the comment?

