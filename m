Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E487C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/Gina2blrGm5v2ETY9g1oMK/EGDkiZ2FvbqiYsEnpo=; b=RjVCfS5ixQbyITjvgtgd08BoNr
	NMLzpLkhhMsuhWKWrXIy2H0pYr7o1ZIta+SfUePtQ4KvYVYRXiNqrbNw9z3tnEMj+cZ+z/po0+Ang
	QP3arMJyesn4nYWgZYQAUj2rtCJszu19FWAO5WwlN33Rw0cCtAXFVKNeHXeEh/W2xYsKP66lUpnJT
	EQLeZZd+0NWgke9VKxC3Kcv4kVwRad1tmQQ6jnLc9EsOXtgDl4dSCiQSR5DyAapcyQ/QlMHWLyuOQ
	DmoSYh3PWEqUs2v/dKKoIJ3AaxPFHxl3Fw0JXME/rV/OjihlGw5vW21aragJRCcDj/qjamMMEplpH
	q8tE5Y8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouek7-0040fL-HC; Mon, 14 Nov 2022 19:03:39 +0000
Received: from mail-bn1nam02on2057.outbound.protection.outlook.com ([40.107.212.57] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouek1-0040d3-Uu
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 19:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjkTOp+5cECXdjsXZhFa4NDV/+t6fqc6ZOuQKBHgW3cXr8a+rLxKis2WRjnxuhBANtpOYkw44YDDU+fR5mrbTHOL4BoM9kupuvb0XlE+IkU7xj/exSMgjqqVlmOBjfF/ITbW2okSjG5xkLjuMK1WEshqsNrWD3PbTxRkK6AJJu1VMOGxGTgvepJFthLMAErrf2XnWLiVTjttU0xuWtZhpc435uBJew6TqMjxLsr7kJOOi9JpSDlCvZMaLRXGfTLskwz6XE5RJJ4JRVFuRpmtgtCoQghsPlk57so6VxE3+WbspF6dWHlYTk+f8OFbfWsk9gY4u8C8h4QdF5IN9LFXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/Gina2blrGm5v2ETY9g1oMK/EGDkiZ2FvbqiYsEnpo=;
 b=Bs5eJlAzZ2+ieF19GL3oW50lgK6SBk/SBbbZ1T7ZYRjmIrdj5fnyQsOkkLo9F/2JB3rVK/4OnsVyeKUtmb9zkLWKeDZaTqUTICDfkKjeVGr3ERkzoqHTroufiE4me67XyxFhicGsNsl1DaknfB+8eaR476ASTBB6EMiOyuQhRP5VaUFNWSHJ6qQ7aOb2UlHohu4gyFBu8lxYmPEKhxAlZGDefu9O1xsprJwI2/bsGR98f/McT8IZDmLSd4moe3YKhpb/38W5pUKyQ2w+LzW+whndA5u19VUKWmWmczaanKu058KjQXS2eu+ZV3te/Xxj1p18VnMRTeDVeCPYyLYrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/Gina2blrGm5v2ETY9g1oMK/EGDkiZ2FvbqiYsEnpo=;
 b=hlrRvg2RhObN3ZsU8cDRXRQOYMH3xdHMexb+HwS/8npw6dIOzvlO0ranJJbULmYQEHSt7bf/86sA5J43JzJUTdbjaCnfGRMqaEsgyfcCeXFQEV8hq7/suUd9R/D2q5K2sWH31DOH8eqaFQo0J9lbGZRMjnr34t0SgEDBW4M6H5AgGRSJh+onfzjYdJqxNPAsPTrP/wTrszRizThK8yQXe8EwHvR1ZDxwXLifqPc4hi4q64H0vmcgY0nsVOdr2hhHGrdNjJ10LFLlv0qncL2LTQIdnYaW4flgCrgY4E0JmtQF+1TWgqoa2KHi4Y45UiYASbdJ4HIWWXx7nd11stlgHQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 14 Nov
 2022 19:03:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:03:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: add re-authentication running concurrently with
 reset
Thread-Topic: [PATCH] nvme: add re-authentication running concurrently with
 reset
Thread-Index: AQHY+ChbKuoMm1lypUSviwaYWralE64+xz+A
Date: Mon, 14 Nov 2022 19:03:29 +0000
Message-ID: <268e8f74-c55b-3dd9-903b-f64dafdd61d9@nvidia.com>
References: <20221114125252.1086763-1-sagi@grimberg.me>
In-Reply-To: <20221114125252.1086763-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6153:EE_
x-ms-office365-filtering-correlation-id: e8d3bee7-8e4e-47ce-e8df-08dac672eb00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  S9dTqNEvIg8Uk1FQk0TM0CIyuI1xK/mmb1GuIaGKGQ/jgHisu9O59L/F5jLp/DZYLMwzjsYJ5jPcCsEF9MExHmUgcqDG7Jewa3Hg4Q6qL36veJNdvQqDZkcsQn9vezHqX320eOisAsmFg8uslCFzqFrmdqUaflKIFqcgrAc2E+8Uva3z8tX9v6up7IfEBM5I8rP/qmUbH+GXwHtgz91tT+dQzJNXfaFNcfZ44s277oaH6T9jxDllvfKC9udZ30Xz+An9nP6dqKLZ4PNNAdDPNkBux7Q02p+li3DkdQzOTDN1Sp9md9W7PxgwQoTscLLrURLKI916bjcKJoOS7lOun4GiXq2EpnOLSy3EkLxtsK8m61oFqL2I6ADPzk0ESNMgWFpSkZBl/ukOxGYYeKV6dlpC6y8HM9uJ8YLuyndloxnj+4yJVhM78eMxq3VYRlRD8BvQs6z5Tu2PxkCAH75yxsDmCvP4dKYfrpomJMK7XYgFlphuT+m0BR9I33oV0wMP7GV6dmFFr03u8e5nqQtA+RIi0bP47xUWuX4+DtH2etvBLi5mMXT3mbaQ2RxTm47Vi96CAm4ksqXD9bHSQlpbzbLyXcVVqUQlfk4EsJ2EQLBOIoFOCFBnm1VGS95k5UjtnUJ/W1/w8oK32a0RulAORh/8/pEo5bXBs5M5ISVwfvOsajJNgPz9b3egxKJ8yc5v6thurinKqByCnansLwoqslTVtHvF1IHDEDfpPa14TrnUFTbFmLAME+ZGr9fOmBPCjh4aTk6/uN1mxS5cF4ELmEbmivmh5Ivix7WDMJcCNxBQaYdX0GWo8Tn2nd8eZOTXsr1m2JIVqNWXIIpfAMIh1Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(54906003)(110136005)(31696002)(66446008)(66476007)(316002)(36756003)(6486002)(91956017)(71200400001)(66946007)(478600001)(4326008)(2906002)(64756008)(76116006)(86362001)(186003)(66556008)(122000001)(83380400001)(6506007)(38100700002)(53546011)(6512007)(2616005)(8676002)(4744005)(38070700005)(5660300002)(41300700001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?czRzaWRlRzBjMjRhUDJqbFhBbVJWYmlGZlFOY3o1b3VCeFRIRFhXN3Q4dnVD?=
 =?utf-8?B?Y3BaUjNBWTJGSTZnZUJVTFdieWV4QkxTc3ZJRXBUV1pMUkF4eWowS1Z5UHNF?=
 =?utf-8?B?UVNWN3huZHpjdnE1KzZZMTJlaStHRmtaWVJpOC9JM3hTMXhXYTdjWkdhYUdV?=
 =?utf-8?B?SEVBd252dVVvaWdrMmFQS3ludXh6ZmZTOXRMb3JkSTBuei9pNnBLVlhyaWRV?=
 =?utf-8?B?YVE2SUxTZ1BnODdRNmNnRzNzUW5iaU5nOWl5d0tybkRESFFnNGtIZEVseHIv?=
 =?utf-8?B?MkVTa3RDZGpBSzhvRUQ5WXBXN1NTUDdHam5xMnorRFhSL0RHRTNEWmhTbitO?=
 =?utf-8?B?cUpHVWNYTER6VDdrYUtFM1JXVlpCUVJzTURNeWRBTGNsSkNFaWprUUZGQkFV?=
 =?utf-8?B?MTBveWVvcTJNVUt0TXlDNnoyVHdMK3FabzlDWEFwNVlRT3NRRjRDK0tYVHlO?=
 =?utf-8?B?NUExOG9FZW8xY2NKYXhjMlhNaE05Q1NtUUl6TUlWSlA3VEhVL0pQRmw2eXBE?=
 =?utf-8?B?MHAvaWVzN1RzV1pKR1FBODN4Ti8vMnRHQ0Y4OVR1Vko4UlV5TUgzUmNWMWdF?=
 =?utf-8?B?WEE0MUhnYVppS2EwbytERkxZelIwK2ZsKzlSbEpQelBsQmRHT1VwTmRWT09C?=
 =?utf-8?B?cngyTVFuZDVRNDBXbklGS2h2RzExcHlPN1BYU3JoLzd1NDZZcjJZZ2FhdkFl?=
 =?utf-8?B?UC9IcGwwMVdSeUMvdFRaNnNESjVjbUVIMCt0Z1hObmxOSjBLWjJHN3gzRng3?=
 =?utf-8?B?Q2ZTL3QzTmR1NU10L0VuaFdBNnBNYThqd0FqalRNK3I0V2d0L3hxQlU3VXNM?=
 =?utf-8?B?U1pBd0kyWG5FVklHSkdoQUZCVWcvNno4THJzQXJabEljcENtZVl1WEdlTk9I?=
 =?utf-8?B?L2Z4Y3VtZEszY0ZsUHIzWWJpZ3RNUmhJYklaTnB3WkcrNFpJSkR4RnhhUEhx?=
 =?utf-8?B?aG15YlZodE5RcUdZRDVwQUtFelRFWlNzYkZBRllyZjRDdWhPVUk5VkFLNE0r?=
 =?utf-8?B?OEszWUduckplUEZuVFFWZTU5cDlPR0MycGliQmRUdklROWR5QmdnS014eXIx?=
 =?utf-8?B?NU1OcVVSNTR3OTdoSXlrUER5L21adFloNDFoUWV2Q1JDamRKMzRBczlxNXZ2?=
 =?utf-8?B?RU9laFl6bHcwdDNYQi9ZU21ab2lIanF2Q3dQcDRyZWlFdmNZUHU4WVFSR2h0?=
 =?utf-8?B?cFhMUkoxK0dhVUFUb2FrcXliSVlsTTY5Q05IeVVVMHhjVi9maktUV2dEQjIr?=
 =?utf-8?B?emJCUW15eWVtU0RPRmJkeGgycDlOdUlmMjhKUDZyOW1zd3N1WXNCdEFOSytn?=
 =?utf-8?B?eGoza0M5R3AzVHhxZ1JYSk1aQmFJQmQ4N1hJS2hLdzFNc01sODVra0JpZVNT?=
 =?utf-8?B?MUF0N3Z1Y3U2Mm5jOE1ySE1jeDBOUmhqNzNqV2xLZTZrMUJLUktkMzZDYkt0?=
 =?utf-8?B?WWNnOW5wNVRGMWg2VWx1K3JCVERqQnpCVXNKUm5yV0JsZmhMdUZQd0xnT29w?=
 =?utf-8?B?KzA0TDdxM2k5d2hjeHIrQW40dFczdVBVamZCenppN0F4MStYMjBJellNK3BQ?=
 =?utf-8?B?M0pCZEpVa2xlMU9oQ2FYcktXTVlxQithVXlMT2FHTlRlVW4zclRnNEFqc01P?=
 =?utf-8?B?UmY4MkpGMURsWDZON1VEenVMZUdpQ2tINGVJT1RVZ0hkek5rY3hDR25xWUpU?=
 =?utf-8?B?UEhaRGw5cm5MM1M4Syt0M2J1T1pldVdlaDVCdDVEaVljSEZIZUJaUkFKSVNq?=
 =?utf-8?B?UVlyNE8xNHA2MUN0M1F6dDhldFJEak9aYjhJL2h6Y2J0WUJCL1ZrVlRWZnFK?=
 =?utf-8?B?eEFKV0xvODFZZjJEVmJ1MTNtQWsrMytvYlg3UjYwNU9ub21hOVROV3NNVnJC?=
 =?utf-8?B?bFdDTllUNnQ5eFBLVmtKVDkrbm5PRGl3d0FGRm94eENXRmVVZ29ERWtETXEy?=
 =?utf-8?B?UUdYRzRLUWVsMlkrVlBHa3djODhwRlhsaU45ajNYT1k0RHlPTFlXaUlsYTNM?=
 =?utf-8?B?L1kvVnZhVGt5VFBVZnNkTUwxVkoxSlp4RzNZY1VzMFRpUERrZythV0I3cWkr?=
 =?utf-8?B?QWt0bHpvR1RLN05qSk5rejNZMVM5S29BdnhzaVhESEZLNUlxSzBOUG5ZL3p5?=
 =?utf-8?B?SjJVWFZITGVjNkp6dUY2cnAxT3RVM24vMU9oc3dmb3BTeEhrQXVKR0Q1U0FZ?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3667AF9A9D606B4B9758E2ED6B1D9620@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d3bee7-8e4e-47ce-e8df-08dac672eb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:03:29.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faP+frH5yvCO56w6XcXJw2HmXQOBYTALVMsmwlT1mYISbVFHfqKvOHNLDr2G+CBjjI6uHux7XyKpGWsDlW5K9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_110334_340344_87649268 
X-CRM114-Status: UNSURE (   9.78  )
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

T24gMTEvMTQvMjIgMDQ6NTIsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IHdoZW4gcmUtYXV0aGVu
dGljYXRpb24gd2l0aCBuZXcgaG9zdC1rZXkgYW5kL29yIGN0cmwta2V5IHRoZXJlIGlzIGFuDQo+
IGFzeW5jIHdvcmsgdGhhdCBpcyBzY2hlZHVsZWQgYXN5bmMuIEEgY29udHJvbGxlciByZXNldCBz
aG91bGQgYmUgbXV0dWFsDQo+IGV4Y2x1c2l2ZSB3aXRoIHRoZSByZS1hdXRoZW50aWNhdGlvbiB3
b3JrLiBBZGQgYSB0ZXN0IHRoYXQgdHJpZ2dlcnMNCj4gcmUtYXV0aGVudGljYXRpb24gYW5kIGlt
bWVkaWF0ZWx5IHJlc2V0cyB0aGUgY29udHJvbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNh
Z2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0K

