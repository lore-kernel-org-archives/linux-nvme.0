Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6762C0218C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 09:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuFFdZt1n0CUdldxzmAQr7Wa+FBxivQcIMVou+uV47w=; b=oYl3XRWgh4p9rJP9XCjA7lUvuT
	0FOBGXhu435Y5VGRjckv/tFa063/uZcrjOvSbCF4wq6mtlan/dMkNa6GE1IWDwNB59N+bWx7wYVcS
	FF7aDx1UhG45za2CKYNXGkcReA/kUz7X0mO5CAiETIUArCqwwYQaN6Wq3J9k4xrnpNdnmUL/9yihL
	yo/0mYell7ElNMHMcNrrkz87zM+UgeNy5WKXH9EWlfwU9IG6WSz38dKI1lB3oZ14XJidmYhzjPULm
	erP+6D63W9qrvXopApelni7Hg2XyLwrzKdZu34WA1lkEqN0pHkSVmR0bh4bNaUiqUETNDa+s0DN++
	7hjIi9Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcL03-00000001wu5-1u8q;
	Mon, 27 Jan 2025 09:01:43 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcL01-00000001wsw-1GYi
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 09:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737968501; x=1769504501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UuFFdZt1n0CUdldxzmAQr7Wa+FBxivQcIMVou+uV47w=;
  b=qlaSEjkhQ/MY9yURIUFaqJ5xEDZ+1GlZm0YMEs8VJvsdHxc4CGgPa3+a
   hlgtLrPnGOZUPOqDPVvDjOFIlESmbnnnS5jeg1M6gpWIBayAvzfwKICfM
   yXQuWqjbhKSv9/bcArHzvCzK5jvIvRyXvnzXHZXdQpnwYzxblpTvR44CT
   AQSc/yMk4q62jCJQVtm9cGqNPFHZk95FLZbOKvjEIsa+jk9LR4nyeMGfM
   BJbVuR6NJB/xV6i4OC40UDiskF5R3bism/RYF0yUC/iKaXfbMoy4f9Rzf
   8QEciimwYBPZO6FLtJJzaFv3n7iNuR/WE56hCpDNVaB/y5tJGg0dm7JHO
   A==;
X-CSE-ConnectionGUID: xpipxvTURfOS+N3TvB5c7A==
X-CSE-MsgGUID: X9UWPP9DR4uU1+BXTymAPA==
X-IronPort-AV: E=Sophos;i="6.13,237,1732550400"; 
   d="scan'208";a="36273751"
