Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45760C433E1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:56:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A00206F7
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YjBJ0959";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EHpelkHt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FABcKIBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A00206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WTx2tl2eYMD5HPk4FVlcMqybldk5N1NAMT1Z4OM9zL0=; b=YjBJ09594/ivIl
	cERB238F3sn71o3CaonkltvlOAxYHe8KZIKzVBJ7LpaEv8cDO7xtaoPryb7GaQelELzGpyu1Io2qH
	RJdBpNgfJNXY6cjwH2cuqHlyLc12bP6wZHssKC2USzSazNLHnEcA4jmOgfRcBpRSNwJ+clsB8fkX5
	y7N91gP5Ov1DV6Aa7Mjcnoav1g20Zx66SaqvhTdHcncsW1d/sm8FHpXsnBFN37svrJdcbyQ9b6oM7
	jTvLPQJ9GdbMTFDiZA2SfC7iVQIhNhSUssFPZZ0wGA45ziiJWv1dFhWwRpBKMvLHCm1tNZQ9N6j+s
	XceeV9ivQo8g8PcZR5Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jio6V-0000QQ-3M; Tue, 09 Jun 2020 23:56:27 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jio6S-0000Pc-Il
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 23:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591746985; x=1623282985;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=eg0UEvcvaFoOUleCYwG2wDkwgpHWDhz8fGxqHK67Bz4=;
 b=EHpelkHtQ92knZafGZviudJV/MEV8x8enZQApk6ydXfZ7VS6JkaOteuW
 BK5z34FhdG9G8fd5vhEZAqfJhPabgjvpfEr1uoZWmIIUStj04h169rFtX
 jzUx0UfyYiAGQ5IIdakkRRLxwdhhm09eTWKySkSG20B8d/kexmLaJ5mKt
 WqdPq97qFVZFAcVBRFMOZSMCSdFTxaeWTaNCZkwW2/QXZUOAAF8/9vYsi
 S8OB6GDTZaQYUOWFqpGNPU1gvM/TGfnF0UAadDPJwKp8oqDXxt0bkL1cG
 VK3ylacOaV5VGkj2yCH36mHoKZBmta0Au9aAtvLFad4qfNusRYSf0VYUM Q==;
IronPort-SDR: d5Rf7/pNFwMGdg5ZcUvdF5BTRVFiaPL4gfHD6a+UBDmbYwbA0HCXQreIh73jTUv/hdhy93C2Tu
 oHQ/9r6l6YrlX9tD0u1lbZKYhiZOhKiU5XwB2UWy8ixjvlv7OpFPx5+0BuGbKLgKwH6n57l7xE
 sRR43mYt0npm+shKBtDZ+36+aM/AnfBoqk/mqdTkVcj6tGG3M2a6MmS7O5ERsrObAW6XZS9H2X
 KVC19+HQkS4vVZx8So0rm7QcnZyZJFNhdC4zX8/k3nxcKlG+2cAbPM8fmM17DPa3HYb6Xn9uEu
 bH8=
