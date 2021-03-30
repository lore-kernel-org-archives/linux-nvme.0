Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276A8C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:30:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78FE619CD
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78FE619CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JROF8NWLQ1xAW6XUTL2v1itf+nOdcBblsS1WOrQ5Nik=; b=MT0MoLb7nsVw0O4xdIKRb/jhZ
	H2GSUuZDwaHemII3b6x23EBx44ovI1gxHWhFcAKMXkWOswx2AyvcYQftF+Vwwf0+na4leel8VTQR7
	nL7Y1XJJVsQ5dKjIU3bHJc2foMZmSYys54xJ1hJs5wXk+9Jvy6gimIFLZ+gNphNsQeOOxWFHnK1A4
	7ENivrc9zIfj3yvC2erzMac0tTAPxGgXFEjAxzypJAA+kTItKFHLAn7J46azA6xOkHY85seNlajRw
	XMsYAZgVWsvNhWbqNECs9VwBBcExgjXg7+ZlCaik+0Uv4fiAABdIKf8URC4MfYwr0+UwXOt7zh1Es
	kzFdvTacw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRNnt-0057Rf-Gq; Tue, 30 Mar 2021 23:29:45 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRNnn-0057Qj-Nh
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617146979; x=1648682979;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DDS7abX7AbQGZvGqaW4fynQjhrLj3utBlubBhyn7IsE=;
 b=fK2FLG4SfaQHkdZLfMX2UvzYdTItOeXjjMvwtOaPfUmb+nDI7mz1i+Xi
 QJCjCQAzN9ekK+TOc+z5waDOBWSi6//OujspFWn6HotASGYsPEmR5Ien8
 Vaa+tUvnyfvh7/Izdnimw7akR422vQjkGwESvqMAzojOyKLbEnnwnWU2F
 1aXwjUcq4JHDnzJkV37uCGSKqo8MQatjCv3/iTQdNt4cLW/PdQ9my3opf
 ByO0KRjIO2mIxl6entk0zcymNw/hQbH+6AkJurKNJpG3XmE6XCKvz8Igm
 Z9Ic1uQiIiRLutzexMMnEus713lYmYf2fXu9nU2NJw4uHtBVenVQF4q6T g==;
