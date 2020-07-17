Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C970C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 02:33:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360122070E
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 02:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nqibFaWQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ONuXO3f9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YmFPkL+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360122070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=L6dYzSh13mbJw/NbwNl9pDmH0mDyz6AMOSggfvMZS4s=; b=nqibFaWQOAvQGwzmvVsroNrHG
	A0rfPYuirDZUvsRqrUSJ+Z3288jGbKOxtozY41MDqFDWyGABXbXKsrQV9ena5hZcgqfVnofe0N4cW
	7EkBlAccZ97v5+ZghNz0q05UhAzKDKaBA+78CA+DZLe6onPZ2Xe4bosZ8YKyLVCmoRNjF+fWU/sZR
	WRgEzbGwNvOk2J0uw89W7QR2q1engsunv9AJeEzpRw52ToCgONXKWNlN1fiK5crru34sEArAUWRn9
	+4CYbe1jMTlODvMSxDw7jYPXyShRYwoziS70H1opwUu9tnUWyeoFRSpdQ/cEUvEZMQ4zZCnoH8mQ5
	/XmEKL7vQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwGBi-00056K-24; Fri, 17 Jul 2020 02:33:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwGBf-00055o-Tj
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 02:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594953203; x=1626489203;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kGnqGPHpe2gb+fYA7XW4JT2nUNtWyz76wjI32EJ3b+U=;
 b=ONuXO3f9Aq/Q6huGgRVTbU2dVl+Jg/ynbXPX81R4ovDT/6IUGVe47Tv1
 h8niPlcihYIanzMhFM0y4GI88f08mVTZzAzLwJZAzqihePvBXLamigYKi
 t6FSh7TZzYHNBiMY+kg/kd1Jh6fdge1wh8y66ozm9cyYLSgttMucB+DmN
 moq5us/5cdWKBvNWtLEB2Bck+V/uoRWEJLsH8vfWZfr5lg/L+KY5BLwd/
 r9pjBbo4ipzkT50lYIqLLx6hkcnpGiLHPPjf3hS6cndJcxIVoaYxl6KKw
 wJCdB+cJpoKe8g5nOfllUFd3y6BJ3OtaqwnxLrGori0RC2tpj6hpgAWmk Q==;
IronPort-SDR: Ji8qeF9R/YL+U1fBE7lI2NKyOyS/lHs8cw4oK65548toSANdlig3qpigTh76CjZ1Iv5v5E1y6y
 6fwH4B6Bvvn7T46jU2R13h9KjXsbuCd5qe4SuyeqLkOczpAY9hAddv5hNCl0wJwaPSj4eqHvvp
 mPu5otsUCpoa0WUi/P68akA4/lWFjAD+FWMBkARsucbOfBvgRRcBc6Z/NyI0TZ/J8mYHgYVZ/T
 VfYFMeUnFc/Wm62wd7jeUbHDxIMdRuWQcn4aNXzuzV5hDEdw4Y8EtOAKBQ0urVeAyPR1yxC3wE
 zdU=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; d="scan'208";a="251935687"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 10:33:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCtFbksGOphPPym7DNm4guxeCkihpzZ0DXESJYZ/4Vg8tGnMQ2G4SqeCl+uhc7lPZS/H6sN5rw/aJRKIIhtLfEUs0gOZYrKCkrhSU/q2s+35E+8TXJcuuK4nH5PaklZ2oGgoPpf2kQoCehmShrCRlPVd3C1l32pAokcguEDFzccCootzYfAR0jHsKvW/m7bjdeyjKgECgFDknDA4vvStRu+nkfwXfLWe0SC7rb90OUKB7KSX9t/zk8dM1Gj8cOdHLRmn+LrLIyvNb0mrWY7J/PmJZN8dbPYvg3CqbETnUYt9Ulk0zJoqt7AkF3RkJTMbVTzMlGgh8u510ZducZEneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/n0sX1Vmh7rw8yrMJw8nwdWKEePrKFa68TERhp9z/Y=;
 b=TiiJFlKxrG7Q+Ry3FTgQGDUSS9IdaLHxVsrKJ+LMDxNFWPkr/qPKln0MPwDwY20OFJ6YOsFqe9thqbZMkml/MtL0KYVUesHAzKpEiiAz0I5GyC0+h99pZLda8z47TBEn4ShpB77N0xYfkW1sDeECVI9itizaZZX3Deew4wm0+fnIiIGFzr7+hAQdCMgEFuizErsB7HW/5mrhIRVqRJ4BFVmzoAYEfZoceDlkihg9EZcZIwEBC/PTWAoyqS0Y8U0nAGhG/mf1ZnRfwTqDsTg571v+KUDpS5oKuYGXCYjbALDadSWSqDDDRpXPRd5i5vb+o55kkNWW9RxBX92NvpchUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/n0sX1Vmh7rw8yrMJw8nwdWKEePrKFa68TERhp9z/Y=;
 b=YmFPkL+KONYYL8YH1DFIK022ObFeHM2D3GLA3sYIe36MKABTQh9exLmolTF6+lNnwXTDfHO61Ri11vZkbkOz/iAlARLPLc66MJ8Q8rfFEYgQWCM0MdUI+MR+EcF1Ecjcb6HdCwvGOzBn1h5dSRZeR1ViCAJLHS3GMwq2zF6tJN8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6246.namprd04.prod.outlook.com (2603:10b6:a03:e6::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 02:33:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.018; Fri, 17 Jul 2020
 02:33:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 3/3] nvme-pci: get rid of the division in the fast path
