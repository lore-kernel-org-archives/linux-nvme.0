Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F3C432C3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:26:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E24F20684
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ntXeXEe3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SyhjUt3R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hz9fcf/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E24F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=HSOlcImKtn+4aGpQOhF0PJtxFwG4K1Y4NEIBA41wzgM=; b=ntXeXEe34ST0nc
	276tZ8/HetXkhA5s6pn+2W8ye29KNKcbwrXWdSV0Nk+mW64mt9grKZeybqyaBOFL2HaccvJdRyYAb
	QLMRz8XJa8AjtLkoPjZPxGwuV+uMTj3RiabQvqwQyJzH0mNuwyZJ7cBnt1oI9UJ2FV457SkR2Rjv1
	HGF1R2nfBjDPGOiyDbZDHUuavmvEmJdu5jGvknrOBDCezxcWjk72+hwJY8tZtGqa8S/mYMXnx7KPh
	8j+DMfjAfknhSod7Cp4Tmx60xPOtUlxkylN/FjhUbfVpjKDs0lSy4TaVLhdZgvm7PF+WDjji/j38G
	Ptnz10LQFI/awR16jNcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic2ZX-0004cW-Jl; Tue, 03 Dec 2019 07:26:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic2ZU-0004c3-LZ
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 07:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575357969; x=1606893969;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BZUD80lZ9sWtys7LQueDhuhuDRQA314dXF+OQTNeCtM=;
 b=SyhjUt3RMhvPijeSiCvm838rCuoV5L6XIwwKYdjXsbE3gjrqx346VMWG
 ynLiV71SvqBZopJF7iPJQ97VthBgNidH8QlyFkNUnqqY4sbIc13g38WS0
 4I/Saq8zDJliiFZkk8BxwFPauyoOC/qLINcwRcHwoEJ0DzT59dWkBKhNk
 Mk1odev+uT6LSp8tqhNSIu82t99sirWDSKrQ1iTM2cC2RfE4KTvXlV9D8
 DjKXilUCEDHRWOb+6x1MXsBJQwOY1WOyzJQJ2StQj/phSqIOsIRqBSiik
 uIGTsOhucEdnyZ3mtsdK+U8ILM1tT+ZI0pIPZ9KY1fZiCkQePOqTU2rI4 Q==;
IronPort-SDR: uVxqGLAiVrgyqh40W2liz8f7bt/zj/qVDQu6ZDgOC+O5JVwoosr9taCqC1RT8z28YdoSGf59m1
 gV9U5xM8d/R/2hukj77CHwgbJKIo+0ZBfy3uqQkOSO/dc3pwmFkuMtIMFtJryWaoiLha4YAoDU
 7AF9qrDPVRN1CVF/6O+0aZBhckVVWsTGR5Ymej6u1AsZ4OBBX+fgxNoj2yJOiYKMCgfYGaOS+B
 HOSztFQEpTRIOm5+P024XLvPe5XZY/8tVCtVYGbwGpC2GpPvWl8bTxJkptiBbLuhEJN+8uOtvt
 +v4=
