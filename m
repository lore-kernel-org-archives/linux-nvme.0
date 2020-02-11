Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE61C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:18:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5291D20708
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p8QO0QxH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GTYwvh6N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CRB6OI0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5291D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ri6jQbZhmlM4y1rfyGK7VRTllzEyd7l3ISq1aiu/nWw=; b=p8QO0QxHlW/SX5
	7lt49IvyY/7R1KwmMQ5LS6aqM/T5B87Qqe3Vn+MrpyDo8K7hjkk2e04OPkhY/561FFVLFWPvx6a85
	dxfuKzULNYlFy2wWiq2KADrKT3bq1E0eS965sEPMmuOZejL+wdVjbfHrkkrsRphrACcYKrKdb3bDH
	I+GxElg7wEIK8UWRmEqQldLwPySGN+xYYmiQlyCOD1uUTbouLb70cPwb+HOrGVp5Tv3RQOB+J6cR0
	2b99OQthQk7TECvcwsILzxCMhGZP0l7rDwb1PoVhGdZrR5t3txVYKaIQqGlaL5v/2PIi3fiwB0ST2
	z1bKtpG+tgUJ+cim3Llw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1drD-0005XA-Gv; Tue, 11 Feb 2020 22:18:15 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1drA-0005WE-OO
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 22:18:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581459518; x=1612995518;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Rwi3HuCZ4S1bquuYrUlE/CZnN2Ji2JE2VvG1v/lHYjY=;
 b=GTYwvh6Nu/R1HHveCvo04MEXeYYDN25IjMf3AG7JQxnuMJpoEQtJRWOW
 F8CUI/6fKubsy8I/UPiVi6VauEIHppVOEP8xMfX2sycHAQX5H9zz13l8+
 RaaWATBhfyoru0XzPZsYTtXy0eW7ubjqveKGdeJDkxh4bC2lpk9v63M3w
 GUPpQxA3lxFtt1mvIhlGgJVznR4AjsE50eyu8ENuaI8JklUbyCMU0WQHC
 XB3jMtGBt7j/LNEk+VbBVsx+v78spgnjls2hJHVyyMn0sgRst4cDQ7rUJ
 3csUVmsJICyoMlAlx8Wf4lW7MtqPOEW+Z6RToo3euEQPIvcZtqPVUUuet Q==;
IronPort-SDR: 8fqDvL3cUDCDlUR51LcpivPTu/qpxOy3GZ0FyijMJW11D/QbUsrvXpQTSSSPO9JqcTK26xwV6B
 QxEUACpsas0MBwuLue3XW4pFU6ghK1/yzCFnIFHD96g4Gd2d810/zAYG3hxpCcys8PWXNeZdrK
 9Fnzj7Vq9yjJI1idf1TcqMUupDyzJllzwxJyggc3QMjjkWA/KWDZ64I7bLT9NmJvd3aYUJ66aN
 D52xs0Boxxl3/t5ywKIdOv3EvddQegTwV2gfBUmhzZ2v9+0/23RGcxZwlTIDjCRCDAJZWHevWY
 wH4=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; d="scan'208";a="231417763"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 06:18:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H00/oiXT5rfRaHiXV4XnIzfl3WZbO7iK4yDdl5UD36QskIjSrnvoLmJrgLhLUHweR99o9PQayq+hVCAVnV72+FfIQGeLp/hKwjkcag/RjzvTbvyTPwb0q0+lDOtXaxl+Z2Dj1IF5YZiul3hMlrS+0X+krxusKC0Th4oG2hd7R6xf0LZyOfz2Qs16G4x9OjEdUmchWR/2KO1XRwQYoS1JgVNGBS0pT7UXyb7WiuiPcfFpCnjLQ0E8UgVf56f28EchzsufkIuvgEXj2PKu0zTRlJQt7VX11ZYcicaeOZ2bRIL9jrrLbnix11w8/K4ukH8gSoxRXbEJYpav5QwNhL4NMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwi3HuCZ4S1bquuYrUlE/CZnN2Ji2JE2VvG1v/lHYjY=;
 b=QHdwf7Pxr0zqMyQWWiqXBkpFIBXjhXWQT3VO5AYO/v5UNZSe74g2YktFpZaL72L9hNGmXwvA4jGuf8Sa0ZNCy3TJaF+aNbDaK1ZFgGCLkAFk7fpS4SVAxqntIsfwCKz3BRLQNL+0e+5ZKfxpUChxDQa7znQTCW1nogntr+r8tDtwCKlrEV4OnTuxPknIQZDsBRdoEfnLiS2PoDg2yr8ET5B72WkSTykvCzPoAgcidzvVs5MstZ3LtdfYoFSQYiGONJllLqjujCcyCzhaDuhZKBmZaY/7uQj2B1VgzAMj8/CJR/6vdSR82uBNrH655Bnk1PXMpyIkYGQF3FOZrBhcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwi3HuCZ4S1bquuYrUlE/CZnN2Ji2JE2VvG1v/lHYjY=;
 b=CRB6OI0KPrlNTzXQpwaAr5TqSIvL0vJduZsPjvKNqAk5LHzfzAR0sC92bP+Chsb16g9PA1VwQbAYcKoITDWe7nd5C2qedghVqzqAdF5NdXSgUjjQFajJLWDCmomxQmTHncTBYPL4wcELZzinlhRjaqOLkCPj57yHM2C1eQj23MY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4325.namprd04.prod.outlook.com (20.176.251.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Tue, 11 Feb 2020 22:18:08 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 22:18:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 5/5 blktests] nvme: make new testcases backward compatible
