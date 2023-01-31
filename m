Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF15CC636CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12O/XBFlmTCzpvXJxOAXHtrdw5UT8D3iyF58ssYG0Hg=; b=ztzPWlSV5Fb8vyCUQfB1mgs/xx
	IZ1CSNIWAcXjrTbxvlGcwcrlpEdLinSJQy7w1Np7Cv/jKJy2mFTLIxeP1yUar5tWdWRfqpYtjGrGJ
	ahs+Y2YrwjS/0gis8gyOxXquSU6aUyDkgI4XXCfQEx8GJjO0WQn2D9UGeywqyvRLSUfgxD/3ngQT7
	mMoXOACc/GS/MPedDC2y3aiLwEZJi/bTZUVS4rigLbUWjaYhXDp25ucfs4+tI3Ylq3oJRvej/qrI1
	9DgJ1YmM4PTg68xA5GN/TsKQgGAkW3OIQSopmB3UqphsM++B1KhEB7JlVgchgTj/vn+9GD41w5xX8
	ia5OFWKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmrt-006y2y-EL; Tue, 31 Jan 2023 09:23:57 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmrl-006y0p-Nn
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 09:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675157029; x=1706693029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=12O/XBFlmTCzpvXJxOAXHtrdw5UT8D3iyF58ssYG0Hg=;
  b=GssQLAD66yCalLUtHqIfvOqYTiIJbKHJlToNwKniBZK6FuslTcbOschh
   MQ4seXM6nsCBLkFRVgJtrbF29t3tbv4nM9Xkuml+wNIoCgRcEkoVyXTFH
   6aBXEuja+zsmAODNxj3OnPM3i0eAHV5X4AmZQoOOtun/F108INORsLCTd
   7k0+q/4bs7AkPWLPqF9qOP/XttXxP8/NLZRqgaYj18uqce+O2PhGX9rK+
   9fSOf9PkYScxM/aAg7aV7GMmm2vbSxUVLA0KeJyeGb6wmBe+8puq+QTei
   kfDliTebySXxterEyOYljR6LWRL0w1GJDumAhF5YbQ+/zjRfyqnnplqs6
   g==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="326451823"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 17:23:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdFWq2xqA4XhONX2YnJ2mRK1gFvBhYdCZWj3BSLcG1lJ46j4LUyajerrOqhf+DTOnqIB2fonZrvY8pctpDSSeZPBCz939wofU5VmtCKGp2XIPpGDP2mEgUp094KaFIucROMA0dI02iVKfh97YtcCCHbexlX9o5zgbiYC13i6veUbp1v5xhVKzwVCXAi35DqvF/brqwZTQQf/AaBA9+E8Z4EsXZcDjOXUQxo/RN8KbZNsbE9LpA65LGii66GbBQWGSM+Lgtc80l8KwKcQedVdjO32bmAnKLyp+yZX6N20EjmBpBLyVnjs388LEM6w+bvSPWxuMgFgi2BvdJ6oOGjp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12O/XBFlmTCzpvXJxOAXHtrdw5UT8D3iyF58ssYG0Hg=;
 b=fgQnZ0Hus7GxP8/98hCugXsbdpQ+f6M5tW2hOtjy7PSO687fLLftPpRFunT38Du8qmdOT7kL2QVNtVynzrnVisKcvKzzin5vfm8DqGOQ9rk0VOZYOr9X4pvwmuRNP1+qF3S8uNldJmZ4SYr3UEZHDZrq9xHDaXiBcO10476WJ0u7pwBShpkYXRROuV29u9ATnsuwlehUok/CQ2WVvn4C2CP8qws3ybrydxBZYX38yQjLtzgUE2V8ywXxSL3ntHg6NdVZnUOu1XR4cxmmchgp82TozqD+5XuBHzicmHP+3D/O0IDYVJZQjHeHNAd1yF3zhLQ8kGOraqahUs2p4iJHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12O/XBFlmTCzpvXJxOAXHtrdw5UT8D3iyF58ssYG0Hg=;
 b=Ikw/PvzTG/M+lafO6cIdFVkVfBKgEVCUfGoA2LRjXhlHZrXdygazQyWoXjgOiB3xhxBP1S0IPcKvCxo9Khqx8AdfvNS9f5Joz6RmcBKlyQjx2qsAO+3OcKj6tMwBDz1nehE5jgVRC7EvunlQLck7MajpElvE+Him2i084Se/wOg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7137.namprd04.prod.outlook.com (2603:10b6:303:66::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Tue, 31 Jan 2023 09:23:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%8]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 09:23:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-6.3: blktests nvme/45 lockdep warning
