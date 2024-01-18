Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF73C47077
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 03:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2xVkoAjbBFiaFzgKvuT4iOXn4HVMWo2rDdf1MavQksc=; b=EEQJJw3mLdlZcPfqpd4vRFNADT
	vaEsemsVpkhdWVcOTO9lN0QGZcUpZZThFuv6jD2S5HJzKpy6aXNoYHlU31ZaJLiuIUR+WAoN7isHC
	wndbeNk7zPWwXol3W3yPOFZY/O356N6FhD4oMi4gzhDmkWaL0xCzjSaDF0iR88IsqGuFj/FaQjo/t
	h6unqSZpSFspv4jdPPJ/yjKIKEqIsklezuAHUET3EZ980PsDkZe0USbRZWGOC1GczJQMrrzSHo4Gt
	9p8ea8icsjSLwU5xIyyGi3oF9LsAeatnzmy+piO5dNZ2lzxN1D5zgQya5b6VBUAKdMiLv+dChQTam
	P4j6E41A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQJ8d-001WKm-2k;
	Thu, 18 Jan 2024 03:32:19 +0000
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQJ8Y-001WHj-2D
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 03:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoJHhG4ap3THeqlimSxtZWFEfC+Hqu7pa/KEwHuKB0s9pbuDOZmJxpQAsf6A8kdvh0GaE6F2uE4bLPOPRQCIhJeUh7ricl5IRXUz0WCgG21XK0Cri1aCegpbgovFfdvIi5QY98ujhHyXJrVA6eD/iWbZ7G/nZTz46atO30xO6I30Z4VARxkcVJn9AQF5uZPpYwy7MP2637IbkPSUpCcuCFotWgL6HVWsxg5QpGxLQpZ3EWhHa7jpVriF+S0MqirxttTIOnFdnpuuBI+1vlwXyJkLMZF+NxZk2nYE5gRvhDbBtaZTbvSbxY5kbmOphGnNO6WdF0NNZYxQlNAe1tcb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xVkoAjbBFiaFzgKvuT4iOXn4HVMWo2rDdf1MavQksc=;
 b=RQeAIN41evR5OI0JoaxfFmFl3jl8zQP8UQWbsZOeqn2yUK8B3EO/8MSHUPrOfrM9M1vAN1Awcw7mUFx9SIJhH/XlPLdMdQMXL4oqh5EBSgLIvXaYere++67ZYmjyh9TiJsTckxhyrX6DWy5+fn8ObF//7BR0liAxGp6QxpAN+o5dn/0tVtujBSkD+2eXYcACrgzd41hK0+CQ1zkrXzJku+gZzGrHbEe4yrhNLEA9JBHt0GET1bpLP3ZlFP7X85Pml5971Y3X7yaFn4CBfxiIiQ9ZdiIvLS6k70KL4Z1Chp+3x3s7vEUlcQF/QVhOKandQpcxzlI2IMUcmVkI2xdkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xVkoAjbBFiaFzgKvuT4iOXn4HVMWo2rDdf1MavQksc=;
 b=o4Jhd8U9o9B5PUW+jXPYuAu0apESYliAetgPWswwzBNzml0BKZPpqhzi0nS0JcarXl703RODxe+WX8KzGiP/jm8An2zpXULRL2B2xZdraSjFDNorYd5SU++TZSbhLrjNhkgEFFmZyDpNEdXU18yP/aIy3Y/Zxc+ygu/sNleu42glgJbk6nsK1xXaUoaTfxc9UtqvaZGpX1HDtDjcVNtrkyfv60uoFeyN1+4rnkbMEHIuEC8pYRk/VjpDDDnMXAXUmGnDPyBEMpVAEmAqn36cj6gieaNoDldFx8NoMR9PT8zakadH7wDjwHt7zqEjOVdQ1RHoKr4oEUsmfJT+h2eung==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 03:31:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 03:31:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Alan
 Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHaRCI5o/0gWRRNpE6eYNPv+sWFV7DUMKEAgAk2uICAAK87gIAA3ueA
