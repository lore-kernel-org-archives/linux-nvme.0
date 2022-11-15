Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6897C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XOulur7GwXWyUFIejoVsmaURisqhxCWAk5qA+fSPAYI=; b=hySUGOFMO1SHsUuVmDjYPzVGVu
	Jx3dCrYd/2/dfbEE61c8u8H0CpgDFPvgsF/avw7vReS1Qqa+8dHTwLES2jEyUHtJ3uJ2S69+74PEs
	PtgsYFYtp9kTJycJr/ILauu8V4VVRXzdZhXKUGo/71I+7XH+invfZoyIsfr+hg5QOYbtbWCKwXe1M
	zOwA9AOgkFHyELgx6n0AwSv0/eWH9AEH7dzAZgOV2+LbEvtwXEfCbyp7xr48CGynGf0Vw6NFMbkXw
	ot2JuJ0wkbbbgvrpO+xM8ofvaNfzi76ROt+VAiRB3TJriXUM9QPbIm1tEjQ9LyrQLjDyipvQP7CYb
	ykM8XOJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1outjk-00AIki-Bm; Tue, 15 Nov 2022 11:04:16 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1outgs-00AGo4-N3
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 11:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668510078; x=1700046078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=afKhUiXCct99S8bqniI7FNXG9m3rgCFhIvgUlun54f0=;
  b=dcR2bpu4yPNIHDTzh9FHZZMkYbKmG6Pex9z1iq9vBP9uB8X+v3zaDdPg
   ObcIIZdY7jPRPo6DWaxjrB+7utqfkPFBPt+QPdpZ6YKqqrIawb+VQ/qCx
   3zUie5Ktk8Iv6Bc5TCdTbS7LVG3rvv0+GQvTg0MYrT2caHH1ez8LT1YNa
   i7QxsaNx7nlgceZeCyS82MoPziNlqr1ogd82nES9GTC7zT63rAX2iplpz
   zHDRcPKXqCix5QUsKf2yyZh6aqwvg8UZYqBAYjnXhcQ4KjdcW1G3O6t/C
   aOjeFFFC+V7wTXdiAFJFpX3U6z8+b9kJHcJKBsBQBf8vJmsXZPji+GcFo
   A==;
X-IronPort-AV: E=Sophos;i="5.96,165,1665417600"; 
   d="scan'208";a="216310367"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 19:01:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzHLZD0ZU0XVimEGTtBV96Y5ciUcknh/x3MrSxLMoxu8u7So+h0YTUKjTGFZ8aur05aZCerc6UfbkQGunDWaUuQam/kbPFcFS/ftIl5zBdvDIYX5PEtBakwiOlt0VyQZERkhWYAe31WUEIZp6mYictj4vtXAFga9x9fdSBjg4681mZ0PZWO27jf1oZec1zo/I9sd6rgnyi4u2B/4EeIxtQc+R+4QpVOn2HvAIbqtPvQRx60VR17VwyhbvXeo0Y02M+9fn+epACyZyBQo9xYsfAuP8lF0rpPB9F1euVrQXOhyprYuwu9dbyxGajKlfA3ZWJyIjjgSALJFWnS2raiH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOulur7GwXWyUFIejoVsmaURisqhxCWAk5qA+fSPAYI=;
 b=CzPD7Ep72g3JVG4VfcZIlc109ABhvjpfhak8bR2t3VSgLXPO1rJL/XD7YCVM9tUzlYps8RUMGQUGK47QnkakGJ8WBi3fcVcZqzheTtEoyUA4V38mSAvWiD1r/MpHAUVUtFdc1OMo0At376BLf3NPlIPVA3utZsBxNZHUbep2u8AhahVBMkFL5Hq2JVGU6XnRVZoMYEs11zDlfSK6bhL43x3pux1eH09usCQStt6vZDsFtoWJMQG8pBf575PyDrt7V/WFwvFpdotEjFJ9XPuP95WyrZR7yV5AP+1rFkUFzw0cpByhVdNqv+iLAqqRYOPvHuO7iLjxabLhQdBeiBEK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOulur7GwXWyUFIejoVsmaURisqhxCWAk5qA+fSPAYI=;
 b=pIrGuztvrvkPwwDkOJk/SbUrM7Tp05IepkQ0+5PSF2+pMlSqHNB5mc3OHz4RduTmw1V91koUx9sSCtCjIhP5u/algWQVYKnKLRS5yJdRNO7GD8uhMUgTCXILR8mIbvrtWs6odQhirNcggrLyoLCUyN3WEwYGWsyNAG82f8Jn2DQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 11:01:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%6]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 11:01:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Thread-Topic: [PATCH] tests/nvme: Add admin-passthru+reset race test
