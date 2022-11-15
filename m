Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22A5C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWOJSrwCM1W6cNkS6Tmfwe38OY8BiZFDLyXcj5i0Rek=; b=XYL6JySwSdTXoXqhpaB0anR32f
	71kiLuH80KOK6EMuj16GaZ5LxKTohbQfep2yUFcQtJ2zl9taWQHnkz1dTJrFcHViXVe1+W/dzzshg
	VugiYMTajH62TKPtCACipWfO66iscT1BNyjxRPuUhbhs6SHXFVKfVThqKqq56cVTOQrE5cufeSSfi
	TRSa/Z0H8MDzhYd3iZK86Zr8Kgx+UGG2ysY4Lb5KkvnshIVPxKqF1AteiEE7xwKF4iTyEydxlM+yw
	3zSb2roaEEVJXD6mZRKw2qqohhW1m2vUdbRoVS/24kRftpNcpZmf/u9Ks7EDzjhPJ5cjk2yB9lcpJ
	B/ACeqWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounMC-007Ymd-PB; Tue, 15 Nov 2022 04:15:32 +0000
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounM9-007Yk2-9Y
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:15:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JExmUTM4AXwqKHAG7H0rKApovACIAnaikbF6617JLu6iT/v/Q0nnneCBCHGZEuonPFEL6nWopxe6Ox5gw9zO3n94SIV70C3WgLh3XC7ul5rD65plZ9R/T8thSgDJ96KMuDgV1kHL8CBR6BNP1T5uQqtfdJLCSbGprvAjQx1A4YF9JxQO2w6rcjXuZGlJKw0/z/l+4OSEWzn2oXYYadjvSnnPbgGVkKi/1LBwmzMK2+NgLYLn5C6mIbcE+2gph+4GUWhvnvIA+/QS779xIz/q9NRdZwhwL2KoMUNyE2fvNMKB2ANtvVYOGYy+t1cLvBxETU1g9pDBlwnmadH/FgqN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWOJSrwCM1W6cNkS6Tmfwe38OY8BiZFDLyXcj5i0Rek=;
 b=O6f1LugNfEjz+r8hdYExFq///RZUxZYcniy/gzHaoXZSmZEGXliFNE1vIQdVQ73+ObYO3nuWn0E29HLiqzzXa6xPncW6oY3BoG98Adx0j2AYqhGcU3aiqCInurjvEq+8D5shjztTO0g5Fg53tSL8TU1FSp9R4Z38E8heRZUiAiOIRVSylXxnfW7asGpRn3egdc6QO18/0g8CtToQC2F5weY0U81dwmCeLmGYW4OCdGUSF4vYVqpUYzhy0ikgefbUI7OMvPIT4yd2N/QLzFWgw/MfX5FyyaYoLI+Zmj/LOGgWdDkxD8+Ry/0Nfz+nHhMZntw3cThroKKIAnxfrRaeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWOJSrwCM1W6cNkS6Tmfwe38OY8BiZFDLyXcj5i0Rek=;
 b=DFJsokhSnbrYNiNR2rEsIwVbjNSRDxTcwspAIm/iwnrdn1xGhvtZualSyGPEyG98t6ZACxFeW2hPKf0qgBQnuZHYoHeRaiuqKXF+LsbHce0feyUVD2PDW/HpClfYUGbrnmFoPb3CJg9NC+uG667a081KdfOA6ROG/1VnUJ3gcRS6F3zhQJolYo3Iv8M+GuJh1CA85zLwhh1lTrfZPCrFi2cL8dy482A6V/h3rKVqTHqadHN8yamQbLVGW9i48v2mKwE/MJNipRgShg5+lAWwmbDiZZccknU+Wmd7sssqLUNHOO6v695LLbOA+6vuxRk8P1vi9tNxQq0LLA/P4hOwOQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:15:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:15:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 17/20] nvme-auth: remove redundant auth_work flush
