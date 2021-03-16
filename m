Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BABC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:42:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80DC65067
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80DC65067
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VIS799X1XSu666vTF0IdmwnZtN1Zv0539l2aeuQmHxc=; b=g4GXvKesF0ZXk0FJKSqy+cFbd
	/PWSV2TblTZlMrO4oMewKP4Q9jtudUjycl4cgsfJLfehyYkYLZEc56KcZuxMB8LNC5NMoF3f5+6P8
	R/u9Prhi5jo4m6feUkmfVqGrHQvXNDu1BGy+zwKmNOA5EPsd/QJzk/3i1Ac31ErTI3VuZi104QX5n
	zWAhvkQb/7y2LICoN5dDzCXU5oVe/fq95UtofLnwk75eobFzGsLHZCspXZimsJlNFLURxgHXnuODs
	xVlnqM6uvrxSlv24ohlCWPFhTGcQtkZ21UiXvx9WurNwf3nkR7Wgp8dQxJRXMT0OrNLH5oG6RvZam
	RPdFWmXGA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM0bH-00HLGL-7Q; Tue, 16 Mar 2021 03:42:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM0bB-00HLFo-Lh
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 03:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615866145; x=1647402145;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=7OO/mkEPD8uoa9+czt3/WuxGreAE9F3ApEmrHa4zjvM=;
 b=ZsNnldmaE0NiD0rb3uEYgJ7HeNRkQdU0l/yPwwqQhvTjRXKwpJnMe45B
 lKSq49f+w7XUqEntIgaxu4nd543UoPf9kAOkMBIGPk0iQB0p3WApnWeDF
 gwoxJ7pSWD2WlacTgaGpTDunNtWghXMZYZ2Q7x5Ax4O54uc1DnIJUGh4P
 81ZuQozm7alDpw6gXZoPzx4nIP2wR1C5mEUqUcU77ufi8VOX81bq0tD4L
 HGdataF/ymuwqX6rz0twGSRX1yZ1//NZ8ntgEPdvRUYSIUrFzMMdd324u
 og7Zg4W+/CMqBk7fQP+AQPC10QW+lN07/0v4qxKyWLDMLyYtYAcH/yg0V g==;
IronPort-SDR: sYhBuUmmzXg9ldl45OEGR6I7joIW3+epvEH85hmEAP/6GV3Bix8BkL4NKxc0HS9MBzRNUj6Rz8
 7R/9bC0dypwT9s+gxz5pXIvMnUfNUq7S2GJ6hp3s729vZhF4/1NqytIjy/2ChudkfAurA+3UVH
 K0WALsS0zZ+LXrbhi8fIyW2RPQYyYB6k1jR3HOIxN9bUwyN/2KTD/DGGqbWkPaWaSEVgg6yLgM
 5dornC51YjW3XoWztaE8jUvWmvtwpnzdrwAc9nKqsC+jFYyEv7Sc0iv7U6VWDEblCaPjXI3aV5
 eEU=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; d="scan'208";a="162203666"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 11:42:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7+rHCqbKfdsD6BVsaANie+Ez4rzlncSUYnwtjg5Le0REMDqnfapMtvV+6CCVQ693Ec5zKs+egCUlPGgFr928Q573NBbG+EQL+lDhwqxB+xyTIiCniShUZNhbuHpa166yXkob1H0WMldEiJV67EbdLPs4vxUEJpKIVDRmFmpBB7pcgcPhcsuRkSZTaxCMuMfEvXZgsdZrfslH8inp3mj0bkQCCGQQpQ+3UORoKnvl6iJoIXpJfsCDqwpI0v/qEzYwVQQ5pl3UCinvyN2FkLHsjknWTEzdK60rxKL0tsCxTqqJdGCBgzjIpXxd92hvyPELa72sSnE7QMWm9PmbGX1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OO/mkEPD8uoa9+czt3/WuxGreAE9F3ApEmrHa4zjvM=;
 b=calc0syHRP+AFSMXoH4hPjMK8Xq3KNHk+TEIlO7gusyEH8y79zzF0urzXHOx/g4jPBuR9X/urlPOeAwIdfHQ/S1XRfz81Vb6nN5en7c2xlxBWUi2hC7bCbB4qdJKOCbZuVWnMM7ZvAoW8a2he92BZ7fh7mj4YytHeAN/jANh/OUsIlNE0ti5CNtO0/mzzHjrom2cpBIa1aTxoHrfli7AX74fO1mDbbKYVpE0ko50X1PuUl1G7M6yR+dsmOVIIy2YEnVNqXiAaX1zRbgoXzQgTwuYC1yTjtOfHFoBOAENfAHLtkFQX39i6wcxlbfGmp/z3zFIeo+QGqiuTNs/wtO56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OO/mkEPD8uoa9+czt3/WuxGreAE9F3ApEmrHa4zjvM=;
 b=McvPk5z2/4kI+gIiyNerz9yF0VCy6flBWEFS16da73qsdemCb2S6dj7ypHoCETl8LKFVLvkHiaWyB9HRetTxdKUHlr0igXryW6a+5DshkwyczmZHjDd73IoUBwgu6zeNZpQn36vjRVvyZk/jTyVQ/DzBxMYIVDOQVVnSKJfOioc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 03:42:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 03:42:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <Keith.Busch@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: fix Write Zeroes limitations
