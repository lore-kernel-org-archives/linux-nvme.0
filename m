Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A595C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 04:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eyj6mAGueYmU1vTNUOMyT7yJGEyrI5Gxke5yrriobZo=; b=w63ch5eXsgsBuc8WqValeo0GZn
	W0MxpwM0O8/g5rc1499O1b4Fuz+Rc6z4wJULvXf1CujvLFrJ/G50rPpFDYcx0OO+SXm7GifOf4AYB
	MKM2+n/N4bthOIjsve0ympDEBX85j6W2uyUSjEQRQ6TRKK3koRq2vY7B/Zp0D601GGrMt+0pWMyQx
	h5ziFseG2XWfAEgYMNYhw7hU+gpusQwqklHQCbIS2f0BGMkQtmKK3jNMxW5wBIdWS7PWFce6IUOHs
	vkCi0TwgWTtS9OHKrvPhak6KOZeP8aIv716pqDp7BmiA8IsJJphEVFO9canWZN5P3I1uuOIKLL5qp
	0gmwFxMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prAgy-000BE0-1P;
	Tue, 25 Apr 2023 04:54:16 +0000
Received: from mail-dm6nam11on2060f.outbound.protection.outlook.com ([2a01:111:f400:7eaa::60f] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prAgv-000BCu-1N
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 04:54:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAhdiQQ4HSUmwizMXHG1igLr1eI5kGacpO+8gtQSn4Qf2Jghq5woBvGl3pARIyhB0dCHPWTgw6Ncayqheb77yxib8RzSFW/H9FJghRxs08o7UmxvaN8gCm6112h8g5vVI9+o9lVXlHHZ5dECdfL3XDcLHuidycIyPfZS7AHeMWITOz0HrsN1zxyTj6XthXqiyYBXT7euIekVku9cE6mymV4103SrdO2wq1OJSwDp0TFu0usNcpWHkdTcGdiMoO0UPQOu+Y6lPdCrLcS1qS3orT49EQTBbLJrnWIPtiIdCTxcHIHXBaTBNz8112LXh1XLXmRdVO/gP90cKgrSDhYIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyj6mAGueYmU1vTNUOMyT7yJGEyrI5Gxke5yrriobZo=;
 b=ZR4I50/z/peJg+X7rhlEhBU4iB+L7jelvZ3O0wP/C3UPVuhmurJfPyKLVpSie80Udd06JVkLA42duJb4Fcz1AglnprBN9dbNRKbtzJamXnvY9/6hvM55kTal6aHVX/qHGkLMawwGZ4sL3zVD/OMps/aDr/dsk1WCZ6PhjuAj/jSgP7DjHYvF4XpAXodd/mXph0mluuIdHltOhtLsXx7+3yhtcDk0lF+Ii23qomykjYqSbL7ti5KDSetYtm3S4BMUqkGwftYN53Re9kPJtEcAqeH/2EXxqidBytsuM7aLjEtqBPliex9gP7WL+LjuuIQhGdulrzP0hfS+0auPDi/q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyj6mAGueYmU1vTNUOMyT7yJGEyrI5Gxke5yrriobZo=;
 b=pHJ+lk0v9zqgdJz5ZHLn8qY5GNY7Onpe+KjvWwHC4Jvhe2iMkIEbmxnzEZOEyVfnnCjEw1k5wiz8pe6nzL4YSO/m3WLxdcdoZB+3BAV0EhxWIsV8fI2qVhoNVc1vNYmNrwKyDlzZeJjQoV5Q0cw4+pYwDzGN+j18xAiYRsWegYiv8WFXVXJ9krnp2zx5pCyKOg0GNWm6HO11zSkUUdQBp1WmEN2C66NNmYXcb0i2Z7rXyT5K+ocfsmPypt6ng5V+1kKt5I4IOVQBahu6BqYH8ooevxpdo2ncIyVhvLz+WXPjmrnodUX9yuFX8Xg+n24n6Yb5hLxQRy80/CcLaJMY6Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 04:54:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 04:54:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Irvin Cote <irvincoteg@gmail.com>, "hch@lst.de" <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: Correcting erroneous patch
Thread-Topic: Correcting erroneous patch
Thread-Index: AQHZdzCV1EAr/64pyUinzAsbs0Gc3K87dYuA
Date: Tue, 25 Apr 2023 04:54:06 +0000
Message-ID: <6a894819-29db-bb23-1cd2-88fa7000702e@nvidia.com>
References: <ZEdal/WS/NWxRKSm@archlinux>
In-Reply-To: <ZEdal/WS/NWxRKSm@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CO6PR12MB5442:EE_
x-ms-office365-filtering-correlation-id: 784cf6dc-e969-4150-1d7a-08db4549193f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  jZ16SgmgmTQGcuJ3GgHgnACFANxV0KqDn1miHPVQ3TVe7F93CfNvh3KSqWP/fhl9ktYHFkOlx8siLTt3/ZXWKqkRTljruL4uA5IGJsrWynKxXkWTeoWOqT7Zv5X0qUUnz3l/CHxljhcb7Xs7Rs/7ZUiXIiEJhErjRT9zEAf2oVv7wrl3LHZSxmi34Ovm/9yh2sV4GYKucFXbQmC77BwzG2jNR3qDGtd+QbZEZZkXVSV8CSufey1MXSdkKZP/0Dt8YS809tcbqGcM6URhNGmriSlTGuMukVLnZNccqf2iJIX6eI/Awc3yIf5bydN11HQ76W73f34alyoVQ6HCC+h7TugiG0gFWc0tYrT4gV9e866l6076ZtuJrmw/IMib0/ny4+SgKe3eiJJZ7bvQ0LjjegB2Cy/bzDG4YnMcQuqOcJtIARYjU2T4LL8qs5nduUFxPxaMiaSEzU+XwX3i2qlgTd7BLfPLfTAE7GMEghVNPQeEfDH/eiZgX+Jc9zGEa3QAiuEbEPqeElJhSmJlaP8pbtZ9yvzTYIvj/8owOi6wm0ATOiHMLNZ/YONBlfERatMQbBQBF46Ftgends5SiC8EP+qdnFHI+Z0P/OjCNhNisnwKy4OsHRCtHT7RL8vHtjBcq3TGZB/wNvJobElsZeXOSMzzQBTzVtc+Ntiyoo147wXKACxYh43RMICNTVKgcSkT
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(8676002)(38070700005)(8936002)(4744005)(2906002)(38100700002)(5660300002)(7116003)(36756003)(86362001)(31696002)(6486002)(71200400001)(6512007)(3480700007)(6506007)(54906003)(110136005)(2616005)(31686004)(478600001)(4326008)(186003)(316002)(66446008)(66556008)(64756008)(76116006)(66476007)(53546011)(91956017)(66946007)(122000001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bFcrellMM29HcUxIRzRkME5GdURJVWZYek80TmxHRW9tRzRpcnd3c2k5UzBK?=
 =?utf-8?B?aGVOZk40b2RxYWFIS1d4RkloOW42YTU3d1l4VlY5TDlzdURXM2RpVEYxU0Rx?=
 =?utf-8?B?bSt0bGlWQmNVejZLbzdhcHRTbWtkTnFRK01PS0ZNdlM1NGJ0UUtuUUtwTXV3?=
 =?utf-8?B?WWh0azVQRW5kbVQ5YVZrZ0lhOUFKbnJkSVJwUytuejZ0cFpIWDYwWnVSM3lR?=
 =?utf-8?B?VVZXUG1tdGhrODllRk1mZGRwUEQ5MjNrUk9vckIzSkp5NnpsMjBSZ3Fxd2ZT?=
 =?utf-8?B?MDVZOUc0T2JpUEN3UzBJTXE5RDhZbTBRVnF4aWE3cTFpbDcvdDRvak1NKzZE?=
 =?utf-8?B?TFVaRUtoZmxZTlo5eWZWV3c1bnhTUEI1R3YxNlNPOWRVQjU2b0VqWUVLMi94?=
 =?utf-8?B?Zzh2L042RzlqNHZnV2hXQ2Fxa21mQ05Uc3hqZXlmbkJSKzZIRThxMW1NOThl?=
 =?utf-8?B?eCsyeFY0N1ErOXVMWUliRU1QM2xkVi8rNGdZQzdtV3A2Vjk4am56bktwd1Zu?=
 =?utf-8?B?bVMvaXduZlFYMWJVdDRkSVh5M0lhSU9UeHR0bVFaQVZybDJPa0l4dlhvYlJj?=
 =?utf-8?B?bkUySmhBOXJ5bzRtdW9iSUM5U2ZiZGkzRnNYYTRxb1RWQUlCQmZJRTExaW1B?=
 =?utf-8?B?d0l6dHVZbWduSGlOVm82RHdkUnE2UEJ1b1drdjA3cjh4TjN6N3Axa0tWeXBP?=
 =?utf-8?B?RkxSdmZGdUlnTlpER0hSQkdJbEZ4MlR1VFdUMFF1N2hiTEwxRm1waFNSWVFw?=
 =?utf-8?B?ak4wbm1lbVNvRU5WVVZ3eDVCWTNRTzhLZE5BWjRwaUZqaDJKcld0MCtXOTQ0?=
 =?utf-8?B?MHdYazlnT3ZGMkt4ajN2N1pObzlwdTJnSnJwRUNreDAwanBOVWxyMjJuTjI3?=
 =?utf-8?B?eGFZYlB2a05VZWJoeTByanNoVVBKNEx4LzdUbFdhU0dDdFV4WFRSby9VS1dL?=
 =?utf-8?B?TEVQY0NHQ1M1aTBZUnZhNGFrdTJxNnVObW9OSTBuVFFJWTBZcUVEUkN2OGZv?=
 =?utf-8?B?YmpjcDNrSk9RUzlvM0hUckZ5dXhLVDFVT3JEUmdvNHYrSjNuZ1YwU1lGZGhv?=
 =?utf-8?B?dEcrRHlSMGQ1Wm81bHdOSGNvNzl6RnNRYzQ0YjRKdFowUUNGMm4rQnNzbW0z?=
 =?utf-8?B?N1JuL21yaThrRHhDdU9BVXhObTlvTDJIbHo5TVN0QzJFVjROUllxOWxsVXlt?=
 =?utf-8?B?eGdCOE5sVDBuOFlqc1BDQ0hmc2FUMi9aYnAzRkppcndrazJNQTUwUk10eldn?=
 =?utf-8?B?RU83aWtZbWllS1VOQ1RtV1U4c0JpdVZnaXhVWmgySkpWbkpLam9hQjZaVTY2?=
 =?utf-8?B?ajl4Y0ltamZqNjNDeDFuSmJmb3gvN2NNRVk1REpwdlAvYkVudmw4M05GSTV4?=
 =?utf-8?B?aEZsTllFY2I0Y0FjVTdRM295OTE3V1h3TTdJM2ZkSEVFN3R4VkI2YUcvUUtG?=
 =?utf-8?B?ZDcrdG1hUFJGcjdrUUQyc2llck5Ed0dDQmFLUkZ1dC9qWkJQeDkzdDRaVjhG?=
 =?utf-8?B?QXMxd0JOTXhndjBRbHlMNXN1U1o3T3FWNzFHeCtCbmE0REcxVFhFZFJINDdY?=
 =?utf-8?B?K0ZJTjNhclIyb2JKSmVBM05iVHIwV1B1ZEdSODBkcjF0cTdJWW1ESFYxeUlM?=
 =?utf-8?B?WS9vTjQxSzVkRHhidVFVeEVFUFVoM1Jvdlc5bTZWeEliako4blhvUVZzQmUz?=
 =?utf-8?B?UnJPODVEV3ROSkwraEphNlU0d0RlVEUrQXhMM3dwYWpab1B1VjkvRmxhd0xS?=
 =?utf-8?B?bG0yaVZnUGM1NE5NVVNHNkx3ZjhHNG9mN0s4VHFVRU4wcyt5UThSOG1kT2VU?=
 =?utf-8?B?aytsR3FHdWFBZ2ZoZlRNYlA0L1JRMXRkenBSd2I5OUkxSHpMemVnWmZlU3h6?=
 =?utf-8?B?Y2RNeUlVdXB6MWtuM2RqM2ROKzA1bm1KVEM0eExCQVEyL21LeWhzVS9Db2JS?=
 =?utf-8?B?ZitrUHNSN1VlMS8yZ1F2Z21LOEJhV3o2VmtyZE5LOGRkYlVVQnlRbUFmbHJD?=
 =?utf-8?B?WEJPb3JpZ1RTSENDdlhyU0lMQzU4V1RZeDh5Q2NXRlFKVE94ZjdEQWk2K1Ew?=
 =?utf-8?B?QkZxbjFaOTVBUVMwNGd4NlovQTVJQVB5Ni9rcGQ4WnJPM3QycnBIUFhndjZC?=
 =?utf-8?B?WUEwTXJQL3QvUmtCSkswaEo2SDJSSkpCSE5uWWtuRmZmZGRPZkZxbDhRa0ph?=
 =?utf-8?Q?gC2HJFBTcNKVkV8g72btApFkvDZHNGKYUFR0wJJprh9G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <479B72F79312E442AF3EB45D3F9E4D94@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784cf6dc-e969-4150-1d7a-08db4549193f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 04:54:06.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrBLLG9Vys9qkplQOLt10ChZA7yjUB5huCdmb1gdnOPT8VLMoUfSbTL8oX1ES0nOPoz4/m77AknThAExp9vfbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_215413_551157_5223B156 
X-CRM114-Status: GOOD (  14.01  )
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

T24gNC8yNC8yMyAyMTo0NCwgSXJ2aW4gQ290ZSB3cm90ZToNCj4gRm9sbG93aW5nIHRoZSBlcnJv
ciBjb21tZW50IGluIHRoZSBwcmV2aW91cyBlLW1haWwgdGhyZWFkLCBJIGhhdmUgaWRlbnRpZmll
ZCB0aGUgY2F1c2Ugb2YgdGhlIGVycm9yLg0KPg0KPiBudm1lX2ZyZWVfY3RybCB3aGljaCBpcyB0
aGUgY3RybCdzIHJlbGVhc2UgbWV0aG9kLCBhbmQgbnZtZV9pbml0X2N0cmwncw0KPiB0ZWFyZG93
biBwYXRoLCBib3RoIGNhbGwgaWRhX2ZyZWUgb24gY3RybC0+aW5zdGFuY2UuDQo+IFRvIHByb3Bl
cmx5IGRlY3JlbWVudCB0aGUgcmVmLWNvdW50IHdoaWxlIGF2b2lkaW5nIHN1Y2ggaXNzdWVzOg0K
Pg0KPiAtVGhlIGZpbmFsIG52bWVfcHV0X2N0cmwgd2FzIHBsYWNlZCBpbiBudm1lX3BjaV9hbGxv
Y19kZXYgYXQgdGhlIGVuZCBvZiB0aGUgdGVhcmRvd24gcGF0aA0KPiAgIHNvIHRoYXQgbnZtZV9m
cmVlX2N0cmwgZXhlY3V0ZXMgbGFzdC4NCj4NCj4gLUkgaGF2ZSBhZGRyZXNzZWQgdGhlIGJyb2Fk
ZXIgaXNzdWUgb2YgZG91YmxlLWZyZWVpbmcgYmV0d2VlbiB0aGUgdGVhcmRvd24tcGF0aCBhbmQg
dGhlIHJlbGVhc2UgbWV0aG9kLA0KPiAgIGJ5IG1hcmtpbmcgdGhlIHJlc291cmNlcyBhcyBmcmVl
ZCBpbiB0aGUgZm9ybWVyIGFuZCBpbXBsZW1lbnRpbmcgY2hlY2tzIGluIHRoZSBsYXR0ZXIuDQo+
DQo+IFRoaXMgaXMgdGhlIG9iamVjdCBvZiB0aGUgbGFzdCB0d28gcGF0Y2hlcywgd2hpbGUgdGhl
IGZpcnN0IG9uZSBpcyBqdXN0IGEgY2xlYW51cC4NCj4gVGhlIHBhdGNoZXMgd2VyZSB3cml0dGVu
IG9uZSBvbiB0b3Agb2YgdGhlIG90aGVyLg0KPg0KPg0KDQpwbGVhc2Ugc2VuZCBhIHBhdGNoZXMg
aW4gbGludXgga2VybmVsIG1haWxpbmcgbGlzdCBmb3JtYXQgd2l0aCANCmNvdmVyLWxldHRlci4u
DQoNCi1jaw0KDQoNCg==

