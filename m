Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C09CC7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nkv7oa6PQFXjo8fzGFN8Z7ihm3xd+X1R7fNlUCPb78Q=; b=vpt05+HkkF3CFDCHzr65KDFT6+
	8+eNMLph4+rH7Z9X9R0liitILtETh93bddLSX3uqsN7kJsSc6dMQgiabi4hvQ8jfdvIRtvshoeh8Z
	Yz8rk6boLpeV+aceyEHtJ2hve4HgwdbWA9wNd/7KZq/5GI5RU0Q7mLBUwaAeRwiHDMtiiBj12Dmfn
	FVZXxG8EuAQGcA8wXSB1T29fh1CGHJ0BkCmut6ix9MreWyJTcfVPhTFghuQNSbrDFhitWHjdMIsZu
	+aXRH290M0t17UVNzR6LCEHkGcDBLl8prIMKtPV2nn5H8yBLpKm4p0swftkvKREVxdr5GOsGaXDMk
	QNktr0JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Rd-00EqLp-32;
	Mon, 05 Jun 2023 09:24:09 +0000
Received: from mail-dm6nam10on2061d.outbound.protection.outlook.com ([2a01:111:f400:7e88::61d] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Rb-00EqLL-2R
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 09:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeVKRQFi9AHMsI6yc/yMOFSJRcoWMtemapWtQXRjTHdpJEZ99n51V3gpf/R9wcBQe+xKnH+6OXgURQHhZX1GQX6sxtbDzc9knlsv326jMFcF/gPNo4HsuYUX6khr/hLlIMT4lv5vKVjMHVop20G1tsAZLWx4qmiFyfgD71y6iIBSQrFbsPAEqOiFDW+pkbt7gBGD1NaOB6fi8edKW/0Naz1RXxuWYLSbTVN9yhk9kk6tPUSdmiAzq3Z1WNEjh6TXvNTfsVI4KB+X+iHSksgyaE4ia9NAV3v092l/3tKGLFNbu8sNIT7wg1j+6NrAcPq4YSCrgPKu/JcLYu/kjzNhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkv7oa6PQFXjo8fzGFN8Z7ihm3xd+X1R7fNlUCPb78Q=;
 b=AkvYqqhpEQ/OieRy7il0CUurapmlWUxzMIsdaOmXCGpjBZB+f6XqiC19KKc6Dh/dJns0kcQpOhcY0neTmdosW5cJLqjIG7Lhf2H1M0cnxKIcbZ02Vnva7fpfN+h0RejhwBn6+H3Y0qU9LXNnL9og4iX+nNjDYP/0qP3ot6eqngYg2XWqkmpUOp1Mkj8i/ndOUGLWq8xtbbVq54OqOvb3Szej8xHBMJyxTCViQKynQRvOM75aP+crx1EbWzKnVE0HKJdC13KLqfz/nnZmtmVv0PbkYjHfFWWlu6aluMn3WiFIp1i4wo6q2oEfYnrK3AoI+9f6+sSBtqxsE2ec/z5tgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkv7oa6PQFXjo8fzGFN8Z7ihm3xd+X1R7fNlUCPb78Q=;
 b=UsmfTLYGFQl4KhDypzCsV6f6qqnfdCEDTYMMuGYXlb1Iuk5QY0iyiDz1s4vWHKejpvI2ocIekYP3bvPO7O+2v/eE2k6S8wpc9JJOIM3IjuVbKZ4RAsyLSk7pEXG0mDpin3dbOTzzvORLtHYmQqcNtEbhe4GY2tkho2yGYV7gHTLfz/ltX5QndcHPyJTSM9xkCyGqPbGAlUMSJBCOZHep5rkMQnejP4gQftOw2lW651M4wzeJyC+EsRZ67kUPYmt+ObaMZjv5s5BAD3MWmMRLXuV9E+WyLfkFyJouQwxUyjghiCC9pyZ5QlLc8AnuVKUW8w6+EPUwD60ad7PoC65AHg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:24:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:24:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hare@suse.de" <hare@suse.de>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH V3 0/3] nvmet-auth: auth send / receive cleanup
Thread-Topic: [PATCH V3 0/3] nvmet-auth: auth send / receive cleanup
Thread-Index: AQHZl47e0dS5okoGe06Nw6Jxk254T69778+A
Date: Mon, 5 Jun 2023 09:24:02 +0000
Message-ID: <8b0a0524-b898-0ab4-df73-6d851f5010a4@nvidia.com>
References: <20230605091920.34253-1-kch@nvidia.com>
In-Reply-To: <20230605091920.34253-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB8114:EE_
x-ms-office365-filtering-correlation-id: b377228e-b1e5-495b-cf1a-08db65a699cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wg5rz9jc1nQYNrbT4gv1RwOOzTZcKm7psHCqA0S2CmjMwYd8pY76u3vqee6B0g7hoV2ghvpuN5xX6TLYZSuWlV3tQfNVEqrkCX9UJELeQPhYUz94CTgGz48FkhcsSs8BVJNgreECW3KEhWeXgLgvF9B5PRNotuDAf6V+g7zRVKm4ou93RZvHP8mBRP98wdrfNMSvufZPoOCbxEj4/ubTm9yk0hDMUYntLM6xGOWBck/z1o1ADdHA45Zd2t2JVDMbBwJrewKzyurp6JtRCRDsV6EkuOYWFYVU/1jxZ1AjHjM8atJdv8DS/lCmT8p4v68Jvrp+I4RvcqZxWavOjPvVLruUzjipVGl9jOWhUJme6bMDn3TX22Bmv/ONQc78g/7B1U/tGVTbBFRbbw7+2Trb1lF/hKcxeZUOjRJImE2kEUnvEzoLp60AOACw+T3Stb1TP6JIgHPQAae2xE3n/7dYVX3sbblwXng63V/oqzaK1eq3kOM8Fr3dDrjTqrtmer7yS1Xf1vcLuU3COGl8qLpdyt3/RZVrCQnM4GxvEHtqxTtRuPythihUSjlYHfQU2thXx0+tDAHo0LRSf1Tskj+qvMpeyNI3V+b5gwQ/J4r+TULDCIc/rdlhRn6sxOg5MLnH7ktsZGq7L/Aw1e9GWxKXKspUj91iayjOOBY5gpf+oRhc+1j947OiejoAhBC2aZm8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(2906002)(2616005)(36756003)(86362001)(38070700005)(31696002)(38100700002)(122000001)(41300700001)(316002)(5660300002)(8676002)(8936002)(6486002)(54906003)(110136005)(478600001)(91956017)(64756008)(66446008)(66556008)(66946007)(71200400001)(4326008)(76116006)(31686004)(6506007)(53546011)(6512007)(66476007)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNGK3Nob2hJN0x1NjJsanhLa21LTWJYU1BDMjN5Y2E2SFFxL0JZRGUzRE12?=
 =?utf-8?B?MGtEVVpSSXdGeGVXRzRua3N2RnBxbDl2Z2krUG5TeUhRZGR5OW1jZlMzMHlE?=
 =?utf-8?B?bEpwQmEwVDh4TVdYZU1ZckNVMGgrL3N0LzM2eVByNGdTWmJKUzBNVWg3b2hQ?=
 =?utf-8?B?VEI1bzd4b2YwbGtQTXJnTTIrb3ZUWHNIQllwOHBpcytjeGJkT0FvVk9ubDZW?=
 =?utf-8?B?ODc2dVNIQjRGYkRiWXVVSWtDS0tjWjZNQUZMZitPeG5NUEc2UFNURE9wa3ZD?=
 =?utf-8?B?aHF0RTh4aXdCWDBFd0oxWWZLM0lRQzEvUUZDZjU5ejQyeXlRWENHZ21YNFoz?=
 =?utf-8?B?WFZNQ2lBVFdXQVdEeUVPOURSU2ZJQm9maGYzenJuVG10cVg4ZWNVeHN2OWpZ?=
 =?utf-8?B?MmQ1M3cvR3lUdVU1M2pwTHY5KzY0NnNlNW04VG5oeGkxSWNmT1pwcDR1dElx?=
 =?utf-8?B?SWlYQlFZSU9QcFE3OUVsMHhVU0daZytZdU1xSzkwYUh3TWI4N3VsV09ZUklo?=
 =?utf-8?B?SjBmTWFUalRWeXM0K0FlSEtTTTNFeEliMG1nNHhXUmY3cTlXODd3dWxBaGJL?=
 =?utf-8?B?cW81ZTRoTVBTdnQ2ZWtEeCthdThqNjNiVDNNL2ZDeEFLSk1yaURHK3FoanFY?=
 =?utf-8?B?Q01MTlpjQUs3bHRhTUtrbE5EY0taY1RCSE4rbkJJejFoLzJhaWY5T01JUFN5?=
 =?utf-8?B?N0NEOS9XbkIyWTE4QVQ3ZndmZmQrd2M5U01LMDMwc1NBNXduVTVzVzlxTHha?=
 =?utf-8?B?Zmg5ay9zVjhxRDI1MW5yTTVxZkVmZ3A0amdpVVFWNjJqY25rdmtHRld4c3Aw?=
 =?utf-8?B?WlUrN0Evb1BtY3NhaXMxa0pzVEViMVU0Nk9adlFEWUVtK3lka2NXWGVWWCt4?=
 =?utf-8?B?YlZJUnZ4RjRBY0hNVzhMcm83elFiZjdOclFWaDN3TzdSTjZ5dms1a1R1Y1NJ?=
 =?utf-8?B?V1g3S0lOSzNPQmRna3pUWUE0Q3VnMTJqdmxxQjVWM1VoQW51VFg4dW05d0Vq?=
 =?utf-8?B?QlczbVdieEVSb1RTM1liWE1oM0JKYTRVQWEycHZ6dm1BYmJJN28ybklHVWV6?=
 =?utf-8?B?YnZZVnRGK2N5Y1lKL2dPcFJ2aUtjMVdFMFlFMm82T0pjWE1ycENQaGFPMEhh?=
 =?utf-8?B?M0JXd3JuYzl2WkJGdWxQMWttdDlWelpFYmpNTWRESlVXcVBmUW0reUUxQlh3?=
 =?utf-8?B?OXMvNjB3TjZHWEhHZkVJcWlzUFk3VE5TQmN0dVlnRlgrcjlJRkdGemdVeTVY?=
 =?utf-8?B?Y2tCWGxmcW5UOFJ5UlZHeGZHMm9jZGxLVmp6YXVtSS80MkFLUDBOWTZOV2Zy?=
 =?utf-8?B?RlR4Wkg1M3hKZ21DSlY1RnNsdzlCeXBYNVdadkxQYlpBUU9QYTlkcmFLM0o3?=
 =?utf-8?B?K0pIUloxaWVOYU1rK2ZJeGNhNTlpZTBobUl3OXlIaXhLNzltR0pIR0ZWQnFI?=
 =?utf-8?B?RUdhbVBEclFSS3RZQzhPUFpxTnpYT2hNVmthZ2ZvajlRbHY2ZmVGN3RYMFht?=
 =?utf-8?B?aHRCamI0REo3ekNOTGtJSVRLbTlDUnFjbTNvaTZTckk4VjhaUk83OUM2Zmg5?=
 =?utf-8?B?eVVoc2hyc0R3ZmZTdkFNTTVXbG4rNTZDQnpNTUdRRGtScmxyNlVGY2M5VFJx?=
 =?utf-8?B?Ym5OM0Vlb0F5WEpackI0OUdEYW5hV0NtUjBCUXY1Z09RR2xQclVXUXBDMEho?=
 =?utf-8?B?SnZvd205aUF2RG5GdGtDaGhJOUw3a1VRMC8rcW9NaHc1UTlZUHpjZVRTZWRx?=
 =?utf-8?B?eG8yMlk0U3ZlWE80MStRWDJ6ZklmL0lzOUpHWm1QTS9DeERRWTRucVFLbmtR?=
 =?utf-8?B?K3ppaTUzYXQ0YUIvc2lFck0rZnpjaEtlMlQxWlVhNVZOTG9PYnpWVDdXSjVz?=
 =?utf-8?B?cmQ3V21rekkyQ3RVQTZNSmVpMUdMYS92Q0JENnZrWi93bzVJb1BGTGRGSnM0?=
 =?utf-8?B?TGpzRlNpV3Q0NFpaeWl3SlpsTVJvR0lGMHQxakpHVXl1MHkrV3YwNFIvV0Mx?=
 =?utf-8?B?VFBkUU5KZkN4RjVrcEVIUE1sUExxYjFkSDd6bXZHc1RyaHZPcWpQSmFBOGov?=
 =?utf-8?B?NUJhdlREcVdnQld5SXphNEJBWTU4UnlTSUFvU2xUaVZQZjZVT1RlRzh2bDdF?=
 =?utf-8?Q?fCV7Rz4NQoc0sIfeB5B9MtbX7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D9CA5070479954795AD634F01FD59E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b377228e-b1e5-495b-cf1a-08db65a699cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:24:02.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YahLoTkAze9DIblRngBoth40oJaAvTiJN7y0sP1YSFtV/vVaHg9He1R2q1+16uZFiwHxNAceLxMTu3FmqLOHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_022407_797215_400D57DF 
X-CRM114-Status: GOOD (  16.11  )
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

T24gNi81LzIzIDAyOjE5LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IEhpLA0KPg0KPiBu
dm1ldF9leGVjdXRlX2F1dGhfc2VuZCgpIGFuZCBudm1ldF9leGV1Y3RlX2F1dGhfcmVjZWl2ZSgp
IHNoYXJlIGEgbG90DQo+IG9mIGNvbW1vbiBmdW5jdGlvbmFsaXR5IHN1Y2ggYXMgOi0NCj4NCj4g
MS4gQ2hlY2tpbmcgc2VjcC9zcHNwIHZhbHVlcyBhbmQgaXRzIGVycm9yIGhhbmRsaW5nLg0KPiAy
LiBJbml0aWFsaXppbmcgdHJhbnNmZXIgYnVmZmVyIGxlbiBhbmQgaXRzIGVycm9yIGhhbmRsaW5n
Lg0KPiAyLiBBbGxvY2F0aW5nIHRyYW5zZmVyIGJ1ZmZlciBhbmQgaXRzIGVycm9yIGhhbmRsaW5n
Lg0KPg0KPiBUaGlzIGNvZGUgaXMgcmVwZWF0ZWQgaW4gYm90aCB0aGUgZnVuY3Rpb25zLg0KPg0K
PiBBZGQgY29tbW9uIGhlbHBlcnMgd2l0aCB2ZXJ5IHNtYWxsIHJlc3RydWN0cmluZyBvZiBjb2Rl
IHRvIHJlbW92ZQ0KPiBkdXBsaWNhdGlvbiBvZiBhYm92ZSBmdW5jdGlvbmFsaXR5IGluIHRoZSBu
dm1ldF9leGV1Y3RlX2F1dGhfcmVjZWl2ZSgpDQo+IGFuZCBudm1ldF9leGVjdXRlX2F1dGhfc2Vu
ZCgpLCBpdCBhbHNvIG1ha2VzIGNvZGUgZWFzeSB0byByZWFkIGFzIGJvdGgNCj4gdGhlIGZ1bmN0
aW9ucyBhcmUgZG9pbmcgc3Vic3RhbnRpYWwgd29yay4NCj4NCj4gUGxlYXNlIG5vdGUgdGhhdCB0
aGlzIHNlcmllcyBpcyBnZW5lcmF0ZWQgb24gdGhlIHRvcCBvZiB0aGlzIDotDQo+DQo+IGNvbW1p
dCAwMWNmZjk0NWMwMjZmMWUyNDViYTY0MDFmN2RmMjMzNmRkYmFlMTFkIChvcmlnaW4vbnZtZS02
LjUpDQo+IEF1dGhvcjogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gRGF0
ZTogICBGcmkgTWF5IDE5IDAyOjQwOjUyIDIwMjMgLTA3MDANCj4NCj4gICAgICBudm1lLWZjbG9v
cDogbm8gbmVlZCB0byByZXR1cm4gZnJvbSB2b2lkIGZ1bmN0aW9uDQo+ICAgICAgDQo+ICAgICAg
UmVtb3ZlIHJldHVybiBhdCB0aGUgZW5kIG9mIHZvaWQgZnVuY3Rpb24uDQo+DQo+IC1jaw0KPg0K
Pg0KDQpQbGVhc2UgZGlzcmVnYXJkIHRoaXMsIEknbGwgc2VuZCBWNCwgYXBvbG9naWVzIGZvciBu
b2lzZS4uDQoNCi1jaw0KDQoNCg==

