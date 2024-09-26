Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D593CCFA10
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2024 01:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b9FCNfzGQU2F0M1dzope5m5cpgQ0nGEbGFCxtPM+gwA=; b=vPcBUXpzjJmt0SziBFe3BcGx3j
	SiGuyYqeBetVD8kseaiZBIBZB4sBkSlr9BFHY0+jJ2t36/N7qtnvFtTdQpInfN/cz5kqwvhdhhmvg
	6QkD7u0TZsa7oHNp0EFV+HdTJjEGuLuZtHXppHNNDEWvmZYV1TVoy0wexERJ1P0ML9KdzlQ+tAaRT
	T88hX4diUUDiFbw2KfeH58xkPvyWf17Xs3/blxGqs/FfQDl0Qsq5kyhHflgg2t77LLPatp/m7h7iF
	BB1zA6S+rpQRi1c9G+IQzwTvERAgYYWWiGE7kISoNRwUL/JmFP5es2hGXLCGLHK9mWAaMSgScNPMo
	PjU/60eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stdhK-00000006xSc-45IT;
	Thu, 26 Sep 2024 01:53:38 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stdhH-00000006xRm-0pEh
	for linux-nvme@lists.infradead.org;
	Thu, 26 Sep 2024 01:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727315615; x=1758851615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JzbFNd4LKyWIQ0RFFMvdhXweuj24Ly6N8fZ0qNZCGUc=;
  b=FpJ5hlp9l6cMSudQ9ZF/SX5W5VtYDAangJjTirqFOsQvIJlbVC+KtX1d
   wyOI6vPRFbPb3LisAfgWnOphLyGcypI3pvLa/oqDQp4HXslOlpEbuWhrY
   nLj5WNZvGuoR6ZBx72tES489P7NfJPCQ8N4ouAFCEr2u5UpFE+LBHonsO
   2l7YhxjNUhKw4cRyVo5PWIpWf9r0N5l67wPcBK9UnAZKnCZ8GzVG8qFZo
   IDxLNN5kemSoRBZ8VNx2uCNFtxiXqSkatN3fAOsB81PlLTYiZsaQuHLGy
   np0EmRxcwUTlBkXcD2BzPCAA3b78NOSaLM3lUCg8UlRV725h7KqvHjo7j
   Q==;
