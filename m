Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79A4C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFrrK8klPV9M+Y4sbwqLBb/hxGOo2OdWKnDAoenQR+c=; b=w2Uc3SNyinCuCjX6Nt6s6FZceU
	/mWzOU1B/2EkwRdfq/izU68z3DQoKEdBp5nZll5nZv+Pn2FrD9If9/d8aEwZUTNzWvU9aU16B9Ku4
	WDk4Jofd/EYQZrhjoGY5FOH/cOoY5ZNS5otZDxB5rAOWW+SxvJspsF/FuZrvonxrMRRZf1WGzVOr8
	BrMBWDkYlojbWtVFMqTK39I7zDAdH/WGDoumJe6qLos3wYpyNurY82It5yiHS/lelv84m4RIBrC6t
	tk0kQ47ThCNvzzRPV+1w1c5SoeO8MyXNxxI5qkrTlBukoeLDfnPUyqFlHxG9TE2bfc0WpG2j7fM/P
	pfk4oNOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5uw5-002hmV-B0; Mon, 27 Jun 2022 20:02:17 +0000
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5uw2-002hlJ-IH
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 20:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuGIZ4HnW8QE6D+pDOZ7POTmXA9bDqfZKUH0b7lB5JTKb93GuYVTalSLuYDQOX8kLUK7bhuMGKvxWPqUXgT3vwjwBJBgLI/3Xe2GWj8fX3KIGgNm7qvJhWnvNLCvEh5DhAutugASK53M2qX/LlXePa/nPoyIm6GokIpF+BysxKCsLVApXZrYJ2MHIgZB+TlqdpR8UBtmpQV8CuxYWZbSzXXf3z7dsQ7UmvOXsZzct4MJLR7gFTnXaoVA44MvZOT4Q4rhb4UwDiTHkRUPlYOXz5aspEA+DfAofneV2Y5xgPDO3v6u2BWdQPdNdNQBvPzMYjjeIa/UWqQXZbupRYGR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFrrK8klPV9M+Y4sbwqLBb/hxGOo2OdWKnDAoenQR+c=;
 b=HQfJ/5cVS15Y/+oR8WwwR0G8qKPmiVREi/yiFCHjdRzlz3+lQk1p7rzOowBDBuIyRBNNXXezbxvmS7VBGPeAlYoTTGqmxy8gcuZtw8u1084PFkAUypRMSpUzE5u7ZP8p89WaqvgvmFUALEYEaPbVzUe/SVMkEMNJNV8g7t5OYVIDOmwwrnYpQb37C6qBJ0E02s80tmU6/ASFBVfvpSbb3e8bl8bStDqd7rE9sPUW5TvfbXKuvnK1HM20/KnXxhH9tRxbL1rNXJxDCxMxhdH9+xF9hS0gGahmw7Xyfx1dU6D+eR8qSg5eMZIMJFOtb3XJ1EG3CyigJG5pSyApRmnkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFrrK8klPV9M+Y4sbwqLBb/hxGOo2OdWKnDAoenQR+c=;
 b=eS5Y2MpaWR7JZYSN7X9ycmB/jNYjGFLpHH6gjebqXFRbT/L5jDIoxTN0JwvVaEEdFhCnFxbICDQa0QcBoctXtCtQh6J9yE4oTZ6JSmDHhxdMK1KleTgrBYliRDSqO9IWEFefZ6/tyKEAjiKMjaq57Oo6yJ2B/MgSf+PZROoArVMaEJsv7qAMwqzPi6xMgPMPe1Yui8vp/JDU67I1ZxAC+zMv0srfM63l4Hae155c3xD54KJk5tSJ/b1IFfP/bkf+X95Rut+S6dSkYxPw5QjyRzNlHSW4M/RQqTdcIRQg2JXuHFikieyOxk34aLYwXq7kE6NqsWzd+oPQXvYpLvvP1w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 20:02:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 20:02:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
	<Chaitanya.Kulkarni@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-loop: use nvme core helpers to cancel all requests
 in a tagset
Thread-Topic: [PATCH] nvme-loop: use nvme core helpers to cancel all requests
 in a tagset
