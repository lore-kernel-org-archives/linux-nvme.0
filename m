Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8C2D6D253
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 02:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2boxrFj5SZFwRxR3tGTqgNvYKmW4hsE7QY25ibjHaAI=; b=sxExAEHar2iDN0Ulq87mjs+sKe
	uXX+yRP5alMz48jfAiPBfbZMx+DaI2Vjn4FWjijnZxz1PVTFzHpLbXJBYzd3eL4Ft8pn11FSMQHYQ
	6fjxFo9PNsn+4cR6At8Aig5u9Unu5MNwNoxMW80ibuaVwceatGroQ2AqdnQSTyvrSZMWhDognbk1W
	dIzTgMdcNWEtJ1U2Zgnh3Z41GoM+m0fzSscKVgZmA/jf2Hf+JSSIncwrquFTbkqaJDXyKLhL2t3IX
	jiw+CUHvfa9W+iDzY13hP9LhfwvvAY5S4FUoZziv2I1mZcz6NGKhIcQytXYKSybbpPe+JtHVM4gk5
	YRuzD6eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGUAP-0000000EWnF-07NO;
	Thu, 28 Nov 2024 02:22:05 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGSvz-0000000EOM1-3CuP
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 01:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732755787; x=1764291787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Azth0C8enj1a6jdI8AdMKKgOUuJ/5q18Sa59EtPVKKE=;
  b=WFynp+acNVk7o3U6mnw+I4X1EIpw+aINzwT0K77Ly6UhY3u3cG72n9ow
   t9rEjVXBHE+Bn0RMvoXRJM5NoQdw2Dd0FGOQ3eh+nOqgfRQSyFTKXxU0D
   ZUyMxuDx4xBCpGMERhMYH4ZH4f7JMvyTTM7vGcb3/hNKwY0QlKE8TXifs
   ynQle3MO/1uS2qTzeSBvOLrrpln9fAj02ZkdWUuA6X5kQ8RmlFSrdLwRC
   dOMBFJpfLnTe8SzdoE2g5gHp1GzPal0yyN+oU6F52b0YayGti7CVoFAhD
   1+V2ipsWPRWiXo/CcOpcH6hXzDUMpPXNphPmP7FIJdi7WJFtbRLqaiR5n
   w==;
X-CSE-ConnectionGUID: s/11PCGdSEyvDVHem2phMQ==
X-CSE-MsgGUID: 06wJ8Jb2SwegfPdStRn2ig==
X-IronPort-AV: E=Sophos;i="6.12,190,1728921600"; 
   d="scan'208";a="33071420"
