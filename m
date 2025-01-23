Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626C7C02182
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2025 04:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2FFSIwjzWxtr8F3H9XOzOzR5CRw8buCwXxlgXmuMuso=; b=18b0GgOuRCY6COY6O6hRZdWOxD
	+0SK/WzjK9zfaWZtGlDSJMRaixkmVxfrEdeT+4eC//pfadNzDfULpJFe4aNPJUDU9NDjdPFbwgoPy
	qtCt7/zCqXRRdB275dmgKmJP/CJQ8lcV6TzUCG0XgCbMv3S5qjxxbzMtx9SwR2Mu+rtOntqdJljBu
	S/k3pjjeKGJ3URr+Xq6W4YqC93P4BosJigBRYbiGn+x1kHVJox54PhSm3+fRxhEp1GOj8pmWVSY65
	ugTf8WiCjhGiVa5DmOpBXdJhHLMMnEwuG6n5zGDKyOhqd/jZX5t3e2htJXvWKoeJ//dzIQ1vH6AwG
	hdItdYlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tapDK-0000000BhsR-0bVq;
	Thu, 23 Jan 2025 04:53:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tapDI-0000000Bhs4-02pA
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jan 2025 04:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737607987; x=1769143987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YEF8RNJ8CWy+u4V+0u7fhY3ndK6dbaDjCoANNz8qih0=;
  b=Kiv7Iia9TuV07ShHNWp274YjP1ftaPZXc1a0ggciedc8vLqkcBNb8yfz
   ZDzLs6VS8OKha46aTmRfOKhFMM6JG9aF4QbcyOuX5Pw+SJCkbnY21Z49W
   RKTjsYc9ZxoTZuVHWbobWUznmzS0u1OM+Xdl1kPjTEuboo6mcFOiqAHcv
   zElfD6q1NEldC5+2syhIAtQk/dEl5eaKdLJg03PKWed1/SiZcjQAxVg8D
   PeGGZzUmnqx/xIfG8pf8Vts9+osdaVXneDdRZtz8d0AN07wIhzsizFsiT
   dIBbAkuPNXo39jYljvDoGMYtWZSCgDM2e0lfMYd9HmULKPOmLBs+KTWug
   A==;
