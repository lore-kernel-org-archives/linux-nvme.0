Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE9AC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qc92zWlhwpqogcBOEfRF6abmZL5P8Tbquq3W5E83AYk=; b=V+WuLaAR+mzFGFE0REQOPte95I
	YavWDMx1ZSqc7Z3YOBdfDUScgfdTxK2rD/NYbB00VO98r4KZPT+hKnDQPlp1GK7ILSz0QI4HyXffw
	r1kYR1jUmqnEYmR3SFV8lTly46YkhqRuiZxCNIga1c6kawm673VXxaghAd+eA/NE2ae3yDxVIWBVv
	MKnkcKFLnxjJJtAGs7OZ0jkr34eP9mi1VR2jCOm96BFYKBYNW/hgST7xbQ/lE8ABES7cwpmaUg2Jy
	Eefk0YV+YS5DjsPTW6z3bUPQz8F6ECJ8N/Nw5zrd7/ae+gkNqenSCbcBVjsYoEBVvi9ezuBhiq6Tb
	IkqR/ZNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJeO-00000005nWb-0LtN;
	Wed, 31 Jan 2024 23:05:48 +0000
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2409::600] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJeL-00000005nUy-0eM5
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 23:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2INHTz9umgy9uZOZVhrVmMYNIeon48E8uP9mdYoFvrsI2zRnvvsSWHDlCQfBwUx1nmb/E6absiiEM7cpC1Vvl1/efgqrYYsiLc1Om2gh9IrtbVsuJEdAL+26lTz8Rnr9PkWwDkfHkf2q16dzW5ZDar9/5UWvYvFp/z525mCV9fBv5Y0xQUotgVsN6BKhQKVvFTPfmgvT9jD0OghxFFvLVRiK1D0Rr3Xc7R6Z7FasYEotVM7j7PHEyhlB8EmfUAypR1OcrZB6WhP3FQqVHlwSoAPT9QdWNLNjI3yM7a4bISiNb2cmw0Gf2SGHf9OhheWjnXU6bo31oomCUCUo7+/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc92zWlhwpqogcBOEfRF6abmZL5P8Tbquq3W5E83AYk=;
 b=bnb3Fzt0K2Fv1nNkHVz2aWOR+d+z8fmQsnhLbzQY8m8dax/o0ybf/mbatqzyDf8U9lG8bjOshJyqFisE8Xrna8hhIugeACDQYLgHgjaRUg2y7wLR2zE2IAyypgUZ1LI6Bkl6YiarhTKLBwwuXqTNMPlFU+J9Bd84K+13OVIWdXCThpAnj0eUSlQ0ig317OM9UH11NVCQI4vmcmHLHnnnTrBuojOmzD94045t4DKnlmW0m5XTFUVivuTC5vcYqei7bUICVXP+WzkrkAdIrPIiTadlQRA+OsVhryIDyOOXC+FEXWe0k3uS3QBEJHmEVwLCrpr+VUCOVHjlgzHvOGNCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc92zWlhwpqogcBOEfRF6abmZL5P8Tbquq3W5E83AYk=;
 b=CvnVg+NM+X6ejfw9r8RetXXVMB3EDIt8zMfjIZ6Oal6WIjn9TfznBFQxCnyKUbj41Shs5QEFEPlA4EiXCmNKko7TALv+8WYQp5H8chW+XJOt0H7wyW/uducZY2L190iTTUjf/ooykddOwx+mRw8pRL4jrjWV63HbsBetCMT+YeI2XSdDIyHHwJWygKFWe9yKM935iGJWSTJaFRr+m5prvrBSJi6MK7ZQ+fJ3lWvSVK/QgNkuqgf3z5NLlGJuPz7ZxEZglt53DL6vbe27blSWERNFs/qbS9dYht6+uAIgybDdYlKkcZZyrggIRs1OT1VpZGCPh24sPkecr+DnnnHs+Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:05:40 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:05:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Caleb Sander <csander@purestorage.com>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 1/5] nvme: return string as char *, not unsigned char *
