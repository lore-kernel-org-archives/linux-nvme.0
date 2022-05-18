Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0055CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RH4IDfWGtCyfsKdgG9eqkbydAVwTKpMXSi4ougKhe6s=; b=jCkK59ex/k7Pao3iyrLibllA5K
	YjxCNDKJmhRKZvUD4J01rD4q2p29pSEYSSfRdpMXMNOSZBpe8ugHRg48aJfjS4kP5J5t8+9UknV8F
	RdINzxJuxxGgnZsgZTBMoZxtAIjFbS/Rr1oNgOXQcWec5+oodGUjYeNBbpSx7YA7EwHp3iJguilZ+
	HUHA5I49gkZd8H4vKAgNHqEE0dnkdgiw7a+oSBIegDAK0Ufex9Ja6D2RvcgRakguHusrSps9hozY0
	Ebo/sWioQZjOYCyt3qA+i60p5z2QGeTbpraPXhOdA/WNgZFFCeOjGbVqWhfueyGjj1XoY0DSXD9RM
	GPGfNLeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrMJw-002yjI-BT; Wed, 18 May 2022 16:14:44 +0000
Received: from mail-dm6nam10on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::603]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrMJu-002yid-1G
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 16:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5vx0xlS8vlPYXzTNPAP9Uy9B4BLPgHWKhwa/P57qbNwvQVSlrOf4qB86W2AwuKcdffiG/YRPFSVeK8t/wzwuLyzkVbHwt+5AT5/xRVnzwcRdhKLC5tLkQir5ghPo7MUunRYYlyJtHneDNftPP8NcbD6F9jKtHRjF9P+SQTfvFnvSrWeGWJEzgkTKQNy1If30jPoQHF4wWLGrZb3gRJaY4KziqkkcX30OVPkY/ndmfMJOh2Du3RafqhC/tQQ03t5HBJZUVQ562aI4QpgfwQfz81uwsVGxpOWU4ovFHufIriroHW3gVsLyUUT7PvzTN1c0UFn7uks0DMCw0XBS8hpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH4IDfWGtCyfsKdgG9eqkbydAVwTKpMXSi4ougKhe6s=;
 b=nwqJUZqtgjdmy1bWCHPBMEn4QCX5xEpr06Rmgzebw157H3qA76mje11YrBMtydJFe0U4fWAQPt/38xDzCgjei3dTYTWOlelT/Uj96POXepHI9WcG8nwJQc9H7Y0DYxRf5mIJCBpJBEnhGKQJl0aXcv98kXOTNOdXsLKnDr2NAi5EzqMxHCN9JKv7aLOKAZM2ui9Sgcq3tmsM7gWRHzsSoXH3ZfteCeRbpc5o3nXb4PZv5JtzjVgzoujDlF4Hbp5XrZNhl6PPtyeEQh2bhGrn6YVxpwTMupJZhDiw1TEIDGmHDHircdye9eH0tqY4PLvWePtnR9ONkNY2gCJisPtC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH4IDfWGtCyfsKdgG9eqkbydAVwTKpMXSi4ougKhe6s=;
 b=dg6eoxmttk6ZlfSL7RyMrgQwIONHcXSg5kKQImzVN3gPkT9dHajLhOWtNF4FfwIbI/6G+3WzXgteiJcLZdfToZNC73xkFBpQD1R3JmTmG7WedVDpCyqWaQgTI5CkFNi6feeVmbPq5SshriOv9kyuDzeLq/WCpR8PsPs67o14Yys3/P6/RQq6UJ4dOxAcBMp1wR0uc0cqwV8AQ4lGoPxL7z7fAWOGMfR1E+X9BPPUzA7KyWIXganwvkwFNS2MOKvmNOZM3aRGI9B7gX+zDciNYkUpYr87jzU/9JQHJPCsXJ0CIgAjh5yQ2U+c8H2ymnYC+C9a/O5/Jzla/JNG6n3cCg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR12MB1587.namprd12.prod.outlook.com (2603:10b6:405:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 16:14:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.019; Wed, 18 May 2022
 16:14:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Thread-Topic: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Thread-Index: AQHYaoJV5dfU9ZZssUa3RRjQh9Li9K0ktGKAgAAGsQCAABSlgA==
Date: Wed, 18 May 2022 16:14:37 +0000
Message-ID: <ba9454ef-20ea-2a8d-558a-e0fef33deaeb@nvidia.com>
References: <20220518064040.3223894-1-hch@lst.de>
 <YoUEf5nsyhVzeDH/@kbusch-mbp.dhcp.thefacebook.com>
 <20220518150044.GA1359@lst.de>
In-Reply-To: <20220518150044.GA1359@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55080cca-5b60-4cdc-18bc-08da38e98195
x-ms-traffictypediagnostic: BN6PR12MB1587:EE_
x-microsoft-antispam-prvs: <BN6PR12MB15878EFC6174C3BD2F5E9D01A3D19@BN6PR12MB1587.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+AR2XKmwoinGvw7Vcvbn8Zoam3gOvw+NcCbN4yTlQs5pMh18wZhQp3ft2pQm7omgH1hfVdV/VFhy8tHCoKXyorjjcbVpXQpUG0Txa6FQsHt7gHbpBSUJiMYIPMmf+7nHZE7+dDuZNiAjzyxcfk0qTDBR6BcY5T8ytQyuWhfqokG1ky6Lm+LbKUn5T+7o+tj8RERA3N0bWRfXF1NfR8WrG8z/1TaYFOXprs39oj3OfLBA6WbyDswa0lmhhwTZYYZ01bwyBheSuDh/JLMgMhsTXt+HP8XSoj7GTOt5v+uRnIxwFzVZxdXm7kkeHG2ndvNAWykl4KyZL2aJXEOTiY0fBtpolFJJuTlMHefvLgwUdYg9Osy0TMwBBlUqm7FjRh/Nndi1tBvzCZOdYIprRpOuhsigxUATvreZolvAN0jXqU5XyCQ+Z3ZqYHbPHlKxseZ7T/z14T/4PrGUHv4yGZTPVt/Wbx/dlBrIdUAx2Z8MB+X6BA4r4Ap3SRQ1fYqHBG8IDN77wnuCKLc/1KbrMfjh/0aU5fIYhsfKaI9pwaPjU1b0D52vDEIzjD86OjE0+aCimtk+YVHBJqrmUS18SpjqzWPpqJkhdKUe5UaqwB3h0Hs2/5vnrIzOzkiA2YEZ80SUo1ajN3MTqzWyTH6gcT6g09BF6vIKlTBgxbQdKx4iEAdpDCOkbc92pSwNULHf6oBvQOrd5FFpBsfjUhFpYZr8Q+0t1IvAqecBv0tVmG2+nbK1OUkTKRJ3HRTvMrvtLCJBCko/6RuUp2wEO1IHKW3GQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6512007)(91956017)(4326008)(38100700002)(54906003)(86362001)(6506007)(83380400001)(76116006)(316002)(6916009)(122000001)(71200400001)(66476007)(64756008)(66946007)(66446008)(66556008)(38070700005)(53546011)(2616005)(186003)(2906002)(31686004)(6486002)(8936002)(36756003)(508600001)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW5tUTBDSzhZYmN6MGluKzNFclhSanpuRm9MaTRtbFJETTRjVm5ORmtxZ05u?=
 =?utf-8?B?WGRGaU41OXFrUWc2TkhFVnF2RDBOcUgvSENId1BSd3B5dWZmTG5nSHZaM0Ev?=
 =?utf-8?B?NlFhZ0hya1VhUDdtRXNQLzl5R3ZKZlpDNFJKWFdkUWh5QWF3MFNzTDJUZGda?=
 =?utf-8?B?cnFNc0ZLb01XZTkxc2w5TjBuaHJaYk56clhIa2ovRXJBZ0tvZ3I4NnNmcXFp?=
 =?utf-8?B?M3BxSkl0R21YNko4NWxWazlMZjRVTzNaOXhIcE9tbkhiMXl6cGw0d2U3NUNH?=
 =?utf-8?B?RWxiRm1EWnQrQ3NMVDRqVW90U2N2RTRVT1E4RnNFYkZWM2g2NTFhck15dDBs?=
 =?utf-8?B?NGtEN1o0R0NzU21wRVAzTGlJMnM2OUpwcURzMnNCZXpLYjh3S0tpTzBacmUz?=
 =?utf-8?B?clBZOHd5c0ZvUkZidERhOWZlVEVKOW5KdTYvc0xMT3IyWU13eEoxVEltMDZu?=
 =?utf-8?B?TStHQXhSM0JqeW5rclU0OVFWZEcyRUk3OThCTzhkZlA0ZUwrRGE3dnA2T3ZB?=
 =?utf-8?B?blZTeG14WW5QT2JaRVJPRjRBcXZsU2YyNWZ5NUpQbXRvWU9KVHpiMnAvdjIr?=
 =?utf-8?B?T1kwTy9kSnJLMEMzR0M4d2pVUHFwVVFtTnVLMjZTQVNINmNyNEtYRGpYbU0v?=
 =?utf-8?B?TW5pKzZHNytweUFUV0d0a2lOWmJwOWMxdWlQSGRzcnNjdnkzOWFFSE4vL3ZP?=
 =?utf-8?B?NXpabGkxaGdMdnkyZ0NCM3E5VkV4UFhQNXRTVDAwYXEvWTdnaXYrY0hCNnJa?=
 =?utf-8?B?SGFpcFUvRy9yQlRYQjNIK3hOOUJxcW8rZ3pTNEs5aW5objI1bytBVW1EUU5w?=
 =?utf-8?B?TFB3MzcyZDUrSFVUN2cvT1U5bUU2Z0xUTTR4SGcrLzYvZy9RNUxyd2VMRHVR?=
 =?utf-8?B?djFCQUhHVnhsbnNUbk9KZ01ORDIxQzdSVmdnVlVsOVpNQllka0xkVUl0N3hT?=
 =?utf-8?B?a2xsNE43VW1RUkRsWWdabVdyaXRyTDFLaDhUOWU4anF5aU1TT0o1K0xXYXpa?=
 =?utf-8?B?UVZXTWhnbkQxS3VTcDNCUzVqUGZ3TzJUM3Q2N3NLc2Y0K1JoK1JMckp2SGlh?=
 =?utf-8?B?blhGZ2c3WDU4aVVEL3NCeHlhOWdON0JDNklDcW4xZDVwYVRKQ2dQTUVJeE1T?=
 =?utf-8?B?clJGQ3lhWmRGNkgvdk1EQ3dWRVIvVXFrSHNpOGsxaFVPMUlBYjZER1N3L2F1?=
 =?utf-8?B?ZXJ1cG5iYUo4bUx5cE5YVDljaVZCVTcwOHZ1amtRWVp3TVpCWHdxc1laZk5M?=
 =?utf-8?B?L0lDcHV3UVRvUWhad3V0bFJZRjJoTkJsZ1YyQ3JUNU9aZWE1Q2ZScVZOYlpa?=
 =?utf-8?B?RFdCNjVkbG5rQ2c0YjVOUjg5a0YvQno2clA0UlQxV1NmTjFXbUpHMHJLSnZx?=
 =?utf-8?B?bTEvcWluWmo5UzUyQTBQVGw2KzhZZHVsU29GaU5TSXhXQy9GZ1RWaHNGcUto?=
 =?utf-8?B?eS8wYThIRTJ2TTZtelBxemdtSFQ1NkhucTdSRGNpYUdnSEZEaWd4bzN1YWhJ?=
 =?utf-8?B?U2NZQ21Bb3V5QUxKY1F4c2hlSXZaQVVLd01aUHM3c3VXcnY5Z1pyTVBrRzdR?=
 =?utf-8?B?R2dwRjNIWjJFaC8veEJrdVd3SnhJd1dFZFNpUVJWTUpmZ2duTmJJYWZBMVhZ?=
 =?utf-8?B?NmdGRUw3TTFMOHg3ZVl5aU12VnJZaENpUS9uMzF1YlcyajYxNnlnbStXVFFZ?=
 =?utf-8?B?SGdGdzhvcFNQUnVaTGJoZG9lN1B5cjlLM1Jlejg1YUFXcTcyM1pweXhoQlRV?=
 =?utf-8?B?MG9NZXd1SU40cVduNEtENDBYRldGM1pnV2Z3UzBHOWxTK0lIdW1NRElkeml3?=
 =?utf-8?B?QStPeVZhWG9ZOFlmaE9HWDcyV3R6WXN1cWwrMHJERzB4a0FNZDNSdkdhVmZS?=
 =?utf-8?B?MUFkNXk1T1BFcWlOMkk0dlZiRkcwcktLMkxkWFhtaTZJaU4waUZGb3lHRHli?=
 =?utf-8?B?MnZKcXFEeHJXS0xYU2xJSVR6Wm5xWW9mN2xlUDZiLzIxU2lkSHp0ZmdlTHpl?=
 =?utf-8?B?Yit5ZVZtRDlDRGZXWS9lb1NRcE5PNjFkVmN3dkVrQ21nUnJKbU9iZWswVFVl?=
 =?utf-8?B?S0RhZHlQMHFyWXVzNW0xMTU5dFlLMGpmV3RwUEpzNzBJb1BuemxUb1A5TUls?=
 =?utf-8?B?VzZQb21OM010M3JBTFFiemh1YmZESW5iQjFaWFkydk9xb0ZLWUdidnRnMDJr?=
 =?utf-8?B?Zm5VRG4wZ1prSW5WRmdtYjNLS3BhV3FIMHNSSXJ5dlk1T29ISFg3MFlRNmU4?=
 =?utf-8?B?eFFXRkQydTRLUTV4eTJsQmVNTDNqWU9sSkkxWmRsOHljNUpZekw1MzJOVVU3?=
 =?utf-8?B?K1BFVGZWejMzd0lEV0VWNnlSOUQvekVXb3JtbCsraVo4N0YwVXRkSmo3cjdI?=
 =?utf-8?Q?eIqb5LlJjK2wbvaATi3q+eMyJYAMe6tTqVaYFOhL++fCO?=
