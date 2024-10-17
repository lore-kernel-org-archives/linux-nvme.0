Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55740D2F7FA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7wuSGPYscIruY6JT1vNu9mfiiG+RiTO9+nYxgRtHhg0=; b=GoC1evemZOzmdloQioS0iwUlw7
	JMfcJq8NX5XpuK/zccfOn0D1xshe9sm9i6x2Fg9hLGCZhbqCb45J8tXAI2uKub5wKZWES1u9nY2oS
	ktUrvVsGzWGHA7LlKzGb6Hn4olhaisAXW93HHEZlp0gOtd8Rn5LPYCnaQQMLEUglBBaRgcZB+2P8c
	9xdjP1adhbw+VaW0Q4q9zXV4CA4/2dRDnwLyTzdUi5J7p9HwTn4NwWnbleF94NjUkyGfAMYeW9EEh
	bg7J7P6d1JyKPZH03yRbhn0xhyXauuP5t6YWAW/0L1U87w8Hp7F/V8nMEPTBVKH+MluQrsTsEUa3T
	EP82XmUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LGX-0000000E2JE-3jvg;
	Thu, 17 Oct 2024 07:49:49 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LGN-0000000E2Ik-2b6l
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 07:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729151379; x=1760687379;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=wWa9rj84mtj6ugGPdVa26+J7oIy4E1lBk2kicGeBX1g=;
  b=HwpmTyNAlO9EKn/fE6lMObgFoqC1nUKyCEuUJmuQWyhanTAYVXeASXNb
   B7Pv97oo+auQvL3+7fl0xnAUq+0l43v6Zi5Gi5cNx+hvHLFej4uNhqnME
   dqaPapVkJQO/r8z7zKMHXcwqvenaI2EqqssMNrr4obqsf9z7zzV9mg9UT
   FxMU/8cSzgkjpR9mJ2hWi2CsQ4M8RsBrIEwp+yD9IHG36zkuxlFd4NEa+
   esNMc64+sNOZ7hwbak9G23dyTvra+HM/ehJ5znbniSJL+K49ImuV3yD43
   vf8PGPWSalsmEPKEGkbpEJP6v4Yn1kU/7n6GqCzQhphbh36S4qsHV85i5
   w==;
X-CSE-ConnectionGUID: oE5kqR1hTXSaT9GkG5+2CQ==
X-CSE-MsgGUID: 48UiamkJSZ6KzPD5RV8ELA==
X-IronPort-AV: E=Sophos;i="6.11,210,1725292800"; 
   d="scan'208";a="30263991"
