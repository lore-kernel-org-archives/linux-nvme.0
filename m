Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81C7C28D13
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GdfMy8Rf70HVPA0Qk8F9YZbs1VFQHG+Hu96/VobnfCs=; b=f2sQ2HzugFka1PXmww5AzU4u9i
	3/eZVe3Vizr8XEZpy69Blgu1gdhKBRDeesc4AgNYEgFYEfR0hhZoCBQB5IZlxcjlSls3uJ+YhmDn3
	eNbk9k7NrhDbA1ZxDehIMDkNdbhBEXtIa0zRh7T5ihi8aGncmmDwvTjPgxBe5kV9tTVnWn1u4sn85
	vkNRIhBUJcKfqLsz5Xfn11wVTe8pUe6EAxr6n35D4y8GE8f+Gunm7lbzxMZWCuHtBWSMPScDUVs0n
	UEm8XiF9PPv6c46+kX3QOW8PIbXVHQOHBEmtmE29dEpPm2QoJkCOPuCWFqOeZvcaaqx01qaDLg3x/
	vuzdiKcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR8oa-00Aa0r-AA; Thu, 25 Aug 2022 09:06:16 +0000
Received: from mail-dm3nam02on2068.outbound.protection.outlook.com ([40.107.95.68] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR8oX-00AZuJ-FG
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 09:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6YUA5nv6XpA0AcGL6++2N/6Ca/1hppSeBJ4CqLO3Y+JQ6EyJoPHuCN34uyisE6kMXaVjc3b3kaxnUP/AXew6uudfMcFnSkJgQ7aMHJCfbsZGwrWc4UnvBjmOkIerXXTPwfkTjAx4/kxxvDTkuKm6f0Pq0/RxnnMQoUsV3rOnXWHlSucq6Qf6oGqAp2GvvCU15Qbl+EVCjJtP/BVHfgFb+b/UduClGGLa3sJlvxi8Io6LzlEVSyz3rYaE8oZLcqIRXG5Pg/X/q39AB9vhXQXPtsigU/b55xmSb3SMuwGXVdrdccIaJqivJHSPYGQMY3m0Dk+isiAIPdJY5BUN6A1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdfMy8Rf70HVPA0Qk8F9YZbs1VFQHG+Hu96/VobnfCs=;
 b=LllGnwtzRL5+C9ARwPEjQE38DJv/TbA0lUOr8zs5q1Qli9TCgk3/lZTn2E8hgYYcd4cwzX3Xmp1dkYCbkFWWel6PQxxVLvmpH6ke0t9pSLWQ/uJL7O1ZsWmjI528VO2imnMV/OH1+juqanfBvko2xqNF8u7W9IMBzD0Wr4igJqapFXl0Y8ixr05+N059yMNsj8CdkEIKjUgKGgeVn8aqerRpJ+lhAJhFJAnHhM7UOhSilc1o5AreNhc1wiCB+UOmJFwVz8ZGkRKG4FWiFtAOmmAq0t3PdYvSG/o0awMxOFVVZogWFn9r6MSX+UsrG3Tv8Ig3qJ8NtVbrQUzER8GnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdfMy8Rf70HVPA0Qk8F9YZbs1VFQHG+Hu96/VobnfCs=;
 b=UH7lx9GaZ7WU6vCk0+tQEtJyayQV4/6BvADWbFbIzPF0+7LCqZ7g6PMTTkDR6B7HdeChIGME1xDiIAJk5VIiDoS0luz3qHpBRCAl4s80baOyVk7KzGUgzJ7JrhGEUsuXczGtyIa3rWyMGNAkbcRqXuKy6cLfVZqaSwgHc81oopUUO6R2k3zN992cul/Oobq5Eoyao05hlRchso4Wdqbm0E6AsFyeGG4cLZjothAjjEIIb91PXr91nFE8heht6RTuZeEh4Jkh10WYlw+kFPh7pa3cnzNbJ3x+Op4wBrSDlHMH4dtvX6N9zCL1KjbTxrwlNTIK1mxAVlRWNZiO+z8CaQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 25 Aug
 2022 09:06:08 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5525.019; Thu, 25 Aug 2022
 09:06:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Tal Lossos
	<tallossos@gmail.com>
Subject: Re: [PATCH] nvme-target: add missing goto in nvmet_setup_auth()
Thread-Topic: [PATCH] nvme-target: add missing goto in nvmet_setup_auth()
Thread-Index: AQHYt4qREgr4Xyvx2UWcnWax/raVHa2/VL2A
Date: Thu, 25 Aug 2022 09:06:08 +0000
Message-ID: <1aa60d23-e57d-871d-864a-6b06782f56ea@nvidia.com>
References: <20220824072316.44389-1-hare@suse.de>
In-Reply-To: <20220824072316.44389-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2846f6ba-1255-4c39-ebf2-08da86790c48
x-ms-traffictypediagnostic: BYAPR12MB2677:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  4p9eY4yXIJzDAVMd3Kwa3eKSAuJO/4pycclAoyzs3Mve3miS3+Jz8fghFdBwuPPy/cCsFJdubGbKCjR+JnPSdmXfEdi97TrvLmnBaiNQoCObDIqrnYaMyONQqIcL9mbHhv3YI3EAxEJkiIIctLlrFV/WB1xaGZao8B6VKTlWF2SABUfc0CCL9g3U2EhlMSr4KWnyi2dCp1Vp9seMOtYIw4SChvvEjW7OyGDHStCQbwWEP5NRC/OAObuOKyX2V4sd09Ml5Bf3BI/F86POK9LWosHLKPNpDYZj5Dk11C3TBNESe+z6YvJtmDtS0BB43Ojgy+JiAR3OuF+63cygl22/oaeZPE/+jL1YDwXMkrV5g2te+jM02TfoBAaUDfhZY5v9AiWAje0ycLow+PS5WE0NNBDnDCYaBtjbv74DnxQN2gJBTX3OzlTW8tJVDZGv7lxXYbtqRGNklTfosdjKBf1Kfspa9xV/jFantQVR3vu9sEARgtWgekEFyq2+DdnAOE9wywJdpkOQZCSyc5kN4ZGSslEv+4kB70/944/kWP6prIKaN9SplueVag9uKwmQ8clVDKcG0/Wi+DMN4C+ZbI5YONZXl5lkr9Rb6e49hWMzf73OlBR+GfD/GtodMPEHjkvpxsk1BPcT2n9j2k2zuw2MxYGz+Rm8HXqJIxufgwrfBJPphJ7Ksj5qXw8p3vg20nUGoDlPqugi1usRo7uztXp/XMntuVjpXFqP2oUf+90Q72Xe5PUSVB0WTLJsXfLkrxOYCsOH1jFASDt6BA2u5tacBL5UzYNF5xsxtnS4Dp+U3Uz97aCMHQ952ZkiRiZGKwC2RNXmSGLTkbrWbkl24rZm8g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(41300700001)(316002)(478600001)(71200400001)(186003)(6486002)(53546011)(2906002)(5660300002)(8936002)(2616005)(66556008)(54906003)(66446008)(110136005)(66476007)(4326008)(64756008)(6512007)(8676002)(6506007)(66946007)(91956017)(122000001)(38100700002)(31696002)(31686004)(86362001)(558084003)(38070700005)(36756003)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZHdLcXVmYUF5YTRXWjI1Yi80WVY1d3ZqdFNzWTBSOENaSnpOTndmY1ZqbmVQ?=
 =?utf-8?B?UVRqYU9ZcWs2L0RrQWF3aTB4d2pVL2hSVFFEeFNqUXRVRktlbE1NMi9kdThy?=
 =?utf-8?B?Qm8yaGdUT21MR3ZzNVlYU3RpbWJSaGduanpvR3FBdzY2cFB0MGpBK2d5OTl6?=
 =?utf-8?B?b2NTSUZyRFRJU0VZbzYvUkp5MzVjazBXcUNvYVhORlNQZUR2MU45Y0NCZjVP?=
 =?utf-8?B?Tnp4dFRzZmlRMmVjTFZLclBvUGs4OXo4eVcrRXpzWGpLK0x6UjAvNUM3V2h4?=
 =?utf-8?B?Tjg4a3ZGZEhSVWM3QmxGTzJsVEp4YjRobmVuNzRkZ0lnL3IyNzU5SEI4VEtJ?=
 =?utf-8?B?dUorbTZXTlZra0hQVlJ2WVdabUJ1OEVCM3RZSlVlY0pzaG0zR0Z1L1pvbkh6?=
 =?utf-8?B?NmJqbE1lTUgyeXlnamh3a2pucWlONW5RUkI0UlY4dWFBWHV1VjBNNXVpdFd4?=
 =?utf-8?B?TVc0ejVUcFFpcFRIUi9QVnFiOCtKd29nQi9EY21UQUJtbmN5SmNqcXp5a1k1?=
 =?utf-8?B?MHlTMTRMcnNwUXJOSW9wem1WOGRScUdBNDIvVXIyaFcyWmNPZytMMi9DenZx?=
 =?utf-8?B?aFpTcTRhdWhWQStTN1VWTGVQQU9ERGJ6VzlZaVYzRjdRbnhua054d2dRV1RR?=
 =?utf-8?B?UmV0ZDlpc1R2Wk5mNndycnViMDl6UzJIWmN5a2lsRk81Y1JDVDZiZzBWcDZn?=
 =?utf-8?B?OTJmZzd0dVE3RjlDWEtnM3NpMUlmbDZGd2JBV1p6UWVrdk1ib3hmY2NLVkVO?=
 =?utf-8?B?cDRDTUs3elRwM3M4S3F0Q3BmZkhBUm5meVRHVUNNSWFReVBCZDc0OEFQSEx6?=
 =?utf-8?B?UTNlRDBQUkNMT3ZkNVhEd2ZuQ2ZGTGpQR0Z0Nk5nVXh1dmVTZXBxcE9rUVY0?=
 =?utf-8?B?Z2Q5TTZNUERLVElUODlxUHFXajRSV1QrZ3Ixc3RkU0FXL3AyR2ZsN2ZBUFNM?=
 =?utf-8?B?djkzU2ZmVWNiZzl4UU9pQ0g5eHNoOHg0cWRpZUgvc2p4TGJjUkRFNjdadUVH?=
 =?utf-8?B?d2o3N2R2eFNsYlJuUmZQS0xtSldSUzBPSm5wOTE5Z3ZIbzVUSjV3emVMSCtr?=
 =?utf-8?B?RVN1VWtaWUpHWTFib20ra3FyREZjQmNhZlVTL2lrMU8yTGo5VC9VaVlOZEhL?=
 =?utf-8?B?dWpqeUpEOW4xYVluM1VVUktpNHFTSzMzSnhSY3Z0Nmw5MTdlRDM5aHJGVTJL?=
 =?utf-8?B?TThoYzFUZ05aNVQ2ZUtxekxQeXc0ZkRqY2I5b0Vyd0U5OVhLa2FxOWs0dTFp?=
 =?utf-8?B?RFU0MXdFU2o0a2ZjdDBlTUhXejYveG50OWg3WlVNMlgyNUdtd3lQYTU3OERt?=
 =?utf-8?B?RGlYZGwzcy9VQVIvUS9sa0F1SnM2YlpDTVBkNlZUYldGaWlaOUozSUovRjNv?=
 =?utf-8?B?Q1RqYVo4OVpDcUVKT0xNaWVTc3FhcXEzZitkRGd5RjJTWmRCRVVrdjRUdWlq?=
 =?utf-8?B?a0h6ZW5YQ1dLODlnRGVsWmRyV3JydkNnSU9JbVNxc1htUHVoSWdJYU9ON3lV?=
 =?utf-8?B?Y0RqVjlWVnBNN0V3MjZOc2ZjQWRYUUpsU1VMT1cyQmdSYk1BT3crR2FkT09s?=
 =?utf-8?B?Vm1EMkh0ZmQrNFo5WFNpWEdHUjI3Q0tRSUZzdDdaT0hkKytRU3FvRHEzRlU0?=
 =?utf-8?B?OTZWaW5pVGZTRk5NL3BZdmVHbjRZQ3NYekN5cUNGV1VPWENOeGdUelVqaXNo?=
 =?utf-8?B?UXNXakIvZ3ZIKzF6dmZBWEJWVWVLN2VnS0Rhc1ZGc0hMZXdlNlRGQjBRbWx5?=
 =?utf-8?B?dWo5eXlaT3JIUmsxMVRpNlpoUlQzN25DaU9RbGpOdG1lNzVqSU0rdytKM1Jo?=
 =?utf-8?B?S2NhbU1ZTUsxbnB6N0k5dEdEY1ZsNEd0ZzU2RjV4WmExcjU1VVRwRFZmTndW?=
 =?utf-8?B?aVd1NUFsQVlkWHNidEFiVmpjZlloMzM1UmdSdG01L3NndUlDSjZVZ3VBdVF0?=
 =?utf-8?B?bmM0ZGdKZ3dmNVFkc0RXd1JBbU1FeFJZdlhQUXp1M0NwWkNFMDI2cWJCLzJS?=
 =?utf-8?B?UE1LRDVsaHVRUG9XNVJuTTdzS0JaaDRTUU1aRnVQbmJxUWRTR2ZpcW5rUUpY?=
 =?utf-8?B?M2xHdWxweVg1Z00vZ1V3ajdSYXNoQlBRd0pseTRrdzE0aGwrWWgxT05YWlUr?=
 =?utf-8?B?MXdCbWxHbW1mY3kwdERhM0VOVEF0T0ZFcFUrZXlwVEZMZzlFakh6N25rUHJD?=
 =?utf-8?Q?RxQ68spVDP4jii9/Nw8Xy+yQfZVYOT9PG0jzNJoOJETU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D3360176888CE4E8C91805A6EF0EB86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2846f6ba-1255-4c39-ebf2-08da86790c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 09:06:08.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEIA11pm1PpLAyNXa6C8+0bpBjPl3/XDXz4cN2PmvzRPfCD5qbyqDsXXw3WsswyQFf8O6UdYI3juO2IunukdqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_020613_796381_DB829142 
X-CRM114-Status: UNSURE (   9.06  )
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

T24gOC8yNC8yMiAwMDoyMywgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBUaGVyZSdzIGEgZ290
byBtaXNzaW5nIGluIG52bWV0X3NldHVwX2F1dGgoKSwgY2F1c2luZyBhIGtlcm5lbCBvb3BzDQo+
IHdoZW4gbnZtZV9hdXRoX2V4dHJhY3Rfa2V5KCkgZmFpbHMuDQo+IA0KPiBSZXBvcnRlZC1ieTog
VGFsIExvc3NvcyA8dGFsbG9zc29zQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

