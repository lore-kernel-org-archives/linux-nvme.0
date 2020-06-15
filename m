Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755FCC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:49:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD04206DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qpfQAwkb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nunAefrn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y8UQx/sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD04206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oTV6Siw7+jA7uZpdZkUWH9HET8dtakskCgK2Hm5zJOY=; b=qpfQAwkbZIMfG3
	yvf3p6QmlPpB//SaEqHlLZ4z11JSsT+lamq2G43LHxD0KdXEbd6TjF9x3KtdqADC9IJMXksf0GfBQ
	RiobgYdewJICSTfk4Yx0bLxMxjcC5OZn7MwbRCqvDQmm1UEl8jNbkExjyRFQK6kq4R2bC2Hj//dzT
	EViYmrjhNufab2j4WetPfqD4O68baOoPiToiFAtgfFBumwF92+gdnIYN65fsDWPmgYEzjgucgDiGo
	9udKdOgjimeUJlGxIV0PDmyRNZhSZxF7hGf50FNHtduDrQf5Nw/oO/fizKIQnhJFWluT+wIYKwU7b
	VWVw4nQWRIrBLVZX8jVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkyql-0004np-9o; Mon, 15 Jun 2020 23:49:11 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkyqi-0004nO-IJ
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 23:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592264949; x=1623800949;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=h3OvlzAEbqP2Z3xW7d+nuXCJrUrENp1dkDE/7c5bUwg=;
 b=nunAefrnuX1872gO3Uzs81+MhNfyoU4piChJaE17zIUYGDhYp2JA+uos
 NgmXbsKlsvnOo2bj6yZwc2VUH4UAYKxX3k0mwUevT/h1/SY5aO0zfafXH
 UJlv96XRNnvc4kwRp2bpmnZV5F3G6Ney3weOhn6zz/DD92Ct3pgnE5ZJp
 ppdviT4LZYryVS4Qa2X5fRTjaxompiL5UQcOkZ6AUnSD1NXosONEJYNjF
 R+bLubFAzVUzvetc1z+sixrNo+Ivde0t3C8zB5ZnCMqEn7mw1fIJ662L3
 nAdmgdydY29YyGTuJbxExZaAa0b2IaT9Szzzlm+UrD8MHZ1q4kFLx+Ssn g==;
IronPort-SDR: uIqmYyih6jxtbywhiVcspjsyCJRyUgZFukjO1tO8UPpS9AaLH/5f0KLqcEcPAi3w19cjPkXrbe
 k2Z1zkiYEE9Dn+V5iGDNP5CZpsqp90gcpce4N0SYsj8QbPm8dGU6y/UdAgkj1lQDgrjAdSyR4+
 tYmXswEXuBGYOEO3+ICsA/UDlkhC2dYT23/T3Kfg7XGE1e5FTisz3O6zzdmmkrIVQ12BrJYArS
 1Xrn69ST0Lp5NVxUKL4g5b8FPXve7VT/yNGhG6SRC/Ln8PHXNf5s2bWcMxr5IVLqxBwSFP/RK5
 Zjg=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; d="scan'208";a="144395100"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:49:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIHzM94xb7VoR3S9gikfeFY+x+A4ZTSTJz4rCmjtlAhlXGgp/nOhjKZ3xrbiRTV+MSwwl9Qv35PDSt9RLwYi+2dPc7dLyrXZZRSGaKSV9RbtyBANtGT07k7ZlZHwifFMBrL6gn5G+AJ075RTC9fHLwBk7SvMsyZDsSMAcJcn4MpgZwYybXqJ8ZENWZtS3iSAMGrxR3eRAddjvlE3EWVdTd2EkGi+8hfVtJHQFhqfS5DEmGfP4vg+w7qKL3upaUHRcaJRKmr7QzvbzqFxNGLhwhgeyme+2gHoJwhZuD3g3V3LRpZ4tQcImTxEBvw1Y1yMa5y3e9S/G1fOAXqFHiuyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3OvlzAEbqP2Z3xW7d+nuXCJrUrENp1dkDE/7c5bUwg=;
 b=X3xgs600XsCfpof8lu1vf/SNY93+ih7KSf0rXqpMi2R4AEBybGNj94yof4djMt3D1IefoYLCxKXL1e1jOFiPQuMmD2BeRA0KCtyRKEZ2R0mZXNHrPrVy9B6JnLfvw334Nb/4S5N8P/m62mbzXYimhPWXD+qr/XGpKI8SNvVsPFTwhBo3WR75omR3qedkBx/HR2aQNrGxVYT4oDVAla1vaQhetHl12csleUlTe2hATfyQDomtgW1YdwLrStIpvjinDBwFx/NS1SYhHTaA2rzpiVEn1VOUymYQ3vx2N9EvG1OdtfZqMtAd7+ShngtVntoXbDuSmD6zxoO0bEVqqFo8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3OvlzAEbqP2Z3xW7d+nuXCJrUrENp1dkDE/7c5bUwg=;
 b=Y8UQx/sHhxAtelqkOalTYZqY1Dm8UhOqI7+VwNPYKL87VvsMnSzh91nRGPvEvv9dINucrAwzFSTMK/W0Hv/4KS131oPaR0gRsOzE9kaBT7+njxhUcy/VwuKNYqbYyc32lEx1Wb8IO5b4ifQWadEl5eWmVkDwyXjwbuBI/r0HQqs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5334.namprd04.prod.outlook.com (2603:10b6:a03:c8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 23:49:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 23:49:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <Keith.Busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/5] block: add capacity field to zone descriptors
