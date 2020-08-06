Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A65C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 01:10:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA9B2173E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 01:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NE2x3HuE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GijMFGLC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U3D87b87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA9B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=2jP+lGKzkyWauqQavvTOp0VdK3RjotVC0w0af4iiUGU=; b=NE2x3HuEoybi6bU+TZdKXlfbV
	ody2SYJDHd+R0csEukYV7u0XheqowoAWfr+LhdUk+PL0sCLr7kvBHGR+CiqszdB/XEbrsLTW74Z72
	IY1MaFrp++JhGN1yvNdu84M1clxt5lZaTJHcsKlWgrjvR1DOCLCh/5NBD9I/JP2EbrZqExQFwIoqx
	bMOVoBgpHJPqwCKuoLN72QUKmU/QP4ZI+60kNyeN7f1nb8LtmGtM2T/T3KrRJBdLT548vhN7fXX+Y
	wDSgWflVtSCdWG2ha8lrl+OjRZ4Qt98u/VbvY6s9c6B4SIHhdiwvX94czm+uwkPh+hqp8fc10J2gY
	dntesSaIA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3UQa-0002bz-CK; Thu, 06 Aug 2020 01:10:40 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3UQX-0002bV-RF
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 01:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596676237; x=1628212237;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=lFmTv21SZyQpcx14k2u6P9ep//LKExgg/ttFCFXa2oA=;
 b=GijMFGLCYIMkAGwvo3BZItKAnpIa8pcmgt/dBdWpwpUqOQcSwcsqrT/4
 QJ9cytOj4lBOcP/NRQjB/70dchGrui2G1PXbsV6mQvFfYzBz9Iobbv7o6
 xZBYUnl3Fz20Mp+HOI8KaZv9NPqc2ZC7GLx4GkaXWWXP2tbgtte9sNBwj
 Pe6ZzXUS9U7cR49BlirNXLO4PYUz2fG0kyFFxgkjhUDDfj4uHXlXhL8jr
 fEXgo5qsHh6IjZhFlm/Ba9vvWpVAE0VSgAZyo/fJmnsHZarV6Gks7NizU
 z1BOi3+zUttVv0egztoqNFggTVmg/JjyvIkSANX5BdH8XJOqq4XeDNxak w==;
IronPort-SDR: OSEZDeusGCPUDy67Cy36+Fqh40U2KTz1uW5TnO5raZeoTFetWs9gHxm0l7QKsoMtU/XuoRPAgb
 gL5/wgI10D5QBIM2fnMl0zeWOiBh4urVEXb4DqyCCoS0E7ZRq3GVGNTJp6wjXPgn0nPryymwY3
 qjtlofUchobqUz1EihyHREXJ/WetTKPqnggNru4vI6JcbqyUUM9uWZjUImHU/kEZ9/JiOn7MNL
 vAk0mAYT3uAvzDc0sStyZOmfpKS68hNV9Gik9CJsRbxX52XvhmgDuOYo0OCq0O4ZHBGFWXvprP
 3Lk=
