Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BCEC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:53:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA33361027
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA33361027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Xh8RrjfTvGLoBn8WSh14rsKn7wefKqD1My9buDeh5lU=; b=ZpiwZfXhepvxL/Jgm/zIaz3bN
	KfT+czPnXV6QoSAY8AdZQwr8vB6sz1w6aS3fBOKWjyxuaYZ6yqtB6rEe2z13vIbY42shwk8cbpAq/
	FuKwrR9bscGC6GXjVRLtCYB52kMqJVrIB8yYzDZKlmieG25M+D6RFAPokvWn5LpXeO9GLquuawZxk
	CPlYaeEJMuyu1RwepNB33SuNL6LVxmejOFlTOXx42fzzQXtd2zd0FBBKaS50yIMn+EPuALu+fsH8T
	V2YwrfQM8ZTZXMZuerORoeW+EozHB7gSvYC9txi8qO52ud8VlSH3hA3NCCMvXwD4Z+1FdzBCq6b2W
	tsGcIv/mw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lepfO-005oam-CO; Fri, 07 May 2021 01:52:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lepfI-005oa4-Jm
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 01:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=avA26UlWUWwlaJ3pVWhVdIIezeURmBa32WEXR84rXD8=; b=MbMSK1IQYtkGNVoqv2AFzVV38S
 gMzyl2nm73+uSwTvXltIbwaeIf6UAnBm9N2k9Qfqrko6YnYPvOiAVxFe+ZHqNIFvXJceIQiyGkF2a
 zOQEFJvXKpT998B7hWnL1EYXQh/c7u3SSG/s1uwYHtJzQctwQr+OrzDfmMe5zPc0Eob3Z/sHZD+Tv
 uBAJKVtI8J1ttqHmrv1LQL4+1vzGJq7fLUUno1zhDrV5eqYd02t8whmjOmWdeW1gZCbsBBUQ3L/L0
 EJfCX7H7XaWfVRMYrbCxSg6vKmwM+5DrtFJS/6zy990vqdczSAQub5nvaLWQAFWRrG1QnhD3DZY4l
 yRC4osvg==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lepfF-006VqZ-SS
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 01:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620352345; x=1651888345;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=avA26UlWUWwlaJ3pVWhVdIIezeURmBa32WEXR84rXD8=;
 b=Djpmk63Uh3dUJWQuTgi7QRFZhl2FwBcWb9v1pZ4ZVJLVGhKted94TRuz
 uEiU3VX1CF6fXUwJDChGo2BDdBaWfO78tz7SxktUjMabnF7jSHCBpBy2D
 L6qso1zxcjRGgfeMmdg9DRtjKqpKbARHJZYiGOeMhmfKoZOoaOEr9s0ZT
 4+TSyP06Qa5u+fNFTJZHc5Gb1TkQ8Wxc8eu3MH5ooGmllhjWIx7+TEo4A
 jYaJ+mkQFnquHKT7sSBgy7wvTzBWuZyhc5S9aXVvOrC1ced3fmY/MAD5r
 dwMrPNYeKz3Vy8fOPt9t/wideysZuE4pWnVNpxTMFag/exUXIZpuLIzjf w==;
IronPort-SDR: 26hP46jthb8JG4DvNsIAc8OWYOKRLZ1OMc/AlpCOwkiizhIE8OOf44E+0fqWKPuQznIbId35s1
 wOV5LtymL76XUlTSGWrvU7jnls0/8cJHjoY8vYa5XRciPD9J1bEeJBqwFhLvvwXSbIGiebByey
 Q0x6gvNWXyVyKVesqR8KGEszwlQ+7cZAdgdkbK5md/7mTGYpq+Qs49Q8GTsskK+vWO3xAP5dos
 TsuYZywsSXuZRtwXAqyBv2/wD0j4h2WoGyK11c7XelSBxTgn5hXpQCUwZkmcBYRpK3glgHPe76
 PXY=
