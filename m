Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5B2C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 04:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nG6WTZ/bC3wsV5C7DqFi4S8vp3UnIJQcsFWMYI/hjXQ=; b=nxCGJKExLianW3MSV9z5Nd8k5u
	qv6KDWiQmzS0iNiikx+aknBlaGp8EM8cwb8Ln/0g6c0dFpRctb6mdhN6RoRcvkjey5LWdCmxugaJU
	IaBHBP9sxw63kOyf69RsbXTDCDr5jGwTaacrHnwYRa9qhSAehdKGUrp+Dncni91dBP+SNBQS6XhDU
	hiS4R4/uBsWYhyG6/PGgPJks27sBfJTMt18tyMLqhswhzob0nyI6aNP2cGIdUx9SGAW7HwTtA/mMo
	864AGRNTkRZVUvu0tTXYflQZFATOKXYRQ0pCAIv3HmmgmEddvEFrwzOyPXkPHmGIgRpMVxnLdqxh/
	3rnstoaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0ZxE-002v65-3A;
	Wed, 08 Nov 2023 04:14:12 +0000
Received: from mail-bn8nam12on20609.outbound.protection.outlook.com ([2a01:111:f400:fe5b::609] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0ZxC-002v5W-1v
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 04:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWZMt7h4idrIFt8/H7CsGSHWK8scxAKMZI8GCpjjrt+IaJarnFZjxM4IH8nSgaMypjMnH91ZFrSqJqkztPvgHstV0Vq9H6+t6k3+EFQSIxaNqFKz5lvvsSc0XBBGNWZwLXekrMNEyzFJdLxRAzIkw0WA7mvoEJzzhss4kvay9wzP9DG9c0kAb7j2pcQs6PLS5rYTx6uxueOt1b9k7cTo2nErb3rj+tfY2U7pSt8XNxKbJX83XiqUhe8acogJ+UQTAwAE9fNxGWiba3EWfKCf6tkeKrHKxp/iUSny3rA4RfTqLAmxXee/h/Kbnrv3gczgtM1w7PkYYOJfYQoJgctJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG6WTZ/bC3wsV5C7DqFi4S8vp3UnIJQcsFWMYI/hjXQ=;
 b=fpt9GNVhmnv+S/cyEhlUR8vUxLF1mFpCLnh8s9+AqXEg5NqFxEqo3JAAAdri9akWxwdyr0/abRgvfbzaNTLtUzZblxqHwsMw4azVJXGDLikN94Y45wwsBEweLXnvCzJfWtHz4po8l5CbiFrigFz0CTW6c/vC19YPZ7s+WyNVQ1cJxSU3oG5vmDkUduc27yvXS4n5IUdygbuj3bA27LJWQdJpgJepcjt7lVEdDemZlqCCo5wlHmZ8pcf7G23mmNOKkadXO12RQLd/AJDSBjj5LvMQa8XkUkEAw+24J/4hhDJSD+UdNduUkG/yS3rY7RUDWKFVTJL07l8mjo5tlzjqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG6WTZ/bC3wsV5C7DqFi4S8vp3UnIJQcsFWMYI/hjXQ=;
 b=G4wIcyqDbp+7b54kkj1GhnQIlgyyI2f31EP5yoiIPG6elyLqvoJDwI86Dq+gir+cGnb66liTC/GUsYiSZNosL4zYa4EXJFG2uS39zO0ExoHD1hpxZUZqSZt7oLaKMpQfiKru1q5GQ8FAnjUd///dJAzoW8NrzUEtYRphSFCxwS97TFa0RE9bsAxe37ZTexDQuIE/8oUevaV8TXjbdM8fHChyLRBNbhC9GiOeJgDUYmG3J25oYR9ye22ozp8xH7tSvcxL4An8l5JYeIQG4IVBqtTdg1sO4Pxx2G+KTV+pBAAGgc7iIkGkpTbsXFkPMGd84dWQfCIs4rKylDfpLCy5PA==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 04:14:04 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 04:14:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ewan Milne <emilne@redhat.com>
CC: "tsong@purestorage.com" <tsong@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Topic: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Index: AQHaEcEA0yfaha1bv0C9HNeQHQvmELBvZCOAgAACzgCAAGmQgA==
Date: Wed, 8 Nov 2023 04:14:04 +0000
Message-ID: <01fec932-ffbd-4612-a960-407d7c526b79@nvidia.com>
References: <20231107212331.9413-1-emilne@redhat.com>
 <e7b8ee83-c63d-4b65-b446-2bdbac0084e4@nvidia.com>
 <CAGtn9rnEqs0OKeg52+UCwkvU2kiVkMKDXe-pxDUHn-77i5e9sQ@mail.gmail.com>
In-Reply-To: <CAGtn9rnEqs0OKeg52+UCwkvU2kiVkMKDXe-pxDUHn-77i5e9sQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|PH7PR12MB9176:EE_
x-ms-office365-filtering-correlation-id: a9a6bd76-9b23-4ef0-aaaf-08dbe01124f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HJ22ePjlK0nt12P4BY9ouaEJenyGaS0Pkd0DxqfE1l4cVvLkY80AmjAQCWgF8lze/cRKSGaAVOeGlSfCapJRGiFpNh86RoXGPsVGuogrheVPNF9+V4gWwTece5y3VvLLKFs5lkU0IRneDBlUvUTmVJtoAm+P3wfhGRd6QFVGil24SpRwGQ6QCTbnrgthRu84aC9rHPxNEw+hQ4eGY9xY4nDMj4LSTeWIb7QTefsS8utAbYF+jI70/Os2OEEyianaDLzmjGx4U2/4v132UX8ah3ThOmlHayB2aunx5Hk2kSmlLkng9WOHOj807L+j2UCcNIgHgCsGl9DNUa3ni+emDRgobjfVjGIadEBItuoq+Xr4xRkf0Wpa1C/LZidCVN6PjFCfw7FztylOpEYkVf7b0hwCpmtDrIEd0CQ/2lBa1fzHQgeHm2bIiVdttoVnGJjC/SHWD2NCAWceokJ72K0KqKmDsMt9cBZST5CL3sdPEY/+qQfA2T327rez45fZjfofdmdkmqeHn1hINIq52UV80jcLu0t/nSeZYJJ+PPsRp/G+JE9BYLkkBhNprSxmh2fNcE3e+cCIvOnF+lgMXmpqrrjVgg/zv8WVvCgYkKRitgsQfM3iujbMRZzQ5SQJnBIuxxYVMwv/791QGiaA60YLdozBmNXR4U6gZZvWpv5WlFC3fq7Qvx+UBlgOXuGCCBi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(316002)(66556008)(64756008)(66446008)(66946007)(54906003)(6916009)(66476007)(91956017)(6506007)(6512007)(53546011)(2616005)(71200400001)(38070700009)(122000001)(31696002)(38100700002)(36756003)(83380400001)(86362001)(8936002)(6486002)(478600001)(5660300002)(41300700001)(8676002)(4326008)(2906002)(31686004)(4744005)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0dieGlTdlFwTjYrVUhQOC8vL2pnbGZRSm41OE1IS2xLZFVSZDVSTnYralJn?=
 =?utf-8?B?SjkrQnhKMUlob2FBeDkxWWlPdVpTZlE2dlFuUzN2Mlc5QjNUWG40eXlMUG5H?=
 =?utf-8?B?bzVDSncxa1lGMEovWHJrMVNGd28ySENZT24wTXNGNnZxQUNVa3cyUzlQbDVV?=
 =?utf-8?B?a0F3bm5xaWZxbUNFY0N3WkpheEd0VkJNcDZnbGE3dEc0WU5qWGxWRjBmeGdo?=
 =?utf-8?B?ZUd6SXVZeFJoS05odFlaZEhmekF1S0NGd1lrY0lpeHJGMlQ4cVB6YlhRbTFz?=
 =?utf-8?B?RURqTGtTM283bnk5S2I1ejlzQmZLK3AxVzBxVzNTRjZzSk5QS295WERPUUZC?=
 =?utf-8?B?Vm1xU1dTbnRUVWc2eGlhWFQ0N0tFSmsyTTJ1TXgvTzFvRngrb0pEMmdFQk9o?=
 =?utf-8?B?aVd3M2dXZG5rcHdZa3BYMGdTUk1mWFhrRm9UTWNSb04vWDJqaiszdGdEMnR3?=
 =?utf-8?B?UEUzNFJGNWxBYkg5Nkd3N2dlSlNVMUNEcGdYWHBtUTlaZjNLRFN0RU9TRFNR?=
 =?utf-8?B?MkJMcGdvV3RFWUhmSmlyVVdjTEZsUVRhc242QTB0ZHcwOXFDeEpWWXAyMWM5?=
 =?utf-8?B?Z3NrZW81ZEtDbzRGY2JabXFOaVd3c0xKTkRmWnFUZGZwT1BxOEpNSVFGNmk0?=
 =?utf-8?B?cmxzb3htMi8yQmRpRituQnl0SkdMOG12NkZJQVdLdmlPa1NQVU9XMDVScUZ0?=
 =?utf-8?B?Vy85ZndScVdEQkhqbVJtR09COUtGVnJ5cHd6QXdYd0g4L3JOcHNNRjJ1U2ZD?=
 =?utf-8?B?SWw5S2JFZHBPNExURnhUcFJDUEVNUXY3cU9SRWwwN05pbHMrYk5iY1VMMHFR?=
 =?utf-8?B?SGVUQjRPWjlRWmxSUkYrS0Q3cWNvcC9FUmFMYUF1V2M1NnJTTGxCZ3pSUlI1?=
 =?utf-8?B?bk5HV3NIWFJ5VXpVNXJyTU5aMjV6V2JTYXdieHYxZHZlNU1ldjlnZm1nQU5y?=
 =?utf-8?B?QkNVaklULzc3bmtJS1lNTWNRK251bHpNNEtDMTZWY3diYTZ5blVHeWp0NEEr?=
 =?utf-8?B?ODAyZVNCZGszV2tpWVlGWWNtd25CYjB2VFdtSEZPTE1tMTNoTHQ5RkVPVmFk?=
 =?utf-8?B?Q0puemV1L1RIMWN5NjFWczJZWlJpUnBzcEtwWTNJc2lzUjRQUStVVzZDOFFB?=
 =?utf-8?B?VWw1bitLTjlmZlB2VTVLVnd6RVkrN0Q5ZUsrMFIxR0M3aUlrRG5PZXo4Y1ZI?=
 =?utf-8?B?WDY4Mm13cnV3REVOOW9QaFBpMkY2M1N5NU1OV2doNi9xdjNYUFNGb2FwTVNW?=
 =?utf-8?B?OWt2WEZPWVYxVFRiUjFlUDJ3eGsyNHh0MmpSWXo0aFZqdEFHQzJvOGlkRnpN?=
 =?utf-8?B?OUpBWWE0ZkZ1MUI5akhlUFBsQ1hGUUNqNk9ua1ltODdFbVBnYkJhdXFRSEhr?=
 =?utf-8?B?TjNrN1U4YWk2cGhsWm5kcmsrOHhaYW5kMlF2Q2xUeWx3TmhiQWNHZE85anZ3?=
 =?utf-8?B?TjhGaGdCNk1IZG9md2VOYnBjODdpWTI5c1BDcmV2Nmo4cHpLTHllV2JCNWxv?=
 =?utf-8?B?ZEpqNEUrQzhuUXE4ZDlPNVhJUWFOL0pBNzE0T0tzWWpCRHh4VlE2WkFPaVV3?=
 =?utf-8?B?OVZSRFhqVVV3NkhIa3NseGM3eGNPbDE2R29JM0ViYXErMXNlMmViTHFFUHJh?=
 =?utf-8?B?aGVta3F2bk56U3BmaFMybzJsd3pKVll3b1piQlRvYUUyU0dxWWlwSERpR0xQ?=
 =?utf-8?B?UTBwZ28xcmMwQkYvdTAxTzIxU3JiTGZsZCs5aFlVK0ZpUCt5cy9YaDhzYU10?=
 =?utf-8?B?Z05IczF6ZVA1ZmczU29LbzgzYzB2dklYejhhclJiMGU1SkxDdkRwV2V0YXRM?=
 =?utf-8?B?a1FxSmxHaVFkK1FuNHAxMDBtcUhDM20zYkgrblBLcDFzSmh3RVRXRk1KTFc5?=
 =?utf-8?B?bExCb1lYeHdoTjJkbDJYQWxJakRlaHp2VHpQQnVrL1N0OEhGUG93K29zcm5G?=
 =?utf-8?B?YldnSGh1djhubCtkMzZXZytUWlcya1JaaFpubUkrdUJNbTlDMjFRT0srSHBU?=
 =?utf-8?B?TzE2VEczWElmTmZmZEdFcTFSd1ZEUXdxVTFVbXlJM3RML0xZVWZMK0RBQnVH?=
 =?utf-8?B?ZitZM1MwUDBKdWJmak1rQ0dkS3NSQ1FCMm1wbHVmTGZJWGE0N0UxNXdEQnhC?=
 =?utf-8?Q?ateutXl4LEu4vZbCtg1marRDL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F4CAD6A1550FC42B46B892EB60975FE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a6bd76-9b23-4ef0-aaaf-08dbe01124f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 04:14:04.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOdUMbf7wndsXno/x2UdPui/d6/di1sCSmhRqmpmdcaqS2DDLQs3VgpxcKFfwPuv8ryHhxRPcg8jEyJzzCxIdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_201410_800805_A62A7661 
X-CRM114-Status: GOOD (  15.40  )
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

T24gMTEvNy8yMyAxMzo1NiwgRXdhbiBNaWxuZSB3cm90ZToNCj4gWWVzLCB3ZSBoYXZlIHNvbWUg
Z3JhcGhzLiAgSm9obiBNLiBwcmVzZW50ZWQgdGhlbSBhdCBBTFBTUyBhbmQgdGhlcmUgd2VyZQ0K
PiBzb21lIGVhcmxpZXIgb25lcyBhdCBMU0YvTU0uICBJJ2xsIHNlZSBpZiBJIGNhbiBwdXQgdXAg
dGhlIGxhdGVzdCBzZXQNCj4gZm9yIGRvd25sb2FkLg0KPg0KPiBUaGUgYmFzaWMgaXNzdWUgaXMg
dGhhdCB3aXRoIHJvdW5kLXJvYmluLCByZXF1ZXN0cyBmb3IgbW9zdC9hbGwgb2YgdGhlDQo+IHRh
Z3NldCBzcGFjZQ0KPiBjYW4gZW5kIHVwIG9uIGEgcGF0aCB0aGF0IGlzIHJlc3BvbmRpbmcgc2xv
d2x5LCBzbyB3ZSBzZWUgYQ0KPiBzaWduaWZpY2FudCBpbWJhbGFuY2UNCj4gaW4gcGF0aCB1dGls
aXphdGlvbi4NCj4NCj4NCj4gLUV3YW4NCg0KU291bmRzIGdvb2QsIHBsZWFzZSBhZGQgYSBjb3Zl
ci1sZXR0ZXIgb24geW91ciBuZXh0IHZlcnNpb24gYW5kIGRvY3VtZW50DQp0aG9zZSBzbyBldmVy
eW9uZSBjYW4gc2VlIHRoZW0sIEknbSBwcmV0dHkgc3VyZSBJJ20gbm90IHRoZSBvbmx5IHdob3Nl
DQpnb2luZyB0byBhc2sgdGhpcyBxdWVzdGlvbiA6KSAuLi4NCg0KQ2FuIHlvdSBhbHNvIHBsZWFz
ZSB3cml0ZSBhIGJsb2NrIHRlc3QgKGNjIG1lKSBmb3IgdGhpcyB1bmRlciBudm1lDQpjYXRlZ29y
eSA/IFRoaXMgbmVlZHMgdG8gYmUgdGVzdGVkIGV2ZXJ5LXRpbWUgd2Ugc2VuZCBwdWxsIHJlcXVl
c3QuDQoNCi1jaw0KDQoNCg==

