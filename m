Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490D2C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plMcXbw6v7PKsUFEclgznCENLwXp91amBB/H3GI6F4Q=; b=sjM84+wS1r0iel5eN91LT2eW7E
	ynLjlGOpL4JILlNY3TyyrZgcHUCEJBgmikEoX67+fq/AYiwl/KtbsxC4jbmnpjqDuWD8zE9kEEi/l
	Bb6VmSdjtjYhnigWTJNv+YW7ZAqjxyySS1spHnGcf7l2F8ovnGTlr72wT5oWX2trR4a14Qi+E+ycg
	EoJpzfPMxJeteLZOfEMtfhS+qz4KD2+w79EsGPG7APqkdzdd3CEYouc1V7Bj1SsL+gvKGf5kQLKfp
	n53cN6oVu8feUGxEZkaET/E5WfGGFYCrk4fWIw+jv7E+UrEJPutM4EiY/IfsG7utzmIwT9ghOdLUE
	eEOEDLsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCfdr-004sjU-06;
	Mon, 11 Dec 2023 12:44:11 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCfdm-004siX-2C
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 12:44:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702298646; x=1733834646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=plMcXbw6v7PKsUFEclgznCENLwXp91amBB/H3GI6F4Q=;
  b=oVQYd9iLYqdv6KR1wdKWWvWs1w6SdI/zznRKI5a6t1WnFBNe2XKY1VqK
   0T5Z0nUsle32q0q/4fCnjUGh7qUygbKvjkPJaCSzG0BQaOwp1i7C0WF8b
   LwACfc9bQQf0IrKRXkAwX2Gfa/Vb8ikODqRfsJPNBNQJfKHIls2AOGfky
   TYdK86nD9IhXqXmp8aXUoBj+3mraRq+NHUOJLMp9fN6AN1q4EKOla09kk
   SZZbHnOTzfSJ3U6cn4V8zUu2jwKC/aCyyWkXMMYEY0aX9sLwN4gtvn1Xt
   2fXhdlANGzEqPtnEi1El20wDqeNEn0xDGnXSqEfdUxCKsLJF5jW1jfawN
   A==;
X-CSE-ConnectionGUID: mpavW4IGRci+ktmEIhUMYg==
X-CSE-MsgGUID: M0Q0igNmT6aXNujt5OdP/A==
X-IronPort-AV: E=Sophos;i="6.04,267,1695657600"; 
   d="scan'208";a="4370812"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2023 20:44:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEOtq5aBwtV7Ncby5fuFXSWwDacUCKz6XEkDhc3ApBZ8sYZvsQYwWzf3vbHzhP57+Dv7p1pABzcHz0r322Uf0aRT9yPHBxiJTTWP9XZD+L0jyPCUY+Bfbwq5W77qUgkPuM1UZbol+DAtD1Z+BB3CwXTKkt/gt8e8psnDuUGwH3IwPQhLmh4Xk40Wr9roaZBqU8GKl+djbEGPex+/5fpx8zQH6b+cTDkBVWik+1xU0KMtrcp1jsCYhU+dnyXx8TFcCtESHH5RkoywLuEy7JNcDVkN5wbBwpw+idYMouSegyHS+oD2RozwMsuEtksDhqC7T003z3U0lCuHJY+rG0Uk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plMcXbw6v7PKsUFEclgznCENLwXp91amBB/H3GI6F4Q=;
 b=IAwGDHRfZmLIk8rKCXaBvaRPMA4+Ra45uXiw71t8qtkjPo5Ny6ilESIIF3wfTr87CbMCpfRlD4aNd2pPpVlqX2KzgrxUOo4HC3E/PI2E5hK7c8Bu90xbvMPt9wpTZemxgBeOGRkdzR4tFHCgNIfDcA4dkeLuD6QGMACs/YoBlkRswCc4vsnvMrLSJrxfBsH5nWWr9OBwFInycL7J0d0wZQxEGxLwqP2oiX8EScJoVtDDs5jQSWM4vKNKr3cFr3aJO4tmFMXHuSNYBGaedrkWbB7jhNJgyDNMn3H0WVJByHT0e36w9h0nYI5ycNJy7vYo9qVEBr0n473T+UTjJf2Dcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plMcXbw6v7PKsUFEclgznCENLwXp91amBB/H3GI6F4Q=;
 b=zcuJ4nUaT8A2MoJXafQCubVZ/nl3Jl5XJItVSz2pqLx2SG2Nttw27Qed3y/n6/xS6KZouMGufAcPC0PBz3GFxU5K9uLnSxu19A7AV4sB2bL9NT5nmPfa9kMsB7i+cUIGRDoc9fEsB4eDi6h/c6Hq7dLbG2bQ3WczpCLrXYpHpow=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH8PR04MB8613.namprd04.prod.outlook.com (2603:10b6:510:259::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:44:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 12:44:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "hare@kernel.org" <hare@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 0/2] nvmet: avoid circular locking warning
