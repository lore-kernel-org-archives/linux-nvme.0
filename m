Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3319EC74A5B
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ovtTJ1nz9zccqXVhoEPxdVczuHmgIfwgxI9WWawNxLY=; b=QeUihONiJrcOtIGSyjUSsyBhrH
	yr9obpzb/hW7D7ymSfm1f6LmE/dbTxmK6v21tXZmj3d2xQhvojRYUlKHpauUxZmdyqtw506vDhd9Q
	KY64OPW39I1YrOIJhvkTgqGrKCQlbcEhrHk5aN+dkzXTiaYq/r9dpYjmAON5rZB+BcB/xQrzYveOg
	HjxnDAh72o19Z0Xs90bb11ZIqUMIhQa2O+caNDyiezDExEYeaYq4NrUNadbWy9ikM/tVXYXhJYBW5
	qp9AWtMjgchUn9FHIj/su1nnpXHeDSq3umIvMZhBQWTEqzijS1lfILZbZAyWOT5KSWR0Eg+0ODuVp
	gl0wcIcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTJO-0034PN-1d;
	Thu, 23 Mar 2023 22:21:34 +0000
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com ([2a01:111:f400:7e89::604] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTJJ-0034OV-2e
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 22:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPdanNlySdqK/cIM8kEU++kf/3tC21qN7m4CiFQg3dyHz5sK61CCU9LO4y/b5/C3E5Zj9q1yBN+xPhSKAmejVaHOxNPWaBoxyyoD2UdHuucN5RMeYZ78HG+B97sg8RM6/dwO4ODExyT8+rUd1ljeLpIF2kDbvnVAQb6p0njsik26x4d3pjJfMQpky78Rukl0g42MWkMRaDtBnZLXCjDGYeE9Oru3+vB2bNNRKhmqlgf9+cmDFdW+eEEzObjZ7ZW2i+vWnuivVzR89XmojwZGOABSKZA8lr2Tq0DhT9R1BSfnrgsjtpxzOtufX5uPJNyrNHfPE47Qfv8XlZvsy5dCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovtTJ1nz9zccqXVhoEPxdVczuHmgIfwgxI9WWawNxLY=;
 b=XyowA2LtwIIVP4b9epS1H2VxEmlzOGOIiRSDKGmNk2uXTvrm1kGpUproGHCgQVRm87SSn2FvpjaAGMpKK/xcDrx2244zRHe9baUErKxwWpU48YlAr1ytFe7JMO2Yre56WmBxCO5Hby5OaqspEDoiJCAEmJtPSGOczFpVE0lXyHWlo5XlcogMBVp0lkPK2xVF4dFhPEEYc9U0l8Mdspsuyey70hD00bB/bYmOQcDI4FQibH8H1L/FlRmruaY5/wd9PYB5h7izoUuPdWKPIvCe6mN/OMTUuxoo1UpnPxktnQ9VaJv7rySL+7e3G/bEnTtRwB+Myic8ThBfZbW9IsNsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovtTJ1nz9zccqXVhoEPxdVczuHmgIfwgxI9WWawNxLY=;
 b=FHKiT/7NQzQFMIbeOkauGszIJQyuXnZD+AtQ7YdS+UgsJX7sAiHHDgDPGXuj5Q93amt5z5dmnvN2f/8TrpaVs5u9/7F+r8bSMQgY1fUy4JzwcEWoIyy8SPk3NOfh6vtRIyUUPbI3HfyDys6kCkOsUgYna7/v+8ajpsTgDXULnnOx5tLBrPvZ/tOvriElme00HE9p8G8ShcIVHj9vnLUSxPJH8bDy1WIiJjeDCz+6O73EYh+zXTj604hitOgVlEgHcj2c2OFFzGE+XDInhvDvBFdHHM/5RuyjwwlNXHzhlxr42DUUXcUuQ33U3BcYMSNBKo1t8rqxmo0DndP5lYR2oA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 22:21:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 22:21:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Thread-Topic: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Thread-Index: AQHZXTjBXaqTKuNmt0amN2Iq/alJAa8H/26AgADxvIA=
Date: Thu, 23 Mar 2023 22:21:25 +0000
Message-ID: <2745623e-2b0f-edf3-2cf1-7a8ca9415545@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-2-kch@nvidia.com>
 <5639f28e-ec89-f2f8-5737-8209b36088e9@grimberg.me>
In-Reply-To: <5639f28e-ec89-f2f8-5737-8209b36088e9@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6066:EE_
x-ms-office365-filtering-correlation-id: 477f2c3f-da97-44eb-449d-08db2becf104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  DmRrn6nsKOztbLxpcYxzkJwFTzNNaUo9GskrFCCAqG4Bwd15uq5YKNpF8uC+/qoML5ltknNzKIQIwefIr+6fxEXzdjO94Y5FmnaoZsW8MM3oP1Mf4TQ06RUwzs0lSvBkzEQPfCDFnKSSCs125GKuoMAb7GgtQk1UWs/PTpDO4sTN++4x302jt/G5ca4UI9Dt0yOdbhGXtKXwyHBIrKiRSBkt3j2Uc2roCLly/Zq+gmsW6/yU9VvQO3+B6z/pUtkxofc2yKpXdqbn462y/e962jExAHFZ3YGRuLdAgutFM4ufF/Y1B1ClZTx/V3Z4k5ipq8divupWfiIYSajL7czPDLINrC51LU3LRR9QdQ7ciFPJEOvIyWZ0cdF3p0hjOX/0A/8wyfu4tw1srNZwGjKH/qyuHj5uepQ34q1r55EFUD19aZgQhz9RFAAEfVrjj7b/aZNDiVXcoavzV1pe3QyeY340XUnJYjV75LGKn+gLp8taG6li/xMz/ozrdIpIkrCbH0uJLdll5TxitvB9tDFUBDLKjnWtHVGYYhQFmevLXTkm/wreh1JOe6i6P4OgwBpFT6M7hGbGgEZu05LAA9tOASTO89iKlBzZ2NVcC5Uduen9JbUWxRaPnAQ5e6byCSBiGu6wkJMIM6oazQwdFqi0RF5ctw5B1YGG2msggKXUmGspDf8hf2H9ajzn3oTbXxdgkhoM8rMD68JEbb8PJG69ForHlyP1LfECGPaCpk0Xi97kiLQqMO6osKY0vzNd08KBC391/8bGCKH3cdsc8qh+Pw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199018)(36756003)(66556008)(66446008)(8676002)(66476007)(54906003)(76116006)(64756008)(66946007)(4326008)(110136005)(91956017)(41300700001)(5660300002)(122000001)(8936002)(316002)(4744005)(26005)(53546011)(6512007)(6506007)(186003)(478600001)(71200400001)(2616005)(6486002)(86362001)(31696002)(38100700002)(38070700005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?OXcwR01KR3VheVdUUmE4S25sZ0lnRzhwSHVjd1JleDRUNDhKK05VWGo5bDR3?=
 =?utf-8?B?UHc1eWZRcnoyWERmYkUySUdIY2VPNjY1aUlMZzY4cXFzcGpPZ0ZacFk0ekpW?=
 =?utf-8?B?YnlJb2w0YjdXNnVrQ0JzQ2J2Zkllb2ZkZUtGeVFUcjFtTll0bjh0aG9XQmxn?=
 =?utf-8?B?QkhtU3Fxc3lvSUtuNmpqNEdQSG1JN2hhTkZjaDRGY29Xc1JkWjR3dkRFcmhI?=
 =?utf-8?B?UmMzZHJUZnZMMTNJNjdFQktacnhHVEU2MnFlQnBoSjZGTTBHY2ZtZUhNamF2?=
 =?utf-8?B?V1Bqcm9qWVpIQ3krWWZ1clJBcy8wVU5nSGpsU0xIY3FIMGp6aStPZTRUZHo0?=
 =?utf-8?B?MzJpNUptNFBsaFcyUjB3enZtRDFEWDZKdXJDZUN4VmNuM2ducFl5UGJ3M1Vi?=
 =?utf-8?B?OTBsQ3Z2Y3JVVmk5ZDhsazZ2UlE0clhwZWJ1VUM3eForbEd2aW9EZXdBUVJu?=
 =?utf-8?B?MmtxTllTaXJKK21SNWlaNzZIbWI0ZW45MFpHeElydmw3eXpjTE5EUVUrMlh2?=
 =?utf-8?B?c1p1dGEyWGJ4QWpMeHo2WTF6T1N6TW4rTklzN3NiYVc0RWhFeEpSYzNoQkN5?=
 =?utf-8?B?T2plaWFVS0cycWVlcm83MWpmUDFETUhET2xybnQvTDVqVGo4ZjBTNFRjUWZ6?=
 =?utf-8?B?ZmpYV1N5Z2dmRVBqak1lT0dEUzJxcEVlbHRLcUQxU1VsNGtoVmNnUk83MlFY?=
 =?utf-8?B?cm1vT3RodTF0ZDVQaGYyUnRWbmgzbGJ1WkhVWVd6VVpwdDRWSXIwczJ5QTBW?=
 =?utf-8?B?WHhBYkVBLzg2alRZQzVpUm1LU1VqSndZckN4cndzU0hkS3kxWXBqQ2VGMzBE?=
 =?utf-8?B?VmxEYnUrbkprOTJHTzc5V0l1R3VzU1FLQlM4ZkZ4eWFWUUg2SkdDbXpwL0M1?=
 =?utf-8?B?dUQ5RFNncXFETjNma3R4RWJTMmozdVd1MTFDMjllckZtRERpaTFzMkVzOEoz?=
 =?utf-8?B?VlZOdldmemJGRk5vazczQ3JicWFrYjh6TEE2QlZZQ2xURGQ2TWJHWXhlY3Y3?=
 =?utf-8?B?SE1XWnhZV1NSOUdPeHNlVXVTaGZHelZrOVl1RHFRKzVaamZrbWdYWGlnWEQ1?=
 =?utf-8?B?clBhSjRwMlg2MnhwV2l5V2d6WHpvY01FRFpDa1VMYVZiMGdmUDFPbThjMEE0?=
 =?utf-8?B?VnJ3WDhVRGw3Rm10MEpCYXJpamczQXhFOXl4c09kc2JYNUFLZUdENEZYeWlk?=
 =?utf-8?B?d2pWMS9jZ1poOGpJSXlyWWwySlhsOUVhbkhNS2NYU1VNdWl1YXFpUWI5ZXpa?=
 =?utf-8?B?WEh4SHkxWkI1cTVKVXdscDFDaUhTTUovZWw3dGRNdXpvQTVyc2hrVkdaWFNr?=
 =?utf-8?B?KysrOHUvaDdGOXJza3NMcjFBRHhnK2lXVllvZWpsci9HR2d4dzF5RUZNeVd2?=
 =?utf-8?B?OW8wVUdNTUFFVUYvS1hubW1mU1FlNlIzRUY4dWlPbXMzSEgrWThRdVR1RUt3?=
 =?utf-8?B?enFpWis1RnRrM1NxN2gySmFBSmN4N2c2bi9WRDJPWG9Qa2xlbXg5WXQrUGs3?=
 =?utf-8?B?S1MwT05mSXRKczd3ZWdkTzJpV1BINUpudk5nVlNrcDU4dXorNmRqWTZoQVlL?=
 =?utf-8?B?Q29kZVpBbjJxRk5zR1kwUE4wMWZuSHNodnE2N3BwU25WTnZiczVpMi8yMm5N?=
 =?utf-8?B?dHZMdUhsMXgwWTY2eVhKUXJhVXcwb2VyWElMQ0pibWFwM1BXQnQ2SHdXdVZH?=
 =?utf-8?B?bDVKVjlEUlRyT1BQVy9uOHZidUZ1TENpOEpiRW1qRTJFSUdGakhONXBTc2dh?=
 =?utf-8?B?aGZPMzQ1SzlBekdEZm1XSFYrNkhqUXRjMnlEUzd4Uk1CVWl4M3RjeGFXZ0I4?=
 =?utf-8?B?TkM0ZFNBSzNXV1lsZDZqckxXaExXVndrdVEvS1NFMWpYb05xVHNPd3RTY0ZP?=
 =?utf-8?B?VE54WGpTRVFUTlZYUDBJK0s0MStsdHRLVTVBNnJlZEhsc1kvRk5EY20wTlMy?=
 =?utf-8?B?bE1Ea2pIWmYrREZ6SmJpa0pUSlBsL1k1bnViemV1MDkxMVE4WG80eWppWCs1?=
 =?utf-8?B?djB5SVZkU1phOUhaem5LUHJOVFV1b1lZRzAweU9lYk50ampHYzBKb3RrcExi?=
 =?utf-8?B?dHpkRzRpWitnMVkxNEZvQ0I0cEYvWlBDSzZka2E0aEFLT0w0WEd1eXEraDhW?=
 =?utf-8?Q?ka71d+gIuhcwxo/nqcxD87O1Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF5AB3353486D84EA7F5C34090599C3D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477f2c3f-da97-44eb-449d-08db2becf104
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 22:21:25.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bu8v70MZDY9Vm1gPM1XSk3Sa2U1VPoH+nW/0hLuI2qYeVrF6p8bW19o/huq08rKDFiDCPNhYBwzQ/iDmcbde5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_152129_865080_EDFD3EF7 
X-CRM114-Status: GOOD (  13.19  )
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

T24gMy8yMy8yMyAwMDo1NiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4+IFVzZSBjb25zaXN0ZW50
IHR5cGUgdW5zaWduZWQgaW50IGZvciBzaHV0ZG93bl90aW1lb3V0IHRoYXQgbWF0Y2hlcw0KPj4g
b3RoZXIgdGltZW91dCB0eXBlcy4NCj4NCj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGFsbG93IHNo
dXRkb3duIHRpbWVvdXQgdG8gYmUgdGhhdCBsb25nPw0KPg0KDQpubyB5b3UgYXJlIHJpZ2h0IGl0
IG1hdGNoZXMgd2l0aCByZXN0IG9mIHRoZSB0aW1lb3V0IHR5cGVzLi4NCndlIGNhbiBkcm9wIHRo
aXMgcGF0Y2ggaWYgeW91IHdhbnQgdG8uLg0KDQo+IMKgQWxzbywgdXNlIHRoaXMgb3BwdXJ0dW5p
dHkgdG8gcHJpbnQgZGVmYXVsdA0KPj4gdGltZW91dCB2YWx1ZXMgaW4gdGhlIG1vZHVsZSBwYXJh
bWV0ZXIgZGVzY3JpcHRpb24gdGhhdCBzYXZlcyBhIHRyaXANCj4+IHRvIHNvdXJjZSBjb2RlLg0K
Pg0KPiBPciBzaW1wbHkgcmVhZGluZyBmcm9tIHN5cyBtb2RwYXJhbXMsIHdoaWNoIG9uZSBtYXkg
ZG8gYW55d2F5Lg0KPg0KDQp0aGF0IGlzIGNlcnRhaW5seSBwb3NzaWJsZSwgd2l0aCBudWxsX2Js
ayB3ZSBoYXZlIGl0IGluIHRoZQ0KTU9EVUxFX1BBUkFNX0RFU0MoKSBzdHJpbmcgYW5kIGl0IHR1
cm5lZCBvdXQgdG8gYmUgdmVyeQ0KaGVscGZ1bCAuLi4NCg0KLWNrDQoNCg0K

