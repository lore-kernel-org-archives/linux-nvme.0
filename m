Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB64CC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA0560FDA
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABA0560FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gsUUREXO2SdoAKrGT820+aYcYU7HxV//A0aCmV1E0Lc=; b=lOHM/ElfvYv8FX
	BJ1Zz2llG/FvY78NGWZJvRpZL3l3S5oAgcN1AVw7uVwkTM6GdSCDGa7PNX4sDSZOFYkqP4Wkrdd3/
	zRzGMgaReYqHzObpOn/gmKenQUy/CATiFGJkuE9jjYPhXFhu/uaqnPFkxgMxIy8ncyHABfubjggtJ
	y6sc+KI863/ZVW/WzfnR9MryuN4B/ExLyYBunlhNS97hu5GTCm1dKYFzMQjsxeeSgTvBtUFyeIgoL
	LFEZbQraJTHSn39RS6t5uUbUOPMnYMbBt5NmEjd1zrTtoZ4HmFUXy8RD7nqXpZFskv1RZHjsreCNp
	idMjrCaQ7Gogi8c5xWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSlJo-005atI-Qc; Tue, 21 Sep 2021 19:20:40 +0000
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com
 ([40.107.94.82] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSlJl-005aso-GR
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 19:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVsMBQeM2s5N43qTYwmM3AibyrE25EIlanfe/DgJlVmPiF0a7+BnC1RCZg0QobuS+jYzpdOLyJnWp/Eqxo0/w8/YpeCKzZNhV6vVuGFhfiAGf4I5243OJYYbmYDrCywSJY5wvhgBmThAQcDs/LSPr+sxj/DJcUsoFw1xUrMpq8MzrJgWsSZhlwvKs+DQEwlkabcqiUi69JqAHpOr91BehB4wUkGeihKEUwN0f8WHZkBdefd6sjLajfyU5GBTlK0QZhYXYDDo58R1LPX37kmnTNLmvLxfc9ejWiKTnrfR54nNbRcGWuLsdLIPh2WP8mtXKBQJigumxEzPPAwBCeLL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WQL/OA1T5jN/w+dzsfACB0tLNrpad4XSQsbUqtCCLWc=;
 b=jVgneSq7i9mcJmreSjsW72/mf4c0qdlPU5sLpPlhrnxAUxPRwHKZfwBZbqLZI7Pp3VV09ZZIlo9Agj2gtsuBr8B095wfZE/c0XPTN4srK3/IlTit8YuUj5GGoMMNH5ce0Ob9S8KelAkoqpSu04OyUqjOWAeRBVPydfKz5sdJq9s2DSQOGhloxZoXm5U+9VWxuApF5Um5IkfY+CeUQpwdlNVm7ci+obueXFnjHfk3fT/G1fXYfquIZt6zwp+fVZ0wLZcR11/ZcSNfiPZrwUi+EI+QJZau9JHcxpaze8/TkhNRasFdmHS5bh7lNEsCG4ANZQw5L6iYTluG3PnXFN9wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQL/OA1T5jN/w+dzsfACB0tLNrpad4XSQsbUqtCCLWc=;
 b=A60ksWtcpSL/BlgZSfJLN88PiJpCrrnJr8t+8Tu5yYC3pjTJ8KhaRuQzaIwbf+ZBbW7D5/dGxbx2YLAQc72shUJGk5T+eyLlk8khXm3TueDb+zcQbaZADmM+4g6UNvEOO21SNTE1NugP9pvUdH4246YmGrJajMFoJSei6LKNmUmH7mKVRkQkjDFxGKVaNieJYr4qtmlZXur123u3rsLbXQQOnQtvuJEoO0hXewW25idQjAgcf8kO2xmMtS52yrUj2XlObtb8xdnxWo7xcxnuCW4MWVZp00WwyZwaBSL8d2qdMHjkHu8WuIpOMGiQrlMhs2ETOdotK0Cut4l3g2NoeA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 19:20:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 19:20:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Israel Rukshin <israelr@nvidia.com>, "mruijter@primelogic.nl"
 <mruijter@primelogic.nl>, Oren Duer <oren@nvidia.com>, Nitzan Carmi
 <nitzanc@nvidia.com>
Subject: Re: [PATCH 1/2] nvmet: add get_queue_size op for controllers
Thread-Topic: [PATCH 1/2] nvmet: add get_queue_size op for controllers
Thread-Index: AQHXrxuZmM4/t/5dz0m1jswmxRgmb6uu3UyA
Date: Tue, 21 Sep 2021 19:20:34 +0000
Message-ID: <42970adc-3bb6-4141-f2f2-47ef875f07cb@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-2-mgurtovoy@nvidia.com>
In-Reply-To: <20210921190445.6974-2-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3faa516d-43a3-4dd3-03de-08d97d34e30e
x-ms-traffictypediagnostic: MW2PR12MB2505:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB250572F5E7828D687FEAB03BA3A19@MW2PR12MB2505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyfE+30LtWews6RfnoEUaiswicDPMdbP3QWHhzmmg88dPuoGkD78B8MftPJ0LJR7PtL5yfH9ZA1MAMXJUvX1Xhg9sy81jJ9U78NdLrdIVasTaov91a6fddIvdn2HatS52r3FDDaxKb9u7UMa6O06FUp3eqTkA1emRAmbYFQanQmOwuzmX60HbDRC6CgRjHO1uXMLbAg02uAANhwnVpoXwX1Da8Kndm+bZza+YDxAOauv8IGyqgymrrjKOTN+ZFpWKHnR5wHvzi52d+I+EXwjpagZKgPIBIPP+e4B9nTb3yU/5hZletpTFC7X2rdevxpwTVmTFLv5IEluvm4UANnE1C9tUBN18DAJX0cJibramWd9ZvGOmPlHyKqxgbLh9bObwXJ0JXiolLblggj7oYcAzszE6aI4s+3uWuhSC9aAIN9PjdmbFnqN8LJ9pduIMXahoAOd6ieTe6b0V8sBLppGLAHKaJeqQWOtQmED6sl9Gd/z2lT/oZZFXnMfKIY5SAqtqWTKyXeck+iPtDTfx64pA7ddugfVwjtKwZSXwQGGXm42Bsrv/HKR/KWymICUA7yOog+yK2PzecXSKsvupnImn9bwWlMKCariJMNvkwVwfXysuWWHO7qXxvMoO5+0J8FxEdsnsxT2qOgBuhzgtgDl33j1dBQHFQDvQ9a+jwIsBfTM0lqNo6YfphMyN+lVG8j/xVnBk/lmtDPdk/Mx7lC40Hmwx5rer1D0steUX/U6z+dovYK9oedKxoYF9FeFxM1oEDgEGjtRDvQQ+JerDJ/UIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(4326008)(508600001)(86362001)(31696002)(4744005)(5660300002)(316002)(122000001)(6486002)(53546011)(66946007)(76116006)(6506007)(6512007)(91956017)(64756008)(71200400001)(66476007)(8676002)(66446008)(66556008)(36756003)(31686004)(38070700005)(2906002)(2616005)(8936002)(110136005)(54906003)(186003)(107886003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG9rc2RtNkp5TUhMVUxDa3ZSSWVxbkwrN1ZJaEhzT0pPbFdKYUc5L0R0Mlg2?=
 =?utf-8?B?dzVzN2dncE9FRU9OdS9XcmZ1S3FFMUE0NHJUR2p2TTVmUjhpeGVQRFhsVmJL?=
 =?utf-8?B?MkxoeTRjdnNTYlpIZi9lalQzcytEWlNxOXBEWDRrVFJseENsdktBOGtJb2xn?=
 =?utf-8?B?LzUvNGEzZnRmMmNCM0FuNCtaOXMxNWZQT1hGZEtSUnRwaDFWU0xrS0hrVXIz?=
 =?utf-8?B?VS9qamcvdVpwVjAyS2xabWFrMVhLTWJ2RE5UNWlQa1JvbjlIN0FKRHJjQi9X?=
 =?utf-8?B?REI0WXJkZC8yVUx0dE1wN21BalhRSHZPMXoxQWFFbnE2ckJzeStvMU5URUQv?=
 =?utf-8?B?c3hMRmxGWUtiZWZiZGxyQUhxSmZrMXN2eUxTQU1YUEtRaXFqMEtscUl0Tm01?=
 =?utf-8?B?SGN3ZXR1U2p4ckJPSi9kblRjbXU4KzFsVFVqZjFCZFJXQ1Fqb0pzV3lpcWQw?=
 =?utf-8?B?NW1aSmFKSUVsWkErYmhabDg1V0dCb0kzV1FKTnRiSVN0QnlHeUVuZUFvcWZ1?=
 =?utf-8?B?ME9GMmw4TnV5cG9KcWFCVDZsR2Q5V01aUmR1ZnQwaElFc3A1S0Y5ODJlWXhi?=
 =?utf-8?B?NWk4L2t0b0NoM3MySGVrdHE2bmZhNHJndG5RRWJTY09HYzd2T2xkaHlvY002?=
 =?utf-8?B?UmVwcndtSzVxeHBTYWpuMGR5VG1PWUR3N3FGd2YxYUVyc3hzQ0hCNUQra1Vo?=
 =?utf-8?B?MW0yRUdhMnJ1OWhPUFlYTFByczJ6NzEza0REcVk1dDZ3SzNyallnNlQraDBV?=
 =?utf-8?B?cVlnQUVsa0dpL29VS2RBTWFYUVNYR3RJVFhXamo2QmtoeUVqeHJHU1RzN3Z2?=
 =?utf-8?B?UklYdFBRUCtCbXFaQXZVd1hvUU9YM1ROQmdVVE0yVEtiQisvNXl6Wm9MeHlJ?=
 =?utf-8?B?bGRlVkRSQVRISHRPdXUvK05iOU9qWU1rblVZZUVUNk81Zkg0Vm5tdjM4NTR0?=
 =?utf-8?B?UmIyYWlTQ1ZuYVhpdnRzNXVKVWRSYUl5TjVxUnJhMWJ5Um84UTNmd0FYTTBi?=
 =?utf-8?B?aFpQMi9EWUUwNUhXdGxiM09GSEp2bkdFWTBTZXNZUXlSSUkzUkUwbkRDa2VE?=
 =?utf-8?B?cGJ4REl3LzlleGZmbW4rbjBOMzY4UHQzWUZ4S3ZleS9lakZCNGlSVWVlMXpJ?=
 =?utf-8?B?ajJWcjZjVXRudGVHMERyeVl1TzhOTnFJM2toaWUvWXNhM1hDRUdEOUUxWUM5?=
 =?utf-8?B?UDRmaWlpMTdoSGQ0Y3E1a0VFbXpXSmhIRUM0Rk4rN1FRREJaUWtuYTJvWkoz?=
 =?utf-8?B?NEhXNTVuTkp5VlkxYUl2ZkpVSE16R1htK0pCdnFzTEc2NFlVOEZNbHZtNmJG?=
 =?utf-8?B?QUJCWk9EdmJMUXpmU1pSTk1mYW1aWGd5NHZKUXZ0TGw5RDBPeHZoZTNtM0Fo?=
 =?utf-8?B?YUpxSFQ2bUc5UlE3MDZGV1NiL3QwdnRPZkJzcFZ1UmJnS0p2eUU0REluRTZ3?=
 =?utf-8?B?cm9NcTNVZTlkRURBTmhOTFF2TWdpdHNBdmdLOGlHUWNpRjF0UE1lQldqUzBj?=
 =?utf-8?B?VEFNMzRpR0lwWVNjNnRWTjV6Wm5KcFc0MTkxWXluN0VLMWZiMG5Ib3FkZ2x5?=
 =?utf-8?B?VkpTK0RybyswMnNXbGdvTitLZVFLSVV3WmxNL3JtRDBYUXhMQUpjUFlOK2gw?=
 =?utf-8?B?QU5YVklVMWxIUDhzWmYvUGtMK0tBYUI3VHBiTUtjZ2lNM28rZlBoNVFaQ0h4?=
 =?utf-8?B?OWtHOVErQW9YUXdNdWVpM1hSTDEwVEtPVHk4ZmF4MjUwUUthbzFkN3A4c091?=
 =?utf-8?B?UVYzcXBEWnBkM2pzMjJ4dHlCZi9yTVhoc3lYak9ta0RFYzlnRTZDR0o1WUpZ?=
 =?utf-8?B?alBkd3o4QTlpTEtIWWpHT3dWQWdmMndhbCtnY1VRUCtCbDJubldTMzNEL0JV?=
 =?utf-8?Q?7HyXja31TWnzh?=
Content-ID: <EB8A27341F1F624D988BA369CBF21BB0@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faa516d-43a3-4dd3-03de-08d97d34e30e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 19:20:34.8954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uDWv+ZCCnpRiINTz/YUz6wA8tIKhQpx77uBPRXMKRk/H2kMmQwBnas8pw6cX/NRwFQmJWUKq2OsFtRqQUboFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2505
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_122037_650377_D24D1257 
X-CRM114-Status: UNSURE (   9.71  )
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

On 9/21/2021 12:04 PM, Max Gurtovoy wrote:
> Some transports, such as RDMA, would like to set the queue size
> according to device/port/ctrl characteristics. Add a new nvmet transport
> op that is called during ctrl initialization. This will not effect
> transports that don't implement this option.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

I guess there is no way other than making it generic API, looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
