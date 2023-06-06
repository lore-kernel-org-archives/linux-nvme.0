Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5313C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 05:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjfOAxLv4ZVwGw/YQhN7gALKjG77x26T9XrIjv7QD4U=; b=O4UCfSjrKIZPvv4KpKWNa4RVDW
	jUbITxE3IllRBDKUPVdX5gjpQZd6l5SDnPlbCNzMhp/D6UxsT+55fRSogu2sYVmlHgmaS5YCFg/7j
	FugFU4u8JQRsf8w7/lxyEaL+noFXnoDwFsylp3Mv8SSH/R7dWGDHIkX1/mdCXUjh6UORnxzBn0UQ5
	C+dbd35a+CRUPYcDmVkwg6DIVAB8AzJnSmEttif0E9kzHqZ/O3rJ8Z+VUggo+6Bzn3WVljUN2Nrpx
	Ma/5nkhQ0Lh8w2oMZJE1naIMjqFYfqnbg2GwJVSCQIxy2jPGQI9+S/YQCGOr/MTHYOaKVdpwZ28Uh
	05IIVhWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6PBI-000FVj-0k;
	Tue, 06 Jun 2023 05:24:32 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6PBF-000FUi-0O
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 05:24:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686029069; x=1717565069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vjfOAxLv4ZVwGw/YQhN7gALKjG77x26T9XrIjv7QD4U=;
  b=oETcgLX6kV4ohBRmwCfLHCuVxJxzKMViZ8uevrnXReQPhxmsDPdLP+2w
   8M79ng6dXegccMS++2KrFUsDK7wo9kzIjQiqdDEUj3kCUmk1kyYR/jYfa
   7Ex+22nnCJu9YTbxa2NHYLjoREYMhTF3eMT3SJLcRrIRatpAH3jQaaKXs
   /Sb4vsQfkUNEsv1tLjl2kfwic2TKy44R+qY6Gkuo7GlRpWUcOqHfeInAL
   QfPdsiAVVsPHQU4ZzV4o/7InC3vFl5zBwnGuBdlnV5SezZwGpo+M8y16e
   sCL195EJHLMlgYuoxxyi7N6M1A6sqZuJSdaTpIqY6a4XJx1MREaIeateY
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,219,1681142400"; 
   d="scan'208";a="337138601"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 13:24:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKMLGEb88JxoONsWFbhJYe3cDAP8p8qVENKKDkMTU/MnSgcS09HH8b3WMmNZDqt30ukeJEKpFTrL805soTNeLkMfQmZt+Ys4X42k1TRV3GddT5Lm3Vuy6LpdAhP5ED/1pewEjFPbLaZtFKe8O+AieUhgm52nTzEKsHyF41d3W/9rl0UzGJJqfZFUVRKX3w4mowiNrfZPA3uAiYsSYn5uQajgqz+KRtzA52W+E/hpyhoUk4sf9+FQa80YmH6qLZ926LsHJv/tMNAbrOXVElTJLEcdGEdO2Boq6jWepgXVYh7/9yN2KB4Up0+lYB+3B1XRU1x1nmd+CxzR5D/V9Dc1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjfOAxLv4ZVwGw/YQhN7gALKjG77x26T9XrIjv7QD4U=;
 b=eiHvnJk5X0Cqrgpf2YLCtSG1mKwLDWzBn/gIiPReiXQicTh7H5nM6orc7+4Infj6NM2P8bx20oaWL6JHlLH+6KBp4C97MGfqhdaN9oNaF00ceh3PG0NR40xu6AOe9mhRAeSiIHF41dQsq7MfpvIfB1z7vDTl4WtHl6TBXo3b3Bzec3DKc5eFwy3lSd5IadxszUy9NNQvx8nWqp1CJx8pZNYxZQ2UMhHnYFb6D2ug4cciQo26TOktP5JbaYdCCST+nivgvdIKlE3B5+e6FBBMqs4XGtwD7BPBEIzZ2BX2pHa0rmQxPhoARY4qqndel2W7Z5WRdsaE1v9OiVLAzh8F4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjfOAxLv4ZVwGw/YQhN7gALKjG77x26T9XrIjv7QD4U=;
 b=L0AsDdCdFzDUqS5Ynro33P8MoaGf0IzTEGFbCAxN7/ll14y0WOSto50sYEk6lW3TTKzeFmNcC5M45Y+bjwis5gPvCEIvJCbRf2QsPc2li97EveID1LFV68l9vOF6/hEGMTQz1QQwUlMcSUGqV20RKgDofIp+vKpUYs/E1AFE47g=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6279.namprd04.prod.outlook.com (2603:10b6:a03:1f2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 05:24:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%3]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 05:24:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Thread-Topic: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Thread-Index: AQHZmDclG37kKHjwrE6X3QUWhYKsSQ==
