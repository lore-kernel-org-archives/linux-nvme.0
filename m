Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB2C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:18:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88A420757
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHp7NqeW";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="lmYKpUGP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o3qvkKrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88A420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OGxjqqFuTo6sYJxjedtWJ5D+ElKOQyEYutiI23lzbMg=; b=eHp7NqeWncL2eSw20MZ4MKw3B
	xKOwLI+2IDA6xqnauqVsEzoGPJVLI2UVVKGuFubS9vkbF5Cp8VonowLI7OwftboyYYBWzbjihz8XK
	bGUFIG2XjYj1BzwRvQTguBwh3lMLE5zKLqWCKkVoKAzmJucmYFXAJ6Wgs6A2lmLWDJzOYfdZOmjeU
	9lmaAcBt+19KupszINBrjjo7f9AMgg25Tygbje+sbB8c5gudUtwlMNI04mWXdxALAFsYfRia0L5zV
	kHVf0HwLuzPREO4K8ncEdA3TTv3Fr3NhOd/pbEC3SxpvWhMu5wSvsR/zjvgPlJ7Wtjp55p28aXiP9
	FLdscse5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNN0u-0001vJ-3d; Tue, 29 Sep 2020 21:18:20 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNN0r-0001uT-DE
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601415317; x=1632951317;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4VsaSDFOOJkbACHkVdgX8cDhU8NwI8TCuV2A6mxps0k=;
 b=lmYKpUGPUg2kd1pGubchXu+uIjSYq5IDy7o+/FhKlOUTfVuGWa4DQ/XM
 EWr9d8fhyYDfmjGOO+J3rAoQcrCDyJ+aaxg90+vZpY7zar6nBDi5hrciI
 EzTSCJpT52EDPIpGH00EsPlUeuon/qxjKZEnYdV2uI1aSzbfpNJwiRzzG
 hQ7bXYFPBuj8ZzLoBxHt9RaIrIRnx+lsM7+LhpTj/kc8wS2pUvWR+f9pU
 0ww8KDNwPVlqayQn/UGHEPIQ6DGd+NeThKPwS8y6tBArrz5x29BouYiXr
 AtaL+1MB3yXQpb+ujh1tXB9OW/NZo6kvOldOw4qV63xdlcX+30VT9AFY/ w==;
IronPort-SDR: YAJUBNSoD9aBki0JmPRNyG0sih9QDzeH4HYVQlcgOFeOnwBBA9wgJvBw7RxjomOk9+RzqtXr4u
 ALuuYrHTrS5HKEA0rRnzgF3vZavoZgq9p9jaAJQyV6pscuFSyFkWhee4KSWQRBtuC3gFoEGUg+
 POnxjslwMpu25jk4i9H6fISZgiWtCdX23iuldS6vYrrd5u3kENL5Qy/S/8AKWcW92eB5o84XV0
 xee2fdH71JeiumBGQ4hjY3EhWl1DDnLYVLKNOvkqNKd7S5uvH4fhpCn9yIaoxzPwSnFi3MhP4L
 N9I=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="251999868"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:35:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsecaEKYL4Ei7QlaK36LKxwZAEBo/ph5HdQ3tneEczpZ4B7wZsh1VmSjSed4KsOJYBGxtO+93Ia9PCV/lSTJMyrPsoNEkzvBSwZzVhL6USyKox+eXBD+1vmk2iZ2d6Oe7rV0mOYjZPuzR0wTNNjiHsihBouRSeeMpqpkh4gMKhDdXaTEfqKtGybZvEkqMKFqAMGbIOxm3eqoJDkudgPUQiffV0fblMA79yp8AEgpkifBQ7dQAsUUCu0GcsrX6TnYJG9C8/V2taSDP1N7ZMJiyznZj1blRsih3nn+1COYxbQcSZKllt0KWwDFRk2bTT9nyoM3CqBw41haz6Kx6v+dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VsaSDFOOJkbACHkVdgX8cDhU8NwI8TCuV2A6mxps0k=;
 b=QxVDN5rpTm1sdWltND/cHqQXm/1Y5I9e1TYfE2kkjRFCPHTYf3Tb7QwHoKgMSoFRTibwYlXY2NUmQH+XuER3diRsE2EKbhBshUD3G09y//EiIUzkMpDN8XfHg+Ax/9p3q4UjItJcSFVXr0FCg3vmL9fn1n6owaEGMav+fHwv2z2V/YEfQD2ETT8DV4AYZ+88/I43muHdgHACIqRHUxUn/O4j2yC1g6oAd137zs0RvErZnF3TAIMCqH4g2+i0P7Vrhz1Od8MtWSib7pNmk3/xKcM9S4zteimVEex6qyIjQ0MlsCFzQgn2oQ4oJb60kk3mNOVRCCDCYVEduJ7WWNsyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VsaSDFOOJkbACHkVdgX8cDhU8NwI8TCuV2A6mxps0k=;
 b=o3qvkKrllHKcDzqNID459tVvx5M0hopI+keYCFPC7ERwyrGuXp6tT+ZVOMm1ELibWNaTVYAoh8s9BmRzTGWeTXdhDhwNs62cauD3Jzm8xeAccwSGY7aFdq+/APO3htsdz3oZY72x1+s1NXQuIecLNvjoMWZ9/M0rgFn6iIvt6BI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 21:18:13 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:18:13 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 05/20] nvme: rename _nvme_revalidate_disk