Received: from mail-westcentralusazlp17013077.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.77])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2024 09:03:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4aw17j6nO7IhkF0ns3EZdvK5C8JasXwPJEBXdkpTHf0TrvgdXVyodrnFDlf4fjSZdlT4+s/ZiGM3LeSGCBpAEhH/nBTwn3G7JG+sjYiPaVA3490awzLnSDdUlW/02vQbWDPcTqXVXzR4HAVdnpm95aMek3LSxsp18Ar8eeO9X8izY7x0vc+znQlFf+PmRLV1UcS8fHalzDs1NW22i4FYpU65BMFKPuFPe2M2YZpOwihORnssxytcKcM85/7aFbm2c92b4Q5O4sweI3NIov+SjlYJrZHkXup03KTtJ+f7ZbLgbDSH9p6pGjusGvUFiKrDwlaoCMW+8ya4zy5l5TVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2boxrFj5SZFwRxR3tGTqgNvYKmW4hsE7QY25ibjHaAI=;
 b=ElcxH8UFCop2hRieQEgqmrDtfvQT+FOcUzp4kMUKGRstUUjE4K4f91AjG9XQYYPUayCVOwPb4ySB0Xvxaiv/yTtx2e/OvdZ/qcf+Lo8T0YP4BnTRSmjEEsHX5TmBGR8ngwC8CcxHvE2cOy+X5ZznklKCr3bArEB2c3xqWxy8nfFbyAO7xqi91KSvJsIDD9/AfEd2nYz+sy5R83t2KFQLKy0wgnWrNuhG3WaQVxcPJHz6T185K4Kq3d8t0ZzpUeAebBtAQGn8LQ9619Nw1CraTPo3aYWNSRUZFx7HQsk6FV0uQA2vej10HpOW+TPvkPsCLAcfj0bmcDK5yhbf85oC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2boxrFj5SZFwRxR3tGTqgNvYKmW4hsE7QY25ibjHaAI=;
 b=COOlrKrepM+kd/91ds6q6mDTNLMQsF1wvyHVHEN11d47dXJLxxS1z8RV/xUsV1VBM3smIet2BLLhiyogae0nws6rPucHcaE3FJxDniPPBarQLoT6sbKDnvXBhFd/lcywIILf9Zqe8cjtwODAacmocA7Es3Os4QpsgsG7m2xm5u0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7817.namprd04.prod.outlook.com (2603:10b6:510:d6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.21; Thu, 28 Nov 2024 01:03:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 01:03:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bryan Gurney <bgurney@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>
Subject: Re: [PATCH blktests v2] nvme/039: check for logical block size of
 test device
Thread-Topic: [PATCH blktests v2] nvme/039: check for logical block size of
 test device
Thread-Index: AQHbP3HNd31PTIPHtk+wLSj8AS08vLLL46gA
Date: Thu, 28 Nov 2024 01:03:03 +0000
Message-ID: <e5oltln7cob2cdzkawlfbhr2hgzdajhpks3iiygh7iuzwmnqci@gmjtq2rlgs66>
References: <20241125193933.22017-1-bgurney@redhat.com>
In-Reply-To: <20241125193933.22017-1-bgurney@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7817:EE_
x-ms-office365-filtering-correlation-id: a047e68a-ed7c-4ed8-b020-08dd0f48690e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vdOmgY6pIwQ2wndtKPn5EitbVNfN4zyRg63aHvRrL4GJlVDk46SM8TlDOjHg?=
 =?us-ascii?Q?8fEn2cS1PQHhzWbdM1JEQeKLWEqV/++Ow+JJcQHRHJJF9l8X90vPfbyiNqT5?=
 =?us-ascii?Q?H/zxgBRZ/FAp3xL30fOfR0aizrQmaDGeZ0PRSNz2HXAm76qiRnhAU0jDzVSd?=
 =?us-ascii?Q?eAcH49GGTCFXSPCOuk4fIUSE+xcQATQYwKuD+AgGz+tvnvpZ1+kDvEgcIhPn?=
 =?us-ascii?Q?JcC8pbXxs/IdjfFm8fBar8QjyKrRN1bVsLFnwD4JHALgupKXlZXSM5H0+5a8?=
 =?us-ascii?Q?euDB3CXStL+fmAyYtl5h7VAk7Qy7Lf+3GSLd/eVKywUS2MxSQMlkKzYXqL9N?=
 =?us-ascii?Q?szF08h+r+lDXFPecVoN0Pop4HsMwnNNp5HmEkaYdtoVxdPNpym7+54wa2Viw?=
 =?us-ascii?Q?5ec6Oc0PakCEhFytcH+rx+17MfbewiYpv7gWpXfEg2YYfPEN8w0FBI3RZF4T?=
 =?us-ascii?Q?XuIKe19nUn9vumvbymsSIA1CabQ6qc0u1hAU1dBFsoHajRHSAyjqlwHrJK+l?=
 =?us-ascii?Q?6pr/u2yvKHh03/elMcq6AQvl6BumT6CUd1g8/tUrQgij5V7wyXoeReK5MZBf?=
 =?us-ascii?Q?qnB5tsizdvtMVJjvaLiEgbNRtd84MESU3RqDRG0ZiBv4FIxN9ZYhw5XoUY3I?=
 =?us-ascii?Q?Qe0qUyaa93QjAOds3IsvjLz1hrYOA2hCZRsSY1dnG4AvK9iFe/zuiHAFdR2K?=
 =?us-ascii?Q?6T7CI6d24hO0V9MZfqtUL3YIWNGlYr9eHgQXWKCIaXAqGkK61q5PrN6r9hSF?=
 =?us-ascii?Q?gDb2r25fSJ5Ol0NVhZlMg3Z9CD4sS8qV2XKMxp29StLpb6x1VZDMAOSbXfit?=
 =?us-ascii?Q?hlD/Cuw8DsIFYwEX9bvxxucS+oIjoaY3gcYLiAhA5GLTf5jfibiATc3eSw/H?=
 =?us-ascii?Q?JRNL8DXH3HQMMMNrg3d7akj1C3ZIWRV9Y0FSbStPiCLm4ZdDaXD1jL00T/VF?=
 =?us-ascii?Q?6+htUR/+mBaFGQtVAO1aLg0fmNoV3Is7PH8sYEk0fcmx1oOKbUFSa8ZFeVK5?=
 =?us-ascii?Q?3IrwMuRFMkatyQW1mEIPcF9yt3/eWXGlZioZ3Ajpf9oN1Pvg3GQE4xn6yPAU?=
 =?us-ascii?Q?Vtd/OKzd2ZuEfgvI6S9aBQu0vF6ICvnwTWvy0peuIZdrGhvGhFqarhtT9KNz?=
 =?us-ascii?Q?vZbM2APL2VEoUJ9aXZjyMbqjEn5Pq5hQaMMHhL6CpA/jxUF6nphvpqKL7fd8?=
 =?us-ascii?Q?hB/NNBQqbEFpHKn5UXEDxyDpt7e700ZBdXCpxUZNj96cDBBVyTb/O3b90e7k?=
 =?us-ascii?Q?ci+q/ObI6hJAOkkmOHSVmxa3PBMuGsLKV2VxE3TuT9Xr77NjcX3rOF1FM6a/?=
 =?us-ascii?Q?2oBtfgKMknP5Bxw7V2UyhY3C4t3rw2Oqgs5/mfbW26+cZrwrTkaDA0PO740J?=
 =?us-ascii?Q?CUaWNzf4N4jVG1MqdUb1IfJJbam3tJ9Du4vcO52LOlQCa1JMSQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H8K8WiOsdGTiuBPTktfJ3IF5fn2tioArq/GhR107CDS5UCntPgRo2mIviMak?=
 =?us-ascii?Q?vyjBFc6AE5JPExuV4887cYnC3SsOdB2Zvk25he804NO3rmcZ/lEBSjsm1us9?=
 =?us-ascii?Q?9f6SfbvaxyyvZq/I6uOu+2nd70zFWRjCY8LDHiT6tWxP/3XDU0Ml0QQacxls?=
 =?us-ascii?Q?LQG1rvMNmfY+iJ/Ii1t1B7UwunOeUkrHD3dSHd4/T1vNMTdH4qxhR/hCWFWf?=
 =?us-ascii?Q?iGhgYvsVdzeguidl/hEhf9iuWJuSkzNa5//iykyRwHi6Q3TSYeiESXL2KmGT?=
 =?us-ascii?Q?xRJW7/v3QlF6eZ2JX9G18nL1lKGEhblJt9yjmKL2QAPAclZxcY9H+QVwEqUH?=
 =?us-ascii?Q?u/NCe3r1ryIL8pDl1H4le3quDt0w9CqTna74d6JvCOWsk4tXSG7KoAZDTgv4?=
 =?us-ascii?Q?YcsnHzpBYYAH0jeJMm43cT/X4Pra1YTtdnfCxSV395KJjyEIIjzfhitSIIXM?=
 =?us-ascii?Q?0RnyKh6ERXvQXDgEYat5FVt4PcMM5n0YRV30V34gQrlZJlwJiPf+8kxlv+dK?=
 =?us-ascii?Q?DuLrLn3SBDy2wwmdR1LCwZxfE372+UdaMJHok7AYJ3BJNfJV75JGKdXxoSRe?=
 =?us-ascii?Q?/nfznJN6qVI2JffnQuWlTOFneOwx0vFg52TEGdfu0YzdqQy1fb+oOFcdnOGH?=
 =?us-ascii?Q?8HachVppA3EzZ+Rw30VBWs1xAHNdImZ1/U2h2zQNd4Z7CwSqJ0OtN/2zJ93t?=
 =?us-ascii?Q?gZtUYXIEPBtVusAsvB10fgo+RtB6xpljwSBe+hFuPHodyYRXn9GFvQoxqLnY?=
 =?us-ascii?Q?YnLfPz2rCxMQShg3BOb23Q+cHhIONOZIqEQ9pOWuF7rg+Toa/uxfhgPi2hWO?=
 =?us-ascii?Q?IZUOFlnoTWv/u372zvLuvEOA+uBgVbixUASkEoV7KlIgvVeq0nbsZIC1VW05?=
 =?us-ascii?Q?pQU7r/z54+FwYAyyoi/+f4FiOmKWgVQyQsF5Tj461wFM3zjo5uxZ+sUEtx6v?=
 =?us-ascii?Q?MzEDYSw8EAUmKCh85E0zLYDWTkeyVldujsCtavFVB5NngmVh3fd2hQYijMcg?=
 =?us-ascii?Q?OiUev8n8OC1pSniq+3kJGQg0GIeIumFPxYdrTJ6j+BHR4JACgwXLy+DZD8Bf?=
 =?us-ascii?Q?PyseDD52yWyoKHz5szimilkeqO8jxpIKdRE2Jw2WRn9IAbRICY5U4GkrxePO?=
 =?us-ascii?Q?dPgOGTdOEaG9d0L5wYRpPFw6egrqO1e1k7osxMfaxYZZrgL3VgUHnUmK4ZTs?=
 =?us-ascii?Q?hS1PBXeuKvYOks1kp0i6eTKSi9fZRZ90uGdRbnTbVaxba1s7fwjn1YIqZKXD?=
 =?us-ascii?Q?O+VBvDEmF+Be9I8yA4Dcr/XBjtVgnbWEoa/rk/HUUtGAfDByeDA5UKEWzLyh?=
 =?us-ascii?Q?urAU97M4vPpPeENsjnwUqs8Tpi8nsj3CHfHfwTQo39P7mTziuGeBie/8K1Cx?=
 =?us-ascii?Q?VyaJtDbMIUrr1+NizkhmpmVoyjLjDFZ462wGEoZPTUmBlggRr9ADkqCPA0NS?=
 =?us-ascii?Q?J4nBV6Z+lAPDzYOFVmasfoyGYfrmWwxX5Os7JSM8preQS5VlYTrFNPAYxD67?=
 =?us-ascii?Q?A0XNrIRFWgp4aJwnaMTQfJxs/O+UIpsUmRwEvi0jmIY1wWMDZpQ9X8Hvcph5?=
 =?us-ascii?Q?AidFU8fa8tTUBLhTS/6AYa/y9OpNxZsOgDwaNCNQl+6/mQGvCiAQA3WGQTrS?=
 =?us-ascii?Q?mZPCanJ3oh5rd/SBN+qD9Zs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4E95CB03DFDE84DABC6022C20F01EEC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aDC7ZKgSFk4cEISY6QLjUIAfo9u9UsxFXxdQW+HH2EOhuCjts4IBClw94SWH2AcreUr+E5BWiXKrsxuXCgxp24gFCrfT+VZ8g0N9Lmj/68qsO8GWiC0bRU6JvLrlaYs2u/57qwaUbGaNCIhTmwg6WU7InFkLxnfekR22UFm30910jamnTc+N0FyJHTg3LS7x58LgZ9B9oQgTu04b3JRwF/9K5zm2lTE2BgjfxcqsPjD1dHVpm+zcreHGM217H+aBRJAV5t82Dph1sNOrQ+uzJq9uagTX9Nz/0ZlVyB9saODd0CggI093xymGI07sre1YZmjfHTOn46tIUDNNnj8n1skJ+smjWZrSPWNlcg1GktWSvOk8LwfasiuqAyUFW4mZsdtlB5dpNadJpsnAxViP5bG+DsROdFSMHgKDktvfewfgAsA2MSkhPRp2B6Y64hdl8rnhApBsxw2G4sRWED/dE9MMhvueJIl7/7GBFreSsv+POpoBpg2442wTZl1G/xNprHsw3949kNfCLJU99Q77w1JJTa1AJJ5qXKPL7SabG8NwHaIX4y57G3C3Xy8a3UE05ZV7VzHwfsa19lmC6LEXsDMt1GfN/17vYR/cGB4Q5sLI/oeCZrwOZpbalOeWu3fo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a047e68a-ed7c-4ed8-b020-08dd0f48690e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 01:03:03.0846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPlOlbvdH56m9axFOSUyCoyFU7nGo4c1STuUjt1LmJ2cwd74UZVZQUfQwR2zIOaTfPuO7IioXZ4oKptw6r1eAzrGExtOJTcKPAKz1KCprQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7817
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_170307_895232_72CCC6EE 
X-CRM114-Status: GOOD (  12.63  )
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

On Nov 25, 2024 / 14:39, Bryan Gurney wrote:
> This test has hard-coded 512 byte values for the dd commands, which
> will fail on 4096-byte block devices.  Create an LB_SZ global
> variable that is populated with the result of the command
> "blockdev --getss <dev>", and use that result for the block size
> of the write commands.
>=20
> Also use this variable for the "--data-len" command of the "nvme
> admin-passthru" and "nvme io-passthru" tests.  (On a test with a
> 4096-byte namespace, leaving these with the hardcoded values still
> passed, but update them for the sake of consistency.)
>=20
> Signed-off-by: Bryan Gurney <bgurney@redhat.com>

I applied it, thanks!=

