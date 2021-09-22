Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D5D61184
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6D5D61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CpOAIaLEgOMfsxOWYUTcQBk2SSU0Yyy9G++tHfNn4Og=; b=r8SdRztLpyMcrq
	cQhoK7GC9FDwy4SCfH7dJLKutSqIHWXiTauhF5FjOGZ0vHuQgZm2uGQL5nhKJvYtWeDRcp4SaEg/q
	bmIPW9+APiyV/DgrSoDoUlfPr3VG4t+uCW9GcdmJS3EmhMuqKSPY0j3AAeUlclDeMlrKGYB1t6CAO
	LfhzxekZcgNIh0XlP8HdmwyqbEmaJLFD8mruYrT23jsBrW1IhFFx5OSUh6742yrMlJ+/Q1Hop9cWa
	IJnb+TGYX6Jd5utDGUwG0S0xbx/tEbAG7jfGocCp0jGgdEm2qPtpppQWAoVuYKnGyjPmDgHseMsnS
	aVybFBTVvqkVseGmb9hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSr1O-006UhE-SV; Wed, 22 Sep 2021 01:26:02 +0000
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com
 ([40.107.236.51] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSr1L-006Ufb-FY
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 01:26:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV6E9DWZZDfPVtjwl6mynYY9WxO/UzxtbBu939om5xl5Yn+DQRfR6hQuXmfxh10hE7+DCyZNA5a0ggau27aHnLGWp6z8STxwoNj8gf+PXYQGhz38NP7K0bTaunoCndlqilMgm6SHHnzi8+RrKFQnGfDTRBh60fC9xfKJzNIuxTM76Ykneb5i5DA5stdxte/QhobAZkRGz5JC+A4OTXksWGyVdO20M/OIdHUIJNe5lX+DOAKfC0A9WryUeZiVW6LWKHJOt13Nj7vaMyqCtyFNibsIL2se59OLnbUidnwTORMgK0ssAedY6muxsO3ecGbDFzas1Wao3NWdJ4eBDvaWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1r24QCmsN8e+XJFzfkXhNzFG84XiZ89A6wWth833s9s=;
 b=YoeIGJyxyyb5TP3gyu/K74Kb2wmKnn96kw9Owh3gqXkIHiLgtaijaWOmppneccK5Zp4xBMGqFs/I5H7Hf7wuySNf4OkpSxgS9dN8tUctX4HSJnFh88ccoKi1X8U8JNdpue2qy3sL7mU+3/FcPyNqA1Flk6UcMOSPNVnMCJBw3dS+yaCeAdsZVmK/PpSVyjhiabpCkhZwnn58aVLyBdgbS7TxOAyRSsGWtk5Z0CqekXrtM466ifsGTVIrpYPW0l3EIzRwAEHCx63vfcb15YfmEpwJdnm9xKWI16Yo1C69KTV9KXN5DYxs2HeFoJJMh4J5mx/Dow9jvmFLuFnojFUCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r24QCmsN8e+XJFzfkXhNzFG84XiZ89A6wWth833s9s=;
 b=hELqXe7ZuvSXc11WCP/+Y9V9BS0FdpyOIB5sW+ZTY77ee5d/pJt0kP0uq0sxBfF4wrzNCgKux14Fvu41SidLOBfrctaK8GKyoX5+Ur02wLQa4adBuZyyoOIXvcTadkToHRntFLWb4ncsAvun9bIPKvzDVrJ8TGIEaCh49q4ka+82pw6ELsmxzlpjwaSlrFEX2JGdEhpeiaOTetoFS1lBVyWMpXT7d2oZF8QYUSqvvq6LY3qdPOmM5KDZlacaa8s7ONhHKqJkcvya7+qLRr6lPmgagXYjv1KRBJpF9m1D1PIqaF+O6MWQUtiJLy/658SrIl8qoao7N1zFOJy/DEGHpA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1326.namprd12.prod.outlook.com (2603:10b6:300:10::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 01:25:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:25:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/6] nvme: expose subsystem type in sysfs attribute
 'subtype'
Thread-Topic: [PATCH 4/6] nvme: expose subsystem type in sysfs attribute
 'subtype'
Thread-Index: AQHXrvv7+bs+nc6NjEOYs6ZS7IEckauvQ5uA
Date: Wed, 22 Sep 2021 01:25:55 +0000
Message-ID: <b55c9c4b-f744-f555-4334-702eb508f747@nvidia.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-5-hare@suse.de>
In-Reply-To: <20210921151529.29419-5-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cffcb279-8fb6-4360-a85b-08d97d67ece8
x-ms-traffictypediagnostic: MWHPR12MB1326:
x-microsoft-antispam-prvs: <MWHPR12MB1326020619784BA7A5425ACAA3A29@MWHPR12MB1326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGOCgFqTvrz9wpuGbWwJ3x/30/C5NcsMNVzFxpaVXwKnxxw77UQ3ey+E0ruh4H47PBtOr071GoRqp1DcBG6juSLcIcaciDQ/skVwLAHzSMwYm8IYw03HKC2HrVhCnZ9eBubQHRroF1Z3Up9hFSdp042PnC944XJHFbHH9wYP4grrhwLYK6tp4VfHEbNXsfUBT6TdC/h9lhDGT/IexL2vV6E7/fawSk5gDgebHZ5sv7X2xUBEOEK+ogKTHJozFX9p9Jtu65NqkW8VFYL0FCIN4VtNSHxccYljVs1fAlPj4nHUMlmdfJlAT1hOKJqKEsx0GSje9pM/EbzVFuzewO+5CKenRq2Bhu00dazUtcEJiFTfUTHlIqSSCklO6MdPH6oEfEP1ad+qUs2YQZyMFuc1WTNMKeqbSP0RPjst81+YxsUayYsd4d+QFyJqVRwz5p/mtUO3jV65v9Q0SB7JdR8U0sqaeZycKb9CkFV3kxxWT0+WnMSBylXzZKTrdaUXare7988RmGF3FGSARi0ghPGVZ+WB3sLZtarVuRR/BQUML3HJt/XPAKn2C8/pygHVfecgxWQXDYiwf43zgjtO5jQ5s9AWQUp9DUu3+sftAT6QWL4HAGCDxEp0kYsKYibr6D0Mk8lzfiZFS9WGKp7hYVb4zusj4vd7oTH3qAFiMf2OSkouYirjbDTGQXoPB5fODjhs4S/cn+vDQowyZn91PMDmTmezTSE4Jfw9cqf88xRYb4dzwWVrkolbkpoeL4F2IfrEOLDsvyu5w6mc7oGDf2NwXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(6506007)(53546011)(4326008)(6486002)(6512007)(26005)(186003)(2906002)(508600001)(71200400001)(31696002)(2616005)(4744005)(110136005)(5660300002)(86362001)(36756003)(66476007)(54906003)(66946007)(91956017)(76116006)(316002)(66446008)(66556008)(64756008)(8936002)(8676002)(122000001)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW9FTlVNRmVKS1k2c1hHa3VJRHhHaGcrMXU1RVRFa2FwSGs4TG95OXhGOGJB?=
 =?utf-8?B?a3p6MmY1bm4vNnhMNXdHTXpmdE8wTkZUT1krb1R4U2ExU3pSaFd2aVBpRGFy?=
 =?utf-8?B?Q0h4N21xZWRUSjI3SW4xTmQvRE1JdTdONWJ1eFI4V2ZTL3lvZzRFNThJQ0dD?=
 =?utf-8?B?Y3FXOGZCN242WDVyOTh1OERCYSszb2lhWUtRWlhMNnhuUnlIUVJ0czBGdFR0?=
 =?utf-8?B?a2RWaHVKcStZZis1ZDZsSTlxeVJLREZvanFCWGRyRHdpK1J2VlRYSnRPeWdQ?=
 =?utf-8?B?UnVtYVcwRG8rZEZsUUNXQ3M3dEJXRGYxaVBMK1hrOHk0RVJYUDUzeWhndXha?=
 =?utf-8?B?Mmgvb20xM2NSa3l6c2sxcS9TQTdEN2RZQWgxSDl0TWxJZ2dtclUwZ3FYQy9i?=
 =?utf-8?B?S3hRdzBGVXNVb2swS1E3YmJZZzVCdVBPeGJmeWErTW1UVnl5ZEZacVdMaFNy?=
 =?utf-8?B?NXBmK2ZUWlFvUjcxTnNsVnVZYVhhS1JqL2N3alJxY2NGWEExN1BVSWdIK2pa?=
 =?utf-8?B?Si9nNTFNQzlJR21OQnpyRnpHZldWWWtra2ZnUGYwR2t4cGFQTW1raDlUWWZo?=
 =?utf-8?B?TC91ZklMUVUraEh6NDhnbkhEeDZsVVZjODcwSkcrTzBvS2NFUFFpMXl4TUdm?=
 =?utf-8?B?a0RickVqTm1IZ2pPaEJHa0hXeVdLcTEwSUIvZy81TDFELzhpUHBuT3h0djQ0?=
 =?utf-8?B?Wm51S1BrS1hFeGtsRlFLUllDVG1NbkhJQ1ZHR1IvZ1ZhYTBVT2EvYmVDbnRR?=
 =?utf-8?B?dEdvVWxHUGVsbjhqYmVUQUNWTzNQQUZPclVBZ3kxNlhhaWZQeUMwWXdYaG9s?=
 =?utf-8?B?QTdHa2I3ajJJL1BXWjVaUzluOGJpUFg2Vlo3WUZwSkFMdlVQdk1rMXZiMjkv?=
 =?utf-8?B?all2SkdCT1Nxd3c3TVN1Y1BvSzdDYU8ySUNYTi80QjJSTGJpWGtRRFVYbXM0?=
 =?utf-8?B?Yk9vMVR0dms4MVRsR0JxdEpqcG84ZHA5T2FRMWRiTE5mcHhPVGkwNzB0SlU3?=
 =?utf-8?B?NDBROW5zcDlsVzl1alpyd1NZby9FRDU3d2JEY1EwMTJGL1JwS2VvWTdFOEty?=
 =?utf-8?B?ZXROSmY0S2RpOG9jN2duNmx6RVB2TzBWelhGYnJaOU44K0FoV2tvMEpiVWN0?=
 =?utf-8?B?dnFDNXpMV05zNmpsWXNhTlhoalRlYnZmY3Z1NmFTTGhRaVlQZzNqMG00bXdC?=
 =?utf-8?B?NHpkSU5EK3gzOXg5WmttNmYzL016RUJvUEptL2hCZTc2UHlpUk11Rys4QWhY?=
 =?utf-8?B?U1BoSzJGak5CRVVWb3BFZEJzM1hjTjI2VzRiemZNNlhBek5SclcwM2hwdGJU?=
 =?utf-8?B?dmhNY0dkMExqbmF5WUtPaHRMVkhuTjA3cTIrMWJJU0NxSUxaQmNBRjVXYzVQ?=
 =?utf-8?B?TElGNE1RUzQxMDc0OCtYRGdXY1ZnaGxxZzcrZkl5SDFQMXhMN1NORG11ZUZ0?=
 =?utf-8?B?dE1EMm5EZWVxclFIL1BpczNVMUhXa21vUEZtOTBnUlBaOWE0WFBUOHg2dmlS?=
 =?utf-8?B?QWs2QTRRR2dmVXhmU1Bac1RWOEdoYy9rSnp6WjNjV1VSSVBOaGd4UmJuNDNB?=
 =?utf-8?B?cW9mU0s4eDBTRUpsdGN0bzZWWFV4cldFM0ZzYWtuNnA4d1RLTnhtYi96VTZV?=
 =?utf-8?B?dGUvUGN4L3ZqMkxjSWhkOERuUHNzbSsvSWo0NGpkS21zcW9CSUF6TS9haGlX?=
 =?utf-8?B?TlVWTElNR3czR1B5T1N3V2RCMEdUOU1RZVluR3hFSWVhb0xZMVpQb1YwMm1x?=
 =?utf-8?Q?qjnMO9fshHfLDyD+sZpkWHOeSpdz4emJx16zwOw?=
x-ms-exchange-transport-forked: True
Content-ID: <8B55087D7439E84987A41FAE723FB5E7@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffcb279-8fb6-4360-a85b-08d97d67ece8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:25:55.7980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+wfvJiKrVXG3rYsTcVd6szr8TZtigPVMMf32+ARV7u2UDrM7EAsanq5vYTAjRApUf5yvOSUmaTVW67pHUMx5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1326
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_182559_576644_6F1ECA5D 
X-CRM114-Status: GOOD (  11.80  )
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

On 9/21/21 8:15 AM, Hannes Reinecke wrote:
> With unique discovery controller NQNs we cannot distinguish the
> subsystem type by the NQN alone, but need to check the subsystem
> type, too.
> So expose the subsystem type in a new sysfs attribute 'subtype'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
