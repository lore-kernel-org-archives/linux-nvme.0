Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D9AC47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QiQXmo7sqRe2Qk9xZhrrXfadaT3bFSMxXBRst0JzyCA=; b=FfWNvYqdwVTGM8FScXEsHLepLp
	hmw5SnPcD1pywazOlJCH6EHrGiScPBSpb80fE4cSbsTBDA7EVnE6OfZSJ6xDAgwW3/8gjwHNlOBWp
	gFuId9PRg4mgHwxp6l2uUuFbMsl4Me4gey7gB2tsvUOwsIsijVIO/KJ3hMqHjhQuUO47JOAwOR+TW
	4eW7HHZMfi3m3kIDx3ztWR8LlJz9paNFOjCr7VUinYDnfE/8E2Hr1jfUTBP8N4OtoHDyskBnltwn9
	LDMWRx7Crpd9yTLiRPrqRYkN+MRNVQfdO9FRXLsfM1TBd+Hg+tRYoB5EKLD44If4UXm33xeFvp85G
	GcU7K9aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPZX-0000000CMdj-0Vuh;
	Mon, 29 Jan 2024 11:13:03 +0000
Received: from mail-dm6nam10on20601.outbound.protection.outlook.com ([2a01:111:f400:7e88::601] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPZT-0000000CMaN-1z2B
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 11:13:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHvBKFPcHAH2SlQdRO3EO5uyyxmzeopZZZ+cBXUPqZQ6bmSuMUASxOFkFZxNU1V83JvUFUM6U1Ak23sC9F63cvH2LaeIdugQKdi5hx5MHk5YU53+kgy/q+ecThsmqr2uGgY56/WSGYL9kmq4QmC5FUiugSpnbtcxTzTCq8JVvVNgKAq0XVVfIIIIduJVi9LDIV5j3Z3tdg2T/NBP1jFnixCvJbBFnXzK87uAiC6/Lb0NBV3aj/+0CzGClOBcbcrWadGBg+TMj2XxALcknlR1kmNUpJGylD2EfWbGerajucTE3FDtOZGPjT5QixWOXjRhxRG7MBRTL0h2JCirgAqcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiQXmo7sqRe2Qk9xZhrrXfadaT3bFSMxXBRst0JzyCA=;
 b=G7x6N0LDw09HyqVrOiwMfH2LTNcWI5lSsnTYAe2KWN/+BwFE0AhbaZKg2bQYZ4Fc0rSfZDbaHTJl9Wr9uCpV32QxSYlCSLh2V+puNXIA0ktQV6rmFJ1qe4MPcIOFGzj68SN/TZ0xwEEmANJNw3/cYaKJuOuCI6mc6uDyW2U15iBRLMdK83GEX7r57nCg2kgdkh28B5Qy2h5/S/obyjbDGzh5yGDtLdyjYXsNumjwD+eK8rNp8+l4nNdgpTqtuc4RucMmdAnJx3Ny6CXD7nuONtKG7K/DHHA87RmCuiX7HTwzu7cBKoi41eGvju6wxFLEAFmp8R1xcZ/OIR/K2F1LKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiQXmo7sqRe2Qk9xZhrrXfadaT3bFSMxXBRst0JzyCA=;
 b=VagCZc5BzlYNrWOoFQNyek6lrFNWxTLf/mTe8RWwCwCFzmSn7b1m8uyr2IjGkv9viUqPaokC9M+0viDST09ROsePayue7NA0GFf3TPt1Dh9J/8RSs3l0zIcN/Ye5dQp88Rp48whup7VlMeWcJc6SDYs8E/Qb06j/e625KzXQJ8Yq+Fj3huOO6ItWw5c1FWk2jleef61yuJKPxKZslaxPLFFX9+McpMQjkayzm4vig7EHH+F/+a06126kYI+PFAS+RICiYKKCCVrtH96XfCCa44BGxkgPIm60vWJTHFwMVCrte2k0ZYD6EdJnAtVeRunJ4ORR7xweKyjOSKe9PslCgw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 29 Jan
 2024 11:12:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 11:12:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hare@kernel.org" <hare@kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 0/3] nvme: enable retries for authentication commands
Thread-Topic: [PATCHv3 0/3] nvme: enable retries for authentication commands
Thread-Index: AQHaUQSP1uZ7GmclykKBOUttsV5eOLDwph2A
Date: Mon, 29 Jan 2024 11:12:41 +0000
Message-ID: <5f55eba7-c09a-4ce4-93f2-842cf1c33ee3@nvidia.com>
References: <20240127093746.40246-1-hare@kernel.org>
In-Reply-To: <20240127093746.40246-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6925:EE_
x-ms-office365-filtering-correlation-id: 34d5ccca-ec36-4f49-b59c-08dc20bb3635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DhmL29m/+gjgBKHoBoVdYesXZxVCzsuc6YHaM+ptzNZXmiovsYaF7feyf/fuCABl+FdwZEw6Y13JhRjgn6hepCbQEHYOOxqYwGmAxuS743qsch3Cr6/tzaiAw7RFyMuJHvBIjtfE+H+TvNybvKfiEOAdLrprxH01ic4noOyGBe9ztOyHVTndGS8XiW9hQJIVpFRDGBvoY3suZHuZWDg97nXweTD3ppbvdv0UF9zCBjIjAFXPm5XpjnVemtiPUBNj4B94FImHKrGAFojUB6CW37eEnnYad7XeEyvdKKSS8X6D3HUKns+ISK28rgnn7sgx/FU+vfk4KXJ012M45bvZH6C9WYgTSwe7crr6Ckr6vKxLtZply28ODE93IQEGiH4QWYFeGbZ1H9Z7SnRb5htev42nPHRDdHCPbkMBjS798qm6pIgpxxcCJMSdXBF24gRjMEGkuxgAcNEOQNYCuDZe7fQ2yCbIGztOTeCnqx7La7WTAztHhDWQzXiW28a/Xbbxg82NkjtpNS8QwvGW3XM3YcbZVI+jLGf0QI4inLBrAWybapKg342vcrOaBTIxjPFuDeERRoU9n8n3jqYkkfYxaQz7dJBDJgVfBESRxNUyqXk8Nt4SpE/9z0DjBKz6VYKRFSikTZFMnwKNqrjxEAUaAx5yNuWMQzdYWa3sKHdqCYEtOg6GQ9SmVWeyj+vAoYHh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6512007)(2616005)(38100700002)(122000001)(8676002)(8936002)(5660300002)(4326008)(2906002)(478600001)(6486002)(6506007)(53546011)(66946007)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(91956017)(6916009)(76116006)(316002)(41300700001)(38070700009)(86362001)(31696002)(36756003)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHpvZVFaS0pSSUNEcGQzTUVIWUROTFNBemxpNVAwRWFUWUlPVENMaDcxWXlk?=
 =?utf-8?B?TlhoQjQ3SkpIUzZXOFBFN3kzMTRYME14R2dGb09EL1dRVDhmTVBleUp0QmFp?=
 =?utf-8?B?TVh3M1NyQlljYUV4R3pFS2RwVHhReU15RTJ4SVZGMmRXb1hYOGxuZUdTdGFH?=
 =?utf-8?B?ZmpudHV4Z0UvWGJySlZQUUpuM3dGcWpBL01BWFJxMzRvb041M1J1N0FnWVJp?=
 =?utf-8?B?bFJUdXMrMElQdkU2REdzZzl4Mks2bnEzVkd2YTQ3L3BMVWRSZ1Vxa2RyMnVi?=
 =?utf-8?B?dDNKRzlHQktiNXN5U3h6VkVFZVMwaGtLU1M4OTA4SldGMUhLYmkxRmJIRnpz?=
 =?utf-8?B?MjJubnhnOURYalpBWjJ3Q1lDQ2xlUHdtYTB2bTNkS3pDMU56UXRaVmN0L0lC?=
 =?utf-8?B?aHdQZ0hOMEpxaFM0Y2dhMitXYmVPQTZmZkdieFdVNWZFUEpWMENCa2Q3Njl1?=
 =?utf-8?B?ZXpQMEs2RUZ2L3ppeW9YbGFQWW9WNVZsVGV5T013NDdUbXFUdmdLUldSR0xK?=
 =?utf-8?B?eksyT0toM3dYbHd4TGtWTGdpWU9EdWxOVjE1emJnaFA4ZWthclV1SFR6aVhJ?=
 =?utf-8?B?Vng1cGRTNGUvZHlhQUxMOVpWdmlhODRuTnZ3YTBjUk5neW9PRThlOWJDRXcv?=
 =?utf-8?B?NytSUzY5TkZIaWZoUzB0SkZnajFqb1BWeWhyQ1lMbWUreHlkWTgzK3BuRk1K?=
 =?utf-8?B?SC83Nm5oVWlMTFNwdGZSd2xlNXQ4b2NjTnlrK05URnJWSDhtZXdaaFdOZm5s?=
 =?utf-8?B?QUh0R0w5VHUrQ01HbGl0N3grU3owWlJDbUdIMGZZOXFhNUYvdGs1cDIrN2Qz?=
 =?utf-8?B?OSs1V0FUSjE3ZGt0cXZ4ajhaK1U2OXZSbmxrVmxpNjBvMjcvRlVOT1FwaTZF?=
 =?utf-8?B?UkZ5UGU3KytTd05lb3A4NWdkVFJCNE53bzlhd0trR05rNWFqbytWN3UvaVVp?=
 =?utf-8?B?UmFMTE8xQmNYTm1vM3JBVjkyc2tWS2FHTHBWZjRLM0tDL2toaHhKTUVmcmtC?=
 =?utf-8?B?OFdCa1laQ3FiOXVBN0NBaHdZWGlkRjlSZEZRMjMrOTRnaVB0ZG9RQmRvRXVk?=
 =?utf-8?B?MkhOUk1Jck1FSEpNNGVNK1AzVmR4WmNhcGhleHQ0VDZvNVNBdW1tc2xnQ04y?=
 =?utf-8?B?ajJEd084RzMzejhtUUVaVEhSS3NXSjQrVHE1Si9YN25PV0FkTXhwbDhCcnFF?=
 =?utf-8?B?cFRvUTR2NWcyS1JwdUZlaEo2SG5HeW9GWk9MOXJYRW5ybUFjMkxUNjd0eUZO?=
 =?utf-8?B?cFlYUmRCalJxOEFXQ1FJVzJYWXJVdjVsVG1qWHdDK2Nvb0NFVEJOTUdYSHVE?=
 =?utf-8?B?ZnlGeUF4M0g5NDJwSVB5N2hjb3pzNDNYdk54Zy91S1RqdWNLRlAxdUZaQWFO?=
 =?utf-8?B?aWRROXVkNHRSbm1tR0lVeXBzR2JpeWxDU2g1dVMwOTRrdEhhaWkvTDM3R1hj?=
 =?utf-8?B?bVl4ZHJDeUFpZDZnV0pBd3J3ZGRsUm10VXJITVJ0aGI0MlQxOEZSVit3MnRv?=
 =?utf-8?B?QkZJRmRXekRuaXlzRDIvNW1xcHlyeGxSakZwNjFjbGllVFU3T2FQWk9UV3Vr?=
 =?utf-8?B?YVhRQ1ZBdjJ5Mlk3TGh4Qm5xejJ0YS8ySmZoUWJwWUVIR2hIeEhzU1JDWUVq?=
 =?utf-8?B?ekkwR1NzQkVUN2VwaGxSbWt0Z2pHd1ZxU2Frbkh4aUpLcGJ5TTNGRkNPdGFY?=
 =?utf-8?B?b1FjL2dZSnEySXlWWCtOdHhKVjl4aU13NjI5SnZZYmI4aWRSS21Fa1R1bjVu?=
 =?utf-8?B?MGl1bHdqVlhFdlF4ak1zL3kxNWJXdm5KQ2VDbmFDRUFPdlpTSTcxbVdkOHp2?=
 =?utf-8?B?V0ZzSVB5V29tSU5ONytxQUQ3TjhCVEZ3Y0JYTlFqdERBaEFqUWgwRWtmK1BS?=
 =?utf-8?B?a1JRcnAyZnFaRzhxWlJwVFltU1piclF4blBPeStjZ2V3WVJpeEM3SHRpMUs4?=
 =?utf-8?B?WlZObWE4VWk4cUFRNlR5enQrZ0J3MG5UaFE2eTdkQzN2azYvK3l4Y3NoSXlQ?=
 =?utf-8?B?bm56YmJPMHVQcURpSjFiNU5DTGxVTFF0VnZOaEU2WU5rZEtqL2t6UE9IWWFE?=
 =?utf-8?B?ZkJXVXgzaUJ4M01BUnUwOGNWSS9ubjVpZHVIaUJWZW8vR1Ewc3BZNlRRR0Nm?=
 =?utf-8?B?MFhVeVh0Q1UrSDA1TXJYbFl6L2l0b3lYb3J3QlJHSDZWejNOK2FFbzg1ejZU?=
 =?utf-8?Q?NskQcmp39ECiE80FN+E4KVYl5OXtZKlufBdzPe2DNmT4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92CD4B957A285845899E3912A9A7881E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d5ccca-ec36-4f49-b59c-08dc20bb3635
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 11:12:41.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNiUkdOU0ReCOLq6rNufo+9+qC0Rmf/+rIt0WJ1ahwsmHtJ/l+8WRoRgXbAERDe6fA3jI8VQUSWkoamUxQt9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_031259_558739_0F3AEF97 
X-CRM114-Status: GOOD (  14.48  )
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

