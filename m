Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8DDC38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jdPjoBGVVc2BN5zKJWBokX0+/TQnpaas10kB/6JLan8=; b=UIyQ5CddyJKtgahh3dQt1MioeR
	8MsuYyueQvpDwa4mh5tLK56s9+LgIrViHuLAtsd25Nyt3kXfGIKseYUQXcWFuxyJ7Lus6WRB+eY6t
	/adjc5I0Dqwt6u6cKcNOJp6x3/DSOC4e8qs0asm5PH/DDT+pcNxlQky3o/E9ZG1aFj1J1wZrbtnlw
	NeRWNUCK5T29LK0C471tYlMRMiumD+pbyj/9nUiSnZkE8rtpbFlPG/3YkrjNr+WOf+k+MLlZaLFWU
	N5Z+oKb0aWSZfo9dZAZvxxhXmLnX41+IFPCVKpqAwaHzKxaRToBPXRdj7bBz33yI3xG2qFf+2YD24
	il4bsLUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVwQ2-00755O-Ps; Wed, 07 Sep 2022 14:52:46 +0000
Received: from mail-sn1anam02on2089.outbound.protection.outlook.com ([40.107.96.89] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVwQ0-00753l-9d
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 14:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ4/QLXFuYdwceSzhQdX3gYBCbNctuHhhGo4roFJM4u1fyR0mfdA3NOZyQdqowJzNWfMLdvWpXdqZ/84QciQ+smBjuAaprSvNyodPjK+RAOfm+YlmAD2l42QcPX2M+HERtAJZW/dqYRGgzeK9PKt5B1mThGFiH6+zmn+t3/LwY3x9Yu4fTmx3nAuYgHHN/YY/7rrv5/Os36dd45IBaLjLg849s4a/6/FdWoQzKCKH46TXl7sxLCSDXmqkusjdKfOMj2aefdaB8wOpYONgfUs2o5IquUm3r4BLviooef952YyV90UxmGXZYaOZ3uirj+RznzUa058s6T+mqwaAtnd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdPjoBGVVc2BN5zKJWBokX0+/TQnpaas10kB/6JLan8=;
 b=JHVOpvV1kGglN8twiCgZy1U0LlkW6GbCx+Jb+xDCXtRoFn3yxACGRl5y1/YqUZpSX7pAEPWMBs5hrJEP/fEhH3iNK/zExybXEgHLKV/9pE39KP7d/wHKhFe9NaL6fPViWtCgMcv7wYyiGPC/6+PyM2Bnsi2aRd1vtebyMYiOamH6FwP4R5MnFRMs0Fssnl5QcfsUbK8lrM2sjMH3KldW2CSWdVMSgt7v4yKs24lybv13DOajpfkJM9ojq3ejUzV1QuPXWDvym64xw+EMipWLlWkoh4Je/66cl1sXAGEZyQ7djlGU1yaMDXR2LovtjjK9iQEi1lFAaGh66kU8uqLXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdPjoBGVVc2BN5zKJWBokX0+/TQnpaas10kB/6JLan8=;
 b=R4jQEyyOfcuZdaozZU0ZJEFBO8jXL7OORVCznvMtYaapDk58F3uFXbRqt/5zArEQWC8ZtVpukvqhtcHDf689o4/kw7xFUB3r09tr6VExjlqstKFYAFLh72RRLyfxz/KkTY9yb4+JPjsBznJu8n8y0rlE+9fzR1paJ4xYPwjmf2ENMA8AyeJPl/LxQ94OcNwTl0HviNZ+nIB5TIQq1iEHYFb+ITLjwmLRQKSXnhZ92Fo9CiTUdaEQgl7Ow7SZJY5drLthlY9llJxlWE6Ph9t9xHcUTaaCVanH03jh/oUEPV4UVUlLePRor8AeTdOkdLyG6y1+i099xD70qf71McpMXQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 7 Sep
 2022 14:52:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 14:52:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH v4] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Thread-Topic: [PATCH v4] nvme-tcp: Print actual source IP address through
 sysfs "address" attr
