Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BBCC04A6A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oqjLz6SN3RuU2UXYAqELaLD/KinjDUd9lu1cvex8j5w=; b=pe1udq3EBdrrG0XbQ3sN62hNxH
	cCd+/St+tqm8KCFN9JGxJm5JwbcO37WP0bptPCwXz2aDKz9TYYCY9SBENbX/TMsMwE87AfSo9L5KL
	H8nfesHemFztn0OcUPy8N/DRCOd6p8TqIro8fJj6UaJCpbEtp0LOgRfsLPN2PSPLph40AKhbr1C0b
	6PoM9p+MAP9ePK3yY+hNP6Wv4fB+x9Qcglk2k9wuREzmOpbhhGxRBA6LTTipN9btpv7OFdcK50eKO
	3cKh6rSxi3DoMMsJU/Xx6g7rGPCxx0wIqsc6KdUAjMzSKpxaUtUTy21Jd+3qG8KuBAkbtw5bblAvQ
	K0bw0q6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTSjH-003Lzv-02;
	Tue, 08 Aug 2023 19:50:55 +0000
Received: from mail-co1nam11on2061b.outbound.protection.outlook.com ([2a01:111:f400:7eab::61b] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTSjD-003LyR-2j
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 19:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5Tmut3kGJsyFgd5+7qnc08hC1fkqh+QU+KFWsZDo8tbIhcLOZfQdlJJSKYD4DipeKoKrOkZVmxyuQCKdxIyWeo1SKRe/Zl1qAV6PMYiqdwilqMc/EZZGbV9LhFvZnWeq8XevnCD7Vx3EjxRy8Uuwn6C1wdp7QpmrzPRBBLUB5X+isXT+SHj6d5WR4OLSAsCzkIHbh8fh/YmHLj6HdUw1FzFgYANJplPZhroRbYAYbBOJkObwhxoid/AyiM961fwekgr2b7+04WiGXT+CxrP/1VBwIhcf4+noiERcMZY0kEwzpVWX3SJ92HAruQAVBhsz/eHxusYmfmSMRktogRA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqjLz6SN3RuU2UXYAqELaLD/KinjDUd9lu1cvex8j5w=;
 b=IKJpbjyOlMv4ExM3EuC2MlRVVonolUN6VUpCSCbKPO79MAoZqIYoctge5gxNaxVwFi9xhFzRVLqzciQCaK6x9m+YHCe/oGUVlSVEEzzw+6wZaQLHqN1t90Aq9GzUAakAuNeusHmFvCi+iE8bXvV1/v6Kps/N+0hGP/g/SsqcT7pLh/f8oa4r61/swo6XydV6DzIA7Hq01i7/8m0P7vQrGK1kxLN5brZ27SIm5MdxJh+mFMSX4EJbiN+/6C4KYyRqi+AFpeJFBQTOOPuiM4YxPemNUzn12YQ8pJtyZzdR9TzgUCGQKfWtaXBsTn6GTAuhbS15b7AWGKab4RTe4VvBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqjLz6SN3RuU2UXYAqELaLD/KinjDUd9lu1cvex8j5w=;
 b=IfbOvRtn2Hvw6PxLh5PH3KyVWU33W0fxjSXBHz60OvhRicI3x7IGlB3WMhmlMUoQbABAfLrRG+PsAuZ3LMkpeJIoY81kO0oCS7BOtbozineXBxJ8ttjojuNzA2VIXCSVE3rz8sAeHcCDOLjVxBGzkQvVrWCqzKhBKZdB9u6gy2Cg//jU+2X1ku0F2mv4UY8fBge1JEi+oXIRJuIIGRaiaa8sdcQMPWumMasHUj0c5pfyCBqSIGYR0+Ug5xOpVB32fgnRDc8zkpYoTY/ZvaCwWhT1mIEwKIhxPs3tjfxAanLADbqQOl5pTyVo0zh7jf06IgjkYRcBV8zmiAl3n9zx1w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 19:50:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 19:50:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH libnvme v4 2/2] fabrics: Do not pass disable_sqflow if not
 supported
Thread-Topic: [PATCH libnvme v4 2/2] fabrics: Do not pass disable_sqflow if
 not supported
Thread-Index: AQHZyfybfLsGm7FsF0ecq2hhl/TWsq/gz0MA
Date: Tue, 8 Aug 2023 19:50:43 +0000
Message-ID: <12dfeddf-ddff-ddb0-0897-1f8269c5dfeb@nvidia.com>
References: <20230808133028.14643-1-dwagner@suse.de>
 <20230808133028.14643-3-dwagner@suse.de>
In-Reply-To: <20230808133028.14643-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7663:EE_
x-ms-office365-filtering-correlation-id: 13f79f1d-67cf-4494-3735-08db9848c02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2BS17/ZlmYVJOTv2+mPHJMozVbi8wt2heR/2WB7lXP26E5wVxIVtukhA3Do4QhAyxdbaX+BNOShtwp2LCgINDLYZ1lPHpWXoYwwyO6ui0k5wk2t+IbXnmwvwsZ5cChiU5Eir1EMkkSdex7sKPi6wNmPi7YtYNMrW9SmZFz5DnnW5heQkVz0NF1r1JbLVs/DdfO3JojoMxuVY1/FQxyeOJusrLx/NwoFM5a2Lwn/VUoGdvGa65msGJBLUPX6rsVz5eOVenar1DYwRnL/q3hrvcAyMyV8bcdhUZI9VaXvFk+ux3/y40TvY+svN1DxyOQRWp+KckBlQCFJSA4zrMEGe4/yV5ghxqxJ9Hnr0/0sBYIM1lDJRJiw3k6yrXr7zveMVCJKNhAONtHjoXMAZUjjya56/S2TFFFlsLCbkNlzxdrF3SLppAQaMWt0B5ZW2fQLclNk2xGi+CLpJIm0cB0CTwSNHjbm3EpUym1pmqgBnUHxB3D0PLlc3APQJ3IzlbIh730VA3IQf4rbQHq+omj7fvcnAmWs/bu6M7ySTO7OSpCNjFtBNKqpP1keVr0ZwLSEQ/1sFxz7CJHbV4sS0rdDeHTbK7KUtmEGyZX5zns77GW/KtiDosLRryxY3RhQxMkxr5HHlVf7sZVBzNhJAJ3dTYNBqL2EV4orx9OxD9v38BNizwHkOZ80fQ73rl31NXYo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(1800799003)(186006)(451199021)(31686004)(2616005)(558084003)(2906002)(110136005)(4326008)(5660300002)(8936002)(38070700005)(64756008)(38100700002)(66446008)(8676002)(316002)(66476007)(66556008)(91956017)(76116006)(54906003)(66946007)(86362001)(31696002)(6512007)(478600001)(122000001)(71200400001)(6486002)(41300700001)(36756003)(26005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHNEU294NUQ5T3gvSVpOb0pjejYyL3NtQW5JL0dvMXRmUkxKOWI3NWpNRDRW?=
 =?utf-8?B?VjU2VjRLSU1iQ2RxSlhIMEZTbFBrSWZDdFVsMjBQL3N2Y1lYQVQzZkdQaFhp?=
 =?utf-8?B?ak1HTXU1SzVtNFh3b05iOU5ZS21LUjlsR2o2dmRLQ2dUMU5ienZHRTRsRmZ3?=
 =?utf-8?B?MXlqa2NrNjh1YURPZ2V2QkZJbEhUTXBsaEtSTHl2eE0zUHJFV0V4cjNmaDBh?=
 =?utf-8?B?VDlkZmI3cjVBTURwY041S3FYZWRvdzBUamNtcTNaNXd0aE1INVVHdDdtczlw?=
 =?utf-8?B?VlJ2U3paVWpOdGZadWltTVBobWdwWHQvclFHNi9NZTlLczFKai9Uc3BkMVdW?=
 =?utf-8?B?U3dKNHo0ZmZLUW1yUjZpV1VjbVFEVGtVbFU2VndLNTJLSkVqRHcvMkg2ajNP?=
 =?utf-8?B?NWhwS3NONDlXSHJsNStQc3E5MGtNTldVTmtBQzNHdjJVTmlSNWpTQ2pmczhq?=
 =?utf-8?B?c0Nza21XWEFMWGZOcTQyQ0ZNMXFZRDRxQlA4RExLYUE3L1ZxVVUxWjdDejMv?=
 =?utf-8?B?QnpzYzhacERNeUdpdHduM25OZ0dwZkRmZG5UQWhmUGZ2ZitUV2NNSEdSMy9t?=
 =?utf-8?B?TSthdjdaS3JQMFFFcmxZbHk3YzE4cUhmcVhEd3FlV1B6UFZHZnN1VlFpNWha?=
 =?utf-8?B?YjhZWFM3WjFXSW5FNVZZMmQ4cWRFb0tZeW1UaEFGejh1RStuQyttY0l4bTdQ?=
 =?utf-8?B?Q0QwTDNtTG9KaEpJdlNMclMvaVJmUXAyWGhVRHYvVi9ZMnFWOWlYUFRFaVc4?=
 =?utf-8?B?UldTSW1uNkRBaHJEN1FobEVFbUkrenFrMWlHL3ZyY0MvVjQ2L2dTQXFIZmpG?=
 =?utf-8?B?cy9tWTJ0UDhBbitMa2xGRURTTEZpTG5yQWRxb2N5QlN0NENvaWgzVE1Jc2ZN?=
 =?utf-8?B?Z0VUT0M2alBpdS9mU3Q3eWptUlF1ekVGejcxcWEvTXJJWGNTUjMrcmQvM2Fq?=
 =?utf-8?B?TitjUFRITkJXQm9vMFVMc0UxUWY0b0hGeEhRc0dBbDlVNnNGc0IvaWhSeWZE?=
 =?utf-8?B?cWhQc0ZUKzFiNExkU1dxTE05cGVOVlBoK1U0MHY3bS9Xcld4RkplcU1pTXJr?=
 =?utf-8?B?SnBISmErZ21aNWxUWExwZVJsVE9zVnM3eWxoU09ZZEs2SzVxWTZ3TkFNOWl3?=
 =?utf-8?B?Uk8ycWp6SXI0MjlESTFBNmo2NEJVdjdZV05vdkFjemc3RFRnVTBNWVZzQk5P?=
 =?utf-8?B?ZWMzcnA0czdVSjFtaTk1bWlPT0RvOFk4dVFJdzl1T2g1L2JxZ1cweWdTTlM3?=
 =?utf-8?B?V2doRWY5QWFqTmc4bHcwcWJMNXplODRsTUU2N08veTlMeGJXeVpQYmQveG8z?=
 =?utf-8?B?VXAvK3E0WU9NcyttVEx0RWdzQ3lDWXF2NTZ0QUxPMGhwRk1hckU4R2hWMzhq?=
 =?utf-8?B?YmhPbnliOHRiZDU5MXF0REhzVXN3Q0ZLLzFRRm9URXlWanZsRVNrUnRBWW5m?=
 =?utf-8?B?ZEIyVUVMODV3VnJmL3VCSldKUmR2M0dUUUs0VU9RQkFVMU13UXl1ZjUrZito?=
 =?utf-8?B?Nm5MV2hhYXpaVlR3RlN3cnpqUStPc3kwNkVxRmJrT1J0WUd4dGdvaVBXZENw?=
 =?utf-8?B?em5GUDFaK3VnRmNmaDlaS211cSs0Uy8rWjBSbUhQYUlWQlRCcENEbStRaXl4?=
 =?utf-8?B?R0wzVDd1SHZwYmRON3lUU3hVZEtkVVhUc3JPRzlZcUlBa1BvNTl6MStYMS9Z?=
 =?utf-8?B?eko3KzN3ekFIWTNHZDVPVEJqUm5scldGNncxU2JoVUlENnUraFRtOGpYMGxG?=
 =?utf-8?B?aTZkSGN3elJlTWFEVWdYM0RjU3BVcDdUVjlxNTlIeHgvSkZnYjJYS3gzTVQ5?=
 =?utf-8?B?NUJIWlZoT1BWelRzUVIvdXVHZHNtMVdHVmJVV0oxL3J5VXJ2cmVOajRGTk8v?=
 =?utf-8?B?QmdOcXFvQU1TOEljTWs5ZzVLM2xxL3gzWGNEUEtLTGVaTnlhNmVTNHhDSXkw?=
 =?utf-8?B?WEk0ODFYUDNRb1ZZblBrU05VWFg3bDN6ZDNQMXA4cDVqU1BuOTFTSUJFQ2h4?=
 =?utf-8?B?U21tR3ZnQk5LenNRdmVFR2dUaGRpeXRpRWpTRWRLbEhacjVEektSUzUyaWI5?=
 =?utf-8?B?K3UwZDBwKzJPanFoeG13RXpPcUEvTjdtOU1OL1NzS2tkelFEeE9UUXZYY1BD?=
 =?utf-8?Q?TM4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC45D3B593A952418F780F7A85695135@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f79f1d-67cf-4494-3735-08db9848c02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 19:50:43.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFrPvGBNtCfzT06zN64ACJ3impfV70fYwtP9leXurEkQ0rqNPXSC1I1t4Lnjeq+IJeQ8hu2dCoYzmxKAmIH4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_125051_887106_E527CE7A 
X-CRM114-Status: UNSURE (   9.19  )
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

T24gOC84LzIwMjMgNjozMCBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gRG8gbm90IHRyeSB0
byB1c2UgZGlzYWJsZV9zcWZsb3cgaWYgdGhlIGtlcm5lbCBhY3R1YWxseSBzdXBwb3J0cyB0aGlz
DQo+IG9wdGlvbi4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1i
ZXJnLm1lPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+
DQo+IC0tLQ0KDQpJIGJlbGlldmUgYmxrdGVzdHMgaXMgcGFzc2luZyB3aXRoIHRoaXMsIHdpdGgg
dGhhdC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCnx8DQo=

