Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 06:55:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454776162E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 06:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 454776162E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tJky+BF3xE2/dkWPEtDj40cxlaMY4nL105Kr5zaso7U=; b=hFkcyQ9eUvkziq
	QHlNS70KVeE0H4GynJfuTewrq4uyv7gWaYxb5CUsC0YYSpdoUkAT8EhlZGBRSrb/T34pVPlBrlbU2
	Mn+ke+QWwButBTWwiE1BSfvEfMn2csNnfM16gF0mYhlOM9pIBK4nmmRsl5O2odhw5JYrxiCL0J8lp
	lDxvXq6pDjM3hi1b//oVXzVrdm5BaI6RfsdfxxJTjiYeqknhA/6PqIXsJfTERv6vP95uUUAccclzN
	Ggd/X/yEG/xJtJCX9JyGBvrbuTDNCScUOXV1Sotvg9u976wMYrUQ3PP7RDYr7+QOq0DsOtIwr2Imj
	0ldkb/iTRDIGlhxUqMhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVpyI-00D77Y-T7; Thu, 30 Sep 2021 06:55:10 +0000
Received: from mail-bn8nam08on2074.outbound.protection.outlook.com
 ([40.107.100.74] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVpyF-00D76z-TJ
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 06:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCMReTh3MG9LV+vW91v9HI/KzCRhd5vPQImBa39CBlRpcNozVKORa808ahkDdw70nDbBeoHwpF9+osY+DqmvlqbLDatGQ+tRgdfAsE//Q0BR2YpAGx8OihaobWgHC59qVd4RPkg1uT7mN2PAYq/XhAqS0vmZoubh31rEze5lHnqDzCRkBUy3fctbUPGXGR9L8GkrlwCTKk5RoTOpU5IN8kgczUY3+FeN77xOTKibW4ZQZNljRhQY401tV0pWsR0yzscmvnWDrjAz9PSMCX4LXm5SwH38QUKo3fWpA2Mg0RiKTI8Q6YlZmGUHdwxvbY602JriunXg/vdf2NAQbPuD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=r40k089K5U8WhBTQLGlLxENQCzJiFgY+KV/oZg2Y1PQ=;
 b=B6g9TKMmk1ClOwNLh8jBgeQhD1zuOg3Jbpm0Nq5xqiMpDWnBWevyyjXC50uPChgAh/iey44UVXel0jivrBMoJKfJF+Vb02skGfazA4BTbKT/V2iVp/i24hDa4QYxFeHCEocKMDTpDiAeaNGa99mpQpEaYmNv/WQ7yCQH0UuLHWCN9kQWBYouiuwdTKg7eQUxx1hByU2pC9JYQPE0CgaGgJsWBSK7/ASe7yU13qltT4PezTHcHG4o5BtwPHt2v+sZN4pDS4/qE2G8rEcZIzjOHAv8bFTFoTz/yzRM0bsLtA/sjGaKPjUMl6xYdrV6VYaLiAhrVFhSiBbUWasDN/5AVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r40k089K5U8WhBTQLGlLxENQCzJiFgY+KV/oZg2Y1PQ=;
 b=GeR96uzOJDLKfEKlQezq8GPAn9pEtHcPPjyT+hwgYewIjSkg47wf9zb3anPlVQ4EyN7JJTIt4O72viFY8r3beQFGnGoByMjm2rpST5v22HzhDXly07AgDzMzqhG9FodfXtA7CqV9PzMedNARoLSkeTdZNYmZ4F0Fgn3szHmWitAeD7tqumoD6hAkGwxE3aTkCrmsrqAFSYbNOVUQabds3y/KJzIlQBLWoXSMQs6nDLZf919tKNW9pW7m17R9QApggZXq6/M9JKq+8kNdIcxDFYbEMkKmEc5B2lgZEuARUq0HCM6YyPwppoVuzDTnX/g8RJme8BRgKVRLVDf6Wxi8dA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0270.namprd12.prod.outlook.com (2603:10b6:301:4f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 30 Sep
 2021 06:55:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 06:55:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Topic: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Index: AQHXtcC9fdM+ebBBsEqJOm6MgbwFyau8JKmA
Date: Thu, 30 Sep 2021 06:55:00 +0000
Message-ID: <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
In-Reply-To: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 115d7e79-3695-4178-f00f-08d983df38aa
x-ms-traffictypediagnostic: MWHPR1201MB0270:
x-microsoft-antispam-prvs: <MWHPR1201MB02705435BFED77604504C3F1A3AA9@MWHPR1201MB0270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbA1iMJpj4be9tFahiHDXuksmH38ILmnivf2w7tl2kTFNCWe2q6I3R2PKqPrD2M43lHCQXvs4vF8d17XFaAbJcgUeY1aHZhJKUa7DXC+m24gPzMXVLzbliqJ/x/hodgJscuUzilDi7AsB4mtdrPPm4wK5SHcrDgYp9ABE5WzVAnjC6rIafIWOi/penlCT2dvhFmbq1Mxll4rc27O4I1xbfoRgc+pr+X2xtDH192XmQQmp1ZSzvbDJDDXvqgkmcMmpxswoeXF/JD02Igz2LNnppp71/SIWMahYYvPKg6F5PR0uhuehOTVcN+EHiLA2GA9ZMOj18msOgNGQ8QOxIbPn4z5SLD/2iWXYf1GQUNW3d2P7qAIHuLvgYkTvzrs+3EezUHjJ+FsC4qU9rE8IN1/Lgeab+nEJ5l41ReyHAwxyoMOnBrszONmMhZA9SuXlhrhgjmDBhh8VVFAKmwHPjN6zAG5uah8cyey/BsuMQ42x5Mw1VJyUW+Xq7kaYLCl/y8BZntrhetJxfC3aozVQKVSJ842H6qiE1Sd5v5qG2R6iA/USmbZTtrPrCaxw8pDns1CjbxD+b3jvhsQl/wp1kVf+cd67t6Xfgv3OHjukgaivh9DLYu2ogDl7zcIPNEoshI4jHIxTynIpnSQ9/XFr1U42xjMECI7VNG6i5SejHqUPU5/X5O3nBTt1Ip2z7/n7Oe8wwPFQ79GJxg7KC+lDmkLyCqUBTBjxvaCD3HUy2VG2uKkueJamq/i3V6OKMAM4Ex0Yhis+wFlNBdvFYg8GhxD5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(38100700002)(71200400001)(508600001)(91956017)(76116006)(8676002)(66946007)(64756008)(66446008)(66556008)(66476007)(316002)(122000001)(31696002)(83380400001)(86362001)(2906002)(5660300002)(186003)(38070700005)(6486002)(36756003)(6506007)(53546011)(6512007)(31686004)(2616005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlE2V2dPS3htTm94VnhKMjIzTmc4RDYxTExMREVRY1FtdFRnVGQ5aHdhTDVP?=
 =?utf-8?B?WmhpazFNWE5UM1JTS1hQME9pcTFHelNndVBHRHA4VnlDMHRwYWU2VEZhQTYw?=
 =?utf-8?B?bU11VWRYcEd6L2dCM2JKYmRyd1V4Yno2UUk3TEgybFc1LzR6Tm9zUTN5Nkoz?=
 =?utf-8?B?dFNZYjRXUEpzYTBWSlRIQ1BUeGpOR2VIOUZ3OHRyZmlLREdPUHJjTXo1Y1lw?=
 =?utf-8?B?Zk5HY3JWV2c3Y2x4WEJtdHpnS01tL1ZtOTFDRU9UaGVoTWdXZXorb3dzWlM0?=
 =?utf-8?B?ZnA2OFdIUEkzMk43c0I0ODBnWVhyRFJvWGlsRVJSM09iR2I2aEQ3NnlFK2Zl?=
 =?utf-8?B?OTZaWnFINjk1N2ttL3pHM3phcFhYNjY5NzJJL2lIMzFBZnZmYWJ1Z094Ym50?=
 =?utf-8?B?SUlLanVHamNTdzY3b1dHWUVEd01MMGFrTGV0Y0dMR1VmdHBYMFFuRUVidmcv?=
 =?utf-8?B?NXZwY3BFVk83aHZQQ1VQbHBvMUR2YXBwSUszR085eFB1R3k2N2ZVUUVFRVFu?=
 =?utf-8?B?alFRdVR4L2tvWTJ0Um5lNmJzRkd2V3JHUDY1V2wybTI1SzM3VEk2ZHpYTS9M?=
 =?utf-8?B?aUVhM1MydDBRU00rV0RCZVpod0dYTnFXQWFScG9rZ2hUZW5tZjVDOERtMEFS?=
 =?utf-8?B?WlFIbE16TUZtUzlFZTJMaGkzbUcvanJpNmZCbll2Nk9kem9hdmUya1FNWmdi?=
 =?utf-8?B?SVVXeFZPZ29VU1hoK0czR0l6NkNaZjFuL2s2dGNiQjdIYURoYXFXR3Z6Sytq?=
 =?utf-8?B?QjhUVVM5bENSODR3WUZ1UVVHT1FBWWRGd1VLZU9ENzNLczBNcnlQZjgxZTZ3?=
 =?utf-8?B?MjFSTFgzdjFGa1RDNmF4WUc1dFE1VTU3TzhSbFoxY1FxRFJyc3FBRllTMHBN?=
 =?utf-8?B?QWxyMG9MVXlTRUQ4ZGszWVlLRXlmWnp0MElHSXg0Rm1LUTBBNi9ReXBsOGp1?=
 =?utf-8?B?MDNPU2VrbzFDV00yY1pkZlpUcjQwOVlpcWVjUjNxRHhkemViaUZ5Qno4WWRx?=
 =?utf-8?B?b2ZONFZQUmE5OUM3VU1qT2QwWDJOSERjR2lRTnVQRkpCVlhWVGdvSUpja2VM?=
 =?utf-8?B?b0dCYnZuZ2tWZHVyUWpnZXpWNmRIcGpnWklrNER2Y3BjYmp3dkNpWjBjbStn?=
 =?utf-8?B?RnNZbnI1WjQ1VlRzbHBBcHdOMmFYbEU0NzY4Mm1rb1cyMnJzVzBnNHlYbzgw?=
 =?utf-8?B?N0cyVHFQd1ZqOFZNZEhIV2NVR0tQZldIQW1BdGFCQVZ1M2pXNEhJUmRsMnN4?=
 =?utf-8?B?MnBrS2dFWFZza29DSVM1TDhkYVFFL202cFJvNEZuZ0pqb21MQUFmVmpSdllV?=
 =?utf-8?B?dFJOc1h0MlMyRkt3TU9hejEyZllpUW1Na0pLb0diYXdXS0lnZnhheXJmd2JY?=
 =?utf-8?B?NG1GSVYvS1dOaDhHM2JFa2hCYVlnaXA3enlSTFRxVXZ2YXRORlg3Y0w2eFZn?=
 =?utf-8?B?NWdUcHV1Y1R5TVlPcEtxZml5UzdCcXR3UHg3ZW1IT3BuNVVza2h2UTBvT01M?=
 =?utf-8?B?czErM1RlQ1QvWkVkbE9HWHkwVTY1cjNKYm9KSG4zNmtGR0E3SVRNbHJVSjhv?=
 =?utf-8?B?QnFyOE5lUnpsRWY0V24zUnRMaXdvdnRQb3JDcHNyTm5OSTR6WFYxbXdvRUJT?=
 =?utf-8?B?anhiZ0VIVHc3VHdNZnVxRVoyTzJvYWxLT3FmOEwzWW1lU3VFbTdJWHJicS83?=
 =?utf-8?B?a3pZUFoyUjB4KzUwS1d3WUMrek1ERXBpQ2Z0OENweVhldk1qdjA3WmNvMG9v?=
 =?utf-8?B?SEtVRjhOYUNrRm1LSDBrbVpja0hoZzUvbWhSV3pWbU4zWEtxdzcvS3liN0Yz?=
 =?utf-8?B?aWsvYituL055R2xKc2ZSZz09?=
x-ms-exchange-transport-forked: True
Content-ID: <672E2FC611CF704E9C887964242BC5CD@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115d7e79-3695-4178-f00f-08d983df38aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 06:55:00.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgvpFVpmgEFh2uvWxXbl9V2rYnibEdCtWrsTACQzXTgFoCYNfC9G6xqOvKjzBHe/qpGu+q8pZ26GvPQiIn2saw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_235507_979359_46C5065A 
X-CRM114-Status: UNSURE (   9.21  )
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

On 9/29/21 10:59 PM, Yi Zhang wrote:
> Hello
> 
> Below kmemleak was triggered with blktests nvme-tcp on latest
> 5.15.0-rc3, pls check it.
> 

Please share the test number and the frequency to reproduce this...

> unreferenced object 0xffff8882bc8d6668 (size 8):
>    comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
>    hex dump (first 8 bytes):
>      6e 67 31 6e 31 00 7b 7c                          ng1n1.{|
>    backtrace:
>      [<0000000046e1c456>] __kmalloc_track_caller+0x129/0x260
>      [<00000000a8f7a3a1>] kvasprintf+0xa7/0x120
>      [<0000000076a54cc5>] kobject_set_name_vargs+0x41/0x110
>      [<00000000a569a16a>] dev_set_name+0x9b/0xd0
>      [<00000000f793cc3d>] nvme_mpath_set_live+0x322/0x430 [nvme_core]
>      [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
>      [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
>      [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
>      [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
>      [<000000007be5c512>] process_one_work+0x9a8/0x16b0
>      [<000000002ae51314>] worker_thread+0x87/0xbf0
>      [<0000000034c41079>] kthread+0x371/0x440
>      [<0000000020c3a70f>] ret_from_fork+0x22/0x30
> unreferenced object 0xffff8882d1509800 (size 512):
>    comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
>    hex dump (first 32 bytes):
>      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>      ff ff ff ff ff ff ff ff c0 b6 b7 97 ff ff ff ff  ................
>    backtrace:
>      [<00000000d6c8d6f1>] kmem_cache_alloc_trace+0x10b/0x220
>      [<00000000e6493d28>] device_add+0xe08/0x1d10
>      [<00000000aa40e6ce>] cdev_device_add+0xf1/0x150
>      [<00000000142436f1>] nvme_cdev_add+0xf8/0x160 [nvme_core]
>      [<00000000d948ccab>] nvme_mpath_set_live+0x347/0x430 [nvme_core]
>      [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
>      [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
>      [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
>      [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
>      [<000000007be5c512>] process_one_work+0x9a8/0x16b0
>      [<000000002ae51314>] worker_thread+0x87/0xbf0
>      [<0000000034c41079>] kthread+0x371/0x440
>      [<0000000020c3a70f>] ret_from_fork+0x22/0x30
> 
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