Thread-Index: AQHY+GifxjRLmZpCbEexexZ/mmEJda4/rYZPgAAkxAA=
Date: Tue, 15 Nov 2022 11:01:06 +0000
Message-ID: <20221115110104.roj72am4kbksyxks@shindev>
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
 <bb0cec9a-693e-8fd9-b521-8c23a7ff2ce5@nvidia.com>
 <bcf1c16d-e822-8fbd-50b3-7224465589d0@linux.dev>
In-Reply-To: <bcf1c16d-e822-8fbd-50b3-7224465589d0@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7843:EE_
x-ms-office365-filtering-correlation-id: d3d58230-761c-4668-a23f-08dac6f8b1b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  JzfXNeeIZN29ROr98mi1TyszbSsbnXRJgS71ogNRz9nwkg1Xp0II0fU1p9c4nOtkAki9bvVJebMltxil3TDSJLXu9XzvB9Iw+TBlsBwhonunQ6uSyqLfZyGQEDokagWpqfNr6EFSWZSxJfhpdR4I2+24v7I4evUPP0SCrwDDLDFKO073bT9vALsdYyQRSo/tVGeuwPdfNRLq5vwUc6KAvGwBgX1MUhSNqnAgwGhACACg1sdnzYmyXShWef1nOADI+cXUHjF4Yb3LlDIqavYhanzplKU3SI2Iy/0ceTkE3FzUzvZDALisj8EvMCDgeb20JjWYilMChBEZ/35CyxwxD1NIKGLbqoxgjIIUlxJfgoKE6TBskqdtPgpvOKnJ5OPIms6Gbr+S+LCb9D3eVuWmuDM4/gBaaLN2VKKYBYkoo9dWzwOmjFi+mvpJtYgk6QBa7iFUhO8RRDThJQegk2w+GbIW3iEmpuyV3l1LCGRsPJ7J5Nx6RipXY044st1d7wn91ylL2xf2lCGUhXWss5CF5oL1ojia/RpjOedUci/+fGYXJhfEqDt0S5DZFi0Zn84gX12BxhtAqqNLGa0XTbbdf6slJVvsCzf287s64wmFO2tVLV9uveb08WZHz6//hsWekvvNlrR/YUWJVWZEFhzHe+b3mNFAJoCciEtkC+4ikrSleArrimdluJZXjLdwcNOEJMifBliZmAbA32q11UgK3BwB5kI52SxcbyloZ7t4/r2TDW666dSv3W4wbkKOcY1u+LPHP09IERRO4GPBQ5K6jX2rcL4t+QqLTVHsnEHR3xc=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(8936002)(38070700005)(478600001)(6486002)(966005)(2906002)(5660300002)(122000001)(54906003)(316002)(6916009)(71200400001)(86362001)(64756008)(82960400001)(66446008)(66476007)(33716001)(186003)(66946007)(41300700001)(66556008)(76116006)(6512007)(4326008)(91956017)(26005)(9686003)(8676002)(83380400001)(53546011)(38100700002)(44832011)(1076003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?+lo7wGSVXh47I1Ti/4MU7ig1wXg7CW7AdD54u5ogpQu+AaDKydctUMq4hm+K?=
 =?us-ascii?Q?yDgBqYuNiXni9VWS3w1vBijqZyesEyc6l3S41WRvePnx8X7rjgwvZTDAD3Xi?=
 =?us-ascii?Q?8C1CKcJWKBSpYtp8LeDCWkJjwK4Y7S8XJNHLC0Vamdnl8+lmaxrPNsNWPUqW?=
 =?us-ascii?Q?RBO07tbCDCF7wLACtmVx4xq2+0/ojot4s25Iyapi5xEd9tvAzW9b303XOipu?=
 =?us-ascii?Q?6INTJI+ibTcxOHjzJ+n4PL/7z2Pi7ajqcnUD1YPpYB1juGhfF6AC0KGYkIGf?=
 =?us-ascii?Q?wnpeG+LM+ee14/8WOzhWjDMwvghI4YnkXkzRsApCyUGg28zLRkGhg/PZxZDh?=
 =?us-ascii?Q?3lAl1gqVRRKlf2lG44sDs/jXCbldjTHzUTEDxvXFAeZBq2YqmqpLrA7Ln6SF?=
 =?us-ascii?Q?Y2cJhZ1MoF5Tz/dCvc7aqxamQWUcq/H5/D6gxyWOzoWm+ku7imKExhlYdyjI?=
 =?us-ascii?Q?zEqA795ydkvoNu1YvMttImKhtaXasjkwXZQTTowmbv3eigDoGK9KdAmVZ/sE?=
 =?us-ascii?Q?VZS8oPIBDX3APM/yqC/2JM52d88GpdDtivakPNibMAkADzs4r5B5yg7NGfrA?=
 =?us-ascii?Q?wOmSYsYsI+Zz2Iad3wdTBBkuK5ryiZ2Rv9EhrAlh51upmMswRIq3TXrvYNgk?=
 =?us-ascii?Q?8I945FbgIY4bi6qriCuZuusqgf22yAPmRjKXgT4KHp+C13NRO2vZ2aEyfR+k?=
 =?us-ascii?Q?LqQlj8uTP3mIKSkNao36Z0m4BYhCsUvwgQYFWpCLCTWBFKgnmE6OLsB0rS+W?=
 =?us-ascii?Q?ZdKrHGefjrNVcoRs7rg9xTbKqrGScrG2Of4yND1uq/FImZeKiZ2HBOPUFL2t?=
 =?us-ascii?Q?1gr5WfE7au62XDGviEXO3Utzor3MbVpnteVJXJATXIDpQQDeJXiCJfcD2qa9?=
 =?us-ascii?Q?jENIkwqb1ygPu3sWzeWLdu578qUGGkN6uk+yrAoTvaQZlxGt3iYpfAw6nd4b?=
 =?us-ascii?Q?5J0jJCIc6oWvpPStr9AgH+nE3dbCd2J+dyp5ZKafecohVibeEQtMBJRDtP5j?=
 =?us-ascii?Q?JMOHywCs4l+4rIsqeZRBIOKCviR1cntndGpO4mIF3VQyrZ3mh6IuJQG96K9G?=
 =?us-ascii?Q?yDgRMnrhEB/YjBEsAy7mIOa28EF0GGV6gK5lSqT4zJ4JuugD1t7tnaCHHRT0?=
 =?us-ascii?Q?k7mOL8UZ+IfDa521QEradwyBO+/tGjOKig34NPEsvMusvqC2c2Vqlw76mBfZ?=
 =?us-ascii?Q?1FXLf4NiY8SVmsCX/rktxu8zXv8+0XjG99ij3Yxexe3pqoWsaB1Nd1eFZdDu?=
 =?us-ascii?Q?NrhgvU5Gxb4dqTzZOr3HgUiN0NX6/1MHS1v8Sio7qROAm1pD1L/m0OtBaxX1?=
 =?us-ascii?Q?LkgnjdVEtKX8tgkoVroZQdVx2g8vDjNZEDHr1aTFJlFPCAHtYFgWb0QZQ+tH?=
 =?us-ascii?Q?tAkloxdOCIMA6vScHDx3ay+1z/InYeJGtxdcKoT6G8mjMrbJMAvxSSyVvTxS?=
 =?us-ascii?Q?0g3gCFI9YOHuPNE0BsqXrO6na+8zd4p1EeKlHIdB1eXNz0v52B1AMkfFwilx?=
 =?us-ascii?Q?u5eXnimpqFh3QIsG0zyJbksX2eSWe4N86XWKV5kPqb2VE+h5+hq8ybe47G49?=
 =?us-ascii?Q?A+G0dyIUGIkWwyR/LTl+9gxIU0edlETdFl3nFmY2DyRaV80CBAIy6l7bkrJe?=
 =?us-ascii?Q?zu1hJJR4XOMAYLlCvzS067A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E73D6052C7E6284BBC2CC0A93077540D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	ICFBOqAkt9S6yCF5Gt57Mz49gg/F3HSAUxcU0fKhNt72RaMY8RLSuSNeQheWN1lLRI9uzoR+UifFcUP6TZK8f6zLGmE9YbaGQ40lvUgf/fr0T+yfJzCIyXHKP5ijhIO0DNr3GaLIptTWRkrte+cj+7aNCY8U859c5qUBGpucmiRInNw5tWFp5+ffKAfHOs533D1gcbSpQPGotduiibaQuCIX3IakNTh45XjGotBVWSwmmWRP37UNhIEd5zZtcvzsH/7zRGboJ0liNqNB/k6mpvqfqwCknp/X2LfbZCtP49BLzcCQzr57/NM1Xp2D+J+5Q3hK/HRugmcusUe4q3TU8Kw3Qj6vVCX+P39lKSpbn67rKARZJwoXaMJU8R5U2RH+nDKayAV/Ak4xg3hzPKdoNwKXGMH6jyTJKt6DaVPwB0WGjw5Zqcp7e9kE9WiTSaKOPNp8MUBG1iF7B0uinVhtMShwdj3ZksXk0NXoTBddEhOhJ8wzdon56NsyHQz2EJcOSWG7V0yQaY8syjpQPUMpHjW02HEKCbxk5e+P5tBHmUt2x7ZXiXeHXU/WLQpXslu8DM3M/5sgy6fyvFCruGFf2hYtUXpb3NW8vnCRysyya3U+/a/GFeeUUC4znuUIX+1/JfGSV+T+V32IIErTnAdNnjrZ3eoL/dtrazGWsxgA2u1M8RJ700LDBrL6QY4OeYxPi7XN4+f0CDrJGGgk8xlGaRlOKhIBkMFYzJqYh+bIE4wc+U52nLxsbWPe+MbHtJ45lezRsWPgnEJinDp2WsBWZED9gVbOWRV/FiKcQivC1WCwISTqP8+1XN+KWRgyMgqLWBWQyNZFgSqJfoBXK1thdrhqKubVbAVsr87E3i7xL7Q=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d58230-761c-4668-a23f-08dac6f8b1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 11:01:06.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnSfTqunw0YZu33T9k+Q7g4T8LYFnX3rXh95hy8AoHbNh1DDc3FLe9ta8SOD3Nn4PCrCQQRvPOZUNwp6p4+U1dTq3zv/zXTfP4KJo1GpPLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_030119_018290_DA45982F 
