Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6734C001DF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Aug 2023 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c97mzRDDU5v1CHqJZhISHvSrPyMIvGWpe/F8XQ68y8g=; b=BtMKpuyZzOxl87QoyWUL8fW24y
	fFCci2DrP3pTdjPlL2Xt/RuxibkVAQ6HE05TDTnp+zZJGyPKaFSFpTIn2c4+2iQxMNowXqyzKDI/w
	WedbggzeRiNwF5XSsHTDqvPCsSRNg9TAnYJieSLQT8fSQKTk0Bsu1VwsYeTBbQJA15wHrF3WxDGhy
	mBNxMDeTDAA3+RGTDQSAjVH4W426oqRBsyTIHRKKFqB0mn82+YnNGfSxCx1l9V9d9UNAf8UtdvCam
	9facmeYx1VQk0z3K4AqxeCCyDS553/7DoOUbiUOA5o3Y/cWLV7/EyajvdzFS2H0sPVOth7fAScM85
	TsbtfIlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRFR6-005TV6-2t;
	Wed, 02 Aug 2023 17:15:00 +0000
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com ([2a01:111:f400:fe5b::62c] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRFR4-005TUa-1e
	for linux-nvme@lists.infradead.org;
	Wed, 02 Aug 2023 17:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhgwHDpOXTw7/XilFEhY2EdLRHIt6BEjjdPJzPReQLiJEtZtAVJvbJryPuXiDlhhtUwwvBvolIq3j1baGT0Z11zpLM8k4P5Rx01vcxFaFRkiEvnx7df67/25PZoASHCYXGuLnQfMAxEf6aZZuI9g7DNx9f6J55I2+0EF2ZRLbk/Wdab4kcSEpnY8WnmmaxQ7D4ZVBOwRw5HRmq9E/dTzMUuq1W07W7QJbMYzXsGL92Lqr7691QNXN48y0yMX+XU17qEd5/BL1PoWtPgV1xR5xuBJQwoXghtn8SybHMFOJIc8gMkZZ91iPHSQA90LqvXcT1xccOQP23KWVP/GfMcqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c97mzRDDU5v1CHqJZhISHvSrPyMIvGWpe/F8XQ68y8g=;
 b=Iz51c4p8liXW5GU1CGlyaF5n1MFrvhgn1vSrH7248mTLfoJaqVBPYNwOPopY++yQ9e3HHZRKZYg6BDvFXmy4w1E3ZHo6bEA9sO4kVsiUcWTEGv/IRoIfB0fWSQQUkbV+/OEPpcjoCD/RSLTfXZiXBcv7NuvfkWmABlstzZKdML6jYx2j10UyGcqBby30ovKkF5ytc7CftuFS54cBwjvB1Dff25V425zKUXF0gLM3LnFDGi6h3R2kmZ5QH4JhTadiGjJsHPVoScnalmgNqAjjCFinsOjZdQdipE2mdJ/abBwLvBpYJ7Phtv2JYCm4lgRCv0CUHbzAOKH2PazbpX6NJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c97mzRDDU5v1CHqJZhISHvSrPyMIvGWpe/F8XQ68y8g=;
 b=DAQhAMXwhAwhzzdvRs06ux59mKg/MMrOlAs294UueRNjDeJ7CpGTOgDbAJgiuYkByBakEA6acFLyxoQLMk2vgH7EQtVIrDLi5Bo7MRTbjfyYAxoZ+vUrZqx9gFJmFO8mSGSkX+N6D/HO+A60mEysqv7EoNBm03DWtQDdACyypi/V20RY5YYdAcmdOyiCxeHw35oELfB/Ej9kp4L4lCq7iqFsAy/vVtcXzYiI1L/bq3PIZvUTANi8DBb91cO1CsAaCMlkeC0ZKm2URvGnf2Xo+Q92YqNmipU5FfyiboVGfr7a41dsGZnpRp5+hPlt6WVoxYgVaivQZKk+bhj9a/ANag==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 2 Aug
 2023 17:14:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:14:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "alan.adamson@oracle.com" <alan.adamson@oracle.com>
Subject: Re: [PATCH V6 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V6 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHZqieHAYqWD4bf206hYtM/h/I3Vq/XHfcAgABXZIA=
Date: Wed, 2 Aug 2023 17:14:45 +0000
Message-ID: <c9ba336c-786d-079c-b0cf-f49a48064929@nvidia.com>
References: <20230629011713.28554-1-kch@nvidia.com>
 <20230629011713.28554-2-kch@nvidia.com> <20230802120158.GA30301@lst.de>
In-Reply-To: <20230802120158.GA30301@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4191:EE_
x-ms-office365-filtering-correlation-id: b96fa382-f352-4737-ca9f-08db937bf847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2eJCGc74kT1gPi32ECMmS1pEdH3NEhhvB9JmHKVeakfWtz12RjWCCM5zlvoMxlNrhThHO8QtfpMkJy3GBC8KN26sziwk4pPSNLBZ/q7CkP66DEwB8wQurAPWinEgWarZB9y+3HTHult83CFlJ9LXLrBUbxGwAlpTUt8UsqqSFfDjMj7fGvbyqyNgIXBOUKspMQpNFTY3h4wEyUDHQTW5xRadLYkL8I31ROxgEk0htV6WXUwsKSb0Fx6elBpgTeEP3LEz8np6fOGmWSrofxe77XYnwVGhh46G5GGOifY3bZQFTLMSl0SPhrP1TAeAYD9rmuuJwnV4DmZy+tdjEe4i87B/2mENWsO2uUqc79QIEDSYhCSfFFfgtu0WCJuXQQJl4F5Rv1aYs5UYlr2ZGuwgfqtFD532pJ+CXiUVkErVpPyfhr2qQ394RIwud4Se8AefkSadzME5R0wvlWYiNcIuS0cWlNEEIXscy0YwR4n5jey15EoVF7S5QAeyRndNaN1QBz8wRSYc8Od0XS6eZNEBJw1dbd+hW0FzWPLDr3GfxcDitv9LIaspFP4ZqrdDJYL5nJIVjwo3C2FG9kzmRUF8lQ9sOiFm42wbyucG31WN869+IYR+pI8+yCFucQnwHi6cRMuWCIaeQkjhLcnOu6Ikt5djC9c9N1NWYW3T4t176ulRg1jMy5PASM8YTjcxdty
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(6486002)(83380400001)(478600001)(53546011)(6506007)(26005)(6512007)(76116006)(66476007)(54906003)(91956017)(38100700002)(66446008)(64756008)(66556008)(122000001)(4326008)(110136005)(186003)(2616005)(71200400001)(66946007)(31686004)(8676002)(316002)(31696002)(8936002)(2906002)(41300700001)(86362001)(5660300002)(36756003)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFlXbDZvMHVhYnJqbEhnK3pFcjB6ZWlzYWQzVmFSNW9PdVhVSkx6TTNmNmpK?=
 =?utf-8?B?WTlQMjc4SWJReExId29qQVhka0Z3OVJIWndJdmJjbzRMbkRxb3NmWFRINkZw?=
 =?utf-8?B?bWo1eEF0RVVwWDcwYW4wZlQ4enpaaFVBZTY1TGdxQ2hVaEtORmdPZGo1U3JV?=
 =?utf-8?B?Q0xMVGptdlJ2a0x5VUFEd3kxc1h3MkhCdGxOVlk1YnU3eVJjKzJKRnM0SEtN?=
 =?utf-8?B?aGQ1REc5aENQSmovbVRpWERzVlhrd01UcVAyZWlsNk5GRkFmbUM3emY0cEhH?=
 =?utf-8?B?bXhmaTNkSXBCRDIweXFQOEwwR21TQjRHQTBCRGd3aldXUWc0T3pWNnE0YnBj?=
 =?utf-8?B?OGR3aEM4bmpNME9mU2VXVVYrdEJkblNmNEVJekt1dnNRaVQ4TjVsQit2YWJx?=
 =?utf-8?B?cXJMTnI4dVVWYWdtRFBZRWJUS0gzcUloeDBOd2t2aEQxVkhKWEV2SUNFU1J0?=
 =?utf-8?B?RnlOS0d0b24zZEI3TnNuSXNUZXZDZFZrb25xZTl4b21KMFhZcmFlblFSOG9t?=
 =?utf-8?B?c2NQZmRueE9LWlcvUEpLS00xbE5ETFBNZU1ya1VqSWd0WklJQ1VjankrbzRv?=
 =?utf-8?B?VnNaTVFGdWRIU2hUdEl2WlR4dXRPZnJBV3BKWXJOSEJXMzlxTkF6TWwzOTEx?=
 =?utf-8?B?dlBsRXY3ZGVQUkR6VTZEYis0ZEhkS2pYZ3pLREhnK1lHei9RSDVGSUpHU1I2?=
 =?utf-8?B?dW5LamxMWFJKck5ieUJrOWtqdmJZZUR2Z2xTVzJvOHVwSzZFQ3pWMnAycXNW?=
 =?utf-8?B?RFQ3RjJ1UFIxaWR4OUJOdUt3dWhRMTMzOFo5djFpTUdRdEJxeUhabUFBakZr?=
 =?utf-8?B?dzVYNURIUCs1emxoTVd1TWdsMGRFZnQ1QjNoS0FCbms3dU5yVzlaNkVaeGFm?=
 =?utf-8?B?ZTJ3YXRpTmpLc2F5eHdSY0dsTksrSUVLS1NTR2MvOTU2YjJEcCtRZzRDcmxV?=
 =?utf-8?B?V05tck9UMmkxZ2JnMmxYUHVTd0hWTXd5Sk9ia2lnYitGUDA4Z0Z1MWRKbElE?=
 =?utf-8?B?NHlLcDVhMTVVbFdWWTM5a2dsUEtTalZEV1M0OWprdk5LaVJjUStJcmsvSE1q?=
 =?utf-8?B?UnZDZ1NUQ2JjRHg3NzNacEpKU1NLUlZ1ekY3emkvc2l3dHlmUmQxUEhaMTJn?=
 =?utf-8?B?OFZEV3NnT01aK2pZUC9sV2tlQU9keXkyZnZWQXdFVGZnM3pXZnJTWWtxZnQ0?=
 =?utf-8?B?YkpkajE4d0hxSTc1L25oSGUwOG1sUmtCV1dwaW5jZVZtd3UzTU53aFNJNWU5?=
 =?utf-8?B?NjR3emoxdzVHN3NNMHB1Q3JmMUNxRXFnTUpSY3lEYnFMWVcwa0FXTmw3YnhY?=
 =?utf-8?B?QXhxakFtVFByM2ZFelIwcEh1OWxFVjA4cmNxTkx5dElGTmU0R3gza3F5b3d4?=
 =?utf-8?B?U2hQUTRaM29SUzVRU2dHMjdhb3ZuWEVza1Fvd2pub0JQcU9CZXVML0p1VUkv?=
 =?utf-8?B?aGp1bitsSlJvTWZUN21NZmFHbEJORnBBTDM4UHpCWVdBRFdRRkdUeFdUclVS?=
 =?utf-8?B?MXVwQjlpTlJtTmxadGtJdDlITkhVekQ4b3V1QlYvMGdZVFcxTWpwSWRoRFBP?=
 =?utf-8?B?Nko0MzJ0OGIrQ1NCVE9oVUk1T1lKMVJGQkNiKzNkQnNxblZmalI0Z0s4aVRI?=
 =?utf-8?B?RkNlYmthekpYTisyQW9xaVg2dEFrbDJxYXpiWVB3WkRjNVZiYmxsWUhNdkNx?=
 =?utf-8?B?MWVOQnNxRXVOU3FVeHVFdXlvYjVicFVRRXlYYktxamNpTVN1Ti9aSUlGVlR3?=
 =?utf-8?B?WXB1UHArcUFRQ0dtWUxHNVZTeG1sREdFNnkxdlBINmJ4T3NVaStUdlgyUFh4?=
 =?utf-8?B?WnpBZUVkL0JVRnVhWkp0VXBzVlBya1FXVGp3OVhKRFp3bGtaZDk5WWFsZWov?=
 =?utf-8?B?cm5aZGRGUHBzT3pRdmtZbDkzYTRHWVY0WVNXVWc0eVAxTTZZQXNMdThtS0I4?=
 =?utf-8?B?LzBwcXAvR1kzUGpNVGY2M29RR0tRcW05WFdqTDF0T1JaK1NhZ29FTzF2WG9O?=
 =?utf-8?B?MUFlRUNnWS9zL0Y1YnEyeHRpOG5FTGVseXNSNkdjMklmQWpRL2taVjVMVFlz?=
 =?utf-8?B?dXliNmlYZVIxajNUTyt4N0pPUzFtVmZIMWRCOXgyK2taUXpMb044YkZibldV?=
 =?utf-8?Q?UlzELJ/BFS2/7bgiglspYhUgB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AA8FFE1312A234EB68510D5FD9766FE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96fa382-f352-4737-ca9f-08db937bf847
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 17:14:45.8205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84DmEdn9QKA8OAmoeKCS3HclcUppVpxX0O/AEvNMNUU66LE13MoaLOeaxZmWwfCr7SSJ6m6C+I0A77LoGBIFxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_101458_551737_D4D2405E 
X-CRM114-Status: GOOD (  13.60  )
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

T24gOC8yLzIwMjMgNTowMSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiArDQo+PiAr
CWlmIChjdHJsLT5wYXNzdGhydV9sb2dfZXJyKQ0KPj4gKwkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVm
LCAib25cbiIpOw0KPj4gKw0KPj4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICJvZmZcbiIpOw0K
PiANCj4gCXJldHVybiAgc3lzZnNfZW1pdChidWYsIGN0cmwtPnBhc3N0aHJ1X2xvZ19lcnIgPyAi
b24iIDogIm9mZiIpOw0KDQpva2F5Li4NCg0KPiANCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHNz
aXplX3QgbnZtZV9wYXNzdGhydV9lcnJfbG9nX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+
ICsJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVf
dCBjb3VudCkNCj4+ICt7DQo+PiArCXN0cnVjdCBudm1lX2N0cmwgKmN0cmwgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4+ICsJaW50IHBhc3N0aHJ1X2VuYWJsZSwgZXJyOw0KPj4gKw0KPj4gKwll
cnIgPSBrc3RydG9pbnQoYnVmLCAxMCwgJnBhc3N0aHJ1X2VuYWJsZSk7DQo+PiArCWlmIChlcnIp
DQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsJc3dpdGNoIChwYXNzdGhydV9lbmFi
bGUpIHsNCj4+ICsJY2FzZSB0cnVlOg0KPj4gKwljYXNlIGZhbHNlOg0KPj4gKwkJY3RybC0+cGFz
c3RocnVfbG9nX2VyciA9IHBhc3N0aHJ1X2VuYWJsZTsNCj4+ICsJCWJyZWFrOw0KPj4gKwlkZWZh
dWx0Og0KPj4gKwkJcHJfZXJyKCJpbnZsaWQgdmFsdWUgJWQgZm9yIGFkbWluIGVycm9yIGxvZ2dp
bmcgW29uOjEgb2ZmOjBdXG4iLA0KPj4gKwkJCXBhc3N0aHJ1X2VuYWJsZSk7DQo+PiArCQlicmVh
azsNCj4+ICsJfQ0KPj4gKwlyZXR1cm4gY291bnQ7DQo+IA0KPiBUaGlzIHNob3VsZCB1c2Uga3N0
cnRvYm9vbC4NCg0KaW5kZWVkLCBmb3JnZXQgdG8gY2hhbmdlIGl0IHRvIGJvb2wgd2lsbCBhZGQg
dG8gbmV4dCB2ZXJzaW9uIC4uDQoNCj4gDQo+IEFsc28gSSB0aGlrIHRoZSBmbGFnIGZlZWxzIGEg
Yml0IHRvbyBzcGFyc2UuICBXaHkgbm90DQo+IHNvbWV0aGluZyBsaWtlIHBhc3N0aHJ1X2Vycl9s
b2dfZW5hYmxlZCB0aGF0IGV4cGxhaW5zIHdoYXQgaXQgZG9lcz8NCg0Kc3VyZSwgSSdsbCBzZW5k
IFY3IHdpdGggYWJvdmUgY2hhbmdlcyAuLg0KDQotY2sNCg0KDQo=

