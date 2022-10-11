Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B029C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 19:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7i9F0lRlst5DWI4IczH31iskJ6a8Q0SlITlpTPpSjQ=; b=ZQ3NwOoG2x+Kh4lRUGGqYtiB25
	G1Nrn6X/3gJK4C9QIlAJwt+SrxJx90FbZFs+3toP5WO64bpdbMdXVobuLzce/QqOMW2qSKVjSoPzW
	bS8eZhBMyOexNrGdGlCZvk+89B01NayHoC9GVezdzEaaqxETLBFmWFS3S71ztl2bjTePzMROMzEWu
	Xxrj0fnpdYoRXBU1YmQYQAH2GJE8cfJAaKr2+PCg+wYbu5Aqn9cUR4NzAeo0Lj12/qVULdbmv/vb8
	FkWBAsByhucYts7EFZ+/dBGcGYNzAZp7Nhf8nVssMIaFaa38uEm7ekH/+lNXixICwXn89J3DHU8Nf
	WJEXh2uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiKxz-005dVm-HR; Tue, 11 Oct 2022 19:31:03 +0000
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiKxw-005dV9-RE
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 19:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqqMcPDxSzUTagVBgreh6v4QcFioOREm+jTiM5UWkQQTyqSGWSKV7uON8DdYfbpFs0FN7y5v9RL6u7QIuxOORaIgQ9ASwv19aVSEs3VpzW/MLv1I5yXH7HuGx8j3jFz1+txoOkbEpZqIenH1sy8797QPplY0jMGfvV9nBLMa63tCWxnzEKWhcZI/L6ZMLJfYwMv4vzEXoipPHbxvSds6F9AXD3kT3oNy/2NQVyYB4L5S3Vb6QSK0jA+Pn9BR4gtJ6tenaT3WUgmiEWvFQki8LA3UCfkNaHuRAQp2jqq/T3Kxcu2IOm5N5m8QdZkjq94AhKYHjHYkKkqjb/z1ipYLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7i9F0lRlst5DWI4IczH31iskJ6a8Q0SlITlpTPpSjQ=;
 b=OZ7NtsHpNG090nT6VKhK8+IRpkhEKATp9UPYjOfaZJMbDItfQIaYYGOzRjpIOZrcihoIOeq+0bJc1MTkPrukbOuEYi23H4lYUrK8b4PfxzZFxwD2YvoSw2PIkAIHT28k1+w0ZtyifZO/FyZ7jaNhLBS5qEhJr/+ZXqdwH2BmTb+mgQ1oDyBbcsB1NVxT481/w1kZnmmbfyR0W3r924j7Vi93+T8kVxIdy4VRhgxhdcfoZ2VoQLOssMU26nLo7aDi2t6/RgkMq7aX/7NX0swxsC4Q6rOHcxvqvbWnboCVllk1tPQ/dra2VXcujYiP5Jy7n1/T/Z/q7hgVXyWebReWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7i9F0lRlst5DWI4IczH31iskJ6a8Q0SlITlpTPpSjQ=;
 b=RwhwFdJwruOVLm6us7RN+HT+cfUqBYgQJYq/IDWqNlzF2TSWnsIkZdA7c+ot6frua3JIAzLRghdD97vp7yHOm5Hj5ssVjnG4knkdpBiyhHLwvqf+xj+9JYQ4WQ4nLj5AZz4tKmbCM8bhpeqZQGVWqqHewbKJqu4H5CdCmMzjRosFKQbMqLe//mhaZ46Q/6pQyBnn1jVvvYZGojPXyFk0GBCH7SddLtBixRkj8vqqjTwZBAh5cdL/hS0OtUAW8vPSTV6lkhJuvn6wYScv4AQOp7DYH5zWlwdSGB515nAW65ZynM8kG442D7b6xfVt22kKnnw0wOCncx7JQ4jKAFD83w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Tue, 11 Oct
 2022 19:30:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 19:30:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Seth Forshee <sforshee@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-tcp request timeouts
