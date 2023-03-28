Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3B2C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 05:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDh/i8UU5D4Ak/nsbsNuaU5Ge4E/NhN+97m5LVq17dE=; b=ti8JXBF2VFwVVYuBpKyQxTKpy5
	GT9wDqHE5Vk92BzY15fQj/OqzOhrYERdeb+SMS7UhLurHp5/FrBUPUZGj5NpIQBfvZ+Yj8KDIc5NQ
	LTQxjHnk1PHREfXN5zQccFRsbBopgteEKTB2V+LD1MK8zHj5ln/u6d972w+jU25RgNBKOnU+pHD0l
	red8+oH1TjgCnFfGz1ySv2GgZwdfFy5exqXPVBWsEOjRU6XPIb6wLKyjdc/46lmTycUHbxUFpMbVg
	20Q88An0qoIdRbi6vE9lIKUyuhvG3/eYzAus8Xw49T/txCUA3SovU16ZAg4CqwLkGQD41v1fchHqk
	Es3gxIuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph1jW-00DAO3-2p;
	Tue, 28 Mar 2023 05:18:58 +0000
Received: from mail-bn8nam04on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e8d::62f] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph1jT-00DANX-1e
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 05:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsVQ1Rcmfyl0h98gUh5pXE1iGk+fxY3EjnamT/XGi+V9XLXyl/2MfUJ0hdzpyBJnNHKHOcTElaTmzIUgEdDv7yHxw5mXYyF7Z+Xh5KkFt/7PFNvX2311+GhO4NpMumztXPv/BPG4U4i095G9EJ9j5wn3WMOOs/j7YAp7kqtQ1scHFFI6zGxZ+iTEd66EJBUhqnUsSdPu3+PYAh1P0Jm81CAjkVB/OKaGYbupIISULcL0/0wkOo2bQt2whNmECk+lYIf+rqA7Q3QQpw+D/oei1JBrUq6j2zOLUkbcH7p3b15ZrXd5sVcNvulc/sF4IDYciQpeJWtdqs/NdtbqnN7KwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDh/i8UU5D4Ak/nsbsNuaU5Ge4E/NhN+97m5LVq17dE=;
 b=A/UnU9CD4GkHzPKniHnUWQA1UDc7GDIsfT/T7mejzAY5mawkCLq6HA6voodIhhqOAjIIs8mVQBxXf9/hSp/cBhri5A0tn9L3MqeEbsj6lqbJ7/x1g/I7sFSEBHBKss4qPbdrjHAiqhXiGERLLWPv9xxJIAdo5se9Wo/qWUnX0OvDAnmKnj2t9L/QGRcHmr/u0dHY+4JTlDmBkPH9fDTlVB+7Z/KyHeAP1IKuJ0uYkxV/ztiPOv8aXTic5GunR0PBNS/a4etTiC5RUosnbCTOAGcNDPV/kT9WFI92ZL9/bqrPNDGxqgWdmWbszDFblLJRMSPE9+Zgs/iuVO/eeDW8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDh/i8UU5D4Ak/nsbsNuaU5Ge4E/NhN+97m5LVq17dE=;
 b=CXIXThWpk5D4H9c9CHpGsPkzpcsh+XLXJpU8IRu3inMdDZGs//nXaTwcuTK7Guo5sHrdkEGBgREWgYdNemRAU9jh1JG5FwqPI1UX+9l1IB5bkqVGRvINbReyLg/+qA/8NiUBjVvwzhTH/CMDcHveMn5fvEngxzLmIHcj4pFsWzG1U++LrU/RqimX13IewBDRXy+LV7ilVu5ZQY0bUpHTkFGejX7BlkZcwSgfa4EI3vSvGQF4UH8eoioa70ZtxX2DURHqziUB9PQogl8phsTclSHDywz5ziQ0aVDOjEA3m1yi+NG1cJjhp/s2nHAOHBOrGi+71PhUaVsKkAUxhr+xzg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 05:18:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 05:18:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/7] nvmet: use centralize req completion for log