Received: from mail-eastus2azlp17010018.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.18])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2024 15:49:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGzj1qypmhGlapkBAv+0xdric86ZOf0PsOu0zq6lCgAD8Ur80CpmaGKZpycqDBVDoBvMhIL+46qEgaHdTlpxSps15luafPqdrKCN0LEbiDIAK0SjXeVG8UVkFgI/MXpmG7Jn86VjAiH7KeleZZNSEPi7TJi8dPxiUgqXE8bT5ZmambR4QlSfv6uoiOSRC3uOo6Kz/yEPuZqXTSc1vewo/2+L/q3TKPaCubF5eNPnkMuJHn7i0/3Lgg2nxSD95Y6cUhwCQkmR+4XzV+dTFuXod4koDIhyVuMokGoB8W59busGVMSAtKnYhiwm/CBdS6LPWmlCYtxW5WbchSBMAOTnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wuSGPYscIruY6JT1vNu9mfiiG+RiTO9+nYxgRtHhg0=;
 b=jE9yiPHSzehHuxs4MAN0+AJVPdjGt/pOFvDUrGnCyFxn1IMumU10pwRQsoktOhs/ZXt6TRbC3ZFC4McqaImjoO5IIaFHBA7EXHQ2z4JeHt45N1bHU5jdRoBksyd0gyUHkuAF68WAP5dvxuy1mS17xbKokEDF5JQx410GXObxkBkVlCJfYRgBssn00sfrN2BWS6NLuSfkYYlSfGigqpkX1H3KDyyDuqVIEm7Az4OAtgNGnVzpQefw1qjlOVtYvCuqwIFiDdM2fY5wuq6lChdY4AeRkQZKvd8lWhkX8wOueYzMAJHO+ySq9P0sv9yNrgYs99Rwk4JqnedrQxJFhAFXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wuSGPYscIruY6JT1vNu9mfiiG+RiTO9+nYxgRtHhg0=;
 b=WKxNAQv85CTS6FYA9vVDsMVjJ45th8BsMCWj9CxJv93TDGPPE6KGZtINwX3fosPVIlSoDw+n9aN8wPglCuui6ohj35gGs80jpy+GfpLoRcrBCaWafEewCPmcFT6JVOkc6rdxa7CB9D49zMmRrlmTq0S0spIM0xHeprfZtu9lfV8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH8PR04MB8614.namprd04.prod.outlook.com (2603:10b6:510:25a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.32; Thu, 17 Oct
 2024 07:49:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:49:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [bug report] "BUG: Invalid wait context" at blktests nvme/052
Thread-Topic: [bug report] "BUG: Invalid wait context" at blktests nvme/052
Thread-Index: AQHbIGkb3tplRyy8kEmzooZTkUq0jA==
Date: Thu, 17 Oct 2024 07:49:33 +0000
Message-ID: <tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH8PR04MB8614:EE_
x-ms-office365-filtering-correlation-id: 5014450b-62be-4d52-b1e1-08dcee803dd6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/ZKBL2xBtthcg9jmmm2C/Uj6/aGj60DAEwpjHUJJlSiVqt8IAkhD0Pa6OoDu?=
 =?us-ascii?Q?R7NNwfdMjxS+95tR4PY5/DEw9ELHUwMAv4zh1K+SHv/Xuk2idvWfIFmysowF?=
 =?us-ascii?Q?srZc8qrvdjb8M60kpeBssnyo+7IcMd18fXVZ4qMe/iTXbiqMMZgr/D5yUGxt?=
 =?us-ascii?Q?YlLNDSWhAgGEwW5uShHM+extcMe0wdQjBwTR134TynJvINT8DXPsNiSrB+FV?=
 =?us-ascii?Q?4o4ngO2/oeE4AZaZ5yRixS4YHp2Jyj66Vv1EP6wnZQ1nAJGxdfr9C72veS9T?=
 =?us-ascii?Q?fYKsU6ddlO1zjEp1tTVmRsC24rOVVlFYreD4DS7ooHnAtwGyYdLQt8ZymESl?=
 =?us-ascii?Q?vFbHtX66SskdJ0VW6TdzV24us7gt7tKaD0Vsty2XqjeflSzNiNKDpIjgtjOh?=
 =?us-ascii?Q?VsAboh8FLyV/fGrBlyPBr3BzMZMp9DqxhoBJKKWI2nbfZpJwm0tg1tf+sMoJ?=
 =?us-ascii?Q?P4U2QfJFybhcVNHj9NRyNSsFc5n8VmBRsZ0ID3Hy/I97DQ4Zzi3bvXq6fjt+?=
 =?us-ascii?Q?6MJbqThjw5Q3DqUUcIHLpVENmgV86s/9UJmwbqFzQpVQKO1yNjpwWrJLZqsx?=
 =?us-ascii?Q?553Eyf7aLIX22WaWLwf6eipDueRw5gv5S/gLYSQBZpoohaX7mpSHKDk8IPTK?=
 =?us-ascii?Q?sKK+G+G4QpxJpT568/KDo/C+9eMACfOdtQe+/r6rAPlnnb7D086NBtKcIlio?=
 =?us-ascii?Q?aRn1pbaaDtAPXRnFsK2g4vSJK1rTqx2uEhbqs/qQDREz19mUUJ1oDt7CV30Q?=
 =?us-ascii?Q?594RCiYkwlpcimsayjx1vZaIs9FA4YeY4RWRS4FYvxU3zru1wKZde17KfrfB?=
 =?us-ascii?Q?WQMCZOKUIT0hyUXgNMgiqLWahctHJdCkeQV8AwDA+N/bOxzoSclmT2YPHXm7?=
 =?us-ascii?Q?XAor025bDceqdF5vi5ZnS0FajrRLuoWGUy4dhu3dDp2GKBgDOg6pSKNW6hlt?=
 =?us-ascii?Q?5UExAuGM/KMmJJ/sWkHIZCMPq4OqtJc7jbKg04dwFGTMguLIXR6sGifgg5Qf?=
 =?us-ascii?Q?zRWeH0+L2VuXWplHmK6PlDG5t73gJpySKoxR5K/VDup8F79wh+pqJ7oGKTGU?=
 =?us-ascii?Q?uB/WK0JqtkbktYn3XyyMOfibJKTHQnOSu6vl3mlm7IB/qsplM16udvr/Ukej?=
 =?us-ascii?Q?5Jo3TGA6WC+nFMFT68vUVuYyRf7Ied9VDM9/GqX7x51MKxBohwk+T19NzEDb?=
 =?us-ascii?Q?D55u4OnHL3SFVOC2d44fpAMMnJ6YbHUIpOXGnIZTwQRdOzUcFFpZYMWsnkYx?=
 =?us-ascii?Q?o+d8py7lA9jQCeYmnxX3PA0stAIAAveEmPHNKKFg9ExyIlFb6zMsGximn1+j?=
 =?us-ascii?Q?dH6FlZxcSOPPIirfOA0RTy4USnquoSrwUBERRdLz4+uUTxXJNg1jYJoWaOS1?=
 =?us-ascii?Q?OrG5fH8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DYu3ZWBt7Lj/2Y5I/qnf0g5XjYNzPqdvge/j5/IZekcp+7dqm458DFjZjNef?=
 =?us-ascii?Q?lr8iO+scX6io+0tQUodj3IVIDe35F2K/FwxZs30FkPHMlROFOq2WPvZwd1uQ?=
 =?us-ascii?Q?xWTuTAz6t4k/euzzHOyfO6sq4Za5H4gRgFt6Msmi0kBI55Zk0cc9tuYycxbn?=
 =?us-ascii?Q?qaJDh+gW4xYCSv41k3j55MHE86UyJFa7gXuXqDteinAPN9vgkP3IjK+oOSFL?=
 =?us-ascii?Q?C6u8jWpsc+TEq2LoUyFtkpyb7FEsscgxdlHLyYfxv8MhVjgjhitAESEhBkiS?=
 =?us-ascii?Q?GGW3P2fYGmOxh3/DFX5+0UnTwhoao6p+41Q41P1WDahNPJS6+mVkIr+b+nWc?=
 =?us-ascii?Q?S2of8i14G0Gg9jAgC8YF2TkBJjWLckPp8bxIfcQRI7wnYNFx/24rhXqJ7lNR?=
 =?us-ascii?Q?nAvjeAKGpOPXf0UClYrJXsZ28THZgoKkgZsBuHeLRdOdQBsN3xTsEgZuzS/v?=
 =?us-ascii?Q?3TNjVuORVztbSuzg2iAR3VMQI/v1v5jnalnxMzE1gbrbePDLmlzDqeqoUWkG?=
 =?us-ascii?Q?+wmoZ/UQ4MIWxIEvFNs9wSSgBi7Xtk49XmNlgxu7l6k+uK47I3jDijF09QlM?=
 =?us-ascii?Q?GHvXV03IUIKXHefitCV07Q2LOxNWfw97rw2kTN5sUjEWssAwkepcpidm9RH7?=
 =?us-ascii?Q?OWVaQzxpgdT09ao3I740W70eg8z5HhEoNBFzfrZG00q4Blbu48NmImyWQ+JE?=
 =?us-ascii?Q?qb6FMCAJNnqxnIS8RXuqW2BrzgRkFcxnIXdn+H1znflIDTgJ03bH2G8hnI3/?=
 =?us-ascii?Q?/PKeI1TYq8K44pKiFXcFD77Mc6B6ZohWp9QxvLcLOV9/pXDD3u05MbsQa8Ke?=
 =?us-ascii?Q?eHDXv1IycEbTmLBgrmhfsPLbRvBJhi0LuQGcJCX5yOSTTZUcwsb1WBJ2elOJ?=
 =?us-ascii?Q?NKSlKjtgAtXY+lJ5rpzZ8z5sJ4Leuu58jFNEttS7wBJPDR1HnO8Oh/h9XAQS?=
 =?us-ascii?Q?7JjdV8EA/8stFZKzk2X90xf0ts6S4hxJW5a1aJEWubevYjLGaghlJ1g+JHfB?=
 =?us-ascii?Q?reloSy434zzvKeIfOY4ESdrYgXmvQyGzCULREFGeneNpax4Hz96a0nAieyhK?=
 =?us-ascii?Q?kLECfcJyC5I1f5ycNpSMX/9iaHYs65yBeS/quRYJoxwsJhc3jq2N6lnWdsUS?=
 =?us-ascii?Q?YE1Z4PsahMZOuIh4vDUALDjsv87UMfm9BD779xr+THV1zHiwMKhskQgNWDu0?=
 =?us-ascii?Q?FoAVm4thmS0PEgWGhiO7NhFGV3I58OE+SO325Xv9/87DEyLAmT/wZSNJietQ?=
 =?us-ascii?Q?ZevGrpkXI1NiB/B5mQPLU212GtHIwSPSJE+ZabRK1YKcKdFE05Bc1FaZEkiB?=
 =?us-ascii?Q?xq7UF+iyrvvbSu6zm7JxIFacvg+ZAt/STKu/WpESUrNZxndrvQtJx+dftbA2?=
 =?us-ascii?Q?yGuavbacmx2c0HnM6P7doWeRECi9yQo5Md0yrmTKSDvPZz5Kzgm5JODlkk9V?=
 =?us-ascii?Q?YvRh/F8ZGSe80yqU+Q68O7CeMVxgDpVMSCIqgH66vHatU0kDc6xqpv4lRb79?=
 =?us-ascii?Q?V02+K2z0Ejd/KQzJy/fSCgBfYPU7gZpFx4s2GfjkR+ALabDhO2nMurtKY7dF?=
 =?us-ascii?Q?yBpCaACU4hkQAD7wziDdiBHJ1nDJRKQAWDeix3wJSKwQj1aAplXxfMjCGSmN?=
 =?us-ascii?Q?AaNNvcu3qjXnf2AdB8sn7GU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CDB57EB143247459F9B7B7562643A16@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CC7L68Kr4K+LBYl1scSWoYiuR5aok4XPoFPKiXgbVfFmGtfOrcQ4sQgzfi8BmwcPrzPRcULX6r8mPIfg6KVa0clXGPTiWwexisQH+jVubPy7XpMhulQGnOTFu196ZqcjdYANNtx4UcGJtEYgmBHpHPvyqGqKkjXVNyHP0A1h19X19MERXT7UjZG5Okv5dze9YdQ/BQvJ/0kgBW2PxI2bBwDcgvEdRdYcsc1TyqaUSCtsOZHpIa4BsPu+0WWW7L6Rr9Q3od4fBKcBcZENWGYonMlSH8Sw7iPjT68JxCB2ecyVjHM3gg9nt2x9kXDIMsEtn62HjCUtHrw009NZjj4iVJECnTEnweCZ+yDIC5No3jglYHAI71/wKIb2KH6YCcFY1GS8HwrxKlw+Pv20zlEC0lGb5rNWx6YvFK/qAKz/YUfBJpH/5dfU3XlDE6oYABKqWzdfHZwX3aB6rJ4A/7NIdYKhrRtN/bsH+ybpbHsheitbFvLNgxW4SHygWWVdHgwLilD0aB1doVq/Cv17LjXy8v/+lWhomAn6jYrYI+pRJVukHAtHpITyrbIiPGbaSwxx+NgQGHfw0GdUDIDrVsAwMSkCrLMxl2fR0fNKPMtJJOiOl+/wBPVC+ambug+sk/RX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5014450b-62be-4d52-b1e1-08dcee803dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 07:49:34.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSGvkoc351Qd28YQ0rTjw82dhc0455IIsEWjrTtwfKH6gtU+38o4uOQkAAEKjq/j6994h64w5KXuixFCwoRB3Ef2luaeG+IWg1C/zMJXqEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8614
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_004939_860146_F6D764F0 
X-CRM114-Status: GOOD (  14.74  )
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

I observed the failure of blktests test case nvme/052 with the kernel v6.12=
-rc3.
The failure cause was the "BUG: Invalid wait context" [1]. I have no idea h=
ow to
fix this. Help for fix will be appreciated.

Here I share my observations. The test case repeats namespace creation and
removal for a nvme loop target. The BUG was reported for a udev-worker proc=
ess.
I guess udev is trying to read a namespace in the removal process. The BUG
message notes that "RCU nest depth: 1, expected: 0". From the call trace, I
think the "Invalid wait" in the RCU reader was in the function call chain f=
or
the read operation by udev as follows:

blk_mq_flush_plug_list
 blk_mq_run_dispatch_ops
  __blk_mq_run_dispatch_ops
   rcu_read_lock                               ... RCU reader starts
   blk_mq_plug_issue_direct
    blk_mq_request_issue_directly
     __blk_mq_request_issue_directly
      q->mq_ops->queue_rq =3D nvme_loop_queue_rq
       nvmet_req_init
        nvmet_req_find_ns
         nvmet_subsys_nsid_exists
	  mutex_lock                           ... waits in the RCU reader

I found the mutex_lock was added by the commit 505363957fad ("nvmet: fix nv=
me
status code when namespace is disabled") for the kernel v6.9. So, this comm=
it
might be related to the cause.

The failure is 100% reproducible on my test node at this moment. I bisected=
 and
found that the trigger commit is 4e893ca81170 ("nvme_core: scan namespaces
asynchronously"), which was merged to the kernel v6.12-rc1.

  I did not see the failure when I tested v6.12-rc1 two weeks ago, and not =
sure
  why I see it now.

When I revert the trigger commit from v6.12-rc3, the failure disappears. My
mere guess is that the commit introduced the async namespace scan, and it
changed the timing of the read by udev, then might have revealed the BUG.


[1]

[  144.024806] [    T971] run blktests nvme/052 at 2024-10-16 16:41:44
[  144.084641] [   T1015] loop0: detected capacity change from 0 to 2097152
[  144.101557] [   T1018] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[  144.179962] [     T47] nvmet: creating nvm controller 1 for subsystem bl=
ktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-48=
56-b0b3-51e60b8de349.
[  144.184000] [   T1025] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  144.186270] [   T1025] nvme nvme1: creating 4 I/O queues.
[  144.189757] [   T1025] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  144.314156] [   T1042] nvmet: adding nsid 2 to subsystem blktests-subsys=
tem-1
[  144.318660] [     T93] nvme nvme1: rescanning namespaces.
[  144.543233] [     T93] nvme nvme1: rescanning namespaces.
[  144.616545] [   T1064] nvmet: adding nsid 3 to subsystem blktests-subsys=
tem-1
[  144.619799] [     T93] nvme nvme1: rescanning namespaces.
[  144.849535] [     T47] nvme nvme1: rescanning namespaces.
[  144.913513] [   T1086] nvmet: adding nsid 4 to subsystem blktests-subsys=
tem-1
[  144.916331] [     T47] nvme nvme1: rescanning namespaces.
[  144.947818] [    T996] BUG: sleeping function called from invalid contex=
t at kernel/locking/mutex.c:585
[  144.949434] [    T996] in_atomic(): 0, irqs_disabled(): 0, non_block: 0,=
 pid: 996, name: (udev-worker)
[  144.950434] [    T996] preempt_count: 0, expected: 0
[  144.950866] [    T996] RCU nest depth: 1, expected: 0
[  144.951293] [    T996] 2 locks held by (udev-worker)/996:
[  144.951796] [    T996]  #0: ffff8881004570c8 (mapping.invalidate_lock){.=
+.+}-{3:3}, at: page_cache_ra_unbounded+0x155/0x5c0
[  144.952665] [    T996]  #1: ffffffff8607eaa0 (rcu_read_lock){....}-{1:2}=
, at: blk_mq_flush_plug_list+0xa75/0x1950
[  144.953453] [    T996] CPU: 2 UID: 0 PID: 996 Comm: (udev-worker) Not ta=
inted 6.12.0-rc3+ #339
[  144.954092] [    T996] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-2.fc40 04/01/2014
[  144.954809] [    T996] Call Trace:
[  144.955060] [    T996]  <TASK>
[  144.955286] [    T996]  dump_stack_lvl+0x6a/0x90
[  144.955649] [    T996]  __might_resched.cold+0x1f7/0x23d
[  144.956034] [    T996]  ? __pfx___might_resched+0x10/0x10
[  144.956457] [    T996]  ? vsnprintf+0xdeb/0x18f0
[  144.956832] [    T996]  __mutex_lock+0xf4/0x1220
[  144.957200] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  144.957719] [    T996]  ? __pfx_vsnprintf+0x10/0x10
[  144.958077] [    T996]  ? __pfx___mutex_lock+0x10/0x10
[  144.958482] [    T996]  ? snprintf+0xa5/0xe0
[  144.958835] [    T996]  ? xas_load+0x1ce/0x3f0
[  144.959200] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  144.959717] [    T996]  nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  144.960216] [    T996]  ? __pfx_nvmet_subsys_nsid_exists+0x10/0x10 [nvme=
t]
[  144.960771] [    T996]  nvmet_req_find_ns+0x24e/0x300 [nvmet]
[  144.961229] [    T996]  nvmet_req_init+0x694/0xd40 [nvmet]
[  144.962578] [    T996]  ? blk_mq_start_request+0x11c/0x750
[  144.963900] [    T996]  ? nvme_setup_cmd+0x369/0x990 [nvme_core]
[  144.965294] [    T996]  nvme_loop_queue_rq+0x2a7/0x7a0 [nvme_loop]
[  144.966690] [    T996]  ? __pfx___lock_acquire+0x10/0x10
[  144.967988] [    T996]  ? __pfx_nvme_loop_queue_rq+0x10/0x10 [nvme_loop]
[  144.969441] [    T996]  __blk_mq_issue_directly+0xe2/0x1d0
[  144.970743] [    T996]  ? __pfx___blk_mq_issue_directly+0x10/0x10
[  144.972030] [    T996]  ? blk_mq_request_issue_directly+0xc2/0x140
[  144.973314] [    T996]  blk_mq_plug_issue_direct+0x13f/0x630
[  144.974577] [    T996]  ? lock_acquire+0x2d/0xc0
[  144.975753] [    T996]  ? blk_mq_flush_plug_list+0xa75/0x1950
[  144.976972] [    T996]  blk_mq_flush_plug_list+0xa9d/0x1950
[  144.978152] [    T996]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
[  144.979322] [    T996]  ? __pfx_mpage_readahead+0x10/0x10
[  144.980457] [    T996]  __blk_flush_plug+0x278/0x4d0
[  144.981587] [    T996]  ? __pfx___blk_flush_plug+0x10/0x10
[  144.982738] [    T996]  ? lock_release+0x460/0x7a0
[  144.983841] [    T996]  blk_finish_plug+0x4e/0x90
[  144.984922] [    T996]  read_pages+0x51b/0xbc0
[  144.985978] [    T996]  ? __pfx_read_pages+0x10/0x10
[  144.987063] [    T996]  ? lock_release+0x460/0x7a0
[  144.988168] [    T996]  page_cache_ra_unbounded+0x326/0x5c0
[  144.989313] [    T996]  force_page_cache_ra+0x1ea/0x2f0
[  144.990619] [    T996]  filemap_get_pages+0x59e/0x17b0
[  144.991701] [    T996]  ? __pfx_filemap_get_pages+0x10/0x10
[  144.992812] [    T996]  ? lock_is_held_type+0xd5/0x130
[  144.993867] [    T996]  ? __pfx___might_resched+0x10/0x10
[  144.994938] [    T996]  ? find_held_lock+0x2d/0x110
[  144.995970] [    T996]  filemap_read+0x317/0xb70
[  144.996979] [    T996]  ? up_write+0x1ba/0x510
[  144.997946] [    T996]  ? __pfx_filemap_read+0x10/0x10
[  144.998967] [    T996]  ? inode_security+0x54/0xf0
[  144.999937] [    T996]  ? selinux_file_permission+0x36d/0x420
[  145.000958] [    T996]  blkdev_read_iter+0x143/0x3b0
[  145.001930] [    T996]  vfs_read+0x6ac/0xa20
[  145.002854] [    T996]  ? __pfx_vfs_read+0x10/0x10
[  145.003816] [    T996]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[  145.004808] [    T996]  ? __pfx___seccomp_filter+0x10/0x10
[  145.005816] [    T996]  ksys_read+0xf7/0x1d0
[  145.006734] [    T996]  ? __pfx_ksys_read+0x10/0x10
[  145.007698] [    T996]  do_syscall_64+0x93/0x180
[  145.008738] [    T996]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  145.009771] [    T996]  ? do_syscall_64+0x9f/0x180
[  145.010691] [    T996]  ? lockdep_hardirqs_on+0x78/0x100
[  145.011666] [    T996]  ? do_syscall_64+0x9f/0x180
[  145.012575] [    T996]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  145.013697] [    T996]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  145.014685] [    T996] RIP: 0033:0x7f565bd1ce11
[  145.015566] [    T996] Code: 00 48 8b 15 09 90 0d 00 f7 d8 64 89 02 b8 f=
f ff ff ff eb bd e8 d0 ad 01 00 f3 0f 1e fa 80 3d 35 12 0e 00 00 74 13 31 c=
0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[  145.018202] [    T996] RSP: 002b:00007ffd6e7a20c8 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000000
[  145.019459] [    T996] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: =
00007f565bd1ce11
[  145.020693] [    T996] RDX: 0000000000001000 RSI: 00007f565babb000 RDI: =
0000000000000014
[  145.021915] [    T996] RBP: 00007ffd6e7a2130 R08: 00000000ffffffff R09: =
0000000000000000
[  145.023146] [    T996] R10: 0000556000bfa610 R11: 0000000000000246 R12: =
000000003ffff000
[  145.024372] [    T996] R13: 0000556000bfa5b0 R14: 0000000000000e00 R15: =
0000556000c07328
[  145.025612] [    T996]  </TASK>

