Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653E7C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ts1xuui6tl7vLdak+2loBuHZ94DE0lJMznLp+eR3xGo=; b=hiY5U4JhUagLuhGdrCovGrvdfh
	KimGfaoIO+l3MpkEnMzfSN3sobyjOw4NZsaMzOsXW1Wbt5sHWVX4j4njacbIE4OiIgH3F83s3vG+a
	P0dYtykyYLkcxX/8HCRO98HHvxgET/UG0/H/BPssad+C1wkoTIKVVSJH7A2LEk07Sf3UjkNX4Lf9o
	F5gArjRYZBGfJ1E4i+xH8IKcrNe9g98eHsYStJXYPXd9y1izbeClWgvpbcEQy8cixoFoMGs7bCBHv
	fSEGmExGxg214gOb2sZ00N3C/DbvZ28mxrw4jJt0UxnjaoGAygKn3q+58GUXMm/PeFxW3Tja8cpSo
	PNbY6LmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl6FT-00000000xLm-2TeA;
	Thu, 20 Feb 2025 13:05:51 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl60m-00000000tF9-1U1g
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 12:50:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740055840; x=1771591840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ts1xuui6tl7vLdak+2loBuHZ94DE0lJMznLp+eR3xGo=;
  b=lbQLlb482I+5flrNj57OuhuBrAXQvRCBdIHltuZ2eNVAb9AtOMnrBXDK
   HeOT6/0P3Cgy3lz7ZEwAicZP6bpAfy7Tnqy3LK1cLeYP9yvMzu6dKPvBY
   p1fKKWgxaEZGcXGGkzXjYBSbqhHWbgo5RLmBD1Klp2cGpRlO3drTAIPs7
   HukkUoCxjblVA1LJrn7EvyKaUhz1a5TDFGuTWU9u/orNsfutZwfmC5egb
   e7RX4FoJJRwbjktb9Z5shMbeX52W7TEBl0AemrigQzyiRXRdqwX7eB1OQ
   Dyj6yzzV+JkSliP64KsrF2KCcXgMAQajvSTf+dPFK0MofA5f2iERZmQKc
   w==;
X-CSE-ConnectionGUID: 4ZuMeryKTAq76DuORvfhMg==
X-CSE-MsgGUID: yw47MtaiSdSrcSzkmn4xxQ==
X-IronPort-AV: E=Sophos;i="6.13,301,1732550400"; 
   d="scan'208";a="39651556"
