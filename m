Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A3C38BE0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:54:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A1D20838
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTI5pcXZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fh6Zbdsp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GV5dhteL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A1D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LqtfJdQ8n/jveM0VwesIyC7AuLhbPdgw881vnYcP/Hs=; b=rTI5pcXZLISViL
	vbTo/MGy0adO/XlKS3IBA7k8jMh4KUWyAaaM+Raf6YHf5H0dPex7h6iZ3VL3wgzStOTLo44xBRKKy
	isEYYzMwBu/lrltzpTS/mogfpkq+oijveI6grScmNCv9BkjMoAkbjkPDSsYqPJZTYe4I95fB/y7b8
	a9qmqZ8r/F9/S2zOrgTttsdoDNbFPpq8q1sNXsMgUqAzuU8L5XJs94Lobr6UrqSg8tAhUorFNQe6f
	sv6cPn56JIYpu9+Uu9+gaOnCQmQk7wV8lVb76R9QCXnWa/NJ9FSb2Rbunyr0nJN/yB1wijGHYFZV3
	FgH6H5At01fRVINrkIuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6Irz-00023w-UP; Mon, 24 Feb 2020 18:54:19 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6Irx-00023L-G2
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582570457; x=1614106457;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6NaD2m0gPWu7xKWtZ128G/09giBZSIRF5ekoxTyJFxI=;
 b=Fh6Zbdsp0LjLJayfe9KyCYi/pa3WhTY/NWvO1Zmk1rQrcVcFfcaZslm4
 CMkIPWZEpKKw3zxBTDoBdYmekt6zE8nsaGasMUekcd81M5ITPrGNKr2zu
 y7EZ4WZUaWHI3U3056HIGondl/00xAKyRDiqpMGtzhctJBS+01G6JCxvC
 okwDoA9HdDl3AWc+aaZaap7x43QMlPL0Q0evwu3Lz/ooHa8mOs4Y+GnJ7
 uHBgO5bO6PY2Uea/5XcIHLxKFG4ZTKCrAWXxZGwgLz2DEXdZAfeYns02s
 DizSoAkPj6YKHC5U97SWLOhZ9sbz3fb/fKV3UsKdqxamIMrNKjTUW0br6 w==;
IronPort-SDR: chgd77+ioOWcP0R3by4qghnCYh9MGdGXalzBO/aS4Z/sw4T9IS99chw812YjnCMypluvDVGGF5
 2E414jSr4p5gFTTks40UZFrWot0mJYYn9kX6MR6ftLm5T0q9jCcGddXOyGaK5s01sIUDy7JtdT
 ZPPuW0PVkxVbIxz9rXK4/Aoekpo+gHN0hf2ev5Y/ZcRmFNPPCncaGG+CxPei8TXDryoVVk1/bh
 +SWBKfu77lYOkX9foEJMTZENEkzVtUhMSbUwNXvPc5zT7HiqT2Xy+yJqrUw+dAYKXnN7mUCERE
 0e8=