Date: Tue, 6 Jun 2023 05:24:22 +0000
Message-ID: <ffazxcr66mlu2wecsr2tdsd2fugz425gqplu66cczbchub4kwa@j4ug5w37aefz>
References: <20230503083816.18792-1-dwagner@suse.de>
 <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
In-Reply-To: <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6279:EE_
x-ms-office365-filtering-correlation-id: 14bafdfd-b44e-4229-7dba-08db664e493a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Iq3ikC2ntdsJl+dJKMVBZ1U3rFpvwDOXmPLUp8XEj+pYS11FU0+KK/bXmd5jDe3X/F8o7gUT5GUCtmwsaAhMwftE2qh7vBpkkabyS+JeAMHYTnBtpaYFdtBUcMPRRp4BtzAI1VzoKO8ZauypJQdSnBxDHKqimihsb2/zINExiImjknOgqM6R22xyoh5KG5zC0hFBTLMFwoZLvG4lXAN0ue/ql3PRp30SM/ZDRLRYyh//yqyyFBjCxHMtbCUD1Ys23XHk4b3TjL7rwH1ncNpNFIhlmT0r/tywMJzFwXHeNTzprVX9IcjWJcIcWVDzvnzQgD1IprosMXwfPBSTGT5qrnI9nJ2F+9clP70NUaV7kKiP1FbpTWS4GlUdFB+8egGTm7Tny+3zQkpkl+HKfXKRAhpd/zA5aWdE+M43CfWfgdBZl3bg6laBqr9uwLemUs5jFk7SWUStCj7dgsz4QLA9kqOgYI37NFIX9AtZuEzkQQEZJ4qOKXewxlQAdxrr/i21nLxDpxDIAmYSf2qITTdoYFheBBQlwRZKVDeeChk9ty5F02lh23T4N2taVWzPd9vBPH5bzrW2Fz/IFkK26RcZKFPTBClOQO25wsjJhvxZ8DQx1zyBXSfLazVuBaJJmwx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(44832011)(6506007)(26005)(6512007)(9686003)(122000001)(86362001)(33716001)(4744005)(2906002)(186003)(5660300002)(82960400001)(316002)(8936002)(38070700005)(8676002)(41300700001)(64756008)(91956017)(6916009)(76116006)(66446008)(38100700002)(66556008)(66946007)(66476007)(54906003)(4326008)(71200400001)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1xiJdcyO+bzwRJgA+zWOHf1xRhJFW7qHTqE4tUNBFfsZ7hv5X1czIJi1lcMl?=
 =?us-ascii?Q?dl4kkSNb4UvtsAbsiLFaSflTxDy3lC6SBCoOreOjKUHygFEKCo/fhmq3qexX?=
 =?us-ascii?Q?/IBrOegv0gvsrZ9nqxDDz526yeJhMEHhHU8qz+8cgIQ/Ac6wwUEfJo64vyds?=
 =?us-ascii?Q?xN/JpiY3Vyw4p+l48qf0aHMTnJhDVq7Zk98uie0FTp7cqTy5ognuoLkAI8mD?=
 =?us-ascii?Q?ARTb9l4wzh4EdhXxS7jOWIhoerXTsi2QipurLf5V8qrqGGs9FYyVkcMdLLI9?=
 =?us-ascii?Q?lCGBAAt+UihdeXt6ZcQ3CrC/Ox+Olwq2l9KmKqkYZBay/eA1ekDXEwdPMMl3?=
 =?us-ascii?Q?VpRUP3IVUq2lwRHD73vr75CeQgcvFk4uQMpGxOXq0i6TNlm3B7B5XF9nnNKc?=
 =?us-ascii?Q?neER9LOmGk99eiFP9WlC5s3s98NPCmtMsLKuXwxk2GirO51jKB4t8tjHMEai?=
 =?us-ascii?Q?1OtzF5jbSqM6wbcVp8WlhQ5ib4b/aqJwv0XaPAHFMGCmWyVOEb2Kat5ms9Dz?=
 =?us-ascii?Q?CTKJ3G6Ug67eZluwYlDpqMxlWTpWEInvHMuuyaHiBsEP2Xivi3EAZu2HA5s5?=
 =?us-ascii?Q?A2HNLneP89PriiXQewbgbEfly1yH0NPWA7OiPGnn4jZnY4BxEVKoWfoKRkEV?=
 =?us-ascii?Q?SMNAMGZMK5gIDAfW6OIoCc7FKq5XJj3WvK8yt9/W4lhnIbkpTKv9tnOQIQde?=
 =?us-ascii?Q?XHXnFSCUwlCSueOG2P1T/UyPOePWlg+YACuWYFyh+9MoTr/UYLqurkxRX1SG?=
 =?us-ascii?Q?9VB2iMUHoA1/5Wsx0KSF8QquyXJ7ilGYveyydujJ/TDDmGuUetcdPpyPZcxV?=
 =?us-ascii?Q?M+lX7f+9yu8IlIF4GgcJypixttGHCwA34uxKEZv/Kr8nQo2+tKOppy0DFub+?=
 =?us-ascii?Q?G5o2WHlcC5elzTyMW3sDm9xh8UhX6hIbABYJxIRQwrz9xF7GDelCxgv05WDv?=
 =?us-ascii?Q?PigaGyXGbBTS33wa1xBLt/visSpCB6gcllLtSsRJ/1TKBLIOmirIsQGqRKCe?=
 =?us-ascii?Q?l5RrWtRHiOWEQfmCTD6YjzS61NYQ/mg6D8vES8srwPcwiIj117DaAuQVBzxi?=
 =?us-ascii?Q?F7v1CS68pqJLVk583esWqPBWSwCZEa5NSPmuZi+WcYheb3n+iGVFTexfbeZk?=
 =?us-ascii?Q?Q1ndc1JZghKMX7LSTsSH5pAkCQLUf82DtqrjCPj0LIe4uhF/NRvPad/pn3Vx?=
 =?us-ascii?Q?01MHfX5cpPZQ7fpn4DQGH8Q29lbpmQ3UaxHR3mWh0aRwnbQtwGoXU+8RGtxp?=
 =?us-ascii?Q?WryL60/X2E1SDPn5K1LavdNxQWM+xBeitKgur0i9Z3A9EwW6FSR10BikRyIN?=
 =?us-ascii?Q?ceRslV7/PR4aSrklugid3o8QZXUUGk9Xr+sL4rXZbbt0wAXKGAzGY9u+1w1H?=
 =?us-ascii?Q?soSVm0/SRjB68vImqz3cyLcCEGDBSzESkfXvwdfZBbdzbbb5VdHWxg6SYZcV?=
 =?us-ascii?Q?S6tApUCCv4lL3huQN5darNyVBIueKzqlBXXGW09CVbu0+MBvKRquuxIgozP9?=
 =?us-ascii?Q?X80vL8qQ8x+5pdNO1sX8Rz237vs37SL4Io8CAI23cxxOyNM/SGgh95Qp7QiA?=
 =?us-ascii?Q?RWL78dzMsGlzTK88JnVh4OxwsTpBq2jBT8MkThTs/Lq5JYM9JwRkZpIm2x6d?=
 =?us-ascii?Q?qvc0y70jarGlLRRNmhPv6sU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18B5DA186D51FD40BBB7B5DE63808793@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Te7RJxnoR6r5layxDh3fA2MZwTeHU8EvL4EFnsQ2fpuJcenPnC3yFsYCxCPf?=
 =?us-ascii?Q?q97jCAindyvVHYz7MRAUHKstvf9DorXxHPcVxq9ck7dOC+CuRBrbcb+8AikT?=
 =?us-ascii?Q?noVKsrUsyNDZKZeZIJMdmIQc8Gg5/1fc2KeJqfOIluWTnSpVAaEVezRMmOzJ?=
 =?us-ascii?Q?8zuka2vllHDSVPcv+1rzbbbD6cfAGnk+qn1Sorq656FM/vj96wMzQHuVY34C?=
 =?us-ascii?Q?V0ks3swOb0ilbyThGPMkuN1FxYRRoUcHzi7/MIj4xQez7bOMbLjWL5kZJMJl?=
 =?us-ascii?Q?q8hkRkKaptxcPaKqNEVTLhHBnDuCOupn4DLVoem/CJXU1+6zykCqLWtRMGoQ?=
 =?us-ascii?Q?kAZ3joM3JrS2/vZyoYJANkqB4cTiu2WD3P1BAQ6b97dL9rqlbc8FPz5Hlv78?=
 =?us-ascii?Q?y5nDto/FYZRbTHlK1fZ5wdF9DYkg9g54l+kN64yy097A+COh/fytImFtUvQh?=
 =?us-ascii?Q?BfDx0LJQD+hB7Oega08gEhGeEsdrqmd3HsRsn0LfrJoTob61gmcyIETtDXxR?=
 =?us-ascii?Q?tThTLmE3yDTx7yIuQny1V8oasLdu0t+GeFG+QA3DKOgnJZRplBFZHMvnebpU?=
 =?us-ascii?Q?9AQocS6fPu4aKCKSo6NUzlLHO6l2NPNha9IYW6POiIJXBaO6jpDTi5eBkhix?=
 =?us-ascii?Q?wmYoMoXAZx9WuAQXPC02Rsl2SZnWyGmsmU+y/tEIi6ZbUiBKH1TYCtw4UTBF?=
 =?us-ascii?Q?k1od3JSYz58rreIFOXQYGo3kLqi5/B06/SXvBAlXOIJxeWWG22E6kacdrrav?=
 =?us-ascii?Q?MpBsPei0d/oMqbHaVS4VyMMDgZEHl8SLz4Mr3V06/tkgEH4jIVcO81AGykLe?=
 =?us-ascii?Q?KJsL+7fIKDJWPvdxge/GqGjRulQesPHgOxhaGNmrw+KgI/BO/yvZ7tQGE5rF?=
 =?us-ascii?Q?zow7/Z7gQX9SlGReBczPFbt8/GSKJA0Og9KMIHu21/ZBgLKkf3Wm2NGXIpqM?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bafdfd-b44e-4229-7dba-08db664e493a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 05:24:22.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4eFUAi6X5LJDbNyYs5UL+LvFDO++YMnILovg39hjxkuD4M5PwvDFPIT+U2dqMYSZpt86zA5odxts027nd3HIG3zjGGGNO1vkVqzj5k9jeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6279
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_222429_219125_32E4ED23 
X-CRM114-Status: GOOD (  10.98  )
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

On Jun 01, 2023 / 11:01, Daniel Wagner wrote:
> These patches are necessary to get to get the FC transport off the ground=
. At
> least with those applied, blktests should be in shape and only the kernel=
 part
> needs to be addressed from then one.

Sorry, I missed this v3 post. I've just applied them. Thanks!