IronPort-SDR: sqoKLvGdn6+0v9s64SuZt5MFlre+5bLn0J4zCC/kXFOzK9Wv/XPC44mw15G+UFmwDOmfDyIukH
 9RFxBjl5Ca9/DqosTd2YZ47y2ukC/yLs0lBKFBsGi0xWGxLSY9bKQgb9ZFpXvgZxP/eJzJYsMh
 rcpsq+XElHmuEkQebpE7Kt90l2AhXleIFuSFkcU8iRH47iTueHsLf82FF73xWSbzS1NPVpJjGZ
 gKXSzSOlWaD14malFlEJOBoWC9nmiQbtldB3THJAo20XNUCnMci5z/lcZ32FrWWrbPjqMJnlFo
 1Ag=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; d="scan'208";a="167867476"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:29:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1LqK+w1PAx4GYBGMk1ZR6kH/En/l8za/+wXxsINvZTxDC5OHzIWih6XCjiMgfGsUqYPmZUKoyJzrz6B8XIG5zStXmOILxDnLJdOfzCITkUNUOES22Tjzs+ZRSkOzUAPOkVKrkzgg3ubqW7aCw8RFowL/qnTYCZVFC4doHQrZ+zS9aUqdoJ32rw+Jg0Ve2x9J0/Ji++YDqeEFdYlu7K+l5fQYLXYwAI6a0Rf02bAxsdQ9ZXpeydln4NOz+N6AQwBe9wTs4wy/nNul9dOaEWT7qs+4SpWfoKnRpuGoLArwjjRU6LRXDfQPcWkTx4n10OO4QrNJnTY1b3qN7kyhRjlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDS7abX7AbQGZvGqaW4fynQjhrLj3utBlubBhyn7IsE=;
 b=P+Y2JWogsvX/NLlKJRQBhURhJy56l2LtWYQc4R2MCRpj+XT+ZvZmh/PoYoivqaGysnMOnM6Bz6j9vnYGVKLqsdPcPWGglTD5pdarIZQLsB0LVfwruDO7GowffM8sY78UxYKbmSDv/spvUd9xbTLFXThB85j2eUBiOHbmYq/QETkwyGHEQHbOaa6nFoXm+5u6cNJV0pU8zJMk0rObsRIA8XGHDRdpLpDFtfu6Z4ZM4EIc/MA+2n01kvCWws3ngQxZvuvyAx4BcsNWFr4jFgZZeQDuWH6GkXcuJQcug7fJ3s21UdgWiaK5r3QKuiz7eYg9jNUypitgjyLuilNjJL3jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDS7abX7AbQGZvGqaW4fynQjhrLj3utBlubBhyn7IsE=;
 b=mxHtyMe9ZwPFTRG3uDeseQmlK4DYTg92afW3hlRXvVLTnBjbqr7Mbb1GDuRc/fn8P1f+swXcM0BNdCloPhJajXC1f9owjQTXFKJz6/mejYAIi3ErYswxE4E1mAVfUv6phwboEjX6cQTntCf2zhhaK3JxfliEiCaZmxYUIw0SuC4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6947.namprd04.prod.outlook.com (2603:10b6:a03:22e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 23:29:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:29:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hou Pu <houpu.main@gmail.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvmet: return proper error code from discovery ctrl
Thread-Topic: [PATCH 1/2] nvmet: return proper error code from discovery ctrl
Thread-Index: AQHXJVwzP/AnM97FtE+EdpPnAVcdSA==
Date: Tue, 30 Mar 2021 23:29:32 +0000
Message-ID: <BYAPR04MB49659B3B3301DA5EADDD49EF867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330115907.15432-1-houpu.main@gmail.com>
 <20210330115907.15432-2-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c7dc4bd-9152-43de-9d8c-08d8f3d3ac86
x-ms-traffictypediagnostic: BY5PR04MB6947:
x-microsoft-antispam-prvs: <BY5PR04MB694701AE1A6675C854AEFAEF867D9@BY5PR04MB6947.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDfReL8FNXWLKCFfhawUic002CXcZxVq3lzX6wKcg6qPCm2pMjP5lUWlSlS33xCL4hrF6/K5FMe37Z1SQL9cBItdPrS8BSzGk878s5e7C4ZZWSZVLEneosLFK69CrLqQbc59PZoBblMuctQaEHE9iwibmEiOK7IhWp96N8FeBIMkLfNTaR6UOex48B3OAwZEamgi2ruroxar/lTu/iA0xrMO8Q0qhMn+Hz9hIO7RtTH79A1Ba+rRPKDL1LytAFtav/5z4deFBfEijoAcZXbQIVMCHRXfyry8jIxHKT59lSUTbzkBvjTkDB8GtgTsGQ2+3nUkdu+Ti1RwHlCtb2DXVj381xBFFLGyeKQQxfmDKnBfiWv3SpTJR+/glIi1bbcMQSRaY7789Vf3iCdw/SuX8Hxov/yNSBQFRCThJkdHlbTPMG9fVLQ3LDfhwUymYOniKHPY+PdZ6WE1KMhE6Q1j/M19gOfm23cb8Uf/YceE0/6/Fb79VcZ14KDubXrsg9q5akhriO4eMFThCwQsprXcV9/xu5SG9EPkKtpA23WQmt7sU6RGhVdjcO5a6oPsd4e99f2O3ownruQldHQnuNyjAV6wL9QjXjR/eODGCcsPgL8cQHx0qky/LUmpY8DODjQrysjZ7BpzGYrqQoU6exM0Z2q/Eoo4xHAWVp2JgsVLW+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(478600001)(7696005)(76116006)(66556008)(71200400001)(64756008)(86362001)(66476007)(66946007)(9686003)(66446008)(55016002)(38100700001)(52536014)(316002)(33656002)(4326008)(110136005)(6506007)(53546011)(8676002)(4744005)(8936002)(186003)(26005)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?99qTU4nLPs/xeSSoA0LqGhIgHEoMfizHQ8hlHETRUBzZFoWlJLYw4z4wnRr8?=
 =?us-ascii?Q?Ehjpt9cOIj7++04U/7Qb0fPcz664kl4S/jlNI+G1wQAi/iBfN+rk04+euAbA?=
 =?us-ascii?Q?S004cxYDKGb+5/MNO9M/byC99r9kgVu/g0jmksk+yB5dtbFfReJj23Ta2M9y?=
 =?us-ascii?Q?VGeX/t8U2oMm/s/XfAAGJ2qHzNr2rI1hVYeyQz+auMvQQDd71NozSJSsovJf?=
 =?us-ascii?Q?QvmPgwsGfHcPqiQ2EbfQfnAXwmLB1ttzHjLmMaq9ZzUsldKvQfGYop1YCdTt?=
 =?us-ascii?Q?y7qfi88uCSe8ctille3OWZYsUM7GEXveohxjNYpZDM8ng4Yyo4icWbPA/MMD?=
 =?us-ascii?Q?207qPjzcT/x1ApfwwrwccYBGy2K18lFMqIRMiD0hEi+S8/vZhiZB52msmMP8?=
 =?us-ascii?Q?JZXh9nlZ/hDC1OodMeHJ7VzbbGe199F6a7CvLQ6wWPpwT60MIUwALuKF9RME?=
 =?us-ascii?Q?66jTcGxRRgjNpNKmtMhNT0vzJavRHkSKPbdkJYSTKimc86xTH5xfVQxlvche?=
 =?us-ascii?Q?R/kJZrmrLXrxOxvHt8d1DN5Wcyz/K3Ryw5gXO+/U8LzdgrbZZMlDBljeBI/E?=
 =?us-ascii?Q?HcMKIBYTvAMDuiGfO8X1oAgXy/cnAzqDPmQpKEtzvvS8HJhWKjREZTxR8Zfd?=
 =?us-ascii?Q?hrGKGfNnL3BrtnLmUF7m7+OkeX+7xUSKa8kOrQ3HkJVDGeEQIotKKRZgNmn1?=
 =?us-ascii?Q?jUQom4xbtWiJtANdzXVvObygwa9Gy257nUMW4Gm79a+ZsFWtXNjk696h+UPY?=
 =?us-ascii?Q?yo3qRZ2EGkdWCSNJgT5+y5XD4ctkW9UBwG0PYrh6M3nHe3ZpsBSzjLOhyPgK?=
 =?us-ascii?Q?lE8M01e565i5k5QkvuaN0XC0DA6z93l2O2nAd3fBKAW3Mf0mSsg/KzC6aUls?=
 =?us-ascii?Q?cX9trIa01UL9+tFQxDF/MoRRV8kW7sGQNchHCJCx/WS948UIm+0loEcMbGmU?=
 =?us-ascii?Q?57rHfCijCxiI+pFIoODk7dDGmcj15gi3lNewnGH9iNbz2YPY3Y4peAfIOCsM?=
 =?us-ascii?Q?WEt8r2IZtXPOU0LkwLcxv/NVMk16O+Wc6FOp3ena2dOF5A/gVpQo91w4+7q2?=
 =?us-ascii?Q?2ZmrikY/Ou0xvoXw+c/jh9CV3pzhtDoGiRBJhojwo9Kamx5qQ3qCdAS9R7dP?=
 =?us-ascii?Q?3aTUrP+qn7c9+CJgpcYHAwMjJArT4V91cOM1TZ12zWzkqc9okVqOSaqZ+MqY?=
 =?us-ascii?Q?Cqim2kjjQFUotwTj6wfPQe5IBWve/BEee90iiNT/vPMZ/kg/qAYOL8Uc1/UP?=
 =?us-ascii?Q?udfCwXr0Nujxpns/q8DGVfL+saPQ7SPSo6Zroq44rzq4+f5iRRHARg7V86eS?=
 =?us-ascii?Q?s1aD31AWtQShcqmLTZVmu+O3?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7dc4bd-9152-43de-9d8c-08d8f3d3ac86
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:29:32.9708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZV51WcFEVT3TL52dq/5ENP5qtpf9B3kqNY8ntKLOlRm15LbfF8mJWq3Y0YMKjZQCIzHUEdKXQOCtrQKjIa6pW61Y7mnxeBvq+DLNgSDTvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_002940_755646_68C4A093 
X-CRM114-Status: UNSURE (   9.36  )
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

On 3/30/21 04:59, Hou Pu wrote:
> Return NVME_SC_INVALID_FIELD from discovery controller
> like normal controller when executing identify or
> get log page command.
>
> Signed-off-by: Hou Pu <houpu.main@gmail.com>

Commit could be :-

Return NVME_SC_INVALID_FIELD from discovery controller like normal
controller when executing identify or get log page command.

Can be done at the time of applying the patch.

With that looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