X-CRM114-Status: GOOD (  18.79  )
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

On Nov 15, 2022 / 01:49, Jonathan Derrick wrote:
>=20
>=20
> On 11/14/2022 5:25 PM, Chaitanya Kulkarni wrote:
> > On 11/14/22 12:34, Jonathan Derrick wrote:
> >> Adds a test which runs many formats and reset_controllers in parallel.
> >> The intent is to expose timing holes in the controller state machine
> >> which will lead to hung task timing and the controller becoming
> >> unavailable.
> >>
> >> Reported by https://bugzilla.kernel.org/show_bug.cgi?id=3D216354
> >>
> >> Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> >> ---
> >=20
> > Thanks a lot for submitting this, it is really useful...
> >=20
> > Overall it looks good.
> >=20
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> >=20
> > -ck
> >=20
>=20
> Thanks
> I have v2 coming with a bit more robustness, so let's not merge this one =
just yet

This test case looks valuable. Thanks. When you post v2, would you mind
renumbering the test case from nvme/046 to nvme/047? Another new test case =
of
the nvme test group was posted [1]. Also, your check with "make check" comm=
and
will be appreciated. Shellcheck has some complaints:

$ make check
shellcheck -x -e SC2119 -f gcc check new common/* \
        tests/*/rc tests/*/[0-9]*[0-9]
tests/nvme/046:31:8: warning: attr appears unused. Verify use (or export if=
 used externally). [SC2034]
tests/nvme/046:54:23: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/046:57:12: note: $/${} is unnecessary on arithmetic variables. [=
SC2004]
tests/nvme/046:57:23: note: $/${} is unnecessary on arithmetic variables. [=
SC2004]
tests/nvme/046:80:38: note: $/${} is unnecessary on arithmetic variables. [=
SC2004]
tests/nvme/046:80:49: note: $/${} is unnecessary on arithmetic variables. [=
SC2004]
make: *** [Makefile:21: check] Error 1


[1] https://lore.kernel.org/linux-nvme/20221114125252.1086763-1-sagi@grimbe=
rg.me/

--=20
Shin'ichiro Kawasaki=