Thread-Topic: [PATCH v2 17/20] nvme-auth: remove redundant auth_work flush
Thread-Index: AQHY91OZzeTlAszIA0+qEx3Tp7k0dK4/YxmA
Date: Tue, 15 Nov 2022 04:15:21 +0000
Message-ID: <7075552b-1a76-8c81-e4f2-0f50ecd78c99@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-18-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-18-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5068:EE_
x-ms-office365-filtering-correlation-id: 6051ad23-9892-4467-3dcc-08dac6c00323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  kiaEusHY2+zhI5+bkxGLyBShQoBA0BksnLZ/sR3we9NZEtZ6Glpxa/ZYSdetdly9amLG24otxCl8lCTvsrB4+vCxYycSBCIFQQgU8dSu9Ql0G0aN61/hCsggH7csqbx2clyC2YnLyol+uK6142x4bmAFckcOsXxkwyuZ8SHwCTqwCR+KqYYeGAz0uoama88n35LpuwNkEoBOlLVBmkBP5AroUqw15nXRymMLD8piwaWIhkEqYnMxPwNx394buxkmXsTqBb9FiHQIru+985QHsWIuTNu2AnSuKDMFclb4PG6UBFPZKa3DRxdw/ENiS2wxfL1N1y6HUaq9a6Og6xX+T/cbEunhm/73m2F7/Om4yA2YfaKsmfAaWxZJgBVmslI607WzYjr0TiIPaUAK/h5MVnCrq39TFD+meVYy7aXXTWCWInOXcf8qOQddFO6M1+/GjETIFgRJVLCX3pv7rZyB3js5mW5ibL8dvpjLKEjx9iklJ4ohxzqXmDA9RIbrA+4UCq7GTX20crD4CJP5ERl6xddnPnLdMoQbnNaFfQyxsN/U6rKhDWrIlmSyi06/l96RAw9hGAIF/7xoJyEYYK2aacH0jKh25hme1vvmb4gkJWflMxFD4asAT6exU7t0Fm7qJKuBwKYB0+zXGRPPo+8o5Bewc8ZHjiEH0RnVcvTj/z6f3AwOYplXFs/VlURS1eif0UWRDiR6dvwG8R+J6QrYIcVr1oXtJv/11uf5rAVRdnHt+9UmUOBmqcWRO6seESu45VbtMJ7LDGeqGrpMH5p1LEtuo3nLw++ktmt9qjd8c+bY9GJdXiADTSaJhddRkzoP2V1HaxCd4TwfPiY4O2rSzA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(8936002)(31686004)(41300700001)(4744005)(83380400001)(186003)(2616005)(5660300002)(76116006)(71200400001)(6512007)(66946007)(66476007)(53546011)(4326008)(6506007)(66556008)(122000001)(64756008)(66446008)(36756003)(8676002)(6486002)(38070700005)(91956017)(478600001)(54906003)(31696002)(316002)(38100700002)(110136005)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SEFXdVBqOG8zSjFwZVZHU1p6Y2IxbGpRWFZQTENBRG4rZndibFNvVlZKRFNW?=
 =?utf-8?B?Q2cwVnEyMmlhU2cwd0U3UUZDYVl3cEVtQ2pORjYvalhya3FXcWw3TFJLRC9j?=
 =?utf-8?B?ZENPanpueWRET0FqY2dqcjdKNUtGeHgwM3BEQkNLd2s1UXAwMGdCMFc4VzdJ?=
 =?utf-8?B?dEp5di9CdENFSDRSblFFS0N3ZlZoNlpjT1NKUlpRSlRmaHR5eUhQZUhwV0dH?=
 =?utf-8?B?MXRzcTZSNUg2TlJub29STDAraG1PMkRqS1FzQUY3d0oxOWpIYUEwM2QwUkFy?=
 =?utf-8?B?QWk5ZXVKdzg5bVYwdlhaVVM1ZEdXVTZNbkRtV29hUDhkM1FQV1V2dWRDNXFv?=
 =?utf-8?B?ZDh6MVZwVFRWS1cwQlNybW5MM1ZQLzIvT09CZllDRk1Vem5abE5xcVVxd3Yw?=
 =?utf-8?B?dE8yVnJEbXFuME9OUjZSMHhEZFBVeW1zM0dOWVV2RVhpeEZLYlhDSXNTRVJa?=
 =?utf-8?B?c0tjV2RsVzFBUHlnMGtPUk1lVTYvcWxML3pkRTdIK3JOU2tKRUtjTlZPalA2?=
 =?utf-8?B?TW9sRjhZOXhaODlYRE42cmluSlcvOEFWTHcwS1gxZ3IxbnpyMmhHQ09PdEVS?=
 =?utf-8?B?Y2p5Y2hxd25BWFJQU1lYRnhDbVZTeUdVZ2lQV3pybEdBZEkxNjdKNmJBdzFM?=
 =?utf-8?B?OTBzQUN2dkxmV2JORHRoYW9hSVFwVXJTRXdFbHREM2VQQVQwb21renVvaXg0?=
 =?utf-8?B?emNwbXY2MTlab0szMkRhOFBISkFwQkpzekR3WnRGMXdEQTNhSGRzaWVtRzl1?=
 =?utf-8?B?dkFxRzVuZnBwWUNuWE0wWGNqMXNRSU1ySlJPdEVsUGwwSzhpKzMvamtna3VG?=
 =?utf-8?B?Z05IczJZLzZjWU8yOEtRTlBndzVJWDcyZW5pZ3pzajZ0UzhYOWRnSVFmaWtL?=
 =?utf-8?B?R2JQYTNnM3V1V0FRbTRaMHRpd0x5VjVxRkJqSi9uZEFITi9qT3JPZlI5L25k?=
 =?utf-8?B?ZWs1SWVsSE03SExRYW9jWmlLbndHUjJGRW1mTTd0MlVLcWNObEtCdWJvU3F5?=
 =?utf-8?B?RndnbkZrdFY3RWxrZjFnSkVybGdUKzlLU0xYdlZWN0ZxV0gwVTZzZEZtTS9E?=
 =?utf-8?B?OW4veTRmeWk3M2MzMUZvRU12UlFCMnpVOWVUdmkvK25UNXU2aGhWTWVPS1lV?=
 =?utf-8?B?NG50dm96NEdtSDJ2cTlseVBrTzFCZ2FhcXgzRFdzN3dJcFhSdExVS01ZRmln?=
 =?utf-8?B?NmNTY0FtZS90WlFnWnZJNHFnenVZYXJqMkxmOUM4TndzYjZyN281L1NSMFVn?=
 =?utf-8?B?T0c0QUdYcFdWcnNoZW5JWnYxTVh1ajBZN3d6WThJdUZHSlJhQkZ2bFByZjlH?=
 =?utf-8?B?eEUxWmd2SW1jZGdlMUpKUFJFVGI1dkFGVFRoSmRHeTVzL2dEZTFoUkU3WDN5?=
 =?utf-8?B?d0pGSjgyRWcxODEzZXhaUUcyZTVnSkZEY0M2ZlZpb2tod2FoNnFlZ2RHYW1S?=
 =?utf-8?B?ZjNjb1d2K1M5YW1VUnZLNmFacXpJd1FSMkQ4Nkk0UjBUVkR0Rzh5ckc3anFW?=
 =?utf-8?B?eUhzbWxKc2FDVDVYUjVEaElyVUpwZmJaOVd1OUx4RWFlTkFnWkFJenM3dE9m?=
 =?utf-8?B?NUNZRFBLZzZ4Ri9EZmJDbytJTXY4WUs5eTFxa05RNlpzZ3JZcmNETjFORG12?=
 =?utf-8?B?RXZvS1habUM0U3pDT0lUVjZPMk03T3VLM0VYZHdxT2M0UG5ZOFhHMVFsQkhB?=
 =?utf-8?B?T25VMmplaXY5RVVXcXVZY213NmRta2pXRGFEeEVBSkMxRWg1V0dFUngrNHRs?=
 =?utf-8?B?TUx2VFN4UWZ6SEhUYi9EdGRiN1JwNzJuMUZxRWVCbExLK1lUK1g3UkdRTVFw?=
 =?utf-8?B?cmNLSjJhVWJsYm8xOThYNnJ1SGNlaUdoZWtlTm9HSFhzbGloY0IxUjBOQVdy?=
 =?utf-8?B?emcvL0lWTHN4RXhHREc2NEo0NXlzM3V0L2RONkJYZ2lsSytiS3NBOHE4MHN4?=
 =?utf-8?B?MTh6eDNVNFFQQmk3b2JoK3hzMVdxNlRoNkJpUUtWaE16cVZzTmticEFabmxm?=
 =?utf-8?B?empBSDVMT2NtY3FGZWdKSHFCMHdjTGpMa1hxdXhhYW9iSmxWdDhVNmQ1YjI0?=
 =?utf-8?B?UmVURGZEak9qMXpwUy9LRE1xMm0yWkFjb1VqaU5qTlZacVZpMDVVYkdTTXVZ?=
 =?utf-8?B?STdWY0tkdWNIajY0U1ZPdFNrWlJkSy90U0d1M1JYYVVHVi9xaGppZStwYjJl?=
 =?utf-8?Q?02uRd5WqlQ1+HSZkqqslOH/49rsXjbDn0NEUTThrmOp5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B12B4A272046534090EDEAE2248F28B8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6051ad23-9892-4467-3dcc-08dac6c00323
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:15:21.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NM6DbnmAA7i0pklJvQ//HVLIRn6tWUH8dl4OPq3GVb4u5yf7TTr3cV/NLmW40m9hLTBOGpQ1QEaxPc+Cl1O7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_201529_356955_C1140BE8 
X-CRM114-Status: GOOD (  11.10  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IG9ubHkgY3RybCBkZWxl
dGlvbiBjYWxscyBudm1lX2F1dGhfZnJlZSwgd2hpY2ggd2FzIHN0b3BwZWQgcHJpb3IgaW4gdGhl
DQo+IHRlYXJkb3duIHN0YWdlLCBzbyB0aGVyZSBpcyBubyBwb3NzaWJpbGl0eSB0aGF0IGl0IHNo
b3VsZCBldmVyIHJ1biB3aGVuDQo+IG52bWVfYXV0aF9mcmVlIGlzIGNhbGxlZC4gQXMgYSByZXN1
bHQsIHdlIGNhbiByZW1vdmUgYSBsb2NhbCBjaGFwIHBvaW50ZXINCj4gdmFyaWFibGUuDQo+IA0K
PiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K

