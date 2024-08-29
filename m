Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22980C7EE31
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9rqFZYI3TedwX/CVTjQmh+2om+Ds9AhbvgXqQGAZ6o=; b=IuZQ6BDerPS9qqdxzU/DjigodW
	DhinEpuZhw432wAeJ3mahiSMne2oaN0gIvYhr9Ylne/7aZQ9/9HwKZjSXD305O9W/MGNynXjnnHDD
	vX13fDB+uQEgdMa9gqUJJsJ7FrbxYjmKZJQ8H3UUFYKJOP0qCOskiXdFNDFUjqWqZpI+VyCYVGZET
	95jTXFpNVpiUTGrysBYdRDqvWcaLHXI+6hAsHe8+U0CfkLsODsVoLiSLOvCyicxBCZGMx9KR6Vdhd
	A1FJLcjrrAMxv8NC7GGBExua/W9v9c+LBZTknDA0gWgsKWuaiyF7/xD6fwF/jhEAiLeCJfWO5v+ON
	llVskqEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjZhl-00000000z6w-21PR;
	Thu, 29 Aug 2024 07:36:29 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjZhh-00000000z5y-2MDf
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 07:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724916985; x=1756452985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+rNCKRJWUH/gKXqYud3VtNjMrjtTYCn5en5YMhmQYyg=;
  b=YxrYfUsaijZadKLD+lSxTNhaWPISJheGLxazoSLh1lwbrxGx1IHcLn50
   Jvz5a2rbnl71NAtRC55AW8feV1bp/wQIVFKfPR19zhZ8ZmprPX921wxy7
   QvvtPBkByQU+kkra1H9pFeuUwSKCGRR83Hgl8N6o1/1WCT6hZXNM/aCqs
   5RL7p/6/lF7ELWe7AUifglmv0JEa9Z4hSJZmE3n/8mJk2PgGrj4GY8Ej4
   GcARBJ535BvKei36b7Gai5+4P4tP7hmvuHsfZxIOZJiZ2i1K/eo6TVbDx
   VTd+6YKxr8f5j8MVKo3tzylPmr/muA6JS2v2i19YXLf78E3zrFHyyzh8i
   A==;
