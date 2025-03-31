Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21879C36018
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 07:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9p5qRetC+z/j6KoLg0EtpdjsGYBqepCGlsh0x9hvMWA=; b=ZHtw/oIagRgqVI1XkHKT1T1h1d
	dTGosmoXeeuxgrMOQ5LDmbEGCaSGz6VejHOYP7QKSjOM1/1bvc9EOqSlySw8+G+RpDtnrzYwaNPp8
	TNXdZtbVfPc8QcWyd3Eyn3fvq95OZBS+50za0IlWTxyXedKil04ERF7GelUXJ4nyY1ckBl3hBaQ2j
	cM+wygWGGsFO2qfNNnNH0yNX/fyZBO0wkQ1dxaG+bRHdCT33yw4vY0lPmQdqLgr2pLI/FJ89c6txI
	fFwCfRBIB1btpel2CfrZ2Uhbv4mknSfpmo70i8eimq6vVhG92eQLbMc9qfiD61v9IevbaN+9IQHsY
	YaDkhclQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz9WW-0000000HCCI-2DCx;
	Mon, 31 Mar 2025 07:25:32 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz9WT-0000000HCB4-2vXl
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 07:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743405929; x=1774941929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zqykLxiQBjiTkc/pCuTiTjNW2oOYxT4tikFk1nMRReQ=;
  b=o29rJUPn/QWfkLWmG7yk8ddulyAt2UYBjU0hByIGCW9bJkYb87JglufE
   OG6IRyDttJtNTg6gudBxfHZQaal+HB5+cYVSCkaIBKa4iqYRcEUugDI7l
   l0i/w+xTEh2QGoVSmTilUVaXKELSwX9xmB1G36jt/Y1HeytjemWFljJAO
   EqtCxbt/XRrY+jp3YJRwYvFGZtxAuYcDxsL2f/d96zEoCKoP53PUg7nzf
   YmVaD12OFD2mntTbnlCKxNfwjBWWvI/jDHHdzofCWmNz4P0u+2Q8/TtgX
   YMP6lJBKE3hWqx+G00mqS4fDCIUuuE8dlZSn7d2UXLTg3NRwrNTnzYGMB
   Q==;
X-CSE-ConnectionGUID: 4Jtq/DIjSFuJ0Bi/F9U54Q==
X-CSE-MsgGUID: PpyUGCHLQICSlz0unxrAlg==
X-IronPort-AV: E=Sophos;i="6.14,290,1736784000"; 
   d="scan'208";a="69129587"
