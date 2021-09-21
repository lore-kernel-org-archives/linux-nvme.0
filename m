Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14E1C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:21:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7254D60FDA
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7254D60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1PosIo+JvD0E0GfZUBeerJ0GiJXW/nvzQ7sMWUjONOI=; b=qqjH2VS7cJmnOO
	ZLV/GUJGQW7rhaVSugpX8SyG+MTqmWS9a3XjJ4OcP/bh0Vb+T93zbl0RvCuRupRACyTUfAHANsANU
	qMlHlcWAx5JxgYilpdoV3vwgeR5NEoII5YEhZOKK9A327yDotameddQRbn4d247Y5deDnB/teua0B
	D0Xn7qT0ykCFie4FKLbeuRIjL9H2D1B3LN0+KmHMChcFBnn7rqrB1zPnXI5OUHlnQItf8G3XgYX1O
	RSaocb+bDmWJYDW837sVNhfHSnRbAnrhee0cIqr0y/NgW9DLISRc/KZKqXoKNSIUUKYCl8QnMFRi1
	F/FelRqoSbIH7liD1Elw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSlKb-005ayl-LU; Tue, 21 Sep 2021 19:21:29 +0000
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com
 ([40.107.236.53] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSlKY-005axV-4K
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 19:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8ffBk4NMHfdbNulnGeEvoJ3+JYbnXqaDfvbqWoAep3htiArBwaOBCyZo9xSzHMJSvihUkqmHC7MRXGf1xSq17TrfBGtEe4tnIhoHW7sYL6zJQ8yvqFZYeKVL0zr3li1DNQ5FFWcGlVEHmUITgiEbd7uhuyGwXP4DTGjGlk19q1unndDc5lnY6JIFjPsRYoE2BYu1l/QqwEp6nkV7xX3WXvj7C4S0HY+qc854vIuj9pBoPc2plYko1k1iOXCkHaHIi15djBU1rlkYta+puOfQ0VKfuw7NCMEoNwCtN49OALvSKeqeOgueZJ2XJDZm3s+ibJXY/CjHeHA/mpo6fo+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2v5nk2SWSmfI44s2VaBOcR1bfJAW3h9rGfH734PqN9w=;
 b=bL4n+lgXwg6/zK6iXcgx4YCDzzyEZyBmVa+pu6Mi8JZZDwCVo9OyI9G6KO5MbIOP69NGTqlez3Ioj2yLXGr2BUKbYXD6PLyobzcu1LFNXTfW/NHZ/ewIxa2g8Op5H0lMModrbxs1ZidtWVkjh6gfbm3kLibZ8h4XFin9f/8GDPyBv44vewNmwjkh5LBO0PEH1bx8opjfr9wWX6GFzGiMZ8YbRMpY2lojPUd8dc8uESm+6KEV+Q2IVTzQ3EB4bFH45Q365UY+b9FhLVaG2l+uFPLeEo3mu4kf6iESLUc+8x8kBJGqYSKVLMCtrmsMfaLucvV0IGZ23e6hvytMD9Bbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v5nk2SWSmfI44s2VaBOcR1bfJAW3h9rGfH734PqN9w=;
 b=PByUZbysIScUAiZ0AxKj6+7kCy+kLwEFstSZNcQH/mTi5AYYjsON6mYMAsKceufjM5nIHmyoHmIimoOQB3NKSw8RY9ZsKPhqLwCPzR2zgFhq1D6X8RgyjdPmsg2hUwbA2E5SE8IE4lWoEGeutUAR39/iN5Itn3CQQRCN9Lmyx6bgMZU3jWUKehkyRek84Cy772G2c2nn8cPEmqdH9OQCCBRnXRPfn7WTtGEzc6zERrFnROFobozLI20jP3OnvgHMwPCiR2MI6xv0umEdYzoCAPJVfn2IE7NPyWq0xmOU+Xh6weKHIrWu1qbb/dViO8dnU9TbeYwGB991yrFcR929Lw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 19:21:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 19:21:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Israel Rukshin <israelr@nvidia.com>, "mruijter@primelogic.nl"
 <mruijter@primelogic.nl>, Oren Duer <oren@nvidia.com>, Nitzan Carmi
 <nitzanc@nvidia.com>
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
Thread-Topic: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
Thread-Index: AQHXrxua8qNQ+ujDo0+6QqIoACrObKuu3YOA
Date: Tue, 21 Sep 2021 19:21:20 +0000
Message-ID: <7dc65d21-950d-6233-2bca-f33a6da2b27b@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
In-Reply-To: <20210921190445.6974-3-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 403d0a0c-11ba-40f5-3704-08d97d34fe72
x-ms-traffictypediagnostic: MWHPR1201MB0158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0158462BFFAF8C9EB5206478A3A19@MWHPR1201MB0158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVffvqkrwuffwzdGYFlynrUFHjup3VQ307qOBF6CkBQJTh2zrAdBHKa75FmY+tv6J6nDXNcvbW/MUmZYuZrkC7/ojP2YbkQAJ6WFqc4EFL+Ds5LLzWObxP2EdbR62rdtXSTlG/CWNIsyeE02578K9vI2gNCTf4GugqMyfj4qsHwbTPpozNGp6C89bBwfWeGWtTWk7F7cAuwf/cWtJCfyaW0l6Va80C0VLTVQGXCpvji6dURp41rtuS6THNh4z8jgKy4ql93avYCB4ZQGiI77XWf02ZeKqLAdLHkH7bsOWkf5UeCtkSquOAXfmYVmTKoS7FvtkkJnlFpMS0Q+LZRHtXrl1FTX+9DgVT7kXV2eC+ST9Z9ne5f4YuqBPE6F0ZwPAiBza9A8hEHM/69uss//Qrb8/4TGExEveC7bd7t+5gQvpPyYXZKoihFnOJUHt/d5skg+FsnwyMkh6jNzxGbNSB4+TVEiyPZd7BCqRpehrdR0xCGicFxvA25uk9gWZY9a0HklpCA7XkjCUykwhnod3Fn/yrX48mlj4HTkXvGezCOzmHQkD37D67Q6gL8TSlry2lh/8w6zKI/qT0FmM9zkzOP2yzbkIKko/WBXgL5hOgRgWErGrGlC8ic0Qc4qB3wvno7cVImzIwSwW5sOdyeeHLIC/uTkzhXa1SUNzKj/6VVydnSdJHksPhYjvHHLQ+PvM4qON0Jr5jhd4tKiTnuGQ00LwZbgKXcBCs5KxaiteHX+oj/5JKAqfHEeipdENhXIjGQ6twyLfTToVJgwrjzv1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8676002)(54906003)(36756003)(66946007)(31686004)(110136005)(6486002)(122000001)(5660300002)(4744005)(6506007)(53546011)(38070700005)(186003)(6512007)(2906002)(8936002)(38100700002)(31696002)(83380400001)(2616005)(76116006)(66476007)(4326008)(66446008)(508600001)(66556008)(71200400001)(86362001)(91956017)(64756008)(107886003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmkrRW03cG05TVNhaTVXdjg2Rm84aWRRWjJDQjlDQlJmTXc1azBCVVRmbGs2?=
 =?utf-8?B?ekpZTlNSdEFVTnRFLzUvMEZ4bG9WakY2UUJCR3NPY2pZWmhoaFlNbzhmK2xo?=
 =?utf-8?B?UE9hbWg3UWR0TkVLaTBkYlhZaHV6dlFzZ2dFckxMeFEzVXhwWks4Y1pwbFlF?=
 =?utf-8?B?bVdDZ0NlTWJVZDFvbHlBNmZLNy9aV2VHSitxdjViUnVoa3haNXYzYWlMQmhD?=
 =?utf-8?B?dlVRa0c4RkNGTk1iRW0xVU9IczdUUFlDZ1lwQU1sU0hXc2NzT1lQU09xdmtJ?=
 =?utf-8?B?YkhMMTBtdkRRYWtERU9sc0oxN1Q2ckdwanJKQ2U3ck9kSnpPZEViVmMyM082?=
 =?utf-8?B?bmlGdlJlQUlNSzlwYWVwNEtOYWxGTUN2QWpaVEthS3lxV2hNU1NHTkVEaGsy?=
 =?utf-8?B?dHJzbzlodVB3RlV1OUw3TVBicCtTd004a0k5VjJzVEFHa3hSTEhZRTJyajhM?=
 =?utf-8?B?WFhUS2dwZHp1cmtDWVdSa3lVSEpGRzZZNnNoTWNvbndBTFY1M2FBKzRQc2Fn?=
 =?utf-8?B?cUdXdnNHZU5ZYldCZnM2TTY0VGVvVVV2WXJxUUVFQjdGTDFYSHlSeEt3aE93?=
 =?utf-8?B?bEdFWWlBdXJmQ0c3cmhjNDZkdGhIRDk3ZGUvYkdjMndJNlBTMUhSVkkwL2Z5?=
 =?utf-8?B?OUR3Z25tUkRnVmN6U0NLOEVoejU3NCtWZ1ZSU3VUQ1ZNdWZ4ZkhLWWFGb1lZ?=
 =?utf-8?B?Q1F0Nk9XanNsR0lqbEFxYU5sZmU3aWNsMmpJcDdFam5wc21Ua0JzN3dGN0tl?=
 =?utf-8?B?KzFCa2RDOGhocllrM2t2UHhHVTNMSEZMQzJoRTE3N3EzdWVobEFDY0JSdkk5?=
 =?utf-8?B?WkRCR05sSlp3U29aNmFvSklra1ExdU5QTUtHUm9zUTlkVzlIM21BQ0xzNXhS?=
 =?utf-8?B?NlM3ZXZsVGVERzY2b3N0TjRBOXRTVy95TzNIbGVsQXFySjRGTDlhcDRWNWNs?=
 =?utf-8?B?RWVscjhhZ2lObXZlQStZazQrUmpxY3l6NFJBVzdSSkZ0ejRsMVZwV1pTcjF4?=
 =?utf-8?B?TXRsRkNBL2dLY3g4N3B3TlNsWVlKVGtYN2x5MjhzU3ZGeVBoUHViUVZHei81?=
 =?utf-8?B?OVNlK3B4UkY1aHY3aWpIMmU3Ni9xeEtHRFBjTk1ydHp6T0JPa1JIV04zWllO?=
 =?utf-8?B?YmpUNXVKU3dlS2FTKzVWamVxdnVSSHUxWWJ5ektEelRvaW1YR1Q4Y0ZHdE5K?=
 =?utf-8?B?ZnptMWZmaWoveWZJVXhseFdHZnhITUNIenlhWjFxRWFtbU13Z2lOQzhYRFda?=
 =?utf-8?B?aXZHSW1ZdmplRFBaWGtkbzFiUE42cmozdWswQ3BYZE1tUklUVzhvb2ZLcVZ4?=
 =?utf-8?B?cksvc1Z0WUlFSlFvR3JhWjQ2bUJBVHB3UUtTS1dDOXRRY3hFVmdKUHJvcEo3?=
 =?utf-8?B?YmNxelJPU3Rjcm5tUFF3MER3T0dJTUhMd0xSNjUwdXNTRk1wWDRqQUtjZzk4?=
 =?utf-8?B?RFU4QWtJdks3Yy9reFBOakpmY3hzVmMvQlVpWnJtYnBGWmhsaGtwYVNkRlFu?=
 =?utf-8?B?cEN4VEFEVGJ5M3pzVytNYUlBczhUMmVtN2VqUmEzdHdob1dyS3JFTW9mVnBC?=
 =?utf-8?B?WVJ4c1Rid0ZNeDNIYkJjc1Y3ampNTzVyWWNpWUZ3UmhtOFA5YTdMbjhDOEFn?=
 =?utf-8?B?cmhTU1NXdnZIUm9Uc1M2OHhrckNjdjJGUGdQcGkzOGFwdkoxRVBZbzVWeFBE?=
 =?utf-8?B?aWRYVnhna2lFWndOZVk0bjREZ05OaXZ2c2xHaTNnQUJ5OFVjdkcvVUl2WFhh?=
 =?utf-8?B?d0g5ejhIRDRhRXVPVjc0RGE3MFBEL1grZjluVVo0RzhnMm00d04raXRmRktZ?=
 =?utf-8?B?eXJJT090NHpoWDVmSFBhZFlkejlxdzBMMnZtd3dJQ09wODR3OU52c25aREIx?=
 =?utf-8?Q?OoutHslP1jfTe?=
Content-ID: <CFE33E2F069E4C48B012F53631F83887@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403d0a0c-11ba-40f5-3704-08d97d34fe72
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 19:21:20.8506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GqgRnxgKSL5lbU5eDKW4X7fZGK4QcgOQLVWvB6gX8cjhWKHNnmefUQht4+bYaBbL5vRTZxtVL272Dx8tWgqCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_122126_219544_4F37FB53 
X-CRM114-Status: UNSURE (   8.89  )
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
> Limit the maximal queue size for RDMA controllers. Today, the target
> reports a limit of 1024 and this limit isn't valid for some of the RDMA
> based controllers. For now, limit RDMA transport to 128 entries (the
> default queue depth configured for Linux NVMeoF host fabric drivers).
> Future general solution should use RDMA/core API to calculate this size
> according to device capabilities and number of WRs needed per NVMe IO
> request.
> 
> Reported-by: Mark Ruijter <mruijter@primelogic.nl>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
