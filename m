Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309BBC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:55:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CC920E65
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nk9aW3E3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mA0/kueZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ysiR6kGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CC920E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gbIB5fTtjp/AOq9asjeXx/TyS75VVxlixL8nVj+xZ3w=; b=Nk9aW3E3Soh6WjvJLWsUTAEOu
	KaDhWpwN5xdHcM9IzOwPvIH/BQSEHpAsPbeo9r4ons2gbH9EVroN7Fw+T9dxF6PuzY99abi4WpOPW
	CGG5VLU8Jupqp3mLiVeLmKJgX9pnVXM7jm2n1xbuTM04t4Sl/2KJvqmf443tG7srtmRoO9BA9Zloj
	Ac3d2uBYltOUT1dT+ByWou9o95x4Gpd7GQm+F2EAUsRXiWnVK/2drTgOm5uvOwjJhS+y5wtgimIBX
	I/T2CHpi5T0CUA1fA7OEKED8LsqVw8nfwOuFuUHjxBaMx265D29aPfsGvNjvatfdYPjRZeXXjLJQG
	tj7uVsUWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwni-0000Fg-Hf; Tue, 06 Oct 2020 23:55:22 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwng-0000FF-6c
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602028520; x=1633564520;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Rpp3lVhDfwFLQIi65G5h2Y0pvnAZDCHoniqvK8NkzA4=;
 b=mA0/kueZ3gDxICQC2fq2aefXyWiyIUXK0ni2bgwvV5EjxxV8EUwdQmXL
 rogbtGxJm0G9BRFRhQxz0VOyz5gEaUL+JgNwNBdRCLdVhhKeBFrIX2/a2
 SKpJxBr2xbugEsfqz9mI3ZJurz75dcUfY19W8vrIK2hJdGrTAM6q34SoU
 ceUAESwsMj89kHThbwmw2onvS4bK+PjM9EpvUIULybNOchjp/XcRe80Ch
 s5RMwJbEy9qDJs4weFRkHKLkaS2XZ4fYQzJrAR0xjPmsYQq0dWEP+Fo3D
 5gGHx7nNXoZSaEDcwZ9nQ7LtHPViojLqo/O4BXUSoukqcCDU45x9IaWzd Q==;
