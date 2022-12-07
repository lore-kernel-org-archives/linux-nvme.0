Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DF4C4708D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 22:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HQ17TJlTuC9a61O1NhXjEqikpXzdwLEXKjh4+kZ7mk=; b=2gs5JeAuUZekJlxXQLXdE3eDNg
	Eoy1VDg0dJp+TwrVx9g6GWRZTY/jKlkzgiSbnF9f5STCS/Uua/LyOwUL9UxJC6TP/DAgNsoXkhLUW
	T3+er4dd2lnDAW0fetoU3fnx0nFj4vVBh+2BJV4BO6tt6R2z8NTlAlSPAIitxHDKD1XGB7VUbv1T1
	+3awdGguSmN5CFp/VdmUD8xEGLzvtOQcLUc9dZlwve41CzayFwPBHl7K7LWMqpUyZZa0KdS7+m1Pd
	ScW7L8NNEUbcfATLd8kiPdC0YsAGf1lrKIHZjzZm/4BCHPkOODZaXEM5WTjttw2RaPd9vT+PGv0P0
	ajFv9r0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p33JF-00EgMl-8i; Wed, 07 Dec 2022 22:54:37 +0000
Received: from mail-bn8nam04on20615.outbound.protection.outlook.com ([2a01:111:f400:7e8d::615] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p33J8-00EgCH-92
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 22:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOrO6b8i9qkYJ0NMtE83/F8wc2bcFKhMt2J30qe7behMM/9pSKcJ9p84NRwQl8RWxDdkZLVIixzEf/jIFTHowCI+cHMerTiSCkStxSvd//3hajOXzB6bTudj5QSfR3Nu5Aka6lXd/g6cc0RLTW0Tn2WmIBFcKViztS9xCMv6BQ1h9q8OR3XJAt+I++dNlsb0Nr9E+nNatnn/HJfP5LbQyIH4XAaUAcA8ofAdTJn2fa5yAWeiGVIaWVWayU2xj0EWkCs/cMa3XDdusHtToRS7vk6EgvbN49OaIr1SlFfeDVd5WE+2GzEmEkCMdywWMNx0sxv743mpMr00ZSBwk84gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HQ17TJlTuC9a61O1NhXjEqikpXzdwLEXKjh4+kZ7mk=;
 b=f2QdKQ2Uk+lIyEqRcUXJQYtNoW4CpaqIpgLCG2wZhX1suBqkb0+YwPKsx03dv6qUV8SV9fMOuFIupKEl1C+buTv2PjuRudjDTIdUGAk4Ta4xyG72RHpPsaPZbJG9NXEc4I12tQbk8XBhWOZ+aSv4y/IG9CVsfsYy3JiBjqaaDHT1VAfJmUgszeGYByoAOBTVf34QgbyHiwUBduJChakMt/bg8i3D9oRaq4f9Be8t7kBwxxwbAZBo3nPhkhDQVWVotxeOfw7YPtgJGBlo3CVv6sDVnUvSo7qvnSK5zgIiBJu2D8LqyjAfx3p5rVkHXa6/GtsIAS1qV1/PQSNHAruHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HQ17TJlTuC9a61O1NhXjEqikpXzdwLEXKjh4+kZ7mk=;
 b=dRsv6ap591gb53HE8R33/dmRkRa78qOTRVtX3478RXaq0CtAkZO0YVwLnt+AAESuv5nQTgxEi+ULuDzkSmjYZuB8GdgqZAnm0bCyNBxiIFPFa1xCXR+ltIw04mL8xhVaxL7EQQNHlsUv1/AJZAx8FGHfddkGhzYuZxklG0gNrgXEjjaH4MQs66OXHGZK23lHuVCQgDU+95tYQLpJsK6DVfuTp4aD06efT5hnRY+Aai+U8r9XhOcSw6e52ZLbCX7ydtRUih8Dh7mR7YpxZtiuFHVYTSByt4XOuL6iDDO9tXiO41B1bCt7BmE5aH1ttfnecZ7rHobABlM8BY6YvVDYZQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 22:54:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 22:54:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Thread-Topic: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Thread-Index: AQHZCTfa4o51k6EUw0ehWDpBStWQ6a5jB+qAgAADWQA=
Date: Wed, 7 Dec 2022 22:54:25 +0000
Message-ID: <e96442cb-a296-4f90-36b5-432a2c0b660f@nvidia.com>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <ef7bffa5-5d74-ada2-87e7-2f0a442f3240@linux.dev>
In-Reply-To: <ef7bffa5-5d74-ada2-87e7-2f0a442f3240@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4243:EE_
x-ms-office365-filtering-correlation-id: c40816d7-1ddd-428e-ebf7-08dad8a5fd24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  AX+UzimRlIMToktT9DnsSxn/16yyNgevksGPFiPG4Q4AJPnZ9ixxrJ0OS1UrG60QGEdaGQhLj7XKLcd6P4BSICLPKv4Jr+pIK6DOxz5SSeT44hLrenaHkHpbMvxFBh9v+dqJ9ONsJTTQqietLUQQoyxcbY/KDHWN4haTguaXCPuFWf3JNhk7dAqGg4yqGcxtdL8/8vPAeEn5oxzSR4i7PBMXWeIDrc12U/4PRxnIu7DNVIf+qAOIQ7Kido+A+2GAiX8Yz9YvCXIP4N9HGcPAfjQYyj3K4CVYhj1h5o80iFNDA9naElAHKYmtblA7mLct/xINHWc/BU8e3P/z6QVzhQJheK7IKnHxbiGOx3KrLEC1TIwx7HiuahZcmroaUqwj2cVD7dE8tIVBUFRzTKk+3Ry8BQ8m1/cfSj7vmL6Z60vfrLGIm+t3CLJXLZ176OC6OOpTaaI7apJPiQy4qq4O3z0tJTfRbb16G32u04aDygA05WGWJbuGJoUtVVI2Pzw+WzaFEyUzt0IjwI7hP296xBDFkVEnVAD00mszYHbaDXEPiE714Xg3fSqZmHHFZGZwcrW6SvpLLPhaOI2s4qFdulBkgbzPD0EXbA17dTmeRsDVpWVvmsVfRhlXp2SMH18BQwUv4gcX2YO2KjsUw5K1YtViI6quaLsAZWzUEu4kUKT0/V//hwKPuJPuHAjRcGDDQ48vSmH9CNee8KYEhSlfKZOxVY02/qRa1P6K8gWTMGi8X64xB2k5G8ZqEaA7UTJZIOfZPtgsP0vFOLbDSQ1o9A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(6486002)(478600001)(71200400001)(66946007)(186003)(86362001)(91956017)(31696002)(6506007)(110136005)(6512007)(76116006)(316002)(8676002)(66556008)(66446008)(64756008)(66476007)(38100700002)(122000001)(2616005)(31686004)(41300700001)(38070700005)(83380400001)(2906002)(36756003)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RVBhcURmT1VBaGtnb2NWZDN3V1k3WnZ2Z2Q4UGorYTNBM1NUNnN2V2dQb1Uy?=
 =?utf-8?B?NkF4YXh2V1NXb2RsSEFMcmhscStUTHBHbG9MY1NXL0ZGbmRRaWVnQTNpVHJO?=
 =?utf-8?B?Y1NWZnRSOHpjSU5xQThaTDByaEhhUldVY01VcVhxNEo4NzRzMzVWTHpEanl0?=
 =?utf-8?B?M0tCbG9ET0M2UWRCOXVIM3l3WFpMZllsS2d6TnpyMFlUUzdZVW1IaCt0TFpk?=
 =?utf-8?B?dGlsYjlKYXh0K2pQR1o0VmlPTUhKMktCeUlOVVQxcEVDenJvUGxnSjY0V0tY?=
 =?utf-8?B?cDArcldnajdYUG5tem5paC9rd0RCNmt0M1pYTXErRFpiV1RtdExDa0JmNUJJ?=
 =?utf-8?B?UjFJaGt5MVN4YVRENXJ1ZGh2amZNd2J6eFlMMmRZNXVHaVRsRTd4ci8wMnAx?=
 =?utf-8?B?clNxWGY4ai9lMld1Vzc5QVA1NEkvYUZRNzRMcU94WmVzUFhCUnl5Mk1rZ21q?=
 =?utf-8?B?T0V2RjJQQ1FoYmxVMGE1dExnQ3poZTFXZ0dtOWNpb1hnUXN3V0pZaUJ4UmZB?=
 =?utf-8?B?RFducnNITm81eDRFVTAxazROZUN2T0FmUGxIaXhsNmlNWm5YUHl5dTExSU93?=
 =?utf-8?B?dlVvSDJsc0FlNEdwNnNISkdTUnhtanRjS1F0dFcyaXQ2eElXM0dyT1lRZjJR?=
 =?utf-8?B?ejN2K0VZNStOT3NMSGt0aXN5N2VVV1pRb3hSUlBiSmthd1o5V1lsR3ZlL3hI?=
 =?utf-8?B?ZzQvazFXY1ZiMWVVcGRiZ0REbDFDQ1BuZkNRQ0tZM01DMXFJZDVaUTdHdE1Q?=
 =?utf-8?B?S2Ivc25DR2ErdTNHRGRRbnN3WlNsbVJsR3E5MDhGcngySkxRZnBFb0dPc1Iz?=
 =?utf-8?B?TjdlNkRCZ2dGSGtJOXk4c2VCS2dJU3BRcHpadzVxcFBtc0x2VzY0RHdwallV?=
 =?utf-8?B?aUN5V0FQR0dXVzgvaU9LMmJUZ2dNVE5KYzkzSm13SFQxeml3cUV4RGhJQWZX?=
 =?utf-8?B?ZWRYamFheWtUZ0pLT0NQRVB0Z0Nqd1ZiSTJ0VGowaEs3RjR5TkRzRmtHU0Iy?=
 =?utf-8?B?RkpBZ2xSTEpMTkRiZ3RRQmZCQzhNbGVTRVZhMk0vV1RRdE55dUxWZHc4Q3Fj?=
 =?utf-8?B?dzB2WHhtMWZrU3lwanNSRGNOOVd6L0xmWlNldG5QdXVJYkdvTzlzN01lOElz?=
 =?utf-8?B?VWJqZGFtWWpvMklSRUxoMGo1TkNmNEVnYWl4ZnFFa0pIV1JnSDRhcDBMZjV6?=
 =?utf-8?B?MG9mejFYaXB4TkFNNU9UdW5RWkdqN1BMWEJYZGRYVEMrUnl5NmtubVFuaFZw?=
 =?utf-8?B?N0lqZUpCR1lvV1ZkRUtwVjgxbkFXcittVVIrdndmaGd0c3hjVW5IS1p1d04w?=
 =?utf-8?B?R242Q0RsQnpmMVpUNjJvell2Vm1RYmRXT3ViZkQ0aUIrdXIweEthb2tzM3dG?=
 =?utf-8?B?ejY3Q1hnUE8yMXJUZnB6WWdsUTZZdkVkM2R0UGorYjM0UDFRQVM2UDVKTVFr?=
 =?utf-8?B?Q21RVlREeGpqVG9zVVFoNElsR2ZIWGNNa1UwSjJ1TUxyZHp1cFloZ2dIc2FY?=
 =?utf-8?B?WGJLMnd0ZWxJKzVyc2gzb0ZmTEU0bTNVdm9ESTVXN2pHZE5tSmZRQkdPZ2F4?=
 =?utf-8?B?T0dSVHJjSmlqclo4TGpTT0R3KzB5SUF5MCtPL0M0QjR0aDBQTzBLck5Kd0RG?=
 =?utf-8?B?QWdtTXJyYVlnQ0pDaTBxT1ZyQ1NlM05mV2l3RVpiU052elhEUDFmNWZMdVhr?=
 =?utf-8?B?My82SmlTTTdHdUs1R3ZLQTlSRGhwc1kzc2xvVm8rZ3Nva09hS2hsWW1OdFk1?=
 =?utf-8?B?bXR6ZWFIZ0dUYWliREpPVTNyK0xLS3dzaUNFS1I3OHIyclBNRU9MUXFuVlkr?=
 =?utf-8?B?UWM2Sm1ZWTVlSjYwQVE3ZUgwR1hJSkJMWG8reXhkQVF6MkF2RGpSWFFFZG5Z?=
 =?utf-8?B?MDN6YTQ4cjJGSmFsTEE0cFIvQW40Q0IrMmYxYkgwU01Fb3RlR215M2ZpZlpR?=
 =?utf-8?B?TWpKZ2tsdmhHay9FREZic3FEc1ExdXBZaXJweERKc2RjMHhRMDUrWDhIZEVt?=
 =?utf-8?B?dVBkSkRjMGVKRDUyMm8ydTZiV3dGWTJCTHZZSEJGRzQ1WDhPQWZoS3BaS2x3?=
 =?utf-8?B?U0s5SkpPUTlBdUw0YXNpb3NkTmJqTWRnWkx6Sks3VDkvektKWEcvbkFwcjdM?=
 =?utf-8?B?cnFMcllzRlpXOFJXenRDUW9jT3ZtZXJxQ1c2VWdjTHRlenJJWGpJODlrL2Za?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DCC6FED8D10D040B0CB45F1526D2562@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40816d7-1ddd-428e-ebf7-08dad8a5fd24
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 22:54:25.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTGDhfCmtfMbHpcpwo8sn69YiUWrWTIUWRC6nKQuzLnfxspXcr94MRmd1A34Ly1k82HDI6wJHMzPRhrHrNtrLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_145434_285249_46FD4619 
X-CRM114-Status: GOOD (  11.17  )
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

Sm9uYXRoYW4sDQoNCj4+ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLSsNCj4+ICt8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4+ICt8ICAgICBPcGNv
ZGUgYnkgRmllbGQgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgIHwN
Cj4+ICt8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAg
fCAgICAgICAgICAgIHwNCj4+ICsrLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tKyAgICAgICAg
ICAgfCAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4+ICt8ICAgICAgICB8ICAgICAgICAgfCAg
ICAgICAgfCBDb21iaW5lZCAgfCBOYW1lc3BhY2UgfCAgICAgICAgICAgIHwNCj4+ICt8ICAgIDA3
ICB8ICAwNjowMiAgfCAwMTowMCAgfCAgT3Bjb2RlICAgfCBJZGVudGlmaWVyfCAgQ29tbWFuZCAg
IHwNCj4+ICt8ICAgICAgICB8ICAgICAgICAgfCAgICAgICAgfCAgICAgICAgICAgfCAgICB1c2Vk
ICAgfCAgICAgICAgICAgIHwNCj4+ICsrLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tKyAgICAg
ICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4+ICt8R2VuZXJpYyB8IEZ1bmN0aW9u
fCAgRGF0YSAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4+ICt8Y29t
bWFuZCB8ICAgICAgICAgfFRyYW5zZmVyfCAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAg
ICAgIHwNCj4+ICsrLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLSsNCj4+ICt8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICt8ICAgICAgICAgICAgICAg
ICAgICAgVmVuZG9yIFNwZWNpZmljT3Bjb2RlICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICsr
LS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLSsNCj4+ICt8ICAgICAgICB8ICAgICAgICAgfCAgICAgICAgfCAgICAgICAgICAgfCAg
ICAgICAgICAgfCBRdWVyeSB0aGUgIHwNCj4+ICt8ICAgMWIgICB8ICAxMDAwMSAgfCAgMDAgICAg
fCAgIDB4QzQgICAgfCAgICAgICAgICAgfCBkYXRhIHNpemUgIHwNCj4+ICsrLS0tLS0tLS0rLS0t
LS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLSsNCj4+
ICt8ICAgICAgICB8ICAgICAgICAgfCAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCBT
dXNwZW5kIHRoZXwNCj4+ICt8ICAgMWIgICB8ICAxMDAxMCAgfCAgMDAgICAgfCAgIDB4QzggICAg
fCAgICAgICAgICAgfCAgICBWRiAgICAgIHwNCj4+ICsrLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0t
LS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLSsNCj4+ICt8ICAgICAgICB8
ICAgICAgICAgfCAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCBSZXN1bWUgdGhlIHwN
Cj4+ICt8ICAgMWIgICB8ICAxMDAxMSAgfCAgMDAgICAgfCAgIDB4Q0MgICAgfCAgICAgICAgICAg
fCAgICBWRiAgICAgIHwNCj4+ICsrLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLSsNCj4+ICt8ICAgICAgICB8ICAgICAgICAgfCAg
ICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCBTYXZlIHRoZSAgIHwNCj4+ICt8ICAgMWIg
ICB8ICAxMDEwMCAgfCAgMTAgICAgfCAgIDB4RDIgICAgfCAgICAgICAgICAgfGRldmljZSBkYXRh
IHwNCj4+ICsrLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLSsNCj4+ICt8ICAgICAgICB8ICAgICAgICAgfCAgICAgICAgfCAgICAg
ICAgICAgfCAgICAgICAgICAgfCBMb2FkIHRoZSAgIHwNCj4+ICt8ICAgMWIgICB8ICAxMDEwMSAg
fCAgMDEgICAgfCAgIDB4RDUgICAgfCAgICAgICAgICAgfGRldmljZSBkYXRhIHwNCj4+ICsrLS0t
LS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLSsNCj4+ICsNCj4gSSdtIGFzc3VtaW5nIGJ5IHVzaW5nIHRoZXNlIHZlbmRvciBzcGVjaWZp
YyBvcGNvZGVzIGFuZCBpZC1jdHJsJ3MgdnUgc3BhY2UsIHRoYXQNCj4geW91IHNob3VsZCBtYWtl
IHRoaXMgY29kZSBiZSBwcm90ZWN0ZWQgYnkgc29tZSBraW5kIG9mIHZlbmRvci9kZXZpY2Ugc3Bl
Y2lmaWMtZmxhZw0KPiBvciBwcmVmZXJhYmx5IHNvbWV0aGluZyBzdGFuZGFyZC4NCj4gDQo+IE5v
IHdheSBvZiBrbm93aW5nIHdoYXQgMHhDNCB3aWxsIGRvIG9uIGEgbm9uLWxtIGRyaXZlLCBmb3Ig
aW5zdGFuY2UNCj4gDQoNClRoaXMgaXMgb25seSByZWZlcmVuY2UgaW1wbGVtZW50YXRpb24uIFRo
ZSBwcm9jZXNzIG9mIHRoZSANCnN0YW5kYXJkaXphdGlvbiBvZiB0aGUgTlZNZSBMaXZlIE1pZ3Jh
dGlvbiBpcyB3aWxsIHRha2Ugb2YgdGhlc2UNCm9wY29kZXMgYW5kIGFueXRoaW5nIFZlbmRvciBz
cGVjaWZpYyBwcmVzZW50IGluIHRoaXMgc2VyaWVzLg0KDQpJdCBpcyB2ZXJ5IGltcG9ydGFudCB0
byBnZXQgc29tZSBmZWVkYmFjayBvbiB0aGlzIHRvIGhlbHAgdGhlDQpzdGFuZGFyZGl6YXRpb24g
aW4gYW55IHdheS4NCg0KLWNrDQoNCg==

