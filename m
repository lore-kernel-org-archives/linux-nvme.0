Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC03C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:31:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C84619B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C84619B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=j+ifqtJsgwwHvoGY05UTHOsA2wNmNGSJ2ZFCziwF5R0=; b=Tx/nqHXpDBaidaHooqSysKKM/
	pEtr1YXbtnXO0OcTjhV7uM1jZ6lWxaeq5LIy1huMwyVdM2mAXF3Ta0hQMEI0rXT3unEEejMls8Gt1
	Quaz10/LVf6R7RB9ZtVY7dfuLNotvM3HUUoJZHuPma8WAtVG9CtAxeT5FqMLecti/BXhXHLY2z7D9
	IJ1Az1uVzliZGVoNALxx66fj+wjC5ObgYKqmzj8FOo2B/t4heYEko71LgpZ66KOvQBqgHSdfrkYI3
	UPUP6BtjdYl1hXjG0ihK7VQGSlP6JyOGl0UoI+P13/YHgSYwqygFG72KDlTprTJmBIJtgQ40o0Z6e
	zSWWtPJRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRNp9-0057ZJ-2J; Tue, 30 Mar 2021 23:31:03 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRNov-0057Xy-0s
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617147050; x=1648683050;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=uGEOFO5qQNJO+iq4+dTTHBladhtamawdCuZtmv3EWJM=;
 b=dkXuHgas6dT6kYdM1cpMJkLSrwSTQkW880ZlH/ZkxCG9mLoH1f/HIEye
 ogP0VzdznTC+CAgfkuv9M8huzcKHUSkPPqfSv3VQxWHLmZoQ7sZD1MbiA
 pBB9XL8AQhgdYTsFGd/uSf5ud/v9SFLEvwXe/3p1xefXTiFA+kIWc8Moo
 ZgR/dI0SSWEk3dI3DtnJ69jSPRg6VWxlVETHVdDlsB1nROLAwHEoXv/wC
 pIBcL6a8Nt1LR2M2YY8VORZ70UNetXxbWZhe6mcxZ6UxWoyM7hwgzdv50
 W3jf9Z+Q4rutl1yD43rQiv2t+kYNrMJhkzxZSTn2ZrvW86XwltZ8EOf7Q Q==;
