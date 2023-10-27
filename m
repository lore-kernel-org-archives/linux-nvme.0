Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A86BC25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04cxqe0GyRUh4BPP84QBUL6mdT5zTftpaVU+TYaDKpc=; b=yga6ZwIl7AkcyvMSnez9YCAuyV
	Mxm/9S/07NS4h8SUhVC2k0r/JfTMol+xSJuAMMa3vl0pJd5qXPXb+oMtMWnoW1CTdeIWu0q7v7vrf
	c7w4YcYWR/Uiy2c2QgdGuGvP5WvVWwC1PEG4fODYpI+w/K9sbqCvo2CrIawqej3zZUwpSb66XWWM7
	8hdzsDAdkTYq5CAK5q17PB94ogn6FfJm4a7PnwdiT0SOIQFg8DPvHFe/6P+suiBXvyXdiKQv1Ph+U
	oqdjJz/3M7ZYB4pNcfMILcZB4MYY7E1VCIb2UHU3u4Oc4/YIHuJWc5uG2nPIWCeCbWkG/LtOla45e
	JjsmxKHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwHas-00Fq5u-28;
	Fri, 27 Oct 2023 07:49:22 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwHaq-00Fq4Y-2E
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 07:49:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698392960; x=1729928960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=04cxqe0GyRUh4BPP84QBUL6mdT5zTftpaVU+TYaDKpc=;
  b=Lf4LPxyLwZewi2BXFtiBP2cvg8xy/v9qwEXpbtHSYVWqAuvmxb7wXzM9
   knnSBMP+x3JfL5TDQiF6bmmMg0uxOhw6jzLRx86W7H9jiB7Ko+6qTfNME
   JeWubjIzQSKIZEGBLBdNK9AQoDLJthGRc51ggxgQH6aF3iH2iZxbaTBq2
   AYYNpfYwOOlEqktLdjPq3EU7PuqCygRiG5+1IMNHqjkvChDmAY5uytD/O
   9wGK/xLrEr/o9D9uKGCgJbvkWJk9m5zuEFaqugTf6QqddtiSTQl180/8c
   Ib3Hgehw52YDsP8PfX4cX0FKivl1AvkQhK1zGZ3h1Y3U7tiwDFcbhReyz
   A==;