X-CSE-ConnectionGUID: il6jh3yKS7CGbLe7QHfQsQ==
X-CSE-MsgGUID: Ja2RrgQcQwe+tQU41pFo1w==
X-IronPort-AV: E=Sophos;i="6.10,185,1719849600"; 
   d="scan'208";a="25484541"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2024 15:36:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkUcvx0ri4zl5Te6xKy05fT1ZDOuzI5oGhThnX9vkCLijJBazjRzMzH6sdpuQ3q4EsBZGnjQSJccYeXZvK2YgZzCsqPYGdZcP/WbUjhUjWmc+z79UeHTnDmceJpKWVsm3VzgvIdxg9o7bFXk+SflBKh5zL+tp/8QhVOQXngvxtaxx7XYhI3OEqQOFwnWUeMAu2Bel7v6uSo4MnKEmiLAWpT2nKgrjYSfJ7r2LABGT+8Ts06v1BNtESjywTtZpUtEzt8sEJ76AWk2sygx5Omcet+o7PBUnu+h31S5ADJiG8GKSCIqt0JNDcXwRx7iPjrYPvjxcw1IsXuGv36kE973OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9rqFZYI3TedwX/CVTjQmh+2om+Ds9AhbvgXqQGAZ6o=;
 b=jglSvcTQNTRIBfn1aW2+ZK+Z36qZzPujFRHJiDAhx5pXze/lyVDS0P6SfaHnd6dROlJ5d0FUDe1nOv6AQLu0FYVdfvb7hJ1MUoJxdbeYiJNPpQj7vssBXLdnyUn6pEjm2w7q82mhmJLMT23B0tiUOfzworIFVY/CwwW18BQGMbqitdPNkhS931YZhfBgmJ7cQqOg4kdQmS891c3S1gpOw+3vtkOhL0VITJ/xXdxgf3VRMPMTT8RSUoJd91MUeVEXdOl5vdy7q+J9GaY8qiuFLvdkHyFSeA2G4xJpwjRVBSHG2FSn+E9tcSOwLII8tZaqS2LiabwqJjTChI21OEyWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9rqFZYI3TedwX/CVTjQmh+2om+Ds9AhbvgXqQGAZ6o=;
 b=xzYcZ9gFo90xYGYcjkgFqWX7i9BK/Hj+pOi2VP3A6meZ4HGCO2AHFUN2PQh9FJlvTyg2EAJCLxyY5xGDSad3FsQVzahOWcjagedHZiuN2HsxbzXRyECWA4sXkCns7QZPg5qzF74C2HC3OlQlPF85Sy7axmYASPYmGcvf0VhQcp0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7869.namprd04.prod.outlook.com (2603:10b6:a03:305::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 07:36:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 07:36:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Martin Wilck <martin.wilck@suse.com>
CC: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Martin
 Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
Thread-Topic: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
Thread-Index: AQHa9ZhNW/vrdcNHu0GOnXkEesSR3bI94Q6A
Date: Thu, 29 Aug 2024 07:36:14 +0000
Message-ID: <57yxf7o7zcp4j34cfgk3glhmfag4ukvedzqgtr7fbqdmy2gvsq@t573offeg3kg>
References: <20240823200822.129867-1-mwilck@suse.com>
 <20240823200822.129867-3-mwilck@suse.com>
In-Reply-To: <20240823200822.129867-3-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7869:EE_
x-ms-office365-filtering-correlation-id: b36892cc-72b5-4685-75a1-08dcc7fd42f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BpohAbmVLjZ3WscEtZCt/6TRzqutV7AStkowsmtl+oCODP54DD7zWwJonglh?=
 =?us-ascii?Q?O2RgV/Skd8uSYD4ggRR3VhDHzpLYDeY5VtyKHiUxzZmjzKNOs5CiuS+wXJN8?=
 =?us-ascii?Q?yWpAgGdpKJspfHlG7GvsoOf0N6qv3LqJDhj9OJPIO08l9/yfy22ymgJo6v82?=
 =?us-ascii?Q?HZu2CNWULnkkKF/2NlMQqVEAAL9g47ai6rkmHRaWm+Xpd9HQBh7qDXsp7k0v?=
 =?us-ascii?Q?R2Hhwj6Ab0B5IiC6dZGL6KZBWKmIqx3DWyMeCr2LgYY+tDeEpyLg9kPIy16V?=
 =?us-ascii?Q?do09jghhX8+CsveGg58UVEpis6VGnTZIBr9Zcbj0fsGn57b9D4x7UY5R8AP5?=
 =?us-ascii?Q?7xQtMYeIdcLWd7LJ6l6zM1LyKjdPfFCebrHXdeE+P4vNRAkENFAgVSabAC23?=
 =?us-ascii?Q?xZP2k614KIqPg012wV4KSY1DRrvgb/sz67L8+SxIrBAtIfuI9BqOFt7HRPKg?=
 =?us-ascii?Q?yi8CWXmPT2pBaZnyKuETRM8jGopQZLhDY5QXXiUmr/ithjzx6K1avmj9USCO?=
 =?us-ascii?Q?aknSgJyPefpxwfeUIp+8LBdwN+4rIhGZ738JfsJH/xMsK2NSkgdz8Fr6DEWU?=
 =?us-ascii?Q?Cn3xk5XE3BFLzvtZQO87mvbLuYdete0G3NJdvIuyI/NRbIt5UaeGjEomAXxZ?=
 =?us-ascii?Q?5IEr6npsx+YwQfqT8Ods4w6VEep6YrVw0aughGj/fQmpsu1XJewaqz7PLIWY?=
 =?us-ascii?Q?r8FVhC3byygEpFHRESXQI5ExYMxVyuOBrXvC51p4KONFtvDBgerk/wnVXC8f?=
 =?us-ascii?Q?6AJMCb3to3WeWo8zchQPRPZbDZEWwzOgBCxaOFKthm4aSk938IOluZbAryXb?=
 =?us-ascii?Q?pnVqZHa81S0b2bS9LwgYoELsiuIi022Td9PkhGeQ7a8fS66vE+DD8vODtXnV?=
 =?us-ascii?Q?3syywW6MEJerjm3LWa9X1aGzkbgOmaw3zruDCJq4GBRv6KvpwOt0SLJSxYYP?=
 =?us-ascii?Q?UmAsLNs9NRCw0J7dVEcamsWd00WoAhHFaT/WOQgLkGiCSIHAvd2vT5aAaZJf?=
 =?us-ascii?Q?YB4Ob8ot17encSWcRGrJOj3W4q387iYWxfn3Mf7g9zHAY+3t31Nl4stakmQ6?=
 =?us-ascii?Q?9gi4pMMFkH8gTxTHbXVZdbL+QxQ5J1SrLtrZbcE7ogyA0LBfTnA40lGM08AZ?=
 =?us-ascii?Q?UINKBHLkcdno+sGht0q6lXiOxfh0VgwaHVc8z+bhd2zjaTMyLCA8qRkzHzkD?=
 =?us-ascii?Q?401WKLIk6XtLtpurYKkNIzuenKfeFWBYidm7RokHSRCG2EMODGi5Mq9nAHC3?=
 =?us-ascii?Q?gOGP5SmWCg6kDb3cgplnq5HMltk/S8Wvs+9z/gqmeqlURJ5R1lZhI5OXlvO3?=
 =?us-ascii?Q?FQleB1zozPkU83p+8djWRFBZ8zQ54KKvDld8/biGDLUgn8WSlr8S+8hGalD2?=
 =?us-ascii?Q?dtjKPIw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7w2Y4QJU+2iYF80/S97TR75RHa+5LPUm4cxgZ2zZWNlZ1FNa8BYPdjDC5W4k?=
 =?us-ascii?Q?z3cqoR1mdwr1rwdOv00TMu+crPEYBa3aoNrG95+mxw2wNd+m6gERreH+BIg3?=
 =?us-ascii?Q?xA+Lrn8r3cAbUFy3bqBPEx8O62s08/6/La68YH13PR28p3qB149X19fIldgm?=
 =?us-ascii?Q?lAUHTQOyMtpDxpoIRbkKT+OZa+qcEvdOAshX3AU3k6txvfrVIwtHBDZ/iJ1w?=
 =?us-ascii?Q?pKuht1kiukNrXF0stsHBByLIz4z9OOXCJ+pKRu5FLzIPZboRBgfO0FcPgfKg?=
 =?us-ascii?Q?Qbh9X5o0PJwtuuI8+fMC0OkxXwdHspdUPZ+XbSgsSiWwm4Dap4FuSMtMwgvj?=
 =?us-ascii?Q?S5el4eJBgDzdZHeG7AOh+9eGAs5xyaLF/t7gH1ed5VgspPseOzSuIWnDpeZg?=
 =?us-ascii?Q?uhlfTH/ravc3XchZiEQavQuQY/7igAEjn1jXbQ7dq6YjQKNX/qg8RF5DIjee?=
 =?us-ascii?Q?HmKFzh7qzLsGdFRaQJaYRlMOwZXy6SqZ9eWJtm9r1QqvaAsfCgP69DcWcazV?=
 =?us-ascii?Q?ws7f3eXpYD0j+ciMc8EgAPPjBJEQFqEhSvII1hls2OJv8zlvXWsNyOritFNM?=
 =?us-ascii?Q?SIKXzHIDxe2GaZmSPMvoDDCstd9+KeipHp9sTEekNFk8pvOCGgx5rqmdbaRh?=
 =?us-ascii?Q?U0VPkDzquKN9JR6JvCTzr7IpI0hf9PnPnN6mUDz2S2VNfKN8OQysUVLDUq6p?=
 =?us-ascii?Q?l5iB9OwGCHxjp/ZbZw6PznyzMvu/kFHUin5Tsp1nD/+jBNO5pLoCiqnLspF4?=
 =?us-ascii?Q?0MFM/bEui7aUS+qyYvn3VqDj9khnPDNpFdgOsfdHKz1BLB0nwJWv1czJlfMf?=
 =?us-ascii?Q?uI+5rTwtdpGlXVRbMWwLq292ZjSrHONpozJ7HMz+kUYkQb1NlotKjqPvqRkW?=
 =?us-ascii?Q?b0YIW464esMCFY8tXKE5oqfjBF++u4dt9GvI/vEi5XYPufwoOg1KOVHIJdkn?=
 =?us-ascii?Q?KMNylV+QFMD6b715u27scOrbSAEn4n+QV9BehzTC4lbkWLCSlZpnhULo6vq5?=
 =?us-ascii?Q?Lb+n+AZBWlb7xz3ZQGTNJPVbdZ9QjosjdaTKOtOVNq9dFRwroQ8+aQb9GagF?=
 =?us-ascii?Q?/nmTRtP6urC7Ih/NT37HFge8Ip0EL06MWQC/SvFxzhHwlhGCxYtmQuKHXaPZ?=
 =?us-ascii?Q?fNOtcvbkHsa0ze5sqna3Xy0BqppYWOkhAXSL2GfYMjZDuBJy2HWPN7z7OXHt?=
 =?us-ascii?Q?65M+ipqj2wWZZAOXaas9P11IEr0YhM3j5dS+tWjFLgqipaOi86c+WB1EnCAx?=
 =?us-ascii?Q?1XZT/Fzfwo2alfbjX4KmjJQD05V1Cd2acdE87aAF7FRHXDWadBeZhyZwuzJm?=
 =?us-ascii?Q?oHGu/qXhJ+v01jRUUTRUn8oNnutgau/GAFVd3VAK6bDpWxVVhaEqx+zxYWbc?=
 =?us-ascii?Q?yNoS4g0QKVU+jK/jt9xf8Ce0/iH4BPkOepKMbDQzNYWqf5U+4DTa2tfOaDdZ?=
 =?us-ascii?Q?SXPDBeNz/HX7ilqg+RTlVVyYmAIgxkMiXf+omgvmaBA9Em/OsKKf/x9OPsi1?=
 =?us-ascii?Q?wTc98LupMubdyJUJb6P2+ZIvwHIvVTk2byNMgiuFfsfdgdoI6+Z7W0ELOEhV?=
 =?us-ascii?Q?G08NdvcqTQe7j1Pr8fieQxmPLo5gvyK1qagvfXImSy0PSAKL5sKCKLnvUA0N?=
 =?us-ascii?Q?hNcpWHZmLuYQFnZXMr12oRg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <393A6D84CFFE1D4186D6D9D84F07DCCE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eMIjFVlJjiuEicmspitV4K9/ijnNGPLkwU9Xzi3pe3iXHGqFvUF9Onqv6oZYBoYZfTtvgIaheIOEYJ4F2hOPBTB0Q8FzKGHeJyvzwxtnOq8wuw47HFIhHbfwuUWi+C6fRO855CErVeyFDxhDNltkDFiYT7YZXpGiQ+8sucWoNO/UrfY6o/rzmcYP/jgaPDXc3VQcI5Sh7pS9rrUJY1X0iD48ocH3ICsaB2jtvxO+TSxbssZFSreKgPQbgbYbDtbqo72dwMlpf3kbdLPhx7ZvwVoCRMk6lhsokzvzHvelroroNbfPjlBponi61IYCrvM7CRqeg+yADxYD3uzoliXgkR7UJ3ivWMg8DqQqYS/EzzqVWxRMkwDt1gMfBED2kxshD8kSJ/8hpoevo8LgUqbrjsW3nb2HCkt/n9PTlAMk8eb1uEaekHVrxsM2yqHrZhdhzwjUAoqLcdSoZq+tWx5S0oQOOF9Aircn4PQ/AmJ7s9HIpBo3bZnSO8xMdVCHxQALN1s0tzs3sAyb55EN3bjJkSOL50yexfQ1iH1oDZ7cHmRe1sgw2A1YZATWa8KbSwa9AHgXCepov7EEh8tR1oGLz/lrNX5d7wZvh/v9BCUH31KtUp3dwrLvUA+0LbPMYPLU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36892cc-72b5-4685-75a1-08dcc7fd42f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 07:36:14.3654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zT7xfEM+1jZgaaxvzQnQNU49xB1Acuz1bBANQ1JWWy9AgyRjaatt6h3UhcSMXLfvAha3FQ6zjjU0YTCZlz5nRVhlCEN4C+dCdE1ckPkX24g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_003625_698426_30C42F72 
X-CRM114-Status: GOOD (  26.47  )
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

On Aug 23, 2024 / 22:08, Martin Wilck wrote:
> Add a test that repeatedly rescans nvme controllers while doing IO
> on an nvme namespace connected to these controllers. The purpose
> of the test is to make sure that no I/O errors or data corruption
> occurs because of the rescan operations. The test uses sub-second
> sleeps, which can't be easily accomplished in bash because of
> missing floating-point arithmetic (and because usleep(1) isn't
> portable). Therefore an awk program is used to trigger the
> device rescans.

Hello Martin, thanks for the series. I think this test case is good since i=
t
looks extending the code coverage. As for the rationale discussion for the =
v1
series, I suggest to add a "Link:" tag here:

Link: https://lore.kernel.org/linux-nvme/20240822201413.112268-1-mwilck@sus=
e.com/

>=20
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
> v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
>       point arithmetic and achieve more accurate sub-second sleep times.
>     - add 053.out (Nilay Shroff).
> ---
>  tests/nvme/053     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/053.out |  2 ++
>  tests/nvme/rc      | 18 ++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100755 tests/nvme/053
>  create mode 100644 tests/nvme/053.out
>=20
> diff --git a/tests/nvme/053 b/tests/nvme/053
> new file mode 100755
> index 0000000..d32484c
> --- /dev/null
> +++ b/tests/nvme/053
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Martin Wilck, SUSE LLC

I suggest to describe the test content here, something like,

#
# Repeatedly rescans nvme controllers while doing IO on an nvme namespace
# connected to these controllers, and make sure that no I/O errors or data
# corruption occurs.

> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test controller rescan under I/O load"
> +TIMED=3D1
> +: "${TIMEOUT:=3D60}"
> +
> +rescan_controller() {
> +	local path
> +	path=3D"$1/rescan_controller"
> +
> +	[[ -f "$path" ]] || {
> +		echo "cannot rescan $1"
> +		return 1
> +	}
> +
> +	awk -f "$TMPDIR/rescan.awk" \
> +	    -v path=3D"$path" -v timeout=3D"$TIMEOUT" -v seed=3D"$2" &
> +}
> +
> +create_rescan_script() {
> +	cat >"$TMPDIR/rescan.awk" <<EOF
> +@load "time"
> +
> +BEGIN {
> +    srand(seed);
> +    finish =3D gettimeofday() + strtonum(timeout);
> +    while (gettimeofday() < finish) {
> +	sleep(0.1 + 5 * rand());
> +	printf("1\n") > path;
> +	close(path);
> +    }
> +}
> +EOF
> +}
> +
> +test_device() {
> +	local -a ctrls
> +	local i

Nit: 'st' can be decalread as the local variable too. I suggest to add anot=
her
new local variable 'line' below, so I suggset "local i line st" here.

> +
> +	echo "Running ${TEST_NAME}"
> +	create_rescan_script
> +
> +	ctrls=3D($(_nvme_get_ctrl_list))

Shellcheck reports a warning here:

  tests/nvme/053:47:9: warning: Prefer mapfile or read -a to split command =
output (or quote to avoid splitting). [SC2207]

It is a bit lengthy, but let's replace the line above with this:

        while read -r line ; do ctrls+=3D("$line"); done < <(_nvme_get_ctrl=
_list)=