Date: Thu, 18 Jan 2024 03:31:51 +0000
Message-ID: <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
In-Reply-To: <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4424:EE_
x-ms-office365-filtering-correlation-id: b38ca001-f391-45e8-5972-08dc17d602c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4VKnzBVlGQFUU2ur78q3NYzlNA0AMlKtvZqwq13/w/TwCW+9pD5vAPF2k222hjmVyXaruklaJeU1y9emJz55xAAwTToiuJq77SaNwdmDN0HBfDYfyAWu4Oke8hSMdtRjNs+JTIZsHowgXrPOiXvSMjfc/Z/WOGkQe4hY6GLCpP/Tl+Q/nGk7x35q7kgl59CxRIrxKNYSsVmNCykOJca7uxkDhbuPajnIhWxPC2OnwmIwk0I1bfutuscR8LhWSLO6rGSZMrUiakC8nMcYfnts9YfwuQSqzc+qeiJxhgmhPvHBtHchH3Qm2d0SqmiPQIv2Fy8AA0wAZZGNDMlD7K2ei1TLLXoiA4yjTMJ7gag0c4SHpZeZqRb1/RkyVguErFGBQDdvDINEm3W2TqydrJZVyzd7jR2FxQnbA69oT9MCZV0O7OVxDeSn1bvf7B8hfqxzm4DktTPO0BIfOr8k4rFiSFMd43tkApOGHn+AW5C+XJBTjvz+i8h93tHAbddxLsX/1UEm04n8TiBBIM3Xpf17LSyoKQTbHw7fPBGsWECl7e74KMwUXgYOIku0jvDxb3HalqdvKcJUHNyaUcX1977/4dnTxad3xnIaAbLyHDYUjlQ2G4gaqXukv9K2FPHnh7CwRBK7mdEFtX/v3blzXd6ke7riv2dIso8Gl1GiIATYirTEPVSQnSY+D07WjS/p9oNo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(71200400001)(478600001)(6512007)(6506007)(6486002)(83380400001)(2616005)(26005)(2906002)(41300700001)(5660300002)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(6916009)(316002)(91956017)(76116006)(4326008)(8936002)(8676002)(36756003)(31686004)(38070700009)(86362001)(31696002)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGdSNEN2S21pcDBLbjhadTI1bXRKeFh4UlBJL2cxd0wwdmtVaGJkUmFQeDVP?=
 =?utf-8?B?Rlhzc1kzMWhXSWRLZENBSldjSjhzdlp4RVY0b0QwbnVXNlJUVzR5S3g4aDgr?=
 =?utf-8?B?U2Jza1M5Y3QzQStxZW4wNmRUSk4xcGxSNXhiN2p4RG9lT1UvaFllZUhHRGg0?=
 =?utf-8?B?cGJUOU5XSzV0eG4ybml0cTdGcTQ1bWI4QU5ab3BSWEhUaUErdDRnTlV1WjZz?=
 =?utf-8?B?aFhtREQveFpqL21xQW1KMmVPYkFoSUFtQ1Y2V0tlU1c0endGalg3ZWhLNzlp?=
 =?utf-8?B?SmdvTTZmckRDWmMwMTV1Ym4xMHRkNFp4bEFjOWJpOGFNMlJWYkVaeVkvUWJY?=
 =?utf-8?B?RXQ3dXVYQnFKaHRVczVsdFNkaTRzVzFBWWMyYTY4L1pocXoyaGFsem5Cb3lE?=
 =?utf-8?B?YmxoMGJONU93ck82RkRjc1ZVcWwvcHhpcDJ4NTVkRS85MWZwdTRwekdBU0RT?=
 =?utf-8?B?SlhwRm5uSEVGUVVJRWF4TE9hRXBmTzlDenYxTlNJY1hrQm1rMFFGd0t1Q0ov?=
 =?utf-8?B?NFJ4MnZrRDdRK1Y3cnFJeCthUkpSRGJDdmVwQjRKYzVIUkU0OFA1cDlMeHRk?=
 =?utf-8?B?ai92MWtqMGxhb0NWcGRFR05landOb0w3Q3JMOVZDKy82dFhJNkhieUUwNlFI?=
 =?utf-8?B?blZKSFl3bGhZNTZ5NzBMNFlSc2p1am12dDNyS3pwRmVaUDdGWC9JSTFDOUpi?=
 =?utf-8?B?NmhvdVFISHF0S0EyM1NnL08vSG1wZGdBUDMwcTBGOERlSHVSMDl3b05qWWty?=
 =?utf-8?B?WkwwWVdXQ0dyZlBaUDl4am1FOG9MTGdxemdYS21ua1JsQzlSMTRERGVoNGpG?=
 =?utf-8?B?UnVkdTg4RWdtOUdBcTZsYlVDK3BLL0h3bVN3OExFNkY4a3h1TkxYU2dwWUNU?=
 =?utf-8?B?MGZJZGdXU0lXNENYSFFmcThKVkI5aU0vQWxhejBaT1dyTWcyU1NIaktZeE5J?=
 =?utf-8?B?R0Y1bUgxVmNoMHZCY0JTdHQ5bUg0dzhSZGVpZjhoSmJNOGhpTG5LZWozbkxS?=
 =?utf-8?B?ZW55MUxZaEYvekt4YVZqaUVDWTZLMld3Qk9oaGhISXlJakxjbnRXNU84RWlO?=
 =?utf-8?B?Z1hoanFlQVcrSldiZkhpNDZ2bFZlN3VUOVg3RnU0WmwrNGh5VGZ2eHUwQzZI?=
 =?utf-8?B?NVpzM2pYdnNZN3FhY2pQNWtvczRwME9wTE1JY2Zqd0ljVFR0bXpOZ2NEdWF1?=
 =?utf-8?B?TlFFaTZhcWxZWmtvMGFWeXVGMm9wNHlUbUhLcXpYRUFZL1N5UndEOXF4WXZr?=
 =?utf-8?B?Yy9zRS9TNHc3dVAvOWdrOHRyV2ZtK1AxRUovNW9ERmgycG9oWGx5a0F0Nysx?=
 =?utf-8?B?eFJpNFAwdTJVaENYNkl3WjdoOGtSbG9HbU9rdERUcjFKQXJhUWh1NFhIYjBW?=
 =?utf-8?B?ejN4bTNsVjBWTVRwMHF2N1hUVTVKOS9tQWlsdE9kaW8vcXhMMzM2bjJNdjFS?=
 =?utf-8?B?QXJKZ3Jud0w2TGw3aWg3ZnhuMGp5S2gwS0J6ZXJvakRldXNqdzNEc3k1cGUr?=
 =?utf-8?B?emFueFk2YXFLN05ubS9WRnM3dWZrdXppZCsyd2NDdWJsMUdjeDR3ckVKUVhu?=
 =?utf-8?B?V2p3QkRoNzU5enBkaitUUTVvWG5SczVTUmY2WHlvVi9rVzZlZTNtem1uU0FP?=
 =?utf-8?B?ZWhIa2F5MlFXTjFlZ2dWY1RZR1BuVUplWTAwaUJJVVBWNXk3Y3hkMmdLM3ls?=
 =?utf-8?B?V1MraG9RQnF6ZC9uQkMyYUc0NzBiZzJZMitMdklGQnA4NGdrWjdseDkrSGNp?=
 =?utf-8?B?VmRIM3B1cTJ2UG92aUJ0ZEkvTzNSQWJVcmRjU1oyNjl0a0h3Y1VONldIMW9Y?=
 =?utf-8?B?b3NlRU8vZkl3SjZWNXNLYWVRK1o5SzFsZEw0TDFEOFZ1S3VRV2ZsaVVOV0I1?=
 =?utf-8?B?YXlHWjRuVHdadVU3Ly9IcG03SGxsc0Z3QUlXb1F5QWpXWDhWNjg5d2ZXM2xL?=
 =?utf-8?B?NzRTOERVZ2xzczBDMzNRbW5PTDF2clBxbi9tWjJuUTEybG5hYStvckJ6dnV2?=
 =?utf-8?B?T0xlcWRpaTVwS3ZESUZiS3NjRXlnNWNHQ2d6RE9LMGNkN2d3RGtLVEVtcng0?=
 =?utf-8?B?bndjTG5meG5MZG1nNGwyZk94Z2RuaW40ZjVJbnNTdmNYWlN5WHNlODJOTktY?=
 =?utf-8?Q?Z1dIf+haMMeXT+fH0vT1IkM9v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <953F04DC77F3A244A7C22BB67BCD979B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38ca001-f391-45e8-5972-08dc17d602c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 03:31:51.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALsRev8QpRtIZATPez5A/SSuFum0ihc5ZmdMfpt4URvnLwM+ZKkEuOjLXAS4dcX5/31pMUAjZFBKxJLM5hzFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_193214_767850_69C1BFCB 