x-ms-exchange-antispam-messagedata-1: aY0TJXYRaMjh/g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E33C4A70915AE41974039F3E613F75C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55080cca-5b60-4cdc-18bc-08da38e98195
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 16:14:37.8289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kh61TScX9E8inDf15NrqmB7RFGGNQsDmb+FyCyciPVG9bx1mqzOE1AmlHx3AviT2orm/zFnr5MhXug96hCG8BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1587
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_091442_118127_D0FF70B9 
X-CRM114-Status: GOOD (  23.05  )
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

T24gNS8xOC8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwgTWF5
IDE4LCAyMDIyIGF0IDA4OjM2OjQ3QU0gLTA2MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4gT24g
V2VkLCBNYXkgMTgsIDIwMjIgYXQgMDg6NDA6NDBBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcg
d3JvdGU6DQo+Pj4gK3N0YXRpYyBpbnQgbnZtZV9pZGVudGlmeV9uc19jc19pbmRlcChzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLA0KPj4+ICsJCQlzdHJ1Y3QgbnZtZV9pZF9u
c19jc19pbmRlcCAqKmlkKQ0KPj4+ICt7DQo+Pj4gKwlzdHJ1Y3QgbnZtZV9jb21tYW5kIGMgPSB7
DQo+Pj4gKwkJLmlkZW50aWZ5Lm9wY29kZQk9IG52bWVfYWRtaW5faWRlbnRpZnksDQo+Pj4gKwkJ
LmlkZW50aWZ5Lm5zaWQJCT0gY3B1X3RvX2xlMzIobnNpZCksDQo+Pj4gKwkJLmlkZW50aWZ5LmNu
cwkJPSBOVk1FX0lEX0NOU19OU19DU19JTkRFUCwNCj4+PiArCX07DQo+Pj4gKwlpbnQgZXJyb3I7
DQo+Pg0KPj4gRXZlcnkgb3RoZXIgcGxhY2UgaW4gdGhpcyBkcml2ZXIgY2FsbHMgdGhpcyB2YWx1
ZSAncmV0Jy4NCj4gDQo+IEV4Y2VwdCBmb3IgbnZtZV9pZGVudGlmeV9ucywgd2hlcmUgSSBjb3Bp
ZWQgaXQgZnJvbSA6KQ0KPiANCj4gQnV0IEkgY2FuIGNoYW5nZSBpdCB0byByZXQuDQoNCnRoYXQn
ZCBiZSBncmVhdC4NCg0KWy4uLl0NCg0KPiANCj4gLS0tDQo+ICBGcm9tIDAzMmI4YTgwM2JmNWJl
YzRjNGYyMDZkOWNjNWE0YjExNjBlMGRjNjkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+IEZy
b206IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBEYXRlOiBNb24sIDE2IE1heSAy
MDIyIDE1OjA5OjIxICswMjAwDQo+IFN1YmplY3Q6IG52bWU6IGFkZCBzdXBwb3J0IGZvciBUUDQw
ODQgLSBUaW1lLXRvLVJlYWR5IEVuaGFuY2VtZW50cw0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIHVz
aW5nIGxvbmdlciB0aW1lb3V0cyBkdXJpbmcgY29udHJvbGxlciBpbml0aWFsaXphdGlvbg0KPiBh
bmQgbGV0dGluZyB0aGUgY29udHJvbGxlciBjb21lIHVwIHdpdGggbmFtZXNwYWNlcyB0aGF0IGFy
ZSBub3QgcmVhZHkNCj4gZm9yIEkvTyB5ZXQuICBXZSBza2lwIHRoZXNlIG5vdCByZWFkeSBuYW1l
c3BhY2VzIGR1cmluZyBzY2FubmluZyBhbmQNCj4gb25seSBicmluZyB0aGVtIG9ubGluZSBvbmNl
IGFub3RlciBzY2FuIGlzIGtpY2tlZCBvZmYgYnkgdGhlIEFFTiB0aGF0DQo+IGlzIHNldCB3aGVu
IHRoZSBOUkRZIGJpdCBnZXRzIHNldCBpbiB0aGUgIEkvTyBDb21tYW5kIFNldCBJbmRlcGVuZGVu
dA0KPiBJZGVudGlmeSBOYW1lc3BhY2UgRGF0YSBTdHJ1Y3R1cmUuICAgVGhpcyBhc3luY2hyb25v
dXMgcHJvYmluZyBhdm9pZHMNCj4gYmxvY2tpbmcgdGhlIGtlcm5lbCBib290IHdoZW4gY29udHJv
bGxlcnMgdGFrZSBhIHZlcnkgbG9uZyB0aW1lIHRvDQo+IHJlY292ZXIgYWZ0ZXIgdW5jbGVhbiBz
aHV0ZG93bnMgKHVwIHRvIG1pbnV0ZXMpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQoNClRoYW5rcyBmb3Igbm90IGFkZGluZyBh
IG5ldyBtZW1iZXIgdG8gbnZtZV9jdHJsIGFueSBuZXcgbWVtYmVyLg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==

