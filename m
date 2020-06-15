Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EC8C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:19:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947472068E
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b7zejJyq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MSFXzs3B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xHcWnvgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947472068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=HuMaf0nSgygD0CgWks524QKGQFfEtOWy+UNORAJy6vk=; b=b7zejJyqip5RvH
	NSr5MaC+FuaV1KRmzFJl9DtAII9cGNECkCSI7dibDsZl1q67IeQiN1T7v4Zx/75vFsaWIjAymepLn
	rtIDGmwasoZQAD6E6iAJePBZmw4WzeYaJNtN5EkYjMgw2s39No3PdXS6v28Fk9hyCEmFg3Yu3Dih0
	PKXxbwKEc4vVGBSImKDpzNiFfLLH7wrRCCpp4fAAH6dGoYXKBGYr/qHdiLowmtvvFtwZvl++INizY
	xR6ifucsBiXW6fwXIMjYnLLOggZXzCVbhfIdYzvTUZGePJd/0AKZ8+fhiZVptnw4urhaWhXXkLerd
	wn/SKTLmLa6B9NJLUldQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkyOD-0001vp-6U; Mon, 15 Jun 2020 23:19:41 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkyOA-0001vM-3O
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 23:19:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592263178; x=1623799178;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ANo1VfJU7i+HlgDHVB1Vq03pyE6E+hNmLK3k+Pe70Hg=;
 b=MSFXzs3B/HOPUUcGzbFGq3X/JwGNmyOf3DX34MBiVWM5sv4bgnQRrO95
 NgQ7E9KAfMzAWbUK5e+CNUpSGSzLvRhX4OeRSU2DC08WOsZm9rFXVAOuA
 xhjKNkDaoTNgiTbDlKoyPZZPOcNSA/Ehhb0fo+NU4J/P0ZEXUBirlHK+G
 rJM5dgK9+XNTrf171Hn1W05adnQ+6lXhj8q/IMFYXzXDP1+EUdJE97xf8
 T9gKnhqvx4Xi5vILGTOJuv0CVUmr7FsVEWkRl5/SOXTp7ifIpNR+Mc297
 FqXNcErwMmohcVwTyRK6GtgLkcKZGfGMpmOWlJPfbAXTnbKZry7iR1xON g==;
