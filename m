Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/RPnoRODobQc1lwDznaldNu65s/D5k9ikoonj3raUg=; b=c6uWR6dPg/P1SVyC0C6mkzZSD5
	NIeCR+GtXLXL84OMzO6oCG0XeCpmTIph8dUHIZf2eWZ1vN6E7PL/WfKMEn7L6gCDZ6vaPDIUwQI9a
	tuKK6zotW/lwrhwLtIZR857Z9azj/BHc/cqJtYxhP3w9Iak9P5XTwDEBgTJCZtLoxBpSI69UqK1o3
	BSsi2aRSnPJDIDCmRJhulpPMliGwFS7C+hqxYRY7mjDOaY0H+xKfhMYOUimLfG3XqrADms7JmQKb8
	D7TCrhFmgAK6f1VoCwcn/3ZQdZDcabh5Vp65cIirf1Uzndzz2mzJr7BX4e813JQQ3rcfSGSP39O2f
	QbsQrRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWP5M-00984f-Pr; Mon, 21 Mar 2022 20:57:04 +0000
Received: from mail-dm6nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWP5K-00983W-K4
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 20:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NveJ9gC6EAxcwjLlSxUfYcLmvpcy/WhhlyLAxDvnb89miI1kvcEKYOaKl6l5BuH7RuLs6YDuVTsRzvRPLs2lsr0kL+2q3Q/ZP+fx69dX//BYVL76+4ooatQ3EE8Q7Bqgc5a+Frr0RApY/ayTLpVB0920DOmWEFpS6RcvqO6ag/aotzStqhYqDbLoTNK7J3Li+Tomxf36j4ZVifkkjuFDHQBNvYDiEKX8qQDxOGHelNUJYUrqUeJHbTck+nB08ELrtPw06PTTlU+1QZKs3F11zra+g/HbYQZabuzTlIyZrBDgySvnQjHUmseX0Z7DB+8616Bm0IqO4IoWXGE8wZQN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/RPnoRODobQc1lwDznaldNu65s/D5k9ikoonj3raUg=;
 b=hTOsu4w+yQFrL6mpeNeijwB5o/3HW3/1KUerGdGeyIXtB+blgOJNKzmxHrKsLKoKI1UQk310xVJTZgx20JAbzJs21VgwKQjJGyQ++rCOOC/RN6SBwZn+3i1d2qDQWSouPfBm5sg/vlJR8ujJSKONwQjYMmX67fK4/ug91XpcJj63YgENZ2VXY3QfKPR0J30SztplPiMq3QL/mCfILVHuJf8IERQfJiY9+5w+N0Jh8gN7wHbE++KvYM0ll+bILG3dlp9luF8jOXwiO1wFurUuLciEf4OkxfuyxfGQx5JZihJ6q4fUxx50cV02ncWxKhd/RD4SQbvEtkV4ULIcu6xWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/RPnoRODobQc1lwDznaldNu65s/D5k9ikoonj3raUg=;
 b=HHaKjfv5b+OXfeP/nFo7NNJ1P/jDOuj5vmQMVDcWZp6Jnyp+Nv3dK8LKKnXoDt2B9MDSBm698IO2t59Az+Mhcw5I6zfevjNjkpdK38IGx/zRp6PR88DWyETiIFVCgFXFdO59wQXRiXahzowWNbqEz3lH3vsWOoe3yA4qesZMCMbBRuVFR4sEka/9t6tggxLVS4L188n89pAuBOagkiheVltA57G4dhUOEH5ri4JhYMZQY4fWG8Ovxh7xIt26UT9b7FQJU1EJIL5TBW0CU8aJOQSp7aaSITf7Z0lkAhXEqWpIYERVawGSGZqNnr2l0jwlHjENcLMaW5/tB2ijR6bngA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3853.namprd12.prod.outlook.com (2603:10b6:208:162::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 20:41:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 20:41:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC: James Smart <james.smart@broadcom.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvmet: use a private workqueue instead of the system
 workqueue
Thread-Topic: [PATCH] nvmet: use a private workqueue instead of the system
 workqueue
Thread-Index: AQHYPRr9rl9yZRaBYkm4sbV14syqNKzKTbwA
Date: Mon, 21 Mar 2022 20:41:00 +0000
Message-ID: <d8378170-5a2b-273d-a946-babc7b995dff@nvidia.com>
References: <20220321115727.774650-1-sagi@grimberg.me>
In-Reply-To: <20220321115727.774650-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f6c77e7-6f7e-4c2a-5d3a-08da0b7b1bfd
x-ms-traffictypediagnostic: MN2PR12MB3853:EE_
x-microsoft-antispam-prvs: <MN2PR12MB38534E14585E049A54204F42A3169@MN2PR12MB3853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGop443KpolmqR0GhVSh5vtyCA0ozaSKZh1FgP7Rc5isxNjGU/4BS4vl830Q5kSJs+T3pGEaZM2lpA2zmOXdRy64aW7mZKGBl70W3HWVmeekPoORy9A5Mni4E7yObzaLYX6Oc2dhfCF+whuF3ILe2XY/Z10XAiDB6Q7zjL+liJCU7FSk7+WhPRbuMM/6QChEfJpwfP3cIYtAK65TnOCXyZw+SJ33/Vtiu3rxJ/LCHS8Q3ZOE2yDOTXEX4aUj9z/NStNkl7GwLkdF+HOQ2Tat8N/anW3PdUfYGR+oDGwhCzde9YJDOG4mk9bG3J4URkVw3s7ItAmgavJflTZXWLPqelYDkCoj3xdXyks2Z/ExpIYfBAT+YJsBvk/g3yUzShJRS/KJCcDykrv7Gv8Yx4U+4hDWRJ1s4thPXjbbQYxEh5G/9BCwkHVObbo78jE0EIxhUhLxN2JztkJt+Tc6mgjbNgANt7DHV8j7QL68yk7fvH10BKvXk4F6oqoFze1Lm9TQYj36jA4LDwJwyHE2kZih5CI7dUx3w1E6/MwK/d/JDPWAWAqODVi8YznWLlvV1dAcfpwlhlsE8IqeyfBAF8ktlNqOFP86LvN/Etkw3FnDb8MgdOgC8IXc47FYfemckuxnGIyV0mhEw25Av4B3G6QG79RgTcN7JQLFzD8KNCJ2WekkjL+/S8UuDn+DEaa+4V2IgZPxr1bfH6eHXr5bU9uU+8BBMLQhkmEpzMIZdyKzvh75RliZzlMgTiJXS/A2OT2/jvuaD0Z7rPUeyanTjvNYjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(5660300002)(66556008)(4744005)(110136005)(54906003)(53546011)(2906002)(6506007)(316002)(71200400001)(6486002)(508600001)(6512007)(26005)(186003)(107886003)(8676002)(4326008)(66446008)(66946007)(2616005)(64756008)(66476007)(76116006)(91956017)(38100700002)(38070700005)(36756003)(31696002)(86362001)(31686004)(122000001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU5rU2VQRmZ1TE1xcTdYUVRXN3NTNjRiZjFBdUg2ajJ5LzhONFNuMHFKemcw?=
 =?utf-8?B?WnlzdThWVlVsVTRoOFF6aFVhVFBYRmZXVDRlMm5yZ1VSUXVZK3BGc0I4RU9z?=
 =?utf-8?B?aDZBRkZmcFVVMFJBVkNNSzdHMEV4T0FJb0liWnRqSmJzQ2phTHp6SEZmQmdm?=
 =?utf-8?B?d3hpV01heVdFalcrbkREUzJsempjcGNrV0xwYnpPZG5DYUFqb0h3cS9jOWox?=
 =?utf-8?B?T2ZZMUdYMDlYOGVvOVlEQjJmV01Vc1czOVVYWXd0TXU3eGdaTUMyZ0JyMmhV?=
 =?utf-8?B?UVlrOTZZUVNkRW1ON09Tc2kxOTZ2NkxUTHhwekg5MGljMUdKN2NLM1NBSHhY?=
 =?utf-8?B?Z0x2bTVSeWNERjdoNlIvUGtpcHJhN3lqUTNjNVJ6dXV1VCttUEZBK21PWUw3?=
 =?utf-8?B?UEJSRVVqS2JTQ2lacUhtVjhLd2tWdTRDaWcwSzIxV0kzb3p4R3NpUUtlandq?=
 =?utf-8?B?cWh3dXZjRU8vTTFqcG9zejZGbnE1UFRpMzkwSk5rMU1CVGJDK0tDN1pFay9B?=
 =?utf-8?B?NmdZUlo1aTFGaDVMNVhOQ2ZEaVZpZlBUZXpETW5EeXBFWUkvU2c5MVFRRkNH?=
 =?utf-8?B?Nlc3UjRnVnVWZ2hVZUcwMGNOSXEvMnFHVDExTk1vTmc3dXRWWkNGVWhyc1dn?=
 =?utf-8?B?bHgvNzhoRzVGVEU1U1ZrVzQ1WDZpaG9rRFAwWmVFRFFmTXIyU0JuWjhTNk9a?=
 =?utf-8?B?S09WV01rcWNPOEVrRHdweUFWTFc4U1RheTBGR2FkNzNoT24xK1RSYzA1Wm1V?=
 =?utf-8?B?SEYvcWZwYVhTckVoQW5kVnRLVEZpdjhpa0xOMVZTQ3B3U2xleUswMTM0cFhR?=
 =?utf-8?B?bXlXL3prbklRTzRXSDMxYzh3blYzZ1hoOGVFNm1STThSQXJnalpZdzh5Tk9F?=
 =?utf-8?B?U0h2L3Vpbm5vS3hRc1AvbkwweEI1MjdvQXNHVFp1RWFwbUNhUklYcmtiSVdY?=
 =?utf-8?B?UzlYR2lRODUxQ3IzRzlkcnA1dHYrRThFR3Q5RWVvV2tpNGNueVNtVHNWcTN5?=
 =?utf-8?B?d2tHU0NaNUQ2NWkzcisxVU0wanhFaXJla085THorZEhMUjJRR0xsSkVGMHBV?=
 =?utf-8?B?MEZwZEFYUFNVQ2kxaXNSRG9wZm9Xa0pxNS8vOEdDNUVPUGtSV3NPb2llbm9N?=
 =?utf-8?B?RFdXcUI1M2h3dUJsck5tUVJzeXVjWmQ2cUNzUzVXVFRzMHhvbzBGTzZ4S1lT?=
 =?utf-8?B?M21qWEI1ME9VcXRzdGtUcUxUc21rVExnWXo1RW1aUC9wZ3pObkZ5ZGZzYUNq?=
 =?utf-8?B?SzdtaGZqVjhJWmpJcThrTjBVb0FRRjAvU3IvZFFtNHRITVpzSHVWYUk3Ymow?=
 =?utf-8?B?N1dpWlJUZkllREc1MzZsUWp2Y1hVSVBuQkJFTXpNUXVXenhpQWNaWTRJakRm?=
 =?utf-8?B?TlVLRmpvTXVSb0V3ek1Nek1OWFQrWEtPQjFlcWx0Vi9LNzV2NTRhVGdGSVYz?=
 =?utf-8?B?ak1ZeFl2Vi9XbWZPbURpRXNjZjB2cGlzVHZxUWs1SjVVUVBTRkZ3ZUFOVU03?=
 =?utf-8?B?Y2hLTHpKdWdtUnZVOXZ1L1gzMEV1UlcwNlJ5VFlRVkdWcy9IdjZYTVV4aUhU?=
 =?utf-8?B?aWY5Q0liR3RWNmRnc3ZlMk1iNHovN1RlUWQ1cDc4RUxRSnlWdmNlQVRTQThW?=
 =?utf-8?B?cnJENlhpQ2FKOVlHajVReDVRQkpJSUdJdzltV1FpWFpuYmEwU3Zhb2k0RUdU?=
 =?utf-8?B?OU01ZXJhaTRWQXBydGpOOVdyenYrSFNzWWZVWVdKWFh3anVuRHNoSWtHaUhC?=
 =?utf-8?B?d0M5d0djZHNBa1pSNThrb244NXpyTVkxZEgrdjZ4RG1IQU1SMS9tVGdzTTZ3?=
 =?utf-8?B?TEpQM3pzVkR5em5adWhUck5nM3VZcklNc2Q4L1p0eEM4a2FkVjRJWkxTbmkv?=
 =?utf-8?B?VWY4UDlOTDVMbkpzcVhSbElmMmFBeGtqdDIrRi9KYkhLOGs1R2dMSk1aU3g1?=
 =?utf-8?Q?Km56kpB8+eSC12QnltnrLiYVF2lWN4Dl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96CA99548E4DFC44886F6EEE00B8E452@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6c77e7-6f7e-4c2a-5d3a-08da0b7b1bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 20:41:00.3725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F37J2cDGWUiz2W0N3HsqWUr0AmmU24SebzXCDmbbH0Pe7wKClCsiMnuREbS3LYusTQpptRdYbbMZw8Df/vSi1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_135702_669288_95DBE077 
X-CRM114-Status: GOOD (  14.05  )
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

T24gMy8yMS8yMiAwNDo1NywgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gQW55IGF0dGVtcHQgdG8g
Zmx1c2gga2VybmVsLWdsb2JhbCBXUXMgaGFzIHBvc3NpYmlsaXR5IG9mIGRlYWRsb2NrDQo+IHNv
IHdlIHNob3VsZCBzaW1wbHkgc3RvcCB1c2luZyB0aGVtLCBpbnN0ZWFkIGludHJvZHVjZSBudm1l
dF93cQ0KPiB3aGljaCBpcyB0aGUgZ2VuZXJpYyBudm1ldCB3b3JrcXVldWUgZm9yIHdvcmsgZWxl
bWVudHMgdGhhdA0KPiBkb24ndCBleHBsaWNpdGx5IHJlcXVpcmUgYSBkZWRpY2F0ZWQgd29ya3F1
ZXVlIChieSB0aGUgbWVyZSBmYWN0DQo+IHRoYXQgdGhleSBhcmUgdXNpbmcgdGhlIHN5c3RlbV93
cSkuDQo+IA0KPiBDaGFuZ2VzIHdlcmUgZG9uZSB1c2luZyB0aGUgZm9sbG93aW5nIHJlcGxhY2Vz
Og0KPiBzL3NjaGVkdWxlX3dvcmsoL3F1ZXVlX3dvcmsobnZtZXRfd3EsIC9nDQo+IHMvc2NoZWR1
bGVfZGVsYXllZF93b3JrKC9xdWV1ZV9kZWxheWVkX3dvcmsobnZtZXRfd3EsIC9nDQo+IHMvZmx1
c2hfc2NoZWR1bGVkX3dvcmsoKS9mbHVzaF93b3JrcXVldWUobnZtZXRfd3EpL2cNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQoNCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==

