Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E39EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vj58BzCK0Di22fHufQj/3dgMtQJz5KJOBUTezz4yMoA=; b=lh4ht3vCE5kIwbqOLaIElCob59
	zn9zJTrWjafCY26iKYSCthMxWNiKWljTvHhKG54x37/ZdUr9w7DNKWrn6LutJls/PCKA04+oSdDmP
	wuvWWdBDb8ZremiJfsi7kI4yegCBcawJ5YuMpEo0NWidn7LPhQT0ImEPo5SRxoLeuk7YN2Ro0h8Am
	CwmoEm3NLI7rNIJn0ijo6jz33A7NnytU+Kj/TxWvrC7Y4eLcRlknE4n1PQWElqqovsrgbDc9xy0gA
	4rIA/HmCWIS1HrqPoYNitwA1pkLOvPTEwfPQw9tkdP2icgseIdpBIzntTynzBhYe+GwRSqaQnQehe
	kFkXTMEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQkbZ-000dvU-1H;
	Tue, 01 Aug 2023 08:19:45 +0000
Received: from mail-bn8nam12on2070f.outbound.protection.outlook.com ([2a01:111:f400:fe5b::70f] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQkbW-000dud-0m
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 08:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCpZieT49ZMrITl4g9nsGonNFJG8hyTX2Q1fGKlLo76bi6jxevTboOZC4msIzsoWICJ2Er0OGr73952FREcF3IfS99yAFLVe+vFZj2Ujn/9NuZCtdg9M8Qc3xJJGmImKXrhTmyuRzn8QXDAdJDaX9yh8rdGDLxL110j6if7QOwxyGkHS4fz55o9bBpg5KfFf/NTqtlTPfe03FyPTNDAKl2oERhzUHz3rQOlCbKkyPUp1Hlx/sV1KYNQEb27LqaroRUzUYejpBjVMAOllGbD/l3QAwuH68SNMJTmjz1xhVqWM/f7SJaYrGZYIferLotcJgtqf/w1b7hSFX3lGm0xOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj58BzCK0Di22fHufQj/3dgMtQJz5KJOBUTezz4yMoA=;
 b=kpFjjg1M+kkxKyxmfNIeIoRu9x7q+HIYX8UodIocNWV5sIiT4sgbErKD1Kw7VGd+OI1jvtemTaN0drzEZ4HC48LP4R3Kqxilb6ixyncDaXdGI670CIDQ1cH91I/M7Z69F/LAD0XxQ9uDFIxPuQjiDgJbXEQkoX3G4VQy2vovsENq3y3VrS9vPYi/2A4WA1H9CuMF5t3UEA2kDj3mrR7UdYai5Ia0YqcZ9Pss9/VxDdtd52xTKfOKb6vDgkB/4for7sRowQiAbZOnwAR7gYi1EBarz4GK0VTl6EhKRTAkYEQgzX85swfARs5bUICfZBETh2na5r2o4xDjKx3UOd+K+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj58BzCK0Di22fHufQj/3dgMtQJz5KJOBUTezz4yMoA=;
 b=WgWFESCc0o6D/g1IPF5Ld+f0QuUefJdt2uJ812KQbYR/SErpVruaPrmdk8aJrLctiUY1H7lf814sfLSGNTXeiFBUuZ28biitr4ZMYInRYWCv0ka+GZgnSgfGNMdg1Vd3xk5VYj4bmfTGlSxMYCt09C3aTSewDYQYeICAYJZS7v4=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 08:19:37 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8274:86cf:1c54:8af3]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8274:86cf:1c54:8af3%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 08:19:36 +0000
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rakshana S <rakshanas@chelsio.com>
Subject: RE: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Thread-Topic: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Thread-Index: AQHZwJhCaUPaX1SiKkqSz+IgYqGKIa/T6CKAgABPpUCAABQegIAAyCKAgAAL4JA=
Date: Tue, 1 Aug 2023 08:19:35 +0000
Message-ID: <BN9PR12MB532497C315D6A33070709E72BC0AA@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20230727150550.5851-1-varun@chelsio.com>
 <d0badb81-782c-52c8-2b05-06ca6c696157@grimberg.me>
 <BN9PR12MB532469A81B5D3F6C297F91C9BC05A@BN9PR12MB5324.namprd12.prod.outlook.com>
 <20230731193813.GA13587@lst.de>
 <a9c7ae46-6243-89bc-752a-b8d043e7cbae@grimberg.me>