Thread-Index: AQHYiWX+qsagziTT/0G1OqGnuNpuI61jrsEA
Date: Mon, 27 Jun 2022 20:02:07 +0000
Message-ID: <26c3b86a-1f2e-5643-0052-1f24c1e9a2d2@nvidia.com>
References: <20220626140600.81362-1-sagi@grimberg.me>
In-Reply-To: <20220626140600.81362-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7df3db1d-8149-4b13-70bc-08da5877e9d1
x-ms-traffictypediagnostic: MN2PR12MB3455:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  oWbU5VHxyfmVenaNCMjLVIXZAlewKh/YYlFYRODduZRzTZWzXxorGwRhuccDEXCO5LXFIAHSbrC1y7CYPt48unSOCGwenka5BMb3+CEqCcaYIZ9Gtz7nhBLQiisPJ/ZbFdjmhGD5L4Pbpeyfbmmj9N/GKnQYjvikfiIzK1XNbPCzf9Z2ah5Tw/q7IxiTUK6yv8R1fNp3jN1MfUZdB4CrGKcxNR1YDgTEr6jEF6xdD0Den8Ib4NtGL9sdev6O4r78EAg98c2yIqq9IMLIrxEdgHjba+PNuMGWR0YLE63xqLLCdFDJOYQ/IqIZ2dW5BbLQUVCs7PhEgYdefIRrMNRRolIdFXr2XXwrSDGicydOkuM+ncKMxSPcbI9yxg+ry7GN2V9DPR5upIoD63sKDY8k8GusdLNs6K1vSOGXSaE3ZKa1qaKX8T47C17r2IzuMBgiiYmxNaLvqa777br/CXi46gXMorxykRfBjAFIHzBxJiEXfcCco3mccnrgFSSYJv9lJwY/y+apHVM9yqWH1Eu+EnMBUfXKHy0I1w2kNhkDoWMwLq2Hj6R9L0FIFy2Af5k5HitSairv4f6Xy+rchq8Rmqo88CmwHXK1PgQDBr2+sLWqord/iP7cJXW/bqoF1l0BLm9S2R6twsW7YfckPxB6dtSOYyvCDcAR/xyPoMXDoXhvSNyL2618/5qNjyDCgiohINtw9e5+WFcD2+mw6aSGXHZw6QbxOxtXfapBBXLtgAQ4X1pCf2fJU3LKA1gHV+NsIF6FzqKXW7bAH4pO77B6kab7iJkUrLYNHCLIVtszMDYu83th0Txv2jfsxtOtg/p5aNY0LaDN4hspFzhApmgY8tQ/3trdPCKCoqQHlyHgMh4=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(316002)(36756003)(53546011)(122000001)(91956017)(38070700005)(64756008)(4326008)(54906003)(5660300002)(8936002)(110136005)(2906002)(66946007)(66556008)(66476007)(66446008)(76116006)(8676002)(41300700001)(71200400001)(6486002)(6506007)(38100700002)(558084003)(31686004)(186003)(2616005)(86362001)(31696002)(6512007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VTBwM2tLbldvV3dqcDFtZHppY1phMlVyUDNYYXNxSjZZMWlwWjJlZ3JaY1RR?=
 =?utf-8?B?ZFk5RzR4aWdpcGJBZzVrd1h5aDRGbW45c3FRbWpIYzVNTzcwd3Y1aW51SlhC?=
 =?utf-8?B?TzQzMDk2Znp1SE1SU0lVdjRJZnBXQWJ4cTBKOFpZbW9UUlE4aVoyTFJsbThw?=
 =?utf-8?B?U0VBNHZxSy9lbWlRbzBPMmIrd3ZpM3k0QXFidDJ5eHlhNEtPeEZNZysxQURu?=
 =?utf-8?B?SmJiZmFhNFpOSU1BM0hqQlBpSzgraHFEalZHaGdqMVUwSlBmRGE2NVBFVDZu?=
 =?utf-8?B?Um8rOUJ0VXpGZnhDdGJxMFlTUDlvcjVyWU9RUXBVTE43QXRKYlJDZExnWlVu?=
 =?utf-8?B?TXN6NHlCZzZzUWY3TkN5UHZSVkhBZmNnWjI5TDdvZXdwY1Iycjk2OC92a0p3?=
 =?utf-8?B?eDJMa2k3QVAvWDhCclJ5UUo2cWxBdTRBMGwyK0ZUcDNCUm4xTDFBV2tMN0Jk?=
 =?utf-8?B?Nmx2QWs5Q2czSTdqNU04b2F4VlhDVVQxY1hOTkRnSS9LOEMrOWtJdytVR2tx?=
 =?utf-8?B?aHVYaFNtSmJBM2NxRHZGM3AvNkJ5SHVIbHBvSXlMY3AvQXJPaU4rQ3BacnRn?=
 =?utf-8?B?NzVxbG1Zd0hWTi9oNlVPVnhyOEpJM0owU21CcXFLMllWL21HNUZQRzJ6OGcx?=
 =?utf-8?B?dUhKUVVJTXh3Z1hhK1dIL2hwdmhWbzU3SVRYSkdpMzB2Yko5Q1NGUmRNRDFy?=
 =?utf-8?B?aVprbFJVRzN0UTZ1UGc3cUxtcmZnRkpvZE5UUndOVFJ6UFVzQUU1bGQ5aTRx?=
 =?utf-8?B?Y3ZVSi92Nlp2QTRqanpNTDBKaEJzVW1kUW5xVTBEdFphcEJBRjhtNFRJTGtn?=
 =?utf-8?B?UUtqRlRMeUpHMzF2UHFqZUFJL05MZHFidEtUOUVXMGZtSWo0cW5DNkliLzZJ?=
 =?utf-8?B?cVoyQUFQZEl1ZG0vakhVdTgzRStucmU5TDc4RmdBOHpzc1pVMUxMd0RQc1dw?=
 =?utf-8?B?aUFOVGNHQmdlTFZva3dqM2F2eEVBemV3RDNIYUI5TzdqbUpwNm11OWwrSEIx?=
 =?utf-8?B?U1hnZ0pyUk1SdldFU1NGM3p0aVVtRXZjazBmVHUzVmtwNFYwR2xaWlVuVVBU?=
 =?utf-8?B?N3EwWmZhWUkzVGRMdnlUbDdRQUcrQmVmc1pSaHV2TDNhOWpld3UzbzNacVEz?=
 =?utf-8?B?ZFYxb0V1blNBRGtHdElmUEJqSEdxUnV0RFBFekRQRFd5VTYwMnVjUzZOM09I?=
 =?utf-8?B?ekdkV0JkRkE0RzZlT1B3NGJtZHcvQjUreTA1Q2dQNWhWYThEVTBzRHV2UUNC?=
 =?utf-8?B?WHRZNnc3dHhUZ2FiemtnbDk4STBXR05xT1J5OFJ4a1FaeG54azV1eGJKamJ6?=
 =?utf-8?B?KzAraFlFUjE5RUZNL0FTWjNRcktDV0l3azJhQTlFcE9IQ0xUWktzeElzTmZB?=
 =?utf-8?B?K1FrL0xLTHEvZm9mNjVza1RiazFKZnBIMnVFTlVMZEZZK0hocy9yM0VxczRB?=
 =?utf-8?B?cGs1ajVmWTBXaXJXVWZCeHlHOS9qNVNSZDg1QnE2VHh5MTE5a1lKeW1HMFNV?=
 =?utf-8?B?S0NCWFVPelYvT2JFQVJ6QjNWNmhESmJXaTJzejFoUC9ycVV3NjBPbEdoM2h4?=
 =?utf-8?B?WHpoNTJHd1NwWmZLbFVRbDE1UWJFbXY2aTlIZndYYUhQTEF0ZTV4TWdPckFw?=
 =?utf-8?B?UzVKLytzR1lITEwrQys5WThsMkFuazFDQkxabUNhdFZoNWdYV2VycHM2aDNw?=
 =?utf-8?B?NHBmOVF4cWVMTzJua0F2bnBRYTZjWm42Ky8wb0wvclgyQWd0NHduSFMzVlds?=
 =?utf-8?B?VHVmbENrUHU1ZU96Q0Z4L3FMcUc0YUEwSmNZbTVNRUxMdmZoTEdTZlIrMFlG?=
 =?utf-8?B?dTIyUjIveWdKS2ttZTBoS1I4aUsyMWhEZDZKZTUrdjVvYVpNNHpoYmVVcyto?=
 =?utf-8?B?TnJZUTdoSjFYK0llNmFnaWJVWjhBUTdxd0x5citRTmVZeEdTaE1KbjFvY2Zs?=
 =?utf-8?B?OHhtL3hDSHY2V0gzOXdVNndJaXA1VjFmUVJ4VmNLTHgyWkcxbWxjMjJqOEcr?=
 =?utf-8?B?Q05hZjFTN1ZRMzZ5K3NCY3R1akk1STBQVlpWa1lXVHlHbzhQRVdxa0R4b1hs?=
 =?utf-8?B?Nmh4S2ZzWmFQQkNNV3RkNmtVY0J6RzFYY1dCMVhJU1BUd1htOEw1L3IwcUpa?=
 =?utf-8?B?Ukp4NmxQWjUzMHQvT2txQ1lLNzk0TUNkTklnRS8zb3REV1JZQVRIeVdNeVNi?=
 =?utf-8?Q?EWHVuZgdHgPM2HXt4LAfrI4fggkWD4oNSobbEjqZg6bo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7FA44AEE986C442A3717448BCF8F9FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df3db1d-8149-4b13-70bc-08da5877e9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 20:02:07.3359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjudTwmRffr5CvW+d5LBwqcZztHa+Kz5/8uMNh+wJLADhSko8YV6JDmjgT9QkeNNQdYVwwGQSi4KKvsbG4ElWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_130214_792162_DF9FDC28 
X-CRM114-Status: UNSURE (   8.46  )
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

T24gNi8yNi8yMiAwNzowNiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gQSBoZWxwZXIgbm93IGV4
aXN0LCBubyBuZWVkIHRvIG9wZW4tY29kZSB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==

