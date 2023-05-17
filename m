Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558B7C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OahgayZeP5PTayb2j7Z1I3aGF89sU4Oto4LwT+O4B7Q=; b=WmnawoRI1LECIJ5GA5/KWqjSct
	z7s6gQ7SZtVseS+Ah1vRY5SEvxLa3XO55QOSKlly1hnXDev+KY211hzPpR+9ShhvptDsGHkOyRPaS
	n2FgPE5zzT8JysC3C62wnUpkje8nFyfY6lddwXKb4AzDX0xq35xTgLrWBFvJdpnwSQO6Oc+gxRdb9
	B0xq6sQiwoGNVTqwuWEPS/QGEP8KffvhJ2ZC/fSUIKJ1VRJjPC/NPBKmzTxfYI/WsJrJJrqKNgP5F
	4UlRpO+vkMioA53ttSYKfn+sO5sBK3QF5aKpogzU/FUZnuJrAik1tcOiLy5tJf6deUiKbIr/WgYiR
	z9TgxkPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBwR-008ju1-0W;
	Wed, 17 May 2023 07:51:23 +0000
Received: from mail-dm6nam10on20629.outbound.protection.outlook.com ([2a01:111:f400:7e88::629] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBwN-008jsu-1n
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIiYcrcaNJXTd2cFJHComyphiwcN+5EYtDExxn+YUww6TXWUKDqwRZH6VVew6PM6NkfZ1wjPB4eGbK1nzOYFfwGKyq55EKBdpWBDf27GAX/6rQEdJquT2ukSRXq430OrpOM6ghh7UpvNdpWqfCjbEqiGN6E2PV7MK6f/MAgaGsHWGcyDJt2U4362XBigcGf2RMH8mWNJhpxUe05XsnUsUdshLuph/psxUPDs/MVEvSt3CaGvQp3T3/Vsp5SdzZBHHJDdTJcReErCeIpRpNoyNjUG6Y8QnbMerUfxvM4PmFJzN62BNE/MLbC9m+fpiYr1EFUkhb4WASZLlrJyLulcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OahgayZeP5PTayb2j7Z1I3aGF89sU4Oto4LwT+O4B7Q=;
 b=YyX6xIweD7Amr4QohLaKcsYyDJSshsdLrsYON7xVu1dUOvghoeH3x60yniZ4Tq6Ng4Vl1ivcSkhSxaPlwcDwGCwYe6mkxNaFZG1021Noqshy+o5TKh8YMBGOK2FyjG+YRr/2HvdwfIh82qZ4R1m5vAc7poAdo33YXnWFDRYh5AYvF//Svm3lCpq0/I9TU7PIIl3DfUBewFX2pG07UglaEsfWS7EDKuziM5gsDuvRtpBjlMpxzuXrRQE0H0GrIntFtihRTyV/Y/CwiCikWojKvI5N5KdNRhWHgFonFY6anLBWFSrh0F4U2gzXXHkpvCt+swqkQzmStimY8sB4E7IOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OahgayZeP5PTayb2j7Z1I3aGF89sU4Oto4LwT+O4B7Q=;
 b=EQwc+l1r1xvLDpOaZaTim+nF8x2tVTXabJIwk3I5suMu/+wWAGG1Ssu7yhJGmfDnzIYovMNn2R4jbfy9bz6JdOt3piCeJLJ0hettF/mP7XpOgS/WYw0+xoNE79etc4ugBzdzi3NBgF8mCbDnRW9tKV8/bE94i9AKKCzf3Ds2LDjPRYgETHja4phRPnWRxx1BYigOwiz2FMZeJ/3whLPlE++1L5R0lchAMv2EbCJrvL0/JL2SQk8hgC+y1sr3jH+yaVQqURMYuRVEARNiEizgg1A6hQntQMr7C6WIvtITYgbWmVqy5odiyuHnNFC/xx+HwB694RxMNmGDp96PK+ZU6w==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:51:15 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742%3]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 07:51:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: Kmemleak on nvme-6.5
