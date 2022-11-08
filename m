Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DCCC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 23:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTIFec+QMZ6egrCATS7LTmUhjNMR5IuJsCCz+3No0tk=; b=Bq7VP2TdVF5ESnab93IcdHAiiq
	/5earezbuDahlW78Vrun61YD3CoVI3bsw3Bvwqp0SfgTHIpThaaYcsUwWbDy/hO8SGJjyGNh2hyec
	nxAGWPUwzER4aReX+j+ZLHpDjRM3pdvm94VwCBilMdRVgUwqXVlhL0qYSPuj5lDRQZCy5tDwCPGjF
	dxgTXG5GttUZtN3LWk+sDcWPRaBRkwABLb5Pdv1TgrKpIZQcPMUsepPQ60g4NUsdoESq0uVItKxuA
	7QXCempZN9Rc2YOsJZ680rtuqerSF7Obcov7nXGJ3OJ3uUk8d1FN2yipU+MLf+7c9j5FKDGCSUN8A
	K5IG0sfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osYB7-0099xD-CY; Tue, 08 Nov 2022 23:38:49 +0000
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osYAy-0099vt-E5
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 23:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noCvAIgP+5NeCyiUeQu6toXUHq7/73mjYraMN8ooypnVROVb4yhkLAkMCetiQf2A45psDQR3vsAphHUJwhnbVo1VgsuFY6ljoA8EOiIWjC/xeOPlrEEooWQtoXDYMoArDqat6HtYsoDYXTc2FZ7I8hjeflccEUxecu248+FhQ+cCQy6YcBvVDb5gPDitYoZCDbVtbp71Sl/ywwdZaUZEKUw0oqtqd773lgGEgCLI9lm4cEFtjowWcyRGUgoY7kVn0aUifsfEtsUe2WkjUuy9M14litqB82RSsHHvLmRyYLVFjAnlkp28ITh5uSLnsn5U3ZvrN5jKmRgHA+9HaGeOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTIFec+QMZ6egrCATS7LTmUhjNMR5IuJsCCz+3No0tk=;
 b=HQVbVrtZute8BYSJD3tSRkhWhvIH0QiR5tc3AhUUbrtfThIouYNzI/tL3l1yb5/pDxxFO5uTh4SWRaPirqj6MEr8zCPs9pwyZu9/8ql25yD92PVvm6iIie9yB1OnQqIK7Bs1MgCNrQ26x80SnqOYjnK4QHJdR3WO/Ky4oc91JsIOuSwWA4/xxaB/TgRW8Qz39m+8QaH8IYQCtCj/Ox7Bo6xOLC5zAcRJ5NLV74K6j4BpKaiHn3f1nbQwPZ1YoeETZYz5gufd5HNSH0wblFplPDUX9zCksVRTDdp51OSZjea3GisYHRP1qa6I6nu/6UGbJcjYxfncgVgBo+q5LMsAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTIFec+QMZ6egrCATS7LTmUhjNMR5IuJsCCz+3No0tk=;
 b=jXJjiQstd6HO31i57vRwbg9lkeoFSTSKD03BDWqEZptc0Wit1BnZKd8OnBOB5lleizXkSXv4MXNkz4gfoga02fzBRMfIDNtV4ZDmmnF2+MtQQ1xuI/DvfE6YsOgv6rr0YN5Qt32wqvdJwiCtM3euy/eRETFg7n4XwOkC2EIdfufdiAD7dpj490o6leqAsLBSWnkGoLev7cX+um61klCSZqwJLPkZDRFhIRui1L5ZTFofrLUgpZil0MWtqmUmNWnCbUsPb1rq6gwRsE3pq7PTMr1xYfLE709MQ8/AR13vDohe2IvfdjA5Skzl1NCQhWgH7uEPq2ub3p9B9WP1HoAnjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 23:38:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 23:38:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Uday Shankar <ushankar@purestorage.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2] nvme: scan sequentially only when list scan
 unsupported
Thread-Topic: [PATCH v2] nvme: scan sequentially only when list scan
 unsupported