X-CRM114-Status: GOOD (  13.72  )
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

U2FnaSwNCg0KPj4gbnZtZV9tcGF0aF9hZGRfZGlzayhucywgaW5mby0+YW5hZ3JwaWQpOw0KPj4g
wqAgwqDCoMKgwqDCoMKgwqAgbnZtZV9mYXVsdF9pbmplY3RfaW5pdCgmbnMtPmZhdWx0X2luamVj
dCwgDQo+PiBucy0+ZGlzay0+ZGlza19uYW1lKTsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqAgLyoN
Cj4+ICvCoMKgwqDCoMKgwqDCoCAqIFNldCBucy0+ZGlzay0+ZGV2aWNlLT5kcml2ZXJfZGF0YSB0
byBucyBzbyB3ZSBjYW4gYWNjZXNzDQo+PiArwqDCoMKgwqDCoMKgwqAgKiBucy0+bG9nZ2luZ19l
bmFibGVkIGluIA0KPj4gbnZtZV9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWRfc3RvcmUoKSBhbmQN
Cj4+ICvCoMKgwqDCoMKgwqDCoCAqIG52bWVfcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkX3Nob3co
KS4NCj4+ICvCoMKgwqDCoMKgwqDCoCAqLw0KPj4gK8KgwqDCoMKgwqDCoCBkZXZfc2V0X2RydmRh
dGEoZGlza190b19kZXYobnMtPmRpc2spLCBucyk7DQo+DQo+IElzIHRoaXMgbmVlZGVkPw0KDQpZ
ZXMgc2VlIGV4cGxhbmF0aW9uIGJlbG93IC4uDQoNClsuLi5dDQoNCj4NCj4+DQo+PiDCoCDCoHN0
YXRpYyBzc2l6ZV90IG52bWVfcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkX3N0b3JlKHN0cnVjdCBk
ZXZpY2UgDQo+PiAqZGV2LA0KPj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVfdA0KPj4g
Y291bnQpDQo+PiDCoCDCoHsNCj4+IC3CoMKgwqDCoMKgwqAgaW50IGVycjsNCj4+IMKgIMKgwqDC
oMKgwqDCoMKgIGJvb2wgcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkOw0KPj4gK8KgwqDCoMKgwqDC
oCBpbnQgZXJyOw0KPj4NCj4+IMKgIMKgwqDCoMKgwqDCoMKgIGVyciA9IGtzdHJ0b2Jvb2woYnVm
LCAmcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkKTsNCj4+IMKgIMKgwqDCoMKgwqDCoMKgIGlmIChl
cnIpDQo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7
DQo+Pg0KPj4gLcKgwqDCoMKgwqDCoCBkZXYtPmxvZ2dpbmdfZW5hYmxlZCA9IHBhc3N0aHJ1X2Vy
cl9sb2dfZW5hYmxlZDsNCj4+ICvCoMKgwqDCoMKgwqAgaWYgKGlzX252bWVfY2xhc3MoZGV2LT5j
bGFzcykpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGN0cmwtPmxvZ2dpbmdfZW5hYmxlZCA9IHBhc3N0aHJ1X2Vycl9sb2df
ZW5hYmxlZDsNCj4+ICvCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX25zICpucyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
Pj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnMtPmxvZ2dpbmdfZW5hYmxl
ZCA9IHBhc3N0aHJ1X2Vycl9sb2dfZW5hYmxlZDsNCj4+ICvCoMKgwqDCoMKgwqAgfQ0KPg0KPiBX
aHkgbWl4IGN0cmwgd2l0aCBucyBzeXNmcyBoYW5kbGVycz8NCg0Kc29ycnkgSSBkaWRuJ3QgdW5k
ZXJzdGFuZCB5b3VyIHF1ZXN0aW9uIGNsZWFybHkgLi4uDQoNCkluIHRoZSBvcmlnaW5hbCBpbXBs
ZW1lbnRhdGlvbiB3ZSBnZXQgdHdvIGRpZmZlcmVudCBzdHJ1Y3QgZGV2aWNlIG9iamVjdHMNCmZv
ciBmb2xsb3dpbmcgY29tbWFuZHMgaW4gc3lzZnMsIHRoYXQgc2V0cyBzdHJ1Y3QgZGV2aWNlOmxv
Z2dpbmdfZW5hYmxlZCANCmZsYWcsDQp3aGljaCBpcyBhbHNvIHVzZWQgdG8gZGV0ZXJtaW5lIHRo
ZSBsb2dnaW5nIGluIG52bWVfaW5pdF9yZXF1ZXN0KCkgOi0NCg0KZWNobyAxID4gL3N5cy9jbGFz
cy9udm1lL252bWUwL3Bhc3N0aHJ1X2Vycl9sb2dfZW5hYmxlZA0KZWNobyAxID4gL3N5cy9jbGFz
cy9udm1lL252bWUwL252bWUwbjEvcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkDQoNCm52bWVfaW5p
dF9jdHJsKCkgYWxyZWFkeSBzZXRzIGRldl9zZXRfZHJ2ZGF0YShjdHJsLT5kZXZpY2UsIGN0cmwp
LiBJbiB0aGlzDQpwcm9wb3NhbCBhYm92ZSBjaGFuZ2UgaW4gbnZtZV9hbGxvY19ucygpIHNldHMg
dGhlDQpkZXZfc2V0X2RydmRhdGEoZGlza190b19kZXYobnMtPmRpc2spLCBucykuDQoNClRoaXMg
YWxsb3dzIHVzIHRvIGdldCB0aGUgY3RybCBvciBucyBvYmplY3QgYXNzb2NpYXRlZCB3aXRoIHRo
ZSBzdHJ1Y3QgDQpkZXZpY2UNCndlIGdldCBpbiB0aGUgc3lzZnMsIHRoZW4gYmFzZWQgb24gdGhl
IGRldmljZSBjbGFzcyB3ZSB1cGRhdGUgDQpsb2dnaW5nX2VuYWJsZWQNCmZsYWdzIGZvciBlaXRo
ZXIgY3RybCBvciBucyByZXNwZWN0aXZlbHkuIEluIG52bWVfaW5pdF9yZXF1ZXN0KCkgSSB1c2UN
CmN0cmwtPmxvZ2dpbmdfZW5hYmxlZCBhbmQgbnMtPmxvZ2dpbmdfZW5hYmxlZCBiYXNlZCBvbiBh
ZG1pbiBvciBpbyBjbWQuDQoNCi1jaw0KDQoNCg==