Thread-Topic: [PATCH 1/5] block: add capacity field to zone descriptors
Thread-Index: AQHWQ22j2ywuL6LihkGfGiVomzsODA==
Date: Mon, 15 Jun 2020 23:49:06 +0000
Message-ID: <BYAPR04MB4965F20FA755283EB9EFBCE1869C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-2-keith.busch@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f6cfbdf-d2af-45bd-3321-08d81186b12a
x-ms-traffictypediagnostic: BYAPR04MB5334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB53348CE558635353A8193283869C0@BYAPR04MB5334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrxAZqmtmroH7kqnt4Bxh8papuIc33Zux2jZKQONIEpTyUkaB4Y5H0BJgKneeK+1ZsyfuijO/PzH1KyOEKqT+R3S8Y+UYklEu9099uq8fabEZeFpwBqHgTqsGXfUhSU0A5ZQnoL3poWU4PCZRNM3sikPhvS5TNqQN9uGBeg8STUFy5I8NntxPsLu+GRLzT9AYJlMUiX9LnLu1UwoLcEw9k+V253+I5eD4okOToolAQ2svEfNCfCmKjeuNUSTA/idwvzlv4p+HqPcWYeNTKtufniLPabHaMHhhmJoCzDsVZar1QLwxKAUIQ2+HaP/A4ULqHgL8FhlriUcluKh0HnfMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(110136005)(316002)(33656002)(8676002)(186003)(4326008)(6506007)(5660300002)(53546011)(66574015)(55016002)(26005)(76116006)(52536014)(9686003)(54906003)(478600001)(7696005)(66476007)(66946007)(64756008)(8936002)(86362001)(4744005)(66556008)(66446008)(71200400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: d5rbt+Zt/6pfJRnIokxlPi1xNGRvtcPWZXuzo3G+tfUBF2ezh+7SC/X0e0p8x66u9a39+3kxZjPgqFGH3fO77Bp0KIE6yRX2LQ9KKpkB9RLGduXftG/0oRq/OVjWFO6P3AtDJpvKU3hPT/MC6OYM6vaKQPaHhTM/tJFSMR5A+hFszFu0qlKeLat685SZ7AZ9lEjSQiU19G8iH0Klvp8I7QaYY5s+bEfghmJfvXM7ntXScLZeYbwqo8nziWXlArhI6Dzpdg0pat3etxotbJl/8c1RAr7Brdj1ZcF2+AX7x6fAj9FdCBTPaYOrBNoRSavmogAIZuu9et+1y0+8oWLPv5Iauolx8TYWcUO4PKGyrL9axywcoAgSrFUkUc+hC32NU/7EVkppU34hoWRpvXCYLJsvKQyNPmS322+Xqb15riAvC/x9nSSGHubTX0L3Yv9HWkcKCQNJuaq0xDr0bRfMNQ1KfLaPbNMkOZdAtWe2MOY=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6cfbdf-d2af-45bd-3321-08d81186b12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 23:49:06.6858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InwjEMfbVWalhZzFqv6fqUuT2WISG+95ksR3lkIhknRb240qnB0+dXq/dpYISo1aM7PyQG8LL7QTvW+HlNflnC8WuHb5oSDqNPOvFjKolrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_164908_616837_24B999CF 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/15/20 4:35 PM, Keith Busch wrote:
> From: Matias Bj=F8rling<matias.bjorling@wdc.com>
> =

> In the zoned storage model, the sectors within a zone are typically all
> writeable. With the introduction of the Zoned Namespace (ZNS) Command
> Set in the NVM Express organization, the model was extended to have a
> specific writeable capacity.
> =

> Extend the zone descriptor data structure with a zone capacity field to
> indicate to the user how many sectors in a zone are writeable.
> =

> Introduce backward compatibility in the zone report ioctl by extending
> the zone report header data structure with a flags field to indicate if
> the capacity field is available.
> =

> Signed-off-by: Matias Bj=F8rling<matias.bjorling@wdc.com>

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