Thread-Topic: nvme-tcp request timeouts
Thread-Index: AQHY3YaTY9yuAD8lP0yF3XXSJfjJZ64JlOoA
Date: Tue, 11 Oct 2022 19:30:56 +0000
Message-ID: <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
In-Reply-To: <Y0WMXSv8REysoqFy@do-x1extreme>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6141:EE_
x-ms-office365-filtering-correlation-id: 7d3d7420-7769-42a5-98ea-08daabbf1ecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  40VEo1dlwjCklXNrCcmi9hCY70IKMC1OE6UlYLMmKB3Db4UyOMJ4UDarmh7fZD5YpA9VjXj/TvANqq0VYvMnCxKysyOlJqSHdEuk4UWB5z8s/d7SXc3wfd8gkAyk4NypQZTXh36Tz1LGkRgRVFoHZDV+WsfjYiVkO3/V3SXmG7m+grk2EZuYCs581fa2cGbs+iJpl6S5C4Xc+1YDry1kyXrk+NskOV1BKW6vmhjVJGSSiBV6Z5odBGM15HAFBGHuons5WaF2h9ux19vast52dwLedeeR50qoz8S4OkqZF4zuI9J6bifBERVSyehEmdPzixJHzHJ05A2MJirh+rNOxLzrBstXaNjeus7hWFmo/2eEBM92Nkgjj6fCFWPGMlgZinQ5FcRRm15aVePS10eZl9fccqa4xw5Jw9kr9VaLwGypNFOv5ajE+fBX0JxY2cIk36MRlVCtyPxKK2LK+Z1y/by8hJE+k4d5UWr82djeMplrcQGzT4cbwTzSojl6Co0VgPtfN/jOUVfuk5kN5b3R6yIU9DvzK05TjuQBNL8fKg+tDcYNL8RlfSwcLJooJtQDQsVLpsKmR7m24sv3d1bYqHRJRRTvk7h3G3K1PWaaQ2c1tHTY41Q9q4SZYnvI2aZ8k/yD6kByBL7NItlju16Up95nQkAbHhvpC+RO5DFIXMY8tcZzUfgBY/S1PV0gu3D/Q6u2HkJXVjA5b0k7sp8i9PJpdh3Kq5uFbZQUPUUdRtGGR5YaNz9sNAg+iFbeUKEi96ehRcIZD+TZhhIG6XopoabAkKTn84fG5YU6RwQ7FeEKXs6x2kr3Fgna6tsfYTU0x2DctUm70XA95XWifhiUdA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(6506007)(91956017)(6512007)(36756003)(31696002)(31686004)(86362001)(6916009)(38070700005)(2616005)(478600001)(83380400001)(38100700002)(122000001)(3480700007)(186003)(316002)(66946007)(6486002)(4326008)(53546011)(66446008)(2906002)(54906003)(76116006)(71200400001)(66556008)(64756008)(8676002)(66476007)(8936002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VCtxM3RTUTQzWkp6QVlyMjhPWHVqakt4WU1iNEkrQkl4bitEYU96YVV4U2JX?=
 =?utf-8?B?L1JPaU5mYmhaRUkvZGpPMENlV1hQd1pDS2ZZS2VjQ09FeEh0SHJienRITzJF?=
 =?utf-8?B?UzNqVmpVdjFMZGVYUVNteTFqRUp3aDJjaUJQcUlwbWtVbThmR3FCTlh3elkx?=
 =?utf-8?B?TGdoNXQ3ellRTE1vemdNKzZmMitQaHZMMTB6NTAyc04vUEp2UXBZS3dIcGJI?=
 =?utf-8?B?OUZvWmdwVHRpSGFqcWk3eC9UYmp2UHBXK2p1dWgwVmFKU1A4a0lXejZiajBP?=
 =?utf-8?B?N2lZclNhTm00bzFjOFlYUmVGRk14bC9HK1ZzNkFZYVBwOFVzbFVXYkpOZDRD?=
 =?utf-8?B?TGtUZktZY3o0L0VqamR1NFZIdW4wcG5FcndtcDRRNmphTGVBWlBYQ2Q0cGFu?=
 =?utf-8?B?OHFnNitjczFTaGtaSDIyUDdaY29wQ2FIY2Vhc2VwS2RKVm9PME42K2VwNFhk?=
 =?utf-8?B?VC81NHdSRDg3dWY4YVg0b1gra1NGMjYwdk5CQ1FZSkludVRzN3M1UDhzOERP?=
 =?utf-8?B?Rlk1QnlobXM0TDhZelhBVmVTTmdhTU9NL29GVzNlQ3NNQzhrclNtR1VBcElF?=
 =?utf-8?B?ZmwwTnZsY0szWDh5cjkxeGZRWjVlNWE2ZlpvV1dCeFhhclpWODFQb2prbS9H?=
 =?utf-8?B?QmQ3c1pqcHBzTDVJQ3RUcWd0a1llVE1RL3ZwL2JCYk5jeWRmWU1vZ2EyUVo1?=
 =?utf-8?B?QVdJYk1SNFlPTEJBaHVrdGV0aGd3T3JCTTR6RVo4RHh5TU9CUGU4RnFxTi9V?=
 =?utf-8?B?UjN2OEdNdlpJSmtrMEQ2OUZKRUNtbGpqQWlYRjlwaG9sem9aQzM4WlRwMG40?=
 =?utf-8?B?V2ovZlZhWlhHZFl0Q0lQTGplcW5rSFhlYzJHWFRxQS94Vk5RYXNSc1NuSWh4?=
 =?utf-8?B?WEdTS2VubThUYThxK1ZJaWh5bXB1aDVOUEpJQWFmdWJDRVRSSkpVME9idnFp?=
 =?utf-8?B?SzBZcmdickpKRXVYSjdXZkF1dm80emFxaGdzYlR1ZS9sT04rRGozVlZpK0Vm?=
 =?utf-8?B?UHpLNVM0Y0JObnI2aEhoRG1XUTRNWUZIWE1oeXlkWitEWlhoN2NEVHZRT2Ri?=
 =?utf-8?B?YTNoUmZVdHJIUHJsRzErNXQwWnNjTjBlempDb3RocnZNbkZ6bjJ0TVVuVmpr?=
 =?utf-8?B?eGQrTWtuTWlVOHRiVndKYnc5UW9CK21FaStQU2VVSzRRL1NFblExejhuQ0pO?=
 =?utf-8?B?d1diZTZGcjQ5NzJva1h1UnV4OUswQVQzWklLVXhISXpzcFBsM3J5cm1qT3pk?=
 =?utf-8?B?QUtVWE13cHZWNVFyR1dCVmVPcDVYN0RGUWE1V2I4cFloU09jQ05IazM4NGV6?=
 =?utf-8?B?Ti9UdXZXalFGNmpMQ2t5ZnovVEJjVUlEMUlNM0w3cEE3TGQ1TUxjQnNzckZK?=
 =?utf-8?B?TW84RlU4TlE5cVZCZi9IVEJvS25aeFM5amhvckhYOW5wUExkOEdHOFF5ejR6?=
 =?utf-8?B?L0xHOEs3cnhGYnJSRVZNT1F6bjlyWGpVajhsSWZxZ1RvWDRNSS9QM3BNVjNR?=
 =?utf-8?B?dDdnWGtiS0xiWVo1bUozNkV3VUlPLzZ0NGdrZ1o3UXZMd2dlSWtoaXFYZHU3?=
 =?utf-8?B?TXJFeFF2dG5OdVlDWDdLcnExcVRMS2w3S0xtNlNRdkpXM0tnNFJSZWJ6NmRq?=
 =?utf-8?B?UVZ6elhJT1dCM0wwWU9NeXBndWVkNE1wOXg1Q3ZiM3hZUjN2QWV4ek5LMDcz?=
 =?utf-8?B?amcrNlhGbVJseWRXT053QlgvRFEvSDBDeG5CcWNWSDJkbStqbDJGWWdhN3pi?=
 =?utf-8?B?UUt6Sm0vMlIzZmFmVUo4VDgwc0hTKy9RNnl3R1B2RWhZckpqS1dXWXFqc3h1?=
 =?utf-8?B?UW9maEhrR0UzejlocGxhWDhoSzFCbThNREZhQ21HRXFUVW53V1YrbGhDdi8w?=
 =?utf-8?B?ZWs4QVNFOW04VWcrL1lNTTFQMlNBWDU5UjNPc3k0WkxWa2U4dUxrR0dTQjhl?=
 =?utf-8?B?KytXbCtLeWhFM1M5RE9HZE5QNE02UlhnVWVwejdlNmN0cnhVMzdEamd0MGVZ?=
 =?utf-8?B?ZElsTjN2emxqb3ZTNVMrSHBDVTZ4SURKbVJqMy9hRW9wajZMUVV1SE1jZDk3?=
 =?utf-8?B?cWVRaTNCemQwMEZ6VWg1aVpqcE40UDY5OUJiV3lxL0FMUmlzOVpNV0RGUXFj?=
 =?utf-8?B?UTZZUWZJblhIVDJIakMvTDNSRUk0SFp5OS9IYjdFbHRlWmVUR0NwaVZwWjBw?=
 =?utf-8?Q?/so3Xa4UscaFQQizgvRiDuJzydsOi/Jm34GGPM6VJwoI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA310DBAF4F61748BD2090EBD2EC7E59@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3d7420-7769-42a5-98ea-08daabbf1ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 19:30:56.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1piLVDZLsufJWCiFlSOZ3WCq5Rf7H5RywWxqbSexb9cPu7m47Zfdpta9I/1UQUZ4Lba2iH4gsQLUaEw+19cfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_123101_135180_24B2293D 
X-CRM114-Status: GOOD (  18.56  )
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

SGkgU2V0aCwNCg0KT24gMTAvMTEvMjIgMDg6MzEsIFNldGggRm9yc2hlZSB3cm90ZToNCj4gSGks
DQo+IA0KPiBJJ20gc2VlaW5nIHRpbWVvdXRzIGxpa2UgdGhlIGZvbGxvd2luZyBmcm9tIG52bWUt
dGNwOg0KPiANCj4gWyA2MzY5LjUxMzI2OV0gbnZtZSBudm1lNTogcXVldWUgMTAyOiB0aW1lb3V0
IHJlcXVlc3QgMHg3MyB0eXBlIDQNCj4gWyA2MzY5LjUxMzI4M10gbnZtZSBudm1lNTogc3RhcnRp
bmcgZXJyb3IgcmVjb3ZlcnkNCj4gWyA2MzY5LjUxNDM3OV0gYmxvY2sgbnZtZTVuMTogbm8gdXNh
YmxlIHBhdGggLSByZXF1ZXVpbmcgSS9PDQo+IFsgNjM2OS41MTQzODVdIGJsb2NrIG52bWU1bjE6
IG5vIHVzYWJsZSBwYXRoIC0gcmVxdWV1aW5nIEkvTw0KPiBbIDYzNjkuNTE0MzkyXSBibG9jayBu
dm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08NCj4gWyA2MzY5LjUxNDM5M10g
YmxvY2sgbnZtZTVuMTogbm8gdXNhYmxlIHBhdGggLSByZXF1ZXVpbmcgSS9PDQo+IFsgNjM2OS41
MTQ0MDFdIGJsb2NrIG52bWU1bjE6IG5vIHVzYWJsZSBwYXRoIC0gcmVxdWV1aW5nIEkvTw0KPiBb
IDYzNjkuNTE0NDE0XSBibG9jayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJ
L08NCj4gWyA2MzY5LjUxNDQyMF0gYmxvY2sgbnZtZTVuMTogbm8gdXNhYmxlIHBhdGggLSByZXF1
ZXVpbmcgSS9PDQo+IFsgNjM2OS41MTQ0MjddIGJsb2NrIG52bWU1bjE6IG5vIHVzYWJsZSBwYXRo
IC0gcmVxdWV1aW5nIEkvTw0KPiBbIDYzNjkuNTE0NDMwXSBibG9jayBudm1lNW4xOiBubyB1c2Fi
bGUgcGF0aCAtIHJlcXVldWluZyBJL08NCj4gWyA2MzY5LjUxNDQzMl0gYmxvY2sgbnZtZTVuMTog
bm8gdXNhYmxlIHBhdGggLSByZXF1ZXVpbmcgSS9PDQo+IFsgNjM2OS41MTQ5MjZdIG52bWUgbnZt
ZTU6IFJlY29ubmVjdGluZyBpbiAxMCBzZWNvbmRzLi4uDQo+IFsgNjM3OS43NjEwMTVdIG52bWUg
bnZtZTU6IGNyZWF0aW5nIDEyOCBJL08gcXVldWVzLg0KPiBbIDYzNzkuOTQ0Mzg5XSBudm1lIG52
bWU1OiBtYXBwZWQgMTI4LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMuDQo+IFsgNjM3OS45
NDc5MjJdIG52bWUgbnZtZTU6IFN1Y2Nlc3NmdWxseSByZWNvbm5lY3RlZCAoMSBhdHRlbXB0KQ0K
PiANCj4gVGhpcyBpcyB3aXRoIDYuMCwgdXNpbmcgbnZtZXQtdGNwIG9uIGEgZGlmZmVyZW50IG1h
Y2hpbmUgYXMgdGhlIHRhcmdldC4NCj4gSSd2ZSBzZWVuIHRoaXMgc3BvcmFkaWNhbGx5IHdpdGgg
c2V2ZXJhbCB0ZXN0IGNhc2VzLiBUaGUgZmlvIGZpby1yYW5kLVJXDQo+IGV4YW1wbGUgdGVzdCBp
cyBhIHByZXR0eSBnb29kIHJlcHJvZHVjZXIgd2hlbiBudW1qb2JzIGluIGluY3JlYXNlZCAoSSdt
DQo+IHNldHRpbmcgaXQgZXF1YWwgdG8gdGhlIG51bWJlciBvZiBDUFVzIGluIHRoZSBzeXN0ZW0p
Lg0KPiANCj4gTGV0IG1lIGtub3cgd2hhdCBJIGNhbiBkbyB0byBoZWxwIGRlYnVnIHRoaXMuIEkn
bSBjdXJyZW50bHkgYWRkaW5nIHNvbWUNCj4gdHJhY2luZyB0byB0aGUgZHJpdmVyIHRvIHNlZSBp
ZiBJIGNhbiBnZXQgYW4gaWRlYSBvZiB0aGUgc2VxdWVuY2Ugb2YNCj4gZXZlbnRzIHRoYXQgbGVh
ZHMgdG8gdGhpcyBwcm9ibGVtLg0KPiANCj4gVGhhbmtzLA0KPiBTZXRoDQo+IA0KDQpDYW4geW91
IGJpc2VjdCBpdCA/IHRoYXQgd2lsbCBoZWxwIHRvIHVuZGVyc3RhbmQgdGhlIGNvbW1pdCBjYXVz
aW5nDQppc3N1ZS4NCg0KLWNrDQoNCg==