Thread-Topic: [PATCH 1/5] nvme: return string as char *, not unsigned char *
Thread-Index: AQHaVGTAV1VaY2rNVk2W9mpS9VRcVbD0izoA
Date: Wed, 31 Jan 2024 23:05:40 +0000
Message-ID: <f460841b-f96e-42b1-aafa-774714c56796@nvidia.com>
References: <20240131164315.160042-1-csander@purestorage.com>
In-Reply-To: <20240131164315.160042-1-csander@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8496:EE_
x-ms-office365-filtering-correlation-id: 1cf9ffa0-3e27-4524-1748-08dc22b124fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dV0ASO9sS/sLgigsReXsleUNMI+ku0dKuWh9GhYqzzIfYeDqc3TsD9nVfR/9u0Y7yH9eh+ucoPF8l2cpwN1sbsYA7/JQ6x2Tb50aCAQfGBDxsdCuj1/Q3YCaMbPRwOuifAGkitPdNNW13MyuO1CpASe+7mlNVUj8HlKYbuGmV6ePaH25V8IJpuetzbqPXFeUr69pd1unile23JwBy/cm0ELGT9E7x8WN7SfjKm5XEbloAZLA2Sdwe3X64MBn3f4rKqSTgaaLmVmUJGez05TWclNUynNX9ebL2P9tKvWONldgp8DTW5Y4NpkzfQscaHsXle7izc4sFY0XYxrANrL9orFS2b3cLStAoj9TPskM9q06DyQZS6LwN3gXhRkIq7oVnhhrP5IHM79BefftSi9uebRTc1/pRMCucCvxXwn/pzYQPtlKyl/qS/rMw22iVfDyRkxFC96EqB1/gkScGk4RU12BH3lwWAOBXhypPHN973A9U1J1oQhamu0jXoTjxbclU3MCPFzikGg/7hrbIGQ7FFMrmBdIluuvQ05ruZXPusSUoplYEEBkrg5PWVzAUdzYmso9XgRRLgv6s/wbzHkjiGRCRFltxXSMwelgEZcHI0twIByfWSLG8NMKBF4GMucO/m8+bml+jevSaeQi1LBWhWpeLBVTAnk/wzSTbhB58brLCjkmyQVp8WXaUhPj43eQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(86362001)(31696002)(36756003)(38070700009)(38100700002)(2616005)(6512007)(76116006)(53546011)(4744005)(54906003)(316002)(6486002)(6916009)(2906002)(6506007)(91956017)(122000001)(66946007)(66476007)(71200400001)(4326008)(8676002)(66446008)(5660300002)(64756008)(66556008)(478600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGkxVzFmNEJpaWlYckJhSmRUaTdnenZ3OVFpdmZTc0d6MldqMU93MER1Y3Ez?=
 =?utf-8?B?Zm42OWNTTG84bXJzUTZzcUlPa1ZOSGc4RWlrV2dZdFRvSHBvOVlFS3hZNVJX?=
 =?utf-8?B?OGlSNkpzQzVDeGtaY1Z5dlJvdkpaYjE3Y2dPUzREcDBZQ25LMTFKRUFnbU1Y?=
 =?utf-8?B?M3JhNHR5bERNUFZwR0g3TnNIblptRVBkUUNndFJXK0dpQVRXQVJubVhtSFdn?=
 =?utf-8?B?RXlLY29MeFh4MFZtRUxKTDNZd3o3Q3MyQlVGcDZQZi9KRFRyTHAwOWV5ZlNS?=
 =?utf-8?B?MWRmbVFZbWhzRG1RMTV0dHYweXB6cE8yalh0eFFYT1lPN2NtQjRYRUdCNVVm?=
 =?utf-8?B?dlZqTGZzL2tnOCtUVEJyZ3RiSGQ3K1A3dUJmVXg3ajZRMWhOaC91eHlLeGpz?=
 =?utf-8?B?cGU5SlFlK1cxTEI5MllKb3V5M1drU1NPZHNZUVBGT1c5dVZVVXkwM1dNYnZL?=
 =?utf-8?B?NTVrN1BKcFBQR3R6Z1dhbUhFdU1DN3RrMFZ1WERMVFdieWloYlR5dnh1RFd3?=
 =?utf-8?B?NHNlcTFPVVhMaEI0dk1zWnpTbC9KNjFQaUoyQlg5amU4SlViUmw5aDk5MWt0?=
 =?utf-8?B?N2xnc1pLMHNYcmJPU2x1UGowRmg4ZE1pOUhlMlZicmpLWHBNZ3RObmZ3WnU5?=
 =?utf-8?B?bEVyajl0OVA4RXBjcEkyZ2Ftd0lmcUNCWWY0eWxFYkhOUlAvN0FpWTQrSkJx?=
 =?utf-8?B?T2x5N0ZtcXU4WE8vcVFVRnpPbWxXamhlWStidUtERHdtc1hLQWM0d3dLTVhR?=
 =?utf-8?B?TTlUNVhMTWMwcDRrZ1RSQ2lDZ0dTQ3ljcUVmSFVORnNKNDZobFNVVFV1NGk5?=
 =?utf-8?B?ZnVQSmx4MnNueGkwMENaU3d5MHZQQVpzcXBQVHM2bEtYMkhVU1dtR083TS93?=
 =?utf-8?B?Y1VPTitjcWdCUy9wZ01Fb1N5TGhNOFRqVVFLbVZiZU5CTWdZVzJnRy9RT2Jj?=
 =?utf-8?B?b3grRFZtUVBOaHorWXc4SmlRWGxHZ0M0RklBYUY3L2tWRHk4YlFlS09qcU5T?=
 =?utf-8?B?cVNzL1daWmgycnBSY09MZnV0UnFkY1VaY2c5b1RHNlFuSkpQcDdQeHg0Qi9o?=
 =?utf-8?B?M3dRUjlsa25TYzVvTkkwUVYwYjFsTWxKM0loQmNVb0srbWdYS3lEM3VqcVln?=
 =?utf-8?B?aXRvdDdoVTBIcSs1eXRWV0hjaHVrUlM4ZURuWlFNRHkwWi8vSXdmTzA3ankr?=
 =?utf-8?B?Q1hKb3U5U0VJK0QrWjlOL3FJVTBQOXNHSXNib0s3ZUxWM3o0UmVQSW13aDBZ?=
 =?utf-8?B?MXRqclZvSWJFVFM0OVkxdTB6VVo4YTNTYzhBWmFSWXlteXF3cEpDb2VZbE43?=
 =?utf-8?B?QXhOWWNRMnI1MVAvbmZkbFJuVDFvZkVvNUh0eTlUMER4TnFJeTNMaWNwWm1q?=
 =?utf-8?B?alo2T0xVR0VIWWNTZ2o5UjdrejJCSFhOL2NPTVBzU1p1U3pFekk5Qzl1Ym5Q?=
 =?utf-8?B?NTlXd2dIZmF0MUFQVTNyYlRBS1lQWGJ2RzNEdkdSNUVSenpiM2tsYUI5QjBO?=
 =?utf-8?B?RWNQamhDMnN5ZmpiK2syVW1MVGgvYzVEWTYxNkh6d1VGNDhMdGNrTUYrQnZ4?=
 =?utf-8?B?SjR1Nkl4aStWQ1pEcjBBSnhzeUNUeDkzem9lYXE5Z3BMazdXWWJla0tmZEp1?=
 =?utf-8?B?Z2xjdTM5NittUFl6UUcxZDZZUjVRanZwZ3doYWZqRXlzdFJOMzE2cjRFR09z?=
 =?utf-8?B?SEREV2JQMVMvR0xZSEsxNmM0dkFIWThtTW5VNk93NXhxUkIzeHRMRjk3TjFk?=
 =?utf-8?B?OSs1bWNMTktkbjNBZnZNTmkwWXBxSWxRRnRLSFByMVkrMEZVM3J5bzc3ZXJ3?=
 =?utf-8?B?TUJHNXdVRGV2clZRUG5pN244UTBTYWZyYzVwNVUwa0hlL0Q1OWE4SCswRXBZ?=
 =?utf-8?B?WTFNeG83T3hvbEJmb2J4bFJGQ0s4SkdlbERzRHF3T25iNDRLSis3Y29POFhn?=
 =?utf-8?B?ZTN6NGRHNDkydkV5aWtnT00yc1dXOHdUbE9TVTVYMjUrZlFkanZReUdVckov?=
 =?utf-8?B?T0hSN2hoYmJnS1JUMnpWeFpGSE42MjVuZ0ZNSWZ2VXNaSVJWNGYzYi9NaFQy?=
 =?utf-8?B?Ym9JS2M1aEtJT0toNlBubFo4ajNRNFEwMkZjVE82alhzSkxkdGtDVGdDdGk2?=
 =?utf-8?B?cWdleDlnczAyemdwWXFyTWhWM3doVnV3dU1MTjBGcklJVnlpZlkySGNUWUgy?=
 =?utf-8?Q?mSFc1T1J3zF6PXrr7osxfTaewv5g8h7TjWg6cF+k4z6K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D8249995F44343BCF9811F9D74C39C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf9ffa0-3e27-4524-1748-08dc22b124fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:05:40.4508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4b3IMr0JCtctlrxJlXsJCAGMhEF70mZ3/WhZJ140PDJEMJ8ZcTXh4G3K1vY9niE0La5zzhtq7CC6xtaFQmsj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_150545_215685_E16F39AF 
X-CRM114-Status: GOOD (  11.00  )
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

T24gMS8zMS8yNCAwODo0MywgQ2FsZWIgU2FuZGVyIHdyb3RlOg0KPiBUaGUgZnVuY3Rpb25zIGlu
IGRyaXZlcnMvbnZtZS9ob3N0L2NvbnN0YW50cy5jIHJldHVybmluZyBodW1hbi1yZWFkYWJsZQ0K
PiBzdGF0dXMgYW5kIG9wY29kZSBzdHJpbmdzIGN1cnJlbnRseSB1c2UgdHlwZSAiY29uc3QgdW5z
aWduZWQgY2hhciAqIi4NCj4gVHlwaWNhbGx5IHN0cmluZyBjb25zdGFudHMgdXNlIHR5cGUgImNv
bnN0IGNoYXIgKiIsDQo+IHNvIHJlbW92ZSAidW5zaWduZWQiIGZyb20gdGhlIHJldHVybiB0eXBl
cy4NCj4gVGhpcyBpcyBhIHB1cmVseSBjb3NtZXRpYyBjaGFuZ2UgdG8gY2xhcmlmeSB0aGF0IHRo
ZSBmdW5jdGlvbnMNCj4gcmV0dXJuIHRleHQgc3RyaW5ncyBpbnN0ZWFkIG9mIGFuIGFycmF5IG9m
IGJ5dGVzLCBmb3IgZXhhbXBsZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2FsZWIgU2FuZGVyIDxj
c2FuZGVyQHB1cmVzdG9yYWdlLmNvbT4NCj4gLS0tDQo+DQoNCmxvb2tzIGdvb2QsIGZvciB0aGUg
ZW50aXJlIHNlcmllcyA6LQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

