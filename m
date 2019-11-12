Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D5C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 07:06:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796BB2067B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 07:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FYjfb6ft";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BNW3aqcf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c5HHrkS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796BB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Pu6ohaXmxG6NBScEOFcngR/n2yNN2PeB81VRlEfoq8A=; b=FYjfb6ft/B9AOR
	vwf9tZ0diyKWZf28J5YzYkYEW5xPoq97Vln4qmuIU4Lq6IzxeitRteu1oVyJ8J78p99E9st7ZsIFq
	+hYIsbrY3PseB/LjxSTsUlA1+a4Zoc2gOf4Q+jZVqLkVMFaOxBu3W0rEVcrBZaPHLaCPRS/eH0/wb
	Tp/u5juCpTJxcJ6h5g7ZdORHKWNXJFkTYgHX7isFmB0QGlXbHWQzuQGB5N0IhQZIfUoXzv+wZ5R02
	LX9TUeGxzrqOvmsbohQaX26Vogh62QhNYkctzsGoSkm0dlT9mCnB+gJhbiATdk+l7oZzqplCOARoh
	nsXmBS3/0P8yWEzzxrzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUQFv-0004RD-VA; Tue, 12 Nov 2019 07:06:27 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUQFt-0004QU-GB
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 07:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573542386; x=1605078386;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=V6BSpyiczHp22dB/RMdlX7Go9nXmVagzEsrNykxjXz4=;
 b=BNW3aqcf0SPqjHdYAejQjKE4waYCzWg3zLT93ibC5YyV+oGu5j+vhHAx
 3aw2hX2s0sDnGXSXhcdDFaWAytj4B28k1AfzouYaBK2RsJyspMv5XQVR3
 N7oG/J2oCgiy3DLmC+N2NSp/QWgEHyeC33R+twwzwxg1tnnS0JpSOYQQD
 jNhSqaDpB3qTDeFiAP0Y8/+c7LTK6NfsrkDRw6MHgZVoSgjbI5O2JI/NA
 K+TQdApDBUW9bKev2mS/WIG4JGTmhfcwTsoDYr/AQfa198duQ90iCp+59
 1jyvwyEpEfY0WOB5Tut9qM62hZ/haprQyLa861h2pnCOd3iZmW2PQPHC8 Q==;
IronPort-SDR: tOR8cOxWTMT3lsAj5iqkYQSYcrcUgs9YbLhOp9HbZRiVtRQI/up9IR9KInFVRMsHe5o+aImjIP
 o26TqzrziaVeLf4YMbdzJbqGZqhIIcBYnGw5FbxlW3b/0SZ4xYnYQHTcuI5oPZqfgZuG+K7nHs
 sEDe9hPa3UtD+hdudQdo8PQRqm52Jdy/Iut3AiBdpHQaCDmxwtpiGjmy9tInAAb5/e9WXA0Tsq
 M+0UtSCiI5XjA6m/QEoj2XWzxDQ4xhalSjxX+Mpg0Nzy2LaHu0C4pyjdwOZcKyZIdW/ZcY/MTu
 HIY=
