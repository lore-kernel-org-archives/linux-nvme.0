Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC49C25B75
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 00:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l3p1JzBEicJtxwppRp9c0T62PSsXYGisQpwI3hKPaPM=; b=LYtATO3PfaiRgmIClkjGpEy+Wp
	YgJ7bHlBqHXvzKG/gBAp0E3lRhxDpCV4B1sGZp5O8P6iySoAJbMJu6l3IgHmWIRT/LPAn+YfQqKpm
	uUX5GXIr/MiAl9DQm0egFshg0WFShg2X/Pngq/aex6RbvByO4fR/SWHq0Yjwr9hDJxmKyW0muQT4z
	oAaWU6yJsX4Mo1r57mb9g8Y9aK2Lyn+SLfOZKhBPCJ30fgsVMTlEJU1oCBC2ihMOJqk/u/e2btgRG
	s7Q3guy7aheaplwOe5xAWbluty3rRBMPgLtTrYwXWXMtmjTNnPFr5z85x9RjCfuA9+4BnwBpNZFMX
	vcdOU7cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBOJB-0000000DULv-2sfR;
	Mon, 27 May 2024 00:33:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBOJ3-0000000DUKs-4C0w
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 00:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716770022; x=1748306022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l3p1JzBEicJtxwppRp9c0T62PSsXYGisQpwI3hKPaPM=;
  b=WWtMD8K66+uWxDALcxJN61Unevs3ITKcXjJp+QI8YZHkL+Y5nbqsQbog
   PgZyKmRuIY6M5porz5GjSiNC/RqbbzZ97E+befUFSINde0g5Qe5b3kh7l
   gxV+GBaW9YsvNVA9egxCtl+7D8H0N1bFl+Jgsl2HaLf6R0LJHrzWn5gw9
   IfbIaoExsFyHzq9obZKHe1xk11LQpBSjyBqqo4CdbF207oS54h5DZvKM+
   wXmkwWD/o5xVm/m0l4x6MO1HJAvLgNUe9YC81UDMMChZYC4CV2khJUuIa
   QMeV1Y2NLl/mwijeJetW+g91zuaVMgV196x3dS9RgJl0hJF5Lw0XHW9x6
   Q==;