Thread-Topic: [PATCH 0/7] nvmet: use centralize req completion for log
Thread-Index: AQHZXVxoLod20aUXlU62mPXp596GZ68PZkaAgABIkAA=
Date: Tue, 28 Mar 2023 05:18:50 +0000
Message-ID: <9384b6e1-d7dd-051e-c7ed-5e7ba57dea7a@nvidia.com>
References: <20230323075203.824096-1-kch@nvidia.com>
 <20230328005907.GA21639@lst.de>
In-Reply-To: <20230328005907.GA21639@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5025:EE_
x-ms-office365-filtering-correlation-id: 75d96aae-07d0-4a92-a8c9-08db2f4bea82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  KmqS5HQVJmY90f7uuRwu6ylvAzgkTxTQKy8Gekw91v2x07EpTZ9Dq/Tk+t9DCS213oDd3Yog7+vzK74C+WoHBe2qjNqzhH2HQsZkgESTYVOyiv10dvYGbPrUnpPWKt7LwWqSgCdzZbQW7k0u9ENHzdxzeggAMupHpML4tOzk1paySerY80yfQQ5bpwNOn6Ios38v++gUN7/e2opPj367ngw1sA434FQdcWFPm1BdecmysGlZqRyAnuGXXR3PEVPKb4tmUtrl9hYoBAisMk69lMj6qAUY92n1c78BjT6lVMBgF8zhH21h6AdXz6pzRIkpvumo8YMkRTKB0sE72tEVE2KXa/wozLzTF+vtC6Vu5RBaNkKP+mCxmaCuGGGfj2jGdfOnjVktT3QAaUV0LnYbvaoGWBoJ5kyv10vL1jaFt+t0OXxeI/pbXgTfLMh8+lAmzk7l67hqN93R9lyIoI8sO/YM1raDVvn5pI0drjq4GuDy4NwZtum4Z2GeqOElx3iL4DfyBJhyQ1l05rsRrGNOi7zaGsE/3C28Vuk4Rh5V5xWk2nAei6lqozDe/1KK0B5Ntk2G5fUE6wfWDMTe/fx3Ro6fbAfBqoCdii6mM6RGgtrv1IWPFtvhT1wv/k9BXimrHgQm/ymisHTArgVpSZpIeYwNVCjEsOLjD5cgMIg6eTsro4+fOhHKVkz4GdNsElZrRdyKlq7dq9kiwiHq5axAsA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(316002)(54906003)(478600001)(8936002)(122000001)(36756003)(38070700005)(31696002)(86362001)(5660300002)(66446008)(76116006)(2906002)(64756008)(4326008)(38100700002)(66476007)(66556008)(91956017)(6916009)(8676002)(66946007)(41300700001)(186003)(6506007)(53546011)(6512007)(2616005)(31686004)(71200400001)(6486002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aURzZnlKb0Fuc0Q1OVhMcE91YzBYcEFIeFY1T2pXd1hPMnJuMXB5R1dxa2dw?=
 =?utf-8?B?VDdQTGk5MWpQVXNCOUNubUlGSXdET2c1a0FBUFBDbU1UdW9iQUV5SmRXdXR2?=
 =?utf-8?B?WWMvLzZiVyt2VlZ3UFQwRTludnZmSGNhRkttTENHVGRTeU9LQjYzUEpiSU1P?=
 =?utf-8?B?aWtRTkpock5ybnFIMGhhVDZXUVczU3Z6RDNDQVlBWWdYT0MzZTJZMVhNZks3?=
 =?utf-8?B?L1BCY0RPbDc0OXhBNFFvSlVJVjNHVGk3VnpuOS9TKzlWSDhKVHlBdkFZZGxF?=
 =?utf-8?B?TDQvTlJZa1RLbzNMV0hGRVFWellzRURkOTZCU3UxZGhzSmZGeTBKaHIvbGN6?=
 =?utf-8?B?LzFLOFhFVGE1L0RNQlpJOE5YcVFMdk56WGc1SGwwNjlSaTBMM29tdHNSdHRa?=
 =?utf-8?B?MldDWENRK3BZRFBqay8wbCtkNEwyeG9LT3lmUWdhZ3Q2ZXVZM01UOGlwSjFs?=
 =?utf-8?B?WVhjMmh3bXVXMFA3WUtoVzh4RDNBMWUrSTJMdGh6alZDNkRtQnBMbmpDOVdX?=
 =?utf-8?B?eDg4MnVzbENIZTdvVWlORVYrNFMwNW1TM0tOVWJkQ1Awd0pMdVdHVzdRUmpG?=
 =?utf-8?B?UGhrN3RzOXE5VUxRbUhPZEtNNG9LTTNWMFRtS1hqU2t2UURVOHhtclJ5ZHc5?=
 =?utf-8?B?RlJMSHprOW4wczc5bGZQcitpeC8vMmdSOGRuTU4zMER0NmFPZnBYdWFTd3N6?=
 =?utf-8?B?a2F1ZFc3T1RUbVozWlhoRzUrLzN5NjMvS0lFcklpYlVnS21wVjdMSFliWGNp?=
 =?utf-8?B?YW9Nb1R2dlMycXNLTklPc1hBK0pRQ0FYOWZQNVhSQXVSNDc0d2xJbE5kQWpQ?=
 =?utf-8?B?TUZKU3BwRGZNWTVTTjk2cXdMWDZjTmEreEEwcUIwcjJCdThvSUVRUGROY2ZO?=
 =?utf-8?B?ZlRyTTNvRG1MU2o0T1V5ZTN1OStVQlV2aXhyOGUvRzU0U0ZWcUFCMDgwcm92?=
 =?utf-8?B?eTNSYXVwZi9COHF3dkxXakNyenowZmI2aUNGQlQ2S3M4WXhSckZYM0NoTGt6?=
 =?utf-8?B?ZURWdlhzSzZCSkRUcHk2LzZEM1BEaUhrT1pIMWIyVlRrTVcwSGliQkhxSGF4?=
 =?utf-8?B?VjJOVlRXT0RJdHdDcHZPc2U3S21XNWxkZ3ZoRlY5NTVXOVBaTU5XU0V4SXE1?=
 =?utf-8?B?MGtHV1BTQnE3UjZrM0lFRkVMTlVScnBsY3JQMVYydTZvL2VBQXN4dkVuanNi?=
 =?utf-8?B?MWRjdGhYTW1GcFRwOXp4dFFkUCswNDl5cGh3M0ZJcGsrZjBSWVhDRU42TjIr?=
 =?utf-8?B?Zmo3UGlFSGFMRVRGQ2FzcDUyQ0VBUmxmU05DUjgxaW5maFZYbUF0M2NlVmFV?=
 =?utf-8?B?ZndYU3FOdEt5aitlSldTSFRpbDN5WFRHdWhxaVVlc0xTNGZyVG1rMExSZkNo?=
 =?utf-8?B?c09RWUFnZnJNU3Y2NFhSbW12Wkk5V1o5Smg3dUVDem1CMEJZc2hja2RLSWZ4?=
 =?utf-8?B?Qno0a1dCNzlYZEZpcEcvZHFKWDBKbFNTMmhUUmlnald4R2FOVDNOeDBhMkd4?=
 =?utf-8?B?VVJ0QWplNzMyMTlzZndWVGtkWkpEQnRsL3p5VTJvM1h2U2N3NUZ3ci9iNnlM?=
 =?utf-8?B?eWhycHo0RmVTSndlVjhGeHJBVFVCWG14MGo2eXFlZWJqQ0hWRGpRbHZWUXo4?=
 =?utf-8?B?eWJ5RjNvUnIvWlFFckkySXVDelBpQnV3Yy9uQU00V1N3a3V4SVhCVDVkVnBn?=
 =?utf-8?B?NXVjSXg3bUM5V25yY3hWQW51a1cvdWZ6QlJOSUg5OXZLaHpRWThjM282NDc3?=
 =?utf-8?B?MFNtWkhFWVpzQnZ6eFRFcDFlOFRkc010cU5XSUo1dzFpdS9oZTJNbVFVdVB2?=
 =?utf-8?B?a2tsNFIxMk5INktuUlRXZCt3LzZudE8zV2pSVHhxdUxzTlJhd2xWcDl4WFdO?=
 =?utf-8?B?blVROHhyMmV3dXJyZWpnMUYzS0RrbE1JU3k0TmZXcmI5cXlVT3BrUFQ1LzBV?=
 =?utf-8?B?bnR0NXRyaXpiWllrRWpYWi9Zb3lUc08xS0FSOWlqazB1UHlHZVlXVXMxWDlu?=
 =?utf-8?B?N251ZCtYU0ZMZFJ5UEgvb0NOVnJycEFhZ2U0V3BYRUthNkhQZGhUTk9MMnJi?=
 =?utf-8?B?emhUc0x3d0V6SEcydzNJb09QTE5NbzBWTkFqYS80eFB3UUZ0UElwOFJaMXBT?=
 =?utf-8?B?QTVyY3p1NWt5a1Frb1pvaUt5ck13ZDJWdE83c0JqY1I1ZlFvQ3lxd0luQzI1?=
 =?utf-8?Q?sHZZYWCC9LGtLVjTE30xyT96FxJOpbcFFIgS3oJwsF8v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30DA43DD12E6E84EAB0E0DEDED8F2583@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d96aae-07d0-4a92-a8c9-08db2f4bea82
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 05:18:50.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rs1rDFYjBqtyN+AmmgAFww/mxZdn9vaUwjViCiaSmUpnTgImxO/7BuSAGCEuaW56NgRH7EEwZCni0rPhHR60lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_221855_789742_648E7213 
X-CRM114-Status: GOOD (  20.43  )
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

T24gMy8yNy8yMyAxNzo1OSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEkgZG9uJ3QgZ2V0
IHRoZSBwb2ludCBvZiB0aGlzIHNlcmllcy4gIEl0IGNyZWF0ZXMgYSBsb3Qgb2YgY2h1cm4sDQo+
IGFkZHMgbW9yZSBjb2RlLCBidXQgZG9lc24ndCBzZWVtIHRvIGFjdHVhbGx5IGhhdmUgYW55IHJl
YWwgYmVuZWZpdC4NCj4NCj4gV2hhdCBhbSBJIG1pc3Npbmc/DQoNCk9yaWdpbmFsIG52bWV0X2V4
ZWN1dGVfZ2V0X2xvZ19wYWdlKCkgWzFdLCBpbXBsZW1lbnRlZCBhcyBuby1vcA0KcHJldHR5IG11
Y2guIEl0IGlzIHBlcmZlY3RseSBmaW5lIHRvIGhhdmUgYSBvbmUNCm52bWV0X3JlcV9jb21wbGV0
ZSgpLiBPdmVyIHRoZSBwZXJpb2QgaXQgaGFzIGdyb3duIHRvIGhhdmU6LQ0KTlZNRV9MT0dfRVJS
T1INCk5WTUVfTE9HX1NNQVJUDQpOVk1FX0xPR19GV19TTE9UDQpOVk1FX0xPR19DSEFOR0VEX05T
DQpOVk1FX0xPR19DTURfRUZGRUNUUw0KTlZNRV9MT0dfQU5BDQoNCndoaWNoIGFsc28gYWRkcyA2
IGFkZGl0aW9uYWwgY2FsbHMgdG8gbnZtZXRfcmVxX2NvbXBsZXRlKCkuDQoNCldoYXQgaXMgdGhl
IHBvaW50IG9mIGhhdmluZyBtYW55IGZ1bmN0aW9uIGNhbGwgcmVwZWF0ZWQgd2hlbg0KaXQgc2hv
dWxkIGJlIGNhbGxlZCBmcm9tIHBhcmVudCBmdW5jdGlvbiBzaW1pbGFyIHRvIHdoYXQgd2UNCmhh
dmUgaW4gdGhlIG52bWV0X2V4ZWN1dGVfW3NldHxnZXRdX2ZldHVyZXMoKSA/DQoNCkFsc28sIGFi
b3V0IHRoZSBjaHVybiBJIGRpZG4ndCBkbyBhIGdvb2Qgam9iIG9mIHJldmlld2luZyBhbmQNCmFk
ZGluZyBzb21lIG9mIHRoaXMsIHNvIEkgdGhpbmsgSSBzaG91bGQgZml4IGl0IG5vdy4NCg0KLWNr
DQoNClsxXQ0KDQorc3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0ZV9nZXRfbG9nX3BhZ2Uoc3RydWN0
IG52bWV0X3JlcSAqcmVxKQ0KK3sNCivCoMKgwqDCoMKgwqAgc2l6ZV90IGRhdGFfbGVuID0gbnZt
ZXRfZ2V0X2xvZ19wYWdlX2xlbihyZXEtPmNtZCk7DQorwqDCoMKgwqDCoMKgIHZvaWQgKmJ1ZjsN
CivCoMKgwqDCoMKgwqAgdTE2IHN0YXR1cyA9IDA7DQorDQorwqDCoMKgwqDCoMKgIGJ1ZiA9IGt6
YWxsb2MoZGF0YV9sZW4sIEdGUF9LRVJORUwpOw0KK8KgwqDCoMKgwqDCoCBpZiAoIWJ1Zikgew0K
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gTlZNRV9TQ19JTlRFUk5BTDsN
CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KK8KgwqDCoMKgwqDCoCB9
DQorDQorwqDCoMKgwqDCoMKgIHN3aXRjaCAocmVxLT5jbWQtPmdldF9sb2dfcGFnZS5saWQpIHsN
CivCoMKgwqDCoMKgwqAgY2FzZSAweDAxOg0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyoNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXZSBjdXJyZW50bHkgbmV2ZXIg
c2V0IHRoZSBNb3JlIGJpdCBpbiB0aGUgc3RhdHVzIGZpZWxkLA0KK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIHNvIGFsbCBlcnJvciBsb2cgZW50cmllcyBhcmUgaW52YWxpZCBhbmQg
Y2FuIGJlIA0KemVyb2VkIG91dC4NCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBU
aGlzIGlzIGNhbGxlZCBhIG1pbnVtIHZpYWJsZSBpbXBsZW1lbnRhdGlvbiAoVE0pIG9mIHRoaXMN
CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBtYW5kYXRvcnkgbG9nIHBhZ2UuDQor
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsNCivCoMKgwqDCoMKgwqAgY2FzZSAweDAyOg0KK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLyoNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBYWFg6
IGZpbGwgb3V0IGFjdHVhbCBzbWFydCBsb2cNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKg0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFdlIG1pZ2h0IGhhdmUgYSBo
YXJkIHRpbWUgY29taW5nIHVwIHdpdGggdXNlZnVsIA0KdmFsdWVzIGZvcg0KK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIG1hbnkgb2YgdGhlIGZpZWxkcywgYW5kIGV2ZW4gd2hlbiB3
ZSBoYXZlIHVzZWZ1bCBkYXRhDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYXZh
aWxhYmxlIChlLmcuIHVuaXRzIG9yIGNvbW1hbmRzIHJlYWQvd3JpdHRlbikgdGhvc2UgDQphcmVu
J3QNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBwZXJzaXN0ZW50IG92ZXIgcG93
ZXIgbG9zcy4NCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KK8KgwqDCoMKgwqDCoCBjYXNlIDB4MDMNCivCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogV2Ugb25seSBzdXBwb3J0IGEgc2luZ2xlIGZpcm13YXJlIHNsb3Qgd2hpY2ggYWx3YXlz
IGlzDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYWN0aXZlLCBzbyB3ZSBjYW4g
emVybyBvdXQgdGhlIHdob2xlIGZpcm13YXJlIHNsb3QgDQpsb2cgYW5kDQorwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogc3RpbGwgY2xhaW0gdG8gZnVsbHkgaW1wbGVtZW50IHRoaXMg
bWFuZGF0b3J5IGxvZyBwYWdlLg0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0K
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQorwqDCoMKgwqDCoMKgIGRlZmF1
bHQ6DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVUcoKTsNCivCoMKgwqDCoMKgwqAg
fQ0KKw0KK8KgwqDCoMKgwqDCoCBzdGF0dXMgPSBudm1ldF9jb3B5X3RvX3NnbChyZXEsIDAsIGJ1
ZiwgZGF0YV9sZW4pOw0KKw0KK8KgwqDCoMKgwqDCoCBrZnJlZShidWYpOw0KK291dDoNCivCoMKg
wqDCoMKgwqAgbnZtZXRfcmVxX2NvbXBsZXRlKHJlcSwgc3RhdHVzKTsNCit9DQorDQoNCg==

