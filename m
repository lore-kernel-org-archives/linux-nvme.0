Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6A7CA0EED
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 06:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FV/+fi6b4a5CmR0kB+H5+hqL92f74xg13ABqkdhdsYE=; b=4y+fLt62A2q12PQBS2tG2m/LLN
	edttTK6WAz4kDqqAO8HxgYQLcYIB+nAnF0J19OfjlDPmuBHTJV0WviPO+H5gbynpTLf83GmsKHy2g
	zdiB7UUqms818YHguo5nkhpIvn3tkBVS5JLllRletoo/+VsvrXmGl3YGHu45gv9ZlzB3IjaSTh9ot
	P3OBeshHgKxKyJ7Bpq8VO8AEbNGs9t1pWsY06a0rCG7AuPi6nCyi9E5B/3ZTNINTRgYWBYehJ0B4H
	WE+Au9yEEBTsvZ7Sc+jkaVlE8SdeNBUrPs1tsYJSHYTJwPJF1h+Y9K3i7E/Bcu1DOoHpqFaRdp7hS
	vmI0/u+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uocFp-0000000CUmX-1oOv;
	Wed, 20 Aug 2025 06:25:01 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uocA0-0000000CUIn-47nE
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 06:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1755670740; x=1787206740;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=FV/+fi6b4a5CmR0kB+H5+hqL92f74xg13ABqkdhdsYE=;
  b=C58qQnkxXn7YzMZnq2xwLZgoNXZbv5wkesdHTSkesqtfefxe7kstks3j
   2moWAggTchblLzx79hRfdkMtN0e9bf19DmnOQ9iSIOVzqK9TTl4BxwHVS
   H+I570yDYJz5/Evro7rBnAfp4Jr2OypD/ox4i4pDy+xX44JVXJ3oF+uZf
   KsLPbHo9UbWk98Oht9SOeWfi0C3+Zv974XegHfSszKbWxp44fy3iSJaXy
   +bidQGzDln6r/OLFueyGAxh+fn+8YXatDJe2mq2fA5lG4KwAudDgrC5av
   raHSrAPUecqAW86PbqPOxqw12iMuSMr1Rpi8wx3tKH3UC3Kf+5t0g3D3+
   A==;