Received: from mail-eastus2azlp17010021.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.21])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2025 20:50:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0co/XiA0XCMfHNYRKznsal+/OOWWpKrS1djExUfqiTxrsOZHMOS1hXV9Z0+RsPHQGGRyWUMCAJRFWNKrN9jDnm1M1ws04ZNNf/rp6+Oy4PPw6SDk7mWFqnNsn3c1U0QwkL1zwdjG/ZFp0KwbfFPFE/GOl54bezvmuZvS6OOxcxBlzzqxbTZjpfiwsC6ma8Xpt4RPRuGgGYZ2ZVCpKBPUUk1u1H29cg8qEGRXa7RybFK+qwvCgEpeNwsjgigUVJEEOoj7Yv4VO1Zt9YQCiVr+Arhm2n0TemlA8LSfXyfCenlepJLWF9mnXF6SEDLxwPR3aKttnFbzD1dDr/BTukneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts1xuui6tl7vLdak+2loBuHZ94DE0lJMznLp+eR3xGo=;
 b=g4QvYBDEgRPyFlMpW6bXQ4v/XknJLvr77lOdPQKMm7gv/tWb6wG5aLctW7dEaM7z25lqXVzprGD7yNzF5Ajy5Yi4OOB0bGLT+K3QXJ6W+ZQSvlz9Tb+nVqE1P2CiccC77JPV3tkiTHtwoMNyupzfShzCyLongBjN16d1KvXV2YKaf/9yIsBYyOxXif3Lse6HTkm3msMIJPG2qv5GhOYFWsUIre33gxGs/DiYSJUpSs1yXZ7G3IADac+36on7tLNaPvASEThJVX4SXBnO0DrZ8pTw7ic2AZ/b2LUOBZS/nf5zlVGVEtNtBbjmcu6YCpz1lWVex60puwqzHsVnJ89NXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts1xuui6tl7vLdak+2loBuHZ94DE0lJMznLp+eR3xGo=;
 b=o7sv3KSU7jH734+ZVOWgJTkUxmQcj1Gd8uWzCbpq/LrAmm/xIbOwc+ZAp9XcEmPnUIl8iSAhcDvUixffE5Rso7ju03YVX+i9w1if9pExkWPpMqW0UmnhL7dSEk7bPfaBwInUpXPPCW+iev+WvMUBGAxLiOiqX2i/9DG2G8rsJiE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8264.namprd04.prod.outlook.com (2603:10b6:510:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 12:50:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 12:50:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, hch
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] nvme-fc: fix schedule in atomic context
Thread-Topic: [PATCH 0/2] nvme-fc: fix schedule in atomic context
Thread-Index: AQHbfrbOugIqhQgLpk2m6xH49FGjArNQLp8A
Date: Thu, 20 Feb 2025 12:50:33 +0000
Message-ID: <fn3jxqr4gtcmgqp6l6vpveyhzj2z7qfhvwygurvptpdks46qze@xjlk3lbzfvkv>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
In-Reply-To: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8264:EE_
x-ms-office365-filtering-correlation-id: e8efadbd-878f-4bc0-38c8-08dd51ad2a4d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Bjp9spHYnDi3M1gpRcsodhmD/OsJEAUfI4pZp6DNKVz2leWIU9lL8VNrMgff?=
 =?us-ascii?Q?iu48IiOaBbYPpNLVct8zJoIANcAr/SUBseoEzHr/uaQKNrkO5u0+Uq3rtXqk?=
 =?us-ascii?Q?PpcKy5bvaLZFe5F6sUTpOrEfQD7gslhXK/2vhZz1S4Qfa+8ETeiCkzsOT7Eh?=
 =?us-ascii?Q?5+J1opgP7e0bsGaVqNi38YnbZ8JDi0Ibn3kbc3pOo3pD/NZ+UUHv3CJbGdmZ?=
 =?us-ascii?Q?GkFg2P1s1i8G8nhJi3r2TxM8iUzF2fIXtGSutGGxpJoW0lU2PnM1Tmv+yq6j?=
 =?us-ascii?Q?g7pS9OS5mlyhjZwjpD+JsFEVlAvXD3lNBAcpj5ifXsDFxGMsjQu7V1mxjO6C?=
 =?us-ascii?Q?KUNEOgqwir/+/fbCY4Mzjl/Hu2xNWj/FrvZHwHY98YDDwXwied/TiEcGT3jJ?=
 =?us-ascii?Q?CSBpS6wYcY379mmEwupC+YNJhyJVjzhYl8CRKvz38jOOpsQXU07uLbOCbIvx?=
 =?us-ascii?Q?M0jWocULug76Kx3RWU0J13IPpIIAOR0tM6dvXnl/Yhk8HYBW9/0Uj8CCQfDU?=
 =?us-ascii?Q?a4e9f2GXPeUL5/zTMDlR0W4Jgu88lSBI9o0CKRDhb7Tjacam/PRuood3lwXz?=
 =?us-ascii?Q?h/m1AyVSa4u1SvC7KDPP0ott+YQRE2WNgLVeeVIT4WjHyE8lc/0txbyEodOR?=
 =?us-ascii?Q?KsP+is5OqFTfpVMojjWLv7fE5BNuEnQjcY2Zc294jRwnMISG968YdiuJRAF+?=
 =?us-ascii?Q?XPhtiaApFqKF1zUrnhBbvXl/zZPl70wMXRdjQA01QPCc5clmSOSRWkaGQ9Sw?=
 =?us-ascii?Q?RTyI0SBXl+n19NNcP/mpQ8DyGLiNAYtOjh9ONQZaoWmErOq8FhqsdsKM7aqx?=
 =?us-ascii?Q?jU+0yc+VSCLOBydSTOfCM5gaRWNUAgZ99ZsLHjAaOgYY37usjxib8JqCkuDw?=
 =?us-ascii?Q?1Az0ZsuSv09LAxB2f4gmF1ZfrNRAtqVeGw+U4/Knpc2wjxzQL7/qMz/9sppl?=
 =?us-ascii?Q?QznSpaRXXhM/eTLzo1QNB5z6ZyJJHgpiXmoFVb/uww6ZJeyjpnMCZmWii4em?=
 =?us-ascii?Q?kKlySya8TxH2HXVLzRIiSYB7c60UdkEJdMMzpU9mkgBcRF4D5pGfrSkRuVRq?=
 =?us-ascii?Q?cmhwxruirS3EKaALxndQy6yYh2fnCgFzpOvzClVMpaOWn2aA+YTT/QmAnVY8?=
 =?us-ascii?Q?1BRB8Ij6d2VIXCgOKnPr4XfQKTdYnnyfMDqK7ZaRfdI8QW3qRX2777wDNT3X?=
 =?us-ascii?Q?ARQKJEqeaBbxjjphG4LtCA0rIBgpOQt4RwxfxkH9wSofnzt7uQd4EKLHOwDC?=
 =?us-ascii?Q?lqEoIyDnDAGlLXEk4admOTM04IO5Er29xB6ihIf+Pv+WwdMFFShVkWYyCRdI?=
 =?us-ascii?Q?E6jwL4KcwBGlvf8Rj2B4UbtA+rkljFf+9xTZEMfU1X5JFK1CVb+hYcM5D6CM?=
 =?us-ascii?Q?mCHtGbgCFw4GW3LKvXAYbCIN7VU1/j+CvKrxuatXMK/l+bP9gg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Gj/ganwUtxFjOiFBcgLNm+b8PDABW5qj6D0Q0pvJVhnJhxYh33zxRGVBLDe?=
 =?us-ascii?Q?nVaPXqa2JvXNFBjfPYmYm09u+uIMZrozviwzeqvnw5z2FdHxqmX00IjaevYg?=
 =?us-ascii?Q?ggBV8+jQ5/CZHiFoHD0tqN5X/QNPsIF4mbmEbvZDZYYyfdLi5Ezn/StJ511n?=
 =?us-ascii?Q?djbDGqbgyoCobFkhhU0FzGf2/NNeKFIpsv3RfEv6fqV+4rakpdyr5GZdxeQ9?=
 =?us-ascii?Q?fkOAZV9ArubP4PIE+z2oMzTrOMKPpC+SuoH4Isk1Gs3NQcNTaLOyjeezq4ca?=
 =?us-ascii?Q?aisXPnrXvEYCTqYYiGqqrqB98CI95aHAV3cpYJjnwIU8L0HD50cm8luxCB+z?=
 =?us-ascii?Q?p8swVBpAXRej+uSeRTvkSSV6EFZBi1dBMX1NVEskcXZA4C7ylFFj5EAQi1eg?=
 =?us-ascii?Q?n00l0G9Edl9nRPU0pt4BXBvi5bX3DkFnrKNYUZdUhtz26eFNr1kI7IK6987+?=
 =?us-ascii?Q?KT4bkL0Ym5ZB7BPXaq737ijVf6D2u6fLQcLxWL2ZlCXUKbxo7/eXxR1/2Nrx?=
 =?us-ascii?Q?u/exZ2inB1P00yJNh2xE3iCxvPaR/+B9M2JakR1tA+Y/zw2pEMc471X7ZLCX?=
 =?us-ascii?Q?AVKGAq70g7EzMK+q08DQFxAQb2Ouhau/2r0avfNSZrvFxq15KgQL0upLYGga?=
 =?us-ascii?Q?3eWkFRI1pKlRMQAOeysYnvQuaFC0nOMtE5BOu0t2h2Dfz5EiR6X2eyNS54O4?=
 =?us-ascii?Q?5zmBp3EALuIGS3p3NAs8r4aoFlyWuIqv9RpnbAE5n9oYWvhH/07aHssiaMOv?=
 =?us-ascii?Q?yM/X/gzbGuyHp4QQSzIOJyAo1XPr2eCIF5jsb6mZ6ImkQF3vubbRZshHOR2x?=
 =?us-ascii?Q?1P2MNRUtTYYFBDBC8cGpfz+DG9nOmVC7LlvTJcOLkZdce/HOvuXlWKXwWo1S?=
 =?us-ascii?Q?0bf5So3SvKaFZDr43vNMhC+SwUKEUHeVZtWU3ybb3yl8Uz1dz5IakFqfSrNn?=
 =?us-ascii?Q?Q1ob8+gduJZhkHe5jba78PScHQRhaIN1o4WUBpftGQCjYLiouwOlQwoQ8pma?=
 =?us-ascii?Q?6ldn/3Vgfyo97yHVQdM5cM/3sks5Y1nidLwcWBtHtRz4Y1uw+X9VBIkJ1u0G?=
 =?us-ascii?Q?j9zaN0O7r1eVnZ8bZ9HkUkBmzj3sB08eO4DSnOBQcfium16enMALhdxcePtq?=
 =?us-ascii?Q?LTSPioUIkP4lwybqQza/eylF6mEY2ysxsgxP7k+00VsXQC9zJNWmf7V2a0x2?=
 =?us-ascii?Q?K6wFsv2aZX5D+KCo+6+z6KMUy6SWAxtdpncR22j/LundGtdf2QJ3uZAUy5JV?=
 =?us-ascii?Q?xzdFKGX375NUlWXqnfYr5+KMV7O+RgUF0VvlTqd6ly3DhqPN2R1zww3LQLhj?=
 =?us-ascii?Q?dkJu+KKdNlnXNU9my06o2SPU/cKng1DKL1s7A8FTXoDKsbbMr47mA0Z6AyR+?=
 =?us-ascii?Q?SGusIIjzIfrDEWCVtKfUaiGdVs3o4FH5D51LqXsuHXFJV0PpkBo1N0pwRK+7?=
 =?us-ascii?Q?RU7caLGNxHQy71NWzoYGbldafr3tFH2IKNL64VxIc6fImB1d7MIo03TIP+MB?=
 =?us-ascii?Q?m0uy9OHfdGjPl6D6DwGs4JsSK+fMgZPb4WQnj6EGci2n0yp004idRGM9XkFx?=
 =?us-ascii?Q?8r9gZhURnSzJbeMIcvEQxvbdz3ImoU/dbL5M/MKyMaVacdtr7FKIZ+KffcrV?=
 =?us-ascii?Q?5mq+WqmYvo+u8hE7NHrWm58=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C97CCAE184CF2B49A4D7FEAD19784DAB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eGHjLMD/V/zVQZ9LzEw/uUfO2G2zXOG9XKpI3Q948WbVMTPgHbqKWG2UQ9nu6ruP2yuD8yYEyX0P5mlE+sV1UDYi7sDk+YGJtRZ53GgfOgJH1HnAdYNh+V1VLsnGLq9ZVXFaa/zuLztMQe27RZ5MnWBtg8UCUKBqK6/SLX7lXIoD5MjcKz9I6NZUSIj3p+o77z5Yh+F5FdYGM/W8ndJK9FE7vZSGJSzOd1aiwMYHSj5qVz6zHxCmiqtOLH++9PdO5lNSdQOEnulUZgHNZ3smUVh8pm6ghf8jhVKqIZ9g4M8TSLfVZIy1JbLjHjM4zVi24mGGInFryvnJKT9iQbora6tH/6Q/8cD+ae1DxpYzBUfyv4wq4gL6uZkoGpnbCRKE/TYq+PO4+7WFsco1sgcIAR78ulSjLSOerkVcvHR1RXELlYPyk23D8wFrwjTlDrFAzyiu9BRXbE8Bt5E2PAFK9RaFzWYO52Jv1KmCDLS4vxtfhrFrgAQLPOVv7BAG9yoru3ihavBvz0uT8BCvkKuL/p5g0p3rKBdrEscT6o3I49hvRLMWzfidTWbT9TCj6L3fH0DWmPINtMbt/WQFnLM037f+j+AUj6epgvFJbNQ2cmF8AZY5VOaPTrqajLcO8sII
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8efadbd-878f-4bc0-38c8-08dd51ad2a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 12:50:33.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGV4zJDw0xlRYLrqxugEv5IAy3zgOjruVpBegwJquxm/pb9imy3Ty/G+3tdI1oCZcLB40XxnRYQE3TnSmay5F0kzxUtAJLXC6RPDdX+sV/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8264
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_045040_469734_D06D36D1 
X-CRM114-Status: GOOD (  21.42  )
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

