Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9C1C07545
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 05:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pg2AaHr/4j6Xf0+6qbyhCmQdb5fDdAQofvZ41MQKVPM=; b=WtbIyENWon32O5E6Exq14ovfQ+
	saXBS2UjgiVLHw1QOZ9d962k9W32tu7W+kZe5uxZ9WepS46fllN/mH859cG3R9SaPhaJ4bQYTDQds
	5Gh4DaJVl9Mn5MDjwUN7fVMTTsca1KDuFefJQq7M/iN8d1v9RRctajvAAvd6bJU6MH4yJa+AHV1MX
	jgjtukNXJKaS9/Y/iMKocU8yZ7ierPtzGo9KAzmjN2yCuCLi+f0wqo+/PWnwo9Dqe4k61vreeDCao
	1jEBHKgVBgFz2DM09PWo99LmpK0Ypg3MVTft2uR4zvsVImJ85opqqNGmIeMmE23F/i+Qa7TeukXp8
	Br01T2Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAOt-008voS-0M;
	Tue, 24 Oct 2023 05:56:23 +0000
Received: from mail-dm6nam11on2061f.outbound.protection.outlook.com ([2a01:111:f400:7eaa::61f] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAOq-008vnx-29
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 05:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn5BYV9wBuLZbRDmXJzUIU++0Rs6EUEvXiRbBQkroP5NZb4zFT1VuYvlRWSvidX/4EBfu2KozTYEyjYAM7Jcr8a8o4+7ZUksr9kHlLJQmlW6vheQ6p17RPtKScuGvnOBc9IoLoZmXn9govs07EIdq+X9MPfBSoUter0alD/gboMaK3t4ExBKiXcIONNUIJ4OcH01z5PVjAnJlIa5+5w6Vs31Y0PkfNe60tgKECY4JSCsLsBlhZ+iYBnRohse/n+gZfhXSHDr3kpcuFxO3Da/gG8/jiBzsAQJK1hWqk4bjWUUy1Iihz836QeCysk5wgxLxJSNMkAKm1GvbusfAmlOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg2AaHr/4j6Xf0+6qbyhCmQdb5fDdAQofvZ41MQKVPM=;
 b=elruvgAith4PZa3JXFGIEjzMBxL1QQwR2tYJ0cmFI36QKvAHv5eMg/soOosTMjapGMsd0meTOKP9iluzk7mXnO9d99EXRoBjfeTaA1tnTviLgnQ//xIERasH/h88udxXskDSz9nF3tzhfHR/j+JMcmfStlUzrJdBCDCE6epCxy9JVaQHETb4opjKp7t0kK3dAWWrtOX6FS3JZmA3kAduxOSdBqflcIObLozskwqpnFJ8CWqYmiJbe6morxzeNuBbjdAU6vq8skjZl5s/ytJaL0ueiqw17IbR4n4lH+5JaouB5peWQ3dMtC/0JAxrGqvErvGfAkjExqevjD6uZ3djhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg2AaHr/4j6Xf0+6qbyhCmQdb5fDdAQofvZ41MQKVPM=;
 b=GmnJGartiBPymxF8iQL2D+uJwSBxkLH408Q7POVNSEt9GBIxDGFzJ597K10esg1VuZjiy1sxdgiAh3OGqHrT2RSfj1LtXiqOf+MCtl/Te6+PzLU8uC23mtoczX8eeTZ+hLxZBJy6dzs/hORnu5CfHWBeT5p3hq7GMFaUYh9RPqe4n4Jf8zyZfXIouwDh+ckZ4/EJQB71M4BXBEBReWGuwO5hobdiOyHV8KoYxXz4wI5QqZn21FeJ8nJQE7kmD1x4xG9+dssUZzH1lAwOGR/u6EqElFzKcUV5fMPKwhWQQrnsbybl5oEikcEwd/5nhbfM0SzfjA0/Sdc3p2kj51mdIw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 05:56:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::af95:93e7:d27a:15ee]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::af95:93e7:d27a:15ee%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 05:56:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-keyring: add MODULE_LICENSE()
