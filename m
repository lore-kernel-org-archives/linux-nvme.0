Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23051C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 03:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cgil+KBcPrTMe5kweREhiPIfAFrNwy4juF3s25vriOg=; b=tZGRJ9L9IE/ziGPYFMeVx0VHid
	WDjY4izioDnOe1tSDgq5AQfS3J/4sy2is5nLXPd/ok0PABLLBDNmUveN8KeHUQzmsHy+FBrcYmm5x
	URf04VCqfad7rX6BCPhCNyKt0QZAzPyR1mn89uXhfoILa49cR1ilqAniSDA6Yzz2t9OdzEz97xXZn
	Fvax2xdhO37SwW7N8S2Bu23Pnm9mK/1BdxkMaMEjnx1LjC8r6XSrqmVhAomy54utclD/4JvmkNn1r
	xiQ48duquuxTniLXV7bepZpAOiLNciMc3u/bnEf6u3ncb++Q+9OdEfSC8pqzE/lBoqA1OcDLXj+zt
	WGbF3ddg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZHD-000cl6-Ue; Thu, 02 Mar 2023 03:06:39 +0000
Received: from mail-bn7nam10on20626.outbound.protection.outlook.com ([2a01:111:f400:7e8a::626] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZHA-000ck6-S1
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 03:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixzWVylAdVD0FCB3Ajffq8Kv1/Qr4PpVwxFOnHSBqhcc2+5GlHG1pz2nwxiyb887f6Wd2Aa/T8qNNIZkaeH3cASbXvpUvO8P/+rtrxJZtG8NObe+qcWrGIPiegB68YJ22ukCQSJgMqxFVrcWMupldOTzaYan/oCCSpcJ63/EB2Qs+Wf66Xx0MT16Md+KExs+cyfEvpN854zJEWHqbUkZ3+rOzSQgXX5F8L17lLDInJGneVJlCYI+u8xvIaPgwcpYIZ87BzYocLgydMblRlgU/1/2piipOUmIwRdIw0BOsxHw/oJ2c9FvkCTXNtSZ4BdTWyqghp67WlIbAbkoi9vc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgil+KBcPrTMe5kweREhiPIfAFrNwy4juF3s25vriOg=;
 b=WnYH/s5zZlhcjy53GwTCd+djEcAdZiB3cUsYCz/EitvQLoVoYCycr39sCnXiwg1q3QP4/ohxWwbuON+M1CnmUuIabd4g6kXydlJVpJPmrwD5/1YBQyHacO8CFYs5Ix4GEIJAef5Zk5mZwaNa4b+YeFMtEllvzaOxDkkhkq74nxVaSSpd7Ugb0JPPCGFcKwayGDV2NReK+z/InFBV1l5xms3DToIikkklO2ME6D8JpOfLF5QZ+Jjb9SKNcl7byVdIylrY5Ceq4onJF/lmKlWSN768hmzQ6zW0142Hc+WD47SMVNMNZAnGlTHFHZYO9p3Tn+3tTgUC4oZN2x5nS+iMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgil+KBcPrTMe5kweREhiPIfAFrNwy4juF3s25vriOg=;
 b=TrYc8W4DV5jSMzhdoMrpPhpZQgJ6FkxPowMXKujOvJYx3O+OwycfQ24Lt5Ta+0h1zBQc8dd0jD+BTWLxkmW8r/XBkHqyEC6+41lzJl6YNcKATH1JWfPFjswi0I4Q+r5Ygmq7m5doilM83iyTiedqSxrxU47NVgBDhgSqBuBsTpUQ9UF+Y2gXbdlcAismVuevn5ct4MxLOubHopvee6B3OZfBja5o/3mTvvDhYSrbmJBTTaJQA/uOM06HeiYk0wnNiuICe0VtB8aoiETMFJc0Rl3RnuBgr3vfe3BUp1dZyL471XoD3xj1hwBTSUBlCVVuC9wBsT1feDztETesNCz6Kg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Thu, 2 Mar 2023 03:06:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6134.026; Thu, 2 Mar 2023
 03:06:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "hch@lst.de" <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] nvmetcli: set up the target only after the network is
 configured