IronPort-SDR: UtUNBcDvoX/Zpg5m4HuyXQ/cYrs/kLE5WswRjgYNNFkrT8xgMTz30Pa+Df5q7BgKehAiDd+j51
 EJe/o4Gac+6hrvtr/VPpvHsvukkRDdJ98i+VhEBa8pTMI48TzXSaHgPyte/NJRYcT8r5u4Y1Xp
 f7RnaPWYakfdOAU9F+WDrcmcmBTJE7rKoODHC5/6PRELi2molg6RZSB9SeQQLyWPkEYBiCDnaR
 Rm/vd9diOS0BtPoUL4vOYqmLoLJuYRPGto4yA4w9KJ7+y8wy4q0XSs8MawLPcaPWnjjGd4mfwX
 pKs=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="150427381"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:55:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUdpU2CQzPsbwHuhH153vvIJGmohjqcH7ijSxWJ4hW6SQZCL2xkj0ex28p/PZrEDS/727p3CtZ4HbHTrwAVmHeF/L5LQ1weCvdSq2W5pAZY5JJcwDNr8KBfXOZ/4evw8c4bIV9EWuNX0sNj/67dn1ckZxSnRqU5CPZgaKA/CEzT6gJ6Ld9AROkLmkQkJg3PNqfLZhR/EIqdptHlfeLMTqUuEQmrRe7f7HW2t3CS0f5hEuUtXHwBhXXJ69WnVESq4xblCPkxHRVUSVe0eqjmn92j8oNWeLO0YsEo+DNrSIz5jc4RyVaIEkL65AaN+HMWfzQlRHnyRcIWftY+uQO4CBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpp3lVhDfwFLQIi65G5h2Y0pvnAZDCHoniqvK8NkzA4=;
 b=TLVmnNpwvWKnWbF1OolcEtT8Y1yfGPoA6oBs7hnEPmVkNpxD61hWMkbBmssyT17okLLA/qcs3O/b0+azOMObt2YZbpev4zYTq5lDBT3U+cqNwu6uI2wme8lo0IHSVV5qJyRhfa7fWQ3pSxFWcFwZ0/MDzB6cgeKoPjBaa69waIuOj3DZsyC/LBFObsVLa1xQHZna0xw10A0XTCITor+hpNZ82syscAVk70BeaqBlGlfxjSSOtCgmPMK1vhLqHHh6nGu5fCeAVhbLRntfBqKWbo14N6Xn2X6sU9mPNcTVUOESSAO1C1n8Gkcbac0Aai3x7g33MWZ+qNRx5bRPbb0/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpp3lVhDfwFLQIi65G5h2Y0pvnAZDCHoniqvK8NkzA4=;
 b=ysiR6kGmIcRQjYboDw3te1Ay4lZ8aCNj+yvh8okrUVHbIc4Y5I5yY/AK2ayVzgfrfZeKYBHBPoeitA/X4yQ0cGOpVq4KeVauF4zyv+zxkYfQGBL5Lb9ia5I3g/+id47Pid+WeBtsAjNdOPa4hsSM/a2lV3w4cI0pQUjd0iO7SV4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6898.namprd04.prod.outlook.com (2603:10b6:a03:22a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Tue, 6 Oct
 2020 23:55:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 23:55:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
Thread-Topic: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
Thread-Index: AQHWl1ssGO8rVJrUsk6VJGLZV4glGg==
Date: Tue, 6 Oct 2020 23:55:17 +0000
Message-ID: <BYAPR04MB49657A481271ADC1F576377B860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-5-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b718a2b5-51f5-4217-c671-08d86a5346f7
x-ms-traffictypediagnostic: BY5PR04MB6898:
x-microsoft-antispam-prvs: <BY5PR04MB689855309CEC85B624AC58CE860D0@BY5PR04MB6898.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTO+khJNyED99Dl+cHEGGakHlrxssKSFyWGbZbmXNhc5rtLWk1WEglZWH+wC8VzQMmdC/Xrv0fl0ViABxAVXU2HbBPCNtmMOpf4iGNEaWm1UuEn5VHWWmx925ywOhso7cUSDJFdko+wU1II0lbdWr6Nf68uQUHB46NG/G1kb1we9xuz3m5voEQ61dHHsSkU247O4bc1K0aVojHrB0cVlr3VtvOivUbNGuT9s+zOK7UDK+2bybmsiNKZs8vn76/ZzPaFSk8mbUrLTXJQiO8WDrC97p2Putn0ZZoYVQJXI2BEBtxrQv9OxuJpXCel/DPK2pTgKc4InbnOuDEt79ZjYTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(53546011)(86362001)(71200400001)(5660300002)(498600001)(33656002)(7696005)(55016002)(8936002)(8676002)(9686003)(2906002)(76116006)(66446008)(66556008)(110136005)(54906003)(66946007)(186003)(4326008)(52536014)(4744005)(26005)(6506007)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PbYw1EHt7DilMMiArzndgpUmNBskt8FJ5f4P6mp70IVRT2uT8+F9RHGP0IO6Ab17H9jo99d0bLjf31t6QnVEbSHjFcO5hokIt1hyNOM2cUMHEfDGqZZA9V7a+1SJqB96bEjy1yoBevKxYQAlpdF7ri4pbmCXzpKeGVjQo3iToxHJ92Y130GR7PpJeN2oWTEXkfjsH6VI/HLfPfU89VT/wNA5UftJAX9ejCLvhmjujFkHUKzKDxvWqD8r+Uy7YNWkJ7ysWMyJHvk5S6z7HYwnMzaO1bD7Ev3bMRXHPuYfT9LoI/XfGgphtWaveaGJV99HlAYrLBkm3tABIPpo6CZFDefWPa/I1bzegeQk14Lj+jM/dq4SAYu6ljLmsf+m01n0UU44rZita2/Ll422qQ9qVx89E9OM41FEBGV5bCApO2RaTE2XSGRgo1/VM9vy9jBGlWh9/s90KeL6RqD081iiZdbCkMWs1XyVEVkIerJYMvVbB3thhb+/yWrivlpWgil8gD9ggOWdzOFg0X8rHwe4eVqovzsF5a6vAI1M3gonewwHe6e1EjQ2Ln6WboMvcYJdAOstUcU4HJMK8Q6OExKa6J+4aztQMex04TydTZKEz6BrKlq6XCZmr6xdDFrY2TPm6lEbj4mApwXQ2jLNsEE8tA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b718a2b5-51f5-4217-c671-08d86a5346f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 23:55:17.7238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DztorwYjmsHmM7c5HvF3ktwDjJFO91QCYvnKM1PmrW2MhIPN+QQXqXnrvpS+GzNrwz/VHfGpP6q3GJEM+WXRxiC5tRI/LmhLww72xEEgy98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6898
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_195520_358460_910E39D8 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/30/20 11:54, Logan Gunthorpe wrote:
> This ensures we find the correct nvme loop device if others exist on a
> given system (which is generally not expected on test systems).
>
> Additionally, this will be required in the upcomming test nvme/037 which
> will have controllers racing with ones being destroyed.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

If I create a passthru testcase with :-

1. Create nvme-loop based nvme ctrl backed by null_blk say /dev/nvme1

2. Create a nvme-loop based passthru ctrl backed by /dev/nvme1 say nvme2.


With this patch or this series will I be able to write the testcase ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
