Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED468C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OASDc0BqJ+9dS3KHWKgzt2I0vBilobtiqF5a0fmO/HY=; b=ljFNOo1kKbn5MeY/4EoxcciJP8
	6x5/hgT7iL0H90d++p01sqJIRpfYyJsKNpU9CHTwI0lPiCwalWYVebXDSGsjNT6upKM1hqdv+M63y
	1kDb3yKJvc3isjvDBCCQbr7Jxsjn3xaKLqmQttfepgk2AZUM3F1YCDiEaq6HGOtVmLQO/zk+GXf7r
	/59HlCYcyL+mV2HdtB8hIAo6Dt53LojhsSagkpfISbD67svZ9T8MbvaZkuOu8V/lGBjPoH+Z/TxoP
	y1e+fQJPk5WBX3nr/AC4eFpbTV9S6d9DNdoYzacC9z24e9mYa2rbaOUTOs+TylZrAwdwRwNziFIy5
	R8Ud4h3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUf5-00Aqjn-2D;
	Wed, 10 Jan 2024 09:14:11 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUf3-00Aqip-0s
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 09:14:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704878049; x=1736414049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OASDc0BqJ+9dS3KHWKgzt2I0vBilobtiqF5a0fmO/HY=;
  b=NXQEkccgL7yK2JuoH9e1rNjws2THvFrMPjTPeTV6/NLQV/3b77GDP0J1
   et+rMUDGhZqylGwmziEWzufWj6wn8lyxmxQaqBS9rFQYxixpr+mRaOk2a
   4zGpaEfnkQ5rQ8N/JGrdQgH3uZsTOqay/Ix6SM4GjHFf0LQYfjuSTL0Jr
   ELKqltGpHtJL8CrjqoQOimmdLit52Eb6BfpbsA9qToEmmd8Iq7Dr4w5h5
   nhyPPXsUD22AyBhI5wPMYNxv4NLJBpKRThk2Y5GUkdoqMSJrDADZUp3Ql
   on+PI7QN5vfs0ailnZlxaA4WBdeFapZQpIWykW4PoAJfp715hti5NdRUv
   g==;