X-CSE-ConnectionGUID: zKI6j7CqTLK1gG8daKx1nA==
X-CSE-MsgGUID: XYiwQf54Sl+0teIfr+XOYQ==
X-IronPort-AV: E=Sophos;i="6.17,302,1747670400"; 
   d="scan'208";a="109642245"
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.63])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2025 14:18:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX0C/OyXJy8wi03y+Cm1NZlsmB2XUZNYNpJINDxM0jeCH09slb62kNOV56IYpvVACEXPseM7XUTO02Tpsl1Xu2pL15+XgicSTedXJLR3x9MLUnqYQPQZgBC9hzahklK63DVMldnLUhMrHfSIMt0WMi08H3r033CAvsBRR0mVx+98UAaUffUrrU9AsxuOL0VghISK2e+12iKfz+g3aAlvnzRqdHjZnttZ3X9vV4kho20l6RWOq3uoZINyVwVArd0GBp1bSsCAIxJ5zoIgeafnpz6nqyZNcXYK/85eOpTFZvkmAMhjY/A38U46tNGV8zPDvY5orH5SeU2dv0raDxtzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV/+fi6b4a5CmR0kB+H5+hqL92f74xg13ABqkdhdsYE=;
 b=F28KzGD3xuPFXprazRkxC0DVYmvCte3Aln5RPpkPEje5QQ9bvqszlB/Zl9v0lsn1Kz6JDeGGYtpfuT9OA4hWX1c2skC17zMTpqCvHMnU1orSLXxSqNx3a1QWpI04c4zvX3FlPQXFZ1k3qpX6gbheuXs/v40ykeMg3ojL7KUfA4Lhjth7qum7WHDgfgvnXolifrY8WE6oS7v1Iy47LuO2eCKsResL0B0mL++IHfpLyGTXkFxB8L76XSTGAFAMf7o4ZnQuP8SL9W2ZYl9Zm+Dzr5TKndWE2Ag98FJeKSFnBWqf++qlo8l1QXgBshTGQ8RLDDzBIE2g5DryrH4JF2/5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV/+fi6b4a5CmR0kB+H5+hqL92f74xg13ABqkdhdsYE=;
 b=okUcw5wpeD8NDGKMJ0zpPDuvVRwBfiIvNru/renlsGdsZd+SXDH/6CPZExbcmu0uAaEM8HzjUSZ1zl3Okr+yIdsSnnhyAr2eymclSErVZRqZK20q45TnFnMOyuDeIa4fddAncmiEzU6Y0+KUPMoH4xq6h1Ay2nuk/wV7N+WXLPs=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ2PR04MB8485.namprd04.prod.outlook.com (2603:10b6:a03:4fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 20 Aug
 2025 06:18:57 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 06:18:56 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: blktests: _nvme_connect_subsys() improvement for RT kernel
Thread-Topic: blktests: _nvme_connect_subsys() improvement for RT kernel
Thread-Index: AQHcEZpOAzO+lJa4dU2O04pWSc4PbA==
Date: Wed, 20 Aug 2025 06:18:55 +0000
Message-ID: <la7o2yjqljxt67an6kyo4qj76mwedxt7f7az24s52cb63obgfk@xcxhybk46qud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ2PR04MB8485:EE_
x-ms-office365-filtering-correlation-id: 52fe3fae-7a67-4530-1494-08dddfb17162
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WCEpFrA3yGOaAeRbXpt9SVxZLB91JEbdWYRaL1TIV05B3nMqAN3XFPOK77//?=
 =?us-ascii?Q?URkcYK5vpUGbbLKzBLTAoA6TTDYKmqjjju+/rC8Tj+r9s/zK6gtWR4TWma16?=
 =?us-ascii?Q?fkSoTXZn/YF4hmqo0/ufBnQt6GZWqzVcNZ+7Oj9dVa2vjEZmlkU8l5dy8ev9?=
 =?us-ascii?Q?+Ucb4jp7/ihmCr73C3DXMktgXOPYmLBXFsFALfBHF5l1h/txx+Le+cjOOiXg?=
 =?us-ascii?Q?QtmSC+KXEFKma2m+6Pi8dBdwUX4MNTTN/bGP1rdH1BknPeTgbNWMuZ0HGvkd?=
 =?us-ascii?Q?gLruQoa7FYc6n2tB/pgvECpDX5RnDEwtS1G35Wl3kp5ZtgqWxKWs/xZ965MY?=
 =?us-ascii?Q?WCcYeX5nA/LCGRQdDrEIgJ2Nyy7kRsTrtLI2eW3H0+MUWgN1Rfbinca/Thww?=
 =?us-ascii?Q?1HxWYldQ1zs/OXBifSlM/Lcjn2Y1PQs+iXIlvXukNTeOBRw8tCg+cgA0WoT4?=
 =?us-ascii?Q?95vgKMv7c8u0RI/i/SfOOpZvp+HzTeUIKAUWDKgw02QAIT2P/4YnogSYnsx1?=
 =?us-ascii?Q?tYMrwdRr5BmrE2D4QUxYD5r91ogrkfI6cfT9xbCoLXj57qje1UwOjeIHIVgA?=
 =?us-ascii?Q?p+CJqBjxoJBB8oiNha/LlFaz5NjGu6ob8lZyIUqyO17qFeymwuM5WMpF1Xp3?=
 =?us-ascii?Q?BXU43Iby5eRlAVht60FX55NCfpdDHG635JfpSmTPzCeqf4zJ4nl6uWGfnxxH?=
 =?us-ascii?Q?6m/XVe8GEOEpRTOc7b0zLvl4rFq7Mr30ubwufaklHhnOTon7BxPC5dDlRhyL?=
 =?us-ascii?Q?5jPsJm+vMcAHvIVoGY7RmDnmYeAW3K9r3X++iSiMezIFbP70BR+pyXJ147K5?=
 =?us-ascii?Q?gmGG2urlqvaG/TkO1zbslukcgMZ/yqFgezdJOD7tpe4Sv2/CgnuqubAsiL+s?=
 =?us-ascii?Q?m4UO6NC2l57B1IlEOL2V9eoaxMpJQ8uBHzR6nlGoIMh+jvRFwIO5KUy5TfZ7?=
 =?us-ascii?Q?JgW+B9SJw0kTzveoyVLu5YEv5u3pJCYbIBqMoL5hfltjPBJY2FbkG+QBi0MJ?=
 =?us-ascii?Q?KgL8n3kVYbJdYqpEV0chVzfWkLDrTgvmARDxv3WIbv3i7PXWwXQtsNfQ+5hA?=
 =?us-ascii?Q?0tNdcqDK0KjMzEGn2HxNcHlNjzTO7po4U5yvhKy+/zh5ylEnB0Ypj6/ZDKM5?=
 =?us-ascii?Q?BwumOmBEiMkC8g9T6qx0gmwwhAudE1lbIxG1rkFXzmFhVBX/bMkHJrRC9uHJ?=
 =?us-ascii?Q?JodaSWnR6ozwAAy0cDPGYk/Pv3872qCRDa/cHd3FvWvAO0InHk0mrCWNW51n?=
 =?us-ascii?Q?yrMoWRF5gq5hQL9MjTYI8jjufGEl9KQ6O8IbJwo5qKYz0DDXPBkLjlp8PxJj?=
 =?us-ascii?Q?bk0ryjmPQn3zfPoykCbRfwTjrbgD52MffsY2YZ4gFtzNu7+82TDFH+bkrtyp?=
 =?us-ascii?Q?E16szksNdIbjw/WA3KBI+OGMiveVPUHoUJxbFZXv+RULJZh96c7qXRxigghN?=
 =?us-ascii?Q?uL4f/Zhsw08=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?77JgDvZ/nT4MQeyq/XYwm1lnJgLpVuwKlnBr5U41smUjsAMYGmVb58Zorcpr?=
 =?us-ascii?Q?LuRRPc+0oNH3YALZOsNv3oIBxD65/+oY8pwBJPXkuXP7hNOb9AZYsDUBuqSV?=
 =?us-ascii?Q?KJIfMY9vU81TyU3SNDV2ug8y70C1uy+qRsiWfE57lC3pUyPpDmTpfV6mEPiH?=
 =?us-ascii?Q?6KaCFqZlZCiBWuc27xSw2dImLPYjixj7tbqHBntrxjcK+o1oUP34/GPd3+x0?=
 =?us-ascii?Q?pGKTDuGdfdVZCAAmNudBcZWiJDcfBul0arTMcmTx7X3d/G2k9DgV+1rp2lNK?=
 =?us-ascii?Q?7uwQZc5DlCg88O+8pR9MmJH6h2EkIIgrfgVQo30EtQKGQ5xcpdqZulnAY7lP?=
 =?us-ascii?Q?vTzvp/DC7f4gbhLhCiw0sol7ddy02xC+BKJSy9wGzFjtg7jdvHEzoEyt4peu?=
 =?us-ascii?Q?YZlLggf8CXOLw6KptZZ1112rYealwCwtkE3zpglLKbsSDXYF9jIre8i08+Yd?=
 =?us-ascii?Q?mEXfkY8/2HPmEmEEuQ0k41S/fCQCcRrMLzUNswJyzZjzvr/ZDyo4Fd6lUtPy?=
 =?us-ascii?Q?0QIEVCHJ3j29rdS6ooewyFxIXCHPEOE4PQC1r4V3WHuV68jROUVUSoTZBPxF?=
 =?us-ascii?Q?5ozK4MemCfoKBohLjRHFsOiRYlgsDNtWaAI0PpU/rJ71FprDTlniceA0andH?=
 =?us-ascii?Q?7CB3/0AHipjH7N3PpU44lYUlvniAiBFWENTLCIYZasOvf3b3Txd+pP1WnSr+?=
 =?us-ascii?Q?uy3t6eBn6Bj4FfE3iT+E5IqEhDKxIYL11qp8WXaJ8pOAbG7X4tYDtFRwnAcP?=
 =?us-ascii?Q?7jS3EaWpnNucmGL2McGMOsKRrFjBBIbIj/GVIzcY4xuGCNZvZRwN9r51BPgJ?=
 =?us-ascii?Q?gUVnVbuypPH2fMW8BW4PR8hzEPDh81UK7ZVVpf94lIgSdiS1je7Ex5DH+p+H?=
 =?us-ascii?Q?PKR34yLJEyxppwM1IN/aIsaMmLb29+Mid9DXZAYeJDS1YVzU7mbbHbrKa5hq?=
 =?us-ascii?Q?8pIQLL354TwAY/NqgSGFF9hmheMgJv0FMc3wN9kaOREsMLhZipSD2DkGnUqt?=
 =?us-ascii?Q?jM30HiizwFjUc1z0JL7D3lwG25Xjku5lWCGC/JJdoIuDQDvKQq2tMUL9fmeJ?=
 =?us-ascii?Q?CYCTJQMKj5BZ4ilG//OcUIAqkfn/qmaJs4XH5slvLW4ZRIk+oMmIQi65EEHt?=
 =?us-ascii?Q?5tfTb7egbSoCzcDCPnGgcnTnA5MlZusTN+htW8uFBSbddt+tYZtJGJz4xHDA?=
 =?us-ascii?Q?Cvrx6qfJ4I+PcRNHiiuEsLeWofn8QcCEyVJVkGelYrE61dHC/WSjks+BuANf?=
 =?us-ascii?Q?IDR/OK0m6Sn1sfvPZhm4Efu/xi7HdaZDdk5xVt6x8POrARRVeeUSpK5SMDHM?=
 =?us-ascii?Q?wkhvetv+u1JMz7LMVvf1ylEVay+a2nb9DwPkIJxTBHwyCi4oRnHt0C1rxne0?=
 =?us-ascii?Q?nu6J6O0rZqU/MVY8zyfEpDfb+1+L8/i3tKkCQKGZyhICV45NlojljaZEolHw?=
 =?us-ascii?Q?Ppu7V+ocxPsy93xyrQfw+ppugw5DIsFGSoGCVWEV70oTPihFQ+fsTfla7jzv?=
 =?us-ascii?Q?C51lldRCTn/Ufht0sf7OFndEkjFa2a8a0UcC51IUY0VkCxnuCM5NDnFUwl/8?=
 =?us-ascii?Q?pxXiXTv5wj7dH0TqPDSLxypaMCX+RpvfHSmh9SuNl90C07g5LruX4kXUS8kL?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA4774557919E347A2F4A85A787D55E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QvKkRS3ZedV4N4q6zf46LEhhMwSCK2m4YgovmfvDKQwg1aqOVCFr4z9QBGBioGSvMDtJ4vG13RUp9OGFmMlyt+/MW49wgw1fYfhUq4WKUS/pF/NEEeXmgTVD0UGKYM6LeIRp4DU5Aim7ztKrZeWKocDHo74Eokr0Ay3TnBabQRN1vVCfPJXabwFFUXXMB79n0qN+H34vtsBWfE9fZgVkS7ds+EglFKBhDTTGGAy/gv72PxQzGsGYvQZHsWHiapexCRjZHTx5g6fbbgxFirZSVOH2xCd4nzrYT4pi4tiTr5PQ89hvQ0jppJSVAaH77bTfzwCDWDkE+Q3lrENSqUYqY46ExrybEwopFFkyuu0gNBHQ6ONP1xdSQKzldIhSLlPKagjMMFfzuybMip8qC4JgyoQnEpyTnScSZ9lqbTNjWAH5vlvVICLRmniOUFsoqGQBTLyEj0RA/9gIz+G8cTlqJTe4TpCt/+345V9nZarwc8SrGMXaDkiWeILw5UvZjCTHsNkej/qfA1eohDZVQjRCxLDjewuerlrAOceK1eBq9+Fj/utYzrMfwOGHUbb3yLwX98MmzbzRAZdvbmXlnVJda/8Qs+qy2YrDqJLlsIShUBWX5dUuSOWxeu6AD0nNXV9P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fe3fae-7a67-4530-1494-08dddfb17162
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 06:18:56.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fji+478ZbeNToXDyLvqN4in/gBMESYM+pA1fBArDqQ7IbVCWe4LZ4FiPxpwb7m19TdHS04omQFUk9QdyB1Mp9czvOVQkMERWm/SjvCQpkSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_231901_107915_59440F89 
X-CRM114-Status: UNSURE (   8.18  )
X-CRM114-Notice: Please train this message.
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

FYI, Yi Zhang ran blktests on RT kernel and observed that several test case=
s in
nvme group failed. To avoid the failures, Yi worked on the blktests script
improvement which modified _nvme_connect_subsys() and some of nvme test cas=
es.
In case you are interested in the work, please take a look in the GitHub PR=
 [1].

[1] https://github.com/linux-blktests/blktests/pull/194=

