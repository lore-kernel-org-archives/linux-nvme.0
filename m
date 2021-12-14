Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60B8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6v484dSE64U4KX0xbUrJZyuShD1vckZ3qRPnvCPMCjU=; b=Q8wK2CniAxvZQ2YDbKPIypvXj6
	Jp40x7XeWtESAYxFHa2KGk1ga+wxvKi+mjADy5OQet4/KQXolm8SjfiBB81CLoJKI2bnqlujQctIt
	OHsSgi+oTgt9+CDFO2kTGnmlzuU9ghFrdvsdpyvCl0bZhqX7YVEV5m16EwWfyttfYs8qMpIz2NWSS
	cAXqyLgVy0gYHyUqQidVzNArcDxwFq/tg410P8hyMR/H0XKARNRM4VgrYcJ7azT7N9vSQhURc7jj4
	+/JuPAvUGvl/4OmO4yNHTgRHRAUUqA8GnTvCK0XNuTqduxy/TjTdbW6HAc4+3ENrtg+oAI/71MQ1z
	a+gb+fzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx2Mc-00CuZm-DA; Tue, 14 Dec 2021 07:36:42 +0000
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com
 ([40.107.94.48] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx2MZ-00CuXz-EA
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 07:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xny98/8jVK1OUt9NpduKAIOPLCl2j9LdeWqg/yOZxs//Lxg44P0udFBFJYpfK0iRscnwQH1b8mJBRbfWP2Bygob/cvCePTTz2zx/n5TyIs+oO/eY2mbpbxxaNqe0z9nZ/+hoDkzFkP387fCEHDGcoxFMjCSMkWRtPmSq7BOejKBYn0sg3UcNvQZfrKrV9dSUCzB+yObH6xpD8/+k5ustLXH+RMK8QTr6VSAVhRAknA6wParVhGG1V/kvxkNJKRg94TELFlqonWVqRI3tdBdSjjwl6Uvtx2AUdm5HohdLEmHwY8puQHDf17CF8twbG/dpGZt7dqyrl6qOBo9fqvITLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v484dSE64U4KX0xbUrJZyuShD1vckZ3qRPnvCPMCjU=;
 b=MTmdmTYYGy1gsfQQqUj+6t1b2KCfPbxVKHNhuNChkinRbIXsy7O7C2kUm4ePm8EwDmspSQHUZ8VXJ6s4dwg4wGnJuffMaJBTqD/wNv0Z2HdUaWLimdqtFovEiyMZIop4FYZ4jfA4E9s4hMxdviEh0Lv+3F/nMuqw6RFTbvl45GtoOEBymqTBmTfUS90AtbwmVsC5SXmT+yyOfV1EQFZ8f9YmdphPcU7BagesLChhBAkS5zwHMyWE97ukOkdMwl8cGLBN86OAq5jkYdUyPgiwaA9yi+t5Q13tdZUAF3XxJfbBJJW8bI4VikX04rvaOdL1GWfPu48F0Z9bq5uE8iEjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v484dSE64U4KX0xbUrJZyuShD1vckZ3qRPnvCPMCjU=;
 b=HLSNcKRqft+ZYjDzU8dW+xZnynUCI7FzdC+q8MxnvVCui5I1NBn1vCa9VLdzHrCqlXGzLbzG4hpwDPsKihIlTHyBhxE819x+g0tPKcWSa4LZq1g8x8Fqo7ViUrC/eQiegrBQCmIGJif2yJp5e3wAWKMDEMDeaaBzphmdOVkC5nN1R+Cg67OMHlwTpcD6AKP0RlS4/p/FaHvqOM/nDUwzQSrq2pTiMsTW1JcA9jvSmQt+YP+UNb8smJq1qvhmvihoYIzaksBKHfmiPHufUMeGeJZ3xT1U50W9N56UM6HkotHBoYEyYY/QzIsuUmECMeq96ZuFxzHhfp9sQObFXk2Mew==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1200.namprd12.prod.outlook.com (2603:10b6:300:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 07:36:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:36:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Topic: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Index: AQHX4D/0FW4m5OORG0GJLZetJzuU7KwxKk4AgACKNwCAAAWagA==
Date: Tue, 14 Dec 2021 07:36:31 +0000
Message-ID: <8ce0ae6b-1560-f85a-47f4-a80f14f8e8cb@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-7-hare@suse.de>
 <d3556c79-d105-b4cb-a84d-a1b7aff8c4b0@nvidia.com>
 <3e86b6c3-d261-aa07-2e77-20e29880213e@suse.de>
In-Reply-To: <3e86b6c3-d261-aa07-2e77-20e29880213e@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e962bb3c-3e6a-4941-9860-08d9bed472ef
x-ms-traffictypediagnostic: MWHPR12MB1200:EE_
x-microsoft-antispam-prvs: <MWHPR12MB120069DCFDF18E862E100A88A3759@MWHPR12MB1200.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSFBr/FSHHEG/I7SuYpAVE6+aFIvsDYDccqIG5DrLEUvCGYWr754RB6ITjESrkpR0GCjdGnAEnO/Qx92rmDV2KdJ6c35MXWsIR21ohkfnTp8RKKLeqYxtHV9OG2Z7sjctSi70cYiXgaTbzps0u9HkADR93y5IuuBNmjCn9TAeA3/EAWLd1O8fz2W4MFWFIOrF9CpReanaDhKFcQQ385pDigfSlXDt1/wg6UnVJOvHC1EwtK34ZtAB6Kh70M82j7rACtORVrQxEvaXwMH2lDg8u7t09LgwCCN3AAuObqPWC0s/veqy4jmHaJ29jHFD1EV7zWBeYTAdzWxqUEUanhj4TmxjPq7dmwb/F4oTA8FzKbGyPYLLjgX/9f44HC+67MsYHtcYoFfWKOglK4JOWo2KovF9JUTdvAr9Gd7RTgFHU7qKuB1NMCFO5qTT7fOSYKBbCZ41D+1fz2zBHWAclh6qdMybB9kzb+7ww+ulKmXzGpsH+axanWw9MJ+KgLemcbc2TZuFq2aED0MuspCgfXa/4GaU5Vf48xfHjdYtcVO5vfYPfKBNlWHchpLraHjW8lLARi12TMNv9E32Ar3/WfpOqMlSyRThKHTMASse14drZas0rLgyB4O95uoj6wzSt2nDF2wbUrWcZ07p8DjT5yYNn/rmfoTloXZG5+kIuKOgls65rYDxH3qpn7ZOsg3L2qN+C51S4UceAiBswVXHj16Vol5jxUNx656567u34NXmM8pbWRpwE7qDOdGCH3nEJ48vhwIrXwFHTeUE/lnxKIH0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(5660300002)(38070700005)(38100700002)(31686004)(4326008)(8676002)(316002)(122000001)(2616005)(186003)(36756003)(54906003)(53546011)(6512007)(31696002)(110136005)(66476007)(66446008)(66556008)(83380400001)(64756008)(2906002)(6486002)(71200400001)(6506007)(86362001)(8936002)(76116006)(91956017)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW40RlEvNWl2YUJkMVFNdXE2YktRUUhXeUQ3ZE5KT3pFSWxCcjExVkhpd0tS?=
 =?utf-8?B?L0hLU2ppUTV6cS9kWlZ6ak9EZFdUbUNTaEdKdGh0bDVWU1lkZHc4YlovY1l2?=
 =?utf-8?B?WGRQcjdHbzJ0RFVneUEvdW01aHNzbElGVmtwNit4S1NuMjNMVjBXNkNCWVV4?=
 =?utf-8?B?RWxINGNZUlZqd0tLUXBpVlVJUHlLbGlHbjB0aURHSDVlRUFkcURhVUtvcURl?=
 =?utf-8?B?dGt5TGYwTWxyZ25zLzVEWjVrUVRjV3hlelhrRTREbDExKzJOYmY0RDhtQ21C?=
 =?utf-8?B?NHFKOTdMdjJpelM3MkI3MFVVSGJWKzZBOEhBb243QUNWaTRsTWFjaEg1U1lk?=
 =?utf-8?B?NWNmTnJHM2E0Mm15R05uNDFENmo0SkcrcDF2bUY1RGNITjFMWnQycjR1WTA4?=
 =?utf-8?B?MFdCU1RENzBZR3RmSCtoQi9xQXhmNjc2bHVGbXFuQ1ZFRE9sQkFjMEFYNnAv?=
 =?utf-8?B?bEJENDA2L0xMbjZaUnlYajYvdDhDSWd0WVoyd1J5K1g5SHhnVzVmMXlUVktG?=
 =?utf-8?B?VUFZazZtTnhYbEdSVjl1YlEzeHdNTnhJSzlyWWhCcXhBaWQ1TERoV0ZsT0NX?=
 =?utf-8?B?bWtQa0ljZWNINENVZjZOSDg0MUZwWkJQd25BNm5hd0I2aXFXUldBSDJVUGNK?=
 =?utf-8?B?TmxLMTcrYTNpYU9HWUUwZjEyYTBadzhmL2VVd3VqWEh5c0k3V0ZUb1Vla2d2?=
 =?utf-8?B?ZWhBOHdZNUtNakZXVVQvMWx0bnVGdHZCNGlJc05HMVpkSUJiRk5JUDV6SnU2?=
 =?utf-8?B?bXB3bDdnVFhDclhzRzdZalhFUG5aUGcyK3dheDJWNE9acWFWeW8zVk1aZUpJ?=
 =?utf-8?B?RVBjbGx5OHZLSmxUSVl0YkJRMlpoZDNka25ENStXYjhTNWxxanAxMEdsS2E5?=
 =?utf-8?B?NjA1TlhWWlZ4N1o0RGNDYkdlTk5JWkFuTkd2NEJzcnpYbkVhN1BETFVDZlBJ?=
 =?utf-8?B?M1FCb1dKNzMraWhxeHFZditCNm03RXdwa3JUYnVKUjZHbXRPcFlHNEpERTJj?=
 =?utf-8?B?UU00K1NnS0ROTldVNHNsejRCVDk1Z3dFYWsvTjcvMFRwejRvWXQ0dTBoQXh0?=
 =?utf-8?B?U2x3QUprZVdyckRPSHR5TnBJVVc0cS9lc1NoQzg2WWhCdG1TVkM2eDZURmdH?=
 =?utf-8?B?NWJQWHRVVkFocytKMDVZeGlaYU0ybmE4bjViU2ppQ2xESmhzWnFETXBJSUFL?=
 =?utf-8?B?WThybFVlL0hKRlVROTJaRlA2ei9nSlRyM08zSEQ1V0Z2d1RkeUtiNld5a1p5?=
 =?utf-8?B?WkJXMElacWJIWDNGWFo4WkhZYlVWdU1kZ3hQNW4rSHZWYS9iZlNOVVZKTXYv?=
 =?utf-8?B?ZWZqSE5RYmd1ZlZ3L3JQeUVhc1RCcU9PekRDbElmd0xVTU9OOVlwNHhNVVJa?=
 =?utf-8?B?OWJFNFpON29abWpLMUpQSTRtT1BLSHR6WE5uM05QS2hVdzZIcWRVT2Q5bjhX?=
 =?utf-8?B?eC9LNWNPMGJSZGM3ZVBoVjliTmg3Rm5zZjJ4cnpTUVNQTFJRNjRJSFBSTHA1?=
 =?utf-8?B?OG84L2xEK3VRQmtDUm0xdXRtSGRoQVBXaVI2SGRuSnh5YjA1YzAvUG4xVGFo?=
 =?utf-8?B?VTliZXBXSkNmUGpmQTVmR3hiLzlKd0RiSmZJWWIrSkcyVmVJRHcxU2M5S3Jh?=
 =?utf-8?B?cFFCdFRPSVBQVGcrOHhuS2QvQkZUOXkybjMvYmVleFQ3dFA2YVdaRnJGSnVL?=
 =?utf-8?B?elI1T3RGQ1ZVM3Qzd1RwRG9iaXdibEFhcVpqVkdIQkkvOGE1RDlST0h1YmdR?=
 =?utf-8?B?UTBUVnl6bjN6ZXp3bVpuS1lUYjlKelNoRC9UOHJTL09jRU9kSGRXRnBXL0gr?=
 =?utf-8?B?amk1Q014SGRQdUJWVzVyVHF1Z3BubGhIK3pTVkl5ZlJGdnM2TDZwaUErZlVI?=
 =?utf-8?B?RzRPQjZ5Z0E5WkY3djdYWEcrSUtwWDF4WERPSGFjcmI1RlBHbmVmaXAramR2?=
 =?utf-8?B?c0hLN2tkT2VkNkNpOHRQM296bEY3Tm1YL2Rac1Yweng4MTEvK3A3NmcvVmJh?=
 =?utf-8?B?QnNpakEwVy9TeWdVZE9sSWpmeEFwMGJHallpVkdwTkthWjloUU54bHY0Z0hn?=
 =?utf-8?B?VHVkTU9SdGtuUDQvRFVScnRBbGRTelZ4MnBLbVVkR2xscHB0TWNvRE9DNi9s?=
 =?utf-8?B?V0RNYjM5QVNPOTZZNUFNb2NnbUU1MDZkdGl0Q1JkNXBxMFVRSzkyb1dPa1pu?=
 =?utf-8?Q?T9zn+SJtXRsBBMHRKZxuB8fl2/klBgfWw+Y7eJbXszRb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <639D711BCC6E144D953B3B482DC3CDDA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e962bb3c-3e6a-4941-9860-08d9bed472ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:36:31.8935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZtcIj0rQM/319qZHkYlO02KcPmAhT0esZYAVwm6bSo1e27jeUCiqT3xuuD2Ijfzk4I751WSdE6ebqvkNlperA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_233639_515246_4D30D8A0 
X-CRM114-Status: GOOD (  20.70  )
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

T24gMTIvMTMvMjEgMTE6MTYgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBPbiAxMi8xNC8yMSAxMjowMSBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gT24g
MTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4+PiBTaWduZWQtb2Zm
LWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4+PiAtLS0NCj4+PiDCoMKgIHRl
c3RzL252bWUvMDM5wqDCoMKgwqAgfCA4MyANCj4+PiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+Pj4gwqDCoCB0ZXN0cy9udm1lLzAzOS5vdXQgfMKgIDcg
KysrKw0KPj4+IMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspDQo+Pj4gwqDC
oCBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvbnZtZS8wMzkNCj4+PiDCoMKgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0cy9udm1lLzAzOS5vdXQNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS90ZXN0cy9u
dm1lLzAzOSBiL3Rlc3RzL252bWUvMDM5DQo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBp
bmRleCAwMDAwMDAwLi40ZmJlN2RlDQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL3Rlc3Rz
L252bWUvMDM5DQo+Pj4gQEAgLTAsMCArMSw4MyBAQA0KPj4+ICsjIS9iaW4vYmFzaA0KPj4+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KPj4+ICsjIENvcHlyaWdodCAoQykg
MjAyMSBIYW5uZXMgUmVpbmVja2UsIFNVU0UgTGFicw0KPj4+ICsjDQo+Pj4gKyMgQ3JlYXRlIGF1
dGhlbnRpY2F0ZWQgY29ubmVjdGlvbnMNCj4+PiArDQo+Pj4gKy4gdGVzdHMvbnZtZS9yYw0KPj4+
ICsNCj4+PiArREVTQ1JJUFRJT049IkNyZWF0ZSBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zIg0K
Pj4+ICtRVUlDSz0xDQo+Pj4gKw0KPj4+ICtyZXF1aXJlcygpIHsNCj4+PiArwqDCoMKgIF9udm1l
X3JlcXVpcmVzDQo+Pj4gK8KgwqDCoCBfaGF2ZV9tb2R1bGVzIGxvb3ANCj4+PiArwqDCoMKgIF9y
ZXF1aXJlX252bWVfdHJ0eXBlX2lzX2ZhYnJpY3MNCj4+PiArwqDCoMKgIF9yZXF1aXJlX252bWVf
Y2xpX2F1dGgNCj4+PiArfQ0KPj4+ICsNCj4+PiArDQo+Pj4gK3Rlc3QoKSB7DQo+Pj4gK8KgwqDC
oCBsb2NhbCBwb3J0DQo+Pj4gK8KgwqDCoCBsb2NhbCBzdWJzeXM9ImJsa3Rlc3RzLXN1YnN5c3Rl
bS0xIg0KPj4+ICvCoMKgwqAgbG9jYWwgaG9zdGlkPSIkKHV1aWRnZW4pIg0KPj4+ICvCoMKgwqAg
bG9jYWwgaG9zdG5xbj0ibnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDoke2hvc3RpZH0i
DQo+Pj4gK8KgwqDCoCBsb2NhbCBzY3JhdGNoPSIvdG1wL2Jsa3Rlc3QtbnMxLmltZyINCj4+PiAr
wqDCoMKgIGxvY2FsIGhvc3RrZXkNCj4+PiArwqDCoMKgIGxvY2FsIGN0cmxkZXYNCj4+PiArDQo+
Pj4gK8KgwqDCoCBlY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSINCj4+PiArDQo+Pj4gK8KgwqDC
oCBob3N0a2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1rZXkgLW4gJHtzdWJzeXN9IDI+IC9kZXYvbnVs
bCkiDQo+Pj4gK8KgwqDCoCBpZiBbICQ/IC1uZSAwIF0gOyB0aGVuDQo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZWNobyAibnZtZSBnZW4tZGhjaGFwLWtleSBjb21tYW5kIG1pc3NpbmciDQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDENCj4+PiArwqDCoMKgIGZpDQo+Pj4g
Kw0KPj4+ICvCoMKgwqAgX3NldHVwX252bWV0DQo+Pj4gKw0KPj4+ICvCoMKgwqAgdHJ1bmNhdGUg
LXMgNTEyTSAiJHtzY3JhdGNofSINCj4+PiArDQo+Pj4gK8KgwqDCoCBwb3J0PSIkKF9jcmVhdGVf
bnZtZXRfcG9ydCAiJHtudm1lX3RydHlwZX0iKSINCj4+PiArDQo+Pj4gK8KgwqDCoCBfY3JlYXRl
X252bWV0X3N1YnN5c3RlbSAiJHtzdWJzeXN9IiAiJHtzY3JhdGNofSINCj4+PiArwqDCoMKgIF9h
ZGRfbnZtZXRfc3Vic3lzX3RvX3BvcnQgIiR7cG9ydH0iICIke3N1YnN5c30iDQo+Pj4gK8KgwqDC
oCBfY3JlYXRlX252bWV0X2hvc3QgIiR7c3Vic3lzfSIgIiR7aG9zdG5xbn0iICIke2hvc3RrZXl9
Ig0KPj4+ICsNCj4+DQo+PiBTdGFydGluZyBmcm9tIF9zZXR1cF9udm1ldCgpIHRvIF9jcmVhdGVf
bnZtZXRfaG9zdCgpIHNlZW1zIHRvIGJlDQo+PiBkdXBsaWNhdGVkIGluIG1vc3Qgb2YgdGhlIGNh
c2VzICgzOS80MC80MS80Mi80MykuDQo+Pg0KPj4gTGV0J3MgYXZvaWQgdGhlIGNvZGUgZHVwbGlj
YXRpb24gYnkgY3JlYXRpbmcgYSBoZWxwZXIgaW4gbnZtZS9yYyA/DQo+Pg0KPiBJIGRlbGliZXJh
dGVseSBkaWQgbm90IGNyZWF0ZSBhIHNpbmdsZSBoZWxwZXIgaGVyZSwgYXMgSSdtIG5vdCBhIGZh
biBvZg0KPiBmdW5jdGlvbnMgd2l0aCB0aG91c2FuZHMgb2YgYXJndW1lbnRzICh3ZSB3b3VsZCBu
ZWVkIGF0IGxlYXN0IDUNCj4gYXJndW1lbnRzIGhlcmUpLg0KPiBBbmQgYWxzbyBpdCBhbGxvd3Mg
eW91IHRvIGV4cGFuZCB0aGF0IGJ5IGNyZWF0aW5nIHR3byBwb3J0cyB0byB0aGUgc2FtZQ0KPiBz
dWJzeXN0ZW0gZXRjLg0KPiANCj4gU28gSSdkIHJhdGhlciBrZWVwIGl0IHRoYXQgd2F5Lg0KPiAN
Cg0KUmlnaHQgbm93IHRoZXJlIGFyZSA1IHRlc3RjYXNlcywgSSdtIHN1cmUgd2Ugd2lsbCBlbmR1
cCBhZGRpbmcNCm1vcmUgdGVzdGNhc2VzIHNpbmNlIGluLWJhbmQgYXV0aCBpcyBhIGJpZyBjaHVu
ayBvZiBjb2RlICh0aGFua3MgdG8NCnlvdSA6KSksIGl0IHdpbGwgZ2V0IGR1cGxpY2F0ZWQsIHdo
eSBtYWludGFpbiBkdXBsaWNhdGVkIGNvZGUgPw0KDQpSZWdhcmRpbmcgbnVtYmVyIG9mIGFyZ3Vt
ZW50IHN1YnN5cywgc2NyYXRjaCB2YXJpYWJsZXMgaGF2ZSBzdGF0aWMgDQp2YWx1ZXMgdGhhdCBh
cmUgdXNlZCBpbiBhbGwgdGhlIHRlc3RjYXNlcyAoMzksNDAsNDEsNDIsNDMpLg0KQ2FuIHdlIGp1
c3QgbW92ZSB0aG9zZSB0byBudm1lL3JjID8gd2l0aCB0aGF0IHdlJ2xsIG9ubHkgaGF2ZSB0bw0K
cGFzcyA1LTI9MyBwYXJhbWV0ZXJzIHRvIHRoZSBoZWxwZXIgd2hpY2ggaXMgcHJldHR5IHJlYXNv
bmFibGUuDQoNCg==