X-IronPort-AV: E=Sophos;i="5.68,295,1569254400"; d="scan'208";a="127161706"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO
 NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
 by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 15:06:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGtsyeR56ovnJlZDF46kxHrwG4HFfuA9ZaXaFmcfmqqqffcBMhd8jvwT+D/n58yMe6raPQE0gYCp8y4VbA3X5Zrxmvr4t+fDO6lC9SVfksxpuRtkWHjaIX5BmEoygCja67ZhQ5USObipmKHjNNncEs6Ssh0O8qR486wBLvS4zjeH4geaY+H+pwChc6kpqKlHmOmK8aeTJxSmk3j8FYf0CFIrI1BqXV428NsnmNH/cZkOk6Ty4e6aROc0giTUrdXTjbVN0iKUqpTjEHKRPEUdGy98FjaVs0iyEyzEqbu+xnvZ/R0p6+LVV90pMYyfD4kgm/HiFk7hlnwaU2Kg7WzHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYYPfg5DgwcPUkfPABj3Jk0xz9camWELIkzvOfD92gY=;
 b=SDv+5YzhG0UpCrevpIMFuPjA8Dq4ND/ZvaUMuxygHkpDOddvdi3HjFLPZaWY/2nWWEHylJ03QVh77cA4T+xxpqWf/bachIfzraetMvCMl/CK4BwEjyFmjUwJdLU9+MvAMuBn8cQYUxZPXKQtQVra/RggtbQSJO/6xLY3RF8VCLDO8zQ4Zbq6vfZagdQSpV+mZFeX9o74H2qpgCYbvVyD+O2fJeYM+0HkaFKhsH0l6hkuyp74qFikiuWlHo6kwEGVDUvUC1rA6oNAW0c9G0kb0ywBxH3ZbxWVofhWz4t3/rxzc8XpJ3U1pJuTw3+lKmekz7wp0MvqYODZJFLUzKih9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYYPfg5DgwcPUkfPABj3Jk0xz9camWELIkzvOfD92gY=;
 b=c5HHrkS4IZ/3PqKxScpM7QIW3CugqYR2d2vRqWGVV20famGLPOZ15s6+xFley3b/wnbXwLUMLtMyZMXC0GX/aNjwk/jkiddoe0ekYkyjoJ3Mkw5nr7yAPaBRelt26K2pELbZ8nku06mIVtr3/yfGv+8yTjVwx1X7CLlpFcinK0w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5509.namprd04.prod.outlook.com (20.178.232.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 07:06:20 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 07:06:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nvmet: make ctrl model configurable
Thread-Topic: [PATCH] nvmet: make ctrl model configurable
Thread-Index: AQHVkIuhfS0yIueSIkOuObr/y5OBWA==
Date: Tue, 12 Nov 2019 07:06:20 +0000
Message-ID: <BYAPR04MB5749DB569E550588EF53E3B786770@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191101080855.17970-1-chaitanya.kulkarni@wdc.com>
 <20191111103421.GB6127@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c74a4cda-e1a9-40c7-37e1-08d7673ed1f4
x-ms-traffictypediagnostic: BYAPR04MB5509:
x-microsoft-antispam-prvs: <BYAPR04MB550925922668D6D46C9DAB9B86770@BYAPR04MB5509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(2906002)(99286004)(74316002)(229853002)(446003)(7736002)(9686003)(66066001)(6436002)(476003)(256004)(54906003)(33656002)(316002)(14454004)(6116002)(55016002)(305945005)(3846002)(486006)(86362001)(6916009)(71200400001)(71190400001)(26005)(66556008)(76116006)(6506007)(66946007)(76176011)(53546011)(81166006)(4326008)(64756008)(66446008)(4744005)(7696005)(81156014)(66476007)(6246003)(102836004)(8936002)(52536014)(8676002)(25786009)(186003)(478600001)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5509;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7VhnOZA1SUILnRMgJtPpHCuAr1vjV7M3TJmC9L7410pXkQ6fylvP42b3T89b7rOmJvBkLJNpt7FG5hcxQYhlg8xmwVfztbFFmP6Tf+dK1OF6snZxUqs5MEhq1Pqlcl/pg6JSrFFmd6bBnKfwC9FofnSdv4rjsgq160yXRspFsR/QTP7BVIQ44k0TCMkqUAQZfk+pNe2rdTc5gZJeZi2BpNGi41XJxC/jEaAFwVDCW7jjaPyxQOBrHLMmSjz9I9Bpi9GTTvMLqBLuBRIEgtNATfD3bF4cVVuVOTd6kLcmX87aT/G2fay4ZM1EUNPekvjsoW+b9exVuJwiNbtlo1PPm0ty4u0AKpGFhlFXo1oZEBNcKAdW2ncHfm67xpEyaY3nRnC2UHxcKnosJ7LLHJStwIqiAhq2RRLTsHwyLGieaDjbECUrMg12/6bCmIwcQyR
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74a4cda-e1a9-40c7-37e1-08d7673ed1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 07:06:20.2292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrKMzGiMuFY1VZyCHfEf53SObji94RJvJscznMxVXcYeVocmofxOukspkbtVXqLI13Olwj9UaQ9vcjT+E9RnOJgiFgcvsy37Paq5FII77P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_230625_684441_C43B729C 
X-CRM114-Status: GOOD (  11.00  )
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

On 11/11/2019 02:34 AM, Christoph Hellwig wrote:
>> +	const char *model = ctrl->subsys->model;
>
> Can we have a little nvme_controller_mode() helper that uses
> subsystem->model if it is set, and otherwise the default?  That saves
> memory by not duplicating the default name for every subsystem.
>
Okay.
>> +	kfree(subsys->model);
>> +	subsys->model = kstrndup(page, len, GFP_KERNEL);
>> +	if (!subsys->model)
>> +		ret = -ENOMEM;
>
> I don't think we should free the old model until the new one
> is allocated.
>
Sounds good.
> Otherwise this looks good to me, but can someone also prepare a
> nvmetcli patch as well?
>
Mark has sent out 2 patches, I'll test and send out in the
mailing list format.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