On Feb 14, 2025 / 09:02, Daniel Wagner wrote:
> Shinichiro reported [1] the recent change in the nvme-fc setup path [2]
> introduced a bug. I didn't spot the schedule call in
> nvme_change_ctrl_state.
>=20
> It turns out the locking is not necessary if we make the state machine a
> bit more restrictive and only allow entering the LIVE state from
> CONNECTING. If we do this, it's possible to ensure we either enter LIVE
> only if there was no connection loss event. Also the connection loss
> event handler should always trigger the reset handler to avoid a
> read-write race on the state machine state variable.
>=20
> I've tried to replicate the original problem once again and wrote a new
> blktest which tries to trigger the race condition. I let it run a for a
> while and nothing broke, but I can't be sure it is really gone. The rest
> of the blktests also passed. Unfortunatly, the test box with FC hardware
> is currently not working, so I can't test this with real hardware.
>=20
> [1] https://lore.kernel.org/all/denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgeb=
ryzrfxunm@iwxuthct377m/
> [2] https://lore.kernel.org/all/20250109-nvme-fc-handle-com-lost-v4-3-fe5=
cae17b492@kernel.org/
>=20
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Thanks. I reconfirmed that this series avoids the failure I reported [1]. A=
lso I
ran all nvme test cases with various transports and observed no regression.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

