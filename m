Return-Path: <SRS0=c/Ka=3J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB8C32771
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2020 04:48:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FBF20684
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2020 04:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqKDVrE6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="atGk/PNi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ie7z5AD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FBF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BUZ8KLnZDGsFmXnK67u9FtuSNAsykeoWCOhw2VWgMSE=; b=AqKDVrE6j/nMkR
	bjQKhgJYs7UuwG06qlPGKfA1GLr5CrCd13RuMyyThMmWelzri8KkLiy98hfRpEXc4qB+XKxpV+4Nh
	kP1J4IBh8DKJMqAPygU3qeJL8JDIziJimpF0BI4zbskZovcIYGbhhwOAFtG2OFUYmHgdMc6ffoqBa
	i3yKSkNeW6MGG1AFnMmAxL39WGj+9k7zWOHQbCpD0P7OTkC1QIXCPRoYtMZhRmnv9BvXsT44DvVza
	qYZegs3q/1qj9/c/euOwo/pQvf2/zDJiiQgdLIO7L1YLMzeRWVqibvzHbbAnW+63fwomRCxxWQqyC
	6mRGsQDL5bax+EiiwZLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itOzW-0001UP-2B; Mon, 20 Jan 2020 04:48:46 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itOzT-0001Th-0V
 for linux-nvme@lists.infradead.org; Mon, 20 Jan 2020 04:48:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579495723; x=1611031723;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=74rknCfjYghK48K6wnbrJr1q4zbMA9cPWh3zBiihsis=;
 b=atGk/PNigc9v1EfaTXpUgqDsBK/VC0pRv8mjrgU+U1Eken/2aMVSPF/a
 TjRH0vvUMIXA55n/1pa6ngPqbh5tzQ/rvtuBwEQXni+yf4XsnMrpEOjOF
 Am8KEi5UwpS1W6/p8JP7/mi51vIn8RJQPFEVTL2jIYYlVrlvyxjz77EYo
 w/XOUfiAhowNLDaqBcUx9xROqc2cJtqWy1bjTcc2BAyZHXiuIy32LWVzg
 9YPbGXKiNbuDxBLGf1do+PPVAuK/SjEcGj9wE8GhLuomfGb9ofnAWOA9C
 RETIld57GD+eZg2Bfjh96gGpvdGNK+POHK3OwGw6+Zxv0LGf37SAjQWCr g==;
IronPort-SDR: r7z5ZcC7zOd4TV2C/UTaMwELnmCbeBBbK2p3EDG3JDQ7Vq4Gh+6fJ+9rOTbdvAYzzQ1n1SA/MP
 sJ0t7+PqIyx3BKyVD4I414L3BelEl+9arsLpxNbfrveNls1MNI+qw+Uaajx055sc2GE3ialRr5
 ZNEnJw9sWjdjtv7VreBCuydUggMMeycmrrndidEwsC5X63iZ2l7s3YWJKI+mfxnLGQWNiFX0ei
 oiLzkBG9t0kGdtMirVeJs5yFxwEhDSZjuip4yHR5QvEgE/kkvgM+eTIjov8Cm/uzsTQWrsukcB
 gMo=
