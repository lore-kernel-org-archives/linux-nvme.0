Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A584EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 04:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ugXADv5a+YNNLALd3SaRmEgLnOdRkELGmEbRjY7nUE=; b=UOFULqcCa2hE7XCz8SK8jcgCmR
	j6WtUjLJFCPaWSSvIZq8qC8OujaS8YR24I/FbBzRVFY3Lknf6rR5kCjNiN2FvkoAQcMez8Rntkt82
	PrBSe7Dady8rNEbpwW9Hjo6+2XjHjEsumR9Bm+RBOlvn5XPf1GJ6WGn6blsmVRwLNARKr7m90GOfh
	HSXciPaJK79xl4JettxYxWoHJ1RvAaq1kI3XogznyWuKxl5cxAx9DlvJ39dqspe+WVnfx8PK3DK63
	tTjyJB4E6tasxtBx8z+owF1nVZuusKLdGHKBqh7+jY71G7T46hsVxHxJ32vlhqmjxewD1UVZiWbHI
	CRfMcFew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIiyW-00AQTA-2u;
	Mon, 10 Jul 2023 04:58:16 +0000
Received: from mail-mw2nam12on2060d.outbound.protection.outlook.com ([2a01:111:f400:fe5a::60d] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIiyT-00AQSc-39
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 04:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpRFcmj1xuoyMvTOqfXelKONa25GTeMh9OE12nj4bbwpCtDVUEWTVhJIU0Fc/+ieC+LzxCXvjdPRh2iZOHpxGjI5AFOHzb6ejgbE5P0xgEM+KEgpM5oquEQAucGqcamdIUG5oOm6gR47MSBdMZS1enpiE3yyTtbK7BoSnHkvpuSH79K9cLLok+lhvV9HrQ1RyvQcJ417NxWjHr/mDAlc4YUMkw2thLB6jO+OKZvVWFXGZVyoU/eNamADiZNuheI8xk1FAOo2AS1FTA7DYVZq3283sj6CP9I4x5hGef57WmN34zeMgeHRi9iKp2rSeQqYf7G9sVrRn0fhuzGb45iCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ugXADv5a+YNNLALd3SaRmEgLnOdRkELGmEbRjY7nUE=;
 b=Wds3ZiAMXXJWlfu+819gHSOUQAUBH5gBBKUwhKcCR8X7ITvO6Czgu6D9DqsWbOKKQious43WORD/4E03K4PLtFoXcjD/wQAzZmKS4uZs0UBtM2JK7XPTXie8zJxNFfTNFE0kEPeaL1AMS12kl8bQBo7l8pgH8Y797SgqoLLV3YXx+YFyjLs++OOKiSquzazC0wdxdKnQ6Yo2XUA8qkEUTcZvtp93QTBGh+mQDEPreZPtK9iCqb/zXSsrrzo5Z+KC9H4e3V8JQaspmz/DgpdkaXomtaxpU8g9BmI4AuYtUUKdC/ND//mrsbWjuaMcbmVfBaDCa+V+p6YmAFk+KqAUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ugXADv5a+YNNLALd3SaRmEgLnOdRkELGmEbRjY7nUE=;
 b=t0NGAr9xxqxlZbOOQAVKUzAGnj6P9BqrwAf5NnmOHNTJceNCgD4MMz+iVvAd8brjbv1cxEIxmjFkIH16c+tCEQF7XOYaOHnIRyOq3cR3/1EZaKfwNl3bIMXc/dkN22JRimppabYcPLKLAIgtJ51Mdl6n2xCYB8TuBkVh2nrqCI+MWJTV/Iekb3hB49uq88eTHijrHdYh4IIL2saPkbtBprJQ5akUvB5sOL7qYD228wkHN0BC7rr8jF0XvMrfxgWsasxRsio/rvDrJf7gDIzxsjRFpMFm8PvPg2p/guLgL5N1mlqR0L5iRS/LCzqcvRL6rvc0gkfdZE1GZsL2sTtSFQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 04:57:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::ffce:fb56:8f01:764b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::ffce:fb56:8f01:764b%4]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 04:57:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: use PAGE_SECTORS_SHIFT