Received: from mail-northcentralusazlp17010006.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.6])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2025 17:01:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idwYE6pMs5ktx8IOt+92ZUQ823ZMySxWLiya6Q6TaS8L+7gxk7uXgCHjfPzx17RGzXwL/QBHlp3o7mPlgZqP5FDOjtggxra6ST41hoDRYTe5LVfivrQTIPCiy1WWdkY0W23dq+2DngHukufvau+5m9BgtB6g0Yjbh+FIPTK1WmOO8gBCw7fgGK83I7AtZ/9OZH4vnbF8W9Wwq0+icy3t9qscucDOgj+Xm8jKKUDJ2vuTz9X0u+otSovQYUaP6Gy8N348Jrc0BRPUc91FTceYTXDpXVKiMbxfdm/hUeaid+6YWrkn2tMEhpkuUZT5ZWS5J8ufAdj6E1Zka/yNwYeouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuFFdZt1n0CUdldxzmAQr7Wa+FBxivQcIMVou+uV47w=;
 b=apECYVhfZrNqTxBwTEGpOPXN9l7XZqbQ7A7s0vIvTLlEwYNwoDS00cWiORsiRDnC3BzOwIPa4dWzVe1QSfQqCySgppxUwMiTgLtmJWm5KmhuuRE6u7Ajg16JaJBbWyXfMFXeaddZyjzZaS46nVvMcifPpuL1M4FRafHPyKB6ryAeUEDbVWlXvLdX7x3UcOXinZ4vI83OQmVFxRCnw+FGmBiFC/tEuIGUqYnhX/CRHR0ua+swNBdePWxLcXS4fztz4Gqmi09SWZLWaC8RIbBD+4LYlLhK8uYjTfwIl706MXXo0ZNU0swGkm+1GW8nX8QMkQzdpdWhlxRyOwc1c/6xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuFFdZt1n0CUdldxzmAQr7Wa+FBxivQcIMVou+uV47w=;
 b=b2/Hd7PnMXKNorrDN6IxV9NqSL6lfmXBubaoC1JYTGa4MWG/GdFD518YayD7gwnkyh2mgtDXuMFq2+DT7qyLktJMlCtsiB272l1LS5DxyLFl3vo99h0e5f34ORQoP+yJbk3ALONqpBbEoxcAxzv64HkC00TgWdSe0bxpr0k2+t4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB9319.namprd04.prod.outlook.com (2603:10b6:8:1f4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Mon, 27 Jan 2025 09:01:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 09:01:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hare@suse.de" <hare@suse.de>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCHv2 blktests] nvme/058: detach loop device after test finish
Thread-Topic: [PATCHv2 blktests] nvme/058: detach loop device after test
 finish
Thread-Index: AQHbbjROsB8St8AWK0a/SJN5A1OZrbMqV7mA
Date: Mon, 27 Jan 2025 09:01:36 +0000
Message-ID: <suag4fwfxylrzovyclv74ewui7y3te6o35tylvmdbwzql2tukg@pvvkqs2hkejt>
References: <20250124074753.9802-1-nilay@linux.ibm.com>
In-Reply-To: <20250124074753.9802-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB9319:EE_
x-ms-office365-filtering-correlation-id: 9bcf3877-d8d2-42ae-9ac1-08dd3eb13487
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f8w40ls9wsTM5dw3MEQkCWZF+KKo7HJRwAY6E3aAt2vcwRcYp8ukHbP73SsE?=
 =?us-ascii?Q?LLqLped0yRlYxcu9eStVItBJbqeiLpR1uXuJvGRv3SPCLrjeAjvZjJNptY9X?=
 =?us-ascii?Q?iexgDF9e3lfsFeM4ov57bsyrkNzMMYEC7aLdgfQIwMrX4aZTAB+pi3m3nxML?=
 =?us-ascii?Q?SbOmJHEatuq/ofTr/pW45chG7vGG5Vm6BDdfIwoZ+Y2ZGQwJlO14OHco3CxT?=
 =?us-ascii?Q?y3X+GgL2e22ufBMZ2RXtA6URcbEPjvOCtZcMS9+ySsyqlFNIT7KepsKpzPad?=
 =?us-ascii?Q?Sa1gIiOP1qzU0obpKx/JMDZtaaTgGLkIc3Ni73gjgOuu2NJlBdaSKG6vf8ux?=
 =?us-ascii?Q?7cCXpXC2qtRtkIKN0+bqQy37g8Pm7frGT2jvMWrh/JIn5r0+6G4fSjSWyIom?=
 =?us-ascii?Q?m6ufPYk4c4ZksEP9jPjrdhorCXdTMJcEINpUQ6O5xBOThhjri51y6h1KKP4o?=
 =?us-ascii?Q?5++uqRMk6O9vRHRl8xI35NBoRACDujII8S9NJg9vzqrnEH7nU3nEEGsBZCNQ?=
 =?us-ascii?Q?B0TohGMNtPE2If594crbQCD2l6y9dU7VE1ltSv8Rj9BwjwICbWiOytAc8ATP?=
 =?us-ascii?Q?KvcQuTP3hNdJjHn09poQeH0HxOfyjDMBbYbHrcuMs+gGd+35r6VYhuN2dCfF?=
 =?us-ascii?Q?tnebICgozg9ZF9Fc9HYXsHPAlzcYGMxk5vojKg1NRxG23yfyP4bTt25kw0dK?=
 =?us-ascii?Q?7153RUfeWDdEx3KAbMyrs7tTsg5/dGJDLJKq23NM5FtytVUpsGfRSVKd5pQR?=
 =?us-ascii?Q?+dnNEIjRh0PN6glBLx8pzeIMm5R6hfOOAXEdpnYM6fyhLLcWXbSySBsKaaiY?=
 =?us-ascii?Q?Du/WM645tC8cKGRZB5E/oY6/+keq+2yTle2OCdxBxLYNaH+PVmdEjkFuqccm?=
 =?us-ascii?Q?G8KNEaK2RRrdUlqMYmVmpPtrJrEIKwk9k2/oHACPWlXmQH2xei2yN7PbIcE5?=
 =?us-ascii?Q?1BlJMd89nE8p4N7olWXrtOUGOpvSsUTwV/d9NJqkk56CaJp9ggkkkjSO6PK2?=
 =?us-ascii?Q?4nLq1JzkTKJTQox8kfRgpNRMCO0XO+k3FWGg3XQBpkszACRqIh6IYSJJZ83F?=
 =?us-ascii?Q?t0rXsXYsAaDqkN1KZ8nyre4sczQ0hgyhm99JKAlLgI5RrOEaKol6bXYlk01/?=
 =?us-ascii?Q?8qS8bgVnVCpDpIyDkVmkTh6xsF5qXrIjvQOoq1VsEoDpXU655zZ6sHuwrl+U?=
 =?us-ascii?Q?RoZ0Xw2t6UEEJtleMKMNNtecWykUTvDJpaBi21PPNH3dsh2Dz8TahqS0W9s1?=
 =?us-ascii?Q?0JGSpkRbSkxRmZGU9LANjY+9DQZOiygaYkvK+SzMPi/4Fa7O/yddDOYzQSID?=
 =?us-ascii?Q?JWxrvfgmYE4ACJH5xusAv3rYc3PgOxBBhOCANvrf1VlcXizjDPQ3+Mnr5gkr?=
 =?us-ascii?Q?K76Mc1bexSKD5WGHNmR2tDlLnSDTgdA3Lu/QaXH3cD2rSBPrOSZELD0ylXnQ?=
 =?us-ascii?Q?ivkST5SrqhToXRQFYklryuwCHkY47nGi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUMWIfO41Pyiz5TuvV52/gHAFHPbS+LOT7vAtySWx9avoKjT4GXmeAmtGOKB?=
 =?us-ascii?Q?uRFuWJv2an6E7uvPsAQYQHidIdh1iDPXlw8MkhlTYd6lIhi9K7GRCPhVBScG?=
 =?us-ascii?Q?dcxdkLghoRnEib66hh6/Q7KjjqvKEVTbR9Vl0jtrFu6SIskCshiNO+bouWnT?=
 =?us-ascii?Q?oz35wIphlXIg/ETPBdptHNc8EzxeuchMJY+gx+abwOIt5sEtqYjA/LjvzP/q?=
 =?us-ascii?Q?IxksHD/1XcG6tqlGGC49SJG9wOmp55a08UEyz/WOFvlllMkfCLt4kaXomVMN?=
 =?us-ascii?Q?z4b6Y6YOL0hk4431Gaw29jKhDZ9q+00Z8JHdkUs6lRVaCyqbRTjfI/a+/bYN?=
 =?us-ascii?Q?YIqrirc39N6l2w3rooS7acMJCViPI/0+BOmdGJQHGtTOGh9o7plGp4bdTTrH?=
 =?us-ascii?Q?mw3DoFlSYxwDzaKGJ2EOM9e/Yug+UHJEZH/6NJeOu3Vxg3pJbwgU58ieD58w?=
 =?us-ascii?Q?ieFYlUCT6QFbsZk5tBHDLEmc5R/yMYhd87VMEn74yoBNf5S35ETabnT2Lxl8?=
 =?us-ascii?Q?2hTWRWdb3eiTS0+lqVpEuQKdTYiTRsvyJgrVkX+6YYLjNadu6LT/YmaQ55Ah?=
 =?us-ascii?Q?3gvdBbWkMrxRTANQjduWKXQNA/nhqwSTQfRCggx6PM4kRhSoj3Des+TzMyD3?=
 =?us-ascii?Q?OMUDAOGAcSzUMUEj0VQ9NVB6fYa3LgFPoO7rxMkKpVutWm2PRlq7JmCoJhoe?=
 =?us-ascii?Q?hG5NGRe6sO5cbjHl/vEdnrGGte9YHsuj22U36ZOsSYyjgJ6TbtS11qyJJj8a?=
 =?us-ascii?Q?mpbq+RrtSmaenMnNyFEJU2/xbGpr2fj8I04PjvOm0V5IxE7a+6XvTiE/DgiB?=
 =?us-ascii?Q?2Sy2IX/nXkvzRADba3/3jhsL4bxiet0FvKpYcJvHEFAJgdh5MS2ilMZKx0Nq?=
 =?us-ascii?Q?pa94aL6KYQS0HnxHrL1vzkCh5tPU91LjWSapFuuEXEPsLKWgk2+kcfGhtKio?=
 =?us-ascii?Q?hPcAZPLetAps5HbK8JP2VfqlYFBQ2pV9wKVP0ubFfHiRvQW1vf5U/6yN1TbB?=
 =?us-ascii?Q?eDqiNUk4OLG9iGWvOggmmEAdVfEgBzf8JdTvZIL76KhIvGBR4gL8zGkNViQg?=
 =?us-ascii?Q?i8JZ3+9SnLAMHeVwqB1+mQJQw+j7HfEfzrH2H3QQBJ0xT2i2j7BynGJR2+iM?=
 =?us-ascii?Q?79EJuF2L4fiBkiMefKH6822pPJrimyBxQJJspCwocjNjH9J0EWNOmtg7QDIy?=
 =?us-ascii?Q?Deiz+zEGa6mHW1Tx99RWlsHKfj7C2vgI2b7v198t1KQzT51w6pKrLJJN1LHy?=
 =?us-ascii?Q?XWGFkbbX46A3hnpFxba2qjB4inoucykPf5iql22aqAs6AgBBiqioB+yQT7/5?=
 =?us-ascii?Q?iccBF8lfGatijC+2EbtOGGdpQtykanI0iXfMQnkiyVuuOVN6rJjZt4boKFlF?=
 =?us-ascii?Q?4hIf/0XMvCRUdoBGzaYJ5XB4Ag4y1Fj3n1OFfFARjLQc1XDSsrVN2NE0fwoU?=
 =?us-ascii?Q?wWVlXFJQZST04qZZfEiw4WrdJjBY4x9IpBWLnVq0/tlXljgwf1gtVRhY6h03?=
 =?us-ascii?Q?N/vpAm4Eq+19reNALRPJVghbWyjtEWwjHy/R6iWv52VlCAZfm86+vAjUYRpo?=
 =?us-ascii?Q?3j4oaFKhO6+YAnbeB/hR1yhwAKfpZycxv7L8extnu9sujpq/YLVLkR0civ2D?=
 =?us-ascii?Q?vhPwrmr8fZ9EItslkq0YsRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4EBB63BDF26A54C840A68CF7FEEA415@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TFDL3tHQpX9gqaAzCBppT0NP5F8bWBIvarpPn/3JxssNNGPYlSMAiUitIXe34PdUHwQMURefNH6BM1VGC4Rl/8N4bPeQ5ZYDSgyzxYj8dUqtckQ7COt6iOIJCQSufaZcp6efjJ2IpCrvzs10AA+UDRuNqfvRVHRsEc4+AzxNHNXhZZ6X/fDRiwGpJNoqB3Fw58aAoOBFgQNkl9K1iJJaoWt7ukt77a3BzD6PJG+/KcRAmDAF4xSdLYjANM79NCz6kPzlweiry7MsNzpW0Km9uMFIcFx9Vl70VfaA8knsLyaBhbmASZttsA9BFmjQ1/nmbrR1E49OuJto+bF/brfMCkWp8e9VIzwCtn1EKllepaIfFF9sXqvtSaui6IhNEHMrvMquwL+vG+5YztmDtlxTqZTvF6jtXaM/ag3ifFqkw27/5wfsOm71GhEVpB0X5+6XTAlrV430GyMwfGMW4Q6+0WltIOaWHkOSGzfFFVgVkA/DHef6yMWp9FoME7rxIbXctdlXy69zEYGjOushnFBQ6dmudrOWEw1qCq6S3dmK2OWx0pgvgJLxF6p+ZaS1MgemaLH3yPJ0kU2CuAaUwLNWiS13wxADRoTiOi8bo5mn0lM/9ZUFdJUYZn4oMQnsf/Y5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf3877-d8d2-42ae-9ac1-08dd3eb13487
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 09:01:36.7768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcJgICfQxqTeFJgkVglqeHuGH1QQcapGvCvj/Fjek5yO4Or5EShWhD4ivz4lAwFivPRhGjqBdP202t4lvFxf5Rwu8EIqTiK6xkIuglqlMNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_010141_413216_1AFAB910 
X-CRM114-Status: GOOD (  11.16  )
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

On Jan 24, 2025 / 13:17, Nilay Shroff wrote:
> The nvme/058 creates three (temp file backed) namespaces and
> attach each namespace to a loop device while starting the test.
> However it never detach those namespaces from the loop device
> once test finishes. Ideally, we should detach loop device from
> namespace so that the associated loop device is later destroyed
> and its resources are released. This patch helps detach each
> namespace from its associated loop device after test finishes.
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

FYI, I applied this patch with a slight edit to move local variable
declarations. Thanks!=