IronPort-SDR: fzltbaogCyoLtrfO7G18/xC96qwRPgb8eE1mWBoZ0kxBF91k7HKFEKol7PLu0LCAcJKWiy9CUM
 f5zUMCgzMvUCHF1rzVbcli6+MbrfxJfORJX14p0MQTvbpBjcjV/bpuWS4UCjx3k4iaYXkCZ6Hw
 Nnb0xRf/BctwmlLAKcNPPPDmmAWcd/eBXaP7xlZMoWOcgITxZo3E9ve3+C0NscMbM2B8ONi1+a
 dx+KH5dHG4hUS/M7VJ7vr7NqVTnNo1gKslhQTNF745CoOqRehHUeul6fVRrG4IlYx3sgY+PaG9
 orY=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; d="scan'208";a="144393785"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:19:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVpwKMD/vuMBecldRspi0b4qx15blJefRAug/5F12ZPIWDAJI4H4uKQ9C57aVBkD/OCn2ngeys4Xcwr2XvCZ4NttRoLKzIEndmjSUnyC3KYnBJQNIk0KklzYEdhtEXAyLp7sfJDnidNyjkTBKb3EfjZ1/mHp1/VYvDVOQ2owj6FygpBr4+PCkKzTDewy4Ghzkk2CeaV/8yJPrPNYjO5z8rPAGPXUCz8dFkDOSFhsKSzWQkUS2r+9Qgmbty2VPriO3DkQ34U62vUJbvLZjOwL4eh7XPkIfgWMzIxo1dZwScwE5bOij+gzwN+v5JadddmxylEa6EQDOYJOu8xS3sFovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/a6Z7taXClWDoPai6vRIiLlkFUe9nc7JpRKSI6rpBM=;
 b=MelQi29gakFe/fXYYOjFdtW5LxOM0A5vuYZ+lWGT3+dH5HvTFOC0l7zpGcikv2Ct6v9zjW0ylRJjJUDDgVd2BHqeNQXFyUXnux3I2hQwGUSLhCZdf1b3wVaaj+m3Wh4At8fqhslWm0zt9y8bmwWwbdbR2EdN1HOOEsQCFKNl/uSM+gZPrD+x6OYQJ/ht+p2Ao9rQn5+xsovnbNyaNF1HRIYo32ak0mF4OV1lmL8iXQ6wZTDjmY7kq21C5KyKQUC9yHmSzPDyIMSotaWPNIdnfQt2eX4XPymDu+cSuYSHFEiu8YoO6x0yqtB2tI1RxAJgi3Qumu9xXajp5MC55HdgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/a6Z7taXClWDoPai6vRIiLlkFUe9nc7JpRKSI6rpBM=;
 b=xHcWnvgUU0Iqkq0HYCpz9aR+/5N1xRxpOX0yLNV+iYrEnQIT2yvocOJZLCLi0NrzR8gL+s8yWjr9yy+49OVe92lWcAaLv3lVpmxCKNBHEx4l9XofIrcgbhnU3hfbeQW3oA1OE2w0gYD5wqsWVMvxdLuqZ8Nedbbek5frY4rFUAs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4232.namprd04.prod.outlook.com (2603:10b6:a02:fd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 23:19:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 23:19:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "christopher.walker@gmail.com" <christopher.walker@gmail.com>
Subject: Re: [PATCH] nvme: Quirk for Samsung PM1733 controllers
Thread-Topic: [PATCH] nvme: Quirk for Samsung PM1733 controllers
Thread-Index: AQHWQ2p8sCwHP6gB1E2gsBixPm/Rvw==
Date: Mon, 15 Jun 2020 23:19:32 +0000
Message-ID: <BYAPR04MB4965BF5E04EC1C7EC82A40F8869C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1592262742-103431-1-git-send-email-christopher.walker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fc52448-7219-4c5f-2cbc-08d811828fb6
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-microsoft-antispam-prvs: <BYAPR04MB423205104B804C92CF619393869C0@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xw/Fye4Fb/J9iIzo48UIVOl1wfkY1q5clqDqc2PYYJmBWjwfVfXBYvCoLe0sbmLtOhKdUppqVvWp7HLk4ZmIknVZzLWu/UCMNge6DkG1JCLMGxKdJadr8Rfjw8cIR3vNkAdNQHl3mAEB/+5RY3vpvhSMv5p0zDrRRT2hDi5D7V1ok57ZPzSaLJNqewNIGrwORxPq6E6NYN6jc9xZ+de7249YxgKuLjeem8/DbRwAyXI8AmXk08PD6Q5HNtlhYF2PZJW2wTeYFovae1tBFv8nVQY3EQhyO0xD6HWgbTcCUK6m6vRSaPTFiCKpTJitA4IoPFaaMQzUwRavit/OEXyqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(66446008)(76116006)(66556008)(66946007)(64756008)(54906003)(66476007)(86362001)(6506007)(186003)(4744005)(7696005)(2906002)(55016002)(52536014)(26005)(5660300002)(33656002)(478600001)(9686003)(6916009)(71200400001)(8676002)(316002)(8936002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: jjR/wzEppBVl5TMJBzYXsDyl7c4dyG925FfUJn8F4R2FO4j6bLth0b42rrRofK+KhWqDqYlc/dEXCZOj+EmNREZ7cNrWkzwDP6d1x04jqQIyG3E0/sMExwy9HiNgeZqp37wJODS6RdW2LqTY8oe9I2Kng9OiHdpY2wg2/NMk6qHrtTiVUOoU2Ns5P9fCvwMiwspbFo3Ao1fb8gO6J63UTIViKkXd5eM2r22I7cO6/oJrPEKaf+xhBuIvK/mdHmKLwN0iQxx3PCuKC5PwFiU2xXMg7fxvTNA+b1J0SJ4jocp8a14b9pVYjqCEWlukiGSGG76Zlsw6ff4uU4rrOQVbvuurN3gwrXNIHKWugx9+VShM+CuPTfUxSEEyjfR0NEH6A8D1fs2KYWj2TBxrNK57qjqmHXKHdo3kH0D3oqNMZ+3VM5bToPgL/yaWBTT7MVeDss7ZYOKBoE75uqAeZLNor3DlwcaXwJ+OOETFZzkfXxs=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc52448-7219-4c5f-2cbc-08d811828fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 23:19:32.6437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpuM2gt/FSqWEXu8aOY7PUbgBKKKcU6oi/tZauwRmV6zlsYkMtFafTz06clrOqE/NMomG8ol8Hafc/JrFXrEX+Hctcv8P4zpfqenUZ2U2/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_161938_256709_4E35B312 
X-CRM114-Status: UNSURE (   8.58  )
X-CRM114-Notice: Please train this message.
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
Cc: "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +/* Samsung 1733 drives have long drive ready times.  From the spec:
> + * 15.36TB: 4s
> + *  7.68TB: 3s
> + *  3.84TB: 2s
> + *  1.92TB: 2s
> + * The delay below accommodates the 15.36TB drive at the expense of the
> + * smaller drives.
> + */

I'm not sure if this is a right way to comment the code, I'll let others 
decide whether to have spec information duplicated here.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