X-IronPort-AV: E=Sophos;i="5.75,440,1589212800"; d="scan'208";a="144254643"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2020 09:10:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il1bmmzyghhfmXOuQnS7nBzHipmXCurCni2keYGiUrhvxCLzp9Hvw/XTsv3BlDenoTCA1xsSjzWSVlr/z7gSxIFo7Okh+lLO15DkyvyTVciE08hA69IYMigOonCxsbCaptwumVtzfWAiektHWzWIsrBXclOHuCPcI1GplN3Pjc/UXUrwQsu08T+qRvnFgfXkz7NotbQJdUHnscdgL8YOR4MdMNKaDWUJH8d/LO2HNI2CsmxM7hMITRlHT2FY5ARBAIrYKbZS1M55evgte0dmyXaVIqmBCf1oHcd2rHKP2NleN0MGlZaRZ+CgxveShHIdXsELwijMwZGMBy9GDORvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFmTv21SZyQpcx14k2u6P9ep//LKExgg/ttFCFXa2oA=;
 b=Bj9BF+0j4VGka+b492alqKv4uqe0Ur2bAzt+14QrTcO369M76zVC1mc4USWYBJWSM43vjMyl3+Bcgsi8uyghZQpbkwF7gH86X/Ij4R5+9YoD4SdncHNqR+NCN+aTxOYUXOlnsRrScGQOu6hatbrInC1fDPDoYmNw/5wv+fpBDFdtGwgdBqK3evqxS4ueaQxo/AkI73oweKLYfH0fH5OX4Mv68ikZrZHZ2aoD+VyVVxzwvCcm1C1dUgQuiwvGoKosvCIn5XoBoOrKXCvySzCeTixTQvyuGqRm44bETHMWRpWjrBpU+4wHbubqzh52hdk/Mnf3k+qIV2DJwPNhdACTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFmTv21SZyQpcx14k2u6P9ep//LKExgg/ttFCFXa2oA=;
 b=U3D87b877ZvJ+QHRsdibrzP/6UOAp8Hii3WqqYeycKZWHpG3dRLz0nroygKx4NOJluAGxBrXY5odXG+BBLF3KEdx2tuSO6H0OauMO2iP8uBPLMOwpt5g0LJSywed5wOCnHbzhq2xz9MQU7IGMMJxqsDeHUG7aurm8lXacXFNNu4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5686.namprd04.prod.outlook.com (2603:10b6:a03:103::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Thu, 6 Aug
 2020 01:10:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.023; Thu, 6 Aug 2020
 01:10:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa4WuB/SmK4DZYEq5V/CCHY245Q==
Date: Thu, 6 Aug 2020 01:10:33 +0000
Message-ID: <BYAPR04MB4965F41CEFC7DAE474CD3D1586480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
 <4c0eab62-d29a-f1d9-7856-78af8d6fcf48@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75ad9c4d-c18a-4d66-20ff-08d839a584e0
x-ms-traffictypediagnostic: BYAPR04MB5686:
x-microsoft-antispam-prvs: <BYAPR04MB56861E2A5886BD6C0F004F8C86480@BYAPR04MB5686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5gJbBuTAHejlTf7sZJE6TkXHHbzUtC+YHNjGkUc4h43Ie2sgiuG5zPYm6WnY8aTzBUqhEoWdt2dFC2ojOPZ6sqfJWIuQjpze3bEqnknYkS3acfWJEAyFO3SIAh8kj5Vt8RyRdmvqrAC7/LtTV4ZIgkNMKUdUq6c1yvlUWvHDAxwlEahGq0LEEGYTC6dkH6DDNlYlLqWtuoL3aUM5SOsu8n5mMVZBg/V7qhmFXZXSK5XKDYIkOCIMLW2JXHKsdBVncat08xFOnIDpurEl9w4JOFEMg6bSmHMZ7Vv7rxPY2vhptFpR0UXbk9cGNGnU42+TNUqy4p1I0/YHkWPDR84dgw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(8676002)(8936002)(66476007)(66556008)(76116006)(66946007)(2906002)(558084003)(64756008)(66446008)(26005)(186003)(86362001)(478600001)(55016002)(9686003)(4326008)(7696005)(316002)(33656002)(52536014)(5660300002)(71200400001)(110136005)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: o0wveLGiH+bKIHlN6dTRWaRgOhxZdeKYhXBkSIPvIFsvnjTeT4yohJDfu/Efj4LCQtiqhZZadLl8KEIIPy21/6bHQipG8feKA4cF+2ET6+6sdAbj8NKYr09i+L5999GntO99oo7nsPFvcswseUyReupaOzUZvPM33MKV6v+7+1aNowQHmmwiHdcP0MMn+7d0ygOPHZ1RthtT6I9rVNwCYCJCj078taxHHnvjBKXWNVbAXGnmUJ/HPMz4VMeM3RRglkrC7NAtU6CAWsQvLPlBQ89JHaaaRCh2oYVQ0SeLDllKd39eg+nJ5dXJe4VY76JXWRmWDezT6o+yx5QjEn4fTPxX9I+z6Ose522QHbsRLXT5c0qIggQX6Xbt5zid1jS9WuHvslx95ESsxdEwEgrqacwv/vzKObHmJg7+cRcNQKQxANn9Y1XYvCTp41RhM2256QlPHBYBnyqseuOaZ0VHerAPwpt5mFcPM+ud1hx3auLoGua6M3Bx/92lrRA7AX0mhlObkJB6GgjR3w1BNBmMZNQX+r5Ig8oEvdp2Cv+uxP7oomliLY7zMp3yINfmEdQR5C8MqZ81XmBrJEMJspMLTjfWwoWCZ/lbjYVbrGYQ7LND4XYB4oZ0Hbs3fay9rXQ9ZsheFMjiIXvltayzyejTIg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ad9c4d-c18a-4d66-20ff-08d839a584e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 01:10:33.3170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwixL7YvFLWSEEXdYNX4bgaGWgzLdOdtonVqTV69eXrciOXOAgr1unKkkcmavmAPr6M7fvrLW7829bD4opXgQgmC+UgMsMaDbQD+iU20pR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5686
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_211038_187804_87BDCAAD 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/5/20 18:09, Sagi Grimberg wrote:
> 
>> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
>> following oops :-
> 
> Why LKML and not linux-nvme?
> 

My bad (+linux-nvme).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