In-Reply-To: <a9c7ae46-6243-89bc-752a-b8d043e7cbae@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|IA0PR12MB7625:EE_
x-ms-office365-filtering-correlation-id: 6b8bff53-4fe1-48e4-2221-08db92680ab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SD2I1ECE2NGiy/ZpCEaRTVTHE0cDraS/NR3vLG+4jXwcx4OfTlRpqmRleWg7qT1L6d7WTl3S6xDwOrSJiRbLhVOGsyKzVeu0/jwRHBQbBXxqAJNQBhYabo0YLE+v+mGzmHz+nqlMcJ9sOG50gyU2oZz8VwWLXk8qLJBcqgBE/UOTaMtk0CPmTOwgOeBhirqFRh3qFGj0o4P3wydw9XIKWUOyT9caHCjWiceb3DGaVyyr3FC9gp++Vv7IF0gX5tJTPk99Z4h7QsqP07O3p08nWf54F7ZpoWWYTwFzMAQbSbIo7EZgpPk4DLRRtwZhKg1wlLK2Bfu05ibXDmT4CbnfZOSOtM5F80X7wPthgFdLLsMg3Til2fLMQ7rTqwA83MAMVi4y/9U8AaAiJj5ulBCN09WNAyRnGkaZz8A47xsHjAmKhENFSrC6zQKKLI2+3ks+usHmL86Mtz9vTQu9tves29X7OGHYhX5wzHE1fN3NVI+5Zd4gf7IEUQNz25WzYKlAnjMohl0KGINcJlUdzMisl2Imbdrlknh66noeVJSA4jH7HWJWZJeqregIrHSrODxk03Re4GNMU09iJ4cKIYHXmaIfcBXwsft51N97/XKziS07W07gutaNtkDnsmyHvcYK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39840400004)(376002)(346002)(366004)(396003)(451199021)(478600001)(38100700002)(122000001)(55016003)(86362001)(33656002)(38070700005)(9686003)(71200400001)(7696005)(186003)(107886003)(26005)(8676002)(8936002)(6506007)(5660300002)(52536014)(76116006)(4326008)(2906002)(66446008)(66556008)(66946007)(64756008)(66476007)(41300700001)(54906003)(110136005)(316002)(4744005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkxLdjY4SExDbzNhOHNMcXZKNzMycVdTS2J6UjlVMm4rS1pTQUlZTFJaNXgx?=
 =?utf-8?B?cm1uWDNNaGpVczkyeCtYN1NBRkV1ZGpjaGJhUTJtTmgwMjZYNys2c09ZaW44?=
 =?utf-8?B?aDV1S2NjVGluaTVLTCtTaWNrVGdFaDMrQm15NjArZi9iMGhGaUxLVVo1dWg4?=
 =?utf-8?B?aTNwMUtzZm1vdVFaYmltczlpTTdtcmJYbkZXYkxBZmFKcUY3L2NYbDBnWEF5?=
 =?utf-8?B?Z2dsSXNKSXFDZXpXcndzM3U2T1NBS2tIeWZFTkxxUWFHb1doNHQzeE1QZmsv?=
 =?utf-8?B?Y2hRL1BzYzhJekQvNU5JNk1nQlZrZXRnNEY1ZkFFbFJMUmszVTVJVGkzTlps?=
 =?utf-8?B?TlB5YVBHMFdHeHN4RDdiMGh0UVZNckRmTjJ3bk5mUjF2SmIyand2MEI5dUkx?=
 =?utf-8?B?eVoxYVZIVGxlOFgrNkVqVmVaN0kzQk9lelBVVTU3UER0eHBlT2EwbUVRb3hD?=
 =?utf-8?B?dUljbGxYdzFRWFJEVjVXdGhJb0lneTgrWWllWEVlZlBDcFNtaHc2RVVLOWtE?=
 =?utf-8?B?akQya3ZWZVZ1Uk5VWkZlWEdZeURHczZQRVN0LzJKbzRXSElEVnlyZ2VwK0hR?=
 =?utf-8?B?SEVOWDdpMG9xZ1M0Ym5jMTBWZnZ2MGVNTWl0bFpKTFNFM09iRk8rQjRHRmJF?=
 =?utf-8?B?bnlUVXpab1FtQ2FtS2VpT3g3WE5mZll5emJlRENvS1Q1UUNsZncxWGtEYVg5?=
 =?utf-8?B?UFI2WTNYQ25DYzFPckxhbUhwak12dWxLKzBZZHAvbnl3d3BvaW9Pc2lCbUE3?=
 =?utf-8?B?dnZIbmFxbjU5UGFPUkl6K3lLTXFsMlR0SWpLWi9zTnRhQWZwQXArQWlXVTlx?=
 =?utf-8?B?amJHTFR2OFRoUmlQS0pDMFk3VFdOVGozR3NXd3JGQ2Joak8wc1cySG9tS3NI?=
 =?utf-8?B?YjlveFZYakE5RUNFMkdPMWNDczJCOEdBWFR6TmhEUXI2UWI0UzJJU2VRTnI1?=
 =?utf-8?B?UmIrVDM2alVpRkd0N2gvWXI0L0RaV24rVC96cnVDNFhJQjdDeWEyQURXN2tQ?=
 =?utf-8?B?cWRJek9KS3N5T2ZIR2xzemQwWkRjMHArZEFCZ2lueHBrcHNRUVM2YmNad2h2?=
 =?utf-8?B?QXFrU2krdlhYZ1ZNVEQwRzE2MlZPdVBKUGZQZWdUbkFLRy9HL2NEZDV2TXhF?=
 =?utf-8?B?ajV5V1lpb2svRDRua1hnaUxLaHBMdVRHRDA3NllUZm9YaHFjRURaM3pTdXk2?=
 =?utf-8?B?N1ljVE94UVlOQmdOOFBuOWNVOURkVGpMSlp3dFFSdjdDM1pTZWhmKzYzWHhF?=
 =?utf-8?B?S05jS0NINnVDMW16SFU5V3VJbXhWeFZoQ3dKcUVPUkxWazRwTXZPdlBwV1lD?=
 =?utf-8?B?T0NRUi9JTzkvdWxxQnZnKytiYkxhMkpDM2xuNjlMdENiVTk4QmQ2WlpxK09o?=
 =?utf-8?B?blFhT2trd1FWc2VkOHJtRFZUNXFISnVpRnUrcWduSEdkSHBFemgvUTJJeEc4?=
 =?utf-8?B?N2xNRjQveHRrWGlKY3oxYXgzY0o4b3dhMVZWMXpLcDhSWHlBOVRTTzlabjNC?=
 =?utf-8?B?c205SnNGUnB0ZkJPaUttM3VJNHJPclp3Q1I1elgxbkttWG0wYlZmYU5yb0xt?=
 =?utf-8?B?T3Z0TTR6emgzbTFTU0JnVCtXK09Tb0dqeDU3ZGlXQXRtRXl4THlpaHpMdlRp?=
 =?utf-8?B?aVRqUlVpL3l5MHlmZ1l5em5OdTZiZTVycWJUWkNxSzlSVmRvU0hqRUZhMVIx?=
 =?utf-8?B?czFSRU9Bd21yVTljZ0V1bnoxa3o2OTRaQzAyNlhWK3c4L1BMNVdibUt1YmI5?=
 =?utf-8?B?Q2hPZ0NFT0FHN0h4V3UxWnRjbmJtOGx4VGJ5c0cwbFFlT0ZqTmplSnZ2Y1FN?=
 =?utf-8?B?U2FOcVREMXM2NW9kTGdSa3F1Y2pHUFU5TEp2N3lBWnptT2tLd0h1TEFCa1A4?=
 =?utf-8?B?a1ZrZWY3aVZKTDFNZlluT2FjeGpjMC9SUGJPQ3FoVEMyb3dVQWwrQWdzVEM0?=
 =?utf-8?B?R09FdWVhUnJOYVdQSUZORXpZclZ5L0ZXWmRVRVYvZEtJVXRPZDhKd2xrMENp?=
 =?utf-8?B?Vk9YSFV1Z2xzQVBjZGc3ZVZ6a2IzOS9OcDJxcmFRZlNMVE1MTHNHMVo4ZUY1?=
 =?utf-8?B?dzR1SzlXRWhYRm5hNWhqR2NlQXNEYllFRXJYc0QrUnU3cFJEaDBxcTZyK1BT?=
 =?utf-8?Q?/6/q8xj4K0oFRXUd1TcTD5trf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8bff53-4fe1-48e4-2221-08db92680ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 08:19:35.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKRQHUpUkL3rcOba34Yk+0vbO41FpO7TzOss4gxs7IW3updeyJ5Z0ysDQB1axu0Kb/T5tohBVFONMJFcxv9GXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_011942_458040_AE54DD94 
X-CRM114-Status: UNSURE (   7.49  )
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

DQo+Pj4gY2hlY2twYXRjaC5wbCB3YXMgcmVwb3J0aW5nIGZvbGxvd2luZyBDSEVDSyB3YXJuaW5n
IHNvIEkgZml4ZWQgdGhlIGFsaWdubWVudC4NCj4+IA0KPj4gY2hlY2twYXRjaC5wbCBpcyB1bmZv
cnR1bmF0ZWx5IG5vdCBtdWNoIG1vcmUgdXNlZnVsIHRoYW4gTWFya3VzIEVsZnJpbmcNCj4+IHRo
ZXNlIGRheXMuICBPcGVuaW5nIGJyYWNlIGFsaWdubWVudCBpcyBhIGNvbW1vbiBzdHlsZSBhbmQg
bWFrZXMgc2Vuc2UNCj4+IGluIHNvbWUgcGxhY2VzLCBidXQgdGFiLWJhc2VkIGFsaWdubWVudCBv
ZnRlbiBpcyBtdWNoIGVhc2llciB0byBtYWludGFpbi4NCj4NCj5ZZWEsIHRoaXMgd2FybmluZyBp
biBwYXJ0aWN1bGFyIGlzIG5vdCBzb21ldGhpbmcgdGhhdCB3ZSBhcmUNCj5tYWludGFpbmluZy4g
Q2FyZSB0byByZXNwaW4gdGhlIHBhdGNoPw0KDQpPaywgSSB3aWxsIHNlbmQgdjIuDQoNCg==