Thread-Topic: [PATCH] nvmetcli: set up the target only after the network is
 configured
Thread-Index: AQHZS5LrvykEOywVsUaQSg4xGb10m67m0NaA
Date: Thu, 2 Mar 2023 03:06:31 +0000
Message-ID: <029c9051-6a43-1b2d-a513-3559e3c9ffc1@nvidia.com>
References: <20230228163615.436692-1-mlombard@redhat.com>
In-Reply-To: <20230228163615.436692-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: 371c2065-c033-4e58-ecfd-08db1acb1fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  rb1u7eNmQJ7AiB04MKznE7fdVkh1Vo0Oor9InCcN9MufOrXAnbvCCQDwasd52E4SF8kz6umPY84Vf818YrCvhGkWoKZJq7F9Ta0afp16i53YgwP/4ZVAEudEka3qnxi7mn9Q4wNT445cnhJwXzhI8s4d+Hx1U4BnLgZgyBwFCNQfwofOJ8SzHqw21R3roCuz0YYczqUSUuD0IqqXxkJmAgvx2j4CqLCJKr+nB/gyJ1yuv0nP6+ba3n1yfj6r3LQh+2Ev2PXa1uOdNNkVzjt0KE894XghYwR/HXrDFcRgaLIGtFLuwb9kz0LKCnIwnXf9SII2EKuAQQXW1HmrL+oakhMKUBi8aSe4xvWmCAv3SKNxb5HCctKXpw76DaJ9MclLE1BzRwXcyy+4/Yd4lB4LTaQDK0zHuzUi0mwOw31mMx9pfqLwJQGYaPeKo5+uzBhBznHIIqRDyEA5HKmn6bozPmjYvpNTSGyzwlJ+FiHz4K4RkuPT/tVIDtDVXl50LTQ8Awl2CICHfYwkxDE8PR1Q2DLRIc4x9QfVsmp4OPBCT4MzkxBzLxiOUAXtZX+SJOdQcoEfk40IbME8QtpgF93tpD3z33SS92hflamRAvj6KthgFC5V6DRKjiv13U8HrjChTBk7T3gudPbgsujD24r7jMEwJtHjMkj+SEkoIGiSDVxGPIUK4AxN2WuEBWyX0hDV1sMIces6brngWbOG2sFdyFWnpf9GauZUDmJhc58D2IVSnZb+HtfsBfx2nJOscjFzPhJajM7SFlf+ewtqLUmgaA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199018)(38070700005)(122000001)(86362001)(66476007)(31696002)(41300700001)(38100700002)(8676002)(66556008)(66446008)(5660300002)(64756008)(66946007)(2906002)(4326008)(8936002)(76116006)(6506007)(53546011)(2616005)(110136005)(186003)(6512007)(83380400001)(316002)(91956017)(54906003)(71200400001)(6486002)(478600001)(36756003)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TVlTVm15SERjKzJ2bVd3RzRyWGNBbzFWbzVxZEhvVU15aEVBMXhka2R2c1kv?=
 =?utf-8?B?ZWF5N2FSR3VmcWZYVzlKTEpjdXdFNzNuV1dFejVwaGdTcUphaElOV1RNMk4x?=
 =?utf-8?B?dWVoVkNXdms5QUNmckd1Tm5yN2wrN2tzdFcyVkhWWUtrOFpoeCtzS0l0Q24z?=
 =?utf-8?B?UitURVo4L0o1cTJCRkNMYnJZS1l0akRDREJWYS9rUk5QdEJPbkVpUjdCUWU1?=
 =?utf-8?B?TjNuVnNjWWVKNkVPbURRS3lOZWxtREpaL1BlUEc3dE95QWc3Z1dOMXF4c1Rt?=
 =?utf-8?B?RjMySFcvQzhWbVJIL2pJT21WYzVEdzRvZC9rZHV6Z0JMVmw0cml4eVlnQjFR?=
 =?utf-8?B?c0J1Ry8zMEUwcEkvck5PVGRURzhITXJVK3pXdTk5QUl1bHhZYUY2OTBMeXhk?=
 =?utf-8?B?a3R2aDBHN1l4OHJaTW9ucWVod3hTUC9IOWwwclVPWTJRSEV0cEZiMGhyUU1G?=
 =?utf-8?B?VldXVjNpQ3UycFg1WFVXcGhERUxDVStZcVp1ZGdvQTh1OGZlQUZRdS9hc2pK?=
 =?utf-8?B?SEZkVXFXdEJUYWoraDlTRWtGcXBvZFZnbTZIU1hhZWJJM3pkOHZNbDd4ekNM?=
 =?utf-8?B?Y3JZcVl2UGM3M1FhQjdvQWxiU2k4NUk3bFVpS2x2M0JkZDRFNEJkZ3pVUXpK?=
 =?utf-8?B?eHhXdzVkRFZpeWZjZmVEVzZjSUZDNW5rOUozelAycTQyTEUxV1A0V01Fc0tI?=
 =?utf-8?B?bS9pVUMzS0ZzSEc3TUwxcVh6dHVEeFNJOFRGMFI0U2FWaithVURtSkFHRjk3?=
 =?utf-8?B?QUNHZlpIVCttc09EeTlGSm9YN1U4bFI2R1l5c3N3WFRzbEx5amxqc0pyQlZi?=
 =?utf-8?B?cFEzV091MlYrSlR5T2VrQ3p6Qm5mYXZCbXlHMDdjWjZZam9TYlZaR0RRRnVj?=
 =?utf-8?B?SVFyVkwzbjRXRFpXVXN2dVQ3VjBDbk5lNEVqZXdHbHROWTViMnBKdmpSMEhT?=
 =?utf-8?B?TlA5OFhoZmFQYjZYMU1IVjAySzlvM2ZiaTM0a1BadGFHZXJNdndiYi9wZWNW?=
 =?utf-8?B?RHJtREZEYW1ETEkvcitVRmx3Um1WQ09mZUl3dm1rMTh4ZmovWVAyMDJyTkl6?=
 =?utf-8?B?bStiTFhkVTJpK1JvYldwTVdtejR4NjRBRjc3SUwzdTVHUmZ6L3lIbU94ZVJz?=
 =?utf-8?B?V1hMUmxNMHlnaWtJUXBMSTFmRG43S3B3SFdRMGpsUkJ4VFJiWGJZd0Q2MHI1?=
 =?utf-8?B?SFFZVWM5Z2xHcjN2MGdyK0xuc0dWcndBbm4wdFVCQy9RQVlNSWJyUUdFeG55?=
 =?utf-8?B?M2FxSXZHUTAvOHFqYlZOaTd1c0dGei9YbkZUTE9tOHhDTDQvNWRlQzRJUG1Y?=
 =?utf-8?B?ZTFKUkZNc000cTA1QmlEbjBDUEtQa2hDT3FGTEVXZEdKS3JqdUdGM0poZDVD?=
 =?utf-8?B?cUdrY3BOaHhGT2tQdEs1RDA2SkxHOWVoL2dPaW02RDIwNkYrUVRRcjJNVWhj?=
 =?utf-8?B?NVdBVWt6bFI1dStqMlZvcDZyWW5NeW0zai9XMm1NUStrQ2lMZU56Q1R5Y09t?=
 =?utf-8?B?UDd3U3R6MkttaEpicVR3UWpvTmx4WlQyNGlGbys4eWRNK0pQVUJ0Z0c4ay9N?=
 =?utf-8?B?VWlxa28xcXVCaDVXOG5XOW8rZnQvVTkvSSsyRkNiSCtIWWxsOGVwaHlmQlNw?=
 =?utf-8?B?cTZmL3NKSDV0dTI5dG9hZjhtcno5YnkvSUExYjdaWE1sbVFGdFdVU2dTaFVW?=
 =?utf-8?B?S0hySmo3TlJvVEtnMytHc3hUQ21VT3VmZm0yZ1cxTmJ4UTdTcG9EcDVJODhi?=
 =?utf-8?B?eUVtODZlSk4ycEU1ckVQRUtJWHlPaXZrY1laQ1FJVVRUaFhldnBsZ3BzSzJz?=
 =?utf-8?B?ZXNsSWhuR1dyekIwTW03TS9BRTlUaW0xd3pKamc1Q05mTHZ1STJlZ0d2Skk0?=
 =?utf-8?B?Nk40bXo4NjYwd1k1ZytEVTZkZFd5WEg2cDFkbHZ4Z3ZUM2UrYXRNcnI0OFpD?=
 =?utf-8?B?YmNDR2svZlE4N1lGczNOOG9vT3pyQU1Tai94YXRrc1YvbCs5dGZ6ZHBEU3Jw?=
 =?utf-8?B?RXhmVHd1MjZRVzJ6L2tmSUpYclFqdTViSE8zYW1yaEFITGpQZ0FrdG8vRjdT?=
 =?utf-8?B?Z2JJcTBmNXRuci8rWkFlcmRYdkxMUHhocnVmeTR2NFNMYWsvVzVHcmlKTXEx?=
 =?utf-8?B?dFJrSWdCbnd2b2dpWE04djJqeitVdWxTTGZDTmdDazRKSlJueTgwdGlQdkpZ?=
 =?utf-8?Q?hW/68Ih+WIJ/k5RxLU0a9Avndp2zLoS/zhQZYPBRpyq0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D712A0C75F6D7428C3172089C8C5263@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371c2065-c033-4e58-ecfd-08db1acb1fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 03:06:31.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XD64dmQJ4MDzq6yi23W0qiEaC9fKCnffpprecmUjn5YHOVmkoZLFufJDil6UdkQYFf3xxJriy+fS3aeYLmwE1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_190636_946032_EB3B41B0 