X-IronPort-AV: E=Sophos;i="5.82,279,1613404800"; d="scan'208";a="166711790"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 07 May 2021 09:52:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZx7csvjWAmVrDsVa++36zFkA5Ni922Pz/2ybNHxI0Da7yF2b8qiersu+eH3Y5FKcZHw2A4Z7vg6AbX+ciSVFSZ3gB8nxDoVVP1k+scPdWIESj0TnkzqXYNyOm2gjAHkd/2x+IX3okd2LM/PF4fy2qDtJG5O9fWleuW7xY1jZau4PuccdDBNrRkD1RJFXGUEUaH0CXAs8irk78S2hoSsJ8nTztNJu2lr5ifjCZZ1MmmPU9DtdwTMOcbBZWSk1fXA+JBjrKv5apiWhW2AGbiubhKW4tC+BskVNmme3RAs2pD7DG9rnqdQc4ypyNnjJz2NjAQ7RmUML3aEGDA9kURoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avA26UlWUWwlaJ3pVWhVdIIezeURmBa32WEXR84rXD8=;
 b=JufJRnNFLQ+5NEzjok+lQp3L/F4yS9A5hP7CrzY8q/k36+TmCYkQpI+zAaRFERDRdg+cdr+0RQCyhi9g9l1QIkxWGBNppDsGjzWmWiLDpVNiiluNlLhh+U0pHuvDCpBpyEdr1CYmth/gYoub2QsMGuo0X7+a7W4XXLaOWF49DE7oJ8RJGQVqRaSx2o8DATg1BgGAMYsv/OGZLWrrtia46TvaXMKJGLtINVsdMtAIoVcnVKDy55brN9Rtx1IkWp0D1sK5fWEWXDb9JfviqIyX9WnGYmwzdJ2XFDJfrKtS+p31W5u3s5GxsqISykjl0freqvE1xxBklrDYi3slt7F/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avA26UlWUWwlaJ3pVWhVdIIezeURmBa32WEXR84rXD8=;
 b=uwZeT7+jkvkRu9JIWMS75xoSSeMOIn+xPG3Eb6/wc1MUmSKR3gQwdcKStH3C9WiLdSCOvRIk5VSZU8KiRWCAJSumnqxuYv2GxwnPZgXha+gqWqbdciRmAZoT/mbCfWxR/kBHxPX3Chs+F5P5iEBt+sn+c+6XoaJj5YYNWjLvc6Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7025.namprd04.prod.outlook.com (2603:10b6:a03:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 01:52:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 01:52:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/3] nvemt: demote high frequency err msg to debug