Thread-Topic: [PATCH 05/20] nvme: rename _nvme_revalidate_disk
Thread-Index: AQHWlZSwawXD9SS8C0aLf2Rdl1R1hQ==
Date: Tue, 29 Sep 2020 21:18:13 +0000
Message-ID: <BYAPR04MB496571621E4036CBD2D140F086320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 480c570a-43ff-4e21-f6e3-08d864bd2cf8
x-ms-traffictypediagnostic: BYAPR04MB4968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB496869FF371E47CB3E4B896B86320@BYAPR04MB4968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVfrrRBFCrArrx3FHh8a7m4pp2VxjwHQENzIzGMJPd0vu+oY8iv+ZrLveqHuXoud11I7BqVOYybXdEZYFsP8ETYlzyZZg8PGew/m6ErywCcNNxqeFFts067TpW76U6yJVdFt4pNa4SIWlGyk3zbbAyT8V8BTUDsJ3YqPay7qgLdEVDwr65NbCLNwi8Za1opprGqqTu8FMrtOK7RboyhBtXA3RkbUvD6Xcy4lI/yeKQ/PPKxcG+wPAHNtrdrxRLyw1/sLDP1DCO4iYWkHphc7KY2rESa0XQmjsQLlv9cTmbwOCKn0/KLyBbHI4u7vH/J9C+n7SgU6etpraB18sTIzO76TsfgwSPeQe1xakUjbUGcLbnKyYEfD23yv6vPkBDaQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(376002)(396003)(136003)(366004)(6506007)(316002)(4326008)(66446008)(66556008)(64756008)(186003)(5660300002)(66476007)(55016002)(9686003)(26005)(76116006)(83380400001)(8936002)(86362001)(66946007)(8676002)(54906003)(110136005)(4744005)(7696005)(53546011)(52536014)(2906002)(478600001)(71200400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VY2vJMQL7BOIRpqlaWAWxic7zS7J7Uzg3e0fW784KcwNTg0CddkGMGgI5aj2+5mN5/21wTuRcKbyRJJx83fcG3g2a8MB2v/6zYm7xyVCAlbPMsOV3H0MCBwgJTJ7YM0u8DfkP4m0Uj2XujkUztMCXI7A8Bg9cxHklC5+fmYzpmZLss57rZKA5jtqAd9jjU7nn70irCpHQge0sKYNmF00p2/pFDh+ArHLg8EDD0aBFL2M35foEOHgSHPpWwc0vRkzXwV6b2HpgwMTzfPImX5YQZR+mBZnOnyuDcJJ9qkoTsObnENUHRUu1f+/pAN7/IvqVJ+xjt+KzzexbsLLgqPuOlYQRTDxO/gznkkQ+oEDn5tv8mF002fWQULCmO4Vkzc6Eb5Is35e8ZQPqyD4kb+6uTOk7oaSldXg5Uzy/qhInzaD6rZHJh2eSY9gCMoTMjA+2Tc6sdRA17CdF0ZnjaDfSl+vMulPSSb1P1zjohFo7rBR/60/U7ID0F1Td/+Btfjd9awy6OnQbXPGGF0PI+t5pyG1M+uieGTedjRq99QXgxLr9DTWtTTih8KmxPAk5sKNB6MDPy5h5X0uTtIeawu1/zaOVZ4tbTmXiRZMylVomO3hME9RDPGTu3d0BI6fuRAs44xJfWXtjGRPMSXV4ETKpw==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480c570a-43ff-4e21-f6e3-08d864bd2cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:18:13.6986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyBDSkbDby16sXwxLlh7pveAoqbpLt/OYOltcfqRs4o+J+A013MA2uNXV9oYLvD5RSgO5bJdlb6p7kXXiHi93JqWFMUPgEU+UNuJ6TWkW98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4968
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_171817_572603_074903C3 
X-CRM114-Status: GOOD (  11.59  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> Rename _nvme_revalidate_disk to nvme_validate_ns to better describe
> what the function does, and pass the struct nvme_ns instead of the
> gendisk to better match the call chain.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
