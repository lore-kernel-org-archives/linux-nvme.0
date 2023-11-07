Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D30AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 04:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zbOjtEG4O+F9owv0b8PDQN9T6+crQytK7FrGdubi6PQ=; b=3cRnl5E6OY5q7CSQrtGNF+3fc2
	JJWqvMQUyZ6i94cU0kuhtTM73KiW6wFQEdftZXFvLlFn5+CXHCecq2N19ebVexuJZ7A1/FrULC3S4
	6dYMUO2uwLkSBq9pwCT7RiRl8AolPQ1C40KdDFAY2CL82hvy1uC7hEdjev8M3BhcVcThVGtDK8yAG
	anb0JsXsB1AKYr6sfPB85jg0NrXmuuQvnXOKQvzadKtAbIcaqCTbt1/bfZELdoQ57x+zRQBREGs0b
	f2CgMcqxGwM/qV9qisR0S1i4qjvqkXSJCR8mLQj8fNjtDeKUiMtcdnux9NaRSV3Bi1BWKR762ayhZ
	srwVSyfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0DpY-000WDk-0O;
	Tue, 07 Nov 2023 04:36:48 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0DpV-000WCg-1h
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 04:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9pJ4N4pEiqURpi5JFLqTliswZJSHLicHIJVXDxovQ3adH1KlQ7g4Qd1o7q0/zncn5+AgyVDd1iXgl7uOlYcLYfQpW4bbX66PhrqA9keTN86PP0frJDz3jyCSfm1Lur1E4nKBNhuWdwmPaCDrv+QflNg+oM6YdjdGhxPZVpkB06aSh7RcWfdU87ylu75bIjmdamJ8sO3gqX6foEAKRtGDM+WscXexQUMQqOGl9MA8V0zjhcSlGuVxFUXRNqGlZwbAMu6+UQK82pwSFFYYDLp3kK/12dlxdoczoXctpBzOGrGf77uNJCAvP81R30pLI3Wg8J6d/w9R4unG/Ai7x3FoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbOjtEG4O+F9owv0b8PDQN9T6+crQytK7FrGdubi6PQ=;
 b=ca9FywhDtyjHu4BqFpXVdh+c9N/C7Mwvzot0kHn9OPiaw8nyWBO3mCNVpfMOTTJTZNOzvO2IZt+Efc2IYorivdQ3bwlry+Mqz2cWC9alR4O+JfT+AOJ9ZnJ1UvLEUiqJ1aZQqitbnNa5I05+YoQ41lsT8R4IzRGnoQyrooy7q/DLeVGTBkOV8xpt1GSk0jvB5U4M6k791/bq7WI7ZVcQuL1VgtwjLHKkzdRgse5ssASHvjOr1Yl+3vq3GuhH8Ty54/SzR8T1wZgYM/ukvh6gxZQbp35wTtUcuafVAo2VM4moAzFazyatCuxasGhy3OM+hbshbiubs1cgXaxUDAKQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbOjtEG4O+F9owv0b8PDQN9T6+crQytK7FrGdubi6PQ=;
 b=odGMDGSlXijaJJf2LtkegSlAg30L/9t85j2eyFqB3ipl1YutaRwYr8/wPTdpjCPCo5oZValctJJMO+3MGA2R0SGXJLcc/kcBvUqM47ewN/oElSwLQYOV1vr03VqlKuSzRBVJbz1ZONz/DeHQb7BRgyoN96Jv79rEdeyJ2YbN3ePFbm79+ooDSy64ar0P8DgPucG2c3+icSuzR+VZ9GndAcQW/IFlifSs6GMesauV7E4V8mWTfUKp2lGKrWl8BXmes0WFwV/7x0i2SiYVGfxU+oBhd9YxO1a7tkM5IPotdH2MKgiywIiw4NkWFfyihzY3gtp3GMx1HYcUrOT0+EQiHQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 04:36:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 04:36:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Wen Xiong <wenxiong@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