X-CRM114-Status: GOOD (  11.32  )
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

T24gMi8yOC8yMDIzIDg6MzYgQU0sIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPiBuZXR3b3Jr
LnRhcmdldCBvbmx5IGluZGljYXRlcyB0aGF0IHRoZSBuZXR3b3JrIHN0YWNrIGlzIHVwLCBidXQg
aXQNCj4gZG9lc24ndCBtZWFuIHRoYXQgdGhlIG5ldHdvcmsgZGV2aWNlcyBoYXZlIGJlZW4gY29u
ZmlndXJlZC4NCj4gDQo+IFJlcGxhY2UgaXQgd2l0aCBuZXR3b3JrLW9ubGluZS50YXJnZXQsIHRo
aXMgZml4ZXMgdGhlIGZvbGxvd2luZw0KPiBlcnJvciB3aGVuIHN5c3RlbWQgcmVzdG9yZXMgdGhl
IHRhcmdldCBjb25maWd1cmF0aW9uIGR1cmluZyBib290Og0KPiANCj4gWyAgIDE5LjYxMzI1MV0g
bnZtZXRfdGNwOiBmYWlsZWQgdG8gYmluZCBwb3J0IHNvY2tldCAtOTkNCj4gW0ZBSUxFRF0gRmFp
bGVkIHRvIHN0YXJ0IFJlc3RvcmUgTlZNZSBrZXJuZWwgdGFyZ2V0IGNvbmZpZ3VyYXRpb24uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVyaXppbyBMb21iYXJkaSA8bWxvbWJhcmRAcmVkaGF0LmNv
bT4NCj4gLS0tDQoNCkkgYmVsaWV2ZSB5b3UgaGF2ZSB0ZXN0ZWQgdGhpcyB0aG9yb3VnaGx5IHdp
dGggb3RoZXIgdHJhbnNwb3J0cy4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