Thread-Index: AQHYwrVrqy+mg15FeEyn9iUiKKWT1a3UDYiA
Date: Wed, 7 Sep 2022 14:52:39 +0000
Message-ID: <d32a9944-8a25-293e-d2a1-50317cd272be@nvidia.com>
References:  <BL0PR13MB4291260D145FAAC1B2B5C4859C419@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To:  <BL0PR13MB4291260D145FAAC1B2B5C4859C419@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6211:EE_
x-ms-office365-filtering-correlation-id: c147b88e-acaf-48e4-ec60-08da90e09c3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  unnOhvnr+AN+SnHgsH39DrIliFEl0vS5LY8JCgY/vaNC2Y8+XssdwAjSlKrSHgihfR3wizA5ff15YlCx+gXZxcTWMBfQzqUkz30Cznpo6w24SKbcy8nrcWzX/pDgNHt+FZSGy1gGdxwkBzmePxSuDh51NvgGwrTA7hNjMzmCoLMwwkiUnaFRoNYORdmdBH4Gve2CCDzt7zXnAPqmd5bIVByjg9rov2L9/RR/OoRTxEde6uMkruLbgJ+PmtDIRr3gkekAyizKvKFacXhhPeIJILesgGrhyHEMyZIlwh2jNjyGKaU5ETUaLavCHhSNZHGN7cr+sgCr8DoVIP7ajjTWUdFdoOn2ofhQrD9P1vnd2KYCGhFq6ZU1CDD6WNMhVna5UR6dAdeKUzp3OecncCD07t7YNSN7/cyqEOpkmEfkon80bF//9JRDmLDyEoheGXEU983CH+vlTUe8JNNLF4pHDrRXjuBe/WYogWUvCn7vVRQTC68AZwILygmhaZJoYgbs79XHiCjJkrlpukiUnhn9n+rDOt/qdi+1iUtaHvNWwbv7sSTioS9JrvmDo4H7D7IVvorp3UwjZuBCCfyCNkzqCphDNO3XRdW28bLRBB5XfvRjby0pTmmh+Z8ncOhcHa5h0OdabB2gwsZ8zzCEauBpf4tyg6iN6Uphwq58PVZTfSoNYZ+UZPA1jpd7fsKYoeoa0awW0yARJJZLCf180J37SvKG/XgWb6zIQArkkQdSyqgy9e+N42FFUzEvEEvscAzG/BzY/Av0/JpHjcjFMC+iaOcdvhWQwW/GBDI9E3KTeV+jY+cc5BPPkSjEQcwZw4GiTgAtUfot79o0BBqoTH2P7Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(38100700002)(122000001)(31696002)(38070700005)(86362001)(8936002)(4326008)(478600001)(91956017)(41300700001)(66556008)(8676002)(66446008)(64756008)(66476007)(66946007)(76116006)(110136005)(71200400001)(316002)(6486002)(54906003)(5660300002)(2906002)(186003)(2616005)(83380400001)(6506007)(53546011)(36756003)(6512007)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NmExeHhmT2NTU3kycGFWeTBwUXNwTlh0YlVkeUVPcDBIdnNTdWdyK1RXQUVa?=
 =?utf-8?B?MTNpZVYwdEg4N1NJc1pwaEZzVDlnd2J6U1JhTkFDRjAwU2J1cUhmalNRaDVY?=
 =?utf-8?B?bnBUZkZBZkZlYmI2Y1ByaEJBamc5bWpyaVErTWZYRW1UQ3dnZWdGVm1OWXU1?=
 =?utf-8?B?SFdNaWFISkR2S3ZXdG1xekFGbzdVMlVJS0toNWZ0dk4waXJaeVZiczEraHRD?=
 =?utf-8?B?QjZGWGp2djVTL3RMMU0zRXVpM1lyYkJuMjlIb1ZSUHJpbU1tek1WUUJKckZm?=
 =?utf-8?B?eFZVNGxyUHZyQ1RNNVRjM2gxS3hDa2UvcjFkNjBhWCtrcktsQWR3OXVPTE9V?=
 =?utf-8?B?ZzVDNStsQmNKRHIwOHd0SDl2OEwxSW5ia2pHOFhGOGl0SEFGQ3d0OUovbUYr?=
 =?utf-8?B?K3VRTWdtM0M5ekpmanJ3TWR2ZW1JY1NieEpOK283cHpUQUpGSTBpanRmcEZS?=
 =?utf-8?B?QjRBT0xRSXE5NjdUKzlVaWVkWkNJeDVyTWpEZHJyeWtYdGtVVGhqcjY3UFdL?=
 =?utf-8?B?dUwxM2p3a21MOEV6TytXTGF6dVdCc2hUN0tuQVQ0YUpQSnFGOXRvYW5DdWhj?=
 =?utf-8?B?N2RTSWdCVXE5ZXdnY3crdWhMNzlBN21ySkR0a2QvbHRUbFVHY25lL3NnT3gz?=
 =?utf-8?B?TVBqM3diVWtPVjQ5VVFXb2k4ZmpVQjZsUHhQbjNYZ3ZKK2NLNTg3SHVYRE01?=
 =?utf-8?B?VThHTlgwYjlwdTBIaGJCeUJmWXcvSzZWbi9Ia2xuVlpBbWhUU3VaOXVtMDdW?=
 =?utf-8?B?eU40MXFUZVMxNTdZeG41TlBQMnl0M3pLaXFhN254L1hHWWtFcWpUQnBMVktJ?=
 =?utf-8?B?TDc2VnEvdFVzQ09jYzdjbCtlNjZkeWc2ellyOCtxNTVwTXpKNVdiempjczZw?=
 =?utf-8?B?eHVudHZ3eFVnNHI5NUNQR1R4VFNmVnVKckRqcWJaaFhoNDJDVDNab21aVGVl?=
 =?utf-8?B?ekZ1aS9qdlYxbGtnL2VTakI2NEpreG0rQ2wxREVaakhzdDRhK2RDMkN4cUxQ?=
 =?utf-8?B?Vko0Ty9SRTJPNGJybXJJSDJCZ1gyYVNoUkRmNkpqUzNHUU56djJVTHhzcXp0?=
 =?utf-8?B?Zk0wcjJUY1JMZURmUGtuZDZ6WUlaNVFmVWpNMnVUZ3pnKzl2MThsbC9tNlk3?=
 =?utf-8?B?T2xHTS9Ob0EwU01kTEYrVllNM3docmZKakx5NWxyQmVEVk0zZ0E5UklCUllQ?=
 =?utf-8?B?WVRNclkwb2FLTlV4UmFDSlpzMEsyYUZjZDNWL1lXL1pnUWNXTVVJaEVYbjFB?=
 =?utf-8?B?VENFM24yMEtVMXRCTzRVUkJaQnVsQkxSMktNbHBvRFBvWWVSTTlTQWRvT29r?=
 =?utf-8?B?ZGZBL05XcWpsM2o3TGM3NUZVcjFPOVZCWmh5YmMxRU1hZ3laSW95V21PSHRq?=
 =?utf-8?B?WllVNEZxK3V2TFB5eXh2clBqb2hWYXl5dHRIMURITmxSaU1SeDBkcWpmVFRD?=
 =?utf-8?B?Zy9xOTRnVzlYSXFlWHlSVDJGdjRsMVUvV2o2VnJLMExjaUVWQzFVQTJTbGJG?=
 =?utf-8?B?MXRQRmZTdFRUMEdhNllqUk5jbGVHVFZJZHR5Sk5SSndnRnZuWlNuWnM2WVBh?=
 =?utf-8?B?Z2NGM01Yc3cyNFVuM2ZOSW5kYW5QZFB6WWc5c2RvUlNYMlRBY3FlRjI0WjBO?=
 =?utf-8?B?M0twUTl0WFF3TkM4Rm5tb2VZdkNtWWx3RXk2eGVxdFBXQ2FSYnZqMGNpcUFN?=
 =?utf-8?B?eDdOakgvaXFWdlJ4RkRBbFFFeHdEcEFOOFMwSFZlTjZ6RTI1UlNaSkEyb0d4?=
 =?utf-8?B?ZFVtaTNKNmNkdFNncWJtV3lWYVRIdVF4UWNOT1JsU2tHU0U1UzdpQkM3SlpI?=
 =?utf-8?B?VjQxaVlqK1AwYWtaQTVuOFJyTTZvK0pDYktpeTFvT0lTeVQvK0ZSejVtYmRD?=
 =?utf-8?B?THBJNFFMOTJ3dHc1OWZIdmdTZGNSWDFQK2xKMXlSWmd5MGh5Y1JEWmpQZkgr?=
 =?utf-8?B?Z2dpZkF6Q3R6NlZxVzZvUElRSXZ3WVFGOCtxTk1zcSs5WGNOQm04VjhUOWhV?=
 =?utf-8?B?UFpJOWdMaHVYTVQxZUN5UzlkcW5QN25EMVlYWWhHUXcwZGREZjBISnJYTXBh?=
 =?utf-8?B?SGxuMDlGQW9jVkhmRE5kQm04bEpvMWZvejFuSnlNMzdDWERzWEM5czJKbzhF?=
 =?utf-8?B?ZEY0Q1hrNmtTWGJkVVRHaTYrdzVZeWNUNnpJM0JDRk41RndDbUZkK005bmpp?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57DDEF6222AEA140AB06E021378FFBE4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c147b88e-acaf-48e4-ec60-08da90e09c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 14:52:39.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+Hs0NLz5q2Y26Iy9EjAT4OiYOFdGMjBE4bk20WtRCpW/8LZqFaqOuT0W1MCVPiPrZPXvvl744cY3BkQu7pWXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_075244_361177_EED2D69D 