Thread-Topic: [PATCH 0/3] nvemt: demote high frequency err msg to debug
Thread-Index: AQHXPV0jd9LaY9OOv0aQyZJsUec0rQ==
Date: Fri, 7 May 2021 01:52:22 +0000
Message-ID: <BYAPR04MB4965298AFEAB0D191AFA2CB886579@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1735f253-c817-4d2a-ea2d-08d910fac19e
x-ms-traffictypediagnostic: BY5PR04MB7025:
x-microsoft-antispam-prvs: <BY5PR04MB7025CA92B33ACEDC5F48BE7786579@BY5PR04MB7025.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQbFFK+yptRtzC25ECcvOcxTfN+1tKs9qIHHXs0UqGmyhHWpk2VNwx8brZPaIIq5rWtXNuC0cZi9NtYWWdrktVskXU16if+WKky6eaQ660WyJlnroOe3ysKyaJCRlpw0C0blFKbtYvO67IT9UiU49nY5LJb07XQq1NZrdXdKWWcDfuTNviWDLPnik2/sGfn0LKlQ3ioJiFfkpZb6pCIV4Gcyyf+nAg/Plqh1+UzdpGKT0PB8lEWdbHaNxHhXnLM8QXh2P4QD1MEXx5xVOTfh4WVdsJFuE4KrahpFOegw5jYw15DqD7lDpFJW6h3Ezsd3zLg5D5vzHjStjFTKVBa6/NXOURUdMm+rzhtHzuDWDCJ5PZQHXT870+mzBuFvKGLcC4ontiaMNKDxYiNBIeOi2gbc/nj4/RBATZu2z736MYRE7v9bxUxKONqXMj8oqsSSOh6K5Gv4BGqrg6/uBBjWoNJo6e0cs/zO12qPMsd7uhB2X+An5duFgzJucUd3o3FzfjJukKttWlWM72TRSd4aulMBzr5lCf7hRPl1B8nr1jJu+XBQEDY5td/GmpewHFqWNExW5FL5kgk430uad8NcR24lzeF25eX7dfzobOy4XWAW9YVOMXia3ljIdY5WM35hidXLsNAiNOculLpeuzxQ/XcT8mxsl+tsCUC3hYGbIlTVE9jN7PCZpNafCxBpJQ5Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(83380400001)(316002)(33656002)(5660300002)(53546011)(71200400001)(76116006)(7696005)(4744005)(64756008)(66946007)(66556008)(52536014)(66446008)(66476007)(966005)(4326008)(122000001)(478600001)(2906002)(86362001)(186003)(8936002)(38100700002)(110136005)(26005)(8676002)(55016002)(9686003)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hwCB1B3r+q2kti/ETMulany2iMaYoammyhNQwZWKWN0VVXEUWqR2HuHBMj3f?=
 =?us-ascii?Q?I/LjSCrkCNPsIyvK6uDz1W4Voe2QJYqItjqysE9PiCSMXvh46B1plMXzC4g9?=
 =?us-ascii?Q?84iOLY43YLRFvGIKtn6fO4mjBm18J5L3el+NZgjXQbM3u1Wq5JH6tg1DhHOG?=
 =?us-ascii?Q?nqB0LLnKRILKdc7iy9SkOlD5LQV/5RkczHoNSDPXOHDnheB/o06pnKdhvn3l?=
 =?us-ascii?Q?rnOrDkmUMEun59GpuVX7IPc9t+zha5K1C9qKlkOa8YpRzRlOouxbgmy1PQmT?=
 =?us-ascii?Q?W9goqcpdQHiJENPl6x2kngJc+IjGbWwRZ3tbNPMCnc+jQyWc1Dd3qNNjanpY?=
 =?us-ascii?Q?9iS3IMxZ/4duP/YiAdQCRe+N57DOGJ71a5/zAUo5Av4T/0u1UGMEiCmnBVbX?=
 =?us-ascii?Q?ORNVetI0KXqLtJX6lfyQd9Z3naYkt53BoScg12FSZhIldorYSegGF1jA4sMM?=
 =?us-ascii?Q?LXFVqYfHy9YXPRcoXVnZouUAXVpesgMaYn3RnFT48dJ999jOZjPv2MtgLlE7?=
 =?us-ascii?Q?4OHTHNNbF3dQF7Tnt1ynlEq4zAxa4YO8fCkEZ27W6NyAioqQjlAOOWHXY2yZ?=
 =?us-ascii?Q?YyqpqK6TpIpHf9+xcau5RPkXpUwPp4qcJQPhesRtpNtdlH9lll+sSKF6xZNG?=
 =?us-ascii?Q?cCwXj1+Q7MhKSk0laExzyjaY+IB3s3r5LCKW3trGFq9/cdGKxKDuM5zjxwlJ?=
 =?us-ascii?Q?3Fq75O8E1pi7n4xLtlKqelJ8UWgIb1rYPdWzMh/GeCi4qkBftX2mqTiwQvah?=
 =?us-ascii?Q?qDdsqmmSxZIq9J0mxuDTP6oviSUJPDBWuquDq91LPXOurDa7LcoELl8fm+n0?=
 =?us-ascii?Q?Nq6KRDP8K2byBFc422Mn88GZr0SaAtVZaWXkQ8sa7ffwUnmrKnfLA1GaNNl3?=
 =?us-ascii?Q?hAfb22+F5H8A8z8H656KsTWTpuQKufKenE17ee7VkdEXMM7EE3t/Ij6Y/xp2?=
 =?us-ascii?Q?ZE+7QR+IC43WSyShsch0Uvlei8zPQPxJhnamLyLIgQ00pw/QBkXRfwS4rhAf?=
 =?us-ascii?Q?ATxGqKrzCimjsnVmGDxZaS8RyrPN07TSIDO0nCp9OCeL/yHu5m1ov3SiuKEo?=
 =?us-ascii?Q?i79rIqG2qglkczsiAG9AFgSjA0lM3/m7ufiprzyfQtm8bR+enPCBXwNpxK6Z?=
 =?us-ascii?Q?En9i3ZU+pofQj7KK/6MPryiUs6aOvSwkIrfVejCp2YTXG6oUhonxrw2uM4/a?=
 =?us-ascii?Q?Igi96oF8rrjHCX1YZw8nHWnMl4Ig9eMtq/sqssDivxc/0m+diLdE0xs4A/q/?=
 =?us-ascii?Q?fvyyzSm7QEH4gY+iR6b00Ge0HbJgAhxCjUnsMCfN7dzSC3oHdL7Y93U9vg8X?=
 =?us-ascii?Q?wC3Ahb1g9ZV9G1O8ilZnX3/M?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1735f253-c817-4d2a-ea2d-08d910fac19e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 01:52:22.4722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ea8J/om9ExarvvDQ7RiKT+YpXAlsx3+a0lksedj83jbUhZPuzQ5X6fJgzw+0wrl96VRNqmkF7B7A0U2E0/ixWspD+D/UjSAj0BuQi7Li0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_185226_087808_A7C9C247 
X-CRM114-Status: GOOD (  12.04  )
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

On 4/29/21 18:07, Chaitanya Kulkarni wrote:
> Hi,
>
> Based on the earlier report for the unhandaled error messages for
> command parsing, this is a small patch-series demotes the error messages
> for various parse functions from pr_err() to pr_debug().
>
> This is on the top of earlier posted req->sg_cnt series :-
>
> http://lists.infradead.org/pipermail/linux-nvme/2021-April/024762.html
>
> -ck

It would nice to get this in along with :-

4a20342572f6 ("nvmet: remove unsupported command noise")

Christoph/Sagi/Keith any comments ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
