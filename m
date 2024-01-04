Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C81C4706F
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 04:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tkv0t4s4MZXu4zrw5oEqNYA+GMJsMjSb+qHK5RcQOy0=; b=e6EZEj27Sz/giKr6tiwE4RjxB6
	4wq02DSaU7TkJ6w/nrtJlE5M9cjLurLNYVPA7qvOGY3Y2v3Ql1VG7ybkVrHKswNk3KFOeKHq/wrJs
	RSfzS/eTmQiKn19t/Ss2aQE5onJ63EABOi2v6POZ3h0fMrRmxRZqpDuv1pkXRnYzAzu62u99LEzQu
	fdNyjnitFOpDUzqox72aCbcm+OhXIU3iVPR9Rp+mPh4ShZCVEDHib8zpJ6NI/4lC86+W6MY4l7MBS
	Z4hPYHKfmwR1Xbp3ZD+JaO564T+9LLgHbb0rhBc+yuc/yaU90yLTTpFIl01RakMUE1Jh7rU+98Pab
	0XsxYgHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLFeg-00CqZK-23;
	Thu, 04 Jan 2024 04:48:30 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLFee-00CqYA-0Y
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 04:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwpyt2XdlCypn9TLHLqfTtu+zUWEk/x4LaKdMI2gdqDiB8kzlvhT7cSpnnhE5BbhpPiQHhQKdSr0KaHUOtdXcbdpqsX0aEKvD7i8e2g5A91ZmOTUrSZBJrQ7mazl1HHmhSRNgus9oO91XPruNtNZ/tYIUvmBP+RE37bBroLWzprPm+V0QbllST4RCN6fbhp1iNbqLS+VV10/fJHTgB1f2fO5lRq/Ta1Cbp0jU4GkxLdoHpmkuP6xY7yCex3cZfMlsIVdQpfHjOrH0bI5BUdz+RLmVl2C+OcMAgCYDaz6yYUFA1Pab65bf/CszgI5BgrBNeGsiIoQ8A99s5Mev9WOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkv0t4s4MZXu4zrw5oEqNYA+GMJsMjSb+qHK5RcQOy0=;
 b=J7s61p8H+FthNQB5MXPcTuUs+GSFWyDVQ1NtWiU/aJ7gzn5YGCIIRqzOSUreyZSp+N/WRjE2Skhy5K3jVpJiyOL5EBjSBxtKUs3GbAod4g//bhkR7Hpbl2o1gQGoZ4ASSS6OVtg+wh6MH11FVRVhFEiyNiuCOfl+H4RnHrdU22Mv0+iHtDqcpssIJRSQ37VqIYIsDHsFIM3voaudUsOgRF12oRK4QFmtUrYNHyMozVNH2kFXwpH543ldsuZkAyFjdsDAyzG9u+df37HZISiG2/Bsq+qAdVe2viWFJ/yBWTUkOd1hrQj9zGcY++9a/brgCKvBtpK+ZxuKfmCzqS6PdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkv0t4s4MZXu4zrw5oEqNYA+GMJsMjSb+qHK5RcQOy0=;
 b=PzRRazphBaynwrvzX0qw+2VtRRkbBqPkAXCSNbFQIU6rTtzPGa4ou0lAlRZHEZHHHKxMODYs47IaTwntGBQOsGYYVtBwszjwL1wKqWGlrjmB/sDSC/XPLqtBk29J92KJKxclhlkCp03mhfYjcNRFWL30hEqzvDOBwI65e6o+WKlA0IEFTuojqj9BU4AYE81nby2gp6rRJkumpC5W3XcE0MHZ4hVEWeuVrV7hLQ3yyV+xdHetKctGX5MrqcKOATAScDdyFowR4Dkh68NdQyth3eenIjK2Y408G9ASXrbkVvQt5IAK9wBg6mtXFk9C9xUa8socT5P0KIrRaZmD/qlPkQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 04:48:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 04:48:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jeremy Allison <jallison@ciq.com>, "jra@samba.org" <jra@samba.org>,
	"tansuresh@google.com" <tansuresh@google.com>, "hch@lst.de" <hch@lst.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Make NVME shutdown two-pass - Version 4
