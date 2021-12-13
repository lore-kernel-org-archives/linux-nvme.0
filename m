Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F0CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zh0Czcz2XiYRnWSRZ/FDWjepKSuD4EBcqauD61fb3zY=; b=RUQ6sy6Rxf2l6GedU50cwJQGY7
	/M5VaOA0f632vtEs7AG4YyY45MMJwKHryPtU2OmzoROnFni6a1VJNN8yLKBgW3xtQ+Vatqy1ewRH1
	gdDXoRtk6FUcmJKz6NpKyCtk49BGjaBRipWN2NezaHV8tyhfI9HirzdL6d7hdLn0zre/inluxyo3q
	lkHowm0AsHT81UGTGGmuDAp7Vo/wO3OxXzd8CpMT5Z5wgzjDk7MHcEZsI3pDiXghXTwCzwuW/lJbF
	HT0pm0omNZ2PZn3J18vAoGQ3TG9aM66RXS/Z8pTNYAhxqGzHqHy9aEIXdNDA2otR3E0J66rWXPHIn
	fpobv/cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwu7R-00Br0o-1a; Mon, 13 Dec 2021 22:48:29 +0000
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com
 ([40.107.244.87] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwu2V-00BpKr-Ra
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCGg8qG/tdvLTKyCFWedtJJWCIA0C8mK+EXVkxcPD2/hQb1D/pruRz1aW675PzAHJaws1B5HxfrVXmDHet0md1rcryb3eevmIapXFAu1/9grfHHbKS3Kq3zTayIghG7vZGzZG9X7m2AkMFCPs/gtTwZtCB4VaESBip/hFK3hGYTqnUSlUwdd0xyNSCHPUGdfu/c0sFTTxPUw7FjK3N830yvqPj9uAI6kbHhyjjBlelLAjip8m28iLi9I/XQhvn5xdbJEmeqcNijUkul6uIj9+CvHBhXclzydXDRWxqjiH6e8QU603DdDXqmI0nwPdAi3AJIGK8uTB0ICth7DEurGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh0Czcz2XiYRnWSRZ/FDWjepKSuD4EBcqauD61fb3zY=;
 b=MzDlVkjgDfdKUg+1hTGqRWeGqDoH71k/TjQZcuRPH8nfMcTVEJMTo6d0L9fq51TVcEQtI43/YcwGsY9Ucl4aQqRPlFN5fAhnXAlYIJBpqZvy1oA/I5mphiK/59TyInCB4tygO5YbCVPSvkH1ZTWR9FAIP2y2+HlpA/tVSEfOue6r+izFksFGVlMm0fYMZyxpRlkU2+rax4yijRkXYC2CCUFKxdTGFexFTRFTgeauOyPz85MUXZ4bn93PUte/+9ykAb4a2y8WMqSDZLc7zvl/nzLWJBTwcoy6/kxJt//yX9Q+24qWsmgT3Mu6+/gtGgYddlR80XaxGA5LUhY3i4im6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh0Czcz2XiYRnWSRZ/FDWjepKSuD4EBcqauD61fb3zY=;
 b=V3HQxqoCCbxjPL6yfpFDTeNaNfHcnPyJpAE0ZcHcA26xrizT8kdp7YNucJpICE+AJCAwg9sWmpqphOuyg/Udb8oUakxd15hfsunlzLpP7N8Sgj757XaZTaxbzeQ8NKd8gKsZp2zsbA+nOZfXBA6X+Nx+VKs4VhRpx8u9N/CYtbBTa8/G/3ySJfGZ6OJoqo62i2qg03NeEpzqhSSj8CXQAFkWqftfknupax3M3A0RyBorRc4U5iPukKEMrRNOCIlGGu3HLPoHn49cuP3vtKywspvteKM+1zkdaUBlo9t4HPyfDGaNSXIiFSxafTvQds+GPJfuv3Xcpv3+n3o0hDcUMA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 22:43:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:43:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/10] nvme/rc: do not print error message when no nvme
 device is found
Thread-Topic: [PATCH 01/10] nvme/rc: do not print error message when no nvme
 device is found
