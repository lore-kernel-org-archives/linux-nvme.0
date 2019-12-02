Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789AC432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:07:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7916C2070B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y4fMOUXJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WpNJ+erh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f1JKy1dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7916C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DirITdE2l1Qaj/Lt9O2vCZ26S9nZBjKv0Cpn6NCuLi0=; b=Y4fMOUXJVoPOrn
	BTHr7nhhuELCaZN4CQGioOkoDhMYUxX3mnlysXQ0rSg5I4D3px3tKS63h+mYV+5d0mkrRaycnUCKV
	xJi88pCXqpVh131zk0CRgttfSA4YVHgGHE8iM6g+B6yZaQUMaCcC6RxeKHWq8T2JgGjkbcDBoOUM0
	JALshpIqf8s3pAyisaVDezS5agE4XjMtF5R650Rp1Z1nt3vVqKL7H09tEYGknk/Q/4tZEUlaMsm7t
	x9LAlUuR8pPgBQy5Y3speSSjuqcC3EoV2jPlyFszK6L4erpsye9IzkePaQhCFaUSvW4Oc9jM1kVpl
	thlFUKZV5q5+DlGo+wFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibtqp-00010h-AB; Mon, 02 Dec 2019 22:07:27 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibtql-0000ze-AB
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575324444; x=1606860444;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5z25oKGiFpWFWBInqCkjrGr9ZjkLDSONzvAz+oABEyY=;
 b=WpNJ+erhmVTA44/DzvTPJElDEi9y/RbllYOIObtcgQVTGdvGMsULvmj9
 szZK0pPzRFHHayx6Fm4vya3aGoeqC0re0QYAH2zKwIwnjf6JKNEAnIRD/
 9At4SV5WLMIHCj8XtyXRKASXUcPOOrK0sMQzArN1e94iQyLx7r2nUI589
 m0uyD8Gb6KZlg9GfMFnZfYhmUAjaAeeKG4CnNvlvjkeTCugr3gAerx9rY
 XrGOpW+iallVWWXBd2z0o+p2w+BVwNRKtfihdm3JFguAmiJQpNpcF4dEU
 RZBmvOEORHKi6hchD/TPxrstmJ/SBV+L4auw8OlyfbPoVwBuuOrdd32XA g==;
IronPort-SDR: u8NrYIzzLHkJGmZ0eaEi5YKUeLTT5Ao2u5P+dv4qfAawUf3vXyEpxM7PtGXOFRZiutzK1KnJja
 6PUc0VrABvtMq/FXawHUG1WZjfHEGEya+y4i6teLylD9oW9idm/+MpvetPVIhyFdt9v0JDUBWp
 hpXzjyQn3nhTj8IZfXTigmnfOGM2zgcXCYLIT7Ek8FVx5dkCe5M/fTxe80qovArJ0B1/bHgRCe
 mVa3AB/6soTAOlAM8PRZ6Oai95xEjrSonzMqTbEiQDa6kUiyhRSSTsx+IkEqG85X6r86lsyE+a
 ahY=
