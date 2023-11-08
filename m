Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D1C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWVE3gdW57wjZ0mNBmsfEnDYVaKY3vVhDRsqMmIW0zU=; b=mxelESi9M6kZXGsvfyGsyOhvOy
	E7D7rHrj1NWcXHck6LvdpATFOpv9pfwyH3Ul8axFpK0Tpjb8JQyvzIBADsu+N06KEhmz1ADgESwd6
	tLVZezHQtPGCRS5XhfREZLkUOC2XTRvlUg5EjPkNIJWrut5KEpHxU0SWMplGXCt6JrGKXNddhukfP
	50v4NJOCsQWuYG2u2tyJgT9p5RAXQADPlbwV2GueQuq3bif1To7d6gBfkyTAszQaZQjyFcZUZb8Xj
	u3a06ZFw6IjCIm1BaFTt+7J2pDxwIcJ5J7gYf3KG1ETMgr9EukdKFo3cRcpaFBFnC1iM5l4/6mZGa
	/qJYuXaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0qjw-004pW3-1J;
	Wed, 08 Nov 2023 22:09:36 +0000
Received: from mail-dm6nam12on20610.outbound.protection.outlook.com ([2a01:111:f400:fe59::610] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0qjt-004pVU-0U
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 22:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCAxDVo1Ovq+ks45cQJ0PVfO0mfcogdIkAKdx4ZLlcCPOVC78fWfXZgv/xChiUXR0o3dSrg/jwyaY8wDgbk1opBnAv5hB4j/86JCJc11fly8QwJFYKBjw0WfNvnJ51/T0mBJ2PHh6kQDnJo8BCvXP27prTgebEXnwBXmyMURz5FIr2zcxQOYkv/UIIi7k5JP/Ddk3uHF1IcZ2/yymeA0q8LUlwvF5WFgmUZQJ6CnV/UFhipi8IcOjx9Kt74Q72peORobuI9VaJ5xy8MYEvDV7fOdrGI8SeVbZuEfGuX8GAKwJgU3Npoue1fmRGuigUFHqHukUWFP8QEcr0WIEtQPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWVE3gdW57wjZ0mNBmsfEnDYVaKY3vVhDRsqMmIW0zU=;
 b=WhcBw9sa3LZ5hu1WFMSMlRb8iMJ5Tp6a5B3byOjgLFwEpdlTgbEdio4p1bt1rZE4sefDDaNkSSC2ejBHZEQsjhzM2/D0Vg4PEwvpMrFpLnJvoJ7wXNAff+VSoQ+M2kXNHoxIRoWBHB1thAsTFRLM3NFBG4v2noIlMsWI02HMOge6MfVgtAgZYyFMa/9/Rgz+YVt4j93IiYqW00bmAUz6QpAu52xEiuP3LrTFE/SSXTXmArxOqeLWrOHdaW2HhPPwgG47CUyL21m87xIxSgWBpJ9AHTEgts4kkcUYUXbrR4cnz6JetHbUZ4j4FFZKNsK5+zVr1JxNB9IvDLvozK4LeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWVE3gdW57wjZ0mNBmsfEnDYVaKY3vVhDRsqMmIW0zU=;
 b=DKmf26VX/LFS+MtMRJ3VdaMHomXgPhnwhL2GqfjJSxImiCRBMFwNovq2cxrFkUjZRDc8u3qJNmHlrstddpC7v7q/3ncOrCjaY8Q8jIy/qjEyKmmjkhEbKrNiZFO8SYA+OlTBEhHauwrchpq1xRa+uQmUg1MIQNryF2gQU9s5JB5/OoHtuyvZtpc39ilIlB6BzeYrWmiEmfJWs6hNYBOhKUAb0aTE//ilWfUm9G+2CqcZKykIugweatw71htNKIYremg61U9OQ7qPn7ECsbcnkcsSVSA1yEiurpdAfMMCwxoOq32rrVq++4uYkTJ2GfD5bdleCk+TRwDK+zFlyVvvkA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 22:09:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 22:09:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Alon Zahavi <zahavi.alon@gmail.com>
Subject: Re: [Bug Report] NVMe-oF/TCP - Slab OOB Read in `nvmet_ctrl_find_get`
Thread-Topic: [Bug Report] NVMe-oF/TCP - Slab OOB Read in
 `nvmet_ctrl_find_get`
Thread-Index: AQHaELZzBoRn8E2uo0yWhrH10lGud7BwHqkAgAAEQgCAABEdgIAAELYAgAAycwCAAIfcgA==
Date: Wed, 8 Nov 2023 22:09:27 +0000
Message-ID: <afbb268d-5098-4b81-ab1e-a25f0b9013a1@nvidia.com>
References: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com>
 <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com>
 <CAK5usQsOP+4oV3YEcNN6Oe6_kBqP_u=e1DggJvNanH3qDG8+wA@mail.gmail.com>
 <7942920c-b3f8-4f52-b6a4-78a3cef2cba7@nvidia.com>
 <CAK5usQu_mi68_ChP4OckVmY42djdPx8L3hGg7_Jj0fa1yQ2mPw@mail.gmail.com>
 <20231108140312.GA32730@lst.de>
In-Reply-To: <20231108140312.GA32730@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6386:EE_
x-ms-office365-filtering-correlation-id: 4d5c68f7-3a59-475e-05f9-08dbe0a75ffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmtsoCP3CD2ofz01R8BlZbsmvErQ/cXHOOExhS9x+nVU4sqnFALK93BknYqTqDbFYfW65xJDUzYu/LOsv6P0BVZdT3krJpco7AFk9nepQgHiHrzRpCLeqgwXB3TGLWxuILy7X3V3QbckP7q7t3OI3gGrMNaFUYHJsU4VGTASNdaarLxcAJu5n9KLcOuCHw2paTB3DTdoamjr0BO+OChp1C4WJk1TM2blTNgaRsC17WfB9jiUh9di25/GsEocq7LM+d03a22g+kaZdxQVtZDF+kSLTyY3kXxFoZ1Wvm4hQRrKrju8cTt72lJoSRHT2vFyti/OZnkS0bCAh62uQ+CJyZh28vGCPSrbWANvuHMvzADx0oCLgBQD/LaAH3UemKrGPMrnS4wEUJztswXtpziSJtE753Ks9TOv+o5NxAuGAo4tVIJbsJHRpM8uTJ3/lnOW1qgZTF50s/bTvmgWWKB04LhvPIQIK3y3RceaOAzggi3t+80m0yGkxNAF6uA4RC8Lr2zMyGzEiqnPxa8zPms+SI8u+10p98r2C5GGNeDH8Ri/YzQBUwYY0fLpuuGP4bkbZrrQvGP+qqTEVkdEGql316hRr1xMWrvHUCdPm2SLfhxLIatdUoe8X05Kqio5NAYlfGoO8tfCLCZqYOYneq39AWZgeqpn9nxRD6w0cpTIWuio9yqPRMRO8XP+Jpyo4X2T2HHi/9wJH67uP7E7owP5cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(6512007)(6916009)(54906003)(64756008)(316002)(66446008)(66946007)(91956017)(76116006)(66476007)(66556008)(6486002)(6506007)(8936002)(8676002)(4326008)(41300700001)(478600001)(71200400001)(31686004)(2616005)(5660300002)(2906002)(83380400001)(26005)(122000001)(31696002)(36756003)(86362001)(38070700009)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3h5K0lEWWt4WVRJbHVlSGZsemxDbjN2aHkvQmFkOTZaemdNNm5oNHp1Yitw?=
 =?utf-8?B?ZDhrV2ovMDlQRjdKRUZ5S1Z5cTlFeGliSnRiTEl1VGNHNTByTzZWdW1XOGdu?=
 =?utf-8?B?QjRXVmhGMFNRZHFCL01PeXlmUHpRNlhHUCs5N202dmxyUlkvVWZhRThMVWxk?=
 =?utf-8?B?dFZ3OVNVazZJQUoxMDBtL09mdW5PQ0hTT3pueDM4NVd6L0VkaWpNSkw4ZURi?=
 =?utf-8?B?RjlyUmE1bG05eXJlckZzeXBtSHVzMmJYODBVQWoxMVh5dEhobk1hWFNpUUln?=
 =?utf-8?B?M1A2aU5TTlhuRUxGUjdwM1B5T0c3a3g3OFd6VUtnVlBMM3hMSmpUZ2xKOEhQ?=
 =?utf-8?B?U0VBNGZxZUJHL1FGUVg0cnRwY1BSYmhYVjN4NzJ5RFhDeDlHSCs2aE1jdGZx?=
 =?utf-8?B?SHBoMUtDcEd1cEZxUmN0S3RTQjZ5QXNBM1pZYzBpM1NwMEhUSnY2VXZCRllP?=
 =?utf-8?B?aHpNMmVLcmlRN3A1TmlCZjNCaXVabFpoSmZXOXdoN2JtTXozM3RDU2J4aHI2?=
 =?utf-8?B?dkxsd25vYWpuU1ZvbCttVVljZllZM1NlaTk0SXlTTGs5WTRtWHcvRDJtYUV0?=
 =?utf-8?B?VitaeExFZHU3SjJvWmRpeVcwRkxvMW5heC9TQWVsanlIaU5kd2FMMnpzMmNw?=
 =?utf-8?B?SlVMYTRhQ3RRYnRnK01NTEkyc1lucFR0RlB2UUxvZzhCRlUvZndRaSswWU01?=
 =?utf-8?B?dURzb0dtN1B1UklLTzNXdlZPRjQ5bGw3RmQweFZIQmVSdlY0WnRETStLMERC?=
 =?utf-8?B?aGxXbFFuOVVKRjdIdlFLTTB2NVV1ZXF6RGdjbVEvaGl2YVJlVkJCcUQ0c1Yw?=
 =?utf-8?B?SlMweHlWTTBkaWZPZjJWUldwa3hrZnRRREp3aWhKeE9mTjJZQVl5R2Q0aUZ6?=
 =?utf-8?B?ellkbXRWSjgyV2FTa3ZmMmM3S0o0WmI2NEZTUkd3ZUhHMlJtM1AzaldkSEE3?=
 =?utf-8?B?U3dPNmx4ZVBJck9QVDdaVHVWTUZKbEt6UmpJNXZ0eTBWZTREU09Pc0lmNE5n?=
 =?utf-8?B?WkU1SWpLQnpJZHRZcFhVbURGNkdzbk5BVVByUVJMdGcrUFdzWDZpQjI0YTB5?=
 =?utf-8?B?N0NMT3NtRHZQWHU4cEZ6QkVOUHNsU2lFY3lwRXlKNWZnYWt3SzBGRUE3cEYx?=
 =?utf-8?B?cjlqNmV0RVNWYU10elpyTEtYSFJ5a3hWWk1FeTlCVmpEeTZyMDMvbnk5aGR2?=
 =?utf-8?B?cGZMSlVoUG9Kc3Zqb0Rwd2ZTQ0NGaXF6RER2alQzZEdON005WWFvd1dTMWow?=
 =?utf-8?B?NWh3Q3U5bjBoMjVZYlZIeHdDZ3dleDJjWmdYL0s5ZXl4aGxpTUdXQS84dVBz?=
 =?utf-8?B?Qm92U2pZdldGVWJMM05qUG5WeDVLdk92WjJ5UVVOcUtZcHFpYXdEemQ3a0Vm?=
 =?utf-8?B?SG9XSkYzdVFSelorRWVkUnVKSU95ZXN4QWRJTU51VmRQOUdTdC92NHVHRU9K?=
 =?utf-8?B?L3NtK1FpMHMrNkxZVWNRWXFzWWdRdjBUV0htMjcrVFpTd3BJQUJ3VGhidWZF?=
 =?utf-8?B?eXB6S05ZRlcxYjVJRDdXWHdrM2dPZlNWRHh0dTN1VVNjMitvM2w1SU92L0xL?=
 =?utf-8?B?QXp4bTBudC9JZStsekljMHV1VzhyTkVHMU5YbXZWd2xrUDB0cnhTNWg3TTNX?=
 =?utf-8?B?VFpmdWZnTWZxVVVFbEZWWTg2VkNuUG1Ca0xRUGNSUUIvTzhIQ25BS3M0R2pt?=
 =?utf-8?B?WmtsRXg3eFQydDRZSjVvYkM5K25FM2F5ZmdkOGtpV3RwclJPOVVpUllBY0Vz?=
 =?utf-8?B?dTYyeXd5SXZlaEhGcUtLY2NkT1l1NzM4UFZLWHNjUzQxWVRWdHhyWDFHNjdU?=
 =?utf-8?B?QVlYTGV3TDVFMmZOcWd2WEE0YzMxZTNkTkNBNFdGR3kzUUFsYkZweFJUYStl?=
 =?utf-8?B?ZkY4UXhmQUZ0dmt0TGdHV29lNHg1Y2c1OVBvamlub1g4R3V3VUlvQThOZHpm?=
 =?utf-8?B?bXA3cEp5VzRvc1RFMzhYcXZhYTZtWkdaaFNqNmN1YXJxekY1UDlxeTd5REJk?=
 =?utf-8?B?SlRwNzJhL3puUVQvRUkxM3RubXk3MGVkNmU2eGZmeTJnd2FSVnlVT3h2aGY5?=
 =?utf-8?B?K2M4MHJPbFE3c3A1OW1MY3NvRktCV0x2czFSRnM4WkNwa0dReW5OSmIrUHBB?=
 =?utf-8?Q?X2JLupZMB9CO3mOVhyGJvQ3li?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4F91F11FF1B8742BE6BD7584E38B216@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5c68f7-3a59-475e-05f9-08dbe0a75ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 22:09:27.7296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kotL39Krz0DNj05EhjIuGeuGjeCSItrfwGvvkWMsiGMiri9+2oDcJU2xYYxts0oYbr4F8AGFiqickoWfq4WKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_140933_260085_6B8D1FDD 
X-CRM114-Status: GOOD (  19.97  )
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

PiBUaGluayBvZiBudm1ldF9jb3B5X2Zyb21fc2dsIGFzIGEgbWVtY3B5IGZyb20gYSBkaWZmZXJl
bnQgYWRkcmVzcw0KPiBzcGFjZS4gIEl0IHdvcmtzIG9uIGEgdmVyeSBkaWZmZXJlbnQgYWJzdHJh
Y3Rpb24gbGF5ZXIgYW5kIHRodXMNCj4gZG9lc24ndCBldmVuIGtub3cgYWJvdXQgc3RyaW5ncy4g
IFRoZSBjYWxsZXJzIHJlYWxseSBuZWVkIHRvLA0KPiBhbmQgbWF5YmUgd2Ugd2FudCBhIGhlbHBl
ciBmb3IgdGhhdC4gIEZvciBub3cgdGhhdCBwYXRjaCBiZWxvdyBzaG91bGQNCj4gZml4IHRoZSBp
c3N1ZSB5b3UgcmVwb3J0ZWQsIGFsdGhvdWdoIGZvciBtZSBLQVNBTiBkb2Vzbid0IHRyaXAgdXAN
Cj4gb24gdGhlIHJlcHJvZHVjZXIgd2l0aCBvciB3aXRob3V0IHRoZSBwYXRjaCwgc28gaWYgeW91
IGNvdWxkIHRlc3QgaXQNCj4gb24geW91ciBzZXR1cCB0aGF0IHdvdWxkIGJlIGdyZWF0Og0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9mYWJyaWNzLWNtZC5jIGIvZHJpdmVy
cy9udm1lL3RhcmdldC9mYWJyaWNzLWNtZC5jDQo+IGluZGV4IDQzYjViZDhiYjZhNTJkLi4wOTIw
ZmU3Y2U0YWM5OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9mYWJyaWNzLWNt
ZC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvZmFicmljcy1jbWQuYw0KPiBAQCAtMjQ0
LDYgKzI0NCw4IEBAIHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfYWRtaW5fY29ubmVjdChzdHJ1
Y3QgbnZtZXRfcmVxICpyZXEpDQo+ICAgCQlnb3RvIG91dDsNCj4gICAJfQ0KPiAgIA0KPiArCWQt
PnN1YnN5c25xbltOVk1GX05RTl9GSUVMRF9MRU5dID0gJ1wwJzsNCj4gKwlkLT5ob3N0bnFuW05W
TUZfTlFOX0ZJRUxEX0xFTl0gPSAnXDAnOw0KPiAgIAlzdGF0dXMgPSBudm1ldF9hbGxvY19jdHJs
KGQtPnN1YnN5c25xbiwgZC0+aG9zdG5xbiwgcmVxLA0KPiAgIAkJCQkgIGxlMzJfdG9fY3B1KGMt
PmthdG8pLCAmY3RybCk7DQo+ICAgCWlmIChzdGF0dXMpDQo+IEBAIC0zMTMsNiArMzE1LDggQEAg
c3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0ZV9pb19jb25uZWN0KHN0cnVjdCBudm1ldF9yZXEgKnJl
cSkNCj4gICAJCWdvdG8gb3V0Ow0KPiAgIAl9DQo+ICAgDQo+ICsJZC0+c3Vic3lzbnFuW05WTUZf
TlFOX0ZJRUxEX0xFTl0gPSAnXDAnOw0KPiArCWQtPmhvc3RucW5bTlZNRl9OUU5fRklFTERfTEVO
XSA9ICdcMCc7DQo+ICAgCWN0cmwgPSBudm1ldF9jdHJsX2ZpbmRfZ2V0KGQtPnN1YnN5c25xbiwg
ZC0+aG9zdG5xbiwNCj4gICAJCQkJICAgbGUxNl90b19jcHUoZC0+Y250bGlkKSwgcmVxKTsNCj4g
ICAJaWYgKCFjdHJsKSB7DQoNCkkgc3BlY2lmaWNhbGx5IGRpZG4ndCBzZW5kIHRoaXMgcGF0Y2gg
d2hlbiBJIHdyb3RlIGl0IGluaXRpYWxseSwgY296IHdlIGFyZQ0KbW9kaWZ5aW5nIGNvbm5lY3Qg
ZGF0YSBhbmQgeWVzIGl0IHdpbGwgd29yayBqdXN0IGZpbmUgZnVuY3Rpb25hbGx5IGJ1dA0KaW4g
cHJpbmNpcGFsIHdlIHNob3VsZCBub3QgdG91Y2ggY29ubmVjdCBkYXRhIGFmdGVyIG52bWV0X2Nv
cHlfZnJvbV9zZ2woKQ0KY2FsbCBldmVuIGZvciB0aGUgc2FrZSBvZiBkZWJ1ZyBwcmludHMgb3Ig
c3RyaW5nIGNvbXBhcmlzb24gc2luY2UgaXQncw0KYSBkYXRhIHRoYXQgd2UndmUgcmVjZWl2ZWQg
ZnJvbSBob3N0IGFuZCBzaG91bGQgYmUgaW4gcmVhZC1vbmx5IG1vZGUuDQoNCnBsZWFzZSBjb3Jy
ZWN0IG1lIGlmIGNvbm5lY3QgZGF0YSBzaG91bGQgbm90IGJlIHRyZWF0ZWQgYXMgcmVhZC1vbmx5
Li4uDQoNCi1jaw0KDQoNCg==

