Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D925C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 07:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBdgVeR+6mEb5wT/nW6XKcFBLZmQBjXYATh+SHlwTCQ=; b=QE5VTfUYJW0zjowi3A86DkvaXT
	whETkVQA+E+E6fuB3Oi+RdT0yw1s9mS8ULEsk22r6pPx0AfzHBDvACakqwcmbmv4/lylFHfhne1DX
	OzKQnpCDOcXaN8f8DQzlJAvC5EJqWo1uNI+46vqrmFSfe8U8QnBSutKzcRTYuN/92dynhiI7i4ymL
	2jmNaPhjYKi5MG4CJQ32quVxRbjKe4u+KKx+FVe2LOwkktHwSjr4ro1EKY+ruJ7LFIDGi+mQjaVlC
	mMxey8yx0hW+BjQGe4bX+yCif1Ir2XNtrVMliVQTVJLrkTGFk0ylFkhmmF0C8NOfj6A2c6SoH9RSy
	LrbbMalQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwg9c-008B4m-90; Mon, 13 Dec 2021 07:53:48 +0000
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com
 ([40.107.243.81] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwg9P-008B1a-AK
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 07:53:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYZMcfik2Hl6pNUeSEnz7ZnOsTghlUDDcwUGI9Rcv0xHpf6O3+L3c0g/ormWNBYAu0bJnqpP9Bt8l/omap97F0Q19WfwALafChBNRD6EHdU+5PNAxHyxGj7pioCYPjMk/xt+FC7MVHBKBmUJP8dqpauUA3zssjuq5Cvokg6eR/bXe35kz0QBg5brWllm1CJyWx+J3+gfgmcoqQnMys8cFc0+AWhmt5EQJ9NQVTEtXAKPYgtKk3QIchwC5K8x8bpiuGUk7Ufa9mUpjAI4dlk/bLuqlFYw0HYygRqwsrV2Xmk4DYXhWIi3CfCnJDL4uwWVgJ3WzrgNiJkt68wAmv+pqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBdgVeR+6mEb5wT/nW6XKcFBLZmQBjXYATh+SHlwTCQ=;
 b=UuZ/HB7wEXC/kqEKih/3NgFlC2My2B1/J3f2NXoCop05l4CIBiXMMmoCVKmXPeEQou0VRzvo/phsozv4PsW+G+IW9+sIi+2BlIqyYxisre6y3UaZ3z2vxiGKnjwJxFb8pDs/KsInFsl0JTUlpDzCXS7WT6kaHhBu3Hnep0cT87cCtJq6eVQBwL+C3D69trmIDtm1Z9pUda2hGllU+826lWdN/fWb0EhCr2LwtvV3WKh4ITjSMl/VTLwHIdyyjxeZQRG3Oj/f6ngmT+XyNKWVn1KLAtk9kfYjDxIN9BDK65y7/zgUlPsfszPA3I4Z27nlZYi4SvMI8ConSyLovyQIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBdgVeR+6mEb5wT/nW6XKcFBLZmQBjXYATh+SHlwTCQ=;
 b=b5MdNnmUApqtRjXNx2w6JkhTRj4XGlE6QravhqsO8A5RJhDe2+iuZ+QzNReNRfl0lNKdbO+6gINGZJHhKwNfJSPH73YNoECl/Uur4arYzaIgjYxwGnTh669xf2ZA23QjBnpj6Y29XCCtb9B/eVkgVZQJe5OSaOu/ZFaHKOyMh76dFVwUazJRI20AFJat7pj9Q4ZsGGeU/nwDtAca0kEX4B1cy2KHV4yzqKUREYB50UBRsPXO4iJ2KfRAG6XMpos7mP1E3wBvHAuP0rnxVatuYvkxT8unFyUyuITY4hRiZf8D0HmGZk4E4z8ziI+hvpx0IDwPUdvv6hAvV2UgmI++sg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1583.namprd12.prod.outlook.com (2603:10b6:301:11::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 07:53:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 07:53:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>, "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH V2 3/5] nvme-cli: Adds readable firmware level in
 persistent
Thread-Topic: [PATCH V2 3/5] nvme-cli: Adds readable firmware level in
 persistent
Thread-Index: AQHX3KnsY1oXJL5r4kKKBK47PSnqYKwwM7EA
Date: Mon, 13 Dec 2021 07:53:26 +0000
Message-ID: <9beaf7a1-5649-7823-63cb-7d8fd7cb02b7@nvidia.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
 <1637254648-19500-4-git-send-email-wenxiong@linux.ibm.com>
In-Reply-To: <1637254648-19500-4-git-send-email-wenxiong@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17af7356-fedc-4b8c-d2bc-08d9be0da538
x-ms-traffictypediagnostic: MWHPR12MB1583:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1583BCD6BF944EF4F5EB42FEA3749@MWHPR12MB1583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTwkxA7lVmKTiX6TBuxf9z+YqOO1naFUhwQEsEOrj8x2kw8LZy1XSAib9vZ0jcvOSSe9wCkKYdDt1YSzKXQLH+rDue8somkxVCr0Bwcdu8DLIH3Pq7j0DPsftKe1JK2EOdYPb6Yhr544t19HvxfNWBb9OCf7TRNTNtitzUSS/pKvB36rrq5ZoVYPzIXh12VcQY16yR10LdR9vrjX9IwMv5ZBRjSJFoQIcAACY+qUht8I9XUN6kuv+DqtHcR5/BVDedyS+PNKO1V5rdfTCfpLTtVFBHku0ze0/WZc4zYNPq5mi2EpSxauI78AGr5ezCB9TQQhOYK3Di3iN1B7yhuPQmyK+9Twl2/BQh8zu5PlQJ4RD4yONkhDLP7r2M81feG0V6XThfYBH6TTdb7W0DtKg/jM4dms1F7eVlUNViUj2sSXH2me2PJo6/i74tOUwRvR3hziojI2mH1jW8d1vR5roQmnK0hh+RJgqn7w1pcopm37XpQAyIoj/yq09oBkQG+Mz6caY76sOf1xvsDWDr2+K4GG8qEGo2BykvnvM6IVsV5TxOnnzXucKZm339Cn7g12T24HO6/1zMMarRBZ8LcEKQWdZ1i1ySGbzOha5KAMJrWn/mH7AfCxUxVEi/dIj1SaKRoJNZjWxAbwZHBvrVJ6LmpemE27FFGSdoTX0/s/pobw/vZLQGL5QIanbFSpjJO7gn1AcdqgWw2NckAATS1Hqpq96P4H71B0PXs1j7Tht7k39PovYu8mNCib8CId6N8stn3G8gbxMkbQzKP8LsdugQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(186003)(8676002)(66946007)(66476007)(8936002)(91956017)(86362001)(122000001)(5660300002)(31696002)(66556008)(31686004)(66446008)(4326008)(76116006)(6916009)(2906002)(54906003)(6512007)(508600001)(4744005)(38100700002)(38070700005)(6486002)(6506007)(36756003)(53546011)(316002)(64756008)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzAwaHUyMlhLczJLUlUvT25oRE5tSFBra3pZcW1xc0JwOTRuQzdVaWsxcEJK?=
 =?utf-8?B?N1RlSUlpWnJNRVJiNG85YUs4azhoSVBBeHJwVUp0S3BKYXRrQjZRVTExSXdG?=
 =?utf-8?B?YlAvRVExdFlsT3BRUWJBLzNNRWcyUzBpK2pqODVvOUdTVnExa05aRkhvR1RV?=
 =?utf-8?B?OFlOWDY5MkdlcjRFQUY3bU43eHZGSlVtRS9XUWtsR1pwQ3RBUjhiQnU5SXh3?=
 =?utf-8?B?TzQwYzlRT3BtL2NJWG1GUW8rYWRiVVRqd2xpRXdGQVNUV2RjRDhVY2tnc3lG?=
 =?utf-8?B?MGhLSFhZdkZxTGdnelV0T0wwOTV0WGNGT2lhUzhyUVdzSTVIM20xTGt3WHpV?=
 =?utf-8?B?SHFxUHEzUkpjMVFrT2RDeVFqNkh1eUdSOFFjS2hjK091djYwWGliem5SMGg3?=
 =?utf-8?B?bktMZG53T3JuQndxYkMzUk05WC9Gdi9XUGZjWlkvNFF5bkRkN29hb3lDelZZ?=
 =?utf-8?B?blM0ZlRUVHZPRk5ZVFlwaFNCdTgvYVdKZTFJL3N4UVdyMjdDYVp6T2tzcExI?=
 =?utf-8?B?aFZNUWkrMnVnNVQ5OUZINU9KNUs2TkYzdTFUR3FSYTkvc2MvVi9IbTgzNVNX?=
 =?utf-8?B?UXhCYjU4eFlTdUNldVVHc2s3YzNwMVRkbG14WG1HTkxrQ0ZkS005MnhmOXZX?=
 =?utf-8?B?anVxQW1lWHBSVWdFRmQyVmUvN080UHZpRy9jUlF6RGV0UGNndTJZOFRQVEdo?=
 =?utf-8?B?ODIyQXZiQkVnQm1OR0lPQ2E5cVFMRVBrbWM4aFhKSzUxR0dzREV0cTZqWnR4?=
 =?utf-8?B?MEtqcTU1b3NreGtVSzJ0WC90YTZyM3A2N3NJWGNNVXR0Vk9aSG9obklHWlY2?=
 =?utf-8?B?RkRLaFNDc002YXJ5YjFDU0I2UE40RUZ6RkJYdGVsU2RJSlltVGhRaEpURWxl?=
 =?utf-8?B?TURFcmlJKzRqVXNOK0x5cGFFSlZUMEgxV3p1YWwvdy9pUWN5bzA0dTEzc2Yr?=
 =?utf-8?B?aExuTXdCWUJRbzJmaEI5bXorMzJYTGNPS0N5R24yUGlrZWRtMW53d1R4dDJI?=
 =?utf-8?B?SDl0ZzZCNGRGYTd5cVY5OFdGd1RhdW9mTE9EZUV2RlNpaysxaytBNGFqbTc3?=
 =?utf-8?B?WHpUdURQdG5EK3pTa296NEFBYWRsL0d5T29rYzZYcCtBV2tzNkx4OHo2S2lZ?=
 =?utf-8?B?MGVvWktHcW1GdEZtbU1rcFZxSFpwRmJjdG90QkxxQXdUWkEzaFgzVk00RVdJ?=
 =?utf-8?B?ZVlsTWprb1VZcklrU1I3WmtoYWIvUldiRmJHMkR0N3ZYdVlJTWhGTUpxUmtS?=
 =?utf-8?B?V2RzRExXTTllaUtQZXlFZDVOL01rbG1EeWRva3NOZ003dVdwMEVRSnhMZUNs?=
 =?utf-8?B?THppdXB1SjVIb3pjN3BHdWdMdUFWUjFhSTdZdStaTFV2OERyeVpFTDRxZUc5?=
 =?utf-8?B?NHY0UmlUck1MekFNRExpRVUxTVVUNFowdXY2RHlMMVcxMVdFTDA3MkNDcnFy?=
 =?utf-8?B?SjhOWmRTMXc1eEdzdFhITGJRYlI3TTQ2WDRFVGdmVzAybU1BS2Fad3VRK0pk?=
 =?utf-8?B?bHFJT0RjNlZxVFhlbHJYMDFoVWNsYnQxSjBRTkRUNnAyaVBMdFVjZjZiVDNL?=
 =?utf-8?B?Y213NzRkS1RHMmxNRXR3ZGJ4Z3A3b3NSekJwVkVzcnp6TVRlVTdFR3ppS3NZ?=
 =?utf-8?B?OEZNMVcyaHgzTDZmSmwrLzZPTDFTOXFjM2UxdUhtTGl1ek5WdEFyaDU5NERP?=
 =?utf-8?B?cHJkZWdZTzVSRzM5SVBkYkxNaG1tbHczdU1iZ3VtemhrdTllZUhzVlhnaFYx?=
 =?utf-8?B?T1JsU2xUVGpBTkJxT1h1MGtuc2Ziam1EWnF5anBoRFNNK0FBTDV3dVRxeU5W?=
 =?utf-8?B?Z3AwcmZRUVJ4M3RYMHpsSW5jKytPcXpLZmg2RytQVC9xb29kVHRsYU1ZSUdT?=
 =?utf-8?B?UE5XeGQxZGh4c3VZOENXRHhpU1VrSWZYcXZnKzZGQWx0SXluUWt6ZVdVU2pm?=
 =?utf-8?B?QVlMZnJLYjVqaGFWNVg5djBHaUFFM2d1US96Lzl1MUh4NC9DVlBXU3hxQkI5?=
 =?utf-8?B?alNxbThIdDFUUldGZVkwM3hNUkU2QUdvSHlCeDkwZmlocnErT01zbCtDVHF2?=
 =?utf-8?B?QkRHOEplR3NDNWY1R0hyMjBhZFNBU0c0dVZyMUpELzVyZnFjS1pUVkZWeHBQ?=
 =?utf-8?B?S3ZJRldETXpSeFFIc2dhd0ZnRHF6L3hVQmI0akNlZjc2MTBQenNnSlFyMk14?=
 =?utf-8?Q?QMOiq19OnGHJWVgAaYUNjO/nrKZdWBgeYNpPsDDubDT2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCA058AC9650604D89EA57B61A73D8B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17af7356-fedc-4b8c-d2bc-08d9be0da538
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:53:26.4793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Oa3XlvcVcQKPzueD0+fvvei2pyRCd/KuyKnUqOZcHjHkgrmOAwekYoAm6C9G04b9lB8iVKoQz1I1uw11PK3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1583
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_235335_434386_89BB2A0F 
X-CRM114-Status: UNSURE (   9.74  )
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

T24gMTEvMTgvMjEgODo1NyBBTSwgd2VueGlvbmdAbGludXguaWJtLmNvbSB3cm90ZToNCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBGcm9tOiBXZW4gWGlvbmcgPHdlbnhpb25nQGxpbnV4LmlibS5jb20+DQo+IA0KPiBG
b3IgZXhhbXBsZSwgSW4gRmlybXdhcmUgQ29tbWl0IEV2ZW50Og0KPiANCj4gT2xkIEZpcm13YXJl
IFJldmlzaW9uOiAzNjE3NjA0NzE4ODc1MjY0MzM4DQo+IE5ldyBGaXJtd2FyZSBSZXZpc2lvbjog
MzgzMzc3NzUwMDk4OTA0ODE0Ng0KPiANCj4gY2hhbmdlcyB0bw0KPiANCj4gT2xkIEZpcm13YXJl
IFJldmlzaW9uOiAzNjE3NjA0NzE4ODc1MjY0MzM4IChSRVYuU1A0MikNCj4gTmV3IEZpcm13YXJl
IFJldmlzaW9uOiAzODMzNzc3NTAwOTg5MDQ4MTQ2IChSRVYuU1A0NSkNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFdlbiBYaW9uZyA8d2VueGlvbmdAbGludXguaWJtLmNvbQ0KPg0KDQpUaGlzIHBhdGNo
IGxvb2tzIHVzZWZ1bCB0byBtZSwgYnV0IHRoZSBjb21taXQgbG9nIGRvZXNuJ3QNCmZvbGxvdyB0
aGUgc3R5bGUgdGhhdCB3ZSBoYXZlIGluIHRoZSBnaXQuIFBsZWFzZSBoYXZlIGEgbG9vay4NCg0K
DQo=