Thread-Topic: Make NVME shutdown two-pass - Version 4
Thread-Index: AQHaPoiMs8UWzRSJ1Ea4hsHtLWgMebDJFWOA
Date: Thu, 4 Jan 2024 04:48:15 +0000
Message-ID: <775d4ce8-e9ed-4d27-80bd-3877e80b810a@nvidia.com>
References: <20240103210405.3593499-1-jallison@ciq.com>
In-Reply-To: <20240103210405.3593499-1-jallison@ciq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6069:EE_
x-ms-office365-filtering-correlation-id: 0d27fe96-54fc-4074-ad7f-08dc0ce05d38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWztg9NbkGs6EHIA6rwNjz4b1OMyo0Bbgl9xttFPkM+LjByS/lYWsfdBItoY1xzPGRHff4RVHr4fMO5qrFGmNACYVwEdy+0/iLRYvjBPsBZQUQIU+yrxuy7nHbfNA9m1Z3MkQS1nP+vYMaoFTPg1Bxmcojqmn0tmJFCU6wl+ffx0QUMF1EmriUDuZOM9NiCrekxNNkoXdQ1WOJzvthoP3t4gABve1MWKwDB2ul3n+HBEdAULrpmt8XubG7+20aYEg+lll0oAHH43kwMmPZz4oD4G1dOHf45ltFgqlkgplrX758UYAnysYNk+jGcNycbflxRucdH5w1Ejo6xwj8/9v36SGcpPxlufz4zI3qD+c9Zr2p9EDxZXqzmPhUfGMujbB/J2j2JxLj2o/LFnqqE357w5in+vJBdpUwzqKJKDvxIGGmnM/fSuDSztxsG09qOV7uR2GxT+mX4ikmRdfXlDMpEMgUB0c90flerTZetq0SHs+xj7LEjU+fvtAPZqPOwouhbQOj7dM37l7R3leejB2P/MWBix0tVX6zv+sxS0eq8QW1E+zTnxkCQKLTgRmhbur8ZCoG+CvytiKV9y6PTbkqNUIR4WlKNElx6GaU19mX/HxKOXaKw1UEeRM7vhRGzyLoUEVI6weCSjnASOWeQDG1QsgUeEQj1voiPB6F/eRxFBE/LZh/YCkHvseyzmNghx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(83380400001)(122000001)(2616005)(8936002)(110136005)(8676002)(316002)(41300700001)(5660300002)(71200400001)(4326008)(2906002)(478600001)(53546011)(66556008)(66446008)(76116006)(91956017)(64756008)(6486002)(6506007)(6512007)(66946007)(66476007)(31696002)(38070700009)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U09DTFRUei9taGZkVlVaTHcxajJWZHpBQS9FbXFhVVV5SHR0c1JaVXJwM2M3?=
 =?utf-8?B?bkVEUmYzQkh4Wk9iOGFRbVFWOFg2ZkY2MnNJSTB0TTNiLzgvUU14aDlSVUx2?=
 =?utf-8?B?MHhIRHpkNFRHeWk5SmxUZXZuT2MvYUhacFZZdnF2MGJmQUQwL0pySVhsRE9M?=
 =?utf-8?B?UUpibWVOdW4vTTlPVkpsMWV1WklMejRiZHpEcjYzS0czSjFtdzVFV3JNZW9K?=
 =?utf-8?B?NmRDVTQwcmlGYzE0UklJTVovK0tTZUlmTUJ6VkhXeURLcWxQNHI2WDZoemcz?=
 =?utf-8?B?Y0JIRkp0UTlJRE5mWW0zalVJVzdRK3h1VU40SXlmb3lJN0NZWFBNU25qYzdZ?=
 =?utf-8?B?Znk5TEJqQU16akNiTG5zWm1LNjR2NTFiK3FEcUx2akJTQ1VCc1VXU3NTVkU1?=
 =?utf-8?B?M3V1NVdzbGtpV3ZqK3pmWDI1VlpBYjlidzNCM1J3ODRKMFNOSUZQWVZSL0xi?=
 =?utf-8?B?aXhzaXZvL3YzSkJDMzd6WDlFTjZLWHBEMFBkZkc4U1BYUnBHMXlsWFNIeXJq?=
 =?utf-8?B?UytrNjlqanRMbUhQUEtoS0tWeFhJSUJZVjFBNlFmaG9RVHFWNWErdGIvQ2po?=
 =?utf-8?B?TDgvcnJqYStWVXIyR0xMVmpHVlpaSHArcWxkcTdlcERZY05ZT2w1elJRN1Mz?=
 =?utf-8?B?Y21JRnY2M3BzZzcyT2EzYjZpK3RDaTJUMVR3VmFTMDRBTjYzTkpGV2xzNXVD?=
 =?utf-8?B?N09kdGJPSERob1BEd250L01rVmIzYkEvSGU0cEp6WlBRMWtIem10MUZaaWp2?=
 =?utf-8?B?TEVtSDAzWHB4RmlaNm1UZlJBRG1HUmM2ZlYrTnNzL3pCUlYrNXNTdXUwQ20x?=
 =?utf-8?B?Z0dhNlRkYytUWkVkWmptUlZ6N3ZSTlVLa0xFeGJxS3dvaFZEYk5WbGZQemJy?=
 =?utf-8?B?ZmI4Zk1FZHVRQkwxVnltcXBWMTlhN2J1VFgyOThWTllOZDhFVHl2SnZ4eHNy?=
 =?utf-8?B?eUk3RHJ6ZVQvdVY5RFRxeUU2UGcwelY4U2V0K056eDkvWEg2RFVmdEJEVUg1?=
 =?utf-8?B?djErcXpPanM5ZHhJcFk5U0tMbzN0d3VTSWw3YXZKamFOeWxJSHIvWFlvR3E4?=
 =?utf-8?B?MGc4Q0hnSWR5Mys4OExCQklQOElhOU1iUlQxSkVnT2xnSHAyTnk5RkpDZlFa?=
 =?utf-8?B?VEdjUGNXREVNOHFXMkxSWXpxK2g2SldQSVNuOU1LVHlGRVFrTU9oLzhGRThQ?=
 =?utf-8?B?Yk50UCttVDFNeE1qbmNVYkZ4QnJ0RWw5UE9iUVhnTE9sd3dWWk1rWkZNemRx?=
 =?utf-8?B?N3M5Q1MwTmNIWlhqeGovL1MyeUtndWw4aHg2L0cxWnJVQmV0L204THlUTWlw?=
 =?utf-8?B?ZjNHYnN2WTM3c0NqYml2M3lLclRCZGgyd1puMHpZVExVWHR3WFh6SEkzNXdQ?=
 =?utf-8?B?Y1ZQNFhyaGR2c2NpbGl0bXJhcURXWkZxR1pwK0RIMS9XNjdNT0pWMFZuUDJV?=
 =?utf-8?B?YjhBY2NKNDlINUtLKzZSQ25DeVZOc1VsQUdnWHN5cklHTkYzR0Q0dHpGR1FY?=
 =?utf-8?B?MnY3VjZxZjNLUmptZXJrSkRrRVRqUHNVVlY2U3BHZkMrbHlWb2czV0lnYkg2?=
 =?utf-8?B?OVdLUnBnYzRkcGxUMmRhM05ERnRJbitPWG5NYllqcjI3VEg1SWpiR1BRZVM1?=
 =?utf-8?B?UTY3ekkwMXgvV3dHNjVtNHRWSG9vYW9RY1dkY21WVW9lSlc4REs4aWdnUi91?=
 =?utf-8?B?T1dndFFtaWlwN1R2cHN5aHhLSHZjWmpOUjQ1MS82dnEwazYyTWl1d1JNL2VM?=
 =?utf-8?B?bm5KNkVVS3JFbGFuc3NmUjdKKy95cURJdy9SNzBsa01aRlNIM29idDQzejIy?=
 =?utf-8?B?Y2hIU05mcFVKZEtsUmJ1KzhUVlBORnlGZFh2dTJFdDBuWWt4T1JvWHQ5VU1H?=
 =?utf-8?B?OHZqWkNtV2pmT1BuZGxyN0xhVURyNjJmTiszcGMwTHBEbThUSmxCeGRoR0xa?=
 =?utf-8?B?R05XK3lRRU5IcGc5TjN5bTh0RzhJTjFwOWlNSi84RTZzay9MRWpqcSs5Z2Yr?=
 =?utf-8?B?VkU3eUtTdTVVa3o1c0xvUWIydzJkbmlIWEorZFplcHd0RnNiR1h4SWhRQW1G?=
 =?utf-8?B?ZmcxdFNVMzVXa05jbG4vNFMxeTR4dkkzeTdBS0Z5UTJjRzBLbWtEeTg1aVlW?=
 =?utf-8?B?bEttcDFNVStRN0lOd2NaN3VFTnlxQjZ2Y2ZvcUozcWpUR3BTMmJxMm81eG5a?=
 =?utf-8?Q?6R7+dUHxr6KBfF3ScXzINkeiSVK/p+bVSuZBcgWyfC0r?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACCD1928887E0248BFEAE933E191241F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d27fe96-54fc-4074-ad7f-08dc0ce05d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 04:48:15.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSTv8lg1Z3TjUq0AUC8TjRGiiZVbDBoyUSm8RR1EiIJ54e8PpG3sUKdD3Ux/H8PZ03TLP2xJQMrb+ECqnmd2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_204828_231761_39DB9025 
