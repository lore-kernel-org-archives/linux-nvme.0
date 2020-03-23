Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A804C4332E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 19:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0D120409
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K2xLJgh1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pS8Itt0E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TO6sYcWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0D120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=yoe96bIFBVhrHRGD9AcTr12h6dyOCS5NMvI2xCVrkNM=; b=K2xLJgh1MUqnaq
	iavuOCAD5PBC5RFFEt9OHQy44DJDzaG+d7Thr+ue+GmGW8c67qsRS4fK31fdvbqsD2fmt9gWFrPda
	mcRtEbwnKKS/L1Lk9JYbH3WCaTUrhBruH5njLVGcuJWNZrqPk/vZx1IcKXtIIpPfrtHApgVB8cnRS
	HqBLhN28VOjSwn4heN3eMoLjEdlw58HaJb3fHnYaFlO/v9zQ0FfAWssxRkIaI/v1AyG2RW3S2WCxI
	agyzf2pEFDYAzhfJGPXVjJtomWiYgq3zVEcQrbxAw57j3b8QDlb+UPJU/eHPw9yJ2qvrifjzurUF6
	tU3PxsX3nUy2lApyZmKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGSWi-0000h6-UI; Mon, 23 Mar 2020 19:14:20 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGSWg-0000gL-EU
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 19:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584990905; x=1616526905;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2374ZeTJwRD4zIDZZJvS2pN2ON9asN8N9VHBccexrso=;
 b=pS8Itt0EsDtJZAYnI5NJ8obppTWnZKlj36qt4OAOLSvsMOy4LlE3atSf
 TzTJbC8ld/m+a3glTMstWOu+8FU5iaRlDz9gITq7mE7xHSRbm3QZGAjbI
 4c0dYs881Ae80KFIVMsTKmLYO1PkjwB6HWPz2X+XGB5Pd1vR8NIx/pcCm
 hjOJBw3L5G82TaaKYnqi1ya+Fb0wFWJuw+hoHzU5lLamjGZfnrMho/pD0
 iCm/JaesQrqgsqsC/2Hpgh4kdGxYiPAdMN2b8XUuiR5760ILaciOc9Sar
 vPdp7suZcqYPbt+UnIjQ8143IqkJC6P2oUV0Wd3hdPztXO1eg8u7hQNOO A==;
IronPort-SDR: TEhQHqIZeFXYH9hKPKgSfLwvQn3oTGuY5Kfn70gkN+oX31uYnim4pXg/EUUGQkCYXesYF9fUD1
 9wQLwyqd1cDfEFzedzuJQz2hWL/HQ7z5gSGlJWVrkoE78WsGSjapd7kDtXc5flp85MDcedfp/W
 +QXJulRMsE2Az0A5ff1+ZZU+xk2scP+iyqJp7NlYUOTYHRmh4zP3kwh3xgu1LtEQo1IY2FLTD7
 2KoSL1cV4FTtIUSU3GV59EDF79Qk+3NmnextFHEleTeTGnRExsgZFjl9W6B4sxaHosPf9D5L9H
 r38=
