Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F15C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 21:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42gKs2xXFB9d5chRTIKcaOGLwqDuOvz2BHXyG+FTo4Y=; b=uGJfLVM8OlEpCj9yt8u9MNJgr6
	6Rz1TdQBGXx+fO/P4L0+T8lhOxYD0bxN+ZMLWtrrjJe4/vGI6dyblY0IbFFxkqHAC8e+Xb1ExG/yH
	iDo3IeC/3gFPBX2jjvtNsTnfUEXNe5z37ZT6bLLtqScFbvGnv4djaEQbfNrzgHH+FhipJYUyWpVmu
	ymXa2xGVkBno5niss2bj1O0eKh+Ur0agP4YARqeg0I8wfSgNNIvAxIAvLHAHEQAUD0IFpolgeDSmn
	IC2yEbvm2fpZQHg+vl4Aj0tKRUlYMCN+UG++Z9RBqBrE7vcxrD48yDeFLXcrErbSr4BtiBCm7sfSN
	1J4FabQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Ttu-002Ssb-0N;
	Tue, 07 Nov 2023 21:46:22 +0000
Received: from mail-bn7nam10on20602.outbound.protection.outlook.com ([2a01:111:f400:7e8a::602] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Ttr-002SsB-2X
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 21:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6a2kbbfMv78o3EDxyGG0+jB/XhvsM65AQSwcSg6pKC0UNjHLSuf25BU1lJb7labk7XL8DNbweR+pJ1u17DNBp8d+7hnkG1Ql6i6F2+e2ZNRRGKPCT0vz4esWIEih+xCmtWxH6zBTsLJ0QDA1VM4Usb1sBbqylwpZG/9JCIwa7NpVTZyuZGf7s5rK/Aw7vl0QEj8A/Glr9yXN7oenNgpSbUBRo9OaidGUJ73ikejy2AXK0eQxCUNeHIJEbmTIVru6uuPkPs+Pf+xTsfFxk+3ZGCUie3hB5qbSRj+Bf//fgq3KjiHJbayKC5BNaAK2VGmd7S4sckNsC4RSUonALAr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42gKs2xXFB9d5chRTIKcaOGLwqDuOvz2BHXyG+FTo4Y=;
 b=Smx58OEwhqG1nmC0YmNEE2fyhKXSw4YKKdCAgpNfHIkq9qg2VsOq0lAfM1ZrSpFYZv60kWtMMWPPJFyB/vvOV64OhRud2MUHgHSQIvjyDVeIftLk0TRTWIuL1tAtQLdjunggbrUFwy0/w6Hu8L8WmnZqQAhlRTcW4BYbkh3CF0ZCQsffqnYEm6JMkCLO2sVWyiSn8fh/LHnggXUw0568jDRqwEPkVeJZPTn1vvHPNxgKrS+S4B7lJE2uPdGdcK8mkIRq7Ib6E8qmLArloTWsDJ8lLP6daPPTGty3ao11NF2P40VnbnUm56p1XkghiYTV2toLo7S5e7lqorKefJ/6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42gKs2xXFB9d5chRTIKcaOGLwqDuOvz2BHXyG+FTo4Y=;
 b=ZFA/qc0avhX5qH8otmSFEoaqg/b5/XtXjAWc/3tvkIzZ74Ovl/foXR+unj1ZyeyhESTsslocqcpeI0yRcULfWW/YcyqRdJ1aCbhrShOaXSMiOOf8900ILhfINCegvGtzmoXLb/d4Ql0P6i78kd6EmkqqOPqTvkgkblJl7VG/jbuTogce87N7U0i2OFduYARWT8LTQAX+CX3Ehb5BQByOlrnC3es6oF1Y1oSuVuHoasLkmchY94Gxu6c6dVMxQO7Wkj9rLA5l58S1ciGJAtY437AswW5LQFPGaT+8hNpVaG5btUXJSEAXRAJLIhfibUEkfHusVXpIBePa65yFmfcBpw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:46:12 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 21:46:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Ewan D. Milne" <emilne@redhat.com>, "tsong@purestorage.com"
	<tsong@purestorage.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Topic: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Index: AQHaEcEA0yfaha1bv0C9HNeQHQvmELBvZCOA
Date: Tue, 7 Nov 2023 21:46:12 +0000
Message-ID: <e7b8ee83-c63d-4b65-b446-2bdbac0084e4@nvidia.com>
References: <20231107212331.9413-1-emilne@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8868:EE_
x-ms-office365-filtering-correlation-id: da027cef-4ac2-4c2f-bce4-08dbdfdaf5bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3g8uwRYIQMS4kB7VNIdYGYVNJoqc8dsMDNMrBw3IJtM3UJkHVSaS9fK9iXRr5nrEg6nlq3jgBgAfxXazRawG0IaAaPVFvoVsGzw0qB1e3QGAFpmlYrPwAmv+PVeueTTu8UQwXLZA7VMPKk2TzYaD5zXoDxYgg7ZuuCDsb/vNh0JBrUq8lV6l/oVKEZwoS6AxDe9YSk/KisabiN3ELAaDdZMlmJAayrfH9LTdE+69We+i0ouk43/9UNTOBunZs6CwXndjQIRadOFZEBQ5o/zRtfKgsgHRnxfersFqON3AtJ/DzFuDPDU8cMpC+5PKhHNEI5RLSX66mM0nbilFUcyGLMlWzzU6RI6hir096r4YzhEDUEeorEIEQeFAym734/NzwLrS6BZIQjI5a4OfC6puEwIwyMr8OOfoXkf1p3zu+kRfGP4hl4TjBHeefZ0+Jxbp3FGDeNLl1hIIVGPCQ9TdLLR5OYj/AnH7iaqjKShdTBKwzaKynyIxCkgRaTCNuE1YrRJ4qPNYnMvl69Ukk97HfkCN/XqWP33BmyP6TZ1DWM3NBhtZpSP1N26KL+PGJwwcozh2R8AyLd90xpioDY7hYN247vRLn5dXDM4jz/GhigLS4wOkx6xhpdYNJwleu57CD4cNkG+j2Uy9Ru3iLuh4zaV4wDXE8ktTjvvlXW8hS7IOOS03Fy0EWsRfbuAycmZs8FnHzKe3EiHomJhp+/RNpLDwqbsRTJSvvfmdFqNGnU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799009)(2616005)(122000001)(6512007)(478600001)(38070700009)(6486002)(8936002)(36756003)(5660300002)(31696002)(4326008)(8676002)(41300700001)(86362001)(2906002)(66556008)(64756008)(66446008)(66946007)(76116006)(316002)(110136005)(66476007)(91956017)(26005)(53546011)(71200400001)(6506007)(31686004)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U081MDBITWtqYlB3NkZHSWM5dG5KZDEyL09jMU10YjdweGNpWTdZN0pEb1Vh?=
 =?utf-8?B?YWRBZ0k0OHVWMmRoU3dvOXhxRGR3OTJoK1lSTHlBbExGa2U4dU5zOUt0Rkwr?=
 =?utf-8?B?VFEwWG9Gc0ZKckZLeVc2RUVrK2c1c3QxYzU2MEh4OFN5b1RZVTZ3bUo0NFRw?=
 =?utf-8?B?dEFlZ1lWUUV1QU5zZG13V2JCK21ITWhFSGRXSTg4SWZZUkVoN3pCMVh1ZXpq?=
 =?utf-8?B?QUxZMTAzZjFXTG4vdFc2ZitlN0pYaXFwYnZnYnc1MC9xOUs3T3dUOVNWTVlu?=
 =?utf-8?B?cHB0OWlXbDZTejU4ZGplRHBXNDh2UzBnQmt5NHM0RzBGOUJnOEgrb3phSXRn?=
 =?utf-8?B?cWF4aC9WWTFxc052d0ZNK3ZOWHJndDEzb1gzNVMrdFNRQUNoWDBzK1FuYVFn?=
 =?utf-8?B?aXVSbGhUbjJpcXRaTzFFOHVCaWhLV2ZZaXZHWlY0OUpyd1BQZko5NjY3L3Ro?=
 =?utf-8?B?K0VnWGNudXZjUVNOSDZqcjFmNytBZTV0ZFRHMEFyd2xKeklyYXhEOGxiRVp4?=
 =?utf-8?B?cGRDMTJSUEI4L09tT0RSM09adXAwRUE0K1JzT3ZRc3VSN3hWOCs5WDdLVnpC?=
 =?utf-8?B?Z1BUdTV4ZmZwaXRDekVlWlpFZ2U3czdUcFZZSEFuYnh0RjlqMTNqaHFTT05i?=
 =?utf-8?B?c05MTklRUXpQcEtYMjlvTldKaFYvb3UxUUgzWkxPTGc5TUZ5dGE2MFNxTkU2?=
 =?utf-8?B?ZllpS2psdWk5QUVGWEdmWGx2d2M0eU5keDhxdDFtcm1BeTF3UTFiZ2FtR3JP?=
 =?utf-8?B?ZmtkNkF5ZGxVbnJRSXRzazkrYUxBM1pVOVY2cUVWSFBSSlFvd1lNWjZZem5R?=
 =?utf-8?B?U2dhNUIyZjE1WEFTMTZ1YzRlQzN1U3hsSHBWQjgxbDdlV2tINVZkNzd5YjZM?=
 =?utf-8?B?Vzg3d0YyNk5rZ3l4bE1CVVV0dlNEbjZmTEllUzNEOFBYbnVXcUlLVEF2ZTNs?=
 =?utf-8?B?c0ZtL2RFTHhRdkVzUVFUWjZoTHZxaDBkd3lWVklsOTlqMlBDSXVKYkM1aFlI?=
 =?utf-8?B?VTkwQWRyNmlQS2swdk12T0NOc0xGcEk0aHhTQzNnZ1lUYVZwWUpvZlBiN2xE?=
 =?utf-8?B?cExVS3lLOXh4ZG9RMDBNR29KRmxhZkc0SEtJZ3BwZ25uRngzZkxQdzBJelRJ?=
 =?utf-8?B?ZHF5TFVkZFVyN2xQNDVKK1NnMjlBdVIwY0lvMXM2dWk3QXpRbXFHdHhLbFhD?=
 =?utf-8?B?SFBzb1QrRTZaTmtpM2o1OWRiOVFONjBTN21HRFlUVENTVndIeDFaOVhCdC9s?=
 =?utf-8?B?ODhkSk4wcWg5bXlmcjJjTkZ1THkwWFpLY3RlUkdVOTN2L0o4ZDFzQzQ2cFFh?=
 =?utf-8?B?N1dxQVA3a2JzSnZMUEhUc2tKSjl3aUhXR2VSMis1R2RSMXBpSDN5MmYvSjdr?=
 =?utf-8?B?bG0zeG5aUDYzc0wyR0gyQ3gyWXE1QVB1MTFvR214cTZJa2ZFL0UyME1DY2Q4?=
 =?utf-8?B?UndEVXk2NzBUK081UHBRVGJJWVdvSzJWL3JRbFNTVzB6WmxaSjg2VlFZUFUz?=
 =?utf-8?B?Uy9WWlFTQ1ZMeElVbFY2SXZYL3VEekpvNzNOREIyTFZQZDFXRnM1ZGlCQy95?=
 =?utf-8?B?RG45UHRqNE9XRGI5b3BCS2pYblpVdEg3TXpqTnVZdk5YZXhESWgwWDN3dWJL?=
 =?utf-8?B?VmJIVTl6N2JrTVI2UE9nN04xUG1aWkxVeU9lTjVJWU1oL050YWhrbEZXU1BQ?=
 =?utf-8?B?T3lxYm5rZnQ1RTQ2UGRSc1dibjdLZ3dsenFwN0NwWEs0eG9wREpXM3hIZUsv?=
 =?utf-8?B?Q0JPU2F4N2JrZExKKzlTcXhFVzhna3pHUXlGVldtRGhQcWY1OXl4WUg5NGxY?=
 =?utf-8?B?UHJuejc2SlAzVERYMDBzUTVhczJGNGZPN08wVXFWamNKcWpNSTN2NExMaEZw?=
 =?utf-8?B?RjZmU2JQTUpzQ3NMR2lKTjZ5SXRnOWZFOXowRTBNWW15YXdWaGpOQVdMd3ZW?=
 =?utf-8?B?RU44Ynh6UWZpbjBVTTZIZ0p1bjJLOVBXVkhIVFdxV3dZdUZpTjN2RlhmODdx?=
 =?utf-8?B?d1dZOE4zVTVDR01iVUVKcHpXVmlsdFZCS2JsbkU0NXh0UGxUSnhRQmNseHVu?=
 =?utf-8?B?cFB2TTU0dFBvWnlVMHpoSFJNSzg5M3dkS01idzhCd2xvOWFUaGY4UDgyWHhi?=
 =?utf-8?Q?zkR5Ep7PzRbaq3vbmaja9gzA1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E1EFA5554A9CD40B332C8742112FB07@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da027cef-4ac2-4c2f-bce4-08dbdfdaf5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 21:46:12.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJjZSfO9qQ/jbOUNDpNtz4btBCFI7N9DPiMkT1SYn68zEkuZ9j+vp3cJTzMnJ3rENS7QdU5WoK88ptcamY0Fxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_134619_829758_6FADEC10 
