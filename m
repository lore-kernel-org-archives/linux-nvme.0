Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9BC433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:37:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7FB20709
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="drB0C/sf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U5C67vpn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lhmfnK0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7FB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=EXcpQfvQQRsuVhT+56+wMNNaNM3clD1kok4odaWNKIA=; b=drB0C/sfjr3ypQ0jgKIcf5hEp
	grhl8RYJRGTJgmnxle8yW+Qa0WihWuvfFr2ezNOCVFaRX+NIADf9ndR6U1N9f9+/9YD6LHRU7052i
	waRe3Oyt0fuumTJbRvn3IvSc/Vbm6x9WWVIkM20Kd8cQgGHv9KNdqV+jtP9+aW0phCZDHyz5uP7ni
	oAddjxwQbAXSGu/W25sEb/Auwt1rnVzeGPZyWakrkH74DdsiDi+NpSlOXlYRs0zB0pET6ACGZuYYC
	KZ5wFsvMzXaLaNsdkjlr4WYSlaApPeb5q6FDQpGzBxyxfEHgEEXMGXkF4CEbEH43Q/UsLEft+7ADv
	wPSpDYkrw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDu7G-0000wr-3H; Thu, 03 Sep 2020 18:37:46 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDu7C-0000vg-Js
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 18:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599158262; x=1630694262;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=eJTmduJFhFfXzjgYHH/MmscsCQCrMHyjCQtDdBkBdzs=;
 b=U5C67vpnvecUJ3zz7OYZwHWr7wuK6L18GVtyvx7HllZbOB5wqw6+bLBU
 Yj86RU9Q0Byga8m99+r4HCVFpyENptqHIGL7+A0Djt1FxUqnqfxiuZXIp
 4nVHRpJ9zQAgvshGh8TNU+vSccxYriQv6U2Uvqenu610PTQtd9M838oN5
 NBpZuYdefTPwuNYKOtm5Ah0MMSjON2/KtrIe9pQGE5rxqPu6x4XADCGYZ
 QSRDgSJ82jOjvzcQcmx0E4rijbMPPxKujcD5oPs1fiLNwvnf0piGK/W/8
 gbk8Tm7T3jV3PKIsxDR6n41mO5F+x/sMoqXmZ1An5y5IrMOSfCqcNv74C g==;
IronPort-SDR: 0HCGsCnd+pPlCqmabiFynzx2jEbzE2i3YIWpyt5+NLIaFRy2YFjBsWgrsgjM0E9myXaM5Sm/P0
 zku/ZrcJus471PYradO8GK5UGuQ34dG7uIUIz8u94NMN3IKE15ylv9TLnwF1CWF79hWx7uXTVb
 vuTT7AtOUjXD7uTQTJQm8gaFJJrTZQQxC4OmdluniJTQondq47+6HYeYcHcUiyyjWsjnqRb3eO
 690zrYUu9gsWi9DZ7f0CmyTC1+fE05jX9mLfVNo3GVVf+hUn4ccLYnT4Y/48OIQRUInK6Pm8WX
 O6E=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="256069390"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 02:37:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz4aZstsmUnC2IXfoPwoZTnhMvHhi7lVeBYZUsQQqNu/IQ2NDpaX2OrfMTkxhrPY/BnKaSW8xODeUQSnYxfm2rdnVDKsHYwZTZeWpKesvuGBovbNgR81VxSMfVIvHps2dDJV0pi2hkvpCYox1FSQbHPMzpHYLHIH6UZxcZHiiT9W+arI0UtB0zgcAeW0ZxwhdCbfaWMPire6/BhJciBnoI98BWYjcCOz3VME7IJq81FkN/kyoQcklDUV1ciwYn7lP5iTcSobaVaCPVWq0/CAbCxGCnY8G4LJyh7TCh81ET+enaRCK3pSByLhhb06lZUHzdJaCTnTjQmrf/mYq9yieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJTmduJFhFfXzjgYHH/MmscsCQCrMHyjCQtDdBkBdzs=;
 b=HjkBAeLQui+EbRHeHK2U292P9q5UkulY0vD0749JVex08swYV9QNdZ5PLz+rt6N7/3+g+TBB+I6Aefgv3kXPpNfeQrf2B7jclrjqoCceasArTF8y28Q+eOr97vTuRatM9NJrJAeUspAw/KXI/myV2oP9bHqB/oB8G/SZhky9ljyf6Vm/frF4qBzOUMvWIhUqGdXOGBJ+AualghLXUgK4mUTdVJN1NwUCDe/Q1E81t2+xceHd3aoIDAYoauJmYedIvAwPZ0Ugl/pNsKpUfh4fG2WbbL2AnlNar9DStZ3aGVXBwiBoYo0nRg0MScGcB/iKACqJUPL5f+SOQ3LSkcsa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJTmduJFhFfXzjgYHH/MmscsCQCrMHyjCQtDdBkBdzs=;
 b=lhmfnK0g1PKSI2vzoEkNAZWYxg2nmjUoQy8EPTZ95G0kjMc3mXtz1sAL+lAtGYWmIJEZDmv93fy1fAR80VugZ0d5058lROigZIsTH8R4LfC2aUIS/0bei/LeKFjExeRikJ4MisEbanaVh/VdVasX/MBZxuXuRaMeBGThWXt1agA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5029.namprd04.prod.outlook.com (2603:10b6:a03:48::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 3 Sep
 2020 18:37:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 18:37:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 05/12] nvmet: use unlikely for uncommon commands
