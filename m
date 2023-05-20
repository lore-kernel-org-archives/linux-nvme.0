Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AEBC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 08:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nwTwxBpBlnRpxqHyLfu1kg5VIQ5Rkxl+vN0ypUNQxXw=; b=AuYzs8iJ8f9uRm6F+zzrld7GA3
	ihzHXeEdE+njDhQyTy22rq6cz6e3rP7zUtvb7yFjhvWBJrnxD10Vf8UzkUhW3VbAXP860uJuBeuWg
	+o9meFp2Jxt8Q+xKdvfdBvk3WUISQEzIKZ9q8jNemLjY4sfO5c5GyO60F7T3nDdQBNSqWxhbNtrSn
	8sYlsLkIAoGLXgI4C6wKGnWzVSxNSiBAoFM40FtcWDc8ETCAyC+MuNT/PLCeB+keCPCPR3xfPrHiU
	XnjOVqQ/Jd8NFRlYowcvfXy1REVPL5wgdXsL3nQMkZiIP5Um3iGQ+GLYMKDrZC+KUTN1hfhXY2w7d
	Croga7Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0HY1-000yWn-2Y;
	Sat, 20 May 2023 08:02:41 +0000
Received: from mail-dm6nam11on2062d.outbound.protection.outlook.com ([2a01:111:f400:7eaa::62d] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0HXy-000yW4-2K
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 08:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED5dKWcrkAczwtXLVKrvjYhp3NDmXalqMUAQXsU2jT7wVN3R8QcoNpG8eEAvgIgHTD8NDIs6gK3PC19wkldC9EbE3QsDB8D23pOj1Xv8KE4UnVoE+bF3pBSQm9m4l3+fXlr4adizRJ/4DLwH2zuIE5ql/UIGOyJ6PLhBFSB59St7aVNd5IKEzK4DP7PStN3kMY0zxCP1abOP5+fVGTFinrjZYFUDjTzN7tspbGq1sa9xLEH8yLDOHadRxQkWbchO7y9fDVAj7/tKODZ02vBSrIG7MGLI1yhaBLT3AksKwAzL1T1mdB8+g7sSyvhoZVHbqALjBevIXamP2gOXqehbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwTwxBpBlnRpxqHyLfu1kg5VIQ5Rkxl+vN0ypUNQxXw=;
 b=Qo5r6k3twqmQbMe6fE4pNbAkXqVXra7bVZxFh8bFtM7HSfO+XjTqH14vLej6njkuqP9/5kzeCYs79WVTSMpefNN9z4ZZd36nXi86i6kkmlD5aC8JleI5qZ2UuCMy5HBtXwdRCOgDDiCOi8c3AO7/SixhHXWFj6fjxsr4LPptcPuiPGWQMppy4RA72lRpovcI5JQtLAV0QvZmmRTDglGAiot9woSYYJx772ogha4CCuaFkCkYcQ/8AVpcasaCBULxOthboUyY4vmjIPXSYrSIDJTIokzluRpcNOFCzb4ZE6UHsZd5A3CAQw0MCYrorIvj4f2rxxgLRr/oz6m7dThR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwTwxBpBlnRpxqHyLfu1kg5VIQ5Rkxl+vN0ypUNQxXw=;
 b=oCm4jkKXpDpP2+yjom2jMT/so337rC4p0I754Oux3kfd2SPGJVK2fHlLukBou78SIzE0GpZM979G/1sYa+JiAk8GgZZ1aIL1AlPuh7PPTtaXONShya8iOJlWr8QJcFE9CWRkp/9ibC6j0HOYIfdhjbHynyTMk7XjImWV7RhvP2hnmgJ4Q3LnK9fuGFMYzY/Pzo6VQt5ULJUPcxQRI63TtFSc4v7C1royERJbWXn+ND6MFZ5KA+yuz7lGpbyVo5C8y4kj+1h7Q3czhneEmpenj9GeymfLHl5JaozTX578f8UMfwXCwK35OPugstrGlxoX59iPOnMA2gxVAb8606Kxmw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Sat, 20 May
 2023 08:02:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.021; Sat, 20 May 2023
 08:02:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hare@suse.de" <hare@suse.de>, "james.smart@broadcom.com"
	<james.smart@broadcom.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvmet-auth: remove unnecessary break after goto
Thread-Topic: [PATCH 1/2] nvmet-auth: remove unnecessary break after goto
Thread-Index: AQHZijYLronqYNwN3kqYJukto8yf2K9im9YAgAAynYA=
Date: Sat, 20 May 2023 08:02:32 +0000
Message-ID: <5cb7884e-3669-a616-9473-6fc13a14a1c5@nvidia.com>
References: <20230519094052.48575-1-kch@nvidia.com>
 <20230520050126.GA32314@lst.de>
In-Reply-To: <20230520050126.GA32314@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4109:EE_
x-ms-office365-filtering-correlation-id: 6b324367-e9a4-4f98-8f6e-08db590890f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  BkTLNmpG1qAobNCeSv/4Bmc40f+vYaD2x/EpAWxr6rg4R7HiQrW6udcEzY8JLU0YvguXMeLNVkrtqfQLTZqUqarIO3HFYDFFRadbjmbYsKqFlu++CJAdZ3heSMcHGVksIExZV/oeBkoAgFofhMNCckmseNnTltuNSlCfgc8ps3UQsRgXrg8u2oS4h5NTAmwfDYuKZqPGtD6egkthmrhuChrSnV5kiJT5lbHPBSrIsQWjChkhrqjmHq+XHQ2uakiYS29fy/h99oOIqmUIk8jo1jzyDGC9XGqEvcqZ1ecP3LgRBRbPwLUDhV3a2rJxvApWfF8OJsUtp5TR6APREryDB0sgLeOWRCDATqX8gfGs5EwYKWIkQtQ+4pZx9xxOSYGv3s7rk5YGptNoT18Tmxi8MZJl+T9sGvpBHSB2L7jiMP9W10QsmsoL7xW6eJO4/U/TIMZxrbxZU8DUfNg8Uk77GbLO9gACy4so36+X5gTP6UsZtYkH9k9Y9uxubwuskGnS6carD9aUyex5pjMWknlkSzVztzKTU7aP16cf6r2N0cwoj5CRGJNL+E/XCW2g52uwYetzEgQfRUM9TFLs6liqRcgcLPZQT+I8xDs+fhsMM+Q9yH2/zXpTrajSpOcv1EBLpapWurWdL8iftpK3V9UMxE6H0v5yJ9qy+Q9pdZ07BN4=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(2906002)(4744005)(5660300002)(122000001)(38100700002)(38070700005)(86362001)(31696002)(36756003)(64756008)(54906003)(110136005)(91956017)(66446008)(76116006)(4326008)(66946007)(66556008)(66476007)(2616005)(6506007)(6486002)(71200400001)(53546011)(6512007)(186003)(478600001)(31686004)(83380400001)(41300700001)(8936002)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NTBobjJSdlMvV1pDUkxkeFFZcHdWSEY3THJvNGM0d3V0MGkwNlZKUFFUWTJa?=
 =?utf-8?B?T3ZTYzZGZzltSGhXSVNBbHZEc1pqZ29qV0NwdERzMWgxM3NhVUs5cFRrT0Y4?=
 =?utf-8?B?VlBZZVZPSW1VOEtiVmMyaGU3eFFENGQ4cVl2a1o1MkJCdWp0RTRhUFRBYjE5?=
 =?utf-8?B?dlQrZkFCSlJWTXBiNExSY1llOUYwZExrVDBJV2d5bjZHRG0rQXZZS1ZQV00v?=
 =?utf-8?B?WXhDWXowSUVhWmxIaldiamVhNnVMTzZsRG10QWZIOUZSeVBrRkVEa0RDdVlx?=
 =?utf-8?B?OFNhdU9oMVYwbmZUMWF0NUprS1VCZGxmc1pFZUhHTjAwa0ZqaFJBTzJjT0FI?=
 =?utf-8?B?ekJkTDFocVdrYnlTWTJmQUlJcFUrT1FCRk81TEVvTmZTOUIrckRuZzA0YkNG?=
 =?utf-8?B?eUs3ZGRpaEtqTno2a05rSmFvcHpTa2g2MUhNU3hIY3M5Zi91cFUrYWNTekJi?=
 =?utf-8?B?Sm1TazNrQTRCc1pUb0RobG9BdFYvMXpoUC83TEtNTXFLUmMwbFEzaDJqaTZp?=
 =?utf-8?B?UW95UWdmOWFwZE9iSGVoenJ0QlM0QkkwZTRxWW1Cc1RMUU5CK3kyRXo2SXlE?=
 =?utf-8?B?Qk1JWW9kNjRCa2lvQ1NiWGM0TDNGQnJFcGl2ZElLbmdJcnl0TW5zOE03a1VS?=
 =?utf-8?B?dzVMb1VsVmtKcG9lUkxBNXgyN0FDcWUzdUtaR0Z1NmlHdXhQdXAyTC9xLzNl?=
 =?utf-8?B?L3dISEZzS20wMjV4dkxrUFRmajBaMTgvM3NGNzZBYStZUUsxTnBQdHB6MFJp?=
 =?utf-8?B?eGZpREIwTVBIOXZ5ckxpR3puaGREOU9FWjdPOXpiUjVuaEx1U25EbFhST1NQ?=
 =?utf-8?B?N3dNaG9meEdHOWU1WG9DU0toaE5LMGdBNWRESWF4eHU1endYcHh1NHFqNHJj?=
 =?utf-8?B?RlU1N2lVWnNGb3FBaDBSZXJZZzA3cHp2WkJEKzVkRjU5YWx3T2hiRTljak9H?=
 =?utf-8?B?cnhYYUt2dGYxekljanZVS0Y2Qlc4MHBoaDRBT1VTM1ZFZDd5UVZILzJ0bmdR?=
 =?utf-8?B?djU1Qlc0cEN5UVkrSVpaNVVoMUFOOEg4dzlCQ1Qvb0paR2VvL1FUa0doak5Q?=
 =?utf-8?B?LzVvVlQyelAvNm1CVDl1U0NPTmNBNmpJRGh2YVpueFVRUjFtQXNYT0k5NUND?=
 =?utf-8?B?eHhVZUNucUJFTXFCc1RES1kwR2xYYmJkSHlTNSt0c1pCVHZod2RTQmxZSHFo?=
 =?utf-8?B?NVFaV2pTMGxHZzRRVmVrS3BCV3FtVjR3ckRkNW9xcTJlYU90cjdkNnp4SUV6?=
 =?utf-8?B?OXRYSjM1RFVDTnpGd2luK3R5MnhUOGgxNGZwSG1ubHhZenRxK0k4alVWUERh?=
 =?utf-8?B?ZlYycW4rWUR3ZXI5QWZ1eFppY0NpNFlMSkJvMjlzZWlaYkpXd0dPVk5NSUVr?=
 =?utf-8?B?Vndsb0lXWXVoYTBPV09RVXNSZHk0RkowMTNqYWNiVmVYNnFuN3p3emdmd0l1?=
 =?utf-8?B?QVpyQjUvRUpVMUdJdlFHUTg2dVRVcDAyRC9wSVNpeFBQL1dlV3gxNHVDclVF?=
 =?utf-8?B?clZQMlVVaDRCalRVVGN3RGI2Tnl3YlJqR2xBenZ0NlpLdFlib2Mya0FqTWR1?=
 =?utf-8?B?MkU1VE5ZdW9hRHR6eUdYMHJnQmorQ3RwU2FKRUphMENrSExzN1NIZThWVTY4?=
 =?utf-8?B?WldhYXVTaDh4MHBQZ0J1bVJoNGo5bXlFQWF0MXZ2cWt0dFdTS0VwakxYd1pM?=
 =?utf-8?B?SEVpK3RxWlBNSWorZ0lDLys0V0d5QU0wOWFtWEFidCtaWjVKeUxlcldKNEpF?=
 =?utf-8?B?MmNvK3VEc0tjN1pPQUphdTlkZTltNkxBdno4aWNIMkNCY2lGSFl6WktLVm4v?=
 =?utf-8?B?UjlDYW4yMUVtY1hGSnkwdHI1WGp1ME9pSm94aE5GWWRkUVNuV3pGcmJMMDBD?=
 =?utf-8?B?MjhaUERDeStoaEw1QVVubEpHN2QzL29kdVFOQVV2YnhXa2dXajRWUVhxS1BS?=
 =?utf-8?B?WkIxRjloK3g0VzN3S2dLZzlPL25EdEZIS0RCcDNYMTc1bko3ZTJaMjd1czdS?=
 =?utf-8?B?bk9QL05PbzBkR3UzUDlIZ0dhaWFaMXRpRzBLUHpUcWZMWDhMdURLQklZbWJQ?=
 =?utf-8?B?Zlp1ZmhBNVVFaytXVlhTR0FZREcrTDQyVEhOYlJGblJMR2lZQldOT25RdzQ4?=
 =?utf-8?B?S0pETzJ2N2EyMnZxaklGcUVjWnFnSzR4RnRpMlBielJybmRNeWRxTEk1Z1dE?=
 =?utf-8?Q?eODdwn6P0SgPfmcphKssIPbn9dHvbWNMBUxMySAd/0dY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13ACF0C823171F4591770667BC5EA39D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b324367-e9a4-4f98-8f6e-08db590890f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2023 08:02:32.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAOEimdyT07OjEH5h7uaUz91IhleChJGDNiaDUYIC9Fb6n+tuO9aERhQVlPWQ8Khu+G8Wof0zSSC1rOfx7Q/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_010238_843606_8B35A011 
X-CRM114-Status: GOOD (  14.68  )
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

T24gNS8xOS8yMDIzIDEwOjAxIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gRnJp
LCBNYXkgMTksIDIwMjMgYXQgMDI6NDA6NTFBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdy
b3RlOg0KPj4gUmVtb3ZlIGRlYWQgYnJlYWsgYWZ0ZXIgZ290by4NCj4gDQo+IEFzIGEgdHJpdmlh
bCBjbGVhbnVwIHRoaXMgbG9va3MgZmluZSwgYnV0IEkgcmVhbGx5IGhhdGUgdGhlIHN0cnVjdHVy
ZQ0KPiBvZiB0aGlzIGNvZGUuDQo+IA0KPiBDYW4ndCB3ZSBoYXZlIGxvY2FsIHZhcmlhYmxlcyB0
aGF0IHdlIHNldCB0byB0aGUgZGhjaGFwX3N0YXR1cyBhbmQNCj4gZGhjaGFwX3N0ZXAsIGFuZCB0
aGVuIGFmdGVyIHRoZSBkb25lIGxhYmVsIGp1c3QgY29uZGl0aW9uYWxseSBhc3NpZ24NCj4gdGhl
bSBpZiBkaGNoYXBfc3RhdHVzIGlzIG5vbi16ZXJvPyAgVGhpcyBzaG91bGQgY2xlYW4gdXAgYSBs
b3Qgb2YNCj4gbWVzcywgZXNwZWNpYWxseSB3ZSdkIGJlIGRvbmUgdG8gdmVyeSBmZXcgYXNzaWdu
bWVudHMgb2YgdGhlIHN0ZXAsDQo+IGFuZCB3ZSBjb3VsZCBhdm9pZCBqdW1waW5nIG91dCBvZiB0
aGUgc3dpdGNoIGVudGlyZWx5Lg0KDQpzaW1pbGFyIGNsZWFudXAgaXMgYWxzbyBuZWVkZWQgaW4g
bnZtZXRfZXhlY3V0ZV9hdXRoX3JlY2VpdmUoKSwNCmluIGdlbmVyYWwgbnZtZXRfZXhlY3V0ZV9h
dXRoX3JlY2VpdmUoKSBhbmQgbnZtZXRfZXhlY3V0ZV9hdXRoX3NlbmQoKQ0KaGFzIGEgbG90IG9m
IGNvbW1vbiBjb2RlIHRoYXQgY2FuIHVzZSBjbGVhbnVwLCBJJ3ZlIGEgc2VyaWVzIG9uIHRoZQ0K
dG9wIG9mIHRoaXMgb25lIC4uDQoNCmJ1dCBwcmlvciB0byB0aGF0IHdlIG5lZWQgdGhlc2UgdHdv
IHBhdGNoZXMgdG8gbWFrZSBib3RoIGZ1bmN0aW9ucw0KY2xvc2UgZW5vdWdoIHNvIEkgY2FuIHNl
bmQgYSBmaW5hbCBjbGVhbnVwIG9uIHRoZSB0b3Agb2YgdGhpcyAuLg0KDQotY2sNCg0KDQo=