X-CRM114-Status: GOOD (  14.43  )
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

T24gMTEvNy8yMyAxMzoyMywgRXdhbiBELiBNaWxuZSB3cm90ZToNCj4gVGhlIGV4aXN0aW5nIGlv
cG9saWNpZXMgYXJlIGluZWZmaWNpZW50IGluIHNvbWUgY2FzZXMsIHN1Y2ggYXMNCj4gdGhlIHBy
ZXNlbmNlIG9mIGEgcGF0aCB3aXRoIGhpZ2ggbGF0ZW5jeS4gVGhlIHJvdW5kLXJvYmluDQo+IHBv
bGljeSB3b3VsZCB1c2UgdGhhdCBwYXRoIGVxdWFsbHkgd2l0aCBmYXN0ZXIgcGF0aHMsIHdoaWNo
DQo+IHJlc3VsdHMgaW4gc3ViLW9wdGltYWwgcGVyZm9ybWFuY2UuDQoNCmRvIHlvdSBoYXZlIHBl
cmZvcm1hbmNlIG51bWJlcnMgZm9yIHN1Y2ggY2FzZSA/DQoNCj4gVGhlIHF1ZXVlLWRlcHRoIHBv
bGljeSBpbnN0ZWFkIHNlbmRzIEkvTyByZXF1ZXN0cyBkb3duIHRoZSBwYXRoDQo+IHdpdGggdGhl
IGxlYXN0IGFtb3VudCBvZiByZXF1ZXN0cyBpbiBpdHMgcmVxdWVzdCBxdWV1ZS4gUGF0aHMNCj4g
d2l0aCBsb3dlciBsYXRlbmN5IHdpbGwgY2xlYXIgcmVxdWVzdHMgbW9yZSBxdWlja2x5IGFuZCBo
YXZlIGxlc3MNCj4gcmVxdWVzdHMgaW4gdGhlaXIgcXVldWVzIGNvbXBhcmVkIHRvICJiYWQiIHBh
dGhzLiBUaGUgYWltIGlzIHRvDQo+IHVzZSB0aG9zZSBwYXRocyB0aGUgbW9zdCB0byBicmluZyBk
b3duIG92ZXJhbGwgbGF0ZW5jeS4NCj4NCj4gVGhpcyBpbXBsZW1lbnRhdGlvbiBhZGRzIGFuIGF0
b21pYyB2YXJpYWJsZSB0byB0aGUgbnZtZV9jdHJsDQo+IHN0cnVjdCB0byByZXByZXNlbnQgdGhl
IHF1ZXVlIGRlcHRoLiBJdCBpcyB1cGRhdGVkIGVhY2ggdGltZSBhDQo+IHJlcXVlc3Qgc3BlY2lm
aWMgdG8gdGhhdCBjb250cm9sbGVyIHN0YXJ0cyBvciBlbmRzLg0KPg0KPiBbZWRtOiBwYXRjaCBk
ZXZlbG9wZWQgYnkgVGhvbWFzIFNvbmcgQCBQdXJlIFN0b3JhZ2UsIGZpeGVkIHdoaXRlc3BhY2UN
Cj4gICAgICAgIGFuZCBjb21waWxhdGlvbiB3YXJuaW5ncywgdXBkYXRlZCBNT0RVTEVfUEFSTSBk
ZXNjcmlwdGlvbiwgYW5kDQo+ICAgICAgICBmaXhlZCBwb3RlbnRpYWwgaXNzdWUgd2l0aCAtPmN1
cnJlbnRfcGF0aFtdIGJlaW5nIHVzZWRdDQo+DQo+IENvLWRldmVsb3BlZC1ieTogVGhvbWFzIFNv
bmcgPHRzb25nQHB1cmVzdG9yYWdlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRXdhbiBELiBNaWxu
ZSA8ZW1pbG5lQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIA0KDQphbnkgcGVyZm9ybWFuY2UgY29t
cGFyaXNvbiB0aGF0IHNob3dzIHRoZSBkaWZmZXJlbmNlID8NCg0KLWNrDQoNCg0K

