Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D06E77170
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 01:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EkJcfkvV+RD8SdCgF0MQRptnHPxMli+vncYo8/ILrcA=; b=Ro8Bv9zDyEiv2VyMMJXOK52Mp6
	6QFqEJVSaGq+GUlFalnQyvMe0WXiiDSKDKagRPilzbR+paGQ+USD6radnZsbPEdddLPTXGa+BzTUM
	gggQqv+0FD3mpNxH7m6cZ2NONA141hXAfkjHasQP839C37UJjwzABxlP3frCOlGFTNShCOsvPXjE0
	KpHjbRWWu7lSfL5UlYLlwbA82/9WAoRqcEZnO506yOGymx/X3cc8jw3F/sodF6GZgCx16ZRKj98HJ
	j+9HRJ99x1aEixsE+C/jZyNvN69BiWzs7AaPe/FuyZCkPBUvlelmt9MLwEF1fheJKD3YtghC13tG/
	mZ7gce/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNXG-00000000FOS-0n84;
	Fri, 06 Dec 2024 01:53:38 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNX8-00000000FEA-1329
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 01:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733450010; x=1764986010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uUU7uXm1jfB75KWFv+OTns7ADmYrYvEpZIyK+kseeGA=;
  b=NpWWiHgpIurnHKdER6fhWdmPIEfoDoONcjRC1TEPgraC63AHmNGNqSDj
   kpNszAvRcJWzMAMHirnnQ3SHgGREwYYizxdqKgLTlFKO2FboaVynDTqlB
   2ANO5RrucbMHK+EYTMFkDoG/FDU0MxhwXOl5B3R5sulGc5RXC1vfBIfE6
   cGUWxomlEHlYOdRY3LWgkI7hO+ozOtVbNtuiCMahCuXZk9TI9J7i7zta+
   StMjDCwZeqwDz+8pRizxcw+PM+tvMCfpLwfm7seXQGyo02iDRbNGV/J+h
   xGml5HQR+plILFN/zKcTG+r0v4b7a4tYr5LlZTbdf4p6ZsFpv4Iu2Y4iV
   g==;
X-CSE-ConnectionGUID: 4PXxhZ3ZSn2TdpJTBEq5NQ==
X-CSE-MsgGUID: MhrpTGG0SQ+S4KJ8zbc0WQ==
X-IronPort-AV: E=Sophos;i="6.12,212,1728921600"; 
   d="scan'208";a="32519749"