Thread-Topic: [PATCH V2 05/12] nvmet: use unlikely for uncommon commands
Thread-Index: AQHWf+XuZKZC0JDpb0WBtDtphVQVpg==
Date: Thu, 3 Sep 2020 18:37:39 +0000
Message-ID: <BYAPR04MB4965440523BCBCAD605B3676862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-6-chaitanya.kulkarni@wdc.com>
 <20200903162035.GD25423@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d04d9232-3dee-4bde-8c16-08d850386fc6
x-ms-traffictypediagnostic: BYAPR04MB5029:
x-microsoft-antispam-prvs: <BYAPR04MB5029B2C2A3FE05BC8260E49D862C0@BYAPR04MB5029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnHDZB7AMR9YhBwNoQan6zjy7tf/6HjEYPkKfn15E8VzPd94efNy/VBz6/Z67JRjnvecMlHlaY5h8hoS6arzwuF7YaWcM3ntNZsJGBchUFU1bU+EcHdY3KJqFOWWDU/0ms76SwMFFy8+20FoqIuwdyDdk+hAkId2/rBhJ2DkEsQjIB6XY1uCdkzE16xXZRyBqtXtOOfmkWb/x2pVD+yNJWBmI2wHqnW7QHoGtflWUUtZmvw1vz8XMlPFYhFf/GUhApXfhvLkJ+uUZq+TEFXKQ0lN8gfPzQx7u2Xg+TMEvhMOgJRPWSGosiTuCqyjSnGo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(86362001)(54906003)(52536014)(71200400001)(6916009)(2906002)(5660300002)(66946007)(55016002)(66476007)(316002)(8936002)(9686003)(64756008)(66556008)(66446008)(76116006)(8676002)(7696005)(4744005)(4326008)(83380400001)(186003)(33656002)(478600001)(26005)(53546011)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: tEN+JbmuckjvB5OSIxDn8TXutFT1nFzWmGV9d8sPj9v8KzyawJew5Qirn629zXxYEmdOH0Jh9h7zsgKM/t9uohiEOPUgAiXOl80IcnEGtQ09OlEW4VmMG/Tgt3TFWkPkJOjDSK+N8SWnN3kSKUqicn2/prY08tmkJRjHXnmxl7HVAlbtIn2L9kw0l7X7O9mHvBKPG2QojBjJCo4kuvR3KS10O1YVpx1bDExC86Hp5vgZ+p+JV7xenttqufR1HyoHw32xdVqK0y2b0IHlRtjfNnZWpfWpPdnG9+yt1/QgLWeX4DlExxGxHceRb4qmbAsnpMJqx3a3pYxE1PhtBvACE6GLEts4XXhrEJgwJDBNutFtXo70Z3+fpCNphZRO+64pui347f3MxzSyVhpO8sKpLe3uD0Zx8VrNr9/9mpi2oTHb855RcRLCRUSA7p8Hxr3Q0IThMnibGe0hwBmSGkp28j3XygUAHVqaBfu5Wm+ppUIVjwRbCZZvHwqNXUjKBvpc+1mDwFGqCuh2OqGEawFacT4iln6Fa6aJgb3HHVtZMTY4/oVq/U3n91aaUm2TSS6dtbUFygKdVy4udMYhbBWBsKWTe/sBe+/jwWEidmqJ4Cfo4KXrjXC4lCNtDyS7TMErfpMBt/IAEC0JsL2DTEXXeA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04d9232-3dee-4bde-8c16-08d850386fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 18:37:39.5459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTL7QCUjgTziCo1ah4+zhwaHTA57u1xPEwKIAWZn6AWsTJ5o+i9UTMcipsFYOkDjxGH8OmH0K5Xd3q6peVFYrvakqkZ8K4d+nQiNv5CEAWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_143742_917375_C4010F4F 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 09:20, Christoph Hellwig wrote:
> What difference does this make?
> 

Unlike the first patch(nvme_alloc_request()) I've not measured
performance numbers for this one.

I'll measure performance numbers and look into assembly with this patch,
if it shows any improvement then I'll add this patch in next version
along with perf numbers delta.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