X-IronPort-AV: E=Sophos;i="5.73,493,1583164800"; d="scan'208";a="143910678"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 07:56:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOq0obwBYqrlN870oDX/0BgsMjZwKI9Bypx+FOwIYo9HRjlKoCtYYOfXVN/FZcDI6YP90P85Zcf2qCRYQmL56I+u318jztpi+uf8GvIF5HtBajKPLJ8W1oKNZqVopJ/wt2bRP6xvgAfpjRmgG5vRpqJOjROUlT+6Unxte1MX+/SrF5cuQUccFSH9ZxpHwRczk9YJblkaVKFLMSB0AQlkexkOXEdOd+etNQXV0OkwZPlSjQ+FRMMOWxSWXzyIj52wVGtMFxaBMF8JWIYM87NEYp8L5KiqPnr0Bambe4PQ27wqZHHRFwUSX9v9i9y9tLyIFbUhy1TUKiJ0/2kuj92pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg0UEvcvaFoOUleCYwG2wDkwgpHWDhz8fGxqHK67Bz4=;
 b=UrmFMBKw+J0g4PenkjeECL0dPHoHndCBR8wtZ+9XBZyMPgM91PuM1Jb/7nwVTSkWo7K1si/HBPBjUm9IGbK4iw+H9r/zDUkrfDmU67eHX1cwfd01/rNzAiD8KZ12ul5NuYz+i7TCrfGusO7SGxKYfOQEumTap4T3RcEv9Po+PquEZO9M8YBBOgXszjMRGLn36T/xEhKB1iueEVAjlubLkoG12GWLVNatijrsEfeADk30SW+SA0ZkE0fPecHq2NVkreOStZ6lGdh8R0QIGqZHsJce8xUTP0VSh3EBxJjy4ppWKId+T3UrCchJolhKQJ7BbMCP8GXsILWIviM9D8F0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg0UEvcvaFoOUleCYwG2wDkwgpHWDhz8fGxqHK67Bz4=;
 b=FABcKIBGLokQeU8nHbuLEYH7MdXP3vVPfnztYLivXsP5DHBa/awno8t6nwmFgeagvd2g6gn8Z1HXjPqHYzQ44v+wU+YUc5hbcuF8oHllWoay1ItVKQJ4zqV59KWFjQTh06iIXvGgboXhvWEvSbt+V/4qpQLdQzMJi1XgwH3Fhkw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5336.namprd04.prod.outlook.com (2603:10b6:a03:c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 23:56:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 23:56:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvmet: fail outstanding host posted AEN req
Thread-Topic: [PATCH V2] nvmet: fail outstanding host posted AEN req
Thread-Index: AQHWPrR3CK6lFnT9z0+e729zee86ew==
Date: Tue, 9 Jun 2020 23:56:22 +0000
Message-ID: <BYAPR04MB49657AF3ED56DC691F05C49086820@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200609231942.47808-1-chaitanya.kulkarni@wdc.com>
 <183bd810-3904-5be5-3457-d63d5291c247@grimberg.me>
 <BYAPR04MB4965E53A28ACA2407DC878D986820@BYAPR04MB4965.namprd04.prod.outlook.com>
 <e3530187-4d1b-6346-208c-aebc38395f82@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8474352-d31d-46f9-cbcc-08d80cd0b6a3
x-ms-traffictypediagnostic: BYAPR04MB5336:
x-microsoft-antispam-prvs: <BYAPR04MB533636087B97F4D1ADDA14FA86820@BYAPR04MB5336.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JV9P4a3MPWHwz+TVQYXWKqzaqRUnCGGFfvbAzB5/cG8IteH0kidrhQzxtm5dhK6cLAh6gfNIxIbm2CeuMxoq1k+8sGWOIbpHWbqFp/01hdLL9kP8RGHcMLXfkvK5P6Jp3LSLGt0NdvPdSccOY339kgRv37C0kZ2yo0M/lY7/31Ow4ef75GzYpRpZc7W4dVmHzfTnT0Cfb+6ZNrMxcHE0nyNzYyAfhs0Eftdn7lYhtQwQoJi2bPd5hZpovmgr/3nQCTNLSMc3C4LX/xyjDIHmqrIuVradW0fs23p4JIpA9mGvFcizb9C5RMOC+vjX8lh7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(366004)(64756008)(558084003)(8936002)(316002)(2906002)(5660300002)(8676002)(52536014)(9686003)(55016002)(4326008)(478600001)(26005)(86362001)(71200400001)(6506007)(7696005)(110136005)(66476007)(53546011)(66556008)(33656002)(186003)(66446008)(76116006)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yXYWcAPgAaHm2gOSzoAQlMU7CWGCEaRvRT5j/E3mKHZ/veA/1OnuXxrBMUwaKdzJ+BTE2q3OT36leUwF86Yb80MpqARwXZSK+mv3ND19EzlafCj4CDyQSYZyfoWZ7fEX8Rz/pvQpa2RP7Njw88layj1oATAqKBOjL1qJ3Sr6bDQU3HaTcF2e/ZZhv6ZWPHGMqW7ZYwR31/M+Ce6HDwe5lqtOJl8TivovG3MoCa/9W9G+950iXLj6iXTqLPonSSmZ6u+Lf83JKzTfbIIwysqvXhJQLQyDE4JgM054KFmceqKRD54NbqDJfFkGOoV4wEJFYO7vXklYWnGa02PTEJYQIO4C0u9lmLt6SEcnj0m1cvCOkzyxq28eLTmmlKpfFfqK+ATQplSMFFQGPUudQufWi9JreziCUMTTcfPySlbZh9zCwsmSmMit6ayCz3+wLbwibIvKvrs5R0WAXhL5k0gjyXdjenJN7jmtTQsqTBX6WCA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8474352-d31d-46f9-cbcc-08d80cd0b6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 23:56:22.7935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n45O9LuVGP1eYpL5aL/4ApM/YvrAmsp9SQ275KZ29bIlxLQL/LTqiVFhtfoaALPdoHtSUVElfGz1s14Nteti4KXiZVTJoulL7naOR7kEXhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_165624_628254_D23808FC 
X-CRM114-Status: UNSURE (   8.25  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/9/20 4:32 PM, Sagi Grimberg wrote:
> I think we can just keep the failall variant...
> 

Sent out V3, let me know if that patch needs to be split into 2
due to main code change side effects.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