Thread-Topic: [PATCHv3 0/2] nvmet: avoid circular locking warning
Thread-Index: AQHaLC+2x7f5mGME7EOMJKhqCCpWww==
Date: Mon, 11 Dec 2023 12:44:00 +0000
Message-ID: <adh4t7zh2kgt4ttmpzv7gz3wqcc7qieiduw2g6uxdddleshx5g@t2pkg4fx7nou>
References: <20231208125321.165819-1-hare@kernel.org>
In-Reply-To: <20231208125321.165819-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH8PR04MB8613:EE_
x-ms-office365-filtering-correlation-id: 62974a1e-332e-436d-9476-08dbfa46d967
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cmf7+zO6KCA5AUQt4/1Osfnyt1rIYfVcfeuZovggUeFlEPlWEcYLAw3PrN/GsQ5w08z9Z8EfKYevyZs6vCa47Rz+KZa7JGZ0aLTpo2/NQxdcuVtW0b3NF7hNquFwI9ib8FR5NAzx+FWFy24+Cc3ADW1SDuarKqZDGys239ux2RmUmE+vxwRNQLrgqbcMZqDQdATASmK04J49D3vy3XqZH44Lhci6t5g29p10JT7OSqKO6g/TdTr8EaPi+FOLtWCWCzgM0MabaIQTnxDuZ+3h570WF1A9aAGELxOwQLSbp1V+VInVhyft+JDvl6IOlQB95iAkxryARPYW10dL8TT7tBdlr9W78IVlM4K4sV0jIbqMm/sk1X0AmsXEUYFwdTe35V5KUQeCbDl2uhZ7ZdUpwFYKUP4VUFRWZRKOc1Sx2RKWCbyxMCOGlqhHNrzNp3db3NLAU2oxc8pXljzeys9nlD9LPsvQJYbfGw+hAx0Br6M2uMCuRi1ls0Fb1lj4rSElKe7wDCPD8WinAYXyii/srRlrLZFfSIUFrDITbIX07wFPN9hOZkwZ5G8cpVmnxgKHsDuMO/uiuqTcaQdAHMq8y3axXwpv7ICLOQCLqfQIIs5SqpmVfF6+doMZAmXL41mah/bnpsAY9JYvKXiE4HSbR3Y187i9aM0pA1/gx6+iKzw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(26005)(82960400001)(6916009)(38100700002)(122000001)(38070700009)(86362001)(5660300002)(83380400001)(44832011)(71200400001)(6506007)(9686003)(6512007)(316002)(76116006)(66556008)(91956017)(66946007)(8936002)(8676002)(54906003)(66476007)(66446008)(64756008)(6486002)(4744005)(2906002)(41300700001)(33716001)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ya1giNpHvhfNuqtSCIBfZKfFPhG7lKQ7wh9DqZHLgThriiM1NGiiCf+V4RbV?=
 =?us-ascii?Q?xJjtFk643kgzUoDaau5NBdIYlHHmqpcnudCYkch+66TjAyVZ/0wirl5tfxRm?=
 =?us-ascii?Q?yF4pk3BJIY4otgXzVR7ahEsOCJQ3mh+9tyjke2v/hmms2UYK5OyzmzJpGKQ0?=
 =?us-ascii?Q?j8C44nadYvT2HoDC45tbyE8kCQvF1TjFutgKns6oFi1+UdyHhbHQxVSBe592?=
 =?us-ascii?Q?hBuWDpW0WEL6eshRc2DURzd37UL7MO5nrlWnv2Ppp2V6RPhcqcvfDeJYJ901?=
 =?us-ascii?Q?wdPcLMs9Z4wByUu8Sgk1q5APxTashf1iXRm2+TLXKEsBsQyKDsz8NQZJ0hU9?=
 =?us-ascii?Q?O8sKBZjvbJFwDzqKTInEkzH3i1zbWXNv1Yxow/XWtyhBWM8DH2H2GKdsVvrc?=
 =?us-ascii?Q?sNzY76qwNjuDmNT8DkiGqAZH4FWy9N0cgZZkO1fSFq6yRm8tADBRBZZsU9bP?=
 =?us-ascii?Q?/imaMfGRo2LJOW6IXWbQr2N0GLUSORCOkZbxHI4Ij1LIBDGti9nF9HHdLRC4?=
 =?us-ascii?Q?iQrApr1qtLghMdLO0iDNBdKVWFUURM7f5ioTpEUqIDvn1+E48Jdcu3Ivmyy0?=
 =?us-ascii?Q?fsSu2nYy5P197ZrsBoT2a/ESk4HXHW6eSJOFjkHtwZpeuZvb/ullak4Y4TOf?=
 =?us-ascii?Q?VWeRC8wrl8yZgFoQrwPdrQUKsOyKI7Cjwm4diU9UpT7jw0iWYFD1I1wIfN+j?=
 =?us-ascii?Q?U/QH6i1fJAgWUvbkb1YCCW5yTBlcnLehK+xoh+gUPZY9V6kdIyDF/OD9sKxi?=
 =?us-ascii?Q?R1gVpGDjDOLb2eXqunFXMOCBZ0ZMmNwTDbWbNJpR15AyqpO9dmZP8S8uCy4+?=
 =?us-ascii?Q?eWzKQBdoz8CBSVocFQS7FZCJ05uweq8V+rJ+tJV6+mYxFurlKqepgQEtPQXf?=
 =?us-ascii?Q?9IdcrwiJKU8eNKVdDmLY8qJ3LZYj762V0QpXGW7KkXmUlUI6kV9S+6AvjMBx?=
 =?us-ascii?Q?pTnVVLUYT6dy9x0DJCwQj2MUBLunmcribSznAmnM6X8NU3b/ZcqzGQPTEZPf?=
 =?us-ascii?Q?WSUU3NynP4jd/U88nZ3r6jO6uI8RU/GQlL02Y5459ZV5nrGmkkwG3CCG4ydV?=
 =?us-ascii?Q?+nEH8C7Y4MoWzi4XC3rcpmmvG9ppUFxeZbb3V1lsQU4/4c1bvVwwJuvemNOJ?=
 =?us-ascii?Q?nqIKPjRJpoZd3vOII2lR+lVtUc65htnY99ORSNhlTbtzxwNUv7YzpGK2SR1K?=
 =?us-ascii?Q?dbCBrOQdABM9BpPxuMSRTc9TBVGV7Xb5jnY1pUDBwm/ukezB+pYM2pheEKCz?=
 =?us-ascii?Q?Pu39G9S9SPtnvyZEIDltezIifiz6rAl0xitS/MHxwk7+FNxgm8pukkPuDWpm?=
 =?us-ascii?Q?DBRbzy3fWMHhPSvHbw8WraoN+f0wmjIQtRJA1vVyLWGmdRsCczCplkLZuyDF?=
 =?us-ascii?Q?06arxmZvnKnmLfbAwqPlLICyE6KCyDHXtpwDC0TAeG6XL6kqGgtCGbBU/AwY?=
 =?us-ascii?Q?EH7aD9HLlm5++iuzy0NOPdLE8DjwN6Pq4pyGKgaXJCPUxlAgyr+IenuoiwqH?=
 =?us-ascii?Q?1q/AZ3E6CG9vL2IdJJl36wjA6HovIKv/RANmBcu8YQXjriuAAV36RUx87Dkx?=
 =?us-ascii?Q?AHwvZxPFurwV4OTzw78z7F+9bdAkdDUbyXoEA5GgNvkvdVK7aTaDZfwVc3Dg?=
 =?us-ascii?Q?Fe92BgQw6BXdAELpoubq1oU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1B6C92E28BBAB4D914A169701B83313@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z12ZRLLZoYJfakwDnXxGbUtAqUH54pAbGC1gu7fb/qU84gEjZegHmN8O6BKG856Lvbz/M7ElJ4/NzpFUItV6Mlkb0OubYMV1ZtDtd1IAvej7XjnTsjGM0HE2CWDd4PmfxPxHCeEfaAGPgc43RAJsGyvFmFQUoqd217XheeOeDVWzX/OaPHvz47jPFcVO7xETE6chkijRPAoyRlQ1MZzHQF/4Bks8BmjcAMLnGfCDAqEVtyaFHewxe2+lfUdoFyJV0e005hKo6LtXJDb+ZS+vVV4kNCRi2hTJNoCLHztoJj3S4GgKwZCaY0PNMaM5OlRzQXW3WzdI6r2xIw/fVFi1GbRc94TEUjQ/MTNHV0cw4DHYqGmW2Zwvp9uo3rLlGSOJ+ZTvQCtfNWlMRB/aK1u3DRcpqOd4Ynwyt+ZFsB/ZjMQvYJNj2Wd1Hyrg/0UTqCfZJusFGyZeB+EKdXgoPLxbD17EeV9xIwXYDMcdJqC9DX2jwGzqd6rwUpIkGiOnsG/l3ZpQkUH/jCnv4jL+eqoPoBjs3YvLsXcmbxpUpYGqreum20YOfwz0ImNsCGQLFaDERWdMd8RwhUmkAco1Itfz/H9+xjTuv6oDbYHRx18/tSUADXKY8JGEh3tgPZLOJxQ9TXUjUkPbCjWF5c4pmxUjP1qOEXyAxMZjtbSOIHizTx0zn7fDTNhRDGieudWq9CmrmiRRqex8+X+jLEIcLzLzSSD5Mcp9NcoN0Mqi2s8lgVZHtUwtGE2v8orkPlhFVPo0FIjKbGRpLeZDJiIC7TDcyMuafDRt61+FdIK0YFX76YDu/WlWNXJGdw8KH5Oe3jCegqLfD/DIQ6H4X135KZaz16NWFoZq1qaCbbkq0JrlTLc5rFP1IeCBG075n2ToCqbiDCqvs9TwpMnX10hrTkFPxw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62974a1e-332e-436d-9476-08dbfa46d967
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 12:44:00.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRA+1pxLdsZO1pcfirs8uPLYWHfD2SeBvHjYLcokvNr7IB2pjEOswWhNQ3YSnGm5rv6I4M6FZa0uGpoEW/4kGqBI4OPiD6Yv/P1Ys3LWFO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_044407_468309_80199C57 
X-CRM114-Status: GOOD (  14.40  )
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

On Dec 08, 2023 / 13:53, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>=20
> nvmet-rdma and nvmet-tcp trigger a circular locking warning when
> tearing down; reason is a call to 'flush_workqueue' when creating
> a new controller which tries to cover for the fact that old controller
> instances might be in the process of tearing down.
> However, this is pure speculation as we don't know (and don't check)
> if there really _are_ controllers in shutdown.
> And even if there were, that should be short-lived, and would have been
> resolved by connecting just a tad later.
> So this patch returns 'controller busy' if we really find ourselves in th=
is
> situation, allowing the caller to reconnect later.

Thanks Hannes. I reconfirmed the patches avoid the circular lockdep WARN wi=
th
rdma and tcp transports using v6.7-rc5 kernel. And I observed no regression=
 in
my blktests runs. Looks good.=