X-CSE-ConnectionGUID: R9guIunaSGSbiSxyV0ywWg==
X-CSE-MsgGUID: k7UrvxSmT2O8ljTmXjnICw==
X-IronPort-AV: E=Sophos;i="6.08,191,1712592000"; 
   d="scan'208";a="17571517"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2024 08:33:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kedSfVL4sSy2lC9D/If5diGJEqcNpcJTtkSVTNCwHsTe+hB1UPWLuhW38IElnf4jhp5OL54KNy/5be2PKhRZMorKjytOjbcCroARrhEpQBjPZdv9U2HCOgCIaVD3qht3NeBukGzZU0v72aHro79xgWm6JfXqGIl25k8dKQ/yTCGP70bMtgmBtaNTj5sWZKedQCl9smdWHgoqngDZ4XDmGncPDImG08ftJ+mwBd9PkoKT3rku597yYNJ6VOxPo0nGeN4fTBC9i/nlRGUENderM+VReZ59/lcQpTgbOyq6XIcVQlZ3i89IoIhGNMVsGV2nzUdy5Fdb5bqeizScwpsfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3p1JzBEicJtxwppRp9c0T62PSsXYGisQpwI3hKPaPM=;
 b=nHCq5pe4BejlAm+UAinh7O7oFc5yEsNy1/TMFY9oHdjYR5ukvD9cJsGMiOtHurS7oYJmKFy6MaPk6fgMjApFJyxrOhiZRfT2z6Q8mYabzi9lNOlMF5AMuyuXyn/ov8nydFsa90VZZBfG0l0tQOVkWwbY565wezjm2SWPbCEf0I+VqHmwzgWHyXJqAkCpLnjgy8NsqVXd9Rt/DAE36GyBwBBKT9tZ0e+Ph6aEJdWT+rfU+8GvmzAg3pHpA3c2dBoZjxxrcnL9jRVi3qpxmgnVbt/cXqiKsNwJfwh+1Eto7GIe6khkTDQ+bJ4rT0rvpuEvBhzSbU3bgpFEZrGZID0ymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3p1JzBEicJtxwppRp9c0T62PSsXYGisQpwI3hKPaPM=;
 b=kRCFR0lKjkjHMDgEM9kEGxjtlGqME15qjQ1us057pG3erbA0p8y49M3CnzBqosGWKSFwFOsE6xtkNUi3h24/bOLEyou8/qzgdug0ev2vQeTvgSV4qZr2/OUi7vTws5qW63BB3+PE5QGhFMypW4Y55PdiHJCMGw0BSH/RkKTzowI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB8426.namprd04.prod.outlook.com (2603:10b6:303:145::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 00:33:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 00:33:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: use srcu for iterating namespace list
Thread-Topic: [PATCHv2] nvme: use srcu for iterating namespace list
Thread-Index: AQHarTWeiR7fH8u1B0mlF3YCf7pKMLGlzvsAgAC02ACAA7zFAA==
Date: Mon, 27 May 2024 00:33:35 +0000
Message-ID: <b7ebb2pcpuzfih6neabkjebqi6nyml65m7disbwv3n6rqj5uq2@sbizssh7suxl>
References: <20240523172050.4080218-1-kbusch@meta.com>
 <c7l5prtn3nxihfvbrecmf32mcfchuwrdredyl5ofhbta4a66v5@f4u3iiyev2ex>
 <27b6c6da-8ee5-4ac8-9e8e-f640261f61dc@grimberg.me>
In-Reply-To: <27b6c6da-8ee5-4ac8-9e8e-f640261f61dc@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB8426:EE_
x-ms-office365-filtering-correlation-id: 1c8f1afb-7789-494c-24cd-08dc7de4a4cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hducJX6ME+LfgOJP/nrHpfaUodtAM+3zTlwiEwDfcm3/GtXDXfgFt2xDlOIu?=
 =?us-ascii?Q?5O9YGoRBgotKdJo3LRwG0EttV8wwZkZujluCdijdJ6TGU75w7UYyP+sCdR7r?=
 =?us-ascii?Q?Z9yd/trkCLsG/fHirup5wtTsTR8WwV9zsWVxXEjIntFXnixrJAYpv2q8me12?=
 =?us-ascii?Q?hZ9F0z3vCPNMG4p90Z/OA02hUNWH7a8PvNwLaCa+g76BRslAlC1ebZpUKtGL?=
 =?us-ascii?Q?N0WfXPAa+obMERI4jOXca9OyqkpkW8fLpBpcnSL0uiyd8K1/5TK6b65Bf32s?=
 =?us-ascii?Q?hsco7EGCqXwx1qvU/Xb+B1gLhUTxbro3ClSobyPcRo6KdCZ9bZr1gxgPrehM?=
 =?us-ascii?Q?Gkri2iAiSX8hkXSapbCCW+DCPmzgX8R1awuOEuTv7OKBA/dYYKvUqn4fQ0WJ?=
 =?us-ascii?Q?ERBw5FVhg2ci7qx1R0SfIKWvw2gqQeJG25lKh+3lNXmm1v5QDLtJrhcgmbGw?=
 =?us-ascii?Q?LtdQAOAn5nvYmd9cVidKZbPELAyieTCBoi1z582BHzjxadXxnOefb4hl5uu2?=
 =?us-ascii?Q?usHK9hYdkpt4lEuX1r6ia5KwD27OxT9QC9XMUWIsV4YqLHoke6HNCo+zfu/M?=
 =?us-ascii?Q?nnKo4Z7LCaSjdIOHjjOAIzQlTDCKpEqPjineCnbUyLvcyggV6BKTO9fGRI18?=
 =?us-ascii?Q?cECd5ay84lZEdvSE6HbcpnicqUCTbrx8VyC4alCkMQeVsA1tApGjSDi1To65?=
 =?us-ascii?Q?S7bKpyG/dVhAEs+ygM5amr1/aN/5B/hYfSqTkbHTHpQQseV9/hQ+p0/GMs8y?=
 =?us-ascii?Q?b+D4r6mMedXqrhH0SZmlG9OSfOs2lKV1cHR1oqXgP6HHKSrwEHgpeQyPkqQl?=
 =?us-ascii?Q?dPCebQFr13zHzGnurVmNozsqs/+xRMzj/vqf5nsB+5L+Zly6srJvhyIlEv/F?=
 =?us-ascii?Q?pr/OmSEt/1v/msF1jq9vtPLs/RbzKVUMsOibQHrITmQpSHKrhzdtGvzOkpIg?=
 =?us-ascii?Q?KbRab+8EdLURgBI6JelGsyyuonNjymFWfk8pbVIQKDi2cCYhpydmOBmLGeFb?=
 =?us-ascii?Q?d6zyHeyttHrzN0eGZJpsRqS0NdFeYOSPE0MtCqQmNnN9mexFq78J5OWpcb79?=
 =?us-ascii?Q?tswT7uwRWTCf+ZPVA7l3DR9Gx1LFrNwnXc/YVDzcIRovzMtQNEvpJMvgDHwe?=
 =?us-ascii?Q?KrsEb2foL9DIR8hyRCreuEAF2qDnUurO2AOHjYDie8oFWCnSsW00WUmUJBnF?=
 =?us-ascii?Q?EIQt8lFwki95hBw7G19Q5kmtfqg2lbLeTQCemFS979OJZa445FW9yD0X2gy/?=
 =?us-ascii?Q?um0xNxpXeyQRr7uaCDJqKv2WdB8vAkG0ClwE+So63w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XP4aWs6KFAM/ZtuwKbUz4zGxlqPKGjPGhPsAXtyWP12muOE15qYfQl8JidCR?=
 =?us-ascii?Q?91J2UJRCxpuJyb1GWIPAdsmgHgFryPAfCqso4/1bt8Q/nF0rpohanV+Ga/2+?=
 =?us-ascii?Q?bZMrGvbgsujCghZC4bPCT8EMNKrcFuJptP3TRjslNNPgne6Th53xKXDQO5YN?=
 =?us-ascii?Q?YxAlAhUa/fiDkmxAvrhJTJfpzmwCE4UO7EVVH5gmOEICLi0Nnid0rblwesUE?=
 =?us-ascii?Q?KA5iOP8uDIMLED4XO7OPYOOvcoTqGH6ad2Q6lILeEXZVoPEoA0MYcMJG1tBG?=
 =?us-ascii?Q?1QbBhO7pW7wsRJkyo0/tmULSNZWZDvfgqP/pUS5K2dM38uBg7LxH+5pI4nSk?=
 =?us-ascii?Q?kBoQvXjDzpePKjEwqu+TvayvsOpbVgB+YYcw1OoVY1PM4fS6i1181yrBfN9d?=
 =?us-ascii?Q?uvM9gOJdLnDA0NEV4XTul5anNyy0ql9qmFqrJQ6il+9PPlblx6GyVDrBuic5?=
 =?us-ascii?Q?hWhfCnt+ESVURZ2D2+SlrsDydjCnh4KmcoaTE0AqGeKgEWsZ9qadR4nui4z/?=
 =?us-ascii?Q?AAX7HqDoG4CoR7iCCafk6s20gWuIR+1qQPpUX1tLuEPRm6vUo1dZg39qArrq?=
 =?us-ascii?Q?af3uVU6QCxSfeNV5VTAOwmmihQJ/03mXQaCk33IL7Ft0Fw8qODG1G+wV3Pp8?=
 =?us-ascii?Q?Fs/anh5nZzLlQB5+qbcaHdFhkjfFxIFu1Ri5f0sRqqLuR29Qd0cl8bo2ghx5?=
 =?us-ascii?Q?6xStEbzpIv97vD2hBFrpcM077NcQCjU74mxLepB2M0mAAY0lx5HOehXaEPws?=
 =?us-ascii?Q?D4QZXgKrObc2j/GMauA78MnnocTcrE1ecdSYq5dE9ry9jHw0+Wdue06DtST3?=
 =?us-ascii?Q?IugL5EPqA3CE6S3KHJLgYMdaK05VTiouLus9GRJVHFBZiFH8jNWRB10Gpabk?=
 =?us-ascii?Q?N+kpEM8gkRQiEUNfpr/fovSjRuQgA9Gxr0cTEolMIuW705zz0VCWrHtWeAc2?=
 =?us-ascii?Q?dQhqq4SOrTArAv7Tgm6Jf/QXA3FbxopJOMhB1vysP54XJIveWmL/jTLxUKz3?=
 =?us-ascii?Q?XB8/2Ps08k1gLoJCPqVjxD3G3Wvqa+fqFd27snSDN99mlgWZOt1RodY95pmy?=
 =?us-ascii?Q?foH+tr/BnXBuiBQm1V8TrQEY/SixkrodnnCumQzHktXFl8pl0oGUd7W9VcOm?=
 =?us-ascii?Q?SYT1P/G7f9Gune3CycTBjUQMk3VMAlvLBJXvYAcxuJRy0ZcRvmqb1nifBAlv?=
 =?us-ascii?Q?L6+l0fk7CY7+XCt4Wn69PZgDiC61pbnj3hG+kKQVI86j+pRqNtW+Pu475ufI?=
 =?us-ascii?Q?lpSYToTFnnDEIvdtm8+7oPzyVDotNhnPgGJkmYCRWMiwlLsOz40ReBzduefC?=
 =?us-ascii?Q?OBjKpTmayPAsE8fi7eR8ibcV+g1HfxVNtFTSEH8z84vVrW0I32kMrHH6AAD5?=
 =?us-ascii?Q?/i850biugPtKGOG7bKiDairJfjmTGjbX5XM8MDt/DuY5GYO+dflyIDjqoQ2B?=
 =?us-ascii?Q?szdwq2VSAUbpJ3wcgWq17IvL7/2PFcbVKVvz44qmVHjxeU7E2u+M/LMCHN7q?=
 =?us-ascii?Q?/qQMte3f4Fy6RVfZqn52uq/x33R0Wv3uDOFDcnflgUVeLG4csvhqoe7OmOu/?=
 =?us-ascii?Q?5Xf0UfvDBJ4kpa/DcvHvdwJMljxXP+a7HmAcKM1U23YwlG03MpVMzuVqak4w?=
 =?us-ascii?Q?2mQf03anXq0I0e1vYLV/U/Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D13B256FB9DD34293AEDA27B4787889@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3kHUf45+xK+VDlbuf6aaamdrBoFmZg9H7cE80n9/bvSiUi7cdWULZ0sGRiQYqIPrL3oVqLLcm+j/SjlGSMpzHETjE1uXwraKvORUgOJ/P4xSEPkUYvDwRN/8FlAws41dVjMhxFGYVzukVPgfoJOm4DhkUhQn32sau0yNivGycKAS9SItadYVWtNkflYNSFIRIhuVLVh9CY0LL7OQLhj+KWaEJQQ3to1/SfEHMs8CrkdL7Mq889dN9p2uB8k7YsDoS8ilNcS8juYOiIxrTMM5L/A5NJjenNBpEigBiXysxIpRr83qrjxUz3/ZMzmFcy3Gb/2nxeZ1HFjPEw467/QVzBz3VkMFMqx/VqG0MXgkxbT3zKeoqpRfr41TcEtUTsHA5I2lZ6teyFH/9A3wb3GyMABBgNGSk8wyQwjMJIHf+Iw48eE7bMLx0NDTrOgyVIp2a2ewgbPRWD84AHEn3CvxOxqNPWDPtn/he9SLM86NYXZTCjO87TKPky+L5/j4U7gZ1NBbC/q53wxk4FDuLVBnhkUYRp6u4r7+1YqJaiBSE4pqkM9vPFCHZgh+VyQVnJpmfPg4c1dpf33lVAKuBfDXhRg7XfofbzwLfRX0ex6wLTlqv9tGSde5mN9kYr+gzerZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8f1afb-7789-494c-24cd-08dc7de4a4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 00:33:35.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sucJ7WJMuXI7C28BF1CCNAUOHu6+97jzbX/b8h7JeqyuUhipnaClo/ux4PLGeMPuwp4eCCl62r6DJjN539n/ymXLXdmhiZOni7rb2qT/Ecg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8426
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_173342_084839_E20569F3 
X-CRM114-Status: GOOD (  21.41  )
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

On May 24, 2024 / 18:29, Sagi Grimberg wrote:
>=20
>=20
> On 24/05/2024 7:41, Shinichiro Kawasaki wrote:
> > On May 23, 2024 / 10:20, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > >=20
> > > The nvme pci driver synchronizes with all the namespace queues during=
 a
> > > reset to ensure that there's no pending timeout work.
> > >=20
> > > Meanwhile the timeout work potentially iterates those same namespaces=
 to
> > > freeze their queues.
> > >=20
> > > Each of those namespace iterations use the same read lock. If a write
> > > lock should somehow get between the synchronize and freeze steps, the=
n
> > > forward progress is deadlocked.
> > >=20
> > > We had been relying on the nvme controller state machine to ensure th=
e
> > > reset work wouldn't conflict with timeout work. That guarantee may be=
 a
> > > bit fragile to rely on, so iterate the namespace lists without taking=
 a
> > > lock to fix potential circular locks, as reported by lockdep.
> > >=20
> > > Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shi=
ndev/
> > > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Keith, thank you very much for the patch. Sagi, Christoph, thank you fo=
r the
> > discussion.
> >=20
> > I confirmed this patch avoids the lockdep WARN that I reported. I also =
ran my
> > test set with the patch and observed no regression. Looks good.
> >=20
> > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> I'm assuming that all blktests ran with this change? including fabrics an=
d
> permutations?

Yes. To be precise, I ran with following conditions:

- target groups: block dm loop nbd nvme scsi srp ublk zbd
- NVMET_TRTYPES=3D"loop rdma tcp fc"
- NVMET_BLKDEV_TYPES: default "device file"
- TEST_DEVS: QEMU nvme device

I observed some failures but they were all known failures.
Keith sent out the v3 patch. I will run my test set again.

