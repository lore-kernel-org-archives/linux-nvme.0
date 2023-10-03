Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F827E776F4
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 03:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QOyMa2JsW4NFi2Mj2Izghljw7jII8NZPF+W+zoLIWp8=; b=sOjcndJma1AM5bJLInYyuI0OF1
	PFm/AffAyxnfJyCrhowkWugT2cRl7yPtedL+Eq7rpMuBabobveknd+VGS/EQUWulsobDJ7Hr71hRm
	QbXujIfx+A6/0iin5cCSHg7nPVgLqdq0PHHiI84Gs9XjTkmkjN0soTX0FhK1v1CHAzf5bVpEAuTHI
	l6KfvmlaPEge57z86n9yIRSFhizTUih6C2LgZet/SaiQQiU/GY4VzzAkT8zsM4/rAuVt4ROdOLn6e
	bNEOL6ZlpeLsQZ1e8Cyz2dJojT9N3DDE/HnVZbxPK0MBgA5qiPjEwqBdJKj1rD82hbCPuTuUc85Rf
	WqT8mlzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnWFx-00DjUY-1X;
	Tue, 03 Oct 2023 03:39:33 +0000
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com ([2a01:111:f400:7e8d::601] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnWFv-00DjU9-0t
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 03:39:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLwmNTSLKs3ZcWcumiSRXCE++4edMEDw9NeCniS0f93hz3zHd77pBfWPz61THuH8kTro2cBQ/bnFZ9lw7h0WGg5iwJYfLtRuY+X0Q/SY/mlTwDNRAwGMB0LGg4iFkyCvfTZ/1KuGJNuvdHl5uKod0cwgRyc5lBPj3K2lwLsxCrZ+3jTKaqwlN9U0TXJeLk5veRLycdcplchnHyRzhI6mD7w9khyfativgeYPOiMR7r/+jlAwNroZsunF/GCWUKlS3z1NhjRDoxbIF50TaxO+F9SGwCOsV2guXOkaXUSvLFhTAaWb12kGX4nnwsU03gudfp0bII0SWAnB1Z8TAs6q7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOyMa2JsW4NFi2Mj2Izghljw7jII8NZPF+W+zoLIWp8=;
 b=JDcMhgc55mqjoTRflECejU2Sphr2MIFmY4yQI5OT+cIIGWsRZEm9rzvmWLfmEOkUVFOD5eBs1+R5OrE+y4MnRbCxtNub3C5rRwVZkZR7uNIsy/DRYsHUM9Ql5XZSq6OjxxkF2JTYhHOynZ887Aqxm1KV5CYm4YCehe5kiOw+/+Pemv6iKg9W+5W1qvQguV23E4Hcn7pzwtoJ4W+ECL4+ASiJ0DBey7d/jOHSH0zMCywFngw0imzhsuKOcr1HJXNa8LuZ7vrupzX3U/q6nLQ7Jk6ofuzGuZNBDAdzfgqPps+Utqo10N/NcUeS2zHlMhVxjfp0RNL56QAkZVDKcQcyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOyMa2JsW4NFi2Mj2Izghljw7jII8NZPF+W+zoLIWp8=;
 b=DrTqgAstxI+zVGfZkcwE/i4l0BlYagZp/uPMjH521Zb0anje30zmWzjM/rN6gR8yNdNmCkNQIbVhaQffJIE35GTAU+0SuhG3PRpPxj/tQZT1iVTzZZVbkzgkgaULWsNNRe8kgMKc+p8fOped2JScOBhoHpGbQwKT9LrgLRCK2dPjL4bpownWrrMLQ5bYKG50qX0oew6bTk6b8bXzIoEb2xrMmUJdXb4aieUifJn9LYEJKJREfDMNOOnJoFLdI17TdBt6mUq5i/W5W1BFKKZt24QUtI86vOebkD9QMcuzDrtqvNtA1prjkXKU5SGiMzaEzMGuv6Tf8z25T5AtGnWNog==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 03:39:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::74fa:9ccf:a8e4:2e79]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::74fa:9ccf:a8e4:2e79%7]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 03:39:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, "zahavi.alon@gmail.com"
	<zahavi.alon@gmail.com>
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Thread-Topic: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Thread-Index: AQHZ9R7x+ebZk0axMkGKfd2/wBNMVrA3bCcA
Date: Tue, 3 Oct 2023 03:39:22 +0000
Message-ID: <eea851f6-5c51-1a97-3553-da903fa6c522@nvidia.com>
References: <20231002105428.226515-1-sagi@grimberg.me>
In-Reply-To: <20231002105428.226515-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB5466:EE_
x-ms-office365-filtering-correlation-id: 2a34ded1-d8d4-4555-34aa-08dbc3c2554f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ugrt67iwPrTptES5buC3bze/rMLtjgOxuxLb0yGjwa4/dJr9RgSMIaO/980dGD1/g0dXVQbunO5yZUtZHDOD2J9GhKSIQzjbCVU/oraOT2LmcrWPy/35sJzIzNJegTXO+JX0p/+0o3cY/Q8TCbF8kUZxwwu6JYyTmtlN2b5S3/Vu/q9Fj3dgChAmRSG08xHAjEZldwa9l/goLNaueR2xe38NkrMuBWNdYOFBxwjhf7HNcLefBGdwtQkD4A8a1WOMVc8HDmzWH9Hdct6liV57B5KHP01hK1D3d95qkVVz1S9uFRMhobX5ICoi8fEUQbiPQ1nfP/lzV1TE3VG0uoQJaNpheSDp96n5c6uMPmYWRZd9dD2/KonO4sILxdMB/yJfdf6+7oM95p3uVaK58X8O6ucZmgzhA9KCaMprbii36R2ENV2d4GmGvkh/J3qiyoczij42TzKCsqEcozrsfofAoXncuTjZD51Ten89GXMgdpayiFmIcdLpm3qvy3jGLmRqy/ZWHdewi8an9tIn7wwybiXr/FzzDe/8Egz6MEBuHjQSkIngZ5DB3mpzmHvid5sR/xC2Kj6FjWXN91W5yLg6p2rJWTkjuSSHljGcsgKUnMw/2csfCXnt0Fx5vP73zTYXZKqhDsHO1HXJ9mrs2ei1AmCfZEJmarguDgJAdvCNoG5E7SZv3gBtiYs813JOh70v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(6486002)(478600001)(53546011)(6506007)(71200400001)(8936002)(83380400001)(6512007)(66446008)(41300700001)(316002)(91956017)(6916009)(76116006)(5660300002)(54906003)(66946007)(8676002)(4326008)(66556008)(66476007)(2906002)(36756003)(64756008)(86362001)(38070700005)(122000001)(38100700002)(31696002)(66899024)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZDdjJBckhPbitiZDRGOVU0YXd3cU1wcDE1MFMxNlBzbVBDNUdCTEt2ZC9I?=
 =?utf-8?B?SVF4Wi9YSktTMWlScG1xZkZFV0tKMDZxVUdnNWYyYWk4WENwdFdMb0dockJN?=
 =?utf-8?B?OTltem84enFEWkl4Z0tpVkJDb285MTNud2w5VWpOVk04enZmMlExRU04RWVL?=
 =?utf-8?B?YWFJV1VqZXhhbHM3TG9Ic2pWc1ZnM0FLdW9melNFaEVSaVVVR2VsVlZXZlRE?=
 =?utf-8?B?YmVJeHdzUWlvd1hpcGgyVTVFV3JycFd5ZXdSdkJzWXo1VDVidXR0SWp3QXJP?=
 =?utf-8?B?ZTJsV0RUOExtdzZZdThlRXIyWURLRFZHUjZlL3JZNVRJUjNGUEVNUEdPQWIx?=
 =?utf-8?B?cEV0ajY4Q21EeTVzRk82aVF2YlhMNy9tOG8ramJnazFlU2NDdXo5eE5vb3Nu?=
 =?utf-8?B?L2hzZjM3SlhJOXd1dnlER3cxOElsNjJrSTM5OVF2VStndDltNHJQUyszT2dv?=
 =?utf-8?B?ZFowUEFBSVJWVVBvTHlwekN4eG8xRjBRb1hnNTNTUXBjaVJTTXhwLzFyeGZT?=
 =?utf-8?B?QlpZN01WNWFTczlSVi9XblRtS3lDNkZRY3ZQMlpOZVJrR0NMajl5M1paZ1BW?=
 =?utf-8?B?U3JmSTJ2MTJVK1BuclVSVUlhOVFNbndnSXZWZWtoaWQ0Z24wRlBjbVdHMVJ6?=
 =?utf-8?B?dUJSUnlwOXBSVG9UMjVFQThFbDczLzZQSCtvbGdkUFN6U01rK2lvUmdzS2Y4?=
 =?utf-8?B?aDE5SUVYc0VWQWluVUdWSXk4eXNVbW5BQkFqcE1aQmRFeWc2OFlvNmN5aWxw?=
 =?utf-8?B?Tms0TXFQeXNHaWZnS2h2ZEhjTEt3cWZjc25IUWtUMXNOK1V1SnJTZzlFdzZL?=
 =?utf-8?B?YlArTTIwTEUxMXJaTzNVOHNpOU5oUHpkZllQd0N6K2JOY1BZdkpsb2gxNTlz?=
 =?utf-8?B?aU9xbTNwTEJEb1l1Tk82TUNCa09nMnk5Y0UxbHljcHFGV1RCQTMzNVdwZzh2?=
 =?utf-8?B?cmRMNk4veW5VN2lBSlpMSEM1anV1aVJWcFowN3Rpc3BUMFRBRDUyQkxpRDBQ?=
 =?utf-8?B?aVBYUHdtaERPa21MbkdaQStrcENhMmZEVXlUMkxOc2VQZDVDUHF0TW1lTS9G?=
 =?utf-8?B?UU9XWFdic21sdWxaWEhva0g1ZUNIZkRjR2cwbTJRcDRqMVBJc1dWOTdoQlFU?=
 =?utf-8?B?SkhvTFprQ2RIcFJQRW1PVGVJZlZxWkRZR2E5elRVWHlpMm5mR1h0bE1SZEhq?=
 =?utf-8?B?dnZZZHVLcG9jNFNVaUFQRldXaGZidDd5aVNzL3ZIUjE4V0lCLzhVWFl5Q2RZ?=
 =?utf-8?B?QlBmT2lEYlRvV3lKNGxpeHByOEhuWlFWaVZONmc2Y0hhMHI1UHBscnBnRU5X?=
 =?utf-8?B?aUJyQnd3UzNpMDNDWVRGRFd6bGE4YXcrN0JRSnlJeVFQWXl2R0k2dXZhVlpF?=
 =?utf-8?B?eUU3bFcram4xYXZCOVFtbEY3QmNEamhqeUgwb0xEcm9mMVFqS29VQ01SVHNF?=
 =?utf-8?B?QS9lU3RuR25hWGd4WDd3RVVpTzMrNytHT0FQUGlMb0ZQVUkwdEt3bDNIMjhU?=
 =?utf-8?B?OHdyN3FzaGRWSW5DRWJoS0pFTzVXUVRPK1dDSVFaSzk0enVqTWR2Z1dZaHFr?=
 =?utf-8?B?VXU5K2lNaWtKbXBkYWc1NWlaekswbkFCQko5ZUJCUkJ5cUMvSTNBdnB6N3VX?=
 =?utf-8?B?UldFUGNvYVc0a3JtazVBVHJwckNORW9QYjNEcllhRFdTRldmMzU4ditoaXh6?=
 =?utf-8?B?VzVscGI5dTZPT1BqbWRHSDZrMFpDSkZmdzNKdXZWYTBIcU41dWI4c0xjTFQz?=
 =?utf-8?B?bFdOTVJKdnFrWWEwU2M5aFhvdWMwY0t0cE9GNFBnbUxrbGw3VStkYnNxZ0NQ?=
 =?utf-8?B?NEtmREs2YURHWlFRVVIvaGE4OGFYY2hicERVakVQWit6MWZhRWMvS0Raa2xq?=
 =?utf-8?B?OHJZMXp4c0VQc1Y4bWlqTXczbTNwWmZyeUwvS1d1NW8zV3VRSTBKV1JYZjR3?=
 =?utf-8?B?MDBrVFprNVIyNTlFbTFHb3hocmdUcFdPRUoyalpCTk8vZ3B6T0VUN1dCQTNy?=
 =?utf-8?B?ck1aaCtYYTMrTVlYaVoxNW9ZUTNFSUpHMHBvK2VKRlo4dy9aWUdvZzE2L01p?=
 =?utf-8?B?N0w3R0dGU1JzTW5YQ1phdDNJa1NDdE8vcGRKNkQvTGdKM3MvUXRVSDRWbjRx?=
 =?utf-8?B?UnNNZTNVM0UxalRXeDg4ZThBL0Zqbkg2bk1aU1I3YU1uQnc3TjdFQjJyRlF2?=
 =?utf-8?Q?Z/XYPTU3YgJFPyUusOkqLF8zHvrqpX04dwCQlQVIoyEp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5638A9B5E65EF94DA0EB031AF0E742B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a34ded1-d8d4-4555-34aa-08dbc3c2554f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 03:39:22.4823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7Wy9EOfcAKsEH3pwJz4NZ+rFQmiRwycKuBTX0IdVVvdPZOxge7jW+s4qcnFljuv7KCST3SHAlFRXIvDhDVoiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_203931_371962_834E7D8C 
