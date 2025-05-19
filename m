Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC9C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fspBJJK1VV5zntksKVwZ3K1AtmYCURAxD5smVEio9WQ=; b=oByNw0dV8ne3O1xlDhrUFEN0PL
	4083p/82O/f84o2Azpp3S/WcinpKu+cBol21Nv1nMPDtojn3pF7kDkrcmq1FNlV+DqYXXhGkVxHy3
	OuFtRCxJiPbMwztuh8IeQA7jvweE707LJI2qtZQHB7wTD0npq8zU5CabZxwhXwBmMKYcFG1cp4pD3
	D3rq5pAP1hZh1oXh7b7UQMGpJC2RpY+b9C9k14qu/WvjpPvKm4Pp3czSK2NSEo52CzVS8v56rjoAv
	ytYKpiS0TlfwkIWWLfR586DiQJcSF02HxN0PRKNxLRFfwD5UDCuB/XgzJNpL4VL7RuFJ7LNqdbU3x
	zmlihDfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGyRc-00000008xjD-3LZl;
	Mon, 19 May 2025 11:14:08 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGyQN-00000008xaX-0lTo
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 11:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747653171; x=1779189171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fspBJJK1VV5zntksKVwZ3K1AtmYCURAxD5smVEio9WQ=;
  b=WfHjZeGtj8n9v7BZx4BLuJQI4GxfkM2U2Q9vAmmZlonUFzH5s57wsb/r
   XmdMiVbaJjb0YlH4EtyZntlibTo264gwtMUle3o5zrq766CNVXGTmQcyj
   1bbiv2bUHBX4aVOhJNzzs6qeLAt/qd/Qgg1sHkeUilAEVEMvL2udrSfTR
   lcM7v8uAzVd9yn9OnvpYVBpP/wo0HvSiYWy+LgpGjvBgdY6Qa9Kbl3zOg
   DF96NBh2fxCTk7QNL3hAHgQ8vqq2WUTrRKjzFT082XlVXex8KIHixzbyh
   fMc14ekaL/x/TfOOfzydQA9pY4mHBPNzpvbhAFDilxMFCBfp9XRKI+1zU
   g==;