Thread-Topic: nvme-6.3: blktests nvme/45 lockdep warning
Thread-Index: AQHZNJsoi35TVtYSa0u5/gPPM5qM3q64QjOA
Date: Tue, 31 Jan 2023 09:23:42 +0000
Message-ID: <20230131092341.lo6sltkk6yuqhtqq@shindev>
References: <20230130110802.paafkiipmitwtnwr@carbon.lan>
In-Reply-To: <20230130110802.paafkiipmitwtnwr@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7137:EE_
x-ms-office365-filtering-correlation-id: 9a2dd3eb-6b5c-4604-40a8-08db036cd866
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  JJwxX941g04zxv3IWfnHP2Vd5SA5D9Doy4ssGs8JY0shIpN2XflgNYuVqZKpfurS4Xq/s++3cib83pqCOtXi3GThhUEY0oi/02xKs51YuQkLEvP2k3zPOCl95hNlad6Nr+/x1VQcvmgbB7dMh3vw4hV+9mBelfRN7NSWnarq34M8lYnFbz/pZjBit64iwkuPvsxtTBnNmWOGo327yudwIZZuzYIgqT3PqN/twW0n1KGiakTqWob3d69yNiiDi4Zkiw9tdLeqmm5ssSFE04xd6yWF741jw9GuTZsagvJuwyaBkisjc7rmNPwbvg2Y4agRhddNKsSNUIjPMLiDHfBzAzDl8JHqU+RCQEyou9NHLFn7DuffhSE+FfdSvLoLtG2vCWtIk3RaIsWPpLwvihXCExjNDgPeWVSsmsY6YpRqmrfK7thxl0WEHZRXhSsXB9nBlVF2oKd5TW64rQdid9LL/dN7qgPt2mtBiXbZMCa/h+ddkEWHrNWGaK82JZZ8eqgZs0PNI8pvaHlWC+J99DfHt8sJPNiOIfP76suoSZXaVnv5zP/yl/OQpg1YUCRNynZC72lYVRiAOaZPO2DpbuaB3dIKnfgOJBGEB3DUmfDkQ4+qZy8ERBiBxH8FVHO1DXnCEiS/01boKplrxL9e6XA04+oPz6OsspxlMsZ5Uz+VfhaH5EoFLFwaymQA9JzvEXUa4QHsgk0xdxsq8Sh8eanOpokHhx2H8JT3wSTu60qr7hU=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199018)(33716001)(2906002)(66556008)(83380400001)(5660300002)(66446008)(41300700001)(8936002)(44832011)(122000001)(6512007)(26005)(9686003)(6506007)(966005)(1076003)(186003)(38070700005)(82960400001)(4326008)(76116006)(86362001)(38100700002)(66476007)(8676002)(91956017)(316002)(478600001)(66946007)(64756008)(71200400001)(6916009)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?oqN0wiB8dLWghZzbUovIwhzw3hPZuKTGlQbEiMGt4nY+3CutlKg1UkbcV35f?=
 =?us-ascii?Q?Trk/O50l/lz7TTxhYExgkbldQ5SC09Ol0+o9z7Cy4XAax+4RG+QsqghAaSEU?=
 =?us-ascii?Q?0Vm/bHvR3ktiusLCnLFYmDw9J6n7JflPf88VOWC6GgppiBHkSELSnZY58das?=
 =?us-ascii?Q?0Si7JsUxNowQtWbtIxaQyVoX1rJQNGQptPrI1PIG7ukhK/aNvJCkC3vmY8no?=
 =?us-ascii?Q?dROT4uuFUHl3IpvcgmRYRJabvWjPmqEYRievnI6PR7xUbydxTuhTkXp3j0u1?=
 =?us-ascii?Q?K+iCo5dlT1XTAGSXuMFN1aUt4L9fmvAhmJtrpJYv70De0JFgKIBg3xEdHYux?=
 =?us-ascii?Q?8fYrgdbMWqXphAL5oiMsY5Te/C36j5VW1mhnwhpqzbOfgFG+GMqqL0XnbQnG?=
 =?us-ascii?Q?Ps8f3DHU/8V6DUep9Eb9YYg12xtQOeBWYRI6GU/kb7TcdDs4mrVPoKOxNmdJ?=
 =?us-ascii?Q?bqYHPu2e890aF5/DUqevm+gnF/O5LqSWJb/K3kamThO0k76hIhg/RjzCXBoo?=
 =?us-ascii?Q?WQ9ZMY1IXyMds5TT0si4Cwv/dD4xve39QvGN/FqlU+wkfVKE19ux0ixi5IRy?=
 =?us-ascii?Q?16UCG+23PS5coLK7uGpaFXgpNy9TVq8C1iqavJclQ2VbAMeWpnkdOBwvjTHM?=
 =?us-ascii?Q?7WrQdFBNkcZkn4HWnmoe/9sy38HtrP55NrHnb+07IImg5L2TFSEUZYpJxVAV?=
 =?us-ascii?Q?cIzWn8Op/cG82TyioLnLq3DIxok0tPwROfINJSuV68+RYK5DRxYYRayGnl13?=
 =?us-ascii?Q?6vHEHe3dmZEiRiFX5v2Wd6b2S8WoVY44C2AdMy0BObgjO1byZTksbC5j4i6t?=
 =?us-ascii?Q?nnq2IND1CfTGiunXUg3ENb5WVOSPhi7j1U4Wa5pSiq5AoUdYkbu9UyuKNCQe?=
 =?us-ascii?Q?g9B0pGibgdG7e7vMPwD32xeu2rRTzWCYXnJhwO0TFGNeS4yfsDWkr2G2O++1?=
 =?us-ascii?Q?SJ9CclEPIEgUYWyAvSuAsgZvw4z7Pj426afXzTYbTJ8oF8DwsHC3KiAS70QU?=
 =?us-ascii?Q?C2kvUQmAkagjyzIcfl+qvrAjgYYILzwRFG7ugSxkyjwsNQBtXmO8DqerWSkb?=
 =?us-ascii?Q?c+oPIAjK2AYnneu3ZwZn3Z35Ny+3OtCLfAPWSiGkSBWUXV994MluL1IOsM67?=
 =?us-ascii?Q?HeC4qG0YZKk7g+vqz2LMSzee3fKlgA42j6S+/zZ4jpKip36t6f97PAfLo2z/?=
 =?us-ascii?Q?9MSXrRhCh645HlftmN9exO4+Tkj9jJVfib2ZvsV7YPY+HW5wvKCNPpCDd7ZP?=
 =?us-ascii?Q?SJCq6OjVcTyO+8Z4xnZCPqq6ZpzAfdGWO6Pxc4QL2l3bDuf514hfpvKdvfJ2?=
 =?us-ascii?Q?tkmIq+FXBQeHQBJ9CpxvoD1fgIybn8S7Hbtw3oviklEbFneseGe2eL74pcn6?=
 =?us-ascii?Q?Up3OUHdHIMw2pVobli0QalHLxERQyjibmLOh0Fu7+sRMqcHuvS/Bqx2cy58/?=
 =?us-ascii?Q?NND98Fu7FjNiuj5ploAlmyAS0Nm3GQvyN2nzSc+Pp4XOV+RLrJuEXP6e69AK?=
 =?us-ascii?Q?HeiEK6AhRjs/MEC8Gpkg6wVFbqjXiukrOMWJR9e2a3kac9EJoFXNiqaAsysh?=
 =?us-ascii?Q?axXLVuebJ754n8dQPDcUByUy+wEQUlvsPcsrojm7tApAQ5evozijOIshY54v?=
 =?us-ascii?Q?wAKrCZQui2yLL5XFrlmDJCM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF478D411A26714C9891BD30E414CE0F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	Iy3JvkzWIfBoZvFmnQL4Im+Yx1p1ofhY1HWrX3rJBqlDAmTR+jVg/CjLHPPhtXD0Ebnu4CLI9DOuOEn0m5KKvwVE8E4rBP/ykMog2wJX9k+6aYiD6iDnGNrhS9XAbcEdAd7NybTCWzcLDJMliPdGvUYxI3jugOlqXu0XrHDL1kjBuaWpraSEfYk1FaZmGHnMvAmtK6LJnZzLjIaVHd5bsUGKoeIn+xYqeMggNrpzbjPKcEkFpeAhUdIa3lQhRPoJExPQVarK1sh1ExSfn4pJhCyucSqcpNpx37FolTqXeBND2Q4Yrvx4khOMzadmsLUx7nU0LMQjV7UFsP8kqc7OpRigor1bNaU+DsfojhxkUg3/jLTXxx6CBlo4nbNZpt7whRxqmar90xL0cr82g/xFQlv4gbj7a1UuyVowRI3AD9t7/IGybFlsu7kH1uxWMp3sRt6xBz5xJD67YJ5CzC47O6p3ugFBiBasg563tPsuO/TObmWbxAyOr+JFGiXQR4UY3JZZqVh+TcY4sdhdCNvsEtefKSoxq9gAssB5DWkTDK5jKnIxuvKt23sAZMizdFZJEiaFF8FqsuFgK1tCS3dMr4NxIE6vXob7xCSk/LO7mzg1ZQnI0jNMHPX4zW9dXa9arupryfl1xlxJSyyjfR9QRiZiYCZRyIy8apX+NmfxwThAH/qVl1Z2jZm0uRcIIxboLcQ47cvLSvGXWKmHEmnGkXD20zYjBNwG8HcSiPlPgq9atIBLkXE3auI5MCAMx3XuQqCDy5Np4QmXM7gZL+XEtTyIqwSMBjrM3VtSuYnmR5rz5ZnEolIEeGApK/bCl27h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2dd3eb-6b5c-4604-40a8-08db036cd866
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 09:23:42.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4SLyODPfh9G7HTAJhTbTcUg4RoYz02eHKTChyTnBWga+5vWCvNrfChGd8SZBGk17uNKctWxOAvUfLPW7VVzKlmG2VY9WOnj7e5pFCOosIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7137
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_012350_093103_EACE1C3F 
X-CRM114-Status: GOOD (  13.98  )
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

On Jan 30, 2023 / 12:08, Daniel Wagner wrote:
> Hi,
>=20
> while trying to get a baseline run with blktest against the current nvme-=
6.3
> branch I got a lockdep warning. I haven't really looked into it yet. I
> as that Shinichiro has fixed a bunch of those in v5.19. Thought this one
> looks slightly different.

I also observed the failure with kernel v6.2-rc6 by running the test case
nvme/045 only (I overlooked the failure since lockdep was disabled by by ot=
her
lockdep WARNs at other test cases in the same run).

I once observed this "WARNING: possible recursive locking detected" and rep=
orted
[1], while I was investigating the "bad unlock balance" issue which Sagi fi=
xed.

[1] https://lore.kernel.org/linux-nvme/20221026120150.luck4dinfvhrw7se@shin=
dev/

I think the cause of the WARN is that ctrl->dhchap_auth_work flushes
chap->auth_work but these two works are queued in the same queue. I created=
 a
patch to add another queue dedicated to chap->auth_work. With the patch, I
observed the WARN is avoided. Will post it to ask comments.

--=20
Shin'ichiro Kawasaki=

