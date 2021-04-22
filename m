Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED9C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 19:12:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E520161004
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 19:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E520161004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ORZxlb1YPNdpUryanAvpDqG5Gn55ly+j5AVMo7SFmYY=; b=P9BhA9zCbeqzy+lFe2mbwnDCl
	Tuiws5hZV3e8SoXAebO1hzik9mEu5mbucxWDx+i9JhEI1SLwdWFPxsbwvvFflUXmkhTpdJm19IoWW
	74eG7PEFbYYwrFPDZtIgWThQOx40Qo7q680XSCByIcFlGocgQkRTHDuwlTzND0Bc7py44wN0fKtVN
	4gXbH6aoEAQLJ1MJ9KAYTn8VBqEtaOkTkDjznUBQER13qoEQaEqtJUj2OdrfZr8jKqj0O5fZpaulN
	bdhiflawAQ6ryjVuzw1f82y8s9+TwpD4jSkSuOJO0szUWr8LTbKqbGwv/jdndcsR00QNx6flAiXl1
	0UfQM72QA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZekH-00HIow-8G; Thu, 22 Apr 2021 19:12:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZek7-00HIns-5G
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 19:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=UsVYKxccg1jlA4/9bbX28mzqYt9OU7Qi2664rKV/fn0=; b=0VILC2OFf4L6GnXiWWQAFYEg5P
 Lj24pI+7ksBq/PDLxf3mltStaW5TZ+DOgv4gAPVYbMAQAvv/zRSN6/BEeE1MnzvYuKUMDHFKjiCdi
 dt4W69cvxLoydOhqmVZG1ZImYUb94wLSXPJBMYqHNlquGggJOhAztrnawWO9z6QbWNDCVg8Z3DkQu
 oeTSCUt7XRNc7fnagnKPtP0ZbI/FYMwE+DcD+NkDE4jONhr8E1MB7GQGNZwHj2tH9fJRx64pNCBlx
 RpJK1yuYd7gV3ZhF9nKceoDXi3hjlwjcy+h3Ye8wQNfPXBiXQWKJ6x+BAVtQLEH+0qJZ+EIKzU/qL
 yd3CX+LA==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZek4-00DwKq-Cd
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 19:12:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619118720; x=1650654720;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5TQ2BqGRdq9YYGkeACHe3IC65Rk9nGgMyxFBw7WJfFA=;
 b=g+BzmofnhXiXF6+D1xZXtMGiv0gPfo+0XQz3mDiRF0rzR0RaQtGQSida
 WMOUqjRIiNqGcX3D4X6pk8M4l8Xyy+JQ73un5cvUol1dCD+P2K+cykIxR
 Ge6s6RHjYg2yRk0xMTj58av7fzEpwdbaagPDmNFHpjZSXouTEUSVuFQWY
 9pQMk+Z3KdV5bD7kB/iuSE02SPvIA3NFaU48BN1O+opy0JaUzQBW6YWLP
 Uqqhl6wWAxsrG3vHUxk0b540uWslPwbHq06SHFzHqyeBAzgBn3IBuMMj4
 yYIeBR6uHkD9sJcfdubeMbumFfeQLoTK0q+GUaZ1skOCYW9IkxavTOL2e A==;
IronPort-SDR: JBixiW16b/gTsChzkls636QFuhKjgnMJ4v+FvRz0qjk5aV5AyjKS8kQbL1Xe8ZskQcWVqLNm16
 RPeNRb/t+SssmBXaADWtYh2QRryCjz6zNIy0dR7zu8i5Sr43eBU6D4UkaWHw3vQToqEC7MOWtI
 eDWQ62t/8FsEY7B3FR/M/i032YgFqtLpIIJTo3Zu39DCC+t/I+dXyXWFunI7SIZUJWuGw+avlv
 39YChJgzkm1d/W0TmDkXk5VEltcpCryML1SZ6/5nVsHNb2kX2l2dzwH7wa/QBADdqExTEt67L6
 at8=
