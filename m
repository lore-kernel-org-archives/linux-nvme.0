Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD8606A326
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JwwpDbTi;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=OvnOTUIY;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=dB3iLnt6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rzsq7JTeMIgepdkVoIIobEuVu84EPUObLtLeUHqVfeo=; b=JwwpDbTiMXP5Re5OJUagAfsgtE
	Hb32FKCsUx+bUqw5lrTAQbxLmB7TigqebFmlPwJdoJrT+oRmCGDVyB73XDF9NWgcLkRLZiJM7CBqh
	c3WWPu7P/cbQXrsKbbWni9yxG+MVbPN91rMgoHKQ+ghi0iV+CilDFFBdZDy3I5D68u2vJGq+2K/GL
	Lnvtn7ZLWwjDnrnTMJzU2F5eQeRFWB4+QYbIdWtZhqhzo/AmmfoJl1hSdK1bKIMj4X9PRdYORO8lL
	NirdPP+przGcMAuvHGolVnUVFqhN1I0ugR6jqhcF6DUTs6XUeEdlVBODGfpmHP6wyDJaGjkIewTzQ
	IMtKIg5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWojE-0000000Eytq-3mck;
	Fri, 27 Nov 2026 05:42:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWoj9-0000000EytW-0hKx
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 05:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795758159; x=1827294159;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gMPpxoMeqNNwaP7waacczBaSQadlYR+mBFKZpmtYBj4=;
  b=OvnOTUIYQl5r90gfSxFvJjD0aLOOgSBngGiqagdfzyF6NRbbf/Jz1Me7
   e9of0u3FLoHhJ/e7hKxSNs39aPSqR+EMENUZykBMjTfagwkzIpYHBh8Kg
   kw9DGyxMBc7jkilSifkG66cg0Ijs4JjfcIsBmpj1M8YflsV+OcTD5ngzA
   StiWsv9fMi32KBcXDaeUIqbYQaf3EJ9nDp1gErWVw3ckyBYGJUDdl7JAY
   zRC7cXtsML81nwUCiKUFp57DJtMUj8Sve2kuUia57Mh9REfytjs9AAJwW
   WJnMfiv2cU5UtBwjaOI2wjJFIbDdIyeCvkg+wgBD+axTOrUODfmRJuoXb
   w==;
X-CSE-ConnectionGUID: oo1cgeauQFKac80qgsn6JA==
X-CSE-MsgGUID: GBoxwlLyR4KfPn8ASZDjAg==
X-IronPort-AV: E=Sophos;i="6.27,236,1786982400"; 
   d="scan'208";a="161811513"