IronPort-SDR: f7JNxHx8+4cmg7I8LA3rZKy7Bt90lzKOfM+TJ6XvijOpJ1ZCumgOMhjKhD6yJ3C8UiXDXUT3T0
 DDm/2SStCxKFC+c6jiJ3spBBuBxHYisqs/HvZJ/gqwOq5e3BeKOYdhZDs53p1UrTOpEmWaLynb
 LkDKQBXBwk9s0lIIBACB3OgIfm9IyUnPzP9p0dvZrxWdGkzhaIcAR4EFvUGcHQpKGT8JTUZ5gI
 5Yzj2acCrV/pLBFguG/mY4iOxMNYoDGdEZxhiPO9IRCX3y5ZebZXsWfe+pvU2KFRO+xSnqGw9f
 T5E=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; d="scan'208";a="267819171"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:30:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8LZ9O9EUw9Tf2uzFOwq5BSb+foSPWQ7Qd5Mvs3beDoMBeVouHfKsvlrlWPbR2kzBJ70eI99hsZw27yN5lX8rWr8tSLc8OENoHn5oOgUX3oiNbAaF31Tmh8VNcWo3HzI6ljLaW28A5TAq2G1kHlPk6PRi2WhM6tcsXUt2OleNszZcZHjZMe4/6BJpww8DE/0qfvZzfpNr31w/mxQcMJ6j4XgpUFErWGVvjw5SFhkys+R5pbmsBI880OGBLHqm8+waWEakku8IybjaJdrJymEYOcICPMhfb8lITDnp9gDAgYkzvyarDoqSw+w2/+9JJrruV410ThUjFM+as/WLTPkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuKUyd5ZS+X/+5dO1CgSF9SWnuQJ7R8jgS4H9RBCafk=;
 b=RANTJBvM6/Fw9wz+CDHRViXBlaxZ0z4/t1+eAVG70hHCg32c2SNeqASAH74mli97my4eAs5MAfHxVaZBfmCuxjdQme0Xt3SF7KV4xSvg699vhgochfK2bYa1f98/m30VmUZhZmMKPlRZ9FWuaGu7Bki33EyqQe4c+0jibpUvt3fLtBdmBkzeim8R7VAoim+uiQIBV1qS7wS7nR7SaSEigxEXhY4rOEw1IqsEOgEh1kZLhDYCoJ0HtBLgQeplF2IWNhzeG5QXuFb10AmxB5LFRAoefiE1r++50va00T/CStanjqdzLfjKREA1WA3KjSuLb3mQGz0yJSWccplHa7YGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuKUyd5ZS+X/+5dO1CgSF9SWnuQJ7R8jgS4H9RBCafk=;
 b=E+S/H9F74ZOpCZ+5gYuwhwpMjbOaLjvJ7hEsV1qknOUgspSkararQNzORdIZhXuxMk+B8QRXmMDLfFBHGQj2kzh0MalH7VIJhNL1R59T2aYSrH98IzCYwU0nClpGHNXLWVJvc9J/wW6BNhh/dK2hONT3imvEQNhgjycYgb5mKlA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5831.namprd04.prod.outlook.com (2603:10b6:a03:10d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 23:30:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:30:30 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hou Pu <houpu.main@gmail.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvmet: remove unneeded code from nvmet_alloc_ctrl()
Thread-Topic: [PATCH 2/2] nvmet: remove unneeded code from nvmet_alloc_ctrl()
Thread-Index: AQHXJVwu9IEuRQM9c0O+ybFKv9NEJg==
Date: Tue, 30 Mar 2021 23:30:29 +0000
Message-ID: <BYAPR04MB4965E59C632B8A45D015B4EC867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330115907.15432-1-houpu.main@gmail.com>
 <20210330115907.15432-3-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7508a7df-da39-4d8e-9e3c-08d8f3d3ce71
x-ms-traffictypediagnostic: BYAPR04MB5831:
x-microsoft-antispam-prvs: <BYAPR04MB583162E7F73ED3953B1C542F867D9@BYAPR04MB5831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:250;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CEddVNZ1PLnTyEJLDSa9QREx58ajJcpO8xCz4cM5/rM3v8Ilmvx44DAZzPPYC6XHTrhSAnrpLtrEzyl4o7cVK3BLleHRBp0pFg3mrq1euNyNkinHP/+Sr+vXCIfAlZ7bPCu9CcMGtD+RFJiye7CcD4VFZfWTiXCJo2HKHREPi2O1lxBI48phHyWMVdU1f8LmKzcLrwf2Gj9ds52rwOfWx75EDTh7NjZe2w12+pWODOq4k7mL1dAUbtRe9zqSEo0PLbvvx71OhbTvkhjmEO1QDEFfMcvsgO2J4KTD/g+ONrZCgZANjT3OF09NXE1cy58zJXG4/k/HhM+RArXMPHHSikRwBNA8l1YeS7UKyZ45JSZUrfYbq1kQm0OiywALirPCMh7VvDfiH12l0C6672dCQDLg5hz4JwS8OuoazuuWnB0o64dZ62CZcIbbh3qSgQsDDKcD7ObRVb2zeKKIoU8L2hnJkvB6Yz/ENo9mtM8gLIKQzJ2NlCnWMD8VjwOxSfrVVSBgp3GEMmcsnq+PYb5NF9r2OGnNhoRE+FZ3Sc3iOjDTVGBs73Tbyi+zsEkAMHiZ4uw9N18InhoEj2kXtcCQq4/oqOXWTpt+Qcr8krrabQZXJ2dxImEoT77Jq7p5uUzsvnAPFglmMVHVHwEM0dFhs+DnazC8Q2mN54fgdx72XI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(33656002)(76116006)(66476007)(66556008)(26005)(186003)(64756008)(66446008)(66946007)(71200400001)(38100700001)(8936002)(2906002)(52536014)(4326008)(478600001)(558084003)(8676002)(7696005)(9686003)(55016002)(316002)(110136005)(86362001)(53546011)(6506007)(5660300002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jKUH8fwyH+SJawl6i7iubCDcqIp9YqZa9es98z1v6cb+w+VgsNNpJVi48SoS?=
 =?us-ascii?Q?0y+uieEkkmRH6C9GYHhQLGQjBW9fKBhD0k0JNvz3OwA/DydhWBF5d8clxjI7?=
 =?us-ascii?Q?+d/Q/VygJ2CDpEa7QcJPjc5XsgkauoJkOQyfE9N9aesrC2nBMtsYlBnEQilA?=
 =?us-ascii?Q?zFMrsdi2bvJ28U0/Wj2MaQ/9CR6bjxqK3uHVxtUf/H5Iu+GCp2ROouND4j3H?=
 =?us-ascii?Q?DPHtSTPPe8/KiTX7oArOlyxHXhr7y9KZaMUusGiFszufIg+j4PPDnJBvQi2/?=
 =?us-ascii?Q?gZuLYAVeuTl9p+hgWZKxt8EbNPBVafBLfrYdrx7g2cRycpXGCj/CyjkOgDYv?=
 =?us-ascii?Q?6zqkK3UsTSNVpsxHwQ+h1s5SrlSNrE/6/YPYk1oTgTv/d2QDgArLeaQvxoF8?=
 =?us-ascii?Q?nc1rT6wVgyuhx6SsrveRjYX8O1KkvzWv1NNB8KNlldtiKGIQ4zMxD4bxfWK6?=
 =?us-ascii?Q?oTYF3MTYMLm6AjfnNGB2Oye2krziD/eftGRZBCj8jJ7O5Zl+xQspuHbrkEMs?=
 =?us-ascii?Q?y+RgKwkEVRzI/Sz2j/QfME5j7X/1D2P6ZbbAcwiRLnhP6V9ZS4TT1V6PTrVI?=
 =?us-ascii?Q?iCzU+g7ev5drSrpRHBtY1THZykkNpUTfklTXLEtmLmrzQYI4851+wlqaL5xr?=
 =?us-ascii?Q?qgcr30T+mkyU19TMDSh4mQwq2F0Bp6emsZHnWKr9AOg9+JlhiSBoOqxF0+/e?=
 =?us-ascii?Q?rZY/1IjO5g6hDjwsh4MqOvIalHwF/WUhQ6Jc+ODJBGRNCVOnr5EHnr6dY2p/?=
 =?us-ascii?Q?wLvtj/Fz7DHFW3GYoGJFMxJg4HFHh6ZME5QLO/fCQ6SAyp+7+ip6SjdSGqP8?=
 =?us-ascii?Q?El9rAkCwnzJTJJh59CPeBEDvOMtJJQp+GS8SwFKZTNHsYKTdU83jMdQ/YHP5?=
 =?us-ascii?Q?qURqje9/MT5xc9CpG/RJPQ0C4fy6QY9xM+JeYeAc+oe61wGnOE0s9wJDO6VC?=
 =?us-ascii?Q?u8v8pJDWA1R4KOtzJnh2MgRFvLSfUApw01mjeF+GEjFfmAKMChdfKZPMd1PO?=
 =?us-ascii?Q?KlwikEaRZfypR9v054vPkIe/2Lg9DL7bML3lWTUGkrp2Oh3G0JNKNQgFAYA3?=
 =?us-ascii?Q?utXuImdN285ZQtzwMSzrLIR+6wk66s5spAx7ZnzvGJFJN/+AbGre+PSp2gEr?=
 =?us-ascii?Q?6O90hnYn/993n3g2jx0e5ENuaqIgkHhBF9oN5Qx5Nh8elinqVVLtcrN6HM35?=
 =?us-ascii?Q?ZW5z4m+xIo+xdgKgEEnI091OqGgYzlq3bWVHjBnDQGS4jEgLAnA7gRddrEa+?=
 =?us-ascii?Q?XBHQllMFXRQf292eHTzqZ9r0JRij6PVKjpBowZijtyIFQE3G1muJI6OrT227?=
 =?us-ascii?Q?icoWFBXa7zrs3COZ9jL9vQT7?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7508a7df-da39-4d8e-9e3c-08d8f3d3ce71
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:30:29.8917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47fWUq+veCU+h/a28HgFGb3ecw60ByP2ufTjlGE/pAHhL/wDQ1Plnksdf4Qnrd7NAhtY6avCWyYlxVe0wJUzvAVn15xTBQBVAivjPDXwuM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_003049_812668_2DDAB6A8 
X-CRM114-Status: GOOD (  10.44  )
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

On 3/30/21 04:59, Hou Pu wrote:
> Signed-off-by: Hou Pu <houpu.main@gmail.com>
> ---
>  drivers/nvme/target/core.c | 1 -
>  1 file changed, 1 deletion(-)

On what branch you have generated this patch ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