X-CSE-ConnectionGUID: y68oqY0kTh+5f3RqG4PNFg==
X-CSE-MsgGUID: gRlhbeb9Tpe9gFgniMDT3A==
X-IronPort-AV: E=Sophos;i="6.15,300,1739808000"; 
   d="scan'208";a="82568092"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2025 19:12:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpedBDVSMW9Uy7dqpAM1UjgPYGIHANuBBhsnZpocLuGtUEiq03cTrzdfUkdE1stnKhIoGEk9w7V7zWAcBrA6FwJe7BnGcefyPRXqAxw5NksKVBkMgMkl/H+cKcmA4g6fxLt11uOalpByghSd3cDcmhb3u8qnAyEoGDkj3fNeMLLucpqxYU2ebXNLeKrgck9jC+ifARo8xW7rTG6H6H96r1dg4MDp86PTLVo3ZP6eaR6te1AGmbD41uPX9umofC8Aw/bIe9QylhZIRsTlJbJJ12aveYarlhJFvJBEX9P4CwQrPw2DLXs++7wvZYrTv9s7eNIj8lgryug9d52J3vmvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fspBJJK1VV5zntksKVwZ3K1AtmYCURAxD5smVEio9WQ=;
 b=NjlHkM/7iAK/rHVXgrF8orvQuNKNg9ZIeVeN629BWGXE7+oOK17Y/S8r/q/AaAY+uaLvblIIgHduVHSx6vYlbzKekaT03eUVb6Jx4bJk87G8J0oLIqrrAkGb3tvc2It11QuDbKMnK79OU7b0igPblO4RY+o3cwRPvK/wh8IXA8yOj+fFvQXKqqmveNPr9OBcUoh7c/iw7bjF0ciN0WYAkCLqmBSMyuXMwHp4UWnvEd5VwE1JYnP3+KAhIYBT/O/D9gPULTAAQTU56YkiNzyhyJyMRx53KsIWMt73QNonfpTsNSUFKvYXZvPYRYG9j9nBoBm72BqxwBlTEls4O+T4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fspBJJK1VV5zntksKVwZ3K1AtmYCURAxD5smVEio9WQ=;
 b=NF/UWKRzmeSY39ipAFocBhqRD/HqOn49SPqEeB8gk3R8YY8iiVSiz4surZ3J+FDm7yWnQ9qM/cS4bzTpCxewMceqv/h1fm9noNSfuQU20VELg/pD41EOV018UCpwhG4KE+Z2TorVvUORe+tZc24H/A+Wk5J0c9nDdLGcSKutM/4=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7405.namprd04.prod.outlook.com (2603:10b6:a03:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 11:12:47 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 11:12:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, hch <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: fix 'quiesce' imbalance for the admin queue
Thread-Topic: [PATCH] nvme-tcp: fix 'quiesce' imbalance for the admin queue
Thread-Index: AQHbyIonQLGbu0jm+0+p1jDjeA0O5LPZzNKA
Date: Mon, 19 May 2025 11:12:47 +0000
Message-ID: <edwxrc7iiwnttzkb4k6ftdy5ryxvqg6l7wtsspdcrgzd6way2y@oqphh4xnu3ua>
References: <20250519064913.114188-1-hare@kernel.org>
In-Reply-To: <20250519064913.114188-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7405:EE_
x-ms-office365-filtering-correlation-id: c029eb77-ef1a-4069-7cfc-08dd96c61642
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7CMR6rVERGbDiGJH7PJBlja0O0zPfyacGfeLMFIuqLDiH3UYTPlLlrtUYB9p?=
 =?us-ascii?Q?1vWEyCXL0R4CUfLWy3i98d3RWKFBKWPbm+WNL9wyswq+coCMwXJcyHzj1R/I?=
 =?us-ascii?Q?wGDsC+Y7N6CGEJDRUZo2A940ECj+8nt+UbExbVIfJQkhJs/axMSajyLKhQYJ?=
 =?us-ascii?Q?lmR5NY2F3rUABD0XNQAFxCbHBqDfc+9aw3WNCOcSXlZcNfACMxPDdBorF0sZ?=
 =?us-ascii?Q?+uG1RnIZs/o/rn5/Tz48IvRpAU6osXyVNXOPahnyxLCX3Qn49D5uC9RcGknl?=
 =?us-ascii?Q?EHOGrdwR6h+yUfKRACEfUMa8jNIkiJL8bQ77E79B2AnjcfVn1QBmJfXjKt6Y?=
 =?us-ascii?Q?a9mVWK8lJQyhSUZCRgFSqy3q2HNz8UFnN3lNTq/CLe7VjAX1qw3Oo9YSc2pj?=
 =?us-ascii?Q?l2895ZF4zbi6YYmY5yz+u7NiswWnnfnUGOXm6zDuuPTHPOEtd9Qbf+uAdm4t?=
 =?us-ascii?Q?TIfG9XdgOY8OP4GU7wKBkmPjbzh/O1zd5idBG4KOKBN6/TgNXsEnQEIRQf1G?=
 =?us-ascii?Q?jb/6Fa2foV3l7D67FpETHd5nXjSucKMhur4+ctXUpZx7sA3KdYLENV9GTRd0?=
 =?us-ascii?Q?VUzpq80xuPWTtzNZd/PrL20wj+yJl9muu5piHCcB6XxuKj+EuAa1/jyTsszo?=
 =?us-ascii?Q?TnGKRv4RkdtSwsarbiqpLJlz3Bqj2ZYB7A8xO2+3gTyJDZ8VrP4A0DbLZXeS?=
 =?us-ascii?Q?/rZiWl135iio03yUKu7YB5pi98BLGTNwPngNqtW+GtfuXXQa0CUtFPrgOI8r?=
 =?us-ascii?Q?rkvepbJ0Lr1sgeKpvshR5rmByHgG0FiCMzXts6d9/kUWfl8rr2OvrC7SJGmn?=
 =?us-ascii?Q?szf2hEhYa3rmUa4T6P1Zqhi6VdZIO3qpXN/mySIJ70zTilehDP020K6eKszr?=
 =?us-ascii?Q?x/Mhrb/xHW/nF3SJoua9lB1L7BHrC3/V/sI2hQ9cV0sjXDYnfJGOiZqq7gDY?=
 =?us-ascii?Q?xH5mgcZz6iIpuJ2uA9y4ITsN44aMX0GEey65teNoyIz/rksxVO/pbMHwQW3s?=
 =?us-ascii?Q?z5P5vW4iFrxzbN5h7HgcKNVzF4JwtmvTPx7QCbznymfCdbq3fQSbOs+6yGyt?=
 =?us-ascii?Q?RQJH/5+Nij1Ca3rIArQ0xKGjfyZK1ffJTiVjgWe0FEZJLnmRw4eI1mnRm3j7?=
 =?us-ascii?Q?QyXFuPCA3G04zGxVn9IOOA4HPzaI0GNNOdrV8qasEXUEhU9xmSBmSwxm1Dxr?=
 =?us-ascii?Q?hAntG3E7+FOAnIRMdEQDr6LF1Qh/CewC5SF9cZR9pUOyqtBiePOMMwT+r++K?=
 =?us-ascii?Q?zanH2QnPFe5U+fI8497wtyZMQkLqWeJ/burzByb7GhojYobcLakVY09gIDrc?=
 =?us-ascii?Q?E73JqOBSHwfMq4noB34QXsLrcvIkU0NqQBPfBuWPSkzNKeH4f7yxBmeVwtZK?=
 =?us-ascii?Q?MbYS/JSAe8PzlBMtJ4S1swWZeubFPpFEh1z7B+2srX0Ox6oTC7fJ/oERbbZv?=
 =?us-ascii?Q?rUB9tkxFotNomDDmrMLrBPmDmnD5wXzH5DKuFw6EaMJDkmDTktUnlBzuoa0A?=
 =?us-ascii?Q?A99eVL1iHfeJ978=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ThwHod1BCvdoBiz+aobBKJFn4Lp6dnhlb8OOErTkakoFi+doS0KZ+PlxUBsk?=
 =?us-ascii?Q?u/X6lMK/h3vjDzGLdDRSCUvu+7ttEkG6ERgCM2N0KuakIhHGSUHknqxXut5I?=
 =?us-ascii?Q?AsGXKtOOtg1ekKDvmHLaE2lKOHjyN+Zj0GMar3FyFNMQ16tjhK4aoUmqd+xn?=
 =?us-ascii?Q?Iu6GtFxSqcZG2GuQdx9KNvc22JCzOM1Rc39b/uE4op5O6cgkpqzYxfKPg6Kd?=
 =?us-ascii?Q?PYgmlqOtCk9izsPwg6m0v/rJNb+cxqlHU6YGa48/3+c1XFXQ6huUFE9Q+m4p?=
 =?us-ascii?Q?nQW5ZaX4qU6Y8qZuipLl0mtMdrdS60QHoRWBI/bUUwaCWNM2ECJjGlTF3PdK?=
 =?us-ascii?Q?a9N+irRRLYbR/iudtuzpeEdkJlgD+NZitoTpeqR3d5nKnhTbAP3ILGnAbJn6?=
 =?us-ascii?Q?BHzxiDefNRiNCnJoFGWw1XiyLNUklJXf7UzX/JLssLeIZxHYSe1UWzezhLva?=
 =?us-ascii?Q?qGZT40VuVJ+MMfyU+/s6hXaQqIPO6603hJ7hyyhnLQYwGv+/aj0O70SzBbND?=
 =?us-ascii?Q?m2HDTqBiwqFruMzqYHznsIQ7FhOHKqflwRZUVUU7Mi1fapORTUBoP0L/MBd+?=
 =?us-ascii?Q?G30iZUbDExIxIyq0P9Gb9y4ca7EZeJZQrixUEzm2R0BEBKtn22AwRmLBnMAF?=
 =?us-ascii?Q?sDRt21X65+chRMjQpdCybf1EKPfcb6noV1DPWj68xCQot0AKlRMw6tnBbFX/?=
 =?us-ascii?Q?NFlhgpDZqskYHoYowmbbsjczXv8moo+1QUp96DhHjuIbtnon97l2KpEqIfEI?=
 =?us-ascii?Q?+4t6ZDsL6LJ4/wbwOWUZJCxdro2ecEeAfzieHheJ+rqGc52lT7lQ8CNGN7xs?=
 =?us-ascii?Q?cPMtP6FNvOcSEz/uDVy9o3UCWYRMq9un8cJkfIBRQGcp3d1evOgKbDB41fTk?=
 =?us-ascii?Q?oiIInlKePYOidA5j5lt6qL3pWf2sx3QaKImswdJ0AtPXbEpFuR9h7Sfp8JZK?=
 =?us-ascii?Q?Ec+XsJleiIjzGs9Z1zGwkiFCDfEl3DLE8rR3tC3DQkafLDyMOAoq1ePzHFD1?=
 =?us-ascii?Q?3lUvgdLBUai8tHxlriVLzvCT9L1GoGTmO9aGxj/iEpjwYjxBCsT41L84DRa9?=
 =?us-ascii?Q?KtWNc3uap0wh2KA/GfnflUT0He6JrQfWK3r/702rIiJJxW7fJvVtrIHHAhgD?=
 =?us-ascii?Q?acrARNv/iiDiBF23kSKIGKModGJbw6q0g1mOwMVexVZSpiAxIgywFTHroVG7?=
 =?us-ascii?Q?XqdabLNsVk3kPsLmkgrOIzegeFXhMtuKctXpUMhfhO8772EwrHIokobLZcog?=
 =?us-ascii?Q?/R3Osw/HhgbFD3i3qcO/ya6Rg7VJss8K/pJB5DL/ExQ8JIpNtOAN1FPyojce?=
 =?us-ascii?Q?VPFI4UcQfrRsZiP7Sx8C8S55C8CXdh3IG09qLDZhXIvLNj4sQcldHISpqi7L?=
 =?us-ascii?Q?G4lKafQqj3tQ/B7dNE0alTUvk2RNaGJVo/mg87VachvdPnVe7E65yG2O22ff?=
 =?us-ascii?Q?mndIxo40zKNK2+GWreJBvyJwF44eCuosMOncAL49epXD4xfVhK80WpNrZuoV?=
 =?us-ascii?Q?d7JCZNq4fyrm1ekPMBTkuLw+hI96Hm8RTpbcnY0wBDgu8zBGRQL+RLON4xo/?=
 =?us-ascii?Q?TcU4Xthq698AtppEHEXYLuvZeBXG7BHWu25QLum8uvQZDFW9dHfuBr1QaF3y?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F7AF1FDFC9DBC448559802AA25241C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /Aej3ZesaMQkOjgj4K9Tg5QAfxnJZ+bB47Gamvq64fsfen6I6wCa7+v8umxmcDHk6rumanmtMBiFsrNoaTGgcQKBbmK7oKegMR4NBWENJIvV9dxFMp8VuoCT3azHtG3Ka2k2npt+BFBrNAB9OBpNdN+aAV2W+CjFs+EXpwX0F//8bLgcWNPY4H0p6NR7O0isa02MW4Yz6Xtb5vfZNHID6cMXqM62OHjiSra/QudLQlYhPNFUnUh/UGYsNHMLdn0ZgLlUhW4u2S9+7N4ryMmfoLeFqV8BDWqR4p/ioLsAIUc+M25oQK8Uo49h7U3wPgcW+k3t3qKtar1ZdI2ix3lmaNohWBNMYH6xlaNQ7G1cYnCYtRrIOC7dC/HmOtuqeOrr/EoVtUunKl7G6ThytCrukHy9duE0NjbDwIZrEzQ9bjINX8OyMXQvweOd+bSgW8cG8xMV857xAZeZDTKX1ncWJv1Yv+WsIHNyS0IkQwfzuN8sbWG3L90BSu0ENfufka32zs9K5HhW8xaDW3iVVRBwc+rQqdZcQxnzMhukBjZxRq4xmue2r/oIoMH3qZNu/RExqHgCIaB55GL8lJ0gKNvr16hsI36T8nljzRVF4WnYuqL3nBlQLSHKIuOi+aAVkbHQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c029eb77-ef1a-4069-7cfc-08dd96c61642
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 11:12:47.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCibMaQvxPyicieu0EeCjwwKucICAqw0GOotg0O6Z9D0OifjcJlednaQpiOVAslgpnf0sC2ztuv7bBXPN4rSeyTZIlPw8EAlTY5K+oHfdDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7405
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_041251_226362_5ED8A2E8 
X-CRM114-Status: GOOD (  12.15  )
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

On May 19, 2025 / 08:49, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>=20
> nvme_tcp_teardown_ctrl() calls 'nvme_quiesce_admin_queue()' before
> calling nvme_tcp_teardown_admin_queue() which also calls that function.
> So move nvme_quiesce_admin_queue() out and require the callers to
> do it.
>=20
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Thanks for the action. I applied this patch on top of v6.15-rc7 kernel and =
ran
the test case nvme/063. Unfortunately, I still observe the failures that I
reported [1], both the WARN in blk_mq_unquiesce_queue and the KASAN sauf in
blk_mq_queue_tag_busy_iter...

[1] https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb=
3s44mqtr5dsxmf@gywwmnyh3twm/=