X-CRM114-Status: GOOD (  19.86  )
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

T24gMS8zLzI0IDEzOjA0LCBKZXJlbXkgQWxsaXNvbiB3cm90ZToNCj4gVGhpcyBpcyB2ZXJzaW9u
IDQgb2YgYSBwYXRjaHNldCBvcmlnaW5hbGx5IHdyaXR0ZW4gYnkNCj4gVGFuam9yZSBTdXJlc2gg
PHRhbnN1cmVzaEBnb29nbGUuY29tPiB0byBtYWtlIHNodXRkb3duDQo+IG9mIG52bWUgZGV2aWNl
cyB0d28tcGFzcy4NCj4NCj4gQ2hhbmdlcyBmcm9tIHZlcnNpb24gMzoNCj4NCj4gMSkuIFJlbW92
ZWQgZHVwbGljYXRlIHNldHRpbmcgb2YgY3RybC0+Y3RybF9jb25maWcgaW4NCj4gbnZtZSBjb21w
bGV0aW9uIGZ1bmN0aW9uLiBOb3RpY2VkIGJ5IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcu
bWU+DQo+DQo+IDIpLiBSZW1vdmVkIGludGVybWVkaWF0ZSBmdW5jdGlvbiBudm1lX3dhaXRfZm9y
X3NodXRkb3duX2NtcGwoKSwNCj4gZm9sZGVkIHRoaXMgY29kZSBkaXJlY3RseSBpbnRvIG52bWVf
c2h1dGRvd25fd2FpdCgpIGJ5DQo+IGV4cG9ydGluZyBudm1lX3dhaXRfcmVhZHkoKSBmcm9tIGRy
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYy4NCj4gUmVxdWVzdGVkIGJ5IFNhZ2kgR3JpbWJlcmcgPHNh
Z2lAZ3JpbWJlcmcubWU+DQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gQ3VycmVudGx5IHRoZSBMaW51eCBudm1lIGRy
aXZlciBzaHV0ZG93biBjb2RlIHN0ZXBzDQo+IHRocm91Z2ggZWFjaCBjb25uZWN0ZWQgZHJpdmUs
IHNldHMgdGhlIE5WTUVfQ0NfU0hOX05PUk1BTA0KPiAobm9ybWFsIHNodXRkb3duKSBmbGFnIGFu
ZCB0aGVuIHBvbGxzIHRoZSBnaXZlbiBkcml2ZQ0KPiB3YWl0aW5nIGZvciB0aGUgcmVzcG9uc2Ug
TlZNRV9DU1RTX1NIU1RfQ01QTFQgZmxhZw0KPiAoc2h1dGRvd24gY29tcGxldGUpLg0KPg0KPiBF
YWNoIGRyaXZlIGlzIHRha2luZyBhcm91bmQgMTMgc2Vjb25kcyB0byByZXNwb25kIHRvIHRoaXMu
DQo+DQo+IFRoZSBjdXN0b21lciBoYXMgMjArIGRyaXZlcyBvbiB0aGUgYm94IHNvIHRoaXMgdGlt
ZSBhZGRzDQo+IHVwIG9uIHNodXRkb3duIHdoZW4gdGhlIG52bWUgZHJpdmVyIGlzIGJlaW5nIHNo
dXQgZG93bi4NCj4NCj4gVGhpcyBwYXRjaHNldCBjaGFuZ2VzIHNodXRkb3duIHRvIHByb2NlZWQg
aW4gcGFyYWxsZWwsDQo+IHNvIHRoZSBOVk1FX0NDX1NITl9OT1JNQUwgKG5vcm1hbCBzaHV0ZG93
bikgZmxhZyBpcw0KPiBzZW50IHRvIGFsbCBkcml2ZXMgZmlyc3QsIGFuZCB0aGVuIGl0IHBvbGxz
IHdhaXRpbmcNCj4gZm9yIHRoZSBOVk1FX0NTVFNfU0hTVF9DTVBMVCBmbGFnIChzaHV0ZG93biBj
b21wbGV0ZSkNCj4gZm9yIGFsbCBkcml2ZXMuDQo+DQo+IEluIHRoZSBzcGVjaWZpYyBjdXN0b21l
ciBjYXNlIGl0IHJlZHVjZXMgdGhlIE5WTUUNCj4gc2h1dGRvd24gdGltZSBmcm9tIG92ZXIgMzAw
IHNlY29uZHMgdG8gYXJvdW5kIDE1DQo+IHNlY29uZHMuDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4NCj4gVGhhbmtzIGZv
ciB5b3VyIGNvbnNpZGVyYXRpb24sDQo+DQo+IEplcmVteSBBbGxpc29uLg0KPiBDSVEgLyBTYW1i
YSBUZWFtLg0KPg0KPg0KPg0KDQpJcyB0aGVyZSBhbnkgcGxhbiB0byBhZGQgYSBibGt0ZXN0cyBm
b3IgdGhpcyBvciB0aGlzIG5lZWRzIGEgc3BlY2lhbCBzZXR1cA0KZm9yIHRlc3RpbmcgdGhhdCBj
YW5ub3QgYmUgZG9uZSB3aXRoIGJsa3Rlc3QgPw0KDQotY2sNCg0KDQo=