X-CSE-ConnectionGUID: 4a4XT9IoT6SJ2c6T7BigsQ==
X-CSE-MsgGUID: jfrDdZo8Sd2ZRnMF3J3Y7w==
X-IronPort-AV: E=Sophos;i="6.13,227,1732550400"; 
   d="scan'208";a="37798256"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.11])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2025 12:53:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi7b+yiAkckBMjKYaN2Phhoo4WnM+mCa+pTkJhHjiyV/knt++UmnByP0qLKhwjzKNP2WuC/Giuu+pFfNwqv1X9k0gmt7AqLAH87dNq3OwL0EhKYLrQlfM4RwP7bIQt3nNcSUgpWUqbESR6CNaXnP2xhaxYLQhuHGJedq4NURrbJZlLFbgwq6GIMpM0p/C3hnzLOY0mNrAItIF26OgB9Lt1XpWfsKSVQjuMjgoccTvHbswT95pqN2tYBxdIxHOJi92XE+ZGIGXvbrv0xiZiKWHmC++IJTlKfTRRIltuqkT+8JKQdezRM5tAkzoqG3AXYzpD3bcbx1IlVl78hCbv8eHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FFSIwjzWxtr8F3H9XOzOzR5CRw8buCwXxlgXmuMuso=;
 b=eecmN+EIQxCTquR4/P8T40HuKoD/cbuiZbIoKRFSfJCELKFEx6wMTnIdv0Dba5BQbTBpbZFPs0pnFYHidSUHvaPZaFZX7afEtkgHtoowlmZDOKDh0fZ5bwkUTaTcQ2kYhCRmWsuwXWjRXVXD9q3vi4hdcyWiv0LzGim8VreB8YrPjPTWVtJyILQ4Ppax68Eg6bb/xhb8LGnKICZDN4jXbBQU3qSAYCmgBdpZnRFU2b3gKWchmX/jnCvmktqYzkh6z+urCdkI+gayeSIaw2L/oMvjzRbgOCZ9uXTz96sgqlHBC0FjOrlOfIJm5TpJ4b/tpe8OZn01FwVz63poH8L6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FFSIwjzWxtr8F3H9XOzOzR5CRw8buCwXxlgXmuMuso=;
 b=R5OnYV0MQDAWKX+UE5TdYaCc6slEywwY+iLHnQg/m4mumbQK+03CRnOfODABIat4WkCod3aqaZIGhF1tAb1bHvHb63QmkbmeMQQs1dkuSBpvdEwWNr6/01F+XneIcHbpZViiDoFJkC++Je81zhU/b1e82KcXoeGRI4VFiw41aqY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN6PR04MB9477.namprd04.prod.outlook.com (2603:10b6:208:4f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Thu, 23 Jan
 2025 04:53:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 04:53:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hare@suse.de" <hare@suse.de>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCH blktests] nvme/058: detach loop device after test finish
Thread-Topic: [PATCH blktests] nvme/058: detach loop device after test finish
Thread-Index: AQHbaBm6qwbeYHfpSEOskOEjKpyLk7Mj1SiA
Date: Thu, 23 Jan 2025 04:53:01 +0000
Message-ID: <vml6hqld7aqvpahyzgkt5syipzs64ncqzdr7imnbseqgkdcxn3@nyzraplwk6vx>
References: <20250116132231.349917-1-nilay@linux.ibm.com>
In-Reply-To: <20250116132231.349917-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN6PR04MB9477:EE_
x-ms-office365-filtering-correlation-id: d3898494-bfd9-4d07-9c38-08dd3b69d0fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GgukFJ5wiC85x51Bn9T6grmizVbUCDOQaFQlc01WokR1s1OrSucpXJMnr8Mv?=
 =?us-ascii?Q?Cg0C+Xmpb9tHYqhf5kYRC2Vfytnx0OahyBNo01HX7comUF5ufwKTgPd7paQq?=
 =?us-ascii?Q?VCcWd1Lhmrhu/cP8LcfcLc1iH56NUWKclPpJcc+39ijJ3HRfN3vYrR/DCyMM?=
 =?us-ascii?Q?7oPQcyqrUHWb+bl71j0rVNlIEXFaMk9VEiymFAXkDosXyVyu19kLi0f/Vz2j?=
 =?us-ascii?Q?5ZtIx+YcJ6awzuBdAe4gNn/9GJORmxmd8Udt3V1T2IWl3TdAhLN8p65wy4t3?=
 =?us-ascii?Q?2nXvnajNcHLD3pd7kbSL2Upa2Rd2MoVX3FqFW7jg++TMK6Q4LQHIeuBHhu9M?=
 =?us-ascii?Q?hTs8vd/62ubs3gr18evL9weRgUIdYXA9398ss1WJPASl499YLI8EWu7CxsKa?=
 =?us-ascii?Q?8D+AwwJTlx5epo3woo8YGaZEDcM3N9twM9r6GsdIvCW8cx1Yf2RAVnBqL/XQ?=
 =?us-ascii?Q?is5aHqloZNdPy+9P2BT3Q6CDn5bBkoFvCm/yddbPHa2NZ7GpQzpX5VxyFL9H?=
 =?us-ascii?Q?FW2eR1n95t8L2t0Jnf0r4ncX7kbwQ4lPw58VRaULvDmaB0U56LFymaux9VQs?=
 =?us-ascii?Q?uJGW67kCHSKaEz/n4qwxrN9isXjuLouPUEEp8eqAtrdSZBP+HOtqXmt/KFZG?=
 =?us-ascii?Q?0d3rCNsRhyKBR7HV0VR8rFST/UtjVRd9zOr9rSg/7s+SZ0TooNA9zBozRcHP?=
 =?us-ascii?Q?jxSacYz2I8Ic1JYuns4vfhVnfSR8iwvuVW+RT3/1L/rLnTvywfh+omEdVR5o?=
 =?us-ascii?Q?zY+++IoD0SmQUVx7rk1E8YUiK2B4aGcqfvaEk3Ttcr3U5ma1IXASX90VUUDf?=
 =?us-ascii?Q?qAYQgAmB5w5WNYDV9J1noxWnKI2eAcM+8y5pfOaW4HbH4eoqkAeyWGJv12f3?=
 =?us-ascii?Q?vbGjKKJnGuC4YxMd+3z2mvPV8jnes9wVLFzWMfVJ2EHJExmJYMDpSSdWenV0?=
 =?us-ascii?Q?piMO0ypl/opJiS5hkvZiIQNla1UsvtsygQCkcE217wBou5MPFZdcDE2MsWLB?=
 =?us-ascii?Q?qwD1DMMwxz9WYcXxbSaTvFqeGiDqzeJ75TPzuibWGmIcbWUMX2bBZ/VtxYoN?=
 =?us-ascii?Q?QOZMqyheiQEZxaiDfr7kOU7ij7LpH88b0PbLqC30GcI1AkotHQH8s/1FM/5U?=
 =?us-ascii?Q?QyXhgKS5yh9+oDJ7ZwkYiHUkYlqMX7SrVs2zRXKb1ghNyL3ePChrP6L6Ur/l?=
 =?us-ascii?Q?hAWj2OReb2z/qLYMUWYlNM4rW52ieQKxTBDtjSA1aEBLwDG1b3VPGhzMqgUy?=
 =?us-ascii?Q?0jI59mPnXCKFoWsiWWURffZ3Ur0UNMPOlIcdUwikdzGW2cOQdTc9f1yLdB/l?=
 =?us-ascii?Q?YO6hgj85E17rIWmBH1EQgZwCkkDrTYj5Dtf3meTXnsVn/qlkSg1WgHibHZ/t?=
 =?us-ascii?Q?oZJB/L4lPJlRQ/p4u0IR5DEeB732zRcqyscEa/iWS1qCXAn7b4di6JlrqEZk?=
 =?us-ascii?Q?9h1t0k1FnTbc9pQnStuoBg2M1mo1ZAMV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xlww2GBrqV5FVr13gZvQFlCK2tv7dJHWKrVdasqZTzIIUH/Udju1oOldXHzx?=
 =?us-ascii?Q?jlMgTFWd63AsE+JVLS1+lKzre/L7Y2p5d7C4qxIa0kCBNCG0P9UOfL0GiJXl?=
 =?us-ascii?Q?FIMJKEWoKFc+HkrYp8AbZjMpxUIght4ODq4gwHUZ8m1bLUxXhoJy/ZdgdOsh?=
 =?us-ascii?Q?Ncon0XYmJ2N/EAaQf9untKjJW0i1sPyT8DTqyICBlCdVfY2wql6lvQshJu4b?=
 =?us-ascii?Q?ZkcvPMpqra0AK3YbueaT6OFrfw15xtElv6kn/wje5zz1KKIig4AtYeLCOyiu?=
 =?us-ascii?Q?GeB7bhv+CvBIwIW1wTVwVENrJNL5zlKhIVrYRhROqBuERphQpCmvnXfTMoXa?=
 =?us-ascii?Q?m1OhwE9qbNLgj3V4bD93tLidOa/l7AdprzMqic3Q+n9fxTbrh99w2m9hj/r/?=
 =?us-ascii?Q?/9akMP+oi0KYr96ON+MkbXZsqdmurXQcNeQq2rL2WXfNP845i5VW+KLTWqV1?=
 =?us-ascii?Q?w3pl4egdErOP2l6HPKAVPPl/csmPTCUzu6zuaZFobzvy2NhL9xG4mYw6xYyS?=
 =?us-ascii?Q?HNVVL5s2+qxb228F8IglHG6Jl429vtkQ3AZ1wEVaUj/TgD5Vlu8uKCZQRzQ7?=
 =?us-ascii?Q?uybYX1qgoevzH0aTNVH/OycCdMYOKNm7sWnwdC3eL4q2d6CUPhQmKb1PzRNb?=
 =?us-ascii?Q?FrParbih5vgBmh/tfAFPhLDUUzTsvGexcObE9ME2ZG1if+J6Y05+88sb4h9y?=
 =?us-ascii?Q?YVwex7Y0QxVi1+R/6DJZMj1/YnCw9OoypbrTxe75SM8AiAwDNmSHkaJwrXvg?=
 =?us-ascii?Q?+jBQgN6dajWpbI1Nw6FfGRLM50eXLGTEdnpbg7GpZlHaJ1dzTwHweXj5wfJq?=
 =?us-ascii?Q?LJ1SmybWzlto99toEKWNeY4KfVWRqEd90nBTlXQ/BboDpInK9z32cXxV3rZv?=
 =?us-ascii?Q?fJ0w6lgYAKiRyaWqebNSvAqAOmrbjI0Rtaak8CzMVhfFidiDrvvbOObvXKAZ?=
 =?us-ascii?Q?8VHmlXEgCpa/s6RUZNtQz28BVAjlHFazJkAI5lNWro9vbDnuc6laJV6xAtt3?=
 =?us-ascii?Q?UqFJUul5lBectebpVvhYjiJGfYoSpRv4Lp6jVzfXqYIi8mgdtCM/VC31Zzp5?=
 =?us-ascii?Q?5sMuHjeQI9XD4wbnBgh65lsCEFi86nyhA+v679SKt+Pxj3oRmTcG4Afb0In+?=
 =?us-ascii?Q?c9DE5XdcvEx+XIGyeB82vsCldFBTkJsrKGnvTi2F5kzAmbKDZYxRKWRoNktu?=
 =?us-ascii?Q?ByQlqI8H7PiWhlDUeNqUxq/MrnlewrhY5nJMNAlf9hcuiiCHGILm9U2G0yhz?=
 =?us-ascii?Q?+loO8BOW7R3x4ut9l83sw5vGO5Ms1MtuKeZdG4Gp+wkBa6zEz02/WfWIih7t?=
 =?us-ascii?Q?IVTwj134cXGQYtxEm0XImvSbnRFyv3i+EZHuvYsXuHGOMr6tdIusIUCK5bx2?=
 =?us-ascii?Q?H2Kzn62bMF0xwM1Z963ZitUAXDjvsgj48sWm2LaE1ueiB1gsQ1djEEW7LJUf?=
 =?us-ascii?Q?gppoGBF/YKuc9tx19jw3lFuhb2HMawKOyPD63NSwADPDRo5zri2vkcUfHj1y?=
 =?us-ascii?Q?PqFVdM//sGxXSgcr1gxbusFjNVNYrNyHnYJ1GKgdoC3utWV99LN19ezvoPXo?=
 =?us-ascii?Q?y8VZ2x4r07agQWY6Nu66f07Lzl6Ck/JUMrIMIrRnIBBwApNJueENbsmxNmiX?=
 =?us-ascii?Q?KNj4C6K+aBDQVKnzudaIpMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32641B9DC731BF4CA09B9604DC352F73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1yu3JokIFMRgJk6MfQ6kdegF6Da0mNNasrIHABqK33B2+iVl5bhPytYRJQJ+VOOIvwu8t3or2sL7VlkYuGiDvlj1zCMIchrgaEw7hgSqvAw0BTFaOerduYvzOnvOqU2/KNwnqJ3/krwnoZ5xRLX4kflnQXpeRuBB6skjCYleHvglfgffocVemgAbddQiLxb/YhVgCOD4jtn72MBuwEz8iXA4ETiOK+MMm+VrBN3mdkac/F+B6jbkbv5zO5BbU7Nz3UkxVxvxfoXpAz7TTfPQt/cQgw/LAwpRQoEfzLAzaAPMVYYso4GuFkNCe68vvgEoW0pa6jfZwiLXdaPLxw/59fOT1n97Np+ea8SmWNbl2GOkHWFS5sGdk3/wB7IBj/nDU0v0JSQ4YDrf1QIoYfHb9Es+Lylpt7pgCZzGHeBNQBBeHTk87AQaCgIPG4mnQ8C50OcfUChPcv897xw/9q2e4YIS73+plfTr/JAejT2a8sKZC/1Z7vqsu6lX0cVXW7LDse9efckP00BCmEgjSD9CJY3c7VW47gtdRR5NnSy6FyIHF0cAYOjQSuoK7jzSc6o2YlwA/Ja1J7w5tInnPJ6nveqkqsqZ1qnmiVdHwEQ1c4Jf+EUXzK08o5NRN5RCXpPj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3898494-bfd9-4d07-9c38-08dd3b69d0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 04:53:01.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScUdrT2bNJ9F+ZflbwJPLsjGhEvaSIWQZvCidSUCF7Tf7l29cWZsqt+4pQoI3b5BM5M46Vh00exRCcCCE6mcDtJ+3hv2ZtOAiwpZkBh9YV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9477
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_205308_083767_FA5E9155 
X-CRM114-Status: GOOD (  20.27  )
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

On Jan 16, 2025 / 18:52, Nilay Shroff wrote:
> The nvme/058 creates three (temp file backed) namespaces and
> attach each namespace to a loop device while starting the test.
> However it never detach those namespaces from the loop device
> once test finishes. Ideally, we should detach loop device from
> namespace so that the associated loop device is later destroyed
> and its resources are released. This patch helps detach each
> namespace from its associated loop device after test finishes.

Thank you for catching this issue. This needs a fix.

>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  tests/nvme/058 | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/nvme/058 b/tests/nvme/058
> index d230a21..99e7e81 100755
> --- a/tests/nvme/058
> +++ b/tests/nvme/058
> @@ -99,6 +99,17 @@ test() {
>  	done
> =20
>  	_nvme_disconnect_subsys
> +
> +	for ((d =3D 1; d <=3D num_namespaces; d++)); do
> +		local file_path
> +		local blkdev
> +
> +		file_path=3D"${TMPDIR}/img${d}"
> +		blkdev=3D"$(losetup -l | awk -v path=3D"${file_path}" '$6 =3D=3D path =
{ print $1 }')"
> +
> +		losetup -d "${blkdev}"
> +	done

This for loop looks similar and redundant with the other for loop to set up=
 the
namespaces. How about to keep the blkdevs in an array, and refer to them to
detach? The pseudo code below shows this approach:

 local blkdev
 local -a blkdevs
  ...
 (in the 1st loop)
    ...
    blkdevs+=3D$("$blkdev")
    ...

  ...
  (after _nvme_disconnect_subsys)

  for blkdev in "${blkdevs[@]}"; do
      losetup --detach "$blkdev"
  done
  ...


Also I suggest to use long option names instead of short names for readabil=
ity
and code stability: e.g., instead of "losetup -d", let's use "losetup --det=
ach".
(No need to replace short option names in existing code. I'm suggesting thi=
s for
the new lines to add.)

> +
>  	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
> --=20
> 2.47.1
> =