X-IronPort-AV: E=Sophos;i="5.69,272,1571673600"; d="scan'208";a="125239928"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2019 15:26:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wweq3R3+ZBZTzV7j3clwXiSGo7kofymD3Q83Osy+zVuBc2mirJcmW+ECQX9zhL+PJY1NfJ/SKBN/a9gy+2EouE0rzhpIyFgLqjyeQ1TJHvM18QEW0Qb9uFroKpyL2kX0DybuAm7gYSIEfD8hmwDein9ARnPo35VUkY+MwpHKHlWf9tcvJH5mSnJ07oWtbULGIRBJ1fSkJT7Ua0wXLHoltBwbM32jU/Rx3UDFvgq8Za64MJXR3i2VfVy0qYTJ11SaCf8oHK4zAquIg/lz3PX41UwRcwMRn3UXWUziwoQuwMwwtF79+dlDvPjOWURzvs5cLj7s6L+a1TO6T8nP3VOcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej60ZUIClQ4f+OVsUVwiTJBPTA8zN2PP+ymLhKmjKz0=;
 b=HSOpkgcJl3zSSEtvFfn2kDDgYc+ZHSyFZUUDjbw8Eua78EQDBi85+kDI2x19k/Is0KjyuxawiACBO8sQD4kJaMJ+wpUpHivzvCc75HQAJiahU7e4acdOkm1YvjHbtr0QOBIpMC3kkvLtmKFjyouhY9vQE+bAowilt4D+0KEhIcuYNC+8vXs+eimeL9u+mBb5Cvbys5RNv61tiIaXQyeIKT1D2YDDiFivUS2aL/AepwicWEwShxvW3kOCP1J0CtZYZkH6PwSBZ8Yg5WsrHWUOFs3gqw3lR0j2yhu6BCFAcGXRY3rrZYp98mbBL+2AgmbAyBY5qjQbRGj+fSWXTiASKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej60ZUIClQ4f+OVsUVwiTJBPTA8zN2PP+ymLhKmjKz0=;
 b=hz9fcf/DQTzt/rLefdQ6C9C5TIPMcOX30+KAQ799mqqTD215WRU0yoGhKhRhUIK+CFG3v4JVXrM0Lu1BpY1eHqv/VT1NJe+TYwIbaG/HzaeUgefkm5grZPNCvP1zPuivXkavGMsHds9cGNNUeUAcXVlxdeGILliu4UNFBDz2+Lw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5864.namprd04.prod.outlook.com (20.179.58.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 07:26:03 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 07:26:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "Singh, Balbir" <sblbir@amazon.com>
Subject: Re: [RFC][PATCH] nvme/core: Notify udev about capacity change
Thread-Topic: [RFC][PATCH] nvme/core: Notify udev about capacity change
Thread-Index: AQHVpkvsDr5NvlHVukSqAUHNhXzijA==
Date: Tue, 3 Dec 2019 07:26:03 +0000
Message-ID: <BYAPR04MB57497F5F024F3E5F2200835F86420@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191129002746.6622-1-sblbir@amazon.com>
 <20191129082449.GA9953@lst.de>
 <0a5fc287a4ac392b9b192402e6786e7129b9d5f2.camel@amazon.com>
 <20191203065421.GA23032@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 364783b6-3fd0-4f9b-b06a-08d777c20db6
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-microsoft-antispam-prvs: <BYAPR04MB58647B4827646E5795E1B61586420@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(3846002)(14454004)(6116002)(446003)(316002)(55016002)(86362001)(6246003)(99286004)(4744005)(478600001)(6436002)(2906002)(9686003)(25786009)(5660300002)(110136005)(54906003)(33656002)(7736002)(305945005)(74316002)(8676002)(81156014)(66066001)(8936002)(81166006)(2501003)(229853002)(4326008)(71200400001)(66446008)(64756008)(66556008)(66476007)(256004)(71190400001)(66946007)(102836004)(76116006)(53546011)(6506007)(186003)(26005)(52536014)(76176011)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5864;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IM+aJQ1bdTiBt1o05Eosz70keKcdI0r4AH2PUgUoO23EGDfqMSDQ7p8COIfVxo2ty21e4fSqeuloa/WLEagmivGdQuojx/XlJJoz+5TLIyIRlrIKOntuvOQbd2Q8essGdsIf3MYNIUOIbWep/ZlSiQWXbR00KrarnMk+I3X1EDe22p+eLbHt6VBoq9Mz/t8Mk8hHmjQ1T0Pl8LO57ldjBF/vLZmOTINLJfOayTaPnNuK+uER5yx14zlWibOKHlePgq4f/6i4GtoiX2vwPspq+2ZM0UhKyFMf1An9hdufpeM0x85cbWCZBIv5MZ91FMolzaO+6PVd/mEvCjKJDqPfwaaOsdfPSl1QrzhQsdJ2rLDgYFOXCzLxiCOvyoyOuSLybtN2LsSPutghFmeSLauMz8oX8owSbQwy+zBP698F4DMh5az1MbZjRxoqbs4vITrc
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364783b6-3fd0-4f9b-b06a-08d777c20db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 07:26:03.2212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KORDTCcP9fQQdSR+KK3IC9lo5RwxrW40msXQ0oWXumVtrQL4wpDSPsDLQn4EwS0EGybj1HxfrUCQJxB88mteI0GsEXq7lLb6UxVp7z7FE7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_232608_784426_6F8DA472 
X-CRM114-Status: UNSURE (   7.56  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "Sangaraju,
 Someswarudu" <ssomesh@amazon.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/02/2019 10:54 PM, hch@lst.de wrote:
> I pretty much hate the set_capacity name to start with, so what about
> a more descriptive name for new the helper?  blk_set_capacity?

Do we also need a blk_mq_ops or appropriate block layer callback
capacity change function, so that file systems can register
a callback function to take an appropriate action, e.g.
rebuilding the metadata with new size ?

If this make sense I'll be happy to take a look.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