Thread-Topic: [PATCH] nvmet: use PAGE_SECTORS_SHIFT
Thread-Index: AQHZsGqnmA7ak3BBHkeq2GdOpzqNba+ydV+A
Date: Mon, 10 Jul 2023 04:57:58 +0000
Message-ID: <01376e9e-3e4e-04a7-d18a-da29487569e7@nvidia.com>
References: <20230707003222.5854-1-dlemoal@kernel.org>
In-Reply-To: <20230707003222.5854-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB8496:EE_
x-ms-office365-filtering-correlation-id: 7627a361-b198-4afb-cdfb-08db81023b3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEpTgSU48MET53k9sfEDPNa+hQpOXd2w1K7hkHp99Twj3uXmoT1HN8PZ6oCbnrGC7T2ax6ZSdO+LLwF6Klk7EbLlkCT2EkZrT4P/0LzmdM9YY7spjH+OtYx8108piI3qK1JU7+GXciqPwpY6N1cbqwpnaT5ie/vYbakS+6KWeya6uwky8MeUMsW2zY3yLgYsgZCAF3kfFDag0VE6cjYo+P9X9j76Y5B6VR6fzNSNPUgNjMsVg6lWgy0MQOCDEFwCTiwtA9vtvDDoeJjj7qnhd+0kl6EK6VH9tnkUBSMLrM1XPdjBdbm3GJr81VBHUgE7+1GpDUgtwvi45947Xs7vdTBUrzXQgPIxuqSUMNxSZ8kJst4I4L1QjoCAfcBVGp+Yv5AHl98W0tVFxbkdRns1gDGxhPJkCxdWpsEREbfZxRBo09kateufABXwhbON/8e50CrXQYVShPQW6FFva1dcQi3PVSxANUInAc8NHgosKqrhzxSIUrHMxbj+3Kz3vd8CoIuhDTQ2L+LdKJdcXWc47WtO2SxzhFZOyV2AmObh/bjNOu2oW9fiw8987VacLIzzkbp+e+FLi3wg1HIR4QZJ5N8XDm5p9yJKqYQduO7zv/mXwUhXlwgDrwk6CQ/AD4HvP9pLtN3RoYdaSYoOquRib+tP9P9u4LZEs1iljkhp8K2hhQdb2EhVJFlfWGAmFrnS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(6512007)(66556008)(66446008)(91956017)(64756008)(66946007)(76116006)(66476007)(2616005)(38100700002)(122000001)(186003)(31696002)(86362001)(38070700005)(53546011)(6506007)(36756003)(558084003)(478600001)(6486002)(71200400001)(110136005)(41300700001)(31686004)(5660300002)(8676002)(8936002)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGV1MFZLajBHTk5WK3o3WEpUK0FvYU15RkVveVF3R1hNUngyeVRRWTlXMlZx?=
 =?utf-8?B?c2YvOEZpd05OeGo3TVFIL2Ntb3RDZHVyTVFtSG5ZWVdqSGpBZDQvMGM0dXVK?=
 =?utf-8?B?VDlPZC9vWDQ0d01PenpLc3NNVm1LclpwRWpYTzBDeFE1VDN1aitmZjM2RGRY?=
 =?utf-8?B?WC8wVHRzRWRJN2NVMEgxNEJMY3ErTjk3Z2xwRnlVc1FSVE1jL2N5WWM5aHd5?=
 =?utf-8?B?WFRXUkFXSWwvby83K04wZHA0VGFoeExWUVdtSDRpRXNybDN1RE9YOXJXYUla?=
 =?utf-8?B?UEV6U1JmVHdSQjlLVFFYZlIvNGFxNmFkU3pwaFoyQ3o1YS9RVTJTN2wxNTVs?=
 =?utf-8?B?eXYwZk5yaHJiM2lPQXVGTWxYQlZSaXRyQjJ4akplZVhCcGIySkVrMWJSQVJE?=
 =?utf-8?B?THBrRVMrTmFhTXpaV041ZnZHZWJNSWExOTZmWGhzNnlrMWZCa3lHYmZ1dytr?=
 =?utf-8?B?RWJReDJLYUs1L1J3akh2L0NEUk5VMzQzanorUmV1MjgrQng2dHZHemEyelV5?=
 =?utf-8?B?MGdFa1RNRmQwQUNzbjJqZisxOTkwZHpGMFVDV3RJNExqaUFBUDZyOHFzc0pN?=
 =?utf-8?B?Ly9CQk1YM0s2cEgwSmdiWFNUTUlCRVE4UnNLK2lNT29Pd05jZFVLTmtTbmFG?=
 =?utf-8?B?SThZbXBPbWRENURXQUNtNEFMSHE3dFR4UWhWTkJ0MGg4MlYrQ3ZBOXlrbHYw?=
 =?utf-8?B?UzFPNzdLKzFadmd3b2xjbm8zSnZma1lENVhXcTlJYU9NTmpta3ZRWHc1Rytt?=
 =?utf-8?B?bzYvcEJNTVpERVBWakprTXg4OXNKcHRKR0RjUTFCTnNRVDZvL2tuV25yYUNq?=
 =?utf-8?B?UFB3OGdlMTFHR3JNT0ZsbnRXVXJCbGZ0S2RMZkRCMVFNTkRnZ1dPYlV3aEVD?=
 =?utf-8?B?djNRZUE1eTlQMGlOdVlyaXY2ZXFRWVc0VFRwY0NDazNzNzY3R0hBd2J3VTlz?=
 =?utf-8?B?TTZGRU9EM3lYdEFnRG1HZ2pRWFJPWXBOcU5JVGVvUENLSXcyM08rTzFWL3pj?=
 =?utf-8?B?UVVCT3p6VVh0Vm5jbGZPRE5nalhxc2RKekNYb1VzUi9Rand2TWdLSTJOU0N1?=
 =?utf-8?B?VHBzc3dXbXFPdVRWc0x2cTMxZXBhRk5vN2JtREtOREp0QTRsWlJldEJIcmh6?=
 =?utf-8?B?dWhUK3BCZXMwV1Z3WExaVW9aaUIweTVVSjkreTQvcGZmQTBkK3cyNmlRelhY?=
 =?utf-8?B?b2pFeDdpRFUxVmx1SVgwbkRWb0tkTS9vVnlGejBSQ0RRbDRhUmllWk9rbnRz?=
 =?utf-8?B?czBxM2ZwWEdiVFpVL0NhU2RyWXV1ZEV2Z1p1TVZzeTJYWnZHQjIvWFowNUhZ?=
 =?utf-8?B?YXBVR3VNVDlPMkFyQkF1Wmc5TWNzekR0NC9LY01CbnZiaDYvWEhkd0VHYU1m?=
 =?utf-8?B?dUhndkIwRFVvV0VSKzNkUjMzWlhwUUpTclBucWpSMnBCQjdHb3hRZVhIcHNR?=
 =?utf-8?B?OE9kbkV0THF3Vm03eEJsMG9kWS9RSmFTejVhZHQ3MWxUY1FPN21rRkRiemw3?=
 =?utf-8?B?elVrRnZEbUs2MklSL1VkVUFRd00vSXVjc0tmR1dvcHozbHdmRHhNajJYQ2lX?=
 =?utf-8?B?bk1GZmx2cEdEVTh0TUpCai9sS1I5cmJ1WCs0RkdZT0kwOUo0ajJUZk5sOVYx?=
 =?utf-8?B?OHJIWVBWT2E1SmhtZWU2Yld4YklzNGpBYkZwQzdSenc2UjY2WmZ1eVpPcHBE?=
 =?utf-8?B?dGExQzJtU3RiaGpnL2RvdXIrL25pbEtRSmVURHVQNHRMSUNPRXIrRjBIUFRn?=
 =?utf-8?B?cUQvNlNKNDkrZ3VEOTZYZEVMREk1K0NLTUt3ODBEMEhTUG5ZNlZFdnhuTTE3?=
 =?utf-8?B?SzcxUDBzTEVieXd6aU1BUjIwblczTXlWWG1XcFF2RitQRyt3SzdQNmF1cTBZ?=
 =?utf-8?B?UnBzTC9URTRkcmxqYWtIYnNjbDRNcDNPUlIvOG1zWk8zcFRWWmROdHJlUXFt?=
 =?utf-8?B?S0hleFVvdnZ6OHNpdmdwUWpDU1RTTjZiZ3M4VUJTdVBVMis5REJMMEdVUjg3?=
 =?utf-8?B?eTVTc1hFa0ttNFlZeWYyR21MQ25ZU3JjM0U4ZFZLQjNha08zNFpDeWRkbCtX?=
 =?utf-8?B?ZnljSjV0Z2tyZlRjRFJzTHJDcHFqcHJJM2tlWFAzRzdRVUFqWTRFN1RPdU9r?=
 =?utf-8?B?aUVuZzg4L21wQkZXOG9IV2VyRG44bDZ3SkhkMGlIZ0M2VjB2VGxoVS9EMmtC?=
 =?utf-8?Q?Srp1c9NBBgcDKHfP8JrPDhXNsZYrCkGleaEVZW6Mzh6a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67BAA6AD92D34948B820AB14C1A4E5E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7627a361-b198-4afb-cdfb-08db81023b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 04:57:58.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zK5qyzkz7h4x35CRfabsjEvY3HeINVqyMvbAdfkeyVX2m8p/twXI2IBw8yAT2yI4nw0GRvPdvjJuycgzj+8nnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_215814_090599_CFBE8239 
X-CRM114-Status: UNSURE (   7.50  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy82LzIwMjMgNTozMiBQTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFJlcGxhY2Ugb2Nj
dXJlbmNlcyBvZiB0aGUgcGF0dGVybiAiUEFHRV9TSElGVCAtIDkiIGluIHRoZSBwYXNzdGhydSBh
bmQNCj4gbG9vcCB0YXJnZXRzIHdpdGggUEFHRV9TRUNUT1JTX1NISUZULg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gLS0tDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