X-IronPort-AV: E=Sophos;i="5.69,270,1571673600"; d="scan'208";a="128876603"
Received: from mail-dm3nam03lp2059.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.59])
 by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2019 06:07:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNzOnIULYLxLLUOgmTREcwzN8zDQ9yz2/o5vdCDldXh+6UsF91OarXIdC1VbaKEdlNGEkIDJ5pl8x3H9VdDO+4g1yiHYfjWXvCjDqRxT+yOfZPXj3EWzVRbEL5Tkboe7JXvMjraM1vhFvZTVYqUvz+gJyGkp8RlRmi10Unjw1TqfzY1mNccOHL3I4lUYof0hOA0c2jtKDUo3QLEiBCODoB5L0/g3cy9oxXVfzE8Z16iSdo66LOIERH2uQm1X/Apo9OEINZkDTU5rh+rLEZ/B1VEeLaq/1U1/axMpOnaUi4OLYccgs5JMUTVqRXJzaifUWF/16+9N67UXnSnPGz1fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z25oKGiFpWFWBInqCkjrGr9ZjkLDSONzvAz+oABEyY=;
 b=UCyy/EV8B5MIBBfcEQRtylxoxcUb7kMHYaqooF9nHS2SK5TqHxy/2GkB1rokdMh3gyqAJNzpRcva86xLNuO5ahqZx4Es3BDelnR5aMmyF+bSgdYKxgBP8eO22RwKdBajM2kMSeZdtEl8sFmhyHifLZq5CmMDa6tJaFEDybuxAJbE15qIKMNB29BQKADPJXvBeTkHSYfBA7YyoLnkWnhaBmpflBkFyclRYVhiCGG3crtwwt+sDEXeA3O2LMs2aenRls6nV5pGXkbTo29xlzTNB4zqGEGD9C0JosLfxHeWGalHXh7RPKAWy0t7Zt8DmIoM1srJVBYHnyaaHPehbY+uBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z25oKGiFpWFWBInqCkjrGr9ZjkLDSONzvAz+oABEyY=;
 b=f1JKy1dCGRJ6Z861Zsrm8/3r6UQ7zqojoCBTe+7AZ6U8HaX4SYCCBDuLhK2rFmf0e+2x849IAUe0skHV6SHi1firdGF04x+OfNUXsKYZj7qOtbSqeKevmc7H69MGgjZfLrOgxC1libZEq3byH4KwNksy8OhVW4+fexPAtLlVo1k=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3957.namprd04.prod.outlook.com (52.135.215.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 22:07:17 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 22:07:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Talker Alex <alextalker@yandex.ru>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: NVMeoF driver & Reservations
Thread-Topic: NVMeoF driver & Reservations
Thread-Index: AQHVqDDATz6Lvv/jW0mpJP3WMDJMzw==
Date: Mon, 2 Dec 2019 22:07:16 +0000
Message-ID: <BYAPR04MB5749D5699EB15878C41F4BA386430@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <92087051575042507@sas2-7fadb031fd9b.qloud-c.yandex.net>
 <114736651575042639@vla4-d1c3bcedfacb.qloud-c.yandex.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eed6cabb-16cd-4615-8213-08d77773fe5b
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-microsoft-antispam-prvs: <BYAPR04MB3957179F78BDCBEF3E8FD85186430@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(52536014)(5660300002)(81166006)(26005)(305945005)(14454004)(33656002)(6246003)(55016002)(25786009)(102836004)(99286004)(446003)(8936002)(7736002)(2906002)(186003)(3846002)(6116002)(74316002)(478600001)(316002)(110136005)(4744005)(8676002)(86362001)(76176011)(6506007)(64756008)(66946007)(66476007)(66556008)(66446008)(7696005)(53546011)(76116006)(81156014)(2501003)(91956017)(66066001)(9686003)(256004)(71200400001)(6436002)(229853002)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3957;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWgII+0pC+VwezlNNEzw3ziSzeqWfBqknVNrWiKMKdMB1VzNM3+VgJd1GbNR3XMPolZURCAsDreW0i4pOZ09BXKPKuql9PhCuEE1MC3Qs3vmNuSES/SpEkzR0NmC/pmRBF8/GxC0qYr/fL0MSKqusAACsNk7M3162QSSQCbUiTWEm8qJPc8VWH5i3D7boDRjjR3mOrgaugT5SA8f49sm1jQucEOKjpgNNjE4zDOlPaTjJ2N8mED4hwp4vvJ2Hc6HwOP1hArJa0KZxjVOkW0zQhnt1vDJVp31T+Qv7mQDVI3UhjYMarlAMZOUydOkXkNii8naQXDzYBUOCWuZGoF/X7i7ly7xv2BQEoX25YLiDq1q1y7FQnaZTPb010S5D4lpplD8oouPwSd72n8DsDD0DngHpn0IReP2+hIGbrVLhdLG7C88/Wj+wdM084XRZybf
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed6cabb-16cd-4615-8213-08d77773fe5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 22:07:16.7559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoUCStsZ7ck+GU77XbfS+2WRY7qqZZcb6UmOFgs9LbXz2TOpaKD79zudyPkRDvWS46a0rIWbSsO+6agvoXpJF8phkeMHbN2grmavXt7nTP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_140723_434015_9FA16710 
X-CRM114-Status: GOOD (  12.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/01/2019 02:19 AM, Talker Alex wrote:
> Hi!
>
> Is there plans to implement Reservations support in target driver(from NVMe v1.4 part 8.8)?
> I see that host support is already implemented in nvme utility & driver level.
> However, I haven't found hardware on which it works - target driver doesn't support this command and PCIe drives available to me also.
>
> So, I'm wondering if anyone begin to implement this feature at least on single target level.

Yes there is and I also have testcases to test this feature from host side.

for target I did start working on this but stopped it since I didn't
find proper use-case (or a client) for it to justify the effort and
code getting into kernel. But if you have a legit scenario or a
use-case I'll be happy to work on this.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
