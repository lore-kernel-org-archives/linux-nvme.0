Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DACC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:56:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7623206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="w+qhbHOo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ipd6Qt3s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hu7AgFqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7623206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=+M/32TdU8lp2rbMEJeHG35xJmE8EqBbqsb5/6v/bkmw=; b=w+qhbHOoF+LFQj2pHtQGlKaMG
	qWppMqO9rTEyI9iFQU2vHuUzVSsDWQFSuoHHGNYuPuvzkykS1CH/Jojd2iSt/iFX71qwfkWNYMPLh
	SmrjJlhm7dsFpjgbogjJtAQgPy/4dHQJjDSW4Lpauk9syh59x+nzFLu67Iarse1xyrtLCDKxPPFW/
	vAP26UdrkJkCAlyZaRbAqThwHCwaa4EoVOGYXltFSJ8jRzyuYvLRo85bz/g3bfupMzM3hcXKFQtVX
	XPXvfQ9qiNwK24A3xN4u4FQWZ82MuZLLQcO8DOr4u2uVz1arsGgv9fkdrfxDkgEvdqYbsafHeH9kO
	4Wc8FHwfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Gic-0006Xh-BQ; Mon, 10 Aug 2020 22:56:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GiZ-0006Wn-Ss
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:56:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597100196; x=1628636196;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zP0PX0RN90JO+gd3mB4PsO1ahhiYmBJMvJcnuwLFhFU=;
 b=Ipd6Qt3s6udPE+Lb7h23W3mG55axLxh6sC7ws6SOJvv5QxsyJxR5wCaB
 iRBH9oZQNWQNEAHd2DgtK5X+jXq9V1CAGIJbKOGOPbPLMmLxuJsLcleiD
 PzECdG6n2OVztuOxM0HpUdELHdtuYU9zVoVdEMDHKGV0w+Mn7+PV5NzP2
 /8Z/Bf2NqUOqZjrpR/75eefFV3Bryr5L8JZq9zsLdB8MICZjI/D/WwS3B
 vlLBH/Z6tyGFzd5NvZRk+LCdcd3RleJejupellLRHAensZmR6aSF1yYyG
 6Hm+WFGDi2FC+AO1YYfP4m5hjcJg+B7mDzNxlZOUAkm25kcd5i1L4B/JM g==;
IronPort-SDR: frmLePQi1+sn3m0Sh2mTTrpiLXSQSruQ29/tZH3g5pVkDum6ThN8MSJCqM58j6PL9JtTSXBrnt
 QRAJsW1Hxrv9M1pxP1XolG/KvuuEzRS9irmgNIJ0/vsolVY2jOGHtC5xoYH9ptkpB5cPlpTLMY
 aG9aOIKjz6tDCJKZ+leGyjpKk97X/vl86wsqLgOI5+TXH07RH7zIzRiud5bNfRgyx8qsHA7EZt
 c2i7+/qf/7OBEZu8tNYl/a3tzFS5glHkXV20esjxmyK4/JmY/JauXr78HcQgnbsKTNDzyz8A6J
 BXo=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="145843605"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 06:56:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnbX6QuwkwkHGZFF9CeTbdnahbP6KAL8jhI2YOd4eqLMwq3+cT8yV7YZS+V8jOhm9sUHqXMDrebfmzA4Wbrc21cusgb56tbSwO8xurjb1vprjSYHfhguMBH+5fzgsNCwmEBDLUFGDWGXB6ebBd4yYAHiMn1eNACTrN/wn8a5fg+d6galPK9aMog9LN678AIThxrkl29yB7rkI/3QcmvtxCk6u6fZb+bp4XoBMAXL4L7qNXZZ1hK2PTBq94xGeUEQASoVYoqL7wRZQ8VLChIfTtDJpLayzQSB7OvOPruz8XSsfWXTH8R17KZMI1edr3W5R2XyiYHwyRGPCav5j5pHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP0PX0RN90JO+gd3mB4PsO1ahhiYmBJMvJcnuwLFhFU=;
 b=MjS5ROCCyHfjN8Mll1V+wPV9sf200QjaG7F/6qBuUKz+BYicH8zgr13UqYMfLY5rqqayiKFlNmI9VlcbZaQplX1e4zm3YYrrJWyzgHYxD00ZRXcMzRTx+rDH1fJMTCb7SROYwlynMk37v/lrvBPcaF3/+zGvQ364c/zQ5/WTwknLdsP2NqvtTpPLNJdUCMEjo8e3q3m/qmR0TDpXrCaGcp4fqvhiCKju9eu1amQI7NcbkT7n2TfKQtKUCykYDibPpTFY6H1tFXoPCBOd6AC4rQbQUPKUvJ2EEDmobuHGAm5bAhd4gpazcEqBJEO6WmAU+cBKK6kk/1xLG52PhAle6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP0PX0RN90JO+gd3mB4PsO1ahhiYmBJMvJcnuwLFhFU=;
 b=hu7AgFqkOYpsYnBSWRjXkK2Nji1+I4VsYDIz6OWhoO6ppNTLmiM+LzluKOFeD+2ptnyheAscmXm20ankT1RMna1q/r8K77fEzUFzkqJfV3UY6wyFeX5I62dKfX+60L/pIBcuzqVxQ/y7cR3UtxX8VyXq2di7/0mdjc/r8hm+C38=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 22:56:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 22:56:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 04/14] nvmet: use consistent type for op_flag
