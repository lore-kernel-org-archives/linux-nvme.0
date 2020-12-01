Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB37CC71155
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 22:34:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5115D20671
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 22:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z70GWzJb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zh5Pkp3X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EixCAWvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5115D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=K9ecPY75kMr2vD53D8tsH4mnxPDqpL1Z1muTeSlVAoM=; b=Z70GWzJb0RRlDirT6dD13H6U9
	5Zr+lIPPCY/gt6s9Pi21qxy2EfO8O6n9TPCj9LYS/bxzFJltv5UdICPGc0h4api4VSYT8vmO6i8lA
	hEVdJZ8+jzPRFZH7zehu5EwU/9ujucFPOKQ7C1c5cij0zVwgB5u8tD+15sY1fn5wE9pJ6nMlWU+OF
	UAi9fNUXilQux8CqqJ22ffrsuco42purPDQLA3drBa9McCHkpgpgrEBx/gG4vWLoWMWLgiXEBYae+
	dsUIe4gHE80Ab2uuxufKdRY1GAgrS03st6DwEkPCZsvH0f0t3e3zRu3L6jAvrRhueEE+xoOOhK7iK
	O9dtkVNZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkEEC-00076Y-LI; Tue, 01 Dec 2020 22:34:32 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkEE7-000747-Oe
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 22:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606862067; x=1638398067;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=s8E17gOcecRKuQ9AFAtwlYc8Ab4ykgLsYpL3NqyLevk=;
 b=Zh5Pkp3X53QDB6IVqYIn+CZEJY8RUTXhkvK4Li7XqIO5NX7Au/zxhlvA
 dxNs0qi9h4qMjs4pSdtfhIPHM3YsWEz+UMo1iObpaAmRp/V3zT/sV+c1y
 VvlNtfUroaZfO+rulHNJ8udJJD9d+cV2+u/eK6But9s/WZAozt0bV7F3f
 q2dFbRwGlQUVj8N7Lh5avRx6qOuBRd9Paq2uPaXAEivJbiHHf0lrCUjQL
 7nVYgDFfD2wqS9CjMqizWIw1uHjr9uym8oz+2mY2DXkq3ecmBrlWQHIel
 LT0B+KXg70fq33auDpzgB7JvcU9oFv8oT7grq/0YJ0hAnLw4yZMWkq/ou Q==;
IronPort-SDR: o+6aU97CdKtWTqASEZy0JNg6svi7eer2O/hQQCHskJVTBq2x2c21x8dD72tU2YqWkGcjvdWZHG
 JTnat9TcjUWLHrMq8L3n84omy7JRWvfWDOgBBNf/SXeOHwmEA+5N9+zH6ybxhAgs5kSGc4Ub+5
 J/+5pUFqDhdEKsmenXPW4MC3+WoNmjzdcckKQ6YV5h3C2Ce0dr9w6QS5iQk/wt80XJuP/d0bHq
 gjpA2O4bFF/fQidLtt6d195hhd8DV6Z42nYfnoska773FDAQTZYek9e26L7iQoq+U9TCtBRTTr
 gO4=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="264092942"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 06:34:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXxyxfawEmTMOsLeCImPAFbY50+kmNr+Adj9h4tn7RtjS85/YWdaP7SqNWJwfUvn5Im1Bwg1hng6H0RVqH9T5q/pziuXLitGmLHzsX74qf/JKV6FQKQK8LMP1KTNWM9eg0JeF1jVzc/kGw4sn5Y/R6KZl3iHbB3xLBwFeTJuenrbJLP5YTLBOEoNfMO3TSFSXNX3WOFUf90JIzcPXbnyn82cXaCVlKkQfUjznJCaQLLcB2SS+KFRJg13JD2XPRrZIqGYIUvXKwG2whoHZ+0pUp0ib0ubUsep7XsF8tgAy73pAH+fxI4vJyjg0FN6R8EOHJgUhSIR2+7YzqwSj8eEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9rMPviZ9W3OG0YnxWWe3Jdk+aXjDZYBv2eiGeGKw5Y=;
 b=RvubwDLJgVfKstJNzuIIsLr/L/hiXRfI76cEq+7GCnZ9xNy0Hj1zmcfe0Q7SGIw/AUlM32BWhb8bUj7ObcSBRBBgXSGkhxaKSTst1hFfFYiSdpt3+V6S6GtaGvmgFP40m9OxueEXcKCFzDfAf4FttBU8ACzQqlV5EV9GUxegPLAF7RCaPJp/D9+SF7xJWLh9wfnvlOD1KfRGifTFVr7YEzxVB8W8X1atRPmTOYBOzTNyEyZxBapjjjcnWCEahBiz6uVsNBZbU+L4qK2jm+rB6zkCEfgr8YhQ/K1uxMYWOTrrrBE9ql23sqnOF8bkWu7l4ovpsREDl+B5nKFA1Rltjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9rMPviZ9W3OG0YnxWWe3Jdk+aXjDZYBv2eiGeGKw5Y=;
 b=EixCAWvpypWrU7MqnW5WV0NI0Vbqcjpll1iuBzl4SEREsLDE5wqJhoy/b8Y5Cg1CRXHdMDjxhC8/WvKnfbIZM3HJpyTy0kbIoqgAkEZy/SdbeY0//cfLESSMylD5tAyP/nDWQBnUU2cLdaGB90e6nNfCPJ6+MLX38SdciKiCe5c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 22:34:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 22:34:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWx5hxEAbfrfG/GUqQyO0qzymqDg==