X-CRM114-Status: GOOD (  14.96  )
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

T24gMTAvMi8yMDIzIDM6NTQgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+ICBGcm9tIEFsb246
DQo+ICJEdWUgdG8gYSBsb2dpY2FsIGJ1ZyBpbiB0aGUgTlZNZS1vRi9UQ1Agc3Vic3lzdGVtIGlu
IHRoZSBMaW51eCBrZXJuZWwsDQo+IGEgbWFsaWNpb3VzIHVzZXIgY2FuIGNhdXNlIGEgVUFGIGFu
ZCBhIGRvdWJsZSBmcmVlLCB3aGljaCBtYXkgbGVhZCB0bw0KPiBSQ0UgKG1heSBhbHNvIGxlYWQg
dG8gYW4gTFBFIGluIGNhc2UgdGhlIGF0dGFja2VyIGFscmVhZHkgaGFzIGxvY2FsDQo+IHByaXZp
bGVnZXMpLiINCj4gDQo+IEhlbmNlLCB3aGVuIGEgcXVldWUgaW5pdGlhbGl6YXRpb24gZmFpbHMg
YWZ0ZXIgdGhlIGFoYXNoIHJlcXVlc3RzIGFyZQ0KPiBhbGxvY2F0ZWQsIGl0IGlzIGd1YXJhbnRl
ZWQgdGhhdCB0aGUgcXVldWUgcmVtb3ZhbCBhc3luYyB3b3JrIHdpbGwgYmUNCj4gY2FsbGVkLCBo
ZW5jZSBsZWF2ZSB0aGUgZGVhbGxvY2F0aW9uIHRvIHRoZSBxdWV1ZSByZW1vdmFsLg0KPiANCj4g
QWxzbywgYmUgZXh0cmEgY2FyZWZ1bCBub3QgdG8gY29udGludWUgcHJvY2Vzc2luZyB0aGUgc29j
a2V0LCBzbyBzZXQNCj4gcXVldWUgcmN2X3N0YXRlIHRvIE5WTUVUX1RDUF9SRUNWX0VSUiB1cG9u
IGEgc29ja2V0IGVycm9yLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEFsb24gWmFoYXZpIDx6YWhhdmku
YWxvbkBnbWFpbC5jb20+DQo+IFRlc3RlZC1ieTogQWxvbiBaYWhhdmkgPHphaGF2aS5hbG9uQGdt
YWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5t
ZT4NCj4gLS0tDQoNClByaW9yIHRvIHRoaXMgcGF0Y2ggbnZtZXRfdGNwX2ZyZWVfY3J5cHRvIGhh
cyBvbmx5IHR3byBjYWxsZXJzIFsxXSwNCmRvZXMgaXQgbWFrZXMgc2Vuc2UgdG8gaW4tbGluZSBu
dm1ldF90Y3BfZnJlZV9jcnlwdG8oKSBpbiBvbmx5DQpyZW1haW5pbmcgY2FsbGVyIG52bWV0X3Rj
cF9yZWxlYXNlX3F1ZXVlX3dvcmsoKSA/DQoNCklycmVzcGVjdGl2ZSBvZiB0aGF0IGxvb2tzIGdv
b2QgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KWzFdDQoNCjEgdGNwLmMgbnZtZXRfdGNwX2hhbmRsZV9pY3JlcSAgICAg
ICAgOTIwIG52bWV0X3RjcF9mcmVlX2NyeXB0byhxdWV1ZSk7IA0KDQoyIHRjcC5jIG52bWV0X3Rj
cF9yZWxlYXNlX3F1ZXVlX3dvcmsgMTQ5OSBudm1ldF90Y3BfZnJlZV9jcnlwdG8ocXVldWUpOyAN
CiANCiANCg0KDQoNCg==