Thread-Topic: [PATCH 04/14] nvmet: use consistent type for op_flag
Thread-Index: AQHWb0fVV+HBwCDbGki96Ptk4nxTig==
Date: Mon, 10 Aug 2020 22:56:33 +0000
Message-ID: <BYAPR04MB496585614B0AFDC4F2033EE686440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-5-chaitanya.kulkarni@wdc.com>
 <32e5116d-4a35-b7ee-e73f-bcb957e8ebdb@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44518b5a-4e26-4383-aed4-08d83d80a0d5
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-microsoft-antispam-prvs: <BYAPR04MB61016569D8E73A02643AED6186440@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wztrs/Dghkts0b2idKs6BqizQKHMzuKKSt3SnOd7tG6uehXa1csQQR2rrhCvQ7zFbh5Uj2imdmmm7UKN7KIrrfzeG2A8P4OktcROzxXGF7MTHYjJqeHhlfULDtr6ZGYoExmdRYYScErQz8inUl11tifg40rzhzHD2dWLjvFJ0Yx/xg6PElQAIfAIGddyBRPxqQ1Pw6EF67HHrUoKuoMmmo4Ev6FIrSWHhYn2+6uG49HFHygHnqb7CIoDSEkDfAigu5XHxZh4BHYH8bV1Ty1ObvuGqxyuHt5SCO2N4HRMGPb4ToZvvj0AYF4uNW1rzk8GfZfBWVzb3GTlBTRdy3P/tg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(55016002)(54906003)(110136005)(83380400001)(4326008)(9686003)(6506007)(33656002)(26005)(86362001)(8676002)(53546011)(7696005)(66446008)(71200400001)(186003)(316002)(66556008)(64756008)(76116006)(2906002)(5660300002)(66946007)(66476007)(8936002)(478600001)(558084003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: CftYvJm8Rgj++H/s3vguqkEj/27Q6tBW5KLqqO21XZM8vwgtudQkrM3UYd4pENN3su9lKAFdGtF94Re9jjOCCOmsg+i7wP49+gH7fFurmsXFK8hyZQ9UDMjqq+aXJCDSRxWzDtCtY3qbJelhC5VziQTM+L+DJGlKkAywSoKMY9j28fhjtZCWqIU0Syld6tGvmWTceSzB/r+W+v41WrFkBYRXhC5kxR+aSI4IH5vEF9YxOwVN+1cnpdZu+N8ILIGe0I6vXtTgRmcPj0Dswtb2+RSTO5v022ie4qvTv05ut69Qxc3op0Fy3GrO8RpSLsOvINRPNEVEn/XozV5sVcEHvXEebEz4iQwUM6GLAFoUm31hHvXrTMVqpSj41aDKAtR1u64EuG+TmUVuvwCm6kiunDoDEekDjUgjbW6LpmzLQGn0n6Nj4K3Gz4SlDOotVvLVhakhojKx7U4RfBRcIUqstapEUcsF8C/wx6zoKu3InvzJSRdVAu3yxlO1hCol97jm4QSRP7oNMF8/PQ1N3FY+FwGvtHBKAbv5XTn0p9ZXbvkzhmxRMicu1rI+kyR0hnXtreLWp5XhrP1sHujuH2gnnS/5CKpSf9OWay4ZjdblTu1kSrEvCPote1vtlegA3M3XDrnOLTsPaO1XNcP5hSjPDQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44518b5a-4e26-4383-aed4-08d83d80a0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 22:56:33.5742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qBjHN6PmR4la7duzg1YFe5BS95pSJ5VuyxgwG4823twe4f6xnDaGzm15lzYZzSK4EJTyhDx0KeQEOdCd+dzMIMQzFq8OJ2mKBBRXMPleng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_185636_069483_CF8353AE 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 14:57, Logan Gunthorpe wrote:
> I think you mean "order" (per reverse christmas-tree convention)... Not
> "indentation".
Thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
