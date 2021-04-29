Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5442C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:14:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A3B6143A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A3B6143A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=zBc0x6xw90i0uGcvAbN8la8qaiDew45Ew1zUGSo1rTU=; b=MCsLRbrAe3wNtxGLnJ2DfULC5
	lSkyUXTu0FjEMvAhY1BgNEcXlJZTwJNV/wCBAlWuzaY4rU/5RVYNf/97ZqDX2pzTE3N97KgF1gKl7
	luwTcNMFuyJSz0+hiIK0FwYE5AeIc1xptl4vRjGhwh1IRmrfuhXdXsXTGzoifaC8awJIal07QVhGq
	G08Ul5877/b3yQ9ebTE0oy4W/vR5ZlhFvWcXrBIbi4Pi30w9mRtoYkyKGv56eBoJJn6wXHmpPxSGr
	VjwWa8MyBBzS86kiucZaC0itGG5Q+YVOU26KoeNVsxqhtdT9dMJXQUfPCcFHWj/3zmiArC2jMMQ1j
	vbTwUPGzQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbvFo-004bbb-2B; Thu, 29 Apr 2021 01:14:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbvFk-004bbC-GN
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 01:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=VRnmAWSHi8gSV+McLZEXyAv3Zf2PKTfm8q1SaWEokAE=; b=FSB/RVur99PcIxBPFBjlR4ijiw
 zlFfv7QAyuJh5+Q54kauNR9rtSLxeJ3WHJ0SNkFakUxyrbBIW3rm9QE+ta1DBYWQw/LPgmEFqNqsl
 aqEuGYHFfp4mH8U2ABsvTMNV4utJLqMXS1CREt7yberC5l09H3YmGBPzDxpjp5Hr5LxwzYoS1fQAj
 2GPCLpvFnK+73wOpek5VJ38eS28aqqRW/+XV+3dSBHcZsqCK5bD/siiHbs/qaratDu3xRee3IRl3G
 fjlKYG4fBT2yNMFGZKLvh478973hnAXDJWOJ2ysVWJeRriN3tV4kZ2Mca/LmlZXstdHiljILXiYJR
 Q6jV8jPg==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbvFh-000J5L-A2
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 01:14:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619658840; x=1651194840;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=VRnmAWSHi8gSV+McLZEXyAv3Zf2PKTfm8q1SaWEokAE=;
 b=hRL8d5Av4jQoAnzFeSwQC1H/eWYLPPFxOMIPBU5MSelZ9WghO+lJqBZu
 fWTQtiw9dX7QiUYJK4HydGb15dFqAIYXN+HuJ+fYgilP1GrYDKHxqeoAy
 sK24uyfducV2iz6V6NzTJS7Y036uTsGa4sLkVQt5F9RWbCXxu6ATF+CZ4
 JQayAZLRNhHzRJ/6DVKnaFvL61SzbyQQA4rQdJ3axcLjiqMNkc60g8U6t
 4nf3AkfC4nPqwyLZrtqlVXUYfLXr3bsCTb0S6kdqF0amTh3N5QMxYWXuY
 DKoWBYj4KIIFPf/KhvNYxakX9tmoIqkLqVfw+xFvt8YX9/99kPUp/Cdss g==;
IronPort-SDR: IeQBo3oXUWK53i37pQItn3XPAlbaHtupyZG326JuD1SYfkRgH4fyak39kI7kapOepY7vTn1UH3
 mM/QUHKT04W/LXr3J0hCrld6Aqtv2oalgcsLuxXABkipv8OPCBcLcuLDHgTWSDvGmVdotMjH3I
 fmNlq02ZG1lwVS4CQP7QAMURZf7Y65qPIdl/0Zp4ryVl3KKZ/PiTf6KL2SGJXlOALcc/5Ts7pP
 S9FTLJ6aWjTYclBnd3AJg1uddiXC5zuuuCACY7B1KIJ3uFQzJdQjzxPTQt9G+8IlvhAkjNfK/X
 Ays=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="166609381"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 09:13:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC76km1X6bN7c0EVYaUa0CHGMubGRb0ESpA77pXrKOxu0eng57oMnq0pSnkz3PYzlu3VkX/JrcF2K2VSlDzDLNJd2BAOBz5WByv13ltnKi6NAQqC//1Z1JglmqjtQENs3SRE7mlUDvhCakedRMh4HlNCBPvJyHKhnuOwfoESbQMJ707zCp7JoUERyw+7bp4KdVBQIE+bXD+m8LeCFfrIWOdbu2DZlimYnEsyEqUqn0gZKw26h/lGLwTa4n5vAfPugcnQJT6IZ/1JLvBPP3Aov1B9fZcZdi13XJKbC+5drLgm9ecSt0wJq25TqRbkugYXIji2keuF9sdx/K3HlahsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRnmAWSHi8gSV+McLZEXyAv3Zf2PKTfm8q1SaWEokAE=;
 b=TZJwlhA0HiXOJi/XWFA4iWZFggTkFJB4vgxKf94TyucINwCZ/HC5FaySjdDAdPGQHYEZPH9WXyh9BbtZ+5LxrqCyz/I3E0N4q/IJTIhHRw90cTBF3Ya+xteelZYM7YjTUdMS4yzy6zqF3wFpXuBQyEj51/wi7lXzSWHXcaLQHDFdgWV7VUHoXUqTSIy5qAGXObSH5SRyZ2Q/Aihiaes69JtkfhKixeMycHlXtt8zW1DaJpI9vSQTCAtXDesOfWqqhOETuSuhvbf06ckoLQ5NpK+zMKROcpJoWDJpVYoW+ZjON9t6uIifrr9i2NBMfnW6IvODYLii7k7SFY4owYC3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRnmAWSHi8gSV+McLZEXyAv3Zf2PKTfm8q1SaWEokAE=;
 b=W9/zSQQkNiSVwZJ8S7P28VrdLj4yU0AnWbaiPrB5f9tvCMaRn4mlV9P3Ih+BLBdKKV8dVeAq5i/EJ8jMBrPQf/7aiMZhMPXvXWm/HyH2lAqDopLgCOkCD0qwaeA6iP+wEHq7xNkF05ZoD1iaIoi8lDlfp7riP199mC7FgsHtbX4=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM5PR04MB0365.namprd04.prod.outlook.com (2603:10b6:3:9d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Thu, 29 Apr 2021 01:13:54 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01%4]) with mapi id 15.20.4042.029; Thu, 29 Apr 2021
 01:13:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