Received: from mail-southcentralusazon11013021.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2026 13:42:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykFgaemNi6eVvgF1LpwFgKwc7J5s3Y8F3gII+YfCibPnufjiXHwJ7sJ4WVGGmz0X85gMQeflowWSMJ2c08Zu6wnoYKEOq4CbgW6amms7h5v1r5cEaXagYslstHV6g4FAPvlkOF22DXKNJPauqx24EzhRYFFG78lzpPvcnSEr7cITNnFUk7eJ+Od9xivcFP6a2huazO0fzyf/N+a0/GotyWVL5VxuDU0JKr+XcSOUlkC6wWnVeMiXsAt7jZUYScV7DQCsnwYJK50YXyGX1z9Y1/8JMlfp/6RKwN0myehvgV7K2Do+vmar8nC4mO8p9JYnjjPkQNNpkdWBJLNVkQtGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzsq7JTeMIgepdkVoIIobEuVu84EPUObLtLeUHqVfeo=;
 b=f1IUCabkM1C6yQmki8L0ayMwQXcGAyFDyyJ31P/SzTtNkZus1oQIWDGAmYteyKVfol5sKdz+WvPUILA6b59BapNBXBrTK9prJ57YHSJeQEs3Q0DFRS8Twi0dQ3zSZ6y6zpH8XP+Aamp22H2Kp+IZDSh9upvuB/r/CKcWdrHiGdeTZXuskU5zAv5yLiHwWhJVuVeKKNweQGNvd5rodx1O+NEZkhQNTEG+7AKW7kaOLKAexoewQl9FCndZpXyn6pBbI4jBoi4muwswEKSorcxdtuolds3by8AJ54wtUviGwnZhi+508obgLT2FHiNXs5r+zs/GDHG4b8qayw/HZZA+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzsq7JTeMIgepdkVoIIobEuVu84EPUObLtLeUHqVfeo=;
 b=dB3iLnt6GLkPTD8XiOMXV5WvlsBSLklqHrExiTVqa4mJ2ZB+1tJMDB072LPbGAVQUAcKnbVLz8qqoFkLSF9ElicU6DnnDHzvD7biMbhzOywHOjxTHoZVWAESDqEwRFR0YqVBisXADihV1pSgU7JrD+NjZ29nn6BNnfP2aktSMHY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PR04MB8620.namprd04.prod.outlook.com
 (2603:10b6:8:124::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 05:42:26 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:42:26 +0000
Date: Fri, 27 Nov 2026 14:42:21 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/5] skip tests when a program they need is missing
Message-ID: <awkYJgHKSH3_tFBD@shinmob>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
X-ClientProxiedBy: TYCPR01CA0169.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PR04MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c49332-30a3-41a7-f313-08df4c4937ae
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|11063799006|6133799003|261009223027099003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: iTwE1W7QtKerRJ3tDBC942MW9eqUz5Z5/pQfB7XNBQzgAnWNQRI5dq0YhIntrZdN8ou4QsKtw+1PhCAUK4UNBVUmH3Ie0tH7g09r7L0wzIOx2sqUsU5khWf8wml1T63pSKCN41BXHVU8UPEKZhUJh/oWGU56H6AdVVG53zHJdkCeK+MEfRaiR6+aApa+/wfLk1RMQAnSChW5VxXLsaatlhCQUGmMG0psSPYTyNLnXg6QK1gmqpCwaYYRrUar7HuXCOKQY3j78GkXDUqBoFM5shZsZECEqFUDy9elGmX58NOc9Enimm6j2hWfmTq0ai5PJR/6f7xt9EiPB+w5wlyaLa+Rbtr82JPq/43c7z8pjylGCB9LcOjKYjiW46OH2gT3aBWyIxAhkyRF1L2oZiNDIoiKJQG4/qvjmIsLcLYq8aQ3WvjFp1zWP984ouoAPbwlkKzbmaKCga/nhw0gwsFrQ9MAlr/zmCCctBaF/hhH/rA7xLLPFXbGY9Ytmt2QACF/XfgqOYD5TbDM5jZCSxwVPdnIvnR02VqJi1msbwKISmAM3k2uuAKcAcWvndQ1Tp6Y018hqNq1YF4nKEgK30LA8JjBrA9fYlgPX2YMk+60jdgP+pdaJ5JSPaUXkPC1ikPThcT3FmZzlb2kKbqpmo5YKbeC/Fzu8AYB4YOsdRCZWTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(11063799006)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GI/ImYbXgiOb1hlZN0SdYCEQQ3MF3FSsKzn6RCl0MT+v/SWlQFPlQ5lwxak?=
 =?us-ascii?Q?LxALD3jUbkfVBIgE7YOaXcjAGT8aaArss8BMBB5fjwr3FC0aZi3zwaprB/0d?=
 =?us-ascii?Q?7QJ5kqcvgYheQN2Q542ennPOnyqgSW+nlCG4Vcu4L4i8hcotyqsbEpDMaMS7?=
 =?us-ascii?Q?BJFla9uWKR92HPcZBuMHJ05lQRxXZ1nX8jL6i4B1DNcGSmxr/DFDTtlfJ/NZ?=
 =?us-ascii?Q?KCw5mfhWnKz9ziZQJTuH9+1MHJ0cbNTFfcGJ2jrLkuMm4a4QeTL15FoPJo8Y?=
 =?us-ascii?Q?baoF7PAIHsgxJtCZVSKlQWCif9DQYP59rTnw0ACzWSfjRZxKAvTAokTQLOtI?=
 =?us-ascii?Q?yy63Cd2Ce/z20sigK/exvnol7xMChVQPLFg5jZsnwZJpwRW/SXEdN1+c+2Ls?=
 =?us-ascii?Q?jl3x2Pkn9lv4ucwikQWh+qSFTMSiG8NASRS3ryVSfR0w2Ad93KhT5ux9QM43?=
 =?us-ascii?Q?dLuBKYlUtCT8hKTi0MOpG/3zQf3nQ8kXtymY114zq0Lv8sCQYulOmKUSduXR?=
 =?us-ascii?Q?lRlZvqHby3Pjj2K1sC9n6B2k/i0LAoOb89iYaLtTwgGvZY9qHt6hbWFQNFvi?=
 =?us-ascii?Q?6j4R8SJ3r3z3jyki3NmxorK8bRU9THr2B7Mmngu4IljVgfcR5riqDYbUsbvv?=
 =?us-ascii?Q?VwKAiz7+k6vR/sFrE/A98cm5SYqLDw55yU/7tGKH5+pHbbcOyNglOi1qNWXC?=
 =?us-ascii?Q?OZsPmqPdInoGuns8D6CiF9hBE/lxaBupxr3Ruxy7skpm1RtRIRsybOkrv+jM?=
 =?us-ascii?Q?1H1yHtgWk5Pn8rqGZ83eY/YgcZZVEoQWnEqNT1PFCRFCBoVjE7CHtax8YZtQ?=
 =?us-ascii?Q?hhaUZBOtFS8mJgGHf4RezmzQO/mmv6o5weGZfOQ3+pCSzeNc2Vjzi6uRTeKB?=
 =?us-ascii?Q?fZxwOrjR7VhMJYNPULyIn3deJEKzaj1puyi4Bj+6zHZIJE69/Cz0MkgA6/ZW?=
 =?us-ascii?Q?IK7pUen1+OgNYMHkpbsRL6i4muwf+5lv/M4VX+VoYanVDGSx2NEv613UW/fz?=
 =?us-ascii?Q?wSV8AwcxZ9vXiSvQj162Mm4ydMh46VsR8hUw73MFW+fI+VPGkPIx508VIc7u?=
 =?us-ascii?Q?znIqXCaCQ+A5k2NSdF9uIcADlVvWK7WK4wiI7gPrd75sNo1WM9zDOq5DzBj4?=
 =?us-ascii?Q?aota7YkF7dqUn4sNRLAEZPr9VwMqabM0FPRbADOd4N21r4gYXKQKWMjN9I0f?=
 =?us-ascii?Q?zqAJYUT9A0KOJgLuZZXkoWaSd8W8lrmCap6Xb3hdbfxcqyEyEie5ei/IfvNk?=
 =?us-ascii?Q?V2dk1AHoj1hAz4XUyAyRqTXdWa8n/Q8HuHugRS4eLgTAVGBtxiYGa2osAnyG?=
 =?us-ascii?Q?P7G4Q2E2KXNMzao2sLhztriak8pQRZthFhOkGNEwzdok1hhRt5h//8PfyIyF?=
 =?us-ascii?Q?Z6bjyzyxQovVLKQt3DDlXKVB/yVjIPd+f+fatD/rKAxkPypdDzdwuSPe6JoB?=
 =?us-ascii?Q?pH7L2JbwS5ZSCf+KoSwQq8k6R293Wf+NwdmqpVDnM5Y2AIqZSWQWzO/DdJyT?=
 =?us-ascii?Q?t2j9OhWn34mKAJzrAPlfH/tgKPigAZiXzGNxnN6ewEVgr8GoL6gwUHB0g4hC?=
 =?us-ascii?Q?MVMYYDMzCiw4E4PLnQHLXZusc2ua3P7GWRhtwr9JaORNZ7c4LT1qQt25D4i6?=
 =?us-ascii?Q?lszWBP0B6BmNJw1Hn7khXFoVWsu1CMT2Yew89xCc9AoCpnV8qQ2R5g7QSqOF?=
 =?us-ascii?Q?65nN5K9JHX4Irf0kH742MgptLXRlr9UG5M3YLwHd0kvaO/f3D6LbfIV3HuHx?=
 =?us-ascii?Q?D/oN23nebE09guZKPUZp4YNWLE7uec0=3D?=