X-IronPort-AV: E=Sophos;i="5.72,297,1580745600"; d="scan'208";a="235477451"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 03:15:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKHwVYL2jgsms1ofifxXqqK6XZSkrDHuaYjDPlxZodCu4zqe2b/IIAbU36LpVFFjqQcFgh2WWehsHU3+UfSMLo7P1LQOC3T2QtjoYKH/W0W5qQJrvotSK9hb73qqk93YCPJXIx6WMV5jvB5Im+iIYCQN2JpiOcWv3leAVWWzUO17TWtj8Gk2w5IQ+vTjm3FAP3knlDAxL/1jsTSXLsfA/zNJk8ltWioQW1Vtat7QQH3rM1rs2/DCZEN+UXQ3+3D9V5LFhokB83eMJyBMg9lLDyRWb9xdNAUn8zetgKflmDey6bWd6KOV2m2FGjP8yX9MLxbfTzwUeATP6KOu5f9ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2374ZeTJwRD4zIDZZJvS2pN2ON9asN8N9VHBccexrso=;
 b=YDjncldI3/8LSgF47+pl2dbW9kyiWF0Vnm1O9jDRC17yi6WyPuQM4o/9pXaKzWsqoemsZUxkuPgRTjHZMhFtZRAjr5u1BhATEfj7IKYQdzVwkUhK8zeytdW0Bg1YTzM3VMhaaF9sdPam3hAbfD3cIgslMf6BI0FFUhq71BZUrYeYO7aLDB76gHU2az9AoEgiNHfdlaYtn7lmv0XQmDwTq+FNOdnrgoWi8Yb/vbKNge3NZiquWVvztZ9f3IXN71wllKLHZbIctIL/e7wlZeDjtlZ6A84XLQ4F8lpU1mIhg8xmy6YgbfrVxod8LJR6zK2sYWHxsZk67REP5vxzkQQ86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2374ZeTJwRD4zIDZZJvS2pN2ON9asN8N9VHBccexrso=;
 b=TO6sYcWGo4oexR9QMpCnrpN1DjXZdYy5icVN4UfsHfeIygKf+xUcZgk2CG6+jrk/H8bzx+RH5pxcBry4NTk3pma47qu2vc1HOZJV2gfauCSuUkceV0lSTWZp9ZLLRpAl0IQ+F4UVAaaO8EZ+se4cQ/cGrGgz2GK6yUolJ20Mxps=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5143.namprd04.prod.outlook.com (2603:10b6:a03:46::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 19:14:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 19:14:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Tokunori Ikegami <ikegami.t@gmail.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
Thread-Topic: [PATCH] block, nvme: Increase max segments parameter setting
 value
Thread-Index: AQHWAUA5EvS/8ZhR70KjGhHcFopwzQ==
Date: Mon, 23 Mar 2020 19:14:14 +0000
Message-ID: <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8b38743-349d-4901-bde5-08d7cf5e601c
x-ms-traffictypediagnostic: BYAPR04MB5143:
x-microsoft-antispam-prvs: <BYAPR04MB51434D911781408B40E6511886F00@BYAPR04MB5143.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(8936002)(26005)(86362001)(4744005)(33656002)(110136005)(9686003)(66476007)(64756008)(66556008)(66446008)(478600001)(55016002)(66946007)(316002)(76116006)(81156014)(7696005)(186003)(6506007)(53546011)(52536014)(4326008)(81166006)(5660300002)(2906002)(71200400001)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5143;
 H:BYAPR04MB4965.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JX8vkiwZUCPETUchkvwdDciF88PrJdVWsGAsAXNTvHMCd2WTmsc8TKlVuMdePhVzO7ckxKA1GlS2pJ5G/kgXb0eaO2i3ZZ+X+FmaBG4PGdM2YH+9g0jLZlKEh9zqkUz1ElG/aEHi5JSggX5SY5uiZ3eX3ai111WQgTS+2N23hB1JERAffFWdPox8MKwEhBg/eVbPobHamhaJMCWjp9pcI7ywlZRRpKtiqJibJglKGt9r6Y/1uYuz0NO4k/C1g1YsTG7kpy4rdTNFOMZEp3UOYTIvBJKLAq87PDfjrQo0USQMPxmj33aiGxgjrXdedLSRkQhZgqyqwIMVtouGKn2fEyefBx5RUUvXVIrscNAOrwKRlAHw1jztgTIcVcwHoSfpdbBQd64zaRbtfsfOSVGHEwrweyKyCq0GV6S6FVrLzIc486ZBAgJVj8ivCYKHzAF
x-ms-exchange-antispam-messagedata: SQDTvR+mF45Ys417sXHZYWgMopd4JG+a4ze9ZKrxtY7XKVgvIO9YfUUmfpYPpoENQO1Smj5KUbHZqTPAz/Yts4Ctf8lwJ6VWePj78QurXQeRkrVJmEH/fpbhzNAXdMRJPEI8uOOJ4Q5pBXuw5LTUVg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b38743-349d-4901-bde5-08d7cf5e601c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 19:14:14.1636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrt+OgYb4uOc9gC9IdrLH++aPouK2Sm7lt+Z4FCiJMYSusn0SOorN5bWzD98zxQy/q6XKPTS+og6gERAUXsg//XnW79UvsAtlBWj6juPXvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_121418_577979_191C8C8B 
X-CRM114-Status: UNSURE (   8.73  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/23/2020 11:24 AM, Tokunori Ikegami wrote:
> Currently data length can be specified as UINT_MAX but failed.
> This is caused by the max segments parameter limit set as USHRT_MAX.
> To resolve this issue change to increase the value limit range.
>
> Signed-off-by: Tokunori Ikegami<ikegami.t@gmail.com>
> Cc:linux-block@vger.kernel.org
> Cc:linux-nvme@lists.infradead.org

The change looks okay, but why do we need such a large data length ?

Do you have a use-case or performance numbers ?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