Thread-Index: AQHY8uOkzXEGZs2uuUSS8PxBm+Dqva41sKcA
Date: Tue, 8 Nov 2022 23:38:35 +0000
Message-ID: <581b78a8-d751-12c4-4a29-4879f5baabcd@nvidia.com>
References: <20221107195443.2176099-1-ushankar@purestorage.com>
In-Reply-To: <20221107195443.2176099-1-ushankar@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6299:EE_
x-ms-office365-filtering-correlation-id: 54dfe9ab-8578-4a04-e0f9-08dac1e25a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  7Gv4IyExU7RMtmtLUWgrUBG/OTjHE3iq+KvS8d4OehWohQJZe89IUgfFmCg0UYLFfoQ+oCW1pyyC67HUBMB1tWue+fGQNNkSQyv+r2JYnUfEKUYynIUa+BnvOqD2/A6YRi/pzQkC83sqqSiNovj+BxPpqQBgx2OtYzpIxXFA5ezTOmqBaQjKcRM5fYZx1v2XjsUvpm3uMevUIL6pXFFDBZs3cJfbE0wxI89i9HwQHXuho23NkUIberumwsSC29sxrb8KrDNVj8Zp9u/8fVbvTiQDEU4AjD5IWIVawwhnzGpfErBo+OF4YhVVZyvq8K+3MgpMYa5zcY2gKot5UGQ1G1b+TkyCL4ag8RgFbLexlvc8qazbDSnNOkz+wFufovXIoQSGZDtPHUs1coNm3mWEfI465v5an7HKr7WbF7KylIV1zWKuSXrGFncufY3WvTLCz22/V3+E0LIE9+c3wGM4P/OxZRtXZ2anQEgxZLO1PiCXCiRl8hLtF022R1IVyfLh8OymGf2bw/B1mwyfTFW2lw/qBhgIYYWQm1LbpREDplWX/NR+NFJtIfKHRybd1fmp48fW40bs2knKM6QAlrufOhJIjEbcUF1ChZ9+lJxqwwu8Ic5xX8cv9gs8T0TD4CiDdXZwYGXhEwOxVTPYW6egp590580lnmNybf1Gr+rnMbV8jDwDBXBaTgsa4IJ/9OIqRIGEHo8ySFq1hbrb8EA6+3ewDlGFLCv02/3OecDrbCKN5IQflAY1n9EuqGWtp5usXv8Ud2kyRHkxETKUPkJ5RGMbqjeuvYfZKXVsCuD3uA/a0KAdI4e3tNL6sH6lx208LO6k0fxmr26cEXN2A57acg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(66446008)(66556008)(8676002)(8936002)(64756008)(478600001)(6486002)(4326008)(41300700001)(31696002)(2906002)(66476007)(122000001)(5660300002)(2616005)(38100700002)(86362001)(66946007)(83380400001)(31686004)(76116006)(186003)(110136005)(38070700005)(91956017)(316002)(6512007)(54906003)(71200400001)(53546011)(6506007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Tm5QQWxIRVpKdHIzVWlnWE1IdTgwY1hEeGc0WDhtTTIwM21DSkJQUXdSb2FP?=
 =?utf-8?B?V0JhYzNQbFZqUVVWc1M3WkwrdUMvK3phbVNDV1RNd1hSeWJMbHZvcTNES0xS?=
 =?utf-8?B?alExRlRSalJCTkwwYXI5TkZDNVF1a3YwMXBoblFZZytJdjlwWVBFc3dGWmlu?=
 =?utf-8?B?dnNzb0w5ZW5QYlhuVEJZbGRMVEhYOVI1UEZKaHRKc3NPa05HWENoRzZzUUE3?=
 =?utf-8?B?THZzejZnQ3M5QnY1S0lnTE1wTDFjeGxwQ0phWnpUQUhSbm02MXlXTW9ZSXAx?=
 =?utf-8?B?VGZXQmtIbDkxdUYwblVoKzlVMDNlK2ZUc3RTVWdwMDlhY3dla0tTYzlLNm1U?=
 =?utf-8?B?c3hlc2VhRkZCTjVNNFlUSVhZVVpOdTlDVUVwQjBqWU1WOC85dlNwTGRNa1JX?=
 =?utf-8?B?Rkd1aWRQckErYTBEeDRzRnB2cS8vRlFsRGJ0M2VoSmh2d2dYV1BEYzFYWkI5?=
 =?utf-8?B?cWlvbnNKdXh5TjV4ZXJmWWhiY2txSHZKeU1TbmVsL01ic1pRZ20rOWlaV0Fu?=
 =?utf-8?B?VXJFcFV2RW4xWHdxSFcwd0gzWHdmc0xSS1VmclNjczdocmxsUm1HQ2dFd255?=
 =?utf-8?B?MFZaZ01SNFFMcVJsNTl4NVZwNTJlNUJDdnZnaWk4SWdiaWV4Y295ZmhOZkNW?=
 =?utf-8?B?TENITzVXTXVtYmVLc0Z0SVlmdW1pQkNqaUh5eVgxMmthbkRvVE1VdUJiNEY0?=
 =?utf-8?B?b21BQlhLSDM2SEhHMm1mZ3MwSC9QMWV3aUJqeXBGR3c5QnIzYmhlVVhRZXpl?=
 =?utf-8?B?ZElGbFFEeXdsTG8vU1pnTU4rY0xUelFCTFNsSUY2UUgxVXpGaUh2K2dudHNM?=
 =?utf-8?B?STU5NFpabUl4SmtMNFpyT0N2K2gxVERrSWRGUHRSVWo0K0swbWp6N2hxcVd4?=
 =?utf-8?B?T0RnblhBaWpBTWxUNk4zSDhydVlRMEJmODlJaGY3N2c4VWFjZjMwZnNPeWg0?=
 =?utf-8?B?ejE2N2JXaEt6MGdPMldMQXJuQlFGNGVZdlRzTkZWcWVPL1VZWC9jdlRxZzh5?=
 =?utf-8?B?TGN0QUdUQjMxck5waU1qZWVkWUxLVHp3dkV4bDhmS1JtamtEdHhjUFFjMmJy?=
 =?utf-8?B?eHhpUVhFajA1S2l2TGR2QzdudDY3eEMyMnVFRjVjN3dCUUpHK3dib0RPZzdl?=
 =?utf-8?B?WDRsZW9YaXowVHRoSFJYclZCWlRQOHVUOXlVOUY4RERYK2UxYmZtMjZESWQ3?=
 =?utf-8?B?c0g4MTNnbkJXZVdzQWRTeldYWG52VkswUWJQMkI0cS9sSzFDNE51bWhPR3ZY?=
 =?utf-8?B?KzFSeXloSGw5Q2prRThGaDVuVVM3MTAzRjNuajVsRThyOWJPMmNwbWYzbHJF?=
 =?utf-8?B?cXUwVUhLNlRiZ3pEMHBLSUR6Ui9Fd2VIR05tbnlUVmZRUncxU0dkcHdRRm5B?=
 =?utf-8?B?NnhUdnF5UWM1SU1kN0ovZXgrTW0reHk5ajI1NFc2QkV2dVpFZzlmMGVrSkNJ?=
 =?utf-8?B?Z1lDbEpuL2FmQ3BrVER0cnlhY1N2R3hyQ0xWMW9CaWVWWktUSm12RDBld3Zs?=
 =?utf-8?B?ekZJRzREZmtUSHBsQnpDSXVEczBnY0NJQko4WFpoUENweVVWRUdTSXlVSEFD?=
 =?utf-8?B?N2FJUTJwYXUyNU55V3NRWkplTTNIdXRDcmFTcHZuYTVvYmFoSTkxZlcrcXE4?=
 =?utf-8?B?ank5dW9kVXZxcGo3WldIN1ZZNThldk44NmVpQzV3ZjJkNCtrRWFmWTdjVFJB?=
 =?utf-8?B?WjI2clhwODg4UTQraWJHSW92OUJORzhqTmRLZ2hLTHVCRDd3ZmtRTE1ZSGcw?=
 =?utf-8?B?Yk9zNUZsNUt2U1cvcW9IYlNGb2hLd1NxdnJINFpmMnd1Y2xMdllhNThQVzlC?=
 =?utf-8?B?WEdacG1ldS8wQlp1WXZneThzcmVNTHRaZHlPVWNxc1Bpa0ZzSDMycmIybzhS?=
 =?utf-8?B?a2VuL0htbDNQQ05yREl1enNDRjE0dlNtN0FRTWFrd2l5VmRPWDZYcXNHOWhM?=
 =?utf-8?B?VFJZNEpBYmVvb0w2N283cm1LbEg5RWJXc0JPTHE0bnNJSDhmT0tUeEpXdnYx?=
 =?utf-8?B?cXp1Y2pYaGFURUwxL05JRXY3Tmw4WmNkeWUzVEs4WWk1dXcyN2wrUTNUUDgx?=
 =?utf-8?B?VTgrUUIwa0dJQWVyYXlmOTJRNlYxQjhHRzBqZVdHVlQrWGhTdFR4ak9TRk1J?=
 =?utf-8?B?eHdveEVhRytNYm5iNnNGMVdZbDA1MkgxYjhBZHVGUmdhaDVkV2orWExyUEZv?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A19CA08D0384B4A91FA31E9FC33BE7F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dfe9ab-8578-4a04-e0f9-08dac1e25a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 23:38:35.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbN71cSbuRr6yFsiqTpS29Xifgy+nLdnu+/vuaaXJZA8G1woCtV+TnZ4j1jAxwlFUs3ifjmtvVggWE8vwNKNEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_153840_508620_16425F17 
X-CRM114-Status: GOOD (  24.21  )
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

VWRheSwNCg0KT24gMTEvNy8yMiAxMTo1NCwgVWRheSBTaGFua2FyIHdyb3RlOg0KPiBDdXJyZW50
bHksIGlmIG52bWVfc2Nhbl9uc19saXN0IGZhaWxzLCBudm1lX3NjYW5fd29yayB3aWxsIGZhbGwg
YmFjayB0bw0KPiBhIHNlcXVlbnRpYWwgc2Nhbi4gbnZtZV9zY2FuX25zX2xpc3QgY2FuIGZhaWwg
Zm9yIGEgdmFyaWV0eSBvZiByZWFzb25zLA0KPiBlLmcuIHRyYW5zaWVudCB0cmFuc3BvcnQgaXNz
dWUuIEFuZCB0aGUgcmVzdWx0aW5nIHNlcXVlbnRpYWwgc2NhbiBjYW4gYmUNCg0KJ3MvaXNzdWVz
IC5BbmQvIGlzc3VlIGFuZC8nID8NCg0KPiBleHRyZW1lbHkgZXhwZW5zaXZlIG9uIGNvbnRyb2xs
ZXJzIHJlcG9ydGluZyBhbiBOTiB2YWx1ZSBjbG9zZSB0byB0aGUNCj4gbWF4aW11bSBhbGxvd2Vk
ICg+NCBiaWxsaW9uKS4gQXZvaWQgc2VxdWVudGlhbCBzY2FucyB3aGVyZXZlciBwb3NzaWJsZQ0K
PiBieSBvbmx5IGZhbGxpbmcgYmFjayB0byB0aGVtIGlmIG52bWVfc2Nhbl9uc19saXN0IGZhaWxz
IGR1ZSB0bw0KPiBjb250cm9sbGVyIG5vbi1zdXBwb3J0IG9mIElkZW50aWZ5IE5TIExpc3QuIFRo
aXMgYnJlYWtzIChub25jb21wbGlhbnQpDQo+IGRldmljZXMgdGhhdCBjbGFpbSB0byBzdXBwb3J0
IHZlcnNpb24gTlZNRV9WUygxLCAxLCAwKSBvciBsYXRlciwgYnV0DQo+IGRvbid0IHN1cHBvcnQg
SWRlbnRpZnkgTlMgTGlzdC4gU3VjaCBkZXZpY2VzIGNhbiBiZSBtYWRlIHRvIHdvcmsgYWdhaW4N
Cj4gdXNpbmcgdGhlIGV4aXN0aW5nIE5WTUVfUVVJUktfSURFTlRJRllfQ05TLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogVWRheSBTaGFua2FyIDx1c2hhbmthckBwdXJlc3RvcmFnZS5jb20+DQo+IC0t
LQ0KPiBDaGFuZ2VzIGZyb20gdjE6DQo+IC0gTW92ZSBsaW1pdGVkX2NucyBjaGVjayBmcm9tIG52
bWVfc2Nhbl9uc19saXN0IHRvIG52bWVfc2Nhbl93b3JrDQo+IC0gTW92ZSBub3RlIGFib3V0IGRl
dmljZXMgdGhhdCBtYXkgYnJlYWsgd2l0aCB0aGlzIGNoYW5nZSBpbnRvIGNvbW1pdA0KPiAgICBt
ZXNzYWdlDQo+IA0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDcgKysrLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jDQo+IGluZGV4IDAwOTBkYzBiM2FlNi4uNWFiZDhkNGM2ZDliIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jDQo+IEBAIC00NDI1LDkgKzQ0MjUsNiBAQCBzdGF0aWMgaW50IG52bWVfc2Nhbl9uc19saXN0
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQo+ICAgCXUzMiBwcmV2ID0gMDsNCj4gICAJaW50IHJl
dCA9IDAsIGk7DQo+ICAgDQo+IC0JaWYgKG52bWVfY3RybF9saW1pdGVkX2NucyhjdHJsKSkNCj4g
LQkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiAtDQo+ICAgCW5zX2xpc3QgPSBremFsbG9jKE5WTUVf
SURFTlRJRllfREFUQV9TSVpFLCBHRlBfS0VSTkVMKTsNCj4gICAJaWYgKCFuc19saXN0KQ0KPiAg
IAkJcmV0dXJuIC1FTk9NRU07DQo+IEBAIC00NTM1LDggKzQ1MzIsMTAgQEAgc3RhdGljIHZvaWQg
bnZtZV9zY2FuX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgIAl9DQo+ICAgDQo+
ICAgCW11dGV4X2xvY2soJmN0cmwtPnNjYW5fbG9jayk7DQo+IC0JaWYgKG52bWVfc2Nhbl9uc19s
aXN0KGN0cmwpICE9IDApDQo+ICsJaWYgKG52bWVfY3RybF9saW1pdGVkX2NucyhjdHJsKSkNCj4g
ICAJCW52bWVfc2Nhbl9uc19zZXF1ZW50aWFsKGN0cmwpOw0KPiArCWVsc2UNCj4gKwkJbnZtZV9z
Y2FuX25zX2xpc3QoY3RybCk7DQo+ICAgCW11dGV4X3VubG9jaygmY3RybC0+c2Nhbl9sb2NrKTsN
Cj4gICB9DQo+ICAgDQo+IA0KDQpPdmVyYWxsIGl0IGxvb2tzIGdvb2QsIGJ1dCBJJ20gY3VyaW91
cyB0byBrbm93IHdoYXQga2luZCBvZiB0ZXN0aW5nIGlzDQpkb25lIG9uIHRoaXMgcGF0Y2ggaW4g
b3JkZXIgdG8gdmFsaWRhdGUgdGhlIGNvcnJlY3RuZXNzIG9mIHRoaXMNCnBhdGNoID8gb3IgaXQg
dGhpcyBzY2VuYXJpbyBpcyBjb3ZlcmVkIGJ5IGFueSBibGt0ZXN0cy9udm1lIGNhdGVnb3J5ID8N
Cg0KLWNrDQoNCg==