X-CRM114-Status: GOOD (  15.12  )
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

T24gOS83LzIyIDA1OjI3LCBNYXJ0aW4gQmVsYW5nZXIgd3JvdGU6DQo+IEZyb206IE1hcnRpbiBC
ZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiANCj4gVENQIHRyYW5zcG9ydCBy
ZWxpZXMgb24gdGhlIHJvdXRpbmcgdGFibGUgdG8gZGV0ZXJtaW5lIHdoaWNoIHNvdXJjZQ0KPiBh
ZGRyZXNzIGFuZCBpbnRlcmZhY2UgdG8gdXNlIHdoZW4gbWFraW5nIGEgY29ubmVjdGlvbi4gQ3Vy
cmVudGx5LCB0aGVyZQ0KPiBpcyBubyB3YXkgdG8gdGVsbCBmcm9tIHVzZXJzcGFjZSB3aGVyZSBh
IGNvbm5lY3Rpb24gd2FzIG1hZGUuIFRoaXMNCj4gcGF0Y2ggZXhwb3NlcyB0aGUgYWN0dWFsIHNv
dXJjZSBhZGRyZXNzIHVzaW5nIGEgbmV3IGZpZWxkIG5hbWVkDQo+ICJzcmNfYWRkcj0iIGluIHRo
ZSAiYWRkcmVzcyIgYXR0cmlidXRlLg0KPiANCj4gVGhpcyBpcyBuZWVkZWQgdG8gZGlhZ25vc2Ug
YW5kIGlkZW50aWZ5IGNvbm5lY3Rpdml0eSBpc3N1ZXMuIFdpdGggdGhlDQo+IHNvdXJjZSBhZGRy
ZXNzIHdlIGNhbiBpbmZlciB0aGUgaW50ZXJmYWNlIGFzc29jaWF0ZWQgd2l0aCBlYWNoDQo+IGNv
bm5lY3Rpb24uDQo+IA0KPiBUaGlzIHdhcyB0ZXN0ZWQgd2l0aCBudm1lLWNsaSAyLjAgdG8gdmVy
aWZ5IGl0IGRvZXMgbm90IGhhdmUgYW55DQo+IGFkdmVyc2UgZWZmZWN0LiBUaGUgbmV3ICJzcmNf
YWRkcj0iIGZpZWxkIHdpbGwgc2ltcGx5IGJlIGRpc3BsYXllZCBpbg0KPiB0aGUgb3V0cHV0IG9m
IHRoZSAibGlzdC1zdWJzeXMiIG9yICJsaXN0IC12IiBjb21tYW5kcyBhcyBzaG93biBoZXJlLg0K
PiANCj4gJCBudm1lIGxpc3Qtc3Vic3lzDQo+IG52bWUtc3Vic3lzMCAtIE5RTj1ucW4uMjAxNC0w
OC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkNCj4gXA0KPiAgICstIG52bWUwIHRjcCB0cmFkZHI9
MTkyLjE2OC41Ni4xLHRyc3ZjaWQ9ODAwOSxzcmNfYWRkcj0xOTIuMTY4LjU2LjEwMSBsaXZlDQo+
IA0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

