Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15927C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:42:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7E620748
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fSkzue5v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bzpv9aoV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e3JRMuuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7E620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=LYCbHvXAjDVz8gH3MEiHxipfXLkyW/l0FnHMg7rSdVk=; b=fSkzue5vHEY/vtMQBSoM3a/bl
	veI2QVFl0dL4UlF5Ey9v9xn7jLppa3q67NrE6+XBzRXq/OWMUJTPdfLkMtJNaAa1bUNr32uckmWxb
	f3cK/rqCBJB87Rc6d/EiXoYacgPzKf5LpDtKqRxdY89/oVlHdHf89ZH/D5cZ5QwyfHtymR1zsusLz
	7EWzsEjENVWRZx1813YaUtRtX3haNsK39uwv0oK9NBfo35f0BnoeOMNBK0eu1uXga+VaifAq6WR2U
	mgc98ooG5SlPk47fGqEz6kywcikOgad0DA55XHCEn7kbK9puzkmTjc2BHAvCMS77RTYdj1alJz8L0
	VvK5789CA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqhgD-0000Ji-UY; Wed, 01 Jul 2020 18:41:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqhgB-0000JG-TA
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593628915; x=1625164915;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GSJfV5ALmGEsJEzUSioD9AsJ7Ti7CJQmRtVWQTYZpIw=;
 b=bzpv9aoVr+ulqJAP9XOctGW7f2dvoo0m2sBOFpD5iUzdR58XsGM9V4/h
 1J8XBZRJAgIODp0imM+qyu9/gYGTtykfMw7O7fKSuqjIYp7UiFXukE+DC
 4NFfazF4xsS/jAX20vu7ZP7X5ZG22BWHbX8EG0Xugxo+vlAoY4FQthi9X
 JEKtBywdzZET9DbCHn1/lv9t2KZ/TbykDn4PDGhP+/iisGLWnzlHiKQil
 Lqp7TmuANcEwMe3hBTt9fjEr+IvewW37a+aKdEMjeO/ijFnmyhVXFcNNB
 iTUKFYlu6uCLICmMUeZQNNSkS0wXZ61g9Dll1eGzzBM2fsUDCssKM5WI+ w==;
