Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17CAC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:15:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3766503E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3766503E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8rELshkE0RIU8KefmYIwQkqQXGSXlkzf2pLfmK8FvQo=; b=AtgSPvU9tHSLhhkOur79IUi5q
	hZJu3wBUHTXEp0xV7O3rF32U/deWQSNZyKIp7gZ/x182DDeGpFGqqEPT4q6EMSjg92qRWUBjOp16V
	cXuC8t/lLTkrulyuHY6qTbIJ2ick5Gyh3ZGfajl9nF+3kK1yOFa1XtP1Wp6nIkH+lKwL7/WucdQNK
	nKcGeEviUf4KkEcXOe7yC91qp+KNtSbDy3X0TY11GsiZvIjJE0whj3hjnKIJ0Hsw19cVYFRdrgZVN
	pKXX79YQYK17ny9FZK6RlsZu2EMCHwg2azEm+qNcsrmT+EUU4Dc4e8uLzrmjDt4JuIphyM3/Z8mJc
	b856w24JQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJA6g-00Ffyi-OL; Mon, 08 Mar 2021 07:15:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJA1k-00FeJs-4K
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:10:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615187403; x=1646723403;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4Ra3lXmVv8CupJnKbvJoRy/IBOVlOZ3gpnqnj+qGtYU=;
 b=jZaMYLquQIsQj6KcjZHMHe8e7coodn7ikueWJsGSeyovlMLeYORp9yqC
 F7UXH0EKhu0HpMqfZiQ+t/LV1uEfRbmowuvqQC1p+bOR48M2yWVMfSUdb
 BZgBXkNKg243Eqr8RJUkqT2gNNVZ9iLRUFINgMZruX0ESRKDmb9wkuMuc
 eQUhUxoIU6SCc6Hnn/MswH/m7MyVvCRLrk6KmKaKTvWGLcskJp/8bJbxj
 vLkZatLo6v6VNuFCJgzy63pojHScc0vE4XuJbTEok6W+X960ybwPeiXes
 ryZTfXgRl0TeveSu6e0lMjgK8/l0RI0ri+8FgkwOU/OwBwmFltYIyd9Hj A==;
IronPort-SDR: 3XeHhc879Xug02y8xm+NlHrgD/DQvWbEGEn5qtWsete1X0UKYLNl3XIoxhzYRet/PIQRQgE+H4
 BocrZA2B7+Icx5TVFhf+rCVfUPe8WF6lsSwlMwtL4EYDF05DLiPhBjoXDzAZWUHG7OtmTG55xF
 NCqe/yNBg3mOrXqVFcsT8KGvZ3kUNjn7zFXaPsPfdz4MoHXr/zFU7CBvuraPtT6otceLNE5Trj
 Cx4Peyp/Rq2z0iJS6sBTOT9zcBzWcZ1cZLyBKjYYS/d0uEBC+TrNYMtgcCqf01Oq+cGoxXobsS
 DjQ=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="272251738"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:10:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCIEckJsTDIwy3WN/miQSMQLnVjdYrY4ysa6BSoROh3Rd8YMwhTY6/v7pPLIq2afH3seReb8RvBpdfIWDIixaFFJ3dcZVPYIWRi5g0gBpn8dUsGZ7Cvc7ObUhpCYf+EiLg4DQS9teB+3UwiSQ8ri6asm45FPf2r4oSAUeJ4o7M0gzO2ZlUnRZN4Z1m66q3sjpZoq69vl6gP5exc6nz5UdH4foRyIdLNCPLxKDdbjWL3cH/6vxogmCZococPCMp7KO4u7xSFdLfGyTP1O1jJInTTwTSG55zS8/7Zb9147wtK7y7/V4SG202FSviS1GqnDW1nqAlX5XaqJWYzQz2sHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ra3lXmVv8CupJnKbvJoRy/IBOVlOZ3gpnqnj+qGtYU=;
 b=ERr6TQS+sT/EYe6cH5stH/6a764lgKY+hiXTneuGRAxKekvpuMr/RaJEoIf5yuilb8mxRoIRHcN+kD5+Q35IfWfNGRUXGhWNDs8XSRZljf0hSBX28V4JrgmPQHYJDpAHjWrNDO77OFp3b3QJzxNTDubnWUmNWyPMsoX2bYHk6dZHHyF6teJul37hCshvUSqgWVaM/4nn8N9T2CZGdkfhIhn2wZCvUANqvib1MZuVlReF5IZpr+0zMnl9pjawWTWHtE1jLjUcVeRtJlpV+2gn1kFsyI3m2dZMsFbxhbQ+rubVzBIDgYWmTRNueGQhIRc/9uHrlTbWnfX/TXTsmsd3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ra3lXmVv8CupJnKbvJoRy/IBOVlOZ3gpnqnj+qGtYU=;
 b=Ah6p++IE9KIwj7XVz+2YBolaA8AiVxA47sc+fNYXu+2zVRPh2fp3VF1A2yHk1OMc0/RYzAUGfq0Bk+qwlgpNbOffFQF5XH3dlk3idf4PbiqDcznRD0X8b8e0jMGOplO4PjyrGt+qlPLLtCmRzpyhKyPUAwKwAKYHTLpPz97KSc0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7680.namprd04.prod.outlook.com (2603:10b6:a03:324::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 07:10:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:10:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Enzo
 Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 05/10] nvme: add some simplifying macros for
 __attribute__((cleanup()))