Received: from mail-westcentralusazlp17013079.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.79])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2025 15:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHfXOt4SoFPm4tdyRvtB4dlXWSonJw4zLtGz3BrarDjkxmhYexSodfz1ke3ac2MZ+ZfMchtEh/1JhG5990MrlTtzU0cUSb0OLBvscSNZLEKlxWS1Q5u3eD2wNT/hNXoFoiAxh/Yz3fIjjdd/FsVKZ1J3TmKXY/rFNhXNghZOhrXRDDHILab8a8lyKfVVMuQX4Qcp8nJ6FPjRHLzELAHuZghSO+roQwbmS0QMGsfAVCrxdTZglLMSUFAfpYb8CK75oZUcaw7LiGJ3b6avBKHteBzzIOt1iVMG8MCUClV4RTmVd9DwQGZBmza8ulhIPtmfzmUQ4RAKy/QK2AcWJr+AyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p5qRetC+z/j6KoLg0EtpdjsGYBqepCGlsh0x9hvMWA=;
 b=XImV1EqVu/jh3Ve/vXV2zIayQs4dkDNlkoVqS1AFh7gIutKzUXcyQc5k/jRYxEpleI000lP1wmFD1V4oHIj6jHuZCTkWSZckjgL1Dhc4gyk+FxdCIRRs7+FplwZ3mdXBmBNnsMc9oXMACWEOTqqeI1iNbHLvjrm3ib9hbU7HL9+Bf0a1Mc6BqNzHWR2OkV3QYSjmuEGohdnm+pCCD0+aEEif5s0m0BmEfgtbJG0PsRfQtkIudjHU/+uLzVn99SpVUbem9e0/nPpTmBE34hCa6BZ9NhAk/Ej2ej3vx539BciMyob5xEtHxrvkV+Y4hz1qJTfbTz8WA/8N/kxsG5AMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p5qRetC+z/j6KoLg0EtpdjsGYBqepCGlsh0x9hvMWA=;
 b=YXY/cZ1pqDKC3GivCb1bce+AdXlI0BZpC06Fwic0oj/AAyV0iedlG6cTRJc2h/yi7L9L51NOcgJPoxR68ZUKyxDQzkcv6c3NetOfbR7hQoDv9A+YM3UJizzGoP7xdCKsaIbai0jfK1IJtpT2cfb+a5GDhuPoU0Yp+Iz56671X0s=
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com (2603:10b6:a03:3db::16)
 by MN6PR04MB9429.namprd04.prod.outlook.com (2603:10b6:208:4ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 07:25:24 +0000
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::5088:5f08:45a0:9a8]) by SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::5088:5f08:45a0:9a8%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 07:25:23 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Topic: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Index: AQHboCmEAOZVm3jMjE+qp26mtBFI+7OM286A
Date: Mon, 31 Mar 2025 07:25:23 +0000
Message-ID: <Z-pDY0aNYLgtiCUc@ryzen>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
In-Reply-To: <20250328213640.798910-2-kamaljit.singh1@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8326:EE_|MN6PR04MB9429:EE_
x-ms-office365-filtering-correlation-id: be2a3bbc-d42d-43ab-c2f8-08dd702533aa
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zTtjIN5VyayhYeEE1AP0VhVuSRyJGtn0K5a6jMaP/X1AxqS7ck0j/F1n9ELJ?=
 =?us-ascii?Q?BruAdq/LuMrlJgvRAD9aBaPVgHkx2seGowW9KLK27raUVrQYWjqqQJZtsI41?=
 =?us-ascii?Q?zrDwwkNreWqJU1UD/EmCSc4LjruSSkRyJSCR35ikvef0PIuSzZKJCFIRBdmI?=
 =?us-ascii?Q?WpqmmKxhAngFm39F5RX4f5EMuUSscNydH8K3beAioHCIrFpaWQueVM15bA+Y?=
 =?us-ascii?Q?LJ7lIgpXidzneGCyzcJY7MmIBgxDVr0IuESoCQoPBNhZ1kL4ez1qpJxQp+u3?=
 =?us-ascii?Q?rByeqHlq55/CZArHHGTEqlh1K7AycLMefiEFZ9XsR4rCeHniVTpd8QvdTMtQ?=
 =?us-ascii?Q?LNmENb4JPE+zDdUHjGmQfJlIDJOKtFrJ6hnRBoRc5kHiq1360OFVXclzPtGi?=
 =?us-ascii?Q?s7aInPQ2PX1SCZN/mcipvPMM/Wc8QuwhmY5hZzg2oKUBK0hFFyuGzQ08Ak/U?=
 =?us-ascii?Q?rwMkisWiqpPoqdw0Vz0Dm+R535qPHiK9/GTQJP3TN8XC4MF3emLI4OMt2hht?=
 =?us-ascii?Q?JWQGABu3MXtg7MjeXf2RKfc/3FpOKsHqYPL5KCwhCgo/Czplqr6AugnERBpH?=
 =?us-ascii?Q?AmcM5s91QG2jlFkeUDuIGDYhoyEB85PMGQl2MYEUPH4KX7qOCCm71yijDeFE?=
 =?us-ascii?Q?FMgMhgZeK+ak5vY52KR6fRioNLFrmSujjZq9c00Q+mmgckYpiooSGTX33XiS?=
 =?us-ascii?Q?NA6G8LoayZ+mD5JUTnOUL1LdiybFPo2k3KpNYU4jQVwS5SoA/5nBogfg7o1Q?=
 =?us-ascii?Q?26s4uESn7nz+aqe/dgAVFNx/oxIeMqeITIm4pAKBNbvVK92NulZn1rqNFFl3?=
 =?us-ascii?Q?iZg6YaxmkCcGS9Wo2YcJuLfZrJjMUiqAJ7hZl4CgUe6g2oB/PZesSb5fosnm?=
 =?us-ascii?Q?D1FB4LWBjykVp/WE0KOQ8BxUjeNUeHMeXu2BcGUMr4jJosW1/f9ZFK3jk39c?=
 =?us-ascii?Q?WiRY+T7i3OmG5bimSaBIvr5eYuM44aVURoEM2Uo3lUXukFjlUH8avdlFegnJ?=
 =?us-ascii?Q?ORoM4nFWIhxELFjyyz6d1ojpIgUhzANueimlMeRpvGs7ZFohFnXL8khaPRrq?=
 =?us-ascii?Q?Einls/omIXbR3nGSsCrtJqxJz14woYktR4gZ1P0rzqkNrNhg/mMCWLsrJGQI?=
 =?us-ascii?Q?kuSr4QCbKLrNR5NMOPtqSdwlUlw92MivD4by1YjNXe+sHa0x/hz0lhIC/vQo?=
 =?us-ascii?Q?Ls0vOsEx70zc2xEzdub24aSnjVdVnyYFpOzniAwjPznkkheRp6O6woYcLJ9s?=
 =?us-ascii?Q?SbrTTcdIM3pcGmXhtoypmOZumBmXHsJms4k/JqjAlQxxpS37v2MGJgyWrUxp?=
 =?us-ascii?Q?TG0p/Ff+V18Ee3p2p630M5c+b9Xywqtb4yvLkhsKuImMtb/QD7XE3rx7/Qe8?=
 =?us-ascii?Q?/AJIY+9o+eeQ5M+PpWie23DKAqkxg0yyu+2+uEza3whR/RSSjIDN4XQtagO7?=
 =?us-ascii?Q?hhYMOGOEQSySwuvxsXarA9qxoK5ibo1S?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8326.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FwQdyQebDOR468JAxSPOYA+UuZvY2zZYoGLHLPe+cW0lzPX+7PxIXo04UKxs?=
 =?us-ascii?Q?EnDXgJ6X4jXFJ7gfWqK2tD1N08Etv2+Bf49W+JFXKhlSRZBwhJuoPakWCdcN?=
 =?us-ascii?Q?xGPay6ULEq2X7eF9t9u4nxSzwfKbi6x20q1lol3GPp++F5LOa4+DKsqoVaD4?=
 =?us-ascii?Q?TDUSb/1rAtakjDJuj3/6yotPnGgLHJyfRw+Zn9hPcQ51X2roaaoJPHNuhNbv?=
 =?us-ascii?Q?pLrnchRAJGHK+A6ivHxr2Uq2xiWWO8G+BPTvBr9MFM/enHNNOasktec3776I?=
 =?us-ascii?Q?QWi0m01KdPgzmQA3tS1TTqnyW69wcnmEDxipp+ZH9X3U7O2hitCOBYCjp5gq?=
 =?us-ascii?Q?KQsuSxiIbv2NzQU2e8ygE3NJQD9tnN1Z2yeQXAfFC5yeehNSBed2/jReg8Eg?=
 =?us-ascii?Q?XTkTj+INsbXLs6XXM9dfFjmw651qhG3ltJU67dnWJTWdcj0CAnbLBGca/LLC?=
 =?us-ascii?Q?NkHqj3dTPE3jDyRtSfoM9mV2S1OM0H7UoQ/n2PixMRQMk8Ua+ZudgPeJfAj0?=
 =?us-ascii?Q?WnOefofDFE0DM476xj6ESemBBaEoYUKV33O5+qkPwuWH641w6LOsS1N89Mw6?=
 =?us-ascii?Q?WvWf4sKARRKcv4IS8XE6xCNb+OJE0zZGXmCqzNK4UT7XKzFqDefdGybaCkD/?=
 =?us-ascii?Q?htTyiOPCXnCWNWvx5B2gZGJKAtfvraHfQaan6MEkmo4jE6FEL+qXFxSp3t5h?=
 =?us-ascii?Q?hNDwVITFSSvSqNGrzGR6V61iNsozsBIPcSv1De4mdJ9OLnyOodbjPGd+mGaw?=
 =?us-ascii?Q?ocPoWv27sJYC9/IZ4RCDXAooqjsT5HsgwLWT1GGHx7bbx4N1wl9xuUMl3h34?=
 =?us-ascii?Q?7K47Pg0rMnsy/BD0HMfVyJ+Beg/dtT43ZmdT/wxmHUpLN6e1c5CbF5nZXfqq?=
 =?us-ascii?Q?mfMFgJWO0YpYIu1NlCJYSWUdVA8YB2rlaenr4TbrVAdF6T8NAlM6mZmq3vFl?=
 =?us-ascii?Q?+kHU1oV+f90W6kDvcezCZmcDilG6TR16Qaq4xu5sIZXVjWPq1FWHDx7xZQVB?=
 =?us-ascii?Q?aq5yDJC74X97hFjXc4AXN7gH77QLb1gdvfbWemfnOGuqR+6U9li3JhApzOBT?=
 =?us-ascii?Q?NXdRd4ip7/lfnGMQumzjdZIPxs5TCEWSU1MjV/r/FQPuLzoLo9f7MN1pRnaP?=
 =?us-ascii?Q?FgNaac+Yn/JL2864twoaP/S9RSrYLmsNiwGfnySlwYi+JMrweguYVlbEvD4G?=
 =?us-ascii?Q?2OdUdfZFCpXIhPXA2dhwEzmwSiVqPvyxvBqoAHsecMCaqwj9HVfedvN+gQDT?=
 =?us-ascii?Q?AEp/xkobesfJAqRbrgerA+VEbXEjvtVShGgErS6uYXySdy/WlQ39tIcoTEE6?=
 =?us-ascii?Q?xCMdvnFILY/Iu6YLpUjr7kLTTcxXAfTIzVnQY0EjffK01Lo++oCubPgRxImG?=
 =?us-ascii?Q?Ao8tQ+26EHUp14igNE5k8Ndb6HYWzLNwOoNXlwZOJgNhA7KUSfedBZWeq5pN?=
 =?us-ascii?Q?pMGafwsFk6X45GtDn+swoVtEIaXmxxuj3gpug3TdpYb3YDhUNqPKS5H9fFaG?=
 =?us-ascii?Q?afSPmH1uLRfGGi/DzevRLc0cKkdgSZ0fLNP6wLWyjd/sdSru0KCeM0mvtPvu?=
 =?us-ascii?Q?8uVOeS/Dqx0rXq/uXIG2cArF4eUUPIvEq+oMVQGJYNgOIGmDTSrWhKCtiVz+?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45E90219961D57449424381F15CD129D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o7FhEbODQ2iX7rwcgp/TZQmzhpmP4sE8rnsVbGPkLSe5cZfYdE+72lEBQJecXKnjKdhDfK3OhH6PSmlGGuDkf6KBAehNXn094k6EHM8WVwCQlywJB21A4Ajpf7UJvny9Efi/auGIk22CyE97QyaFfuGxnZbmVpB5/DYGuJjY4MxIqIa51oEtoKpA1Wi+scyZOygPBRjDcD7roWrx0+HxmieLJ7H2CjfjSp2LaJ3P57P7f1UZs5o8gP8/feF8X+oMG4sgiKBN6Mp8jbeeJhOUkOZPRXhmSp4QIVJ6D/Qv3OFxQzctmwTOVkb3mRqY/QdxWpjjqxm3Qdrdh6NyDfWuxAebPFBZR6d+l08C51ZAe9qp4aVPa9PQFQQkhuTn4KVQgmr60bw4XWmj1rc+dF1V1sKLEsW/uY5bRkCksA5mjvfk1dtZX/O0wN76LUX3dWTZjo3fGk7FS39k8MfEsnCYOBvEwZZzZdYenwzyIWeiS7lCotnCA85ouRfJM39mNuIsAszXn8pFQl9LJWSswqTkMdry/boVJNjr3sWknANkopUog0Eak3PSgmgr1QxWXyPg10su6PJbDM1qfe6cz+TaWqV7+kdm7ISlSn38+B3jF+UT38/fuKMy5+b3hcnL7JRJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8326.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2a3bbc-d42d-43ab-c2f8-08dd702533aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 07:25:23.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewzjLhMk7lpT1MmF7qI/33sEfxA6kD3NKV0krUsBuN2unN9jOlJdn6VhnNW+B5T1wLCnvazD2Q0+N50fIwJ5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9429
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_002529_825967_31D71E4C 
X-CRM114-Status: GOOD (  17.08  )
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

Hello Kamaljit,

On Fri, Mar 28, 2025 at 02:36:40PM -0700, Kamaljit Singh wrote:

Like Damien said,

> Added capability to connect to an administrative controller by
> preventing ioq creation for admin-controllers.

patch 2/4,
I think I deserve:
Suggested-by: Niklas Cassel <cassel@kernel.org>

on this patch.


> Also prevent ioq creation for discovery-controllers as the spec
> prohibits them.

patch 3/4


>=20
> * Added nvme_admin_ctrl() to check for an administrative controller

This could be part of patch 2/4.


>=20
> * Renamed nvme_discovery_ctrl() to nvmf_discovery_ctrl() as discovery is
>   more relevant to fabrics

patch 1/4, you need to move the function, but can keep the name.


>=20
> * Similar to a discovery ctrl, prevent an admin-ctrl from getting a
>   smart log (LID=3D2). LID 2 is optional for admin controllers but in the
>   future when we add support for the newly added LID=3D0 (supported log
>   pages), we can make GLP accesses smarter by basing such calls on
>   response from LID=3D0 reads.

patch 4/4


>=20
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>


Kind regards,
Niklas=