[  145.027677] [    T996] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  145.028606] [    T996] [ BUG: Invalid wait context ]
[  145.029543] [    T996] 6.12.0-rc3+ #339 Tainted: G        W        =20
[  145.030578] [    T996] -----------------------------
[  145.031506] [    T996] (udev-worker)/996 is trying to lock:
[  145.032493] [    T996] ffffffffc17f5d70 (&nvmet_configfs_subsystem.su_mu=
tex){+.+.}-{3:3}, at: nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.033995] [    T996] other info that might help us debug this:
[  145.035046] [    T996] context-{4:4}
[  145.035923] [    T996] 2 locks held by (udev-worker)/996:
[  145.036931] [    T996]  #0: ffff8881004570c8 (mapping.invalidate_lock){.=
+.+}-{3:3}, at: page_cache_ra_unbounded+0x155/0x5c0
[  145.038373] [    T996]  #1: ffffffff8607eaa0 (rcu_read_lock){....}-{1:2}=
, at: blk_mq_flush_plug_list+0xa75/0x1950
[  145.039774] [    T996] stack backtrace:
[  145.040721] [    T996] CPU: 2 UID: 0 PID: 996 Comm: (udev-worker) Tainte=
d: G        W          6.12.0-rc3+ #339
[  145.042116] [    T996] Tainted: [W]=3DWARN
[  145.043088] [    T996] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-2.fc40 04/01/2014
[  145.044488] [    T996] Call Trace:
[  145.045447] [    T996]  <TASK>
[  145.046377] [    T996]  dump_stack_lvl+0x6a/0x90
[  145.047421] [    T996]  __lock_acquire.cold+0x66/0x94
[  145.048496] [    T996]  ? __pfx___lock_acquire+0x10/0x10
[  145.049591] [    T996]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  145.050757] [    T996]  lock_acquire.part.0+0x12d/0x360
[  145.051852] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.053070] [    T996]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  145.054206] [    T996]  ? rcu_is_watching+0x11/0xb0
[  145.055279] [    T996]  ? trace_lock_acquire+0x12f/0x1a0
[  145.056382] [    T996]  ? add_taint+0x26/0x70
[  145.057419] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.058623] [    T996]  ? lock_acquire+0x2d/0xc0
[  145.059689] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.060899] [    T996]  __mutex_lock+0x18b/0x1220
[  145.061980] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.063197] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.064395] [    T996]  ? __pfx_vsnprintf+0x10/0x10
[  145.065483] [    T996]  ? __pfx___mutex_lock+0x10/0x10
[  145.066590] [    T996]  ? snprintf+0xa5/0xe0
[  145.067632] [    T996]  ? xas_load+0x1ce/0x3f0
[  145.068681] [    T996]  ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.069884] [    T996]  nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
[  145.071076] [    T996]  ? __pfx_nvmet_subsys_nsid_exists+0x10/0x10 [nvme=
t]
[  145.072291] [    T996]  nvmet_req_find_ns+0x24e/0x300 [nvmet]
[  145.073395] [    T996]  nvmet_req_init+0x694/0xd40 [nvmet]
[  145.074567] [    T996]  ? blk_mq_start_request+0x11c/0x750
[  145.075621] [    T996]  ? nvme_setup_cmd+0x369/0x990 [nvme_core]
[  145.076762] [    T996]  nvme_loop_queue_rq+0x2a7/0x7a0 [nvme_loop]
[  145.077865] [    T996]  ? __pfx___lock_acquire+0x10/0x10
[  145.078907] [    T996]  ? __pfx_nvme_loop_queue_rq+0x10/0x10 [nvme_loop]
[  145.080040] [    T996]  __blk_mq_issue_directly+0xe2/0x1d0
[  145.081083] [    T996]  ? __pfx___blk_mq_issue_directly+0x10/0x10
[  145.082188] [    T996]  ? blk_mq_request_issue_directly+0xc2/0x140
[  145.083297] [    T996]  blk_mq_plug_issue_direct+0x13f/0x630
[  145.084370] [    T996]  ? lock_acquire+0x2d/0xc0
[  145.085371] [    T996]  ? blk_mq_flush_plug_list+0xa75/0x1950
[  145.086451] [    T996]  blk_mq_flush_plug_list+0xa9d/0x1950
[  145.087521] [    T996]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
[  145.088607] [    T996]  ? __pfx_mpage_readahead+0x10/0x10
[  145.089628] [    T996]  __blk_flush_plug+0x278/0x4d0
[  145.090616] [    T996]  ? __pfx___blk_flush_plug+0x10/0x10
[  145.091640] [    T996]  ? lock_release+0x460/0x7a0
[  145.092599] [    T996]  blk_finish_plug+0x4e/0x90
[  145.093532] [    T996]  read_pages+0x51b/0xbc0
[  145.094530] [    T996]  ? __pfx_read_pages+0x10/0x10
[  145.095458] [    T996]  ? lock_release+0x460/0x7a0
[  145.096360] [    T996]  page_cache_ra_unbounded+0x326/0x5c0
[  145.097306] [    T996]  force_page_cache_ra+0x1ea/0x2f0
[  145.098216] [    T996]  filemap_get_pages+0x59e/0x17b0
[  145.099124] [    T996]  ? __pfx_filemap_get_pages+0x10/0x10
[  145.100049] [    T996]  ? lock_is_held_type+0xd5/0x130
[  145.100959] [    T996]  ? __pfx___might_resched+0x10/0x10
[  145.101878] [    T996]  ? find_held_lock+0x2d/0x110
[  145.102771] [    T996]  filemap_read+0x317/0xb70
[  145.103641] [    T996]  ? up_write+0x1ba/0x510
[  145.104486] [    T996]  ? __pfx_filemap_read+0x10/0x10
[  145.105385] [    T996]  ? inode_security+0x54/0xf0
[  145.106253] [    T996]  ? selinux_file_permission+0x36d/0x420
[  145.107192] [    T996]  blkdev_read_iter+0x143/0x3b0
[  145.108077] [    T996]  vfs_read+0x6ac/0xa20
[  145.108908] [    T996]  ? __pfx_vfs_read+0x10/0x10
[  145.109773] [    T996]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[  145.110662] [    T996]  ? __pfx___seccomp_filter+0x10/0x10
[  145.111565] [    T996]  ksys_read+0xf7/0x1d0
[  145.112374] [    T996]  ? __pfx_ksys_read+0x10/0x10
[  145.113238] [    T996]  do_syscall_64+0x93/0x180
[  145.114080] [    T996]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  145.115030] [    T996]  ? do_syscall_64+0x9f/0x180
[  145.115904] [    T996]  ? lockdep_hardirqs_on+0x78/0x100
[  145.116804] [    T996]  ? do_syscall_64+0x9f/0x180
[  145.117668] [    T996]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  145.118649] [    T996]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  145.119590] [    T996] RIP: 0033:0x7f565bd1ce11
[  145.120421] [    T996] Code: 00 48 8b 15 09 90 0d 00 f7 d8 64 89 02 b8 f=
f ff ff ff eb bd e8 d0 ad 01 00 f3 0f 1e fa 80 3d 35 12 0e 00 00 74 13 31 c=
0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[  145.122925] [    T996] RSP: 002b:00007ffd6e7a20c8 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000000
[  145.124094] [    T996] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: =
00007f565bd1ce11
[  145.125255] [    T996] RDX: 0000000000001000 RSI: 00007f565babb000 RDI: =
0000000000000014
[  145.126416] [    T996] RBP: 00007ffd6e7a2130 R08: 00000000ffffffff R09: =
0000000000000000
[  145.127580] [    T996] R10: 0000556000bfa610 R11: 0000000000000246 R12: =
000000003ffff000
[  145.128736] [    T996] R13: 0000556000bfa5b0 R14: 0000000000000e00 R15: =
0000556000c07328
[  145.129883] [    T996]  </TASK>
[  145.130735] [    T996] nvme1n2: I/O Cmd(0x2) @ LBA 262143, 1 blocks, I/O=
 Error (sct 0x3 / sc 0x0) MORE=20