Thread-Topic: [PATCH 05/10] nvme: add some simplifying macros for
 __attribute__((cleanup()))
Thread-Index: AQHXEiDJsbpoMzN+lUm4r8zeJ2CQKg==
Date: Mon, 8 Mar 2021 07:10:00 +0000
Message-ID: <BYAPR04MB4965A3D6E9D91C1102FC24A686939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-6-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6a0e2f1-d471-471a-8d70-08d8e201306a
x-ms-traffictypediagnostic: SJ0PR04MB7680:
x-microsoft-antispam-prvs: <SJ0PR04MB7680FC7AF482817C15193EEF86939@SJ0PR04MB7680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBqKT8tfPYybwbE45De0kHiqbTiM7c3wAz7lDTLGCiMF9jq6ds+w9serYy8ZGy44JRyoLC2n44+T3+Q4nsiMlKpPtmCbzi3cqdc00/b5N6siX9Ee74Pk56L6GWpyNyowFhIU1cTVXM8mgKcIp9IksEUrSfnHeXydx67Zd/XPereMtBQtmowRvc2kiTU1ucYZSoC5Suq7orpkwWHF676gWUn8JZOGq7Ovo8cAT/gMR+M87yncUu0g2MSGkNNgCgorkd2fDtXPaJuAkZ+wilvR3BLm5WFb/DDg3f2aa45E5HOzXIBTRbdJQUVvmpQIXS3NfpmFk1aMHhP7cN8wH7ave3E1c1v9PhN+Jy3QBpG7yg6CUFT4IhxiiiDTxOdwz2T53fYHYwGTU6cS2QgZ6JbZN26Z1oVzMsm7DXUkmEomeYef8iK9Z11YB+nhPTa6MWUg151zDP644Bk4tMvygS1gcDT8LiAlBoa6IzJA0Z8vHyIniuGwNZMncb7N/dGMiJo6nK/W+cTDkxIgtGZA1amuFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(7696005)(478600001)(66446008)(86362001)(8936002)(9686003)(71200400001)(8676002)(52536014)(316002)(91956017)(55016002)(76116006)(5660300002)(26005)(6506007)(186003)(53546011)(33656002)(4326008)(54906003)(66556008)(2906002)(66946007)(110136005)(4744005)(64756008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MoJN61+X3u+kT+q7RCJ/u0ZGFDW37+1QL5Ibd4Yn7scRWLleBGAfSSUSJ+La?=
 =?us-ascii?Q?8wbnG45S88Ezu1eChKy4qb64ez04A5lsDtdbOYyx3dzQMQECE515/PbOIAcQ?=
 =?us-ascii?Q?gcPbfIzTCOjNV5H7ZMdUMZKzWwJ5/xvt0BkG0l2KUeUAwYnAJWA7rT+0T11C?=
 =?us-ascii?Q?uZIFkqhr5VB3Mk4ZrieWKGiHi8kaQ9BNzkDm+mMG26rzcfX0EOZQ9mgFnC77?=
 =?us-ascii?Q?aLS/giv1stAXzhDWox8LYbldxgTR4HnRAraumwbtJ8BMIo1wPFdykbMrY/4k?=
 =?us-ascii?Q?HUHxldbWnh0Y5rrCC6CSaqc/0z6g1mh+dvrD/R+IIl4bzmsAK+ieT3xMK/dD?=
 =?us-ascii?Q?ALaKzHoVs5/BEbNgFkFotBa34el60GSYGHmRWsx/Yp+92l9gK3oC1DVqF8SR?=
 =?us-ascii?Q?RrTL+CgV22efRE+hnw0JzCqUK9Dhon1kM5QJ3I4ktzotNlZIc1KIvqZVwIFp?=
 =?us-ascii?Q?T2/l6QZli4C9gjsnvJRsjeFuH7MoCwnHI6ZPtAw009GvUNDyomoP122Xcl03?=
 =?us-ascii?Q?A1aXvdtCyYepbKBDSbsfRmhfL7SZF5MrP346wTAhPbU61aqQtlF/YRyXz59Z?=
 =?us-ascii?Q?tHlKgGW2lgwcXPFgZ4cvmBln5fbm4l1eln3DSWFLzQRKwBJ3c/ud4I+E4oat?=
 =?us-ascii?Q?epHfzjFXaDeXKCxi1GYxaq9AAuntLh6W4ZX3FNw1eDVSRxj0OL0xBtcKWf3j?=
 =?us-ascii?Q?lxMJ9R0pZJmYNq/lzot5mh6ukiqHb6gE3X+2vk7dQ/+8uIVr1ZGelTduqt1M?=
 =?us-ascii?Q?/H4443NY+ikcAtErq+BCTK1Ocs1anc0xS5ddw/yK+1K2tsc4H+484g/I/8Lp?=
 =?us-ascii?Q?fXkQG6/WP2dyb2q52IAOJ+8lD9+VN5mSlV8CqysFhLLBPEdrZgFTeSWhYsD3?=
 =?us-ascii?Q?Mo4dWsbZaeD+/PSauJDNgqgqorXPcMKVnrff0yraFL5bduCk80YHALvtH5WX?=
 =?us-ascii?Q?hNjqTG/8PgpPjhxGXbGgEFW/68p5IAaBToV9EN+eE8gzErIzP0fZqI1lH3h+?=
 =?us-ascii?Q?j8YpcOI5l/UvynpMOui779/VH6PftkcnojfqPp/ya9bKFb/tx4UDdpYOFPi1?=
 =?us-ascii?Q?H+CrLan3g0OaUQUSRImEWP1ABCTj5JzzpLJ2PF7imB56mGPMoY1sBnXfFAtU?=
 =?us-ascii?Q?VBnpT1O1QPKPwBBC7bK3id3cHaakpZI90TeCP5FY+767BvlBzpADOkUWpE1M?=
 =?us-ascii?Q?N0dbGivcVkn3OGcvBzQCMpnu5CqfNLMg0OAOkPjOIZOb0HdjlQQ9zT8d6ECx?=
 =?us-ascii?Q?ivO6uqobiUoXtmRJaaPWqInXBC17lYXwcvRZi62cmwaQ4MD/a4AjSoaozT57?=
 =?us-ascii?Q?YDYrwhCXMGF1ARgiLIBta0wB?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a0e2f1-d471-471a-8d70-08d8e201306a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:10:00.7549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJnYlO20t3KFu61cr7w4x8GaevHSsDvHTNK1KJI3EB1rYS/M3c4+xWHfzD5HlEqBIyYARab2wvPFSqyJ29AjLTPf8jXaGkz0HomEPTL3LRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7680
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_071005_199609_83CAC97F 
X-CRM114-Status: GOOD (  10.24  )
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

On 3/5/21 16:36, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
>
> Using __attribute__((cleanup())) is very helpful for writing leak-free
> code, but it requires lots of awkward boiler plate code. Add some
> small helpers to make its use more comfortable.
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