Thread-Topic: [PATCH] nvme-keyring: add MODULE_LICENSE()
Thread-Index: AQHaBgTmQ/HOvgPSLkS8SfYeToBQz7BYcZGA
Date: Tue, 24 Oct 2023 05:56:18 +0000
Message-ID: <ba998f19-866e-4184-b62d-37a3319e26d2@nvidia.com>
References: <20231023230052.31161-1-rdunlap@infradead.org>
In-Reply-To: <20231023230052.31161-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB8049:EE_
x-ms-office365-filtering-correlation-id: 96bd4485-161e-445a-687b-08dbd455f0ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOxvBzFbSB2X9X0ETrc1HgbO8RHpasUvPmcxX7uuUI3lN9FMTsBjLMSKLEBakKbr7IIHuE9aujifdP9HY8BbZRT+znPHnHPCI011GV6vb06yQSwwMp9sojWOsoD9Yp2T2Or/oTskd25Y8eUL5SCZlf6peAgQqQ/8q9HDP8KXzDS8EBU3mQwmBRv4X2HMslkXVDv22HSgoIU1+UHQs1txBoPC+8bLWhTFq2aXf9G9W1J7/QQLkrNKaR0+3/+CJj2GbZWCv9AY+U7sXy6VXuz4/Bka9S5kslAdkqeCXKkzY9zllDZiXhgO49xdd41LCle4G0OhVHxbbb6Izc2P5WUmo+lQFThIpAAJh2uq/J8SnePw7cxVUYKUF1mKlMk7Ek546UfHnUMwEwx3pPPs/C2JlhZzNdTY33IcUSUJv68Y3k797++T5hKqGWRBdkGQJKDwp9lck3cvfBQt+Adj+1Xwp8bEMPFHEdwGajMUhkdIPOq7Up3IZbLhkKZm3A0QEnsoBjQw487lI4rsg2zLryE2PyrRjZJwv187tj3Fk0+Ev/Egli7W8mRqw01GrcjekuhyCJJUSRh35YMrwIu0FO1eXVgtkPBaeYpgtNK7nlwMlKN+U4cuFe814t8S8RHtUdTKE5rhgbC+O8TS64v3+fjHclypE1bKm+NHvryRnEskxlf/yvF1TI7sLuuIrCmgBf6R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(38070700009)(31686004)(38100700002)(2906002)(4744005)(41300700001)(86362001)(5660300002)(31696002)(36756003)(8676002)(8936002)(478600001)(2616005)(6916009)(66556008)(6506007)(71200400001)(91956017)(316002)(64756008)(122000001)(76116006)(66446008)(66476007)(66946007)(6486002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkZoQWFyRFZPYS9PZVBhdk5rRmM0Ukx5UWtwamo5MXFDUWFlMFIwbEJCN2tQ?=
 =?utf-8?B?TlhVdnhTbStsUTZ2M0tkQjQ1NElad3RZN3k2dEgxNHgwaHowaWtZVnRHek9z?=
 =?utf-8?B?OVJNQ0dSSW50RldINm9QNjdyRW5JUUV2b1FlQWd2VEhQekszQ2ZBUms3dW42?=
 =?utf-8?B?amFPODc4eVNyejdTdHREcWhYM2VCeGNyN0J3NklNYVEzTDgrWGUrS3E2M3VJ?=
 =?utf-8?B?V1FMaG1LUTZnT3Y0aERsNUN3RXB1MDk1VXJnQW42aUhzcnhOV0o3bXlyeGpo?=
 =?utf-8?B?M1g2bUhzOWpTTk5yU3R4K1ZJTWxFZ08xaXBneGJlMFVxeDJ0NkREVE9CM0Vl?=
 =?utf-8?B?Zno5V1d2eWFHSGtBamcyY0kyTFcycWlPaUQvN2ZtMk5ZUEsvdHZZcjI2NTFo?=
 =?utf-8?B?MGUrNy95K21jYUpzRTdJNHlmcjcwZ292bUxiSk1mcENPMklMZTVEa1c2bHZI?=
 =?utf-8?B?OVlkOUtPalNLcFZ5NFVYNFBmWWx2clM3cm1Fby82aHI5YWcrY05Md2JQZ05D?=
 =?utf-8?B?R1pZTXdZOFhFcFVMMitMZEJYTk5FbFJnbHluQlpWbk5pRXcwaW1pbjVoeWxC?=
 =?utf-8?B?RlNNTDY2ckZlUFZMclVMRGxkYzlOTzhVRlZRbnRyZWkxMEdFaWRqbUpNY2RT?=
 =?utf-8?B?R3pDaVdwRWRGSllJVDN6NkJ2TnFDL21GeGhhU2U4V1ZYR29TVVZKMU5vNTVE?=
 =?utf-8?B?WGZhTmJ5M2dSN2IxbmdUNGNMZ0V6cFZLVEFZZElMZFByejdWbVEvSUVsRXhk?=
 =?utf-8?B?Q2F4NEZqZHZjUDBleTdNblZsYjVPamI4dFo3NnZKZlpsM1RQU1BESDcyZ2RP?=
 =?utf-8?B?U3JlbUsyLzRUbGE5TVJMQWRiTDRod08yaXBLckxYczFaVUxDWEZFR2dHSWJr?=
 =?utf-8?B?UEcyaDJJZXMvd25ZRzZqVTl6V2ZPMnlYcUlKbmZtU1dyUEwrL0N1eTE5eDJu?=
 =?utf-8?B?UTJhVFZIaVhTNEZ6RUEzbTM0THdkWW9HRGx3WU9PZmNDMWZrZXVtRFNTbmFt?=
 =?utf-8?B?OFg3cmV5aGxsMUhZZXNMK1dXbElVVUw5N2ZmMEF4VERydExHdGNBVktsRjUw?=
 =?utf-8?B?Y0lUZzdlenhsMGN6c3V5UTFVNStnUmpHVFE1MmdLVTlQYXlCOVZ5Sk9JUUtE?=
 =?utf-8?B?YWFYMytoY2hHZWtGTkVTdlIvK2czNXN3QllVVlNHWTc0dU14ZHVkQlRQeXN6?=
 =?utf-8?B?Y0hwK2lGeU1RMFgvL2VaRUxtN1lqOE94WkRSRGM4T3I1VEZneGQ2WVlvSE5s?=
 =?utf-8?B?cmRHeUtZMlMveTJSTldIOHdiaklnbktYZ2FEeTl6TXZ1SUZKSmY3ZmpPNVVN?=
 =?utf-8?B?a3dmNG94VEpYMzYzRmE1K014UXVwNE51Y1BoQTJaTjBKOCtETjZYdmZSOEJq?=
 =?utf-8?B?dGVUSU4vQlhBWmgwaFdRd1hyUWNuMlJ6SXdzeDM5RGpQZUFrT2d2aDl3RDN2?=
 =?utf-8?B?T0k3ZDE5UFVVa2p5bWdDUFNqNjRWcXIvWXgrb0hUandCTmdTbys2ajJkSEx6?=
 =?utf-8?B?Zm1jaHpGcDNFZncvZE1UdjY4WGFHTWl5cFhncXlwUTJ0NjJTWGZCWTJTUHdX?=
 =?utf-8?B?NkdEYitUSHAwd0dMcXNRN0lVSjN1WXN2VGxNenRvUmJOQ2xyQzN3VGRYOG45?=
 =?utf-8?B?VXptOGszRXpjMVY2c2lTbUY4YlpVQUJFYWJmK21MMktuKzVMems2WmgyNXFF?=
 =?utf-8?B?WWF1Y3BsLzNIUWtLNHRGeG41WVdaK0hPTjlBWmgwOTZIeWJQaWVnbitQYytK?=
 =?utf-8?B?S1hSVWRtazBaRk9VczQybDFlMXlyVXowSGZWdGErTG1wcE5lVFoyUnVDK3g2?=
 =?utf-8?B?K3BKMkJxVnd5NHhldFhjdDhBL2FSdDZMRGtuSjBLOXFEMG9HL2FYOGZVeDBy?=
 =?utf-8?B?djRqVnlNTjhvbndYdzZkeGY0QzlJM2VQck4wbFQyS3JSSzhQWHR4ZEYvc25G?=
 =?utf-8?B?QVY0Q0VQTEQ0ZEkxRVR3eUpQclYwSHQ4dVQ5Ukk5VlpvNTdpc0lkTHVpMWE2?=
 =?utf-8?B?enN2dHhPOWd5OW9nejFmYWN6d1VsTWlXcGF2cFVHbjZmc3ZvYmI0RDdpRS9i?=
 =?utf-8?B?dUovcVQrVm9jMUNUOFdBWHVOTzVxaW14QUYwd2xjRmlsZHRrQU5OYlBabUsw?=
 =?utf-8?Q?eN7iLlkyfi/EhhtXs4bkjphhZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A9C39ED0B1E3846A0E0EE58E4E6C56A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bd4485-161e-445a-687b-08dbd455f0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 05:56:18.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4a+InIeyZPEQ+b6EwAwNucRNUKi+OL47mmM0GX5+X5dnqQsf9lH0KIS1ldn3705Urf+fai6AmkDUK1yMzq2IXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_225620_711380_DA0150FB 
X-CRM114-Status: GOOD (  16.47  )
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

T24gMTAvMjMvMjMgMTY6MDAsIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gV2hlbiBOVk1FX0tFWVJJ
Tkc9eSAoTlZNRV9BVVRIIGlzIG5vdCBzZXQpLCB0aGVyZSBpcyBhIG1vZHBvc3QgYnVpbGQNCj4g
ZXJyb3I6DQo+DQo+IEVSUk9SOiBtb2Rwb3N0OiBtaXNzaW5nIE1PRFVMRV9MSUNFTlNFKCkgaW4g
ZHJpdmVycy9udm1lL2NvbW1vbi9udm1lLWNvbW1vbi5vDQo+DQo+IHNvIGFkZCBhIE1PRFVMRV9M
SUNFTlNFKCkgdG8ga2V5cmluZy5jIChjb3BpZWQgZnJvbSBhdXRoLmMpLg0KPg0KPiBGaXhlczog
OWQ3N2ViNTI3Nzg0ICgibnZtZS1rZXlyaW5nOiByZWdpc3RlciAnLm52bWUnIGtleXJpbmciKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4g
Q2M6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gQ2M6IEplbnMgQXhib2UgPGF4
Ym9lQGZiLmNvbT4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBDYzog
U2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gQ2M6IEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPg0KPiBDYzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IC0t
LQ0KPiAgIGRyaXZlcnMvbnZtZS9jb21tb24va2V5cmluZy5jIHwgICAgMiArKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLSBhL2RyaXZlcnMvbnZtZS9j
b21tb24va2V5cmluZy5jIGIvZHJpdmVycy9udm1lL2NvbW1vbi9rZXlyaW5nLmMNCj4gLS0tIGEv
ZHJpdmVycy9udm1lL2NvbW1vbi9rZXlyaW5nLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2NvbW1v
bi9rZXlyaW5nLmMNCj4gQEAgLTE4MCwzICsxODAsNSBAQCB2b2lkIG52bWVfa2V5cmluZ19leGl0
KHZvaWQpDQo+ICAgCWtleV9wdXQobnZtZV9rZXlyaW5nKTsNCj4gICB9DQo+ICAgRVhQT1JUX1NZ
TUJPTF9HUEwobnZtZV9rZXlyaW5nX2V4aXQpOw0KPiArDQo+ICtNT0RVTEVfTElDRU5TRSgiR1BM
IHYyIik7DQo+DQoNCmRvIHdlIGFsc28gbmVlZCB0byBhZGQgYXV0aG9yID8NCg0KLWNrDQoNCg0K