T24gMS8yNy8yNCAwMTozNywgaGFyZUBrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4NCj4gSGkgYWxsLA0KPg0KPiBhdXRoZW50aXRpY2F0
aW9uIGNvbW1hbmRzIGFyZSBub3JtYWwgTlZNZSBjb21tYW5kcywgYW5kIHNob3VsZCBiZSByZXRy
aWVkDQo+IGlmIHJldHVybmVkIHdpdGggYSBzdGF0dXMgd2hlcmUgdGhlIEROUiBiaXQgaXMgbm90
IHNldC4gQnV0IGluc3RlYWQgb2YNCj4gaGF2aW5nIHRoZSBjYWxsZXIgcmV0cnkgdGhlIGNvbW1h
YW5kIHRoaXMgcGF0Y2hzZXQgZW5hYmxlcyB0aGUgZnVuY3Rpb24NCj4gX19udm1lX3N1Ym1pdF9z
eW5jX2NtZCgpIHRvIG5vdCBzZXQgdGhlIEZBU1RGQUlMIGZsYWcgaW4gdGhlIHJlcXVlc3QsDQo+
IHRoZXJlYnkgbWFraW5nIHRoZSBmdW5jdGlvbmFsaXR5IGdlbmVyYWxseSBhdmFpbGFibGUuDQo+
DQo+IEFzIHVzdWFsLCBjb21tZW50cyBhbmQgcmV2aWV3cyBhcmUgd2VsY29tZS4NCj4NCj4gSGFu
bmVzIFJlaW5lY2tlICgzKToNCj4gICAgbnZtZS1hdXRoOiBvcGVuLWNvZGUgc2luZ2xlLXVzZSBt
YWNyb3MNCj4gICAgbnZtZTogc2ltcGxpZnkgX19udm1lX3N1Ym1pdF9zeW5jX2NtZCgpIGNhbGxp
bmcgY29udmVudGlvbnMNCj4gICAgbnZtZTogZW5hYmxlIHJldHJpZXMgZm9yIGF1dGhlbnRpY2F0
aW9uIGNvbW1hbmRzDQo+DQo+ICAgZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jICAgIHwgMTcgKysr
KysrKystLS0tLS0tLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgfCAyMSArKysr
KysrKysrKysrKy0tLS0tLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgfCAxOCAr
KysrKysrKysrKy0tLS0tLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggICAgfCAxOSAr
KysrKysrKysrKysrKysrKy0tDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCsp
LCAyNSBkZWxldGlvbnMoLSkNCj4NCg0KdGhpcyB2ZXJzaW9uIGFkZHJlc3NlcyBjb21tZW50cyBw
b3N0ZWQgb24gVjIsIGxvb2tzIGdvb2QgdG8gbWUsIGl0J2QgYmUgDQpncmVhdA0KaWYgd2UgY2Fu
IHNvbWVob3cgdHJpZ2dlciByZXRyaWVzIHRocm91Z2ggYmxrdGVzdHMgLi4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