X-IronPort-AV: E=Sophos;i="5.70,481,1574092800"; d="scan'208";a="238741443"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 02:54:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMs+D7r4z+A7UPe897aNRRdnP6zObIpFX4mkmAzv0Oo7or77ajsYMx05hIbNCOYQZvMdAQo2Xu0qb8MtaSyWJj3rQxadvtFO4dZnm/IEQrA+JwGsakyR5knzeWf6jlSAHDP3nconk/B+puiGIMOJr5QNn/OSv9S3TscST9zrrPeX6/r8o69hdpK2C/TF60a/8wtmbZZrNrd2J/ZxiSgtsdDa6jPtPwfGPmYUesSIF20ELPx3cNbdJiQsGNb4Z6ytpE35ETeItgl3TL/hACU/R2wQwWDK8pT2/GtMsb71zWmcbHWPFLsKdbhCbNUl+tV7ba9+6NVklnJMPOdl/6rqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//yt8fqxPfhSO4IVqabAIhsZWGpuJ6OJ/jLWAagyRWE=;
 b=Lbzp5RLNtKzD59tuYVaCAQW//rKaBko5msgwy/dvQm5wv24/goxQGjHVjelMTk9PRpujW4QHf5LdJK+Bl5jnOqw45oO51oQjk44NpvssVft2SoLq/5Wrjc3cTNazD+V83MzwMAnfGs+z4DX7W3+f41cWrRXGj8UDQms5Z80f8mnjGRX6JW04JC7HyYp/brcC6bcEpEpRWVtpzOXmlu1dRTYQk/vWU3bBD2H6bjwA1uUJuTM3Mm+RDbfOD83KTQP3oOfAOCXMQc0pmbXscACR4mnQvdSF1CsASTPQycK9iIr+hgQmW197GBMUbpT9yp9bUHX69DQl1unu6oswbIr1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//yt8fqxPfhSO4IVqabAIhsZWGpuJ6OJ/jLWAagyRWE=;
 b=GV5dhteL1+fYk3j7fQDN5vAGcUTZ0UUC5EEaZ9p9CF5vNxOUFc6MEapamiXx1H26v2gQQCqR1NZi9ajPOu/s755wKpK2+jkflweH3TGAd5de9C8Xfxk7mnQqFNPEL61OdCQzSexGOo+ApBi8l4xlHBFTZ2d5QnI/p0Nx1nken7s=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4071.namprd04.prod.outlook.com (2603:10b6:a02:af::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Mon, 24 Feb
 2020 18:54:10 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 18:54:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Rupesh Girase <rgirase@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: log additional message for controller status
Thread-Topic: [PATCH] nvme: log additional message for controller status
Thread-Index: AQHV6zBHhX7q5U5EXEa8GCX4f89e3Q==
Date: Mon, 24 Feb 2020 18:54:10 +0000
Message-ID: <BYAPR04MB5749EEB5ABFB07B6AA1E2C7F86EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <1582561924-8017-1-git-send-email-rgirase@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8f6fb19-7b65-489b-923c-08d7b95aef48
x-ms-traffictypediagnostic: BYAPR04MB4071:
x-microsoft-antispam-prvs: <BYAPR04MB40710A6EC1B058B3F2A2E44986EC0@BYAPR04MB4071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(189003)(199004)(4326008)(4744005)(71200400001)(26005)(9686003)(55016002)(33656002)(478600001)(81166006)(53546011)(81156014)(66556008)(66476007)(8936002)(2906002)(186003)(86362001)(8676002)(54906003)(76116006)(66946007)(5660300002)(52536014)(64756008)(66446008)(316002)(6506007)(7696005)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4071;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fV6269i1q7qHY7SEH/0Zjzn3wvjiWqfAWqx7Kqvdx6rRc4zfIkKrprWZ2T7Y1Hffdyi4PqUrS5r3YelV9m/N3PuciAKzbECK6u8QFNc1FG+i86h+YeT448Z+sl9pgPin9n9KnOhEmXlNfomf2ZU+nOY1pugUJ08Y1sX4xe4Rmfx6xZir6l1nUGeOExCTN56zPqhS+CA/CapHT4GsHQks3iygXCvGe63KXyOmTgmGNtqs7SOorknd3XZ5hIuU/+pn31oZT8nlHpeG5nhQ5c+nOGHHmyAi4ovxkJpU5ImpIj+pX0A/cQqaHaXXj6S4RP10i8TzwAIcOlBZU9AkQ0E5BM2uoPDBcLv3oZ56+VSc8pC1UgKar9uNt20F6sLiO0VmaOM9MOO1lGQHpT2W+LmWgfrsI60foPxPJwWbilXmRuQwTg24GHFROXlNLyE/ZjC
x-ms-exchange-antispam-messagedata: kgPmZBRVECqMmx7bb5XK+3MTFibwTF2/P7Zx7y0i77jqZNMe+lwDuqH+3L25HjevYb8DOueIgVGlIn/FHjgbXx4TvYWPVMFNuBfFcq38bB44vlHxr4Z/mkDn0jLuiVwnRdNBax284gQ05IDM9vqx1A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f6fb19-7b65-489b-923c-08d7b95aef48
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 18:54:10.7281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4WyvGZJPwrGQgjG9MYwgW4NGTA55pkAqmKsqU2pYvcB6lZVPiguDF80LCx3r5xzASdp77jQlnsRlLhHh+sgoSH/hZ/6g0TnnNCpsUxB3n2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_105417_648781_0A37AC03 
X-CRM114-Status: UNSURE (   8.49  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good, with tabs in commit log fixed at the time of applying
patch.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 2/24/20 8:34 AM, Rupesh Girase wrote:
> 	Logging the controller fatal and ready status would help to
> 	identfy if issue lies within kernel nvme subsytem or
> 	controller is unhealthy.
>
> Signed-off-by: Rupesh Girase <rgirase@redhat.com>



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