Thread-Topic: Kmemleak on nvme-6.5
Thread-Index: AQHZiIFVFfUBMZMSrEydo+0HkKqpwK9eFsYAgAAA4AA=
Date: Wed, 17 May 2023 07:51:08 +0000
Message-ID: <ef810b97-cd2c-50c6-c3a0-15681b4679be@nvidia.com>
References: <6344f121-f3a8-1a13-1024-c43fac23a9d8@nvidia.com>
 <470d8e75-c2a2-ed21-6cd4-fc06d0b80e97@grimberg.me>
In-Reply-To: <470d8e75-c2a2-ed21-6cd4-fc06d0b80e97@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|CH3PR12MB8970:EE_
x-ms-office365-filtering-correlation-id: 9c5d4c7a-099f-4daf-23aa-08db56ab7ae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  e018dANtJo/vZMAuxGfjaOUiIuPJk50drrteDvQKkdaUw41wJL6gTn+kH8YxuP2KDP5u2u3gq7aqwGPqPrRdYlyFJdHURdDdK+EatTDhspgbpFfCHxePY9fjNMFTtNUlYulNuG/Q069tIjVQDPexkpKxsimic+5QMd1rXoDRJIZLjY/q9eNS5BtZTTZtKqyjKwG8EFAy+8Rr2JIfNxFDrBOdCewedytHcFn+WQPF8N5rDouOguUOsHKZ+ZXpy7ISGWxA3DTSFN0+ieoK3q0J0BOzebJz4g3lqOy008ZyvJjL7HydNAuZnIxjAB/o1pAxHmuwedTCjKOo+sx4mQ8omyRZPijE68jZdqMFXvsU+exw+OV6GGsmFxPmniFx9m+ovvaTnGIQAbj6XLH5yHmctsDPoRMtIqF5zKY3wteJYUmdbogQtYY/u0cuOhYc43zhape8kBsJGbcdZ3msWO4iNm/zaT9FfKsva3eB36cRMJQmAR6g6zvd/urjsLB8cYPadiaFwaav6/L6C8lsL3WxA2nkt305rsFztODDXSz9INS7QuxbYE8uRsN23ojIrC12t3ixr9/VpEDcIj383IINigSRoySqfq99edc0Yo5ezjLh/fciigbS7+0vQjRG1Thk9x0Amm0WMEo/dvj3UwGDv9BqqzPxtsTVHt9lO1WZZM0LU/KDPztyqcAYiH2vCINm
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(6512007)(66446008)(66476007)(91956017)(66556008)(66946007)(64756008)(478600001)(110136005)(76116006)(316002)(71200400001)(6486002)(2906002)(8936002)(8676002)(5660300002)(4744005)(31696002)(122000001)(41300700001)(86362001)(36756003)(38100700002)(38070700005)(2616005)(186003)(6506007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?b2l4K20wRWsvVzVlRlZJMEVzV1lhL2tXVDJEQzhBaFZtbWpDK0lSaTcrcXp0?=
 =?utf-8?B?RFhTeXpOKzB2ZWdUejR0QnE1Z1liUzI5dWQxVDdiYnljSDM1RU9GNzBXMnZ3?=
 =?utf-8?B?WWtBYkJyYzdRU3RnRWhaS2JkYWU0K0JDR3ZtYm5TTXBIclNmN2NVVDdCUDFS?=
 =?utf-8?B?OUxvQURuQzZEWGMxZFRGRTBId1pjNnlqSGVUS0pQcCs3NDZ0bjBvdEZwVXdo?=
 =?utf-8?B?OEF6N0JPeFZ5cThDbXVsUksrMTFvU3liUXZORmJCS2Foays0R0JaOHFiL1Ry?=
 =?utf-8?B?OEpxQThZUEJKYkFVMVNUeUlGNEdIN3pxWkNaT1pKUTNHRUp5MlBPalZweHBk?=
 =?utf-8?B?ZEFqWTVoeGdNUlZVbzZpZzlyN2NiaFczcUpTUWNuRHppbXFCOVVwTWpRUTNR?=
 =?utf-8?B?UklhUWFYRTI0cWNnYzlaYzJVQmVBRGdoT0gzbEIzb3hCR1hwbFFNMkNBY1Ro?=
 =?utf-8?B?RERHSnVMYmtpR0ZCMGZuaFVZZCtaYkhWMVg0Q0RxcUZmY1FmTzV4NEx3T3lv?=
 =?utf-8?B?eVVoclhxY1ZBamlwdmdLUWxCWXNHc0M1ZVFmUndTVWdrUDhMUXI5LzhQSCtF?=
 =?utf-8?B?RXhjSFpxZkxEMTcwVjVlNldOK0tRL2lGQkFQMnR0SE1GRFlIc0NPWFluRi9a?=
 =?utf-8?B?dTZsOHV3Q0pIakJxVmlHSjNsNDRZcXFpNEpsV0lRTW5HdytWbEMxZ0tmUDZr?=
 =?utf-8?B?aWR4UmJ1V1V0dVlkcTZ4RThwekR1ZVJla3pLRFdZOHcyK0NNcEJQY2hvOWh2?=
 =?utf-8?B?UHo5MHBDZVRWNTVadXppdmlwQ3lTeW4rV2xSV2h3YW0vcnMxektEcUpKcFE2?=
 =?utf-8?B?WVRuVytBWEMvT2FWbmJ5S29QbzIyNGY5ZFlydzhETDAvL0xPV25JdjFYU0tR?=
 =?utf-8?B?SnZ2YjNlUWFvZXZ1LzV2UEZyYkNvTVJVTzZmY2lyMEtwRlBHaFMvVThwWC9m?=
 =?utf-8?B?eEhWelpsdlhlQWlLeXlyVDlvZWFqdytPd2syN2Q5MzBPWW1DeEdEVE5SMmdo?=
 =?utf-8?B?R2tzUmhOeVdNQkZQNVcvU3BCU3Y0ZzMwaTJBNmVqdzZKejZsMzNPMUVTZWph?=
 =?utf-8?B?UUxwbU1uMGRLeVA1MExTV05NVjNYRUFOVW5hcTMvT3FwUkNvVWpJalFyUnhO?=
 =?utf-8?B?ZldjcFpZRlhhVTZRU3VQYWljaVV3NkJvN0tBcGJtemM0elREWGVCT2hMRDI1?=
 =?utf-8?B?aU92cGRGbmZzWXdPcWkveVQ4WEhXZkRNWGVFcTRqdTdqY1A2bE83QVJ6ZU5L?=
 =?utf-8?B?dFk1RDNKc3Z6dWQ1VHptbENyZzBPb3J6MHVFazZXNWhlalpkQ1M0aGpYMFNV?=
 =?utf-8?B?T1JrUWM5V0NwVlJQTDdrczlGMnBoazA4M0V0czFwQlpEakl0cWpVM1BvWExR?=
 =?utf-8?B?UHlBb1g5V1Jvc3doWXFCVGcwMnkydmFJcnBLT2RjS3NwME9vTHR4TGEyVDJO?=
 =?utf-8?B?N3BJQkF0TlNid1ZXdEdWOGNhRHVFdXRXSWFOWWhuOHVEU3haTzVDcnZEWndI?=
 =?utf-8?B?dWxlc0h0WXlGY0VoMExtcDM5am1IUmF0VUxYZTIzQmFFWUc4S2JKcUdxT1p3?=
 =?utf-8?B?QWxGM2ZqWWJ3blYrYmhTcnZWR3lXb1VoTHVzRDZpRFdNcEl3dkJFa0tXWEhY?=
 =?utf-8?B?bFRrS1YrTGdlVkEzeTJWK0U3Sktib0tuMFN4TEk1Y3l4czhuQ0ZvaGhzOUEr?=
 =?utf-8?B?dDNvSUZDbjgvWkM4TWNxSU1BaHNtL1ZJYUVYZjlHOEZ1ZkRvektpT0FRWlJ6?=
 =?utf-8?B?VEhDUWxzQ2tkYXlaWlNOZlZjY1F6ZWdKdFFOVTZVWHBQRTlDZHdZUTZWdmU0?=
 =?utf-8?B?NEZNaHhsUTVjRE00SEt1bnhKSG9CUkNOcDZtemwyWDRYNkl0bmpyeFFZcEtF?=
 =?utf-8?B?ZU1ublNtSWl2bG1aWWVLN3JpQ2xLd1FXOXFBUGF0NlcvNDdNL21KU3FPS0FN?=
 =?utf-8?B?bEplRFRpL3o2bnYyTG1yRkZtd09FNkJmbGxYaGNtdXMxNE1kRTVQTVBOVllo?=
 =?utf-8?B?dFJBTnM5NUw1d0dNL3lBWlNmTXdsd0QvNGd2dG1ha1doZVVSb3JhS1kzTG1E?=
 =?utf-8?B?N3dOY1Y4Z1kwUkxEdERmb09hdGI3aTJpOW1EMWwrVTFYVWk0RzNmQ09CR1pv?=
 =?utf-8?B?Z3NLWHdEYkRPTGM0QlhoVXBrSWZMSml5YkpYMzFpZXd0ZGNLSWQ1Qm1zcU9P?=
 =?utf-8?Q?XhC7Z8jW38KJv6nYsALSw2Lx+MN4XI2tCRSo5p1O8Ddq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A31C87D78D2774BB35DEEF64DDA92DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5d4c7a-099f-4daf-23aa-08db56ab7ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 07:51:09.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVkR5UWOZ7W/3Ns6r09lSzcbVTbktdHIz2Z+EAaUTVQ7U3WO9BrQ7IOuGB0JIk+vp+WKV4B9yx++ywaSihKcug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_005119_631192_7DFB2FCA 
X-CRM114-Status: UNSURE (   9.29  )
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

T24gNS8xNy8yMyAwMDo0NywgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4+IEhpLA0KPj4NCj4+
IEkndmUgb2JzZXJ2ZWQgZm9sbG93aW5nIGttZW1sZWFrIG9uIG52bWUtNi41IHdpdGggYmxrdGVz
dHMNCj4+IG52bWUvMDAzIEhFQUQ6LQ0KPj4NCj4+IG52bWUgKG52bWUtNi41KSAjIGdpdCBsb2cN
Cj4+IGNvbW1pdCA4NTFjMjNiZTZmYzk1YTQ4ZGJkYWM4NjRmMThiZTYzZjlhNDFlOGE4IChIRUFE
IC0+IG52bWUtNi41LA0KPj4gb3JpZ2luL252bWUtNi41KQ0KPj4gQXV0aG9yOiBNYXggR3VydG92
b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPg0KPj4gRGF0ZTrCoMKgIFR1ZSBBcHIgMjUgMDA6MTI6
NDIgMjAyMyArMDMwMA0KPj4NCj4+IMKgIMKgwqDCoCBudm1lOiBtb3ZlIHN5c2ZzIGNvZGUgdG8g
YSBkZWRpY2F0ZWQgc3lzZnMuYyBmaWxlDQo+DQo+IEknbSBhc3N1bWluZyB0aGlzIGlzIG5vdCB0
aGUgcmVzdWx0IG9mIGEgYmlzZWN0IGNvcnJlY3Q/DQoNCm5vIGl0J3MgY3VycmVudCBoZWFkIG9u
IHdoaWNoIEkgcmFuIGJsa3Rlc3RzIC4uDQoNCi1jaw0KDQoNCg==