CC: Keith Busch <kbusch@kernel.org>, Martin Belanger <nitram_67@hotmail.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Index: AQHXOtyJpVaoq+y8XkGj0nRxvGy4XQ==
Date: Thu, 29 Apr 2021 01:13:54 +0000
Message-ID: <DM6PR04MB4972A3C638895CC8C6148C40865F9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210426202842.42096-1-nitram_67@hotmail.com>
 <BL0PR13MB42914E1160F96F3EEFE518009C429@BL0PR13MB4291.namprd13.prod.outlook.com>
 <BYAPR04MB49656A4930E8A4367DFD9AC886419@BYAPR04MB4965.namprd04.prod.outlook.com>
 <SJ0PR19MB45443BABE01370BAC883B32DF2419@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB49655438E37C566A45D4E9CF86409@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210428192208.GA22589@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d8bea61-1b1c-4213-a1fb-08d90aac0e8a
x-ms-traffictypediagnostic: DM5PR04MB0365:
x-microsoft-antispam-prvs: <DM5PR04MB036546794B3C7A62656F9D3E865F9@DM5PR04MB0365.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/Qwos14vNYHB+ipaLjIJCDNNz5QWYQ5jSIIZSpT1iqkG7oRbkRYsPwUkZJ/LCJ33/2oLLvYjkQKl52ic2Y2rpv71sKrx2Y9kf/yxoSHv8Zw7LERTSX0kFrZINO+oju2s+XkI04fhGXzETS1DtL8ORNVr3iWbOLnHOz/+o8ljG0sMmu9qEsHzVsutI5Oc27dYfxD+R9WWMqElY68bxo6MGyWuoxKm4SqV3gYXxTOgD1dNVg7egnhDcEg1BsQlKTqcIHQ1ggSzCfLrsCWVjK4CB9pyUWnv8Y47/lZRYOEi99mM7GOzhY4jbu8vNPMK7Cubb2MuurtjFLrOPGzp19YIZ6Zh55rn3Ck2CBpECCy1Jz+sgt0dQpaouIJdoYKZMlFsuSYoG5fHQPnYwT/6uiaSwPMhZsT47sGTi+z12PzsKgiPbkW3Hnaz6ANXR4pQMmEW7kbaWmQkmrP2KoiSE9SwEG3Xb3h6N9SmYuSNnffuw00z2zAazMG200PgczmzTGQpahWWmHF8MVupG1fW2wcE1Czde6AkcXw2cp03EIWWhr/lREjE4xAUjxL3RbnpdQUgmxN9yx4wwbBjwRuJec96aLm7RrqFJyZZe8YZEZ1VA4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(64756008)(54906003)(86362001)(52536014)(66446008)(76116006)(66476007)(66946007)(186003)(66556008)(91956017)(83380400001)(4744005)(33656002)(4326008)(5660300002)(6506007)(8676002)(7696005)(6916009)(9686003)(8936002)(71200400001)(55016002)(53546011)(122000001)(38100700002)(26005)(316002)(2906002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xpIwP0Jkc/A1GI8Cw0mwoKg03JPMGOEStYUC2XXwtJbacetYcnW1R8v1bxLC?=
 =?us-ascii?Q?5EcTFIomNSl0frJIaNvF04Y930cf5jtnfIbKaQ0rwc9EKNBPGS1/EhCRLw2U?=
 =?us-ascii?Q?NF2PH7cj394q/Qo8LzWHuxfw8yQWF1yrPJxhnVotAHyV4y999e5SDW6CopCf?=
 =?us-ascii?Q?NNFWa1RenJtQTZeBsgyrM1f9yjdJM9HO+DSzV1q7Z6199QrU0kjspvcvHnnu?=
 =?us-ascii?Q?tyLX+uVhHgrad0qTf4u1axmmoI2TjcqsKDxTvP09p9MTF5+Zpun1S3qkORDc?=
 =?us-ascii?Q?K3X/ZBKKh15hPsa0b2ouoU63Xwidd71jjmkDxhd2g5NxA4trthJAebYCAtI9?=
 =?us-ascii?Q?/Rbyt2vhVXJzcdf2KPZWbIiKjJS3P3jvNwpYRprKXPaQ4ICdbrGjuKFbVKkX?=
 =?us-ascii?Q?ROzS4/RLERJbBffR9I977e3LhAsc1/zUmYVRqEvfLY4VVhjxSP1Vi6sYD2fH?=
 =?us-ascii?Q?a8/83IeZydPSY/qORWoa4JDaOxb0tZyoynnfuVhiKfs5kkRVrSVz2BHcg53s?=
 =?us-ascii?Q?Ru6PMO4nVbnu0wmTrlDTjmwBIpLno/SEieQcjXT600iG8IhWANoobRXRbh/D?=
 =?us-ascii?Q?U74jQmhbekscaL3NpJnWO91FMHzyg+I0Eq8WZoFeuTz8Noa035d/ebY8Qyt9?=
 =?us-ascii?Q?8mClgPOwNE46xXBKAZT1K1kKH4QOlUcGztQotfGNmbp7b4zrm1O2JmQYOnYt?=
 =?us-ascii?Q?/UslZcXxiPWY86BrbtyVnXhV2za/re458006MQYTcwqz7ftHyjJLeilqVOKD?=
 =?us-ascii?Q?4PCg9dHZHgcYZUEdfOeZBItUGi2z71DdU7eQo5a1kblcSB+oxIXAB36CMQRj?=
 =?us-ascii?Q?gCpKMEJmLAL4taQaxuuzN7ei5Zwl7LVG1rNJdINqTCZ/0DYPhDbLiC6gaBVv?=
 =?us-ascii?Q?BppFS4bF+Sv28izjIsnPBO9eP6yf5DJuD029na+V8ZLW/QvapZbsJ13C/DTO?=
 =?us-ascii?Q?mUO/QPClRyUfk1eorGX40Xw62nltsyPAoPTU3UlxHcaANRq+EqFNpdItylZs?=
 =?us-ascii?Q?C9JkfghrGMWbBouowncR7YIXlTzwxMK+iulN+yGyh3ENGmgZP/ex+4TJNYrg?=
 =?us-ascii?Q?xqN0gA16WnzIDE3rquAjQMi4QFLqlJqssnFMQ+j9SFNw5xlSOYIZX3IOr0RK?=
 =?us-ascii?Q?5hEVqgP+NLu1ZzlEw0f5q0dyjNdeEZg8CjG5KpyZdZbxr0GXmKgeFG+aqoGt?=
 =?us-ascii?Q?yClHVTs9vCQJywSqyL3/t+/xv+FUhdw0i5N+CJ6kxvIAuVhcliKrce5FbxtZ?=
 =?us-ascii?Q?ytkYR5beU1No7iz9bVmzqp8XEhISomPnfrV2ZAnkxd3tlWv6E3jQDrQXwTsW?=
 =?us-ascii?Q?wkeed6iTaVSUo5EIwxjtZy2V/QCoG9D9huH5c6KMLT2bug=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8bea61-1b1c-4213-a1fb-08d90aac0e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 01:13:54.2865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13rqfSKq8Dh+BcfJushA/+Nlst0FVYfjtKrilqAFfBSX506wtIWLyXBgSvmSZwJHmpLBSEj3zyoGj4RpKgNTBllix2g2m6Ks0xaepOWJ9ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0365
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_181401_466349_EC8DF5FE 
X-CRM114-Status: GOOD (  12.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/28/21 12:22, Keith Busch wrote:
> On Wed, Apr 28, 2021 at 06:51:48PM +0000, Chaitanya Kulkarni wrote:
>> On 4/27/21 05:03, Belanger, Martin wrote:
>>> Hi Chaitanya,
>>>
>>> I'm sorry, but I'm not sure what you mean by "proper commit description". What is "improper" about the description I submitted.
>>>
>>> Thanks,
>>> Martin
>> Commit log is as important as functionality :-
>>
>> 1. There is no commit log in the patch but in the cover letter.
>> 2. Subject line doesn't involve subsystem prefix.
> Also need the author's "Signed-off-by:" tag on the commit.
>

True, you need to run checkpatch.pl and make sure to fix all the warnings.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