X-Exchange-RoutingPolicyChecked: EtknZrXvTqF9+kqsO0dKPo3o8xiQaYj7Yy1KpS6xNQ5rtBGyFKpGdNajlZrsz/Y7XDuS0KaEdRhM9PjgCyKAc0cejcLIqzp2xDAo+PDLbBrQcxi+ujud29qbuCHwj8jj9PppTkDRovvL3XwpcWcvRjrACHyL6gGYsH183B5SHtECqhZGFuf+s7/miyyN861glmokF165sbhRc95QE+J449rXrvHjCFWHDUpcy7GSHrgx6RuA/gdKW7oVgLdjJ7cNSm8whx9JG1epHzh4YIXXA9b+cf93xsFgv6MlM4NBoK79TCF7OvWCZcHzE1cKeHzJ1AJYBXuW12JQNmbE60VP1Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6QTqcJhE0jLmU5beN6DxlZUkXmOb7t2qHNZ+OeiDI200MABTuS6qoWma/7NeVNvjTvRdcP2B9pkp4Jjth6ee/FQU0Askebtmfe21wk3UMFGbuSAgZU5yxaFyKEPDLW8mlNIsdxLhP6a9E052tq5d/MnJCciL4f5fCoNfIFURNXHFaja3ezSD4wDBa17rr5ayQuPEcg+30F4sa/m3QdvWAYViLHceIZ8EHuGIWB+jgM2Dq4kWVxcFCfPz1mElOmIwMiTTD00Iqu8Ko1Ud1IjSgwjBlX7vRlvfns3MLAVSGpXHhYW4B9tRP+ASW50vfa0C9Knlcq+6nYZa3yszX3f9lIEOiFbkBYjVI6Gg4MrSDm1ignWKIKLyY2Q3PEYsqbqR9MvG6jO5zGhcfsRsVt3aAa0Bpp3Ofe6W2Tt7DUnA06awlr25dsoDreogCU6zvXJ8ijKkdu0MjM0Ovv0cGSNUcKzeP/T87CS+IYTXqJErYbCbU9H2sN6OOYDHyYaj2cIr64aj1kW8YNjdCAlgcFVCNagVgSaES1Typpx9joQmA8uzP0i+hMBUoOtUbi8Kd6u7maG2R9hEU0X9yYglreAgHTCAwVx+WSSSsQhUuYBqLWxY/Od3LVrEtDxBZdmHPdlH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c49332-30a3-41a7-f313-08df4c4937ae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 05:42:26.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnPDuryPHGgoBjaALqDESuZIhJ+Q3xki/NGN+tywU54Rc2gF1Q+o98vY50dz7EZbbH+7fKKRb0Tu1jVLSj3o2ZE3yY+a28gnPFD6Rx76I24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8620
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_214231_229998_5C0A81A3 
X-CRM114-Status: GOOD (  15.21  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 18, 2026 / 09:42, Daniel Wagner wrote:
> Hi all,
> 
> a few tests run programs they don't check for, so they fail instead of
> being skipped on a host without them. Worse, check leaves the modules
> loaded when a test with a fallback device is skipped, which makes the
> following tests skip too: a missing xfs_io for scsi/009 took out six
> scsi and zbd tests.
> 
> The first patch fixes check, the others add the missing requirements.
> 
> On a Debian 13 VM with a 7.3 kernel and without these tools, all tests
> that fail are kernel bugs except nvme/068. With the tools installed, a
> run of all groups but meta goes from 81 to 120 passing tests. The
> remaining failures are block/052, block/053, nvme/073, nvme/074,
> nvme/076 and zbd/009, which hits a btrfs warning in
> btrfs_schedule_zone_finish_bg().
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Good fixes, I applied them. Thanks!