X-CSE-ConnectionGUID: PCfKXbGqSBaOOkX76Pbijw==
X-CSE-MsgGUID: g+p57T/ZTsm951MT9Rt+tw==
X-IronPort-AV: E=Sophos;i="6.10,259,1719849600"; 
   d="scan'208";a="28465808"
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2024 09:53:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T89k4qDTprcNrqlPXp/reLr0fz91+d701c+K88g9yjf7qa3NzFOteo20tjWRfuc9kr7gyMtmOvkPqhxmI2BPcYKHFPgp/8h4yf2xQPFv1s3YTk/lSYbGVN2Et/hNaCb4HIt46WBEaXPQ3I5SoPhMm+3vUsgAvYD7jfWgDPgd3bsL/r62PA5J8W7R89VyAQkUm+Hv0HqSoNJy28BsYPfuzbXkiyN2y2CYyTuL5sGDOr10kdZv127LRNUqG5oHptLCtHP41BAWdzlhx+PI9Y0rA/fnb2Q3dxOb9pJYObpY/doj9LGc/IkdyXOV7OwuIjHQlKeYcmul1etMcUrDOtdqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9FCNfzGQU2F0M1dzope5m5cpgQ0nGEbGFCxtPM+gwA=;
 b=Q+0Yrl1p7ohfzwZ0yzkGM1Nyiqq+dliLToN5XCHh4otJsKgN8IcaGAoVRoawCE75z3UZv2F9zBE77JWuF3ON480yPcEOgbjOnMweC5EF90SdYW2aOMZTh3sN9O5OQ1M+QX+xt1byTXga28keefQe2PV00KfOlJ/4qtUfbRCcOZ3gQtaawXFXXgR2EsuQvuLsPDG0SJfHBvAXrdAMNwIXwqWdIcRrqCSFSC38To32um7IwwezkTNIZPjthpULW2DB+Y6877C/QzJsl+xZqrGPhjJIGL9tpGbnATpmBXaVmQNTgGPoEPrDFpAAWa0QvDYxyhXn7cgQQygurT2zIe9VVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9FCNfzGQU2F0M1dzope5m5cpgQ0nGEbGFCxtPM+gwA=;
 b=IqV8lr7tNSSw37PPVFYZW2xKB+IYOichKJNY51iqIKqbrBEzqZ0f96pRaem6nX68ZPo4A/Qx55PHQL2g8Wt9ytVKIpU2BzA113KQjnbO9It5cphG4H/UNuKxub36eYgkrujtMOZQMLM3lcmzj5SbX7QpzIfKNCvkbx4srKDzbjg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB6612.namprd04.prod.outlook.com (2603:10b6:208:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 01:53:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 01:53:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, Yi Zhang
	<yi.zhang@redhat.com>, "hch@infradead.org" <hch@infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>
Subject: Re: [PATCH] nvme: null terminate nvme_tls_attrs
Thread-Topic: [PATCH] nvme: null terminate nvme_tls_attrs
Thread-Index: AQHbDmBizJ4mR8qLK0eSbyj5QTyhqrJm0M8AgAKALAA=
Date: Thu, 26 Sep 2024 01:53:23 +0000
Message-ID: <kqtckvgwsbblijg5sgh4wlnfitbhr2ikxaj2npwr6tjuihhc6d@gpe5f5ya6idp>
References: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
 <27712543-4f5e-4b17-9092-b0ea6ff58a47@oracle.com>
In-Reply-To: <27712543-4f5e-4b17-9092-b0ea6ff58a47@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL0PR04MB6612:EE_
x-ms-office365-filtering-correlation-id: ef406cf2-c3e5-4991-d115-08dcddce0197
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7KWAgUlZ8aKlQeurJlhvzLBp4X7yc+ZyOgPkixNf80AaShwJiyXblF+ypcUo?=
 =?us-ascii?Q?KTvBtonrz3uMkT2p0+soR/B95p0nqKT8GWxbQJCEM58V5cLQxicBA/pfvmnN?=
 =?us-ascii?Q?7mVRi/NwOu5No8rNiUeBokynSba4U7SIhRbTp8Ym7Pm8wv6JJZVOUi9CrnyB?=
 =?us-ascii?Q?ccYXpVj4FAdh/2YV/QpeoQm6M2/zU+0/6TsTg+I7qdf/BCuolFDzEO2D1yj4?=
 =?us-ascii?Q?MzyqpvInkVJqU2bguvK/iKm9PEBiptW/rK2qjX+Cqn4yVtq43k+kRIKVhWc3?=
 =?us-ascii?Q?7wVznzEjDqhL5QFPkL9EFI9V2j0jXNdZpmqlM3ugfPeoTUCeOo9kP2fzFAte?=
 =?us-ascii?Q?V4HVjIgdDGF336Bq4PBP83mNa5FbW3PVMh7PCqBCBB1lK5+JrLg9yTH2nEfD?=
 =?us-ascii?Q?azTP6h3Ok0higsfHJNt1nGlyvkvKGICyz0cE9hbFmC5pfVBw5k/SnNqoZnvh?=
 =?us-ascii?Q?Gs3MLW22WYtnOICbCKme/fpxp+NLqmbIKVDHlexa4KVNBFvx3KakIP/LbeIn?=
 =?us-ascii?Q?4cDRkTF0xy4dvDsv/JTobXR6YYDL+L4IojPQokSGRQo8mQXwx/dwQfqlj9pE?=
 =?us-ascii?Q?YS7e0pYh9V9Bvhf3apOe9hIArBfGEyF9RBkUh7CX5QW34WilzGLEv8jhljI6?=
 =?us-ascii?Q?/I+aLDM48Q1xA4FQWo3iJhCGoKmnOb+xf5YLVeYCleOLRjk0MGq01GsKKymC?=
 =?us-ascii?Q?wf2EfE9ZBbqoOhU5YPa06W/5MUlY1FAmobxIQOkoGFrvzG4XZNeIDGG0guo8?=
 =?us-ascii?Q?qGaPI+VNK3Wn4+4ELbTYgPGN0nzQV/7+SKJNhZ5QmaJCyEWnKitvKQFOkzFx?=
 =?us-ascii?Q?zxPT+9TwEyDQY5Jub4SQpN+SzxzhaRqmSmeeI5VJXIMkReSwpcnKF8fatjZi?=
 =?us-ascii?Q?A0O7wNCNN3PRDBf+GYCTrDiePdZQpp0VPNuBVRuIvgCxXcbte0MoW4kTSqIv?=
 =?us-ascii?Q?xEISN1ayqXq+v4+M/iTIRjiqh7HX+Gd/0mkFxq9qpgz4ViKVGch4e9A6L6FV?=
 =?us-ascii?Q?iHZJi3+FqxNeFsWkv4m2WUw2AjuhMZHHjOX50uUpNqWd0oZd4lQPlt9uY6Dx?=
 =?us-ascii?Q?C2iyZTkvZI/yOh7RVKFiXwOFO0dGjmbQV1iH+YdAg0CIH9PS7g3r/LB5HvlX?=
 =?us-ascii?Q?Zhmr0xAzq8+Bay91U9nBW8Nubli4NydfzwIzoFmit3sf+rU58KvkG1rPjLqs?=
 =?us-ascii?Q?WbbLuNOkqbS2U1AinGrm3kQh9K2lFlVR8wY30fL0iWvvoBa5Rh/mKU468h2T?=
 =?us-ascii?Q?UpJ11g35nvDInWeAkpzUVG+tP1RGpgi4Ay1Cq4ldVA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JjF6o6QayF8RMCw2QUtSHZnFjTnwvi5jE9Zv4nIOEhlAlI+KO+YsX57cxZIi?=
 =?us-ascii?Q?V/u3MZ3RDkrOne3YYwhCA9IQLkfOCEm9m/I9Fv854eQp89ur9TkYa5E56hPf?=
 =?us-ascii?Q?JGqvEV0/CSAJCqMOfeY2VC2QmLe0zHWMhuEn8rM9TEYIEwHoqHfiKY7LiZue?=
 =?us-ascii?Q?yCiBmXnaEr6NTSRySE4AUIyGcdBciNBTdkwfCd1ic4EWi/+GXli7PMseywnF?=
 =?us-ascii?Q?7MnzIVsLsxFDqbT1jIC8DjEXhbHL207LSeBHD42WYAn5TWjBzcCwv6JLmHuY?=
 =?us-ascii?Q?/bHH7EX2ezA8tSOtV6dRzRVFSJQh1LcnUi8RF4NvcvDU5wLc74+sfZ9Myxwd?=
 =?us-ascii?Q?LmyFa9FeL6Y634JVUcPHiivy7g+fkte1GtN6iXlmiEBICdU50JH/cR4eATnJ?=
 =?us-ascii?Q?JFjm6uMMQLMdqZs5bYdqTD0Nog3vpkc//NKWkypam3qzbCF2uk9FjeneHjLp?=
 =?us-ascii?Q?9//vHNf/LHnhotwLRWCClQpL7Eok27yWKLOdWiSEJesDl5f7EWhUfxSH3cFO?=
 =?us-ascii?Q?Ket9zuqAkGlKfx2Lt2L0/nPcQ8gRnMhJxUt0+iJap713F6XNxLHk+tAglbYb?=
 =?us-ascii?Q?zVkGOdl7GLxq9COjm4mpj9h9INAm7fkMIBm6SyHo0lmQQOcRZLsq2wgxF0pq?=
 =?us-ascii?Q?iVXem54OGrXsIGFHm0Hc4F4m55xqOYg2DOucpHIxciywme3TjgRvoe9TJNOM?=
 =?us-ascii?Q?KF5yFqZ624FygpfHAzDmmEIvquDBSoE2xYJcMveYjwTmQlo6a2WWSv1kB+8i?=
 =?us-ascii?Q?f/yR2PPtXT/RUPnH/gYPbLcUr+3f6YbTh90LLkL2W8gTMMqifC2LoVp+Xli3?=
 =?us-ascii?Q?KkJ6Z9rW8YW0l2OuIQpO/rmOEJQDQZZZOnKcP3wpJEOdGYBRLPr9Mso6WWA6?=
 =?us-ascii?Q?3DbkH2fkFW7OdtnnyUbtObK2jfvq+LE5LdwkUObuZFE8JtePskYzQ5TyXB9e?=
 =?us-ascii?Q?ifmPckOC40UKH2x0IhvR30ozHkuFEJuQ6NGcnA/9JRfR6jiqxDuuh2T36MFS?=
 =?us-ascii?Q?HQ1rIUPfyCF1yDK3I93vV8HdLq+b+LMLljQqmYt21/9CCApV3H+GF5Rslrb9?=
 =?us-ascii?Q?3L+NN2yKtrwj1Fqnnuy8hl6vLRLskDWkLD24Urx9hV4G8H7xDApW8e4dvEqK?=
 =?us-ascii?Q?4WU0HCRXrhuBpAuertSLs4gzTBAeIUBiMr3Cg6yJe7q5Ayv3CPdS1Z6rQ4NZ?=
 =?us-ascii?Q?epKur2LE9jEWXR0daCQNuc/+zLOk2x7F2CiBElIKIthiEABScfM2VXIuvss1?=
 =?us-ascii?Q?AQQVwNiHdSn9IPCbQGhWbF861FuGK4eNX1D/DX2oq0AWLNEfNu5pq3MY82qg?=
 =?us-ascii?Q?IBwnLeOYID2A3zwMqKDl4vI8STN5ceKGZFIy2uyTxnZklnHsV32iHAJegzRt?=
 =?us-ascii?Q?ehFkvVgIYbIC0w9UbyWTy30v//EqfVM56S+Uz1MY/Dw5GpsQfFDiCSJ969Mz?=
 =?us-ascii?Q?EsQsI+H+nPdCoO2YVDsMZvuJ2BnnWS/dawrvJ/AdAp1LEt6ZBXqrKcm7rOJG?=
 =?us-ascii?Q?0QeT0uGoYTYDkxpxdbx5QS8n0F7W+OuWYnXyXRIBgn5uMaHNueNd8P913R/T?=
 =?us-ascii?Q?3Ee0tPN5WqnKe+qmFLbQBKT2Mzd4fPu324ZhylLawEPI8RE4NyFCHF7Xk0ow?=
 =?us-ascii?Q?YR0to1FSjFEGfn79ydTjqow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EC397BDD91C3C4E9E1B2768E3241120@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3KDKawLRPqRH46cRJ039x3a+fPdpwWPP4+lc6B3PHfXVpNFYvGA5Gi2QztK4Xf4N/ayz4WXGC+q+sSvXrRa3OFHbcfeu8tS3C4Ov70VFz9WWK7oKuXGaFR+w2T2oVvd9Qi1tLIh0C04/H8PQQnU59tI45RCPMd9ZtyWgseVB8od6dQTYfx3V8PPyWf6822ld6FaSc0XhmkdPxNZ54rUx/DbDzVQiRq4QNc+VIb/z9J3VPsoS7v7/bQNFcddWVgsOH8thKB+Y5taUIYbWu0J7vTsgd292m8f4vNDxZ/T91C6+dH8Nmw5Q0Lj4Eh1Bgi7ip2v1In2PyKv/YLEmQwNt++NnHki7vD8rTLfGykGI76Bl8FKqi/bKNiuG5Yo7nYNxsJk/fPChv5ehEepC1dXK2DHSLXwFLMtziWI8ZabY8JvgGpqXQ4q7W1zU7a4HKHDZRc/9QXuGnWCFuB8xNdQ6ph4iGGBqqN1Woi6eUILDIj9TRw1FGk+2OAf4pvN16fIbRUq8hrwhdkF8ukcM4zwd0O49YcDBNhMxIQApzvkwsHlP8jGqAGSNXtgGPrWQHpod7xVdk/QZ47gE3CkqjYzQo84Mvl9ftmoULyxlNCBRa421FwYyI+EFOySG4SPo45Y4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef406cf2-c3e5-4991-d115-08dcddce0197
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 01:53:23.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUMPvxmgf9yW6Rh4TWPqrvmrYmVIvBG4SfyMryyuIA7hjXt0mIbEdz3HSIiehnpCvJogxAar3CNVH1UBkIFn9s2L4/UrrXCkok0DTuoWVX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6612
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_185335_637237_7B2AEB96 
X-CRM114-Status: GOOD (  18.53  )
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

On Sep 24, 2024 / 12:42, John Garry wrote:
> On 24/09/2024 10:01, Shin'ichiro Kawasaki wrote:
> > Commit 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a
> > separate group") introduced the struct attribute array nvme_tls_attrs.
> > However, the array was not null terminated and caused BUG KASAN global-
> > out-of-bounds. To avoid the BUG, null terminate the array.
> >=20
> > Reported-by: Yi Zhang<yi.zhang@redhat.com>
> > Closes:https://urldefense.com/v3/__https://lore.kernel.org/linux-nvme/
> > jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm/__;!!
> > ACWV5N9M2RV99hQ! O7ofbvpkFcN1G5ZtEfcoa89swFeTDXZf8d8VLdkl9BCbv1ofMOt5Qc=
sWBZHT2cfK6Tzf5bWPI80AFNaRRJ6UMEA4Eiv3$
> > Fixes: 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a
> > separate group")
> > Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
> > ---
> >   drivers/nvme/host/sysfs.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index eb345551d6fe..b68a9e5f1ea3 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] =3D {
> >   	&dev_attr_tls_key.attr,
> >   	&dev_attr_tls_configured_key.attr,
> >   	&dev_attr_tls_keyring.attr,
> > +	NULL,
>=20
> nit: no ',' is required for a NULL terminate

Ah, right, it is not reasonable to put ',' to NULL terminates.

I thought to send out v2, but I found that this patch is already pulled to
linux-block/for-6.12/block, so I leave it as it is.=