[  145.132013] [    T996] I/O error, dev nvme1n2, sector 2097144 op 0x0:(RE=
AD) flags 0x80700 phys_seg 1 prio class 0
[  145.133531] [    T226] nvme1n2: I/O Cmd(0x2) @ LBA 262143, 1 blocks, I/O=
 Error (sct 0x3 / sc 0x0) MORE=20
[  145.134924] [    T226] I/O error, dev nvme1n2, sector 2097144 op 0x0:(RE=
AD) flags 0x0 phys_seg 1 prio class 0
[  145.136480] [    T226] Buffer I/O error on dev nvme1n2, logical block 26=
2143, async page read
[  145.139384] [     T47] nvme nvme1: rescanning namespaces.
[  145.177552] [   T1104] nvmet: adding nsid 5 to subsystem blktests-subsys=
tem-1
[  145.181331] [     T47] nvme nvme1: rescanning namespaces.
[  145.353535] [     T47] nvme nvme1: rescanning namespaces.
[  145.435612] [   T1126] nvmet: adding nsid 6 to subsystem blktests-subsys=
tem-1
[  145.440316] [     T47] nvme nvme1: rescanning namespaces.
[  145.641697] [     T12] nvme nvme1: rescanning namespaces.
[  145.689469] [   T1148] nvmet: adding nsid 7 to subsystem blktests-subsys=
tem-1
[  145.692546] [     T12] nvme nvme1: rescanning namespaces.
[  145.880165] [     T47] nvme nvme1: rescanning namespaces.
[  145.964143] [   T1170] nvmet: adding nsid 8 to subsystem blktests-subsys=
tem-1
[  145.968553] [     T47] nvme nvme1: rescanning namespaces.
[  146.175760] [     T12] nvme nvme1: rescanning namespaces.
[  146.244652] [   T1192] nvmet: adding nsid 9 to subsystem blktests-subsys=
tem-1
[  146.247719] [     T12] nvme nvme1: rescanning namespaces.
[  146.401390] [     T47] nvme nvme1: rescanning namespaces.
[  146.439745] [   T1217] nvmet: adding nsid 10 to subsystem blktests-subsy=
stem-1
[  146.444734] [     T47] nvme nvme1: rescanning namespaces.
[  146.594520] [     T70] nvme nvme1: rescanning namespaces.
[  146.664986] [   T1239] nvmet: adding nsid 11 to subsystem blktests-subsy=
stem-1
[  146.670471] [     T70] nvme nvme1: rescanning namespaces.
[  146.908418] [     T12] nvme nvme1: rescanning namespaces.
[  146.943968] [   T1261] nvmet: adding nsid 12 to subsystem blktests-subsy=
stem-1
[  146.947221] [     T12] nvme nvme1: rescanning namespaces.
[  147.161851] [     T12] nvme nvme1: rescanning namespaces.
[  147.210748] [   T1283] nvmet: adding nsid 13 to subsystem blktests-subsy=
stem-1
[  147.214753] [     T12] nvme nvme1: rescanning namespaces.
[  147.360355] [     T12] nvme nvme1: rescanning namespaces.
[  147.397484] [   T1308] nvmet: adding nsid 14 to subsystem blktests-subsy=
stem-1
[  147.400494] [     T12] nvme nvme1: rescanning namespaces.
[  147.613474] [     T12] nvme nvme1: rescanning namespaces.
[  147.649746] [   T1330] nvmet: adding nsid 15 to subsystem blktests-subsy=
stem-1
[  147.653014] [     T12] nvme nvme1: rescanning namespaces.
[  147.865652] [     T70] nvme nvme1: rescanning namespaces.
[  147.943941] [   T1352] nvmet: adding nsid 16 to subsystem blktests-subsy=
stem-1
[  147.948243] [     T70] nvme nvme1: rescanning namespaces.
[  148.165636] [     T47] nvme nvme1: rescanning namespaces.
[  148.208798] [   T1374] nvmet: adding nsid 17 to subsystem blktests-subsy=
stem-1
[  148.211926] [     T47] nvme nvme1: rescanning namespaces.
[  148.421937] [    T175] nvme nvme1: rescanning namespaces.
[  148.460826] [   T1396] nvmet: adding nsid 18 to subsystem blktests-subsy=
stem-1
[  148.464611] [    T175] nvme nvme1: rescanning namespaces.
[  148.673565] [    T175] nvme nvme1: rescanning namespaces.
[  148.749035] [   T1418] nvmet: adding nsid 19 to subsystem blktests-subsy=
stem-1
[  148.753873] [     T12] nvme nvme1: rescanning namespaces.
[  148.951798] [    T175] nvme nvme1: rescanning namespaces.
[  148.991674] [   T1440] nvmet: adding nsid 20 to subsystem blktests-subsy=
stem-1
[  148.994726] [    T175] nvme nvme1: rescanning namespaces.
[  149.202944] [    T175] nvme nvme1: rescanning namespaces.
[  149.238560] [   T1458] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"=