X-CSE-ConnectionGUID: sthbw1tfRJCsn/JMHrGRGg==
X-CSE-MsgGUID: OriTNFt7SnGQtrmEy4Dr2g==
X-IronPort-AV: E=Sophos;i="6.03,255,1694707200"; 
   d="scan'208";a="754916"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2023 15:49:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKcsjKxGQQuT/ZyOLSLuXDSbAEJgqKYGs7CjcCix2mbzlNUCOTG1TDFHDPbo+rV3NWq+HgiGVdv/3BF7a418+5JsEuRnRNTYWRC4ubDBHhIxlTLvGEWP5SNpyaWsllFsKvn7ZIkwrsvTDOXer0UvJILPwhAMV/itYYSN75E58KW1+SKer9xQI4jS4oubz9dlUEJEeYneXjYWme1pbu0QrFDd6IElPP1yZCiLM6Ty6Gm0FGjaHQh5UU73TA3JK/uXgrK1uBi3KQR2YR+ZDb3TplN2s0XLBSEgCl1NQ7/7q+LxFxtLcuXopbQRdkOuNii/dg827k9A4CE7b7jmR+0zPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04cxqe0GyRUh4BPP84QBUL6mdT5zTftpaVU+TYaDKpc=;
 b=jstvziDhv6v+ZCDMDa4oF87c2H905oM/A6e9CgGeCeoBExkdKcVukDAmgZP8ksei6cm5saRtkJaSGLHxYz4BiQZJgnpw02G7ItPK1oyzhZrJ6bkx8tx4A3wSyDAVEhQa1hqfABKEIQxQnVyimkcoXHtvVG+jO+UAl3+qxLeaCDOEt6eUBtiM6/0y/QFfO8wdlXcYK5hv9X+kNX3I+N2jKigVnUz94o4rI6RmBw7iR35c2E4clB7h/Oxz5KhwR1ziOPxaF51eR3rq5L7o4hRxQpPma6Tx8jaGouXXxDUJCJccAUo1wdk7aI+HDezLSxrVlIw5DdxSihtieSiYdRXoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04cxqe0GyRUh4BPP84QBUL6mdT5zTftpaVU+TYaDKpc=;
 b=SZdzdHTLb/ZN83zdq1R0/snPCjZ33PVPmttJNbVNJmCZj8OZ0EH2VjZ/cfyiOlRe/LyH15fNxt6Q/bzCmxwOo6rB0A/ZICAOSI2MwoVASdGWdwR9mtA+i3xcLjQR9hp5aqYk4b7FBfzKOyao43p9/cBMdy/Dm8WIw+iSfrMifys=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6890.namprd04.prod.outlook.com (2603:10b6:5:246::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Fri, 27 Oct 2023 07:49:12 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:49:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "vincentfu@gmail.com"
	<vincentfu@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Thread-Topic: [PATCH v2] nvme: remove unprivileged passthrough support
Thread-Index: AQHaCKQOeOzflIN1C0WozhkHZ2YM6rBdOZSAgAAJSgA=
Date: Fri, 27 Oct 2023 07:49:12 +0000
Message-ID: <tvtfaucvimrqcfbpm3hk5kjbis72typvxmlrgwkylt6nywdefp@e3pxrppwdqe4>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <aesib7wh6jkm6tsvonsuk73pmsgi3h6aikpzf52vbjbak3jspd@kbi4cm2uhsak>
 <2dd010c2-32b2-05fd-2f8a-80e759e94d6e@samsung.com>
In-Reply-To: <2dd010c2-32b2-05fd-2f8a-80e759e94d6e@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6890:EE_
x-ms-office365-filtering-correlation-id: d9033bef-7745-4979-9e96-08dbd6c13614
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nx2+4HPv4eTrskhgyWiJ7D7menkF0hIguwn4f1cX/jFVKihgE4tWoD7FFIxxdVVnVkoGWnpzKiqV0mrgFE2MAc0yOem3AX1E0bFyZUaCcCvWKczXM7yuxKQv0kGmmtOJUF2zIMRMwFZvyfSvAGwmnsKafvv9h7aLWCSn8szWA81yTY8gss3UGdlu/xlldKaIN4KKj6eCtg63noAzdF+nauq3Bn8/tfJStNAGUn/KzzLZ5a/fi/BPtLqczqGxbM473IMfDQerxFdHYAxXsL2Uz/PIahlFnVkuZ7plRUR5jTuQyGrRtWvI8D6oWfQsAnlw25Z0hyh649YAcJKupb4ROx1bCq05s/zcrd18CqbYxCcO/58Ttu4yDofU3E9S08oXEiBpNk2q+2xHC4/lHHQYOPk3RMRJNd/JiAKejVtMRY/8RLh7RSZsOFc/O7rOFhv+LuS8Ndj4vPUmxqiq2djVD+Pm4bcxl+0EsyfVq9tv6cHbf0YqUYAwZ2mzqbWgxOLchvV559zwD7kTGscRFqzGZx3Lzcf+iAHIm5AkVZAOg/0fw+2ifDkQ44WO5U6k/CalJHzSgINy0GYi0PuD8w9n+5go++f4HAMMJiJcjCqfM00=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6916009)(6512007)(71200400001)(6506007)(9686003)(53546011)(6486002)(478600001)(966005)(82960400001)(83380400001)(26005)(33716001)(5660300002)(316002)(66446008)(66946007)(44832011)(91956017)(41300700001)(64756008)(4326008)(8676002)(76116006)(66556008)(66476007)(54906003)(8936002)(2906002)(38070700009)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3dfp1bF77FtA/jCM55K2VaA+CykI7blhOgxUJDsdqVrnDwqAeOjGIMaywthr?=
 =?us-ascii?Q?HAxehZG+NWcf18znfEtuG2NN7ve5ghIgXiIYvCSdibpAso5A6MAdaZwt5jdT?=
 =?us-ascii?Q?IKry6I2Y411JNBpotobAn8lLJJP0blsvOOIRCcTBH68M7mi5SUDvQdWgvWBU?=
 =?us-ascii?Q?feygARYwdtozJupgQJmWRkTlCpcKZCYnZ65H9u0UW69PWjhJfv2VYEA4vBtg?=
 =?us-ascii?Q?bRRLfjVszDKMnoBn+iPu4Y8gbkyUQ8pi5zq3laCudzXyJp+Vcz0WsmlipfiD?=
 =?us-ascii?Q?91AR8k1WTKrgZhbXLfNRuYCWVvTshuTh0NYdQmLMyQMawfnBjuxQePhV5NvK?=
 =?us-ascii?Q?0UX1P2bMhKEbEREmhQVxJEfyVX2QG8ytRZeKyoIoIZ3vg0jFvivomlu1N4tr?=
 =?us-ascii?Q?cXvUbxdlcWVpMtZiwSZXgth90FiGzg/MhvW7SoeV+ZZpFnNdmw3EWox6xoRL?=
 =?us-ascii?Q?HLfi51hRF0BctLQnwtmgmgFcz7pAdedodzVv1M7PuLhAdzgaVPk5APw38kOd?=
 =?us-ascii?Q?DmLkp3wZtVpyEDu/dpRX6OmS1fuNP/IZoOl7FBGxliMwmLamOuh4/R0LBV19?=
 =?us-ascii?Q?bfrlGrXEtn4lZvbEV9yLuscI0C6FFnpFqYSz/IEu2y0seLshbj2gNBcjjy6n?=
 =?us-ascii?Q?Fy/MD+/PQ1FHLUdr3XDOblDkY8zKHS2NSMg0cmXXbi46g+sUkT58UVmb1XwN?=
 =?us-ascii?Q?Hq39f8zc5SkIQtyoUdgmKtofjYDnO1rJKJITGd8y7enPwW9+hFIeVr5xQHOD?=
 =?us-ascii?Q?eVzQO1bkyK3mQHp3lzJEVi6WogNWDaHOCmHzHVLhymHV4K7xQ7cVUab66146?=
 =?us-ascii?Q?FOnH8LluFqy9oD3dRc78oDI/pB8rZwTCKw0NRQYMibCjKmliqTSg3+7RvNT9?=
 =?us-ascii?Q?49Qqy+W+ILIDWCqffXm+DQfAVHKIc2ik1Ln4rVfJMinC/SsX1o1YRwTzhJoT?=
 =?us-ascii?Q?Va3swWumUktPvcbN/A8VPGsBiYiA2DVHe8Sd/JogeWn8c5K1sYsjJoDia0vm?=
 =?us-ascii?Q?7dUREPoSFI8C3Y0xAuF9GV/d+M6urScI3ihP9Su2cCVpnyBjKi94Wjteg6Ww?=
 =?us-ascii?Q?1kF1wYOm4cOihdCH8y3pHln9hLZNMFySP1cEHR7vfxFfQJwUqTg0Mxm1XV4Z?=
 =?us-ascii?Q?A/iQYj7dMxJiubfd+B9n2tZMyfKXXBKJufJSZKMXGClkqn1vifxRCqjHsnTF?=
 =?us-ascii?Q?WHgTC56sH+LpZuDP6X+z4SvH10a1LiTSfMei/pO+NYHLeixsmdXDsTynyySn?=
 =?us-ascii?Q?fQauO0U+X7x7xH0Bco+It3VJJMFcK3vwWTwddl7WeKET29dzQKl3w+sgPF80?=
 =?us-ascii?Q?wK59spodTkjkdiUSPaBhZF3vd3pcAKseSW/CCtmKkMrxL0LUshr4C4+C6aea?=
 =?us-ascii?Q?9IGj14HKy5rlHNBBgVz74nMRJo7T9isoH0XVryn1G+dBz/NEPk6hGtmGbY+2?=
 =?us-ascii?Q?WP7duCy1Jms8VhrydUs++4OCEvYjye32tLsKsO5c9JmpFD6WvjrcBPPBkIA5?=
 =?us-ascii?Q?Zzy6AAtg4HElYXm1ai6wVskpRrWXzp1B9i5DU/JQ/ykKXde9JxcuRXO01Ems?=
 =?us-ascii?Q?bRthWuSm1xocRr9mEBG2Hhg2IT0gaMEYFRay7S4zCsUdZF706yYZBmvHdM4o?=
 =?us-ascii?Q?5xOaPtgbCjllXw8qtXcQ4GI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4CCCF70593E4449B39D4AD35B85CC38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Fz92xICLKMn3Qu3DeCt4rRbnchEAuNrwKKcMajYNr81phGXnzPf8OadiJ3gr?=
 =?us-ascii?Q?EsNYBl1nYMttNurHMqVBfLDn4gz2vJTUuecT29l84BAzbs0iT8CJY6KHM+3H?=
 =?us-ascii?Q?E+oFL0uiY3DhuN/nnPbAtLTc5/J+ns6a6HpSZwbvARaSZOpDXpliAZJGSNfF?=
 =?us-ascii?Q?7UHwxcfy3Z/mDLclidqfwTV53SfOGc4HPG1d3e7FJf+i6TUFqSgteiMOh2uu?=
 =?us-ascii?Q?sPGeJ3BqBZ/EEaOxCA7Hc9ql5Rcxrcz1egB0l4rYQi+RlO4mwBEc62AKHUvj?=
 =?us-ascii?Q?eDqTQ0L53L5jV0SDoP3/yLjCCkfTdCSuaPA+pXAzeVKV3ICDkdnlqD2t+PQP?=
 =?us-ascii?Q?Wg1dDO5eGs9LHgWaNm25BHe5HjQmcfZ5UQ0Q+2aqagsAPxKKds66LyES/hGS?=
 =?us-ascii?Q?zgDgiOESrQgnRO/Zq6U079lohaaxJJwIY8VsXx+tF/GQjToFEPWF2m8F/o/X?=
 =?us-ascii?Q?JYjHzw9OV1rlc+sYsDBjuklFfmNXDkPnzftL/hVF1HcFLmUr9Ym0TeVNvs04?=
 =?us-ascii?Q?h+P3UG9LjcKsGoWVxqrd1UdZx2hOYWmwTxHOoGSqRprCLKqF37eW0VfKzd6B?=
 =?us-ascii?Q?2b3sxjmSLy0ZAstutZn6qPOGBmaP+ct/qMIEE4lW3tTmHR6FWRd8Ef0oOrfK?=
 =?us-ascii?Q?WDzt3+Q8Ltq5/IdRzwqSkGxEFQ44aKuRYA40a6zyVjhemFPUPvXS1kR2SDIR?=
 =?us-ascii?Q?BjzVxXhRWrOZ8als76uvQn7y5OQ43ppaSjALZdpSY1SVjcVWNrZ+iwz3kFdn?=
 =?us-ascii?Q?z3KwOrJ4Sre9wS+Cu3sphvNsRArcZu372pHTZhJtfl7zCXETspjGekiHvtHI?=
 =?us-ascii?Q?5N91qE7eOHc9Nu63R/uKK6/nC2z6fc2uQQZ1CH47NC7DfTe24q9aV9f0qmrX?=
 =?us-ascii?Q?jPRGPircdBvQ6j4hPihJ16FUlcSgcPNdv+0Df4FbrP3U3VCfERlwcSlVspuD?=
 =?us-ascii?Q?MaY59onX5bB3OTZzX14MTgrA8v/JZ3TK0as3O6h6MZcucvJqNN1w+BHlTxE4?=
 =?us-ascii?Q?qgtH?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9033bef-7745-4979-9e96-08dbd6c13614
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:49:12.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvmX8AOKo5OapdBWUI1yVn2GiqmAIm+R5l/b5lGqFUr9d7xDhrF7MYG5hE8yptdh5jZusNcNriAYqVqz7zgM5PeEkbb3yWu7Y6vI1h+IyhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6890
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_004920_802044_B01A62B5 
X-CRM114-Status: GOOD (  18.60  )
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

On Oct 27, 2023 / 12:45, Kanchan Joshi wrote:
> On 10/27/2023 12:36 PM, Shinichiro Kawasaki wrote:
> > On Oct 16, 2023 / 11:35, Kanchan Joshi wrote:
> >> Passthrough has got a hole that can be exploited to cause kernel memor=
y
> >> corruption. This is about making the device do larger DMA into
> >> short meta/data buffer owned by kernel [1].
> >>
> >> As a stopgap measure, disable the support of unprivileged passthrough.
> >>
> >> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverti=
ng
> >> following patches:
> >>
> >> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl h=
andlers with a simple bool")
> >> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitio=
ns")
> >> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passth=
rough")
> >> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Contr=
oller")
> >> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
> >> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands=
")
> >>
> >> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@=
samsung.com/
> >=20
> > This change looks affecting the blktests test case nvme/046. Should we =
adjust
> > the test case for the coarse-granular CAP_SYS_ADMIN checks?
>=20
> Nothing to adjust in the test, as there is no change in the kernel (at=20
> this point). I have made a note to revisit the test if anything changes.

Alright, thanks for the care.

