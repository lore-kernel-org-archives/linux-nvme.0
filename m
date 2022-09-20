Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CCFC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P0a9Y8q1WApa0dCX63P+WmS1WN+fBvAyCF4Do7pYxQ0=; b=bXYVmdbkeV9ns5WSFFfWvNV7O7
	heAgbbxkuqvz/iWAx/O82DffcUJahUrSaKr7pPVN5r1Oo5cItAT/dShCCmNWeGvVX3c00nIsm0x2F
	35hi5repzpyaw1O1MxW+rBFD4Az1wV0igjtUa2b8tXyLEL/YVRD6zPhLGef6Aa0Wlfc8vyWR/iYLp
	988kLTbroqxwgsnde6EqwuN8ArhyLkha77vlXXlpC6KrSpYUoscm3d6iE9m1qwZZ8qcJxFYjsHwae
	33zPcX5aNCD1GFRfkXZIrZTEYEZ97YPTpJoSfId18LqkQlZ0V38Wq18YLILaByRLgzrKnpSydAoCD
	VQFN1y0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal1M-007AGJ-B2; Tue, 20 Sep 2022 21:43:12 +0000
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal1J-007ACW-Gt
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:43:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5XRLO2NzUJvtzgbKshjaDp+NT9R6LjnYBh7sC0oSFcJ51CUfeItaBe07X4LlXpGfAbXF3w3jGjij0wMiGwS70QSnaMNbcZZQdexzD9H91hY1CTvjuEHzTt0WzQNWL7tBKniEjqEkEF2lR6gxeHPFLfMr/e0VVrxbfGRhVUYceMzBd3spt20Eq7vvY5e4LF1BF0U0g9sXhQk1NE/IbACn6WevgNKpCG1wIuVkCi5W5o64yhgcPXjaSZG43wJE1teLGiid5VRtHqppqHxc7ZeV3nORPh1AeWoJVzvQnws8BoSObrDC8voUjtGPgqbEEVGcoWV80AaOMYLJgKc9PMd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0a9Y8q1WApa0dCX63P+WmS1WN+fBvAyCF4Do7pYxQ0=;
 b=debIq7BXRFNMYw9nTiXTHi5nIZWFaIJ6WgwO0hiITP3OZjbWqRu5SAKvTVu6MneHgLaytZS61Ggx/IkkdkQ8XG6HhwdA/7YRQB7NSW9eGkI7nvW0LlDprKggUVTqJVQSl9k2Gl6/Vq3vB/j1XHcvVzKkCLdkfrOzonr2fUFqJ1AeIP5KOm2RHErqvCYu3KD9/7TMNCcQd5167G35GWcRQWHDsAmemx0xj+r779i/c9DlvcFNw8eD8PK3IVJiKre62DRiOrrmch2aEKMQmvAMU2rOIgfYI9lBAmGTrB47QlqaJ5N/zXfL3IP8xn+fue21jU9PODlsOFGLHQKomgzZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0a9Y8q1WApa0dCX63P+WmS1WN+fBvAyCF4Do7pYxQ0=;
 b=ccG0miEkEOOr6VP1bLvOP4CDNehNkrm4NOwz5bG+LGul15t5wTEUzg91bnxsk1jzkBRO4qn5x8JULtpk59uOacGmUgXi6ay9TaVzJ0cqWqjoVJ5FQP6ccgWswFdixHKEos1pF3FZaptjqtU1FrrTT2XYCNQyc60ljD1qt4H8I8Gp3h7CnAVlJXAFg/OH3pW30gl9ud3SV7wpA1YkqBHSBlTwXWHcAW74zi5xN9oE5OR2FF3Pgb+AB7rZzxqHBoJ0xiBlUiTcDRPfNMlgfICNb+r9XeXzlyVu7LFaarfs502mlj5n11yeAWbE4YtrreoNCOCyqc2/ZRl9HfH+TrOpkg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 21:43:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:43:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 02/13] nvme-tcp: remove the unused queue_size member in
 nvme_tcp_queue
Thread-Topic: [PATCH 02/13] nvme-tcp: remove the unused queue_size member in
 nvme_tcp_queue