IronPort-SDR: wiRU+1QF1K3LSKqqhsRWUX9ubvpB9svjBbncD/+T9a4gjCUEWNWhdTZwsnNgdObMlFFKJNQop6
 zLpe7OjdnQBxSZoIa2Hnw1sP/fkt37glQwK+m1JHrnmgAex64LR6tgpEHAqeXapvKRW/oJchiM
 w4TIUHi0vT4f2kg82Gp9kRRVbFajHLJUC2kcdlrUMeb4nMHgvWEl8V2pJTt0Y/oyW8N3diDSal
 wouUEQl5XNAgdIzh4EPzjywb3TO9VABBARBFmkQk6Al4h9TDYEvvhRE69yNzqEleBrOcONJbTV
 eUE=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="250642522"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:41:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+vJvLPIKVyMLe6ExZUK4jY7bYhpI/ikdM12J31ZKgNzfIb4yloh4E6tY38aPiMJ6sOMRx0m9YmHmZMb5584AhM2TFpWrxgH9j3ws7Vb5yN46BopwRG1JcxAg86L6qSSEHBP2ZZwWYVrEGm6eYEBBZTi+hGOl2KVERzabDbmwvBosZ0gZDaM1K+17kP50u0G7N4FKi35HFp6ZsCq/MmyAIz3atjBlMs0I+dzbiA4qULeTGQoMFBQwBNn/m75b7P81gk5c64lqUQ1v5uCHxDQBbk5whr/VhqrINeBV0JBeGQvKMi+nUyNg6rafJpsOPWcMvsqr8l+a8p/c/8Fe2yOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSAFU6m6Qqi1BDKcKfTSQdL9cmTTHgFYx/p/rP013vg=;
 b=hFw6v6++Bd69wIgvJY7mTIUDraIXBq6YwlX2Q71xuaVzVyJnwcLnP80b6JHXnU5tUb8792pMaeErMjJtyYBKojwS9sBVmreA8OdcEKxlQGWYOoU5sLYKOSZUnGHt/VudHs9WtSigyti2/xtuGziv4qD8Tv2IuAwax9DiRpJIxKqdxe378QKzdKlSUXJgWJIFFLEpKRotp3y6IudcYsLx+iGtMfQy32LkVa6ofyWH90LYbeNGvn/hTn6IyhEfUqfXONZdC158pTF3byDvMnjlJjXJ7bA99awDxuD1gXmOJ8RkQOHoJFa99KiQXUGZxn7aw+kd15WkolZsOh7jUKhuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSAFU6m6Qqi1BDKcKfTSQdL9cmTTHgFYx/p/rP013vg=;
 b=e3JRMuucaHj5aZrvA4bPvAYwEJSCb7MV8+S6b23l/mD8voYJReRULh+UhfK8hW3+JFCWPnlRo/y1xFLPnyZ/rUZNbE5ajK9WJbmrlSEacp+KbfzTrUh0LJQ0O2DdyCndW9InpysTZ30AM3cFXtyqAnyuJ/2VPv2MrhFE/+Zxmio=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5032.namprd04.prod.outlook.com (2603:10b6:a03:44::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 18:41:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:41:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Thread-Topic: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Thread-Index: AQHWT07f2kc1pYF3pEmTYkfgZJ9VFQ==
Date: Wed, 1 Jul 2020 18:41:49 +0000
Message-ID: <BYAPR04MB49659993C95C927B7DAB78BA866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701053609.GA28056@lst.de>
 <20200701132137.GA1988944@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d795f7a9-3413-4bc0-5812-08d81dee6a1c
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-microsoft-antispam-prvs: <BYAPR04MB50328AB33A0BD550AEA936E4866C0@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9sbAYoSrgqgY1RDYoPTYtrwP+51BczIE2JCV0OcR3wm+VSNUoxW+FPeIwL93wfChC33SwIi0S7Yde+28Q9+gcqHs62shT1nV9+eObzZZ5/wX3jvUbkNa35Az/F+bltZ9JDUKlN4TIMmRSXPyfWW5uGcKr/B9i2SL8e8XTqBY/Egl1OTtsJCDM9gVronQlioKT1obDhbLgUW55ML2PqvF/M+5sWJ398QC4iqcahfM4H6IrrSU4utydEV1/GCfogJlRJO09reaLhPZsqCCuT9dTYAi2ZltTR0CuLYNwOq+8sUTZlvZEab3s9I1SZW6mhti
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(4744005)(110136005)(8936002)(33656002)(26005)(86362001)(8676002)(71200400001)(7696005)(6506007)(53546011)(76116006)(4326008)(66946007)(66476007)(64756008)(498600001)(66556008)(66446008)(9686003)(55016002)(186003)(52536014)(54906003)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: eFPwjwq+89VYZYHO/SStoM2MxkZMBw77cIsIFd3KGHXP2unbajQdmuOKSYVYSo5nfZDjF2Q4HkDZbzzBAb/M2EtqkaURzGgtSrbLW2tDS9GvCqtOVOYg5vLumd0TWINGB8iqRYdJkXcZXoatLLO9KvAKAswICtX6whvX2TR0CWHeUWgyHqAjf4NLukP+Kozs+ooAxvVd7+J1u/jkc7HkI8ibLkU1LM/5cyMpRhuqKi/dzDF2KmsH8HznBDQQz2MV2XHmjSUFpbunL+pVemhq9i9TpQzXY8xIYxNMtkrH6n+M/YOAw57ktDUozk2ymfLgNfAKou3lBUl+zuuaCh/lJF7NuMZOhsiUGMroGEATaEsOnPuDcKWKCTJuNSFNqU6VyPHlceD7aeXp9Dtv3Tu/t3Vqf1V7pGnsdTvrolkSdk9jh21cAh24x4CzeP4Mk2YNHuertr7Y+jj/Xw8uaLDlOnhhbC45ga9EjJPusYAQ8cu/7lLSCKp02Q9YcpekcCSd
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d795f7a9-3413-4bc0-5812-08d81dee6a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:41:49.1790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5k6UwzEaqDHEcnKgCjiLjanjmduhjkNMqZjveLaV6imokYNUwfqoA6fU2405/KHmONnsLUWGd9eqWsuA7fZYiQW/usIiIPJtJu0x4+8dM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_144156_106964_B1198440 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/1/20 6:21 AM, Keith Busch wrote:
> On Wed, Jul 01, 2020 at 07:36:09AM +0200, Christoph Hellwig wrote:
>> On Tue, Jun 30, 2020 at 07:25:15PM -0700, Chaitanya Kulkarni wrote:
>>> Hi,
>>>
>>> This is a small patch-series which replaces ctrl->namespaces with
>>> xarray for host-core and target-core. We can see following
>>> performance improvement when running fio with 32 parallel jobs where
>>> first 16 namespaces and last 16 namespaces are used for I/O. See [1] for
>>> detailed performance numbers.
>> Why would that make any difference given that we don't look up namespaces
>> in the I/O path?
> Not in host side. Target does a lookup on each IO through:
> 
>    nvmet_req_init()
>      nvmet_parse_io_cmrd()
>        nvmet_find_namespaces()
> 
> And this detail should be mentioned in the test setup for the cover
> letter, or in patch 2.
> 
Yes I've missed that I'll add these details in V3.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
