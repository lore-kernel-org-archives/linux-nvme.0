Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACAEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:40:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E8F60F94
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30E8F60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zfalhlomwACCnynsVoW7/KhO8k6AKS4cmAGKh2K9dpo=; b=qy/gFAZYC6Pe4N
	JRTP7lAAwOcqE+CU1IIYw6nZJHaZw1JIyNxGUbprOolEBA3lWF3HivpioP5xYobi9Rm0w0/3W+0D3
	bUXNqCc4qCaGoPt4pDd55ppV60nOsJ5tVO1cCzdWL3J3juDdnOyKor0S96Oioo8vdO6bq3tdUL34L
	s8qs+tp3eRK0qyySicdSs5npMle5w5V1Om3goTJkaFm++fR00GaGbct9qKmCkrzHhRChc7YZjPb6h
	YchcUIvr7/X3E0+aPDfNX/DRxg8/Gn4PvkilbsHOggnEpRKI+hiKx1UA7nulaZ8hXPmYU2+4NNQ7j
	YWkXp3ZfuKgsN64LL3Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUwTq-00412l-RN; Mon, 27 Sep 2021 19:40:02 +0000
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com
 ([40.107.236.60] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUwTn-00411v-MW
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 19:40:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8WRSfCqZTiX2Z4rBLFK74AckKIaoJY8KgcHTBZO1LJc6Xa2+yAZzUJQ3AyogRLIYcP8k3lYZ2i6ppvOEnr7kmfLu53u8LQ38JN9lYU/wKcnRKsKK0w78ZDw7waah7Xzgk0RuXn2GWO3a0RCf459mnwMN33S3boSGmrQBadix30s4ocK/fHJZc3/EFmQmBpJT2iGhz9vkf7zog+E28dS0kqPmPu4jDbcawMhaHsM485AckMq53tgbBAZ8t1kyRjlUBg5hoZ1rwfpbar7ZYYiCwTkQcyL5taK/S6D/sCYQ/cGbXywRr2Sg8GS3G4RSt035SBBZcv4eiOg9LN6koowog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=MgJEQXAyQ5LiebLtb7fMWcakXkXKU4aEKtrhFXLO0Cc=;
 b=E9NiZkvEUci/Jig0jJ1UTO61roYylevmZnAuCMHadMfwgRcrYZtwVn9qEduvrBOsPXkoxRVDq40BRFZCcwShaWcOeVjLB1xtlqPTu4naALPXpYjMjaIOL4B0dZ0+Qrn+l6cUyMW6LI3bH2HD+SZnaUSoJZkDxY/1pDzZzzJyOEmsKFXZYaxUobV0FbPYxSkwJAmnTMTPmie8HnLL1g8mtRPHSsSdMloySEcXkPdBDMM9bY/Dn6p3FNCmE947dgc8vaTC95I1nsGp7kgwjpuq67UC8FdljoRA0RRfRSQpDnx61zWtEwSxuilyiTBnoYtJiXURHHYKaQIwQGjsdDWq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgJEQXAyQ5LiebLtb7fMWcakXkXKU4aEKtrhFXLO0Cc=;
 b=pSLs+BJW190a/ktX6Mvy21dA4iypVBzZJup8u/a3ZuACQltAjfxTQSooI/tOolCx/q89LU632r/9YifGw2MaHuvtISw04XQ/X0SUHyGV1ezsDMG1tNfPexoWE/qebo401sbMpf8GU8As5qfzszx7yF/TLYDV7smCzCn3ZKM5JQIQVXyUGZwZjCw8e3NBFQuWtpKJ1MuVor1d6eLrVNG/bqwR28OrxWAxGz/qoVS77U1ls0WCZhjUHi0yfhHyvw+rGuINexfAoUJiP1Db15SK5eeyCOzCiq1fdmlOAXen9GTPWoGGyXderfYun0C25wp62LPHWLQQTzZtu5aXQ39fRw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4668.namprd12.prod.outlook.com (2603:10b6:302:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 19:39:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:39:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH libnvme] fabrics: restore hostname traddr support
Thread-Topic: [PATCH libnvme] fabrics: restore hostname traddr support
Thread-Index: AQHXswSrkehyyL9hmE26lgzRscYBh6u4SNmA
Date: Mon, 27 Sep 2021 19:39:53 +0000
Message-ID: <2a5ebd60-0367-6f76-67a4-d5af0a33e464@nvidia.com>
References: <20210926182932.55896-1-sagi@grimberg.me>
In-Reply-To: <20210926182932.55896-1-sagi@grimberg.me>
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
x-ms-office365-filtering-correlation-id: c50673ad-4040-43ed-afa2-08d981ee9461
x-ms-traffictypediagnostic: MW2PR12MB4668:
x-microsoft-antispam-prvs: <MW2PR12MB4668E2B41709C87F25B97764A3A79@MW2PR12MB4668.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PzWbti07wnxto/Ano53P+rZq583AERFllyFVk5BCmjKvJ1y4Ap6S9NvVEbDtCbOeuHF+nTqlSNgyBEAv3MqRPoABXRTRk29NNFGHi7QRwZkQ8HSXpdlGUOpdvlRG2e/Y5uswIk+oMadEgBxFaSoIHuELWKm3CPXQOufJo8/Afrrdf3Go1X35Ivo8YmlaWW6RLiYNuQsKBzzUQwR8i0GTcEXzjjvaIYpPOuZywbXf1+eHhDHDdMWBMdwVqh0mwFWdXjb2MHBkcUAxd11Gq4JNXXWrCnxZX9w9U6z6nuJ+j14YsmHpNWW3sgXB2Vg+dM6GSzM+YiLCjd3rA9o8kJTC4/0y6fVCpqRBR2ff84/4sGpbwg5wTumoWX6+VmcCQYyfY9mefAdzwnQ+r9LI34mAw7M4lYJxDhu4PADn1Y6nqHZTvb+ZLZrOOUAoyTvbb2/dEUH1jiL71iGhNfDPG5Kw80p3y2u10dxMRk8oooowC07fsrLt9YrXuVyTovYNw/cZhyddS6JzQRODI3ZWaHzED6QI3kEuV8jPp+ybLyQL98E5E2ILxfe/QOqVxEBAkmwy7mJlrCPFSP+Oz5ZL3Nk6IFgaUNrePQa3Mk9cNVz8LkFMjtuD0etD5t+p7R3NzW0tRxO3CxZbObaXdKQWA+FEGXVOn8FL7zUxPrZHZkbHAVgZhSFir8mb4C28Pjej6X5ZTJ6UuRzYBCrRF0QeBDzthN58pSPn6jd7n/qFoFU1A7jYz647ekYWmS1VEBEpNipItGiPBjPZnKzqMUzK8iPoyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66476007)(38100700002)(66556008)(2906002)(316002)(508600001)(2616005)(71200400001)(122000001)(6916009)(86362001)(64756008)(36756003)(4744005)(31696002)(66946007)(66446008)(8936002)(91956017)(76116006)(6486002)(38070700005)(8676002)(6512007)(26005)(6506007)(31686004)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1FXTXB1Qk1qYXN4UmFzczgxcXdFZW5BcXFQNUhTSGRUcnd3V0dDVXB0bVRy?=
 =?utf-8?B?VHh6QzB3dm9QamgzNmk4aXdTV1dSK3Q2NXl6RVNLMllJNmtocmRkL3JnM1Ax?=
 =?utf-8?B?WGFuMU83VTlORkdvVm5mLzRKd0k4Z01WS3J5WGp2bFZ3Y0VOcldIc3JXOWhQ?=
 =?utf-8?B?dGd1eGpzdHJHVG5hWDlXZUxKVVVsaEkvRkNiVkZQV3BvQ1VJVjBGcWtiS1JV?=
 =?utf-8?B?c1NIRG0ySzUxc2xXRFB0dEMveUJiYXJJQTlGU0VkQjdNRUI1dHdRdmFLdVo0?=
 =?utf-8?B?dlVodUxBeDM2amNPNmJIQi9sb2dQTEh2WTRpR2t5Q0dVa3VRT2xIZXhMdHlk?=
 =?utf-8?B?Smw0QXVMM0ZiWVA5ZSttVXpTZ0lSK1Y3UGJNYnRtT3hRcDdEZWZUQ3E2Mmky?=
 =?utf-8?B?LzhDSmRUbTIxK2Z1dm9aNVJkc1M3WWpJL1dETEwxdTducmF4SUpNN1lZdHg4?=
 =?utf-8?B?WHhTZTJHR21wMEZvWTNQbjhzOWhHSTN3MTZHS0lQNm95ejNXeHUzRU8vakFy?=
 =?utf-8?B?a2NVNzR5dTFXNGRsVzhzZ2MyMDVHbE5heGVUcUs1ZmtKTlBOa054cEp3Uzcx?=
 =?utf-8?B?dDNWdGJkazBhUG5odzVGQlo2YVFZdUZrTTdXSzQrUmY0YVhSaTFZZUZzdGly?=
 =?utf-8?B?SEJtM0RyaFJVWVZyUUlYSmdhSXh4L0dlSXVnYzZWbVdCNm41QTBjSjFicFFI?=
 =?utf-8?B?UXdFUUJrU1EwQmhRNGk5TzFPSU4xYWVXTDBHemZxSWt4STlVMHIxNDFaY2JM?=
 =?utf-8?B?eHhWM3VqNjlNY0MvYWV6MStRd3E4ZUdieTBVUXZ2eTZUZXh3ZkRUc1NxejBv?=
 =?utf-8?B?WDFSTHhiUzhiU3ZjK2l3b2ZrblpHUE5vT0ltMklJVW5aTjlXZWNkQlRHZG1Y?=
 =?utf-8?B?Um5ZeUdWU090aEMzcm8yZzFFbm0rRTdkSitOMDJvQVBFQlRsc0s4TTlyY0NU?=
 =?utf-8?B?YmFDaE1pM2JOSDg4MmdjTnk2Z1E2TytEaXh2Q3hMbzZNMHlnaE1ndXhsVzV0?=
 =?utf-8?B?ZHArVWVFMXBnWWJjV20vTHdBNkpiYVhyZnRGbjBRVEt4T2VNbk9pT2pZU2dH?=
 =?utf-8?B?c1ZsZ1RUM2NiTnF4WWJrN3hSVERtYzcxWW9DRnJQM2JTT2dJZjlneUJKd1I5?=
 =?utf-8?B?dHhKMW1QTlp2ZWRyaTJnZmpJQSsyY1UwS2IwdUpFMWo5K1F0ZHdZc3V2T3Ax?=
 =?utf-8?B?SFhXaVRvbWtpN2ZvM1R3NWFiUmZIZnY4UnBEZXdjZVFOdGkwYzhiK1hZWDFu?=
 =?utf-8?B?RjNNclVpMkYzalphZitUOVorYTBqLzQ1Z1F4SWJNaWJPbytFcXVtdWZmTHZ0?=
 =?utf-8?B?Uk9XUFZ0c3FMWjY0LzJlaC9wa0hMbTROMnRxbHpYTzZCWnpCRGRxS0s4anhF?=
 =?utf-8?B?U1hHWnNEOE1KeFR1Y3BKam9OV2oxQmlOQ21lVStRVkhraGhUQkNpVVBTWWg0?=
 =?utf-8?B?NFVqUjljZ0xaMFNPWXVYeFIvYlczWVRwMnhlQUE4a2pKTHVTdEdZSFJ4aWh4?=
 =?utf-8?B?elU4R2JHODFpWWR1Rnl4bkwvMjFKZlFlWWJ3eUZicVM3dDMwUk5xR0JGSU02?=
 =?utf-8?B?VWsySktGaUxEdEhodzRWSlh1WFJKeitHUlNXR0o0VlMzYllpcmtzNFdtWUYy?=
 =?utf-8?B?YW1QUkRSZnh1Yk9KQ3FmSmZYUkRLZFNES3hoZUZ3T0w5eURsV0pXMWR5R1FF?=
 =?utf-8?B?QSsza1RPSHZudlV5MWZuYjFUZ2VMeXVKK1JBVzgwYXNOZUdCUkVDYjRIbkxI?=
 =?utf-8?Q?prU8Mf73T/nNS1Kr2dtaUu45xtGVyN8+OS9h11x?=
x-ms-exchange-transport-forked: True
Content-ID: <56D7F4A459A4B745B3178C640E982D37@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50673ad-4040-43ed-afa2-08d981ee9461
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 19:39:54.0055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0fTvbwa6WobbVJQDxjVhlE29cuoei1v2+0rbtNxxBv2GypTeLovA8zuPReSvwnJMq9WBi6AvmX629cPzflB+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4668
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_123959_761234_2350D8F5 
X-CRM114-Status: UNSURE (   9.07  )
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


> +static int hostname2traddr(nvme_ctrl_t c)
> +{
> +	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
> +	char addrstr[NVMF_TRADDR_SIZE];

do we need to setup the addrstr to 0 with = { 0 }; ?

> +	const char *p;
> +	int ret;

With that comment looks good to me.

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