Thread-Index: AQHYzRTWnnVzrgfL1EyuO1guHluqM63o2cSA
Date: Tue, 20 Sep 2022 21:43:05 +0000
Message-ID: <5eb035a5-4396-dfbb-fd22-6a1f25ea1c14@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-3-hch@lst.de>
In-Reply-To: <20220920171611.1289361-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7129:EE_
x-ms-office365-filtering-correlation-id: 0ea3e682-7dc4-4f35-5c81-08da9b5119dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  RPB13gA/y5C+7HBzl6870e0vWoVwRUJiP8yUOmLNsj/l2jCQQZ4pDaoHFcX148LcNGTRILPt2iqncDPpj7LSGc8IoZ0mtU9bn3EP51EolUOORFaFRwGKGpmGybW+GyW6qE57wJpFmhN+mONmeWJl+/g3X1hWc4tp7UJbSI931d07AGYgaYrp1nPX2uQYKhqM+r9w3vtPM7COBgcBuKOh3FMBgvgrkdcHL2NQDH4aB4rdlhOVcMAyyFIsbhYmKbRLn1/tlTXoytphVg9zh4tSSj5k8P2c9TR7HfEZukt4ARpanVH1ZrLJMdbjfHdLeTtxxNKUkKPh7OsgZUObx+dJqwCbRa2XmoggRDib3P555FMS5PZ7Y0kreLmyg8SN0DScbj1kJDQ4vgXsf4opt6caxgXqqapg5omfOJLacV6cUQYh59sJ4AlDtyrlgL1AxUP0LHUp0CNVKUPx8pOLhEf5aXRq4gLSkshLMN1nyQi6VeCCpttGwS3/PnT7tdG4zan93UhMifn5HfAk3k29ZXRvb8Pta3CrEW5sVnzhKKvNKkNWK4tW+LYQ9JXE2Xn3QD+itAO41mE4Ub6pAyLOSSk1EgRIfzBtBX8MOeI4TkgBUJqbDdgTIEtOU8prvnU9+Zqd5QcKqNmJLDV8GyxkiVR28wP23TmNtm3QVCO3YDb4Hyb2SGKMK+LrjMUy9Wa3Fba42pyy1UXDGr1vHwx6GG8/4xNLuNjdwgk5BrMjKWXcDpa/FQ0GPHjXS9ZRa1PP89ErTaFzMgh2isI2VACTfUN6bsVRT0m/qM1Ekp7QyK96zmDLgJpvznQIszgU/R7Mg5nq3MqT5UFSSHTHs+hXzVaqfA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(6512007)(6506007)(53546011)(38070700005)(316002)(54906003)(6916009)(478600001)(71200400001)(6486002)(122000001)(86362001)(2616005)(31696002)(186003)(558084003)(38100700002)(31686004)(5660300002)(8936002)(2906002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(91956017)(36756003)(66946007)(41300700001)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VjdrbWJIWkY2b3R4Z21MNHVab2ZINUNadUx2Qitqd3kvRFVWS0pxNStpM0tr?=
 =?utf-8?B?c3FsbWlYdXVlemp4SStjUEJKYkUwZHZUYXBOb3FLTWFXaHRlZ1kxQ0RlRzlR?=
 =?utf-8?B?MjZoNm05TUhhSk9VZDNZbGM3Q2ZreHVWQlNKS2I3eWtJVFBFbkltYjZDRTlY?=
 =?utf-8?B?WmM2QnRUUWpLYVBBT3A3UGNWOW53V1hCUC92T1gwNzZheWhqSWVUQ0R4bkVD?=
 =?utf-8?B?aFZwVlRKbHFPaW13eWQ0T3pkTjRpSThYTkZsM3kvQlpTMy9CUGp0ZllaYUJB?=
 =?utf-8?B?eStEdysxRkV0SmRZRGN3c01xNHpLT0EwK0h6SlZINnRkN3dDVC9oM1VBYVcy?=
 =?utf-8?B?QkhMTE0rNUFYTGVLaEtSbWJzamJMNkZiUDNNMlNoQUFxdnRTbytxWmx1Rk1T?=
 =?utf-8?B?SFk0V3FaS0Zwa1ZPemhmcFlhbFBQankvenJObXVGTUJaRXcvQnlOem9xS2Rp?=
 =?utf-8?B?dVNlSm16TXBrb1I3KzA5OVprSHVrUVNJd2x5VU10ZkRhYmpCT1FzLzlmc3VG?=
 =?utf-8?B?dU0wZzFReEUwSWpnR3pLTUhFTkEwNXF5S0UvS2hwaG90NGczUEpuWVM0eEdh?=
 =?utf-8?B?aE9VZmIvL1RxNjZJeVNIQnpQZDFwWU1XSkt4V1c5YkZ6OEdUYjJqRHhCb3Z3?=
 =?utf-8?B?VW1UWDhoamxnMWx0dmxIVThyalFldk5zV1Z5M0pNSDhnQ3AyU3Y2OERBQlhD?=
 =?utf-8?B?V0dDeWh0QmprcElWTnZDMTNLd0M0L3IzUUpLRVZPdFVtaURZVTM5aG9BdjZs?=
 =?utf-8?B?SFgyRmdzbzJaV3k3ZjhsQ2RldEtjOEx1aUtEblU3U3lnUzh0WHhhMVFvMUpD?=
 =?utf-8?B?U1lXQkh5U042bGlHamNnN21mNVYyb3RoYlRRWEwzaisycHNWcERzUVVrTGw2?=
 =?utf-8?B?UkhFVjRGeUNiQ0hFYmxLK3Q5OXlrN3RPWFcrMWhZYXZsS3BORkRFWEZWcytW?=
 =?utf-8?B?dDZFMmMvSG05ZlZVU1VOOXZ1VTBTTFlpa2pBUGVXeHR1MWRNSmhTbDRrWjJU?=
 =?utf-8?B?NlJkSG0xRGRNaENNekpocnpvdzBFMHU4S0lqa1lKdjhWT0tEZWtiZ3JFaG14?=
 =?utf-8?B?eXQ3dTh3cHFoZi96MHcyK1AyS3hsVk1WcVo5K2lkMzAzRzVpZ2VwS2VlZEFB?=
 =?utf-8?B?KzBuWHpOK3NmdSs1Nmh2TmkwMTh4Zm8zcFpEbElZQ0dPTEpOT1RwNHIrT25Y?=
 =?utf-8?B?SGVWNGNJYm05ZlpKNks2Q1hRdlhraFJ1VnV4TDNNdi83OXl0Z09vNzlDdTJp?=
 =?utf-8?B?Ykdpdk52V1R0V25sUlRWZUxzc1dWUjRucEdDcmVpYndXVGNodkgwVDdtdGhI?=
 =?utf-8?B?cXRGY0tLWnJtaWd6N29Ja2tGNlhEbU9yNTdHRWhjYVlNMTdGcXYrNDgrWWdJ?=
 =?utf-8?B?OHBnTGpTbFZaSVdIVlkycGVac0I5dy84alJON2RPNkFnaEJEUitwUS9DdHBV?=
 =?utf-8?B?VDFUMndoYUVOVFRic0RTSGJYTWlldUM4RkZJSlNUVEEvL1NDWVZuZ2NjNjZQ?=
 =?utf-8?B?dElsbGNveHVuWVdOb0hvc1hydCs2RlQ3WENwRDM1N3BtMDBDRzFVOWVRSUJj?=
 =?utf-8?B?dVRDUWFQNHJwQXZsc1RldDgvZSt5bUlETjQ0QXUrSTdCZFU0ZG8razhTRU9t?=
 =?utf-8?B?cnphekNNUC9zLzNHQldKUFZaM0dWWDVMSWJDQ2VHYnUrNXBZVTJ6dFAza0xO?=
 =?utf-8?B?d2xmenBjaWJEVGhrZm81dUpyTlBob3pvdFlYRllyZ3ZuTHkrQUx5dVdidVAz?=
 =?utf-8?B?SWorT3N5dnNpQVdoM2J1ZUwxUlZESDZKTFBBSFRmbm1PMytOeHRMVUx5elAw?=
 =?utf-8?B?K0p6TFZRbUxEeHVhakhwRGxzYllzNlBkRndMMDlBNDVwVHFOb0tMZE5Cenl0?=
 =?utf-8?B?bnVCdVhVK2luand4SnhZRW9pa2dkWkVRR2VUaUlUSHgrdFRNTjBIYkhMblNu?=
 =?utf-8?B?SyszdWtpSkJRREl5VVRCdFI5WXJHTUtkaTdBNGE3Vk0rRGpzUkk3UStRSlFu?=
 =?utf-8?B?S0pvak9aaVNON1BuVVF0cE5HL0NxRWhjVi9KdzBYR0J2bjlYY2lLd0E4TWh4?=
 =?utf-8?B?UllnQnFNY1FvWjhmcFdqL1Voa1FBZGI4ZWtQVVZvaml4dVlOQ2s5WFZoL2NE?=
 =?utf-8?B?OWp4bStjdVo0dWY3b1VTTHZGN25meENVQnBYT1RhNFBWaXBUUFREWVl0Mk5X?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F05A0CD14DAF1449BDDC6F07FF39FE4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea3e682-7dc4-4f35-5c81-08da9b5119dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:43:05.4249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrWlSJ+aqcghKeXLNHoQltKrw1ZERnGhmAsTelD3rAqOP1zDixEM4dRfiGuMELHnExbt+ars/B/6rC/j5waXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144309_600863_D7DCF63D 
X-CRM114-Status: GOOD (  10.71  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IC0+bnZtZV90Y3Bf
cXVldWUgaXMgbm90IHVzZWQgYW55d2hlcmUsIHNvIHJlbW92ZSBpdC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPg0KDQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K