Thread-Topic: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
Thread-Index: AQHaETCHjxO/cJJwokGzfIBBYOwSybBuRZgA
Date: Tue, 7 Nov 2023 04:36:34 +0000
Message-ID: <96ca907c-12b6-4bd7-a1ec-5186a228ba3b@nvidia.com>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
In-Reply-To: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB6995:EE_
x-ms-office365-filtering-correlation-id: 4f4903ad-cc0a-42fa-03d0-08dbdf4b1f71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPVrJThi+77LhGrikP3lQGa46f1cmMiPVdKgp8t2iBKTqubtVSAEdMiOcyFnKAxaSdBCwT39CCBxkloUtwMqbsJ2bVu4FjMVn5ff7VH7ZnumDWKcJqxBfdoD6mbEWkZxFltcV2GvF30vSP56pTLo0oRYRVDNF46Y8s89xac7CPOqWobdtQ/NQj7XAYVgvjHqwqXzdaWfD3kxzwcEmfRw7JLQ/6gvKQ2ERPQm0/2W0yrxVtaUHUmyw8gZKPgKVSpDv1M7ohiNEBTqTEpr+HGXX6Ewl3VOxo2oCTHKwDd/OFtyNyCaXsDalwC1n82m3qm9p3NPsvOpkvZ6mKsnk4lF4i/MlIAlQj8XyIBkUEa8I0Q3s9praXpai1kNczTAW1mipJaW0W/b9xYh4OJrZ5rnHqtnrYgPxsFV47JS52cFDOi5MuU22Yz5Bv3wmzIg045QK4z3/I1SqJfAt3MOzvMhxxUlQg0tLk0WA/nbV3oj2sO658Bo9rfRuXNStTPuFAJTAmSkTTq7cabE6h4Wvt/2KXlKv40vo1aoUcvNQkX9CfOyjVOMzkFGtJP1q/jabFLvzGvBgxSKqG3prREpHPsqpqaMQRO8+mr6B/iPu2GK8WMjex2kEuU4noKEW1z6HulouQ7nHd7m0tllf/qiYYPMQC0SJdokewDMBo7qB9cJ7R6rPwtKdutAqAqjiBm/cyQB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(26005)(4744005)(83380400001)(38100700002)(38070700009)(86362001)(31696002)(36756003)(122000001)(53546011)(6506007)(6512007)(41300700001)(6486002)(478600001)(76116006)(71200400001)(66946007)(91956017)(66556008)(66476007)(8936002)(6916009)(316002)(64756008)(4326008)(8676002)(66446008)(2616005)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3pIRUhQSWtRMWhZSVdhUHUzRS9ITmRpV05JZjQwajFMNWpqZFFWd2RXcmR4?=
 =?utf-8?B?VUpySkcwaTFCQzdaeHUrR2xMNFdPTVpFWFZiZXVKUUFHRFZnK3hTOE0xT2wv?=
 =?utf-8?B?alNJS0g1RmpDZ2RlNHNZR1MwcFkrTUlJV3h1dk9rYytYZHFZWW1Ta2tDd29P?=
 =?utf-8?B?VFlVWFd3NGpFeWJFQzVUZm1mT1VDalV3V2I1LzB5bWdlN3hEdmN6bG1DK3RB?=
 =?utf-8?B?T1NWZFlLNnBQUWt5eFYwc3ZrcXVMNmNRc3dPN1prcmUwN3FUZno1Wi9XdGNr?=
 =?utf-8?B?OThRVTZLbzYwRTJLTG94UkdYdWU4alAvMFkxa2d1aUlJMFVGZmY4NStFaldy?=
 =?utf-8?B?bmsvMVozdVpSSjVJb0tsZ1dRblRwcHN3ODFlUlA4TUJHY2pHQUVSenNiZ2Jt?=
 =?utf-8?B?K3pDVE14SkJ4YVFtMmd4cTRSczBlYkw1ZDlqK0Vxc0MwRHFNYlRMeUZXNCtZ?=
 =?utf-8?B?dlFNajEyVGVyV2JpS29GVWpHemw5eFA0OE12Qk05VjROcTV6dXB1UjhKakdW?=
 =?utf-8?B?VzRtYlBTdnk1dldHZHhvcGhiMnUvNTY0OExGbVZ1cHhvUkc0TzB0NXlnbThz?=
 =?utf-8?B?RFdwSEhBaUUwYTYvV3I3NUFvRDJnYlZIQWhhMEdJUkpDL3poZi9RMkVodjJO?=
 =?utf-8?B?clVrWk95SkcxVlp4WC82VFc1ZUN3YW0wYUxCdFpPK2Q3WEpjNFRpanQ3aGRy?=
 =?utf-8?B?aERvL1VsTmtWbFdzMzlkTTNrMUo0elFtY3VDd1p4QVh2b2YvM1NoZDBtbmh2?=
 =?utf-8?B?UC9lcXVwd09pZkNGNCtBejRMUWlraTE1U0hsbnVkSEF4Y3NxcVZoZEc2VGRy?=
 =?utf-8?B?M2hmaDk1ZW45Z2NqdnhuSk5nSHlQbGJTYmpwMGQwd1ROOHhwQUFKUE5BN0Mr?=
 =?utf-8?B?Rnp1cVpYZjBkN3pnRElJRS9BcXRHMFdaQytDbFZwSkNuZG5mb2NhNmpMNmds?=
 =?utf-8?B?cm1EdWpkRzAvOTJEQnJzcjNrSHZmUEFGMXkwaU5lbkZ1Y1VLWmVseEhYUW1X?=
 =?utf-8?B?R0RXTG1rNVhhcVdRZVMxVXAzREU3TnptZGg0Zk9mY21mcUVEQ1RWVmRNNXJs?=
 =?utf-8?B?dG0vMm5SZ055cnpnL3RSZ1EzU2lSM290TlFicWJnK01FdXRHMTUxMFJ3M2Uw?=
 =?utf-8?B?ZTdHWVNmLzRYZEZNRFFkeTcvRTZubXhBbUhMQWE1UVpjTE1QSnlLUzN5VjRI?=
 =?utf-8?B?cE1Ga2xENFdNM1Q1YzJsK1lyVVJsNklIWm83Nkp4Uk1DME1ibEVybFhPV1ps?=
 =?utf-8?B?Z0NEcWxFTTZ2SHBaTGtzaEE2ODZwaHFDNUhXenlYZ3JQNnlvc3lBOTVYQ2Jx?=
 =?utf-8?B?VVVRTmJITkI1RTdsdkxPNVJ1YzdiL0NLQjZVbzBadnBPTkdmME85cE9yN2Jq?=
 =?utf-8?B?eE9DbXJ5d1JzOVFGNnhoUDV3MXlkeGtLU0ZMcWdkMXlCTytGUzBIU2hCT3Y4?=
 =?utf-8?B?RlYxZFNTL3pkSkVuTVZMU0E4ZnE4a0llanVlQ2lCVllEemRiZVBEeHM0ODJF?=
 =?utf-8?B?VU9ObmJSTTcxbFVPTjdSdnZIUE0rMWlJNE83VWV4ZjlVeUhBTUUzK2JvbHZZ?=
 =?utf-8?B?QitkOUJkblh2Z1dlajk3cUxQZUxSMERuL3R1RlJpZGpSNG1rNmJYMVM2YkFF?=
 =?utf-8?B?TjloRkZQY0xFc0dYQlVoVDBZY3dTUllMT1BTRTY5QllSWHV5bTRQN3ZTNWN0?=
 =?utf-8?B?YXZ2SFF0VEEvTHVKSXdBRnEzU0pOdTV0MkcvOTI0Vk1JRDdWZzdlNks4VUpK?=
 =?utf-8?B?SjRXZmdtcHRLQkFtbXVCaE1oOW9QY09Udm15Qm9sWENrSHM4N1BldnJxY0pU?=
 =?utf-8?B?STdydHBYUm1CNEkxNXJTNm9yZWdhUnNMemhOMm9wTlAxVXhsZ0NreU5uajRs?=
 =?utf-8?B?amcxOVo1b3JtdC9jdC9QM0NvaitraGdmNU5obkFyK0NLUi9ZYkNMQXpqaXZK?=
 =?utf-8?B?cFI1OG9OVGlVSG9FZ3lCVTFnUjJaaC9ESzNjMmROM3gwT3pHNDNpMFdBcjZt?=
 =?utf-8?B?dVh4RG85c2FIVFJVbEU3d1FZbVg5SVd2Tm9MSnAzR0hrQjZkTXg5ZWQ3UllN?=
 =?utf-8?B?UlMvSG9tYUE0QXNqS013M0Rqc2lsODkwTHBzSFZmcmxFMzZSSy82U08yOUpE?=
 =?utf-8?Q?/GsG3uFaQAyqPBz73q/iXPZBe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6C2F6872AD17A469FC34BFB31F76056@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4903ad-cc0a-42fa-03d0-08dbdf4b1f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 04:36:34.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfigvGctJfmoU1JmrNZcbz64fI8iDjBMe4zytiIjk7ACD9NEbLj2NDhfs1HyKfqIdLTyfk4CyWMq8h+rWespvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_203645_739791_DFA670BB 