Received: from mail-northcentralusazlp17013060.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.60])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2024 09:53:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0JJHsDj3swYpqO5EpXiIu9MDdP69i9FhRuOIa0CO5/wlPxAL66DW1wZSJH1ScVln9aq4gw9kBaEP3v/QtlvABXIs6HKLZdjoPfTGOPjlE5VcMEKX/1J296+B4sd/G52ESKBu67I1YpZY8JCLxBkQUz9HcRvAI9e9HsUHZJArtJPEroiwWYex+bNMuBrCAe2w6VFoLEPmlXAiN52A3+cUm7nN4DQXi9froYBGSpdFXdM1IegzNwiliyEcufTN7nU7kMLjKsrkE4zCVlPt4cnkTqlwYi0O8dZz9UNnYcBCSDng8iTjDGMKQdpTrBL8p83GBae/IW4zToMFtN5R9TdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkJcfkvV+RD8SdCgF0MQRptnHPxMli+vncYo8/ILrcA=;
 b=D8YgBgT+rNpKIQ7i/gu3+cXrepkVkYAP8EI+FhVKUllW6pNhLMamZHMj5QVoLx5evXnMTvDMHdwVVF+hNNQgI4IqtRCbyq3PWP2I4AQKERInTqwYfXwGL6Nxvuocsfv15HSE4q2GbugS3+kwruCCWCiG7qJhv/3IEOyDK26WYMN9Xjqvuciyw9TZJYpy6RghkAETEy5jIiDU9sNiEXvAq3Iphlhdg6N0Z76TSuklfStclWC8F+X74KHKmrB9T2cVOr6Q/FdAyx0ENdYvj1jROap/+grb8JOS5lU3jd0OJ68eaOQkmZCBZNPrmeOv28FdHzyhPAbJYqRnIqQFbtnAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkJcfkvV+RD8SdCgF0MQRptnHPxMli+vncYo8/ILrcA=;
 b=fq+spp16mcEI6ajV6wUbpecu9ze3gbHrgGaqWLWSj0rOPuW/iw1POa3hOX+tFXQ0v7fb0/0LBhpKc2IggKzcve/ApDaRTnwf2Aly4k9X1snwCqNyIGrRY+TsUaIrMeHccg5NcNXvqcBhjlfzK3St7hTWI1xlB/9bWJ/2k2XegAc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8534.namprd04.prod.outlook.com (2603:10b6:a03:4f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 01:53:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 01:53:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, hch <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns just
 after disabling it
Thread-Topic: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns
 just after disabling it
Thread-Index: AQHbRkJsYHodhWgyBk+G3JRa83MQDLLYdr6A
Date: Fri, 6 Dec 2024 01:53:24 +0000
Message-ID: <t6a6fwlbjk2h5esktnig3hllojjarp3utllgbgnneerdbkcpf3@fxfrnzdbcepf>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
In-Reply-To: <20241204114755.190660-3-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8534:EE_
x-ms-office365-filtering-correlation-id: ed5b22b6-8235-4d7b-9311-08dd1598c556
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|27256017;
x-microsoft-antispam-message-info: =?us-ascii?Q?ct+vgz9f+hhTLuaHkF47QHrM8RovHh1/zG2iGizvyLHLUxRImQaOiF1Y/j76?=
 =?us-ascii?Q?jVLzb7FuVmIdmHkbYcnGiATOAv8HOqaVzj5WwEUob9oN2YzG1jhSeL5f1B4Z?=
 =?us-ascii?Q?D1g/oSRYnCjBrfZ/a7PdUS89bCcLDbed3HrN1cVt50CWCRN95PrVvak79bhD?=
 =?us-ascii?Q?XsZViYTtLsRRk4OEOTCcmHcvgepBEbK1jnmkmYPVOpdCwE81wCGLbKoH4LZ4?=
 =?us-ascii?Q?Bnk2o0tUz57Zb8u+oa3kUNpzG3FaDE0E0dBS9ABfVSLSkB666/cafVcMY5lD?=
 =?us-ascii?Q?Di/B0luXshcmQzUIwuIGveWTygOetexmPUsxYO/qTETwRPnWGl0B5RzT3cgt?=
 =?us-ascii?Q?jGfcy6NpimLYMLRd+lggjV0YrrKKjDsYoFE4eZ4vpEFrAbgDCKZ8Re1LAxZ3?=
 =?us-ascii?Q?uFzX0RRTVcN6u3eO5pmBqyOSJQlnSl3HO+GRgL5PP0lCpwwomEsvZ3hBEZpa?=
 =?us-ascii?Q?CKCEotRPRlQiioa6piVniZCmvj3E4dw53GTy0yfBoV8zpwaVim5pNhYoPysz?=
 =?us-ascii?Q?oVRLD6snLthpikSqYH3i+KTyQk0VFRFndeGwPJMpS6W6PcMBi6HoXBzamKuK?=
 =?us-ascii?Q?ymlkL4Z7sAUNYUhsRW1W7u8/oC6AqZq170FBvfi0lOtruxNODn5MON+gh7sZ?=
 =?us-ascii?Q?sTOkD4djxU2HjpEm67EODaVFeZLCGdfkuR9GyEMyKuVmf1kRm9hzKnrC/huT?=
 =?us-ascii?Q?w6VmZxzuDx/cFaKxcB7LeXuQRJjSjNvpU1qVhRvwRxXXyOiZfEZIj4xzI/Ik?=
 =?us-ascii?Q?YzFfKUr1gTXmBQzRMm7sZ093X3V7jkQozsDLoRmPAiq0mvG2ora76keiWz7O?=
 =?us-ascii?Q?2DT9TdAuUmrMwUWtiKtkhxkKovI/dsUDecndPXYMVe8zCqtq6F9LO26c0/Zf?=
 =?us-ascii?Q?E4KuCUctSix6vuH/iz+ngOy+qD374zgWvIyOxzPashz6OF3IdGtBrJRqdmRf?=
 =?us-ascii?Q?rgyE4phl0xVzR7Ed81vfzE55JKXKu1j7b177BP6IUTnB+5378M73OcHzQYRb?=
 =?us-ascii?Q?UT9thMUsng7/00d9XkayNhuXOUKDSzZ+ZWNu0WONY+vpFcdUIrYs04EPeVcv?=
 =?us-ascii?Q?K6vjDHikOTF1XjfvMCBxUF4MMl/KgblXhN0Sly4sPJvqURNwEeGhz40SAd72?=
 =?us-ascii?Q?zdeCEiGP+DffbEB6zOBRRhBpSK3OHj/EqXMQLRPhTKYnvRyaLZZk6XLncQJi?=
 =?us-ascii?Q?qZhO0hAcyvvKE4NEzLxb7uESogz11HPYH4vYyDCWg4aWsW2oa4DUSyP1/CH1?=
 =?us-ascii?Q?8KvZTEZZRQK+rqwaiQqxWZNzyrC6eGotgungovQiNbSEmKCOm7L58Xk+Y7Pg?=
 =?us-ascii?Q?MZSkZh/R7NWVSPhCOUER/0cKW/NHi+Am90o8kptbcaEgR2CUW2YC+fV0zGrP?=
 =?us-ascii?Q?dG0PA4xNMMd/a6iAix9eg2wpehonm3eP07PpiFgs/Hd83XzO7QYsZBxaJSPh?=
 =?us-ascii?Q?s2EfhpviciHRtiYIf+cWp2jZGGA3+rng?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tKQCS/tSEg/2IksO3TV+yo+g3nuLH7OZ0BTKgO9Vn5HvQtALuqp/veP0j0Pz?=
 =?us-ascii?Q?LZgDzdpIXrceZllKdisEWuUL9soJtfLo+D4AH4Q8qiHVsbg2G0al6PCzPMxS?=
 =?us-ascii?Q?bNT+xnOE3j4fTlxoqAOP1VmIiVFt0qH0h1bZj1ybmvNm+xa8vgYmNC4KMwEh?=
 =?us-ascii?Q?7sKoJDvfj61+YBKyL1HNqwWK+/Ft/afhM72lg5bu09y+1g2V3kZyF/AHBr3A?=
 =?us-ascii?Q?4QxowgoQyNx6jIWRcAWKPBZEECcnxWWP28lQLVa7bw0nmKLX3xd5AYtQceiO?=
 =?us-ascii?Q?ouVEQVBF+OwElgWkc7ldQEMHpk/g8xP979Tk1tQ/KVVgSfrqnCPew/z5qPA2?=
 =?us-ascii?Q?vd8JRTJFy7hxaee0xWXjCaNfQTheVPPJ4fzkH4evyq5cKG1Cnl27B3A/P5it?=
 =?us-ascii?Q?ucG2mWql4FbGEkCTrpijWbY0g3j2VU0m3zNzkmtNz1msnO9uL/6oOyP3SPjr?=
 =?us-ascii?Q?Dkq0x8TcUatY15XxgdLmNk8KhPLzZysUKHhvMKlOCInO6vJqXS5XaM70M9tP?=
 =?us-ascii?Q?wiUS9MIVxRtogqeVD6xeUBqcU/7hIuBj/QEQqiRDXEgHB+IYY6wlKkrfkrT9?=
 =?us-ascii?Q?3JhN7Z+HN3+m17DrcZf/j3UhH9qRKtGYVCN4plqCK2/JSEVOW0LMwAHoqmg/?=
 =?us-ascii?Q?HkkiqyJu2AeaoAOcVnlugKeRe6cXxNO8fZfNvQa+GhjQP19+kustcLxZLIJU?=
 =?us-ascii?Q?I0J0siKzr37XOluDljt+fNvO0R82jj6H93YagVszGSfPXIiDkqecuEyBH8h3?=
 =?us-ascii?Q?K46IKy+3ijWt6vZLmWECyta3bire28wrGmzkv10DtdrEdQHtI+9AtndNMa4Q?=
 =?us-ascii?Q?QPIe2pfAfeUR9+7XaEWFu99fZ6dH+T2Yg6CdEFTNeqobreVPT5u67PxwbNUu?=
 =?us-ascii?Q?bI3XYQFVpH5RizxpD7JJkhyhrCd9gDbhHfxXKox4zDWA/CFEpXeTyUSPqVVg?=
 =?us-ascii?Q?Gt6IS+kjZTCNY2GUo7GLgdZewOqvjP07S4CAoVpvIuFX5BT2RoTtQKgjGzWI?=
 =?us-ascii?Q?jfn113XqqlTNap57IeizNXTFIf+cZd91b/cpffdKg59MhdLOogE+q41u7qYw?=
 =?us-ascii?Q?FY2nEMpHaJ49jJGHsyrH4T906CyCfI3V9phSbt3wEkJ33NfRDMWTi0NqMvLO?=
 =?us-ascii?Q?2m9jZ4csIZHQTkMfD+YFDM8T9QKlgV8SR+GrcrVe4Il8ZdT0O5AUJ/Wp9Id5?=
 =?us-ascii?Q?JBIQKGnTqKX9A3Yq7G4xtDKPOSqx38Am4RSTdcZpoDHzcHRRCJHLmXx3ILzh?=
 =?us-ascii?Q?ga9KlXZnTZLgEBvnSL28YhkdcuatfSPsjWzPTbsfrfGHI/w0WKR0F2ecN1Bq?=
 =?us-ascii?Q?JZn0YF6jxfZMvWWJND2YY+BY5Y3zR0MGE/9aHkERSexGX246CzEgek09y6yB?=
 =?us-ascii?Q?beX0WkhEs9mEXNUjzX/2hlPofciDJ2zC9GEcAVH5K7VxEDjBcKqkRl4gn+xX?=
 =?us-ascii?Q?Jq4ODZGwPZqNd4Q3SXY3zphJH8ewtJ3CowLGikGc/r5n+TwB7lxgr5IGdX5+?=
 =?us-ascii?Q?bql1LEYcE8A/KOmDaUgO2y07eUTdnt6rtwmzP9pelF2cEr2EquDACv/lD4PK?=
 =?us-ascii?Q?IxjCbF90O93SjmgUE6H3fQaTTWnXzZQxnHcZMfm2so5IFAEEi0XfqnHyNGUW?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D410ED624B8FFE40A94FE2F9D960E574@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UtsbCEF5UlPZ+N/589zv0r6c4Z+UbuQT0OaRZHlk+LM4uRRcLYzfifw5q0irFhhq4Me7Hs45sH4Rm7SU96eBR39EtvjnvdPMonpalrphxTZLMCTjPMlpUpFiluB3hjyjMzQ7rjNnpvvQvmJhpBKrNmXQQGc4sG0OlGsp38wZDPm/ddl5O1+FgilIosLfMg4buL3OCbVtv6Y4fxYD70kDP2mm75yTD37S0rNa9Eo6MeCawpSmARUQoRN5AlW3Gcowky5jRYbo4smIH3Lhh8R0JLoevMjexnnC2Wh4Jo3Qj3gfLxLpy+wW5O9vBDz0H0LOqnzTOiH8FBbAUA45V+P4Q/VQQDQEVqls2oogn4UWYofnBtH417rrFMy2v0z99kkaiZ8gBlMgz/QR4uKocLFWXcWIqrA5y993XstJ4FW9FmA4TCG3822wMCyyLxNimJrWegUwCNbxVz5kCsGDgUTKqKxMa8Ap2zaP2JUxGTAulp3y/FtH5Mms4UCYPjJP+hfg1nWSyIxrZVxZ7ZbnmAVCt9ekv8hgi5yxUDif355R7Z6hedWLmLFnj8rTaSqYfGGnPUeTaAQlzuUXQAYJ0yNtVJkzcUppA8RA7Pzg+lho7T6gyHZ5RojKxYZgQfnzym3Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5b22b6-8235-4d7b-9311-08dd1598c556
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 01:53:24.6276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90AMFX03zR3QV5SkUR8ibW1Zd3Vvyb5zwUh0d7VlefV20V9jrrCb5Ph/qcHCtCHDYjMGHnPdeUDwHmydsnlwyNsb9t8YZlp9HCyDHVVylW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8534
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_175330_396758_AEDEA950 
X-CRM114-Status: GOOD (  21.18  )
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

Thanks for this v2 patch. I took a quick look. Please find my comments in l=
ine.
Will do another round of review when v3 comes out.

On Dec 04, 2024 / 17:17, Nilay Shroff wrote:
> This is a regression test for commit 505363957fad ("nvmet: fix nvme
> status code when namespace is disabled")[1].
>=20
> This test creates a regular file backed loop target namespace, disables
> the asynchronous event notification for ns-changed events and then write
> to the namespace just after disabling it.
>=20
> [1] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w462=
3cnxj3knoobfcanq@yxgt2mjkbkam/
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  tests/nvme/055     | 117 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/055.out |   2 +
>  2 files changed, 119 insertions(+)
>  create mode 100755 tests/nvme/055
>  create mode 100644 tests/nvme/055.out
>=20
> diff --git a/tests/nvme/055 b/tests/nvme/055
> new file mode 100755
> index 0000000..f1f19fe
> --- /dev/null
> +++ b/tests/nvme/055
> @@ -0,0 +1,117 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Nilay Shroff
> +#
> +# Regression test for commit 505363957fad ("nvmet: fix nvme
> +# status code when namespace is disabled").

As I commented for v1 series after this v2 came out, I suggest to describe =
that
this test intents to be independent from udev rules.

> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"Test nvme write to a loop target ns just after ns is disa=
bled"
> +
> +QUICK=3D1
> +

[...]

> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local iteration=3D1 i=3D0
> +
> +	_setup_nvmet
> +
> +	_nvmet_target_setup
> +
> +	_nvme_connect_subsys
> +
> +	img=3D"$(mktemp /tmp/blk_img_XXXXXX)"
> +	dd if=3D/dev/urandom of=3D"$img" bs=3D512 count=3D1 status=3Dnone

mktemp is not recommended, since blktests provides $TMPDIR as described
in the "new" file.

> +
> +	subsys_path=3D"${NVMET_CFS}/subsystems/${def_subsysnqn}"
> +	ns_path=3D"${subsys_path}/namespaces/${def_nsid}"
> +
> +	while (( i < iteration )); do
> +		# Wait until async request is processed and default ns
> +		# is created

[...]

> +
> +		# disable target namespace and write to it
> +		echo 0 > ${ns_path}/enable
> +		nvme write --start-block=3D1 --block-count=3D0 \
> +			--data-size=3D512 --data=3D"$img" "$disk" 2>>"$FULL"

Instead of --data=3D"$img", can we use"--data=3D/dev/urandam"? If it works,
we can avoid the img file.

> +
> +		((i++))
> +	done
> +
> +	rm "$img"

If we need img file, let's use $TMPDIR to skip this rm command.

> +
> +	_nvme_disconnect_subsys >> "$FULL" 2>&1
> +
> +	_nvmet_target_cleanup
> +
> +	echo "Test complete"
> +}

[...]=