X-IronPort-AV: E=Sophos;i="5.70,340,1574092800"; d="scan'208";a="129460097"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2020 12:48:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPlF78IUivrGdoj8r1kmCD6nF+PnPCLkPkEKwmgeKAboGTMLhcAzJtfd5eSWts5OJBJjU8+OQFh5xgANxVVsanA1oRiDqK1n2BEfDVQmRTyGjnvJ8MTRUiYnfeor6j4ggSj56yCl3sOItsQhaM1Bedt/hqSRcoahJ402G3LrmMLeZ4H42j1x4ozZ9afujglpwZRsjTxj9wtFgtcNK1zdBXpsHQW37mRyiBaCFJnLm6vzlWcr/GwhuExWdxIGcwVGvItRfl/qdaGswhxvI2E8QDpJ17Pw+Tf3DBtug4FSl0a6GPi4n+xyiCG9JWdoPF4D4iYVVkCfpmTFihp6pmyyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74rknCfjYghK48K6wnbrJr1q4zbMA9cPWh3zBiihsis=;
 b=XEOpb7umQyvFUMiyxFT609HFgGIdn8qDWAU0+TihjsGixtEj5KmXLn0DW0Ya6pndHZ6Q6WEbrblZBRqL3LQwbUKrCRoEYiELt16EV0+PBJ34+K8PSnubXET/NCDdY3c9B2xvYUgJezf1GHLPvGrDwi/wYGF+fEDAk3gitUVEH71bpqV2qiQpCFM+oVRcLNUb2ZCIPpn++5ejaMYDlpnIgYHdNHhLDoWI+eUkTX48WB9en7c20OjzdL2XhSwSqQc4rp4o/5BxeES/qxUOAfzq5ug7igG5we3rjW/rAQI6+sWs0QQVKu2mI+va9yGbRc8IgRoTWpI+ekr3CqdlpgnSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74rknCfjYghK48K6wnbrJr1q4zbMA9cPWh3zBiihsis=;
 b=ie7z5AD3taljM2+mGy75Co7CFRztOrc18h1nrsACyK+C0Sgj721+mxZ4Vo7BXETRc8piLHKzfwSiR6ZLPDn/S0c1EYdtOplRhynJ2wx2EWaZZ53MlkQe96DqGh1s9ExVJsAJhTsXRQ/mL4B/yFRqpuhRbtkJ/sriHLx4FboDRHo=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5976.namprd04.prod.outlook.com (20.178.236.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Mon, 20 Jan 2020 04:48:37 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 04:48:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/2] nvmet: add polling support
Thread-Topic: [RFC PATCH 0/2] nvmet: add polling support
Thread-Index: AQHVryK85gJ3GKafwE2Wl4D0J6eouQ==
Date: Mon, 20 Jan 2020 04:48:36 +0000
Message-ID: <BYAPR04MB5749DBBD567F3BFCAFAB348686320@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
 <fe370161-13d7-a005-2666-968107be13bd@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f0b5b65-dab2-48a5-674c-08d79d6402fd
x-ms-traffictypediagnostic: BYAPR04MB5976:
x-microsoft-antispam-prvs: <BYAPR04MB5976588F77777675911AF16086320@BYAPR04MB5976.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(8936002)(71200400001)(81166006)(110136005)(478600001)(81156014)(2906002)(76116006)(66556008)(66946007)(66476007)(66446008)(316002)(64756008)(8676002)(9686003)(52536014)(53546011)(5660300002)(7696005)(186003)(55016002)(6506007)(86362001)(26005)(4326008)(33656002)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5976;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpkmxhOW7tTVrm26qSuJ0X1QP/5+TGzCrsbaCrGcJx22WuHnOB8w1/8qfQ31xY9JKapzqSr42uUs0lGHoDPB0Ye8mM7icy7I5QDjKx4Ts0BZE7LCAFbnC2f5bU8T7hTHjdE1lDYMvuBvLYLqZEJTNb344UqaqwWMhrEUJMEZikJ41UoGA1Tw6Bff1114nnEc2KEnHmJh0+BFoi+B6YFEIn2bo4KH4U4Ly9Y01fhGO1AYgCZ158Uc7+4y9TbE+weHkJz6I8Z+wCTPE7JJuzOMIM2FjP1RyFVcGtn5roTtPc+/QEE794k/lIwWbI1Se2yszWkp+w00agVBRjMJq135oJNZ0K4U5N8e0/9LVKSha58FvAdmrwh5XDr6p8AL4GgrAuigQTc4wXrql6LArromsXVsuMcY6ylJH7c6AerKUnys53/4kprn1VNWyKLDNF8D
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0b5b65-dab2-48a5-674c-08d79d6402fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 04:48:36.6697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2B7wzwoabvmRSU2s2sEereyefHEQGT5DfgO/rX5cyzQSMo2ODj3l6iuTEQ2D3GXNbTzQo4j86Jtk486f3qwXK0HRm56CCcw7Qv+PPKi93rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5976
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200119_204843_093155_2FDDD9CF 
X-CRM114-Status: UNSURE (   9.77  )
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

On 12/11/2019 05:01 PM, Sagi Grimberg wrote:
> percpu threads per namespace? Sounds like the wrong approach. These
> threads will compete for cpu time with the main nvmet contexts.

Isn't having need_resched() placed in the polling thread should
help with the one thread hogging the CPU ?

Please have a look my reply and performance numbers for new patch.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