Thread-Index: AQHX4D+MOoejNgrRGUOz3rBX2E+ff6wxJSKA
Date: Mon, 13 Dec 2021 22:43:15 +0000
Message-ID: <511dc75b-2747-3ce4-978e-b6501629da7f@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-2-hare@suse.de>
In-Reply-To: <20211123074940.113390-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bac3638-8c48-41e9-a60e-08d9be89f3b3
x-ms-traffictypediagnostic: MW3PR12MB4444:EE_
x-microsoft-antispam-prvs: <MW3PR12MB44442CC38DDFFB4D98A01DA5A3749@MW3PR12MB4444.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HDY2oiBlWkxAbkhTnSmuh6ZCe7vB/hrWdDWBeD7tNINpVzMWTfA52C32RFE2JpPyHPyzHVypKyu/A6tak5YFLp8ELkwghFmnzErnF30/1P+NQiVKfVmlKJIDx8OX6XX7bOO6FEom52s0SOrq4M5L97kjl4JhJAMopjkrZBcAVLbPga6paXAjVkG4NfUWL1sVucgYP2lGUiRYXpXNlr7nlBIMuJoPKPM+QK9Gc7Wg0TIyFWvptJK4m2xScumD8K14wg9JwbHpifBwovAjIJxCwCiU+OARvbQ64I2LrgS2oTBM8q3E5kVnR3i8kJ3bfkphi6A48RMT9fnVDsdDhs43xjJcWpEIf3lF9jwWtY4mvWa+JaONjAC9j7d7Vov55JBW/S25mftmN/9oKAp5Y7K8ezbXvmGic5JEWzW7OU23/rTBV4FiZ5jAt6pPhMHZGBuTDwm2k2bxMJFLav8v14gTJBiNas4kSyOHvEhIXcpgDr7FRKAMstaIkqCgHbTyWmBpWfv6ynB1GqW6X601sKyK9qoA3InsxVlHrXFTpwbH4EBLL2QWcZ+ZENbHPi1RX5wt80bHSsiLssBggFoK0ubPLPmHkiEgt+l29S0WzxpUkcx24wqEUgjW2+Zz2uJO+xX9213tVVGyEMdfcQM8eCJK4OuNt8hyQ9KXLm+6MCm4GoZaZuYWNWldfGskiQVsiEuOunNy11ktNg8CPBXbNpbv/9GQf58cKmYYQwYW4rVW7N2I7spfP+nIQwjA4HurLMBOavqlmpihHxqvIlW+fIF2gQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(53546011)(6506007)(110136005)(54906003)(66946007)(31686004)(5660300002)(31696002)(36756003)(83380400001)(38070700005)(91956017)(2906002)(6486002)(66446008)(76116006)(66556008)(66476007)(64756008)(86362001)(186003)(38100700002)(71200400001)(558084003)(316002)(508600001)(2616005)(8936002)(122000001)(8676002)(4326008)(15650500001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE81YWtSRmFHZ2ZuNFhzcDZsMWZlZXJMeStUK0NJKzVMRTNWblNSZjBvNW9Y?=
 =?utf-8?B?eUtsWG5jL1Rsbjc0OVhjZUt4OTlreXlBb0VreUFqUm1LMkJYVUtOUUMwUkVu?=
 =?utf-8?B?NUtNd3loT25lYWxLMldJUTNOTGhDZFpVZkVwK1RjRWx1LzdUSll6ak8vWjhZ?=
 =?utf-8?B?eXhSREgrK2t4d21Ma0Y1dFMxQ2d1TStaWFh4ekJ3K3Roenp2TXREYThINENP?=
 =?utf-8?B?WTY5NVE4NTIzM3NFc2M3UUtDOXRXRGFRU3lLc3VBaUMvTitXWHc4SVg5TUJm?=
 =?utf-8?B?SjNPVjV4NHZod21NTDNZWi8yNkRJbWhlN1VYRm9rU3I4b0dSSzVycHRKYyta?=
 =?utf-8?B?Q2IydFRlTldkYmlTY2ZiVnRndHVucWNZcE80SFFrWjczQlQ4anZOZVdLbzBE?=
 =?utf-8?B?YWRCbjUyTTg4WE5KbXZ3VWEwdU14OEp5SWlpSXJkeVRKOE9zREljZE5UckVY?=
 =?utf-8?B?T2lMRkVZZUtBZXJ2eC9YQnROdFlxYkNSREQydDJqSVUwTmxtaDRIQXpDUmV0?=
 =?utf-8?B?TjB5eXZueHhBSXJvVFJSMmlJQkhmd2tUcFg3SVpGNUxnT3QyTTJtZUtxZ08y?=
 =?utf-8?B?cFBDN01IL0d5WUsyQnY3c092UU9JL3A0N3hmcFBsMEl3Si8zL1U2TVZLQVk3?=
 =?utf-8?B?Uko1MTFMWW12U0xUSVZWN3owaVB1SjZoU21ieENHTEdLWFhoZkxCOFE1Umt1?=
 =?utf-8?B?MkNTUWh4emg4SjlVQmhaSy91OURvdmkvdUEzRnJmcmpRcitCSTZhU1psbFo1?=
 =?utf-8?B?L0hDV3FGem4vVC9lQnR3K0ZSOWg1SUhrZk00QUZ4UC9iczl5Q1JqU0lOU2xK?=
 =?utf-8?B?OXJpK1Uyc2txM0hRNmZpTXdESVNEMEQrUmRFaDJUVDNXN1c2c25qc0JOeUtD?=
 =?utf-8?B?S2ZoV1hsbWs1dWJ1NUEybzJBZENLMldxMEhXRCtsbUFJWk1yMFBaemQ3T1NV?=
 =?utf-8?B?ZFc4RndWNytZYzNLRG9jcFZMWW5hbWF2MzUxOE5aK2ptMVZ2YzczZGZ5eVQ4?=
 =?utf-8?B?VytSbU9SZk85Q3ZlZUQvMVFHNHYvQkZuWWZIbC9FZHlZdXpsYlU2Ni9DTUMw?=
 =?utf-8?B?bWU1ODdBazVOVkMxMHd2MG5RNHBLUFVudXNWd3NRbjM2OFpVRnF0TjNwODJy?=
 =?utf-8?B?YkxzOGhlOEdOdTVTMVlwS0xVVmxFVThFbzZYUUZyRVcyUUVPd3ZwY25Zemxj?=
 =?utf-8?B?RElpZDlHdXY1YjBaVDgwOG5hTzJ2VVFLQ3VKSFNuUTV6dGYzZDNISThWTEpx?=
 =?utf-8?B?WEY5OXpoM3hieG1tM3NqZDY1ZUV6OWtzanRaTnBIUlREVDVSOFl2Sjl2aHRB?=
 =?utf-8?B?czViYkxDOSsyZzcvc2dZNVdBVWgwSWU1M0ZST0dYcVlBMy84RWo0Z3Bic0hE?=
 =?utf-8?B?RU9scUZOeS9lQ1lHZ1lyajRsWExuMWdzMHd0M3MxSnU0TXo2bjlxWnhMVmNy?=
 =?utf-8?B?VEZTWGVwWEhvYjdJS3VFOU85TEdJL2c0VU91OWNkaktOSnNaWmJySG5nejJN?=
 =?utf-8?B?OGgvaFprMVEzWUdxTUNMS2lMWVJKbzZjQUtsU0hZVFZaK1YweG50MFM3WEVl?=
 =?utf-8?B?YkVUODl4VW1qQWNhRXMybmJKK2hRcmwzblNHb09YenpYQ2RsWHdncFQ1cW9O?=
 =?utf-8?B?K3RNbDlpRVN2RE10V25MNnkycGtkdklldnBsalhuRDRkVGJCVWtDZDJ3SGg5?=
 =?utf-8?B?bnMycGhiMzh6OUdkb20yTndjYi9sMDU3WlVmVTI2V0V1QWRkWVp3L2VpL2JO?=
 =?utf-8?B?Qit2SjRjdjVzaUNnNmNKZXQ2alJmaktzRTd5cEp0QzhCcHZSWWovcXRqR3BR?=
 =?utf-8?B?dmttanNGTWc0VFo5dXVsSEJJdXVNb005M0xoS254azBRMWJ3U0ZmanUzZDdE?=
 =?utf-8?B?a0hKcnRGbEcrVlovVVREZVVFd25lSzJ1bGowVXJrNHVNdXBkdXNWMWNHNGEv?=
 =?utf-8?B?OGFIK0RwZ3YwcnJ4QjJCT0tYWkRLMTZsRkVxL2FZbU9SLzVBZEZicFVpNy9S?=
 =?utf-8?B?TXVxYUhUM1RTcE5BWGJ5ZXJhN0tCZ2ZFU0VUOHRVTXB0QitpZjRqNnNmUDVn?=
 =?utf-8?B?ZlBjbTEzeWVoNlpYN3lzUi81Q0lpVGorWTV1bk44QmdJYXE0MTJVZVFGZk9V?=
 =?utf-8?B?ZkRNUmNlRTB2Z1RqQk9jNmdIcndGbkhxZzUxODZJNks1LytrcnRXSkJ1TXlN?=
 =?utf-8?Q?fzcKSZUMuY2o08LKiqH2sj4bwRNW8TIOV8wFhOXhPGuQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB7B17F49C5AC84592E7F6948BAE2CC8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bac3638-8c48-41e9-a60e-08d9be89f3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:43:15.7140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzdLMgOc0wdz4Sufmb1xEHUMopxrx9gDZyBiY4lKdrGtAxS9xHEYVJW/r/4BQ5MPqK+d6Gd0BVaJv+xg+ux7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_144323_962502_7FF2A40E 
X-CRM114-Status: GOOD (  10.51  )
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

T24gMTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gX2ZpbmRfbnZt
ZV9kZXYoKSB3aWxsIG9ubHkgcHJpbnQgYW4gbnZtZSBkZXZpY2Ugbm9kZSBpZiBvbmUgaXMgZm91
bmQsDQo+IHNvIG5vIHBvaW50IGluIHByaW50aW5nIGFuIGVycm9yIG1lc3NhZ2UuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gUmV2aWV3ZWQt
Ynk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
DQo=

