Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342C0C072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 22:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M08nwUvZrpkiAXrGSXz1SnnK0oKr5wivbcHcajzcaOk=; b=wugYVUfb217zxvqXtR9ZSdfQ23
	UDA6Nm3tMExVv6cXMTmonsqr0aY8gwc2QKmryupHVePd8jrC3X9dr5pvJuw+m2h3iBTjEd35RGjOP
	Hw/GQQbI2dT/6mymW7I2JAIpBn4bcBqsUkJ+k8fJ/z9zRS95LQOSMKGuPCYoMDq7cuG8uXqgx0oIH
	V0ywUjLSJGGQ0V6UQKBuOO3NPBlO6YMTtJSL2xXNYJG6tm2z+I133Fl5NeNjoJN6aSKpeXEKEztI0
	inYuHLyQjnrLxkkYoatQOtcAleTS5k9kExPQujx7PVwWVXcwHSCrcc7cWL5aEZLVgPqTRQcmWgHAb
	Pr4utWOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r47oK-007VsP-0m;
	Fri, 17 Nov 2023 22:59:40 +0000
Received: from mail-bn8nam12on2060c.outbound.protection.outlook.com ([2a01:111:f400:fe5b::60c] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r47oI-007Vrf-07
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 22:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPZNyLLemEKN1SJBvFtN4904QUNAVUabB8l8uMlDgoFiRFfotsULwSLL4p2ND5bEdKhotleK/N7ZJGM0Kye5WBb096bDLqwAcNFk9eotrFaVEiRc0qsjv0oLOEdX1+WFXXyXHWIg37LUep402DFShnDpdkauaIjL4mgat3dWAqGck1t03hiW37efoAQh/PmKNaPj/5U9qgtu75P63IuNhuOoX+qNrkPVBeECVQ2PhI6yiaREWMdDA6TKGngkMcWZl4rBP304i9PmcRcnGg7HlCpPzrgMCh4CKkHXS25z6t4lSnlkpXWDwF9VWT4ZdIPH2O/WOgQ9Jd+uE/j6/BMnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M08nwUvZrpkiAXrGSXz1SnnK0oKr5wivbcHcajzcaOk=;
 b=kLIUPeZaO2cEpPDxJJlNwWQDRtBlzaJMNqpyJb0q4w9QEcga4S2ZD70XgsFwoM+ZLdo2iAPbX98zd/i6xYftz0I0aF0H78OkkjcLSu4slkC6IwNHeU9/v1VsoQ4aj7q6X14bUX1oTuYgBz7W17HuJjfQheohe37eIGlMgxA2KMrt1L7FE6xK748g6WV+1STTsxT6gqkQn0NPfaDGn3POLwyitz3XNd/Ewlnt8Q8dkyHrxSmcnxfDjgh6ylKl2Veti1lNIIrjlXrHYfH7vU+OLxxwo2jo+bTrMDQ6zAXPqWN5+R38M0FhsfLI7eu4nRxPCJJ8b7WJOJ2HpLqoiHm7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M08nwUvZrpkiAXrGSXz1SnnK0oKr5wivbcHcajzcaOk=;
 b=I0iYjHBDd52KIhlFU7d2nYVP7SdMGlOP4BLJs7HbvDckyFKMH0OeAkKnVTJ92CiJ7GksxHCjYjzQy+7+OXbuaGbFVZcJFqqfX+TfHBO3BrNHkfYGslroCSNyOeIl4FoFfkHJHjV+pBCO/uL93fyGMcFf2ghLbbZ0LEC0kf6ZltgvVRLWWynjWv0W9OFgDIpBqJjIjLjEKxGk1V+2et5vowj940EbIzUwQe4/BLXJNw2E6zydf5WwlBi8ICyfAI2HUTo3moFW7FSJ+ZmSKPlngFg/cTVgj8EimImBXnPzklD/kh7W7kyDYebOQ57OcAqHUg5reSMRa0oJEca6eTlE6w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 22:59:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 22:59:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "zahavi.alon@gmail.com"
	<zahavi.alon@gmail.com>, Christoph Hellwig <hch@lst.de>,
	"csander@purestorage.com" <csander@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet: nul-terminate the NQNs passed in the connect
 command
Thread-Topic: [PATCH v2] nvmet: nul-terminate the NQNs passed in the connect
 command
Thread-Index: AQHaGVgHt7i2QY7E2kCMQMDad28zObB+uzeAgABligA=
Date: Fri, 17 Nov 2023 22:59:29 +0000
Message-ID: <2ba5066c-18cf-44dc-a74d-5934a06889fe@nvidia.com>
References: <20231117131336.126505-1-hch@lst.de>
 <ZVebJdEkFRnwdRZW@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZVebJdEkFRnwdRZW@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4511:EE_
x-ms-office365-filtering-correlation-id: 1fba3863-b91c-45b7-315e-08dbe7c0db08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRP2XwJUiA0yNOg4b9WUofAHLtkX0/tP9t1ocd4VP0qFnf0Qh/sOnb4/T6tOT/QY426nE1YDAF4pQBkr/IN5PDkRRyUP1oh30sM2+hU3bT/OFKwZC5sPKTOjRztBrktRpFitGwn0IV4z9ZBJEkRx3FKry4KuU4Qi+frNb6svd6dA45aS1KjwXPKLFiGUg8cKz2p3S2rxwjJP8POqLlS6T4xf5F0QnO7EP2SULMcRTXk4pt4URHx2fFH3UdnoqHCLB651AC5IqLs9mRpF5nV01c28R8OWoV155T+BsJPQ5ohvqqWqtYShVN1LB+3zYmRgm1C/K+aAz4K6Vvq5dEA67HP9uv+yeDWbL4QRPOgbAs+ewaapQGG1xDsKA+CkchBHUBNbA3tz7gD3ZmquvxzzoxgMzCUrnmg68g3XnQtpHcvCsL+uNAgsXPyBU5bZwDx/DClKywimrszs8SpxjxkhVZsWIIVNGdidNfGSDszs51Y2JQjD3vjPnAKTqNVUzkD6UbRUCQwK5+KsfAYv0VQ0W4hQvbzmgiv+5JuUYD3g1JdZbY65eH4U8+rwzj25A0/J8vkSgK8yMepQgdnE6Isuh8nfJAHeggPOttkdJitNz17VLehWYtgFhgWOowo9qz9kMUj96POaCUAtUiwNlNo8FeJIfcv5u6s6+Et6hLKeTzBu8Az1mbUYWGEuqXZKmUhc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(8936002)(4326008)(8676002)(38100700002)(86362001)(5660300002)(6916009)(71200400001)(2616005)(76116006)(66946007)(66556008)(66476007)(478600001)(316002)(31696002)(31686004)(122000001)(4744005)(2906002)(64756008)(66446008)(54906003)(41300700001)(36756003)(6486002)(91956017)(6512007)(53546011)(38070700009)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFZXbWZ3YXYzUC9EQTVZSE5WSWlDOGgrY1hZdU9KZDk0Wm8zTFhGZU1Tbmdw?=
 =?utf-8?B?QjdudUdkWFUyYVU5RWVPc1l2czB4aTZ1NkNRWkVnZFNxWDJ2VWJUK3lyUk0v?=
 =?utf-8?B?cUNpSFhCWUdUcEF2b2s2RXpnTXB0OUlhNDQrME15bHZ5VW5XOWc5MzBLZUY2?=
 =?utf-8?B?L1ArdDFsOWRGUjI4MTlYN0RGcjZpVUEydUZzV2NCQytIMGlsOUpYUTBmelpS?=
 =?utf-8?B?RUZmWUtoK2U2NDRTV0lKMEZoeUg2VWdyVzZVdmxJYTBBUjZuUE43bFFTYzAy?=
 =?utf-8?B?SE8vR3NjMVIycDBVV3F0NUJQN3c1Y1RuWm42b2JJM2tLVWdqS1ZHY2I4eXkz?=
 =?utf-8?B?R1JOaVgvZjRXR2lkNmRPeFRhS1dnV0puZWlqbkl4NU0xcS81Y1N1WFozV1hX?=
 =?utf-8?B?eVJPcGQ5QjJURVc0cGVFMkNDN0grampMd0lyTHp4NG9saUl1Q0JLb3lFcUtZ?=
 =?utf-8?B?YTZtRXNPQ0U5U1BKL0dzZDZ6Skt3WXhET2ZjRXl6MUNCQS9oYkFuN2RQOFpH?=
 =?utf-8?B?dUZHb1NsRndLQVc3aVlpZTJ1d0pDdTBvTkZkeDRvVkMvT0tmcmNjODRJaks2?=
 =?utf-8?B?S3ZCNGFZUE9Odi94bDNwNGMzNHp4UEg2cE0xeVBhREYxeEo4WFl6eWdJdGwz?=
 =?utf-8?B?TDZTV1luR0VRYXZ5NHJyT0czdU5PRE1Zem4rNjIxRUl3UDhiMlIyQ09nYmR6?=
 =?utf-8?B?eXVZT1hKOEh3L0tUOXhSVTRYemU0VHVoeG15VnNKZVhRKy9tVzVZUjY3Ukps?=
 =?utf-8?B?T0lRKzZ1ZHl6U3pjR0owcjNLalozUnEwQzlzQkZYREFOcnl6VFRTMjU2aHhq?=
 =?utf-8?B?VThhNnFTTEtCTkpiSkg4VHYrVUxKeU4xbWVSS2UwVWcyaXZhY1N1ekhkc3Fu?=
 =?utf-8?B?RWtRSk8vcjBPWm1OMXZUa3d3S2pxWkFaSWU5UnJnazhsZmRrY1FjRWZ5bGJo?=
 =?utf-8?B?Zk1qeFVtR1NwZ0l2ZDh6ditlY2tkR1VUQm9RUFJCOUR2djV5ZDQ5Y1M5emY1?=
 =?utf-8?B?M0xhMVVQMDQyTUNLNnBmdHJoZHQ4TkFvdmlNT1NYTlNPZlhHZlM5eGhTV1hU?=
 =?utf-8?B?UFdnd041V3B5aUJNVVoxNkVFaEpueHVrV1B6c0hIMVlTNEVJZng1VGdHakky?=
 =?utf-8?B?Y2U3eGRTM3hRTG0zK0QyR0RXNFQ4TzBPTElkbnZERHVoZ0dCYlZpWVpONFli?=
 =?utf-8?B?RlkvU2E0YzZoclAvc3Jhd0s3MkRlbFNBbTZBZndpT2VlV3lmbC9GOTNOMWN2?=
 =?utf-8?B?L2Y2Z1Q1cDlNSTBsdDNpRGMxSnVUQmxGcnNiK1FkYnA5U3RRdmxBYVRwZE00?=
 =?utf-8?B?SWdBQ0pWOExXYVpuR2pxdlFOdXNjZURGbC83MW8vK2Q4bUJQS2lhWVNSSVNt?=
 =?utf-8?B?dy9BYmRnTUFjaFdKc0dhSVMwRXVSMkl4eFpoa3FCN3EvUWR0NnpUNDE2ZDIz?=
 =?utf-8?B?ZzUrZlJaeXIrQksyRTNXTEVaclQ0a242U3c4cWxkbSt3d3RWN3ZERTBNNHRK?=
 =?utf-8?B?Um9USDRadmdkUWsrWGIzcm9ZYzN0aFE4QzN6VTZpYUFnQnNUa0xxOURvZUJJ?=
 =?utf-8?B?RjVHS1U1Y3lvcUw0clJ6TmNTYXovYXMzZC9mK244RmNPRGFyT1dmOGw3TGRH?=
 =?utf-8?B?TlZxWExSaXM0UCtJN3hJRm1hMHBvdUtRSUpDcVRmMDVKeFlWQzRzbXNET2dO?=
 =?utf-8?B?ek1kRkNCY1c2NDJjSFhqY3E4ZkYreXBNNDliMzZYU0dlVnIyamptMGZobXMx?=
 =?utf-8?B?SjZLRTdxcmlJRzc1dCt2SGFQUHVDaWpBdEdsNmFFYytVc25paFd1dU8yL1A1?=
 =?utf-8?B?cDFVc2plS3FrRVhBUkVkanJWWjlCQ3YvNW5uU0tQbzVXUnc5ZndBSTIwbXpm?=
 =?utf-8?B?aXJ5MXAwbjFSSGU0SmFDMkw3Z3VFYzZaeGx0eUgrSVRPM0JJRXlPZzRtOXRy?=
 =?utf-8?B?dDdibWp6eFBxYTB4SWNVYlFIS3NQSk80MUcrU3JFK2pkR09OeXkzb0RBdzF2?=
 =?utf-8?B?dENOZzJaOWVESkM5WDJDT1hDV2R1NGFoVzRHWE9RWkd0KzlQd1dsVFlRN1FI?=
 =?utf-8?B?QjhjQmRHNitJNzhYeERtNlFCQXd5MzQvN2J3WjE3TlVSRjFDRHhWNngwZnk4?=
 =?utf-8?B?VFp2c3lDdHk3b2IvN25vZTBHd3A1Qlh5R0x0R2lvUml5QXhRVzI4RHd0YnBE?=
 =?utf-8?Q?KRI9VRkuMwpziZjtPsP1o8vYXr312Jdw3TF3Io2YRana?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6B3353525EDD64781E411FBEEC9409F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fba3863-b91c-45b7-315e-08dbe7c0db08
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 22:59:29.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NImy3c5tkv+2UZ340pmUNwgEAqjMwIcMCxR7nQoMq3kdtwKz81o4tugz5hwJpvitrdfvjXO6oInyIzFnYfLBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_145938_083334_4CE43439 
X-CRM114-Status: GOOD (  12.10  )
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

T24gMTEvMTcvMjAyMyA4OjU2IEFNLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gRnJpLCBOb3Yg
MTcsIDIwMjMgYXQgMDg6MTM6MzZBTSAtMDUwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+
PiBUaGUgaG9zdCBhbmQgc3Vic3lzdGVtIE5RTnMgYXJlIHBhc3NlZCBpbiB0aGUgY29ubmVjdCBj
b21tYW5kIHBheWxvYWQgYW5kDQo+PiBpbnRlcnByZXRlZCBhcyBudWwtdGVybWluYXRlZCBzdHJp
bmdzLiAgRW5zdXJlIHRoZXkgYWN0dWFsbHkgYXJlDQo+PiBudWwtdGVybWluYXRlZCBiZWZvcmUg
dXNpbmcgdGhlbS4NCj4+DQo+PiBGaXhlczogYTA3YjQ5NzBmNDY0ICJudm1ldDogYWRkIGEgZ2Vu
ZXJpYyBOVk1lIHRhcmdldCIpDQo+PiBSZXBvcnRlZC1ieTogQWxvbiBaYWhhdmkgPHphaGF2aS5h
bG9uQGdtYWlsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPg0KPiANCj4gQXBwbGllZCBmb3IgbnZtZS02LjcsIHRoYW5rcyENCj4gDQoNCmlmIHRo
aXMgaXMgb24gdGhlIHRvcCBvZiB0aGUgdHJlZSBjYW4geW91IHBsZWFzZSBhZGQgbXkNCnJldmll
d2VkLWJ5IHRhZyBwb3N0ZWQgZWFybGllciA/DQoNCi1jaw0KDQoNCg==