Thread-Topic: [PATCH V4 3/3] nvme-pci: get rid of the division in the fast path
Thread-Index: AQHWW9R+dQnEYq7XXUWMfBzPlyBMTQ==
Date: Fri, 17 Jul 2020 02:33:20 +0000
Message-ID: <BYAPR04MB49652A5628AED989CE279B1E867C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
 <20200717005139.18923-4-chaitanya.kulkarni@wdc.com>
 <20200717023242.GA322692@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32d4a024-c81f-432a-eb4d-08d829f9c522
x-ms-traffictypediagnostic: BYAPR04MB6246:
x-microsoft-antispam-prvs: <BYAPR04MB6246FEF752F6E9EECA123EE4867C0@BYAPR04MB6246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jM3iapW5bz8QrBf96o0sg2RhpN7IG9UtI1NEgc/HcxOTDkuRKpCtOYP9VD5Zqc9oW3cA+A3TGW4ICYB6fF8DW6klVcXwl+0uv/9AYYghmuZ/FRrdbOTON6DVWt3a6UpyXM5tCG/VCkD12Llc1E0cFgKjrclldblxWl1H3xoJwQmQGE4XZeq5hxlNtsD+fCJRI9WPwBdaRpbgIq38SJP0SVDwHRI9dmjIBjIs+dZGdH1OLQu3iZYBg7EpcyO7jROBM8Ny2bdlEhEu9tOJVhZ6E5lb/Sw0qJjM6ohuma8H8jg/mR+2XtvmyoFO1onVef4d1iiW0+ldW34/VXLqG1VTojfS3puk2qyrk7OM5hTU8C2cct03s9w+l/zbyekZ15+y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(316002)(64756008)(66556008)(66446008)(66946007)(26005)(52536014)(76116006)(33656002)(558084003)(5660300002)(478600001)(6916009)(71200400001)(8676002)(2906002)(186003)(7696005)(8936002)(54906003)(66476007)(53546011)(9686003)(6506007)(55016002)(4326008)(86362001)(26583001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fltEcNg0CewaOW/S+dK82Jgvh60PPjK48YwhdjQUmbvMHADkXmhSWqAMat9RZPAH36Ytxqmd/UDZu+xCiF8GsFsaNZakvI9QKGEKzs9zfZYRZS3uvp8NM7k1+lIn5yE2Jnt82TS3ee5wGS7+KBa5wBSJEpwL7qaz4yse/twuOgjHC2wKh4jHfROFuVj8155Ogcn1CZgQR4NZiDhw3qOXE8AzkbPlHmIEy+78S9EvxFjvVYt+ojXd5jA2mRABAU9Cxdpt4aJ3rL3bauxEhrA6tF4IxodD0KiOxaROjqCbfpLyolvLxPgWYmgbA0zPYna6Ai3P1jOG40q1w3SOe9lQO534Ruq269l6iEMVM/x+zStN+Ozx4GjBQvLJvgnlX3BxslycoHOnST9lj3fMM8+2msTyaQZIcj+iamtJtnrrQ29Y4HblGW9eyAmhNph9xsc1fCjW+VtM8OOEqcsSAVwPBSN7dRexPVnqbKJGlfppuGw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d4a024-c81f-432a-eb4d-08d829f9c522
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 02:33:20.2641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbDZQQ1vKCei84b9Htf+ovzXbQPEfGdBkeNskZ83Mef9Rsod40DAl3ygWm7lZwZgdGXvOX+NSJRStjqlJV8OgSWEYy8CeYee0BH20cUZuZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_223324_163097_7E918D41 
X-CRM114-Status: UNSURE (   7.69  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/16/20 19:32, Keith Busch wrote:
>> +	const int last_prp = (NVME_CTRL_PAGE_SIZE >> ilog2(sizeof(__le64))) - 1;
> This is an integer constant expression, so the result is already
> evaluated at compile time.
> 

Okay, we can ignore this patch then.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