Thread-Topic: [PATCH 5/5 blktests] nvme: make new testcases backward compatible
Thread-Index: AQHV1vv5m5/FKUahik+K8cmnBHMTOA==
Date: Tue, 11 Feb 2020 22:18:06 +0000
Message-ID: <BYAPR04MB574904FA7795B7267266E6F986180@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-6-chaitanya.kulkarni@wdc.com>
 <20200211220607.GF100751@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e046cccf-4101-402d-5bda-08d7af404521
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB43255765A013B78B9528471086180@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(64756008)(2906002)(66446008)(4744005)(478600001)(66556008)(76116006)(53546011)(66476007)(55016002)(9686003)(6506007)(33656002)(186003)(7696005)(4326008)(8676002)(71200400001)(6916009)(5660300002)(52536014)(54906003)(66946007)(81166006)(86362001)(81156014)(316002)(26005)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4325;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWT8Hkk158IJeGhm/n+yelrWvuSDg+S5pCTHtCwKPlui3F2Qdr6V/7oU3ewbQJoPamdgT/++A5/wVVWiDgz4Mxmf9Sg0mZe3JdaFFIBrTdNX6YH0GlJPa9v8+klERTtcNBVowsCJIhDHAzRCKIyFcxtAxfUByjxdJ5xf0mcr7BGru3fs+QJnOgPa3Pra1Vc3RE53xlwU7FkMsFWXagaQgVy0+sqBmcMH1jQHehtpoZzfUvhVd5pfArLDuDR5XNsn+I/FtZctk2z7qaPQYbU85PzmnLtyQcZ3JxBJe3wYLCDJDnZyroExniqoTrf/muWtUlf+v3OqHEoVFaT1u2j4GuWw1pzEnIjF+QPK0wuQBnH7wdMiqU2IMujRX0UTr4ZRiw+gfHFsbO0xN/Zlrxc32aRNvIaHQwZzW2fVIYj65SFd890KdG4CRvVmRKfbvcwc
x-ms-exchange-antispam-messagedata: GT2rPQl7sZ1L9QZ3DI1URh3raeI1fvAoMuiBNCwQbRAmWSDdGJJD6jTpvdVYAhrMupwEhsQU0RECrT+I1w6GuB/YEtZzGlNCHKLPrcbhfEJu9h6OmMcRbyoqlQ0/J7wmJ0tffvIrbfIhIxu4zSQPsA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e046cccf-4101-402d-5bda-08d7af404521
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 22:18:06.6797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xzfgkb4+QKTy2s9smkk6wGj6QK/gqpecyyaDlufhexfR7ctWOWdQIk57rTPq1+LeHIh/OLXVDB2VLKiTNmkyHSE3rPg05CpjqdGShXsXJE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_141812_850268_3DF74C14 
X-CRM114-Status: UNSURE (   9.12  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/11/2020 02:06 PM, Omar Sandoval wrote:
> On Wed, Jan 29, 2020 at 03:29:21PM -0800, Chaitanya Kulkarni wrote:
>> >This patch makes newly added testcases backward compatible with
>> >right value setting into the SKIP_REASON variable.
> Oh! These should be part of the new tests from the start. Please
> reorganize the series.
>
Okay, I kept it simple so that easy to review test-cases first,
I'll do the prep patch, and send out again.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