X-CRM114-Status: UNSURE (   9.67  )
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

T24gMTEvNi8yMyAyMDoxMCwgV2VuIFhpb25nIHdyb3RlOg0KPiBIaSBBbGwsDQo+DQo+IEkgYW0g
d29ya2luZyBvbiBuZXcgbnZtZSBkZXZpY2UgYW5kIGZvdW5kIHRoaXM6IG5ndWlkIGlzIGNoYW5n
ZWQgd2hpbGUgDQo+IGRlbGV0ZS9jcmVhdGUvYXR0YWNoIGEgbmFtZXNwYWNlLCB3ZSBzYXcgc29t
ZSBlcnJvciBtZXNzYWdlcyBpbiBsaW51eCBsb2cuDQoNCg0KUGxlYXNlIHByb3ZpZGUgdGhlIGRl
dGFpbGVkIHN0ZXBzIGZyb20gc3RhcnQgd2hpY2ggaGFzIGxlYWQgdG8gdGhpcw0KYmVoYXZpb3Is
IGFsc28gcGxlYXNlIHByb3ZpZGUgZ2l0IHJlcG8vYnJhbmNoL2JyYW5jaCBoZWFkIHRoYXQgeW91
DQphcmUgdXNpbmcuDQoNCi1jaw0KDQoNCg==