X-IronPort-AV: E=Sophos;i="5.82,243,1613404800"; d="scan'208";a="276894839"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 03:11:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrWlB+gYv381FBkmFctbomJcq+JPg7b2Av02YDcGSpdSCeKiMATkHJteZA92aC1OqEzKGUgXhMnpIbeX+QUPT60iOEVpm0oxNnz5yjxvi4eVQvRbPIs7eGzkdOPs16DY6CobPhSejUQ0q3vLVGpQ1C9fezrxwRTkcrS6NQpjC0OA1CGiLKV7MQg2Q6QGFih4Xh+FoLcphWHQNEpaffclSk9JBAiojfJQDfTlGpN2g9tgrcRqko11z3ZInbk0sgUjuUGqP2a3+EO9zdit8bq/HzECZrlvLE8tiqTwv9vysx3jo6SKuj6Y7Prj8svSArSkyNfFktl6XNu91H7HKi3hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsVYKxccg1jlA4/9bbX28mzqYt9OU7Qi2664rKV/fn0=;
 b=Jm29Y1bwXNSX7DNBYg/xKxWXL6JezCMf8BnAqEmi1e+rK1MFYaltLrJ7lWqgq4DJguWxAWPE1z4kfmJA6ad5iJn/k66quoO9B2Ednp9P447DUbN+J4rdslnpYt0X093JtZcIZI4h+QYCj1m1eMaNubLlg1Fh3brUyDGvGY35q+xSVvgeLAKVt2ZbO2SF06dz3ONDE6Op9zKcNy8khQuG/MHj4ALta+3i4bP0eBy6NCBbcRZ3qqI7LZuUfHzGhoR+gko0DYnZn9EJqQMKAriKckbeuYS0S3yXBeJFYquJAUG3GOg+uipCXIh8mRSQN0QFdzxkDJVEyPiNghUZNcEsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsVYKxccg1jlA4/9bbX28mzqYt9OU7Qi2664rKV/fn0=;
 b=OoRa6YJmFp/n4PjYa7tcVvQAd1/oDIBlGY0CeGfsWeJmcP0wfjv5YaADodWcTpHQHuuq9ah4qIEz7AgjoNJ7wjBCETSsipQL/iefLVrAj4Wm54zLG0XDlDcif2l/EuavQanToGElwGaAXPGUA4c1nj1J3Id0W7bHZp8O5+HMkGc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5334.namprd04.prod.outlook.com (2603:10b6:a03:c8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 19:11:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 19:11:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "oren@nvidia.com"
 <oren@nvidia.com>, "ngottlieb@nvidia.com" <ngottlieb@nvidia.com>
Subject: Re: [PATCH 1/4] nvmet: change sn size and check validity
Thread-Topic: [PATCH 1/4] nvmet: change sn size and check validity
Thread-Index: AQHXNcTWJAYbPxX+WkGAFV7uzYisZQ==
Date: Thu, 22 Apr 2021 19:11:56 +0000
Message-ID: <BYAPR04MB4965DDF464B5C48961CF6C1B86469@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
 <BYAPR04MB4965297F005A2E8EC059606D86489@BYAPR04MB4965.namprd04.prod.outlook.com>
 <bd1e5f26-8eda-d784-ff00-686190ed68b4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6964be5f-370f-4224-74e5-08d905c27f49
x-ms-traffictypediagnostic: BYAPR04MB5334:
x-microsoft-antispam-prvs: <BYAPR04MB53347768AEB898C9662091EE86469@BYAPR04MB5334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ox890gWN3DPtPSYwZg9SsSusVx4Ds60J7Io6Uk+GkijoLVtbLxhmmYnK9n68J/hNdFxxeNwK0HnuVRnmirT5p4gM3kukCGVKDiOkG2N03hWCTY8PJ3Mh2K5yRE4JJDO/QJMDQ9elYSpPciOVop+rJBMppkoKDw1sjcUh6ZUav2vs/9y1z4n1q4iYh11dS5baAlVdjgJ+qinwvJ2dHoCBEZh/jDdf0IGR7J+oLtH9/cuOnitO5r/YNhXOQZohFNqvnmSqBqlinORb3immWcPdSh/DbQNcjyvm7VfK55SC/CA+tp1TwbUb5hJ4+aZIyAgt10cPTyWsS1jHKLyGgP0dj0oh3GP3VkVXTyrjMsIoN99RtXWJOI1bxvl6fEYNX6m0xbWGvOY2TILE8zyQ1Bj7PZIfWRqbEcKpmDrjiuJBZgScKb8GLlIHWKxn+WbbuzXRomirQz/hQ4NXeMeT39hwlIBw/s3WWcAg405CkOtiV6r0Nhmmc3SwJemYEXs7B2M2O/KfeBCY1OgD4XV8Q/W3YnVQnamj09Op6TZumB52rOO+1tBNgBwaX3ZSQYEEQZ6jOcfHBJ5zoDZflNH9m62VBkBw4zbtlvv6/MD7hRJDhY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(55016002)(38100700002)(316002)(2906002)(5660300002)(186003)(4326008)(66556008)(66476007)(64756008)(4744005)(66446008)(76116006)(53546011)(9686003)(83380400001)(26005)(86362001)(8676002)(7696005)(52536014)(71200400001)(33656002)(122000001)(66946007)(8936002)(54906003)(6916009)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yQ8Md83Rc4UcQja0/WhSLN0EEg/BJ+kP8AvwGq3Y0bWVUp157pilTPe3BrgU?=
 =?us-ascii?Q?2LBiQX2pBlowbHulIh+sn17Lv+vyG7LKiJIPBjVkmq4xx8jaPaEpVTEEcrdt?=
 =?us-ascii?Q?ogW6SyG6WgGXFwDP+nLCjqkJgr11jmpHpeqgCJnvnuCZQDM5ujDC36xdVssb?=
 =?us-ascii?Q?GhlDVmEdf9Un4pn6ptG2YxVxwKEv3zHWIXbaIPk91fGACJo6H6kcuhT9NMVe?=
 =?us-ascii?Q?w4FgmQxaleI6pGW5bCuW3lbp+RiobSHxFPfBZsONz/mkRj6RWxndvYS2MQrJ?=
 =?us-ascii?Q?nxWwBmMkSV+gtGliOSK2JksNNGa0az9W7LBu8CA0L92i2uTSHzgNmhblwF82?=
 =?us-ascii?Q?audRbjcKNZEe0ke22Qg/rr/THc4Vb5dQxVq9r9d7hfnFu6EIJHNR4ESfEsat?=
 =?us-ascii?Q?6B7hb62A733a2vs93ASwyhp1rG0kMJz4SIVqEmmxBOjq5w1H5M5k+8Oxy4le?=
 =?us-ascii?Q?MIFSvNqAFDuaGJ2rPew1FdM00B8L+soU1zCGLxZtboVTeR5MqQpfFeKV55SV?=
 =?us-ascii?Q?BXo4sf05R/X0/HfLAWpb829Ytne93jpwHEQDDRgIDo9i1QcEYPrfQ6obxXGC?=
 =?us-ascii?Q?2Tdd6+3moQeW0F7XSZGh4kb1aXNdj52Q93nU7uGofA/IYjsQfDBzd6AmrfMb?=
 =?us-ascii?Q?c950zWSTH2uKP9McEvgZOtzUdtbxIrkjpoJx3p5Z7Gbwr9qx42nDYcV0r8tA?=
 =?us-ascii?Q?++TGMUJoYELgqenPZO3TupKgcV1tDgvXlAw1w98giMUEPsj02/WDjekNxROa?=
 =?us-ascii?Q?nxEEzJUXJ9T3mz9XixVye7b4zr6Ie9z03wv4sH6OPNWWzgwJ+jB7OmDmHFjc?=
 =?us-ascii?Q?r+H1hrXiIM+JmBKjrHzcyZQP4WvG4oBjFWHM0Pn2WV8NCmatmbkB+dHpmehj?=
 =?us-ascii?Q?/8PSteYK/ivghcyKXz4M0nOwGV/ytL4dI4UUoZbJtgXkdgT+FiA901ex+re4?=
 =?us-ascii?Q?TmT3cLvK5t4RdZLcLfo9iyDDpI4nE4WW0m5QZCfUbAEA4UmPYMDp+lVPRy12?=
 =?us-ascii?Q?aXp56VylFZIUMWMqgQxfKazhPFzj4Rvf+PyWsTo7pKPMSq3QdDQ7DvjGC+oB?=
 =?us-ascii?Q?U+65PAg/qDjkkY/56QgHsTXASgNtojQ8tgv2xXQfzeg1e/bGcoL5EgaZjDab?=
 =?us-ascii?Q?NsWxgROeJbz4Q4epNjIeimjt17hDlBfNHpJfVXXEFrJ4MbYfI53HSrMQv8/e?=
 =?us-ascii?Q?QOvXmwhE50AdrN0rn3BTFELccPmgPkqVOOx4onopmt1YhWbrMnU1l8eJuIDJ?=
 =?us-ascii?Q?gLTQQSJx1JfH81htMJQ6CT0FLz6N+doWgQH73c+/0Y3v96QauQyv2bysyVMc?=
 =?us-ascii?Q?ntMER6JAuDO3MO6VaD4qTcjT?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6964be5f-370f-4224-74e5-08d905c27f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 19:11:56.5961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OSj/bmtBklaxoB8Y/G8eKdMgf292AxXAWt5vKiYPTeCC7X/VV4beGNfdVLqE7iAGDPGbupfzwzmbHf7nahmfkYw6op++0baFzwxrTOS9kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_121200_465442_0866183B 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/22/21 01:50, Max Gurtovoy wrote:
>>> -/* See Section 1.5 of NVMe 1.4 */
>>> -static bool nvmet_is_ascii(const char c)
>>> -{
>>> -	return c >= 0x20 && c <= 0x7e;
>>> -}
>>> -
>>>   static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
>>>   		const char *page, size_t count)
>>>   {
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index adbede9ab7f3..3efd48b0a34e 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -1482,6 +1482,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>>   		enum nvme_subsys_type type)
>>>   {
>>>   	struct nvmet_subsys *subsys;
>>> +	char serial[NVMET_SN_MAX_SIZE / 2];
>> This needs a comment why NVMET_SN_MAX_SIZE / 2.
> explain bin2hex ?
>
>

I'm not sure, I'll leave it to Christoph and Sagi.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