Date: Tue, 1 Dec 2020 22:34:15 +0000
Message-ID: <BYAPR04MB49651C09824B2C82E44DB79C86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522A2943EFDF118FEBA264EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b73b2d1-22c3-43cb-28ad-08d896493c2c
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7261D47A043113D1F9D9309786F40@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mlZcalB3ByeO6COqZxQ5si11iejm8RgvGUu1nEflSF15S9iWahVfmt87Pa4nWImNu3FeereTWXhpg57skTLAeA6juvg3llc1KxItg6hs91QxrzdYtct6xf5B8jznBSFenBO+qg8/bq+/7RiCNQ9xgMFFv7byd8VbZluXTe8ssaU1jj2zN3RuOBChD/7WuWoJ+4fOYDI8PTtYs8fsAjTBOVxl0+dY9MJPVCdcQCRCiFiy+dK72NUuL+WSrGYRD9MWq2vGQSm+iHN93WxXpWvhDEnVX5J5BYc7UiKPi7g8h7Uhc0aKdVQrzQtDTJLmDSQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(66946007)(7696005)(6506007)(186003)(4744005)(5660300002)(53546011)(478600001)(71200400001)(316002)(55016002)(64756008)(66476007)(26005)(8936002)(83380400001)(4326008)(52536014)(8676002)(76116006)(2906002)(110136005)(54906003)(9686003)(66556008)(33656002)(86362001)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tijbzTgXg7P01iM/tjNCLg9SWCb8UNQqVk4TlH3nscWtuvEoTatTETznF6aW?=
 =?us-ascii?Q?KeXkx/qmHX6NTBwV6trdPHmuwJl3LUzJtqKx0wHy6c0WwrUas23mr43aIakN?=
 =?us-ascii?Q?pIf339vmzTAUp2w7LAZlXwdU8CiJZgRyrnEETzkiQFbDqNhCt/fPrEinEvLd?=
 =?us-ascii?Q?IttntnLmkJ6v3w+imkamcuImhxTfmdA+h47gH8LUupJ0+Uz0qoDIYGQiOT9W?=
 =?us-ascii?Q?a4AGcZUmpcv/E8EhQ+Q6eHQy1dV18kl7ivxWRtfODy91Fs71c3YSm3Y9uYM+?=
 =?us-ascii?Q?F2iOY8BGJO1C3CRIAwNeXiQkqFJek7+/K4Zb9E812eVihIgCmm+UK3YCKS20?=
 =?us-ascii?Q?oxzHTfYhHvYMw/GU+qkZJYR5AqVfREAWIpja9+o5i3OEU44GrSQdMUDgyVPn?=
 =?us-ascii?Q?kqdFoa9nN25ZLrT2am29VLT4+KDYN+GH02jkaHcenwRggAoT+zf6tgnjss7j?=
 =?us-ascii?Q?M7Q4w8NQt8R1zgcJO1sea9jNvLhjVejbd8tZ3L57WUHVnYUN2Ng2AjUThSnz?=
 =?us-ascii?Q?pF5uVCqrieFitcnjG7roo/YPHpBWdWKIcTvk2XqpOTyZqI9lQcAs/yEAZ2nM?=
 =?us-ascii?Q?4Rek2ZFNxflMFkSeYMfLsI7yZm0qRGzuVxrr6x6xAVp5s9rLzpcn/0iaAPVS?=
 =?us-ascii?Q?2SMpSOcDzRRkSV6/YPghvSe3Vm8eanxSgyTHvqohvK54dErIUaZmUIElCPXt?=
 =?us-ascii?Q?Ol/uzCK24GP3M2EeKM5H64PqZcVrxMJpBY7alQVrIb5LQSZcRdR0ZfFiYOG2?=
 =?us-ascii?Q?4wuNV4OV3BOBalJ2191aOGxwc6IkGi5OyNnHCT1gCBmswSLZePuxIkBK3W10?=
 =?us-ascii?Q?Qm+fIfSJ1LpDApmHQEs7jicQamiS2mYU/L99qes6CgFvJVbNjFjme+n+miMA?=
 =?us-ascii?Q?uAWmkIN46wlEyKUEKWvwWEvZ98JNFV6RiXKrGR4q2SwXEHP3FsOkn2alp4EX?=
 =?us-ascii?Q?YXf9MspnrLjqk6SAe4Y2bDDxFVGiT3obK8Eo3EDPA1BV9DvqrEzNtRa/TX5A?=
 =?us-ascii?Q?IW+l?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b73b2d1-22c3-43cb-28ad-08d896493c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 22:34:15.7821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+6XyRVVm3cOmEGY84A3JG1Na+BmwXLP9ih9Bbp7NKM+3/afBdmKqGQZg5XmsRpZouDAAAwb5Voz6FXFZzN1aFQGM6Z+drmZv8rS1MpAqC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_173428_080450_317BCA83 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/30/20 22:47, Damien Le Moal wrote:
> This passes for me:
>
> ./zonefs-tests.sh -t 0012 /dev/nullb0
> Gathering information on /dev/nullb0...
> zonefs-tests on /dev/nullb0:
>   4 zones (0 conventional zones, 4 sequential zones)
>   524288 512B sectors zone size (256 MiB)
>   1 max open zones
> Running tests
>   Test 0012:  mkzonefs (invalid device)                            ... PASS
>
> 1 / 1 tests passed
>
> This test create a a regular nullb device and tries mkzonefs on it, which should
> fail since the block device is not zoned. In your case, it looks like the test
> endup using an existing zoned nullb device, which should not happen (nullb4 and
> nullb5). How many nullb devices do you have on that system ?

True, my test script creates random number nvmet namespaces and nullblk
devices.

I think testcase is reading the wrong device, let me finish the V4 with
removing

bio checks as per your comments and I'll look into this.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