Thread-Topic: [PATCH] nvme: fix Write Zeroes limitations
Thread-Index: AQHXGX/pFwaz6hfi70O8DnfDpRr+PA==
Date: Tue, 16 Mar 2021 03:42:22 +0000
Message-ID: <BYAPR04MB4965F780A1DA23BD8A05787E866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210315093438.66082-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc3f47c7-4026-4434-e481-08d8e82d81ef
x-ms-traffictypediagnostic: BY5PR04MB6900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6900C90D5BEFF9CA6D2C5DB0866B9@BY5PR04MB6900.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/LxQzoz8wPalwWcJeuuFO72sE65YKFTKzGr9ZT0SwV0BfdsfaI8Ddq7bzmCnmS4m+4tltWiMUPOubNIovqETgZ2kUsaXG3tML28+h2isvc/JQxYqEGd6tDr9AkXsM3hwdce8fZdItTNSorTDeVyZJoriSLqFI+ktsIr4aF3iZDLBNOWsxh5bwpip6LRL4TfkAEhmpHRRdbGwv/Oj53IxVT0xpRYeX5498H3pHZshd+wpWWjfBY7H/kNSjHhphurdKkImV9deQZL09wlhZFInsiLZzFzOJIrtR8M/0BOVLb3RhhZBBiEOyHqeLbEO3VZ2Qlw6m64amzlh4PrOndeAGXxKPbxiHjhrKSvxuPqqDOAzq//bpas3I+ilMre9g22E2jV6aG3WTFFRdIOni7JTuEVp3faGmjO90bvTxd3XzupgtPTtxNHbzyQRW/dfR7IqapRRmdDg5n9/FjoC75vVnNmJ8zdhLaLqjK9YcACpR66RnMUgq59OdsCOqE1Hnf5okop+vXaCzU7oLLZ9BK2n1ZrAHbdxjB7y+75f9/YQ1PQ7DqVI5My8YZ/1wqQM9Eu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(7696005)(8676002)(2906002)(64756008)(66476007)(26005)(33656002)(83380400001)(86362001)(4744005)(110136005)(66446008)(91956017)(66556008)(71200400001)(76116006)(6506007)(52536014)(5660300002)(316002)(478600001)(53546011)(55016002)(66946007)(9686003)(186003)(8936002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lonm7TSL3NkOHRG96Tf1Sq+eRqCuObYvxMtAp74UR7/RoXeMfIEuC19IoWi2?=
 =?us-ascii?Q?ts0B/BWDBnUVjXEThdW+uTMUAHBVpH4vGzlzLkmnFrnhJlRcIguqRNlj2WB/?=
 =?us-ascii?Q?WL602lZzM7qx8v80ukTCzwCFMQdNtAINLMq1MvLUlrF8NkMgJ4LywDd1P08T?=
 =?us-ascii?Q?00FcWgTCThMO8gI6bWqk5GTaBB5mWGUH/Y/QXUllXg0DJGZGjhn9v5/WGsBe?=
 =?us-ascii?Q?gH7H0HOKxNorTvQGI9UbWqayelBB0Wn7qhJuna9/4TN3NO9YvtE0ivAmUMo1?=
 =?us-ascii?Q?wymzjuQ5SruIk3J/3zeO5rEmYkYRfiiv7F1cyB2K8uA/X01wnR7mQh0JDOu8?=
 =?us-ascii?Q?z4jD0MtN78ix0AMViiJQMx0wDJHKUE6f+2aTYOU/TISGxQxfEBfnGq1xM/VF?=
 =?us-ascii?Q?EzGCGDjN8c2yVnH76oNUMcpC8MYTH7vd0m6jaxIXxLoirJ76OJ1EVQLrZTAK?=
 =?us-ascii?Q?sm89pldwd0FflShr7niUQ9ckcQ9dBY9Y8ucAyI/LxhYFfuaqTBEEfET5+QtK?=
 =?us-ascii?Q?4Nw7bRx1QAm92lrUmBwwepkDSqd2jCZPeTkpWDsp2Ufw2tvpP/3/8XAKHdeT?=
 =?us-ascii?Q?N044NudJI15BALbHmikqoQ2mRFqUXl/NHzhqsdpPkCtNcUcmEL5XVhuhxGeV?=
 =?us-ascii?Q?jezmqFrhvhGhH4Z00mwRGasrhp+NNr2rRBWJP/IEh3fsyiEWAX+xyOfcJ1v8?=
 =?us-ascii?Q?myg6OoZOyBsYT29HQG7qUwR0xrKdS7zKD2OTh4PZCBJqLAhDbgQWBC9mrh4t?=
 =?us-ascii?Q?CGPdj5/nKqgmFegEzKeHIwgaRCGvI8ANG4uN8hJcyyXKzIufFeAwRKlqTmbT?=
 =?us-ascii?Q?cdJHndhgK2A0e1tUv607xSsRWtrTCKdsTBpBVK+zYmGsw8T29Gw7l8XNkDyY?=
 =?us-ascii?Q?h+64yfv2p3A0YkrKdO2ti7Ui1iJMWQq8lxWfuKbwxXmTIQoEyMNhdhuiFTe7?=
 =?us-ascii?Q?LfVsnCIAvqxXapvgqaV5XrULZVZquy0nQcBLRslUjLaP1qgoJHwmMfNuzRyO?=
 =?us-ascii?Q?SzGwrAjSlWg3/oeoliN/3hiMV5qoz17KAgSvm9blDUij8nY8VfjuBdan/MXj?=
 =?us-ascii?Q?XzzKWPPYJUQILvI16lK8/fKIDhjsNTsh+WcuxncqK0VWmXG4P2X1MykR+B+Z?=
 =?us-ascii?Q?3DTO6qQ8ynKbEj3j6sCQeLazUrSjVmIjpSy+vbW9GlSZ5i/vHmRtbRDMgx24?=
 =?us-ascii?Q?zv0Ym+DLHwa5rFwbjJbMq/rhJ5hXfAH/9F+J1qDgTwkkAV1dyCR8DTriBsZ6?=
 =?us-ascii?Q?XqpeLByNNlI7PNwJgy8Srl44JeyxvLoeCbklIv59KFp6IF0upxMQRukQ9Gdx?=
 =?us-ascii?Q?yDPzyzdtnpcj63RPoLWk+GLK?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3f47c7-4026-4434-e481-08d8e82d81ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 03:42:22.2108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBU5nP0CBe0uSU7pxFcCOGzEN795GRS9KflClDJRCiiSKaQjtM0kd50qMj7Cq316myra63a7rA5mItWQYyh/wM9e937HPTkfLy4qtAgcVxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6900
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_034226_509858_5390C38A 
X-CRM114-Status: GOOD (  12.09  )
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

On 3/15/21 02:45, Christoph Hellwig wrote:
> We voluntarily limit the Write Zeroes sizes to the MDTS value provided by
> the hardware, but currently get the units wrong, so fix that.
>
> Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

My bad, thanks for fixing this.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
