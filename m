Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FDBC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+04kYh4Dhl0ZFeFQTDwbbfVPQXUGbHya+zbBYVQB8/U=; b=nO8bdVU0YMzSm83lfF7v5i7bCz
	gQax9KYcX1LG0zJSA3CDcp2jANe77Ec8TToyQGOirEB4dKygSzpl9em6vUOU7U+HqkXV/5jSrosdN
	wqVqqbd6C0cp15UcYNKF9DiVld2r3AdT7QQnm/UPis9JsrrtMcWBVkRSPTPuTV2niiUcU9LDv3a/H
	Ih4BCrgaHufNant0F9x/i103q8mLzJCaqV4749ifTI9Pv+giAeWlbC5e402PoNg8qo2aFvt5upvLi
	g5Xc2LszOL05S4jV3Wpwr7bhg3TLNuWCG3kGRQU+AJmZ14M0+bcHUhs4ZXkAsRaOAeduj4+v6P5gA
	hey56S+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Tnx-002Rj8-11;
	Tue, 07 Nov 2023 21:40:13 +0000
Received: from mail-dm3nam02on2061a.outbound.protection.outlook.com ([2a01:111:f400:7e83::61a] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Tnu-002Ril-1m
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 21:40:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdTYA0g+LI5pNhX9yxaOuF9LXwlxub5FQYsbVTPLw5jHAg0TmkLR4sECfwc92hAzcuZdv61WLNu8iK3I97FxsOqHy5L9AHmDjgohfesPRZlrNkP2ICtP9ciNpMGg4EWCAhStW4csrUjkxkZkoOE2f9jdOcjv0eZD3PTLVwB98CzVUbzLZJpmzf3SGFUImcR8qvuApzq5RwbV51Qyt0JV9TsT6cGFs1OzffhSZQhEpF2fTTK7ME2VhXXkbeZB6b3C3/Dy9eTR0cKUqiPD44jSEYGvrc0Ff88Ute9VuVhZRwURadWjf9OQQ/hpEmQwgtL1pn8y+Dxz5U8/2QTfbe1D8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+04kYh4Dhl0ZFeFQTDwbbfVPQXUGbHya+zbBYVQB8/U=;
 b=TTkmK+EU4Cr7ahRK9VaQfuZLiWq1J9T/5/xWLelSRfoVCvnpLR3TNrHImnPLoyNJXtvEPNPWgoxyYnMY+5Ww6Nz5I2YsDUsPqvuagIG0i7r111qynwd5yQFF8PK9ZHnUIEA1/sDxyiVZp835od5JGLtx2kPrjOFs3gM/ugx+7zzvUrUm+zVkfFYEKkeXP4gD0SpjxK+tR5xodZRymtWcI+5jRPE1fhhq7GyJm1OhVRBgZ3ilwK0/z/DQk73AqxWmHNiN/7Wm6Rw6O/yjlVYivqtoHlNtOKL4HyA6BCOgBoKd15mS4ON3Bm83IzEAnpaAb2sfET/2nkMaJ58o2zJYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+04kYh4Dhl0ZFeFQTDwbbfVPQXUGbHya+zbBYVQB8/U=;
 b=rCrFzL/5E1rav8bGbvU6EegkFBdyYfymshWzgzKCIOSTHuEK57Z4h+hVZ2eHUAOQd4LdO924u47JDnP/2PpULTqDRBIKgd19NMX/JPX9Jt0712UOd2gVrpJm3gMilRd5CReF4eyfciWxHGCBWjl+2siJ5ZK+XpZk8fdB41pgz32YQcsx0FObex0oM9Cb9be2EXEMDC5NPjRJ6KneXDk/4gpMYp1PevxaykibkcpNDtPzvXcau13HDk2kHNMM0vSzDnsT280wDIalLIr5iXnWHjfmyR0q0+kFs1mCy/mn14fYRAez7J4KFgKM52Ka1QxD5MrFYhAOQbpQSzLwZoI++w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:40:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 21:40:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Ewan D. Milne" <emilne@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "tsong@purestorage.com" <tsong@purestorage.com>
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Topic: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Index: AQHaEcEA0yfaha1bv0C9HNeQHQvmELBvYm0A
Date: Tue, 7 Nov 2023 21:40:04 +0000
Message-ID: <e49a96c6-5a5a-4c30-b7fa-c7ff62c57919@nvidia.com>
References: <20231107212331.9413-1-emilne@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8868:EE_
x-ms-office365-filtering-correlation-id: 9cc24dd1-2993-4c15-7ef0-08dbdfda1ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w51v7LACV1pQZG4xxqwOhGWRgJxJE9BqoBngR2/tVPOEklbBGyP0zBSmWpCsP322xhf/sMzmhyjpWvwNIK1ctcULRtL/ckgkyG0RxHNrI3RoIKso6iwHSdZg10zAAqOIS8zbCKUEVa6VPdcmWuiekksxgo9l1QqW2Xoz+1o4/7DBl5LLBa3qPMET58Jen7UTT6fhWshxG8knOBXKxnrvtfIQSZXG25ZXThZ9TqBLxPD0aTGHuYgYpr6SZ46cZWHLBJNcBp1xJ6k5nIrlHV4H/VcQqnesPV+14aqcYldDzi4ahmuxk+U4e+pP3g9erx4Qeivnb//aOAfT9DM7+z8ri0F6VuIFVLLeVtPGURa7oC3AzCO3hMveBHUlbn08lo3+yChHQLZy8JIsJJxsk/0QlVcCcmfidKwqnqJVUrXhiADQpviMMifbDzEy4OB4rOhVUepd87C4EWJH3Qc79H9R1hlQw9k9gAvKFo6KZkWxJq3j1CALJP9QuXE85RB1dmT7Oaq8zPr+hkg5ntZYGQ7VAjpythZacH7SNMnzmwnNw8k+6JgXqI33vDuWD7Kfklo1KCwAIio9n0xC3W2XatPev+yvlGCemz4phFTKAH6Msq13ydwBZxNaNo4Z/XHTn/os1dDzLoNeeOJIJ6C/aV5/6+vhyI5zWN863Q+tTkUcNdu7nnP8vj2fRZAYn7j057ev
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(71200400001)(6506007)(83380400001)(38100700002)(31686004)(2616005)(122000001)(6512007)(41300700001)(86362001)(4744005)(2906002)(8936002)(8676002)(4326008)(31696002)(5660300002)(36756003)(64756008)(66946007)(66446008)(66556008)(66476007)(91956017)(76116006)(316002)(110136005)(26005)(6486002)(478600001)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0FORVhDUGI5bm84bHBzOHhxaFFRdWQ4MSsxTWhDbURJa3dHYnNQZmZaWmNv?=
 =?utf-8?B?OG9YQlJvZEFQM09tTWgyWkhXTG5ydXE3ZWM3UGNEeTFKRUNnWW1BRHhadlhP?=
 =?utf-8?B?RnRZZGx4ZVJBMFNubHFZQ0RKVlByTjNvUEo3bVZIZE45SENRTm5nN0hnOUQ0?=
 =?utf-8?B?cUlNd0R0Z01Pd1ZmeVhoenE0bzNaWHYrNnY1d01tRjI2dUdiRFJFWG1ScHhX?=
 =?utf-8?B?WC9ILzRZekp0SDZNSWFIb1BmL3VJM0FsNzFmRjh4RnJ1aDdaVVFJZVQwdUlr?=
 =?utf-8?B?dzl3TmZHYVFwZEVHOTNFUDI1bnhPd1RaZ0VOKzJJZi80d2c2Rno2SGtaMEVj?=
 =?utf-8?B?aGgyV0FwSkFJTjY1QllYaFdTcjNUS2hWZ0MxaWQ2eXJROUxscWwxT3BWMlZS?=
 =?utf-8?B?OE9hQ3F3aE9VUnUzN1dtdnliVEsxSzZxSzdhajN3TjhBaWRsN3gwNkNOd2c4?=
 =?utf-8?B?Mk8xZ1MycFdEUWlrbmhIb1h2SWtDeG9BNWdhcitUTk5KQkNhRFY1MGF4SmJM?=
 =?utf-8?B?S1Y4OG5kbW5CVmd6bUlFTzAwWmFUUXc5ZnVGMDBDV2xBUFVVcVJwdWhVNTJQ?=
 =?utf-8?B?QkF4WnFneG83UE5odTRuMVY2aVBYbkh4Zzk3ZTFoY0pYa1ZsOXNRTnVSMUVG?=
 =?utf-8?B?MVZZWlhyb242aDVaQlJDZmlLYWdndlh3eXhPNGpINEphek1oakpwL0M5RlhK?=
 =?utf-8?B?cTRIVUh3MWM4WXllN3o3TzlOcXJ4RVd3NzZhczUrRG1ER2F0WUxveDQ5N09B?=
 =?utf-8?B?dXRlQnIreitITTZKQkVoT3c3RGZoYmpjY1BWdVpvSW9RZHIxNzVUVksyVWRs?=
 =?utf-8?B?K0dxVEZDSHlRNy9uNnBvNmdtOEdWMGRKLzQrVkFLN3pLaGNicWdPS1lSN2Ez?=
 =?utf-8?B?a1FoaWRIT20vNUMzOTdJVmtmSitFbWppZVdObVBNWWdZakdTU2N1OUlKdzhW?=
 =?utf-8?B?KzZIQzNYaTJhYlJCcFE1aE82czRPcEIrVlFvNzVoTDFicXBSRFlxeFY4Q1NW?=
 =?utf-8?B?b2VEL0R1WEhtbklzUXZZQkFsSXhRbWJXR2t1R21wMDI3THJsWExyenFWb1VC?=
 =?utf-8?B?QTUxQXNrZTE3YlFHRXVrTXFkQTNNNHNzRnhGTkxPRjVUbEp6ZG5YYmRMMnBT?=
 =?utf-8?B?UGQ1M00rVVRWaENvajMzVkxwSlpiS2NHZzR6bWIvNklOWGplZlBpTEpGWWUz?=
 =?utf-8?B?aDdURkVGSFpZK0xDQ29nd3ZaeWRweWEzNFZHL0RJeFd1djNnOXNzZmdPM2p2?=
 =?utf-8?B?RThKZXlXZXY2NWtNSWpWTXNTU2tpSHFCMzNIbk1ObVZuSGtHSUxvQ1ZDQzI4?=
 =?utf-8?B?TGtucGhOREMvQ0VKQkZYVE5VTUJNbEVVVXFrQStRSmp6bkZ3bVRKM3g2V3Jo?=
 =?utf-8?B?ZXBZbGZzU3dmZ2VDdHVWMVR6WWQ1MWp5bEZYWGl4L043UGRlc1lLWFZDZ0xl?=
 =?utf-8?B?bFR6SVlkVWVnZ3B3V0VJNGRBSjA2NkZVbGg2YmpIcHN3K0VSK3N5QUhjTWpa?=
 =?utf-8?B?VkFyY0NwQ08wY1NFWng3T2VKNU54WkVZRHdDQkUwb2pkSXVEcEhMTVVZa0tB?=
 =?utf-8?B?THAwaTEyWE5HKysyWjV5dkJqRlFnOEF0SXp3MFVoQVJEY2haK2F1cW9EbThk?=
 =?utf-8?B?T1ByL0JDOTZlU1haMVkyNHVNMmVubGlMZmM1V0I1K1pDbTBid3dXVTR4RkFN?=
 =?utf-8?B?WkFqV3h0ay9GNGV2b3ZrYzM2V1FSWWtHVE5zSkpBbWUyV0tkT1dJRVJoa0t6?=
 =?utf-8?B?V3JxaWZ2MjdRNFVGelAwWGFHa3dsTk85aDBHLy9SQmtJNUdCZk9sYTZwcDUy?=
 =?utf-8?B?SEdkWnB5Skt4Z1Jrc1NkU2hJRDc3L0dSbUxsZWU5V0Irclp5SWNxc2l5VW8v?=
 =?utf-8?B?VENqRktMNVNYcW5IRms5Qzk3NHZUN1hRQnRYNUgvanBQM0c4bitqbGNwT0V6?=
 =?utf-8?B?Y0MzSUs1U1VrN2xuMnVCZDR2Z0VwbHVTZlREckh6NDBMcGR6VmU0MFRxZ3lJ?=
 =?utf-8?B?Y1lNNGN3MUZCcldnNWJmRnBRZUZIamN4VmVxcXQvdnhyZS8vbHFqTmJ0OE52?=
 =?utf-8?B?QytMbHNQaUZsZW1IbHprT3l1cHFSOXBmSGtNY05IMHBvS3kvY25IR09sVUlt?=
 =?utf-8?Q?HG12atkgVJiVdO1SdKeE3JCMA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C144C9426A1CB349B925DA5039CA8256@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc24dd1-2993-4c15-7ef0-08dbdfda1ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 21:40:04.6331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8XEZgLP2a6f8Nsfwm6qn+rGNLFd5Ck6hFwoQue1iV6SibbmBnJw/4ip4XRpyQO2GWV8nJ17QoHZpDEnfKhj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_134010_788456_29388DA4 
X-CRM114-Status: UNSURE (   9.62  )
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

PiArc3RhdGljIHN0cnVjdCBudm1lX25zICpudm1lX3F1ZXVlX2RlcHRoX3BhdGgoc3RydWN0IG52
bWVfbnNfaGVhZCAqaGVhZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbnZtZV9ucyAqYmVzdF9vcHQgPSBO
VUxMLCAqYmVzdF9ub25vcHQgPSBOVUxMLCAqbnM7DQo+ICsJdW5zaWduZWQgaW50IG1pbl9kZXB0
aF9vcHQgPSBVSU5UX01BWCwgbWluX2RlcHRoX25vbm9wdCA9IFVJTlRfTUFYOw0KPiArCXVuc2ln
bmVkIGludCBkZXB0aDsNCj4gKw0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KG5zLCAmaGVh
ZC0+bGlzdCwgc2libGluZ3MpIHsNCj4gKwkJaWYgKG52bWVfcGF0aF9pc19kaXNhYmxlZChucykp
DQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQlkZXB0aCA9IGF0b21pY19yZWFkKCZucy0+Y3Ry
bC0+bnJfYWN0aXZlKTsNCj4gKw0KPiArCQlzd2l0Y2ggKG5zLT5hbmFfc3RhdGUpIHsNCj4gKwkJ
Y2FzZSBOVk1FX0FOQV9PUFRJTUlaRUQ6DQo+ICsJCQlpZiAoZGVwdGggPCBtaW5fZGVwdGhfb3B0
KSB7DQo+ICsJCQkJbWluX2RlcHRoX29wdCA9IGRlcHRoOw0KPiArCQkJCWJlc3Rfb3B0ID0gbnM7
DQo+ICsJCQl9DQo+ICsJCQlicmVhazsNCj4gKw0KDQpuaXQ6LSBleHRyYSB3aGl0ZWxpbmUgYWJv
dmUgYWZ0ZXIgYnJlYWsgPw0KDQotY2sNCg0KDQoNCg==