X-CSE-ConnectionGUID: 28muXgUWQDKKWcX05NP3hQ==
X-CSE-MsgGUID: Q4e3vMrFTVKWzppqw9tzBQ==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="6318058"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 17:14:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5bTO6p/Wpjqke2s93oZtWraKKEMhP178wGCIqdPi6ucfeW2Gr63f9F2l05nhB0hSNhwxKBBtelshexOYbP7OTBUSJhQuhrz1HQdTcjR/PPRUsCP2yZ7zyj99cIpvh6JP0ga2tJ7vsNkLeV1smUyBSzNCfvk3XuoP96AHdfMcxYQZZqDwlWyojTCw3/YrkZTrIjtSC0jYm5rUC97mVPYxg1TK0i2bJv/vz3ufWiUsrghrsgq03LNQKq5aH65QkFZFVMlj5zJigujLmSBdTxaNYEDUVtuw4clljAQY4X/qFMhQbPY5ua1793QXfTKNwv0r1htHTmS+dfvj9CVJp1O5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OASDc0BqJ+9dS3KHWKgzt2I0vBilobtiqF5a0fmO/HY=;
 b=RImW30N7GHbKUnMBhV2HixqUVPPLNBw++DBg91VndBV0LlKdiIM3loCvJoLU4gvtwv0DjqegP8Znv4AFkCjGyR99zwErSuvEZNbh85384dHfq/y7YzL+AeTEx9nNQxc/uDVUpDAdWJtX9XmzsAihIhV1t3R2BefS9HCsZLtGq3DHKM/y54GwA/x/tv8jjZIGyZjKwjGOBY+SHz8eAFLqngy9dhW476numOBeTRheyx71Z0HEI9fAjPQtW6GLB2CEL0NbNMprqg+sY2cQ9B36ytWleFJzuSOYIY9hAaIOZAfN2F9fuFyTsjKv6aXPAk7CdSz+pICvlu3ErweQ2KeZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OASDc0BqJ+9dS3KHWKgzt2I0vBilobtiqF5a0fmO/HY=;
 b=ElproM8x8yHNs4sleAMyycUx6KcQKkpC6mSkguTh4+PrRE9G/uGluQjYSttZxPieCsGrntGYTXy9VBU/ADoRRV7eZsuy/DSF5P7G50zaH5wpq+Y7khOpf4JISbZ8zpBB4d1ZS/MxkdXL8ifE0BJfB5mOnH5AJZftaoZ6sWj4u24=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB9022.namprd04.prod.outlook.com (2603:10b6:a03:53e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:14:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 09:13:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Nitesh Shetty <nj.shetty@samsung.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index: AQHaQ3lJXWqCfG9takit+D8rUbx257DSkmGAgAAXHwCAAAQHgIAABOuAgAARS4A=
Date: Wed, 10 Jan 2024 09:13:59 +0000
Message-ID: <3y7hmz3kxhgu22nmvzcayjl47daylxcoe3absupor4yfhnndgi@vzp4whipr326>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
 <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
 <20240110075429.4hqt2znulpnoq35h@green245>
 <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
In-Reply-To: <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB9022:EE_
x-ms-office365-filtering-correlation-id: 1f70affb-46d1-4083-a74c-08dc11bc7b34
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khyzFVHFTlkNzkZB/vexMyTuU99/2XSuoafYS66H+a4U4x2x6Vrun4g4OaLgRPjKxFoa0KjoF+0Gu9wSNgo1jQFTAoAV+BgwqfMhqbNGJ1mJIzq9+n8EgKW1bEqEtl2zeeI9xgybHZy1ImubMgAcjKcrWUFl3o+kCOBCiTuDX3sCqvgu/1I+gwILE1+gKzwgk3AywaFOe6g5wLqQeOstkJTgmOaA5VS7uj+pJ0ibCL7JPi60Nt8iq5ZDCAEp1b+V7JTFhG8adb871JUjVrR8Hhzdt8VDXLv4TbC3MJ4BhD4VPUBCM7T04Eb4YgDnX7wO9H5YPyhV/HsBxUhbAW+P5SJtso2hG0SU3/c8G2epnVjw3whNZrZAWFxdO3xOSnvHl5Bseb2ja2tJLk6TfHNEMGHDERLzok66yQ2z4cqBtGGojfrS8BF58FiqRM57V9//tMvrSeDtNkraHNiNojiVqlNzh7OYpZA1kvMkJ3aU50IYfgSBYllzng06sjFvG6RiCGWttQ04OGsciL4W31m32FdZ/7sdD/rvhjfnDAGcu+8nzYoMYPiTw7ZEWx16fFNm72o8P90vMdooBYQw5kb41kSx5thAtSERAHzdrUwNzwa4r/XRfEbpvx0aFTkudahm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(71200400001)(26005)(33716001)(38100700002)(2906002)(122000001)(5660300002)(4326008)(8676002)(8936002)(44832011)(478600001)(9686003)(6512007)(6506007)(66476007)(54906003)(64756008)(6486002)(66446008)(76116006)(6916009)(66946007)(66556008)(316002)(41300700001)(91956017)(38070700009)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OzSKnrqjXFiEi+Qr+w+/kN+nL/LxjkmxRcSW0OrrtCEZ6+DXoF7noVae6TNu?=
 =?us-ascii?Q?vZMvuuwVkjQrx5wcCzuo1Bd4OwZxnc8a66wuwlS8Dacu4PP8+kgxXCgo5tD3?=
 =?us-ascii?Q?lRsiVx3QEVFiHUwHhbPQd0AGOagi1XGjz6D+Wp04CTOBvi9AhVYn8rM54ppb?=
 =?us-ascii?Q?cETZefnysccAYW4w6a0CT4BzY5+bj5oiXUr2on36oH4JIdd0rX7Wo7jYe2Ew?=
 =?us-ascii?Q?WS3e33uz5Zn6KuyG+NX59/pRjrSeOglePvB3YYegoD+s8sB0/8wFQ8gVt09o?=
 =?us-ascii?Q?M/89Cr2DBuiuSTSf2dYfWxY0D1z8qG7swv9I+vZ1Eq6PPfxi3gomgIP6zklV?=
 =?us-ascii?Q?Ims9LkFoEO8HWnWLjTl6NmpCDbXQMFxkoHJZWYrjb2GfuoNwdb5ZZRcCphpZ?=
 =?us-ascii?Q?Lz8rDcsGSVsz6OsRe5BdbvE7/WU10LLGz8TsoGI8mdGIB1LiZnDyK0lyF3uC?=
 =?us-ascii?Q?/xBQiuLktecbw0xlBPMvoCAUxzrkI6NjFaQMvEBiItI1rRGdvoJdaeMRtw8Q?=
 =?us-ascii?Q?bJ8Ga6xp0ZpBtILEezRAdXxkttsOvJ/I41mTlHzzzoz9td03vu3c1Bk2mkMX?=
 =?us-ascii?Q?E1ch8dQOEzfnvAiq/G2PI439gMGGtF9Q3O2w20b3PTHFVWKKjtKPtXwcY2bx?=
 =?us-ascii?Q?tV73aD/IvK6CY8UiEDJLpj6MW51BY+P/+K5M6Gc8K9i10dyL70MPJWKu7Pk6?=
 =?us-ascii?Q?O9s61SRJoBywgMHrZ4JW6fxZr7JroE4cm4A7GZ7uevGpjpD9zUn5avztPUFn?=
 =?us-ascii?Q?OW/qcEyF97vTitVn1TdGrn8EzvbCvsGx/C9s1k/Q3Zuat40+a3DLILDdUlpd?=
 =?us-ascii?Q?/EwyiQZ9WY6Giltmu20SxmePqjMe6JES/F1uBUw8Qhwa2jTYCb+d/2da1G52?=
 =?us-ascii?Q?onCDyd4n4QSibI/UmjSvLoPt7yGKjQE87xrNwEDHcDkeWcLmX+TN4plqb5fz?=
 =?us-ascii?Q?jIjJgfVv7Dj8iBYaks4xMDL5wvD66Yc5j5m3g9tttq1s2wfYvuJpxhXooVjC?=
 =?us-ascii?Q?EJ14FhWUD0JTJ5kW1SxbEPXj9icJaLaHOt/6hORKWPJ60ut/+/BaX+YCr6Hh?=
 =?us-ascii?Q?katuy0pH7maNh6JZurT3P9zaocRfQc+VKjyEAAQ7t+S3vsRZCIhNzGZVU1L/?=
 =?us-ascii?Q?FfLr/ULzww0f/+RRNT3HFokLdb6hxGhA16infRDnR6ls4k1FD0FkIetofzrq?=
 =?us-ascii?Q?fsgcu/MRB+YM/fLGpdqq3QgzB5jW/kpdcxyiqPs/4ycvtmyJX8blPzLqAJDj?=
 =?us-ascii?Q?QhNi2pEakjCLNhBSgNMYcErfsILRmMiomccrhcKNaCV569D3h9jWjaKEK9yL?=
 =?us-ascii?Q?GZiFdQy4Taozuy1+uy9c1SXsj6wJJEIa13IW1T08YFYmOUkmZngu55H4gTa7?=
 =?us-ascii?Q?XZT1ysk8Lp8ob/OQZ/96BMgfyTHnGJxuynvxpxNRCLzT8EmAzdNV0smQZvTP?=
 =?us-ascii?Q?MozFD+bw05APxXf8zogZ7sKOPQmdZPMeumDBl3vc5craB5q+FvXYmzdBN0b2?=
 =?us-ascii?Q?xxIU2oyMnUdaVFgOmAQlVLupAKXZugXKr08CuYTd3FSuJM+VLIkiXF+Y9XZa?=
 =?us-ascii?Q?yTaygK6wpmTrYbXZY1vlBiTCA3GFUPBuWuYslUBYQ8g/y9OV2qRw4N/Xr7pu?=
 =?us-ascii?Q?1ks9G4btPH+Dj03oUNujmvQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00F835AFED138D499A90AEE071DFE757@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pCVWGab93YHoVuZArNJQdVbacB+Thjh3dXKKK3exoHmx6SSyJYVyonIXvlOdYaH9tIwLsYX5WuPL9JVwl9o1f/NBFM86+63bji1LKiODLD6u5QyI1Ybif7A8Me/ZW7LM86iRk2r0sXLlq63z8kiX4MFkm4r6kfZFLSxxgvgHa0+Oc6ZldCrEYqDIEmICin3Pp2FhxBOnfNAFySoMdkNyQT+FUpY1qCTzYd7K0Wje8u6WznGYl+1PfkeP8PcQ4GybLoTrI+Zm3qc2tdOo1Zuhxvt+nf446wQoWF+e0ZVR3d0RPosThTdqKn64vLiD1iAFEBtPUgftt5oz7TIhER6jPYn3RNu3oG/U7aLYVluowQQJQ8xoIGVnOS00wJ/vKNMzBBlYyVnkPQluPTcaQioTSG6he90SonGdkV9y1wyIsrBmOc3RZFhJTydDA4UXCvMLc2WvyOFYyJYhsDmXUO8rMa4hhBvQ6MJbab/YYWTBljOQtxjx3ZaubUc22J0mdKoqoPPWzPMcY8mVIfo1DJkO8ld+4UEdNT3t9uVemCrolNi9H4zwP+yJD8e7hDkFqopjUsRtnLrz1Sz3EJX999zHeyR4+t0QGAI2695PTwVqKjOITQaNwYIDg7Gp8RuydHqP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f70affb-46d1-4083-a74c-08dc11bc7b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 09:13:59.7947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kow0MpHfc0a5stjL7ODTRINrVXP1D9O22+crr4An9E9pY3Y9ksT41ktZsBJMINOzU/dlE4DzUVEqt7fu59/hZQTYVHR1WCUZhKDG0XoFXgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_011409_432411_462DB527 
X-CRM114-Status: GOOD (  21.99  )
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

Hi Chaitanya, thanks for this new test case. I will comment on the whole pa=
tch
later. Here I share my comment on the TEST_DEV topic.

On Jan 10, 2024 / 08:12, Chaitanya Kulkarni wrote:
>=20
> >>>
> >>> Should this be TEST_DEV instead ?
> >>
> >> why ?
> >>
> > My understanding of blktests is, add device which we want to test in
> > config files under TEST_DEV (except null-blk and nvme-fabrics loopback
> > devices, which are usually populated inside the tests).
> > In this case, if someone do not want to disturb nvme0n1 device,
> > this test doesn't allow it.
> >
> > Regards,
> > Nitesh Shetty
> >
>=20
> it is clearly stated in the documentation that blktests are destructive
> to the entire system and including any devices you have, if your
> system has sensitive data then _don't run these tests_ simple, when
> you are running blktests you are bound to disturb system you can't
> prevent that by using TEST_DEV.

It's true that blktests is destructive to the test system and the test devi=
ces,
but I still think it's good to reduce the level of destructive risk. It is
likely that /dev/nvme0n1 is the system disk of the test system and the test=
 case
puts some risk on it. By using TEST_DEV, blktests users can specify non-sys=
tem
disk for testing and reduce the risk. We can run the test case (and its
following test cases to be added in the future) more reliably.

On top of that, TEST_DEV will help blktests users to control which device t=
o
take the destructive risk. It also helps to check that the test target devi=
ce
exists and it is a block, nvme device.

So I recommend to use TEST_DEV in place of /dev/nvme0n1, and replace test()=
 with
test_device(). TEST_DEV_SYSFS will help to access the io-timeout-fail sysfs
attribute.

