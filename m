Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BCBC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVaQzQYusemLEpqpYIHQA/4187oxQLD9NpACwqCu40w=; b=lfDEc2T1BZPB1Pdn5RmhigtMWf
	xHP/HCELO4o3Sj8esj2bVC20HunyKDoknlqGQ5nitxXQcyCfydijtG9d+Y1GAwfgvsb5jCoN0dufl
	AFD/huVbjwd7mAMhRrp8qut94O1rJHudIFTei+uVrlz7aE4DzlBb/EI6dsSOiKUldT5PfDcVxeDGr
	Sj1CtQ49LQOut5RBE9qbZK6dfZx3lpStXZb5oT3/zO+8PNBOi3e5d2SK8+Z64mFwbztjDGAK/8Epr
	M/eKRmW5cqECgTRf7Li37fkmJ5yQ5Rt3umkW9atLUiualvxpLA5X5M9i27j8iMBV1ikmgI7n1Y5rX
	eKKZ6Cnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p04o7-00AekA-8o; Tue, 29 Nov 2022 17:54:11 +0000
Received: from mail-mw2nam10on20605.outbound.protection.outlook.com ([2a01:111:f400:7e89::605] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p04o4-00AehT-IV
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 17:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnKvLWPV9K7OX/qbERppX47WoVX6sivRDBMV5F5Iy0b08q/fJPR5eQJ96QsoIHd14VbkjzxUmWRWJpAWRAzlTKC6/NJkeply0kdv0dgQN80/AdbvCOgVlvfx7/5ZrVmuKg4bXBDgFKkR1ZKpAHqGS+PVHEz1PGk7/lLCcLu4NSZwAeclqbsDHH7ChbWr8hVhBE07A3cOOuIEOEnFYGi2zNVn7BiAZztL3zf/8EAmdpIpUF951j74ZGc2rjJFwKyjYk6vblfarv62N8n+1Pfl2MUwVzkD+BLUVY9x2ajaMZQ57OYpZhzaEWIm7XtNHCKm1YHO8oTn83HfMzwTvx7h4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVaQzQYusemLEpqpYIHQA/4187oxQLD9NpACwqCu40w=;
 b=KfaYZ4uS1kqqen2qkVkQYx22AAD58vCbtX48skpRa0bkRRsaHI7jcTCRcJocJ9LhD08239hbrjR7e07QzLmieogF3TOz4ANdxPwtRfwqHFIPZYfF7ABjeDtF30009eyTgZE/gDshIlHkkgr/nb8y7JYyzVRaG5rGdSUGraBVZclp/imMQE3UO9bWX4XBMVPoaSRuAaD/4ma1/ESSvUcn4LnRdlBT6l7ik3lIYQJsQAV2YG88bMrnagAixpn0FNHVWjVXSl4akEQbv4ZEzZMQCM3seOJYqWtWDDPbomW8dqotwnSaBItyf9sBtD/ILInymCmMxZjRFmb2S7KvyDVmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVaQzQYusemLEpqpYIHQA/4187oxQLD9NpACwqCu40w=;
 b=E8ySz9NnIPedGgp7IxsWGZMkgGUvkl4rSad1S38Hnr2np8eDr02fc3a1p/RiFzhANSBGUu0aoUvsdo0G4KILjIiV/9YwLB+h/OIQMmaR1c1qzlUK608wSU9vyCDpcvdZKyzeyxn3AkeBvi3p8JRLFaPex1VNFQ8WCJSonrs2KO8NdxNSh7UcZlou6U9/ad+Vcci6S0WknLh0QudAKa3kpX6wBEVHyrit6FRESJp8tgHTEaUg6WTnBaoPOdB80eAuD+mmiPOu1CwRdbfifsfZp7adHz2rAMMeh7hi4enzN3laNN/PgvipIjkvjq4klnpV9e5Z5ppV3/wVSRYCJms72Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 17:54:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 17:54:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "joshi.k@samsung.com"
	<joshi.k@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: don't allow unprivileged Write Zeroes passthrough
 on read-only FDs
Thread-Topic: [PATCH] nvme: don't allow unprivileged Write Zeroes passthrough
 on read-only FDs
Thread-Index: AQHZA9Erp9mxqngMuka6ra2eu0SZuK5WL32A
Date: Tue, 29 Nov 2022 17:54:02 +0000
Message-ID: <3617632c-e97a-4b04-ded6-aeb035861a79@nvidia.com>
References: <20221129090016.1311006-1-hch@lst.de>
In-Reply-To: <20221129090016.1311006-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL3PR12MB6404:EE_
x-ms-office365-filtering-correlation-id: e68a3c57-b9eb-43c2-8701-08dad232b317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  BU70BSrXwRIlR91VsX/dRO7yicv+KBoj1FAPtMGFDXCo0sEgBXLnk91c+LW+qA3Ihog5a9ReqiRVa52yA6eWubQO5iA9j26O3inyX669myul3X+NjDC6pzgrbZGkPbxUie4h2GY/oH5D1ORFFPbS5Ii7CJmabTNDOrVZtTs+ru5NQ2pbRQFp+nTSvY7P+kgc8eP8FFOQIG6LyVDpKJmALqHOgLzd10J7shGWGbzp/MPPBbEVbwIPOwSezDMZ6AaQsRaQ6fUT+yafgxB7taams+6leZTniGtjkxDrXP20dF+a5SWhPVp8pGXXRgbnCarxtNvKmdtlw3L2NSmNTTyKpjXtHpqDDhxpBPQGtY2TMWYTVSktRVmebOWO7tPHlSoOGSUV8tpFeTQBwWuXc9cP6I7MHb+99zXFMCNCGByt587nFPAfzF+AvFGdTTzaq+h0rDeORPY7PgZH1D5gPWG2n2fDnXPQPOYbWSpBW0mcuJfgV8yHbo6+PAo0gvRp8F4nMzlC7vC9DvHQzuydm3IJNp3X+Zp0jU5/Ypd1y2e+81D+BDAedSR5SUOX56N8PkwvcKdMwHlM/WRupiCDU0UmCHfQFN7WlPmNln6xKzx7KjHQfDpvIJ8B+xW38y67Wwaj25K1NRv+dtFtVEm8mrOyLm08huWhrsInSaeLPUnVwGVk7gFkmdX9oqAqwTn390+QBogDEceFwbhShQRKodrwGB0rzUr5pH9igWC2dBM5xeVDbJhhxeuIxgcoUYfXeLsdbIuhXwnSbwNQlKdWHi087A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(2906002)(31686004)(478600001)(4326008)(41300700001)(86362001)(31696002)(5660300002)(8676002)(4744005)(91956017)(66476007)(8936002)(64756008)(66946007)(66446008)(66556008)(76116006)(36756003)(122000001)(38070700005)(71200400001)(6486002)(38100700002)(316002)(83380400001)(6512007)(6506007)(53546011)(186003)(110136005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QWFvMUlLczFuakJXZ3QvbDUwNkZ6UmxqOE1wVkNoSDRoTkt4clNUT1NySUoz?=
 =?utf-8?B?N2lLOWQ2cUFaaUR1a20ramJvdDVER2xhNUdwQm5PSmFkVWNaVUQvb3N1MjlG?=
 =?utf-8?B?SEtuUXNBUmhhelZhaFVudTM0aG9JRjI0U1RmUGdqUGVVQTVKOHJmQy84ZTBI?=
 =?utf-8?B?M2RYbXVQbVNpL2xiUnI2S2FXK2x3S0Q3WFVLSWRSWXV3QWp4a2k1T0NDNGg5?=
 =?utf-8?B?aHVGb28xaytvRmc4MC84cjlEY3VDSE1NMDhOajdFNVRTRWcvYXRBWS9Dc0d3?=
 =?utf-8?B?TnM1Z3pKUFBnelVxNE9iZmNBVFFMZ0ZwQmNmeGUzNHNyM3NIbGFGTXUra2ho?=
 =?utf-8?B?YXZiS2NYYUZFOUQwdWtlc3Zob1NGUXBHOGkycElQMUdsN3IvcXYvVzRoRlov?=
 =?utf-8?B?dzJhNVFaaUV5Qmw1aHQvNnFkR1M2T0dHc0V6eDVzTStKWDZ5V2RwNVdhcXJ4?=
 =?utf-8?B?MytsVk5EaFRVTCt5dWhkVUF1SUZaenFJNTNhTWJTWWl3UHhzcGJYY3haYmZE?=
 =?utf-8?B?RGxKTmJ2a21Jdzh5QnBHc21IanozUWRIU2RwZkMzZXNGbDJvYTh1czN6OWU4?=
 =?utf-8?B?ZjV2VGEyVUx3NU5uSE5mYUI5WFpVZXlJZXp3VGVsSjMxUzJrWlhZVTdoSVJ4?=
 =?utf-8?B?QlViVTFkdnRWejByd2RHLzUvZnZaTTl5dksrMitXOHh1cmdzU1Nxd1NMd1dO?=
 =?utf-8?B?dE1VSnRZQnRLSE9pQW4yazhlR3FuaDhCZXMxRnFnZmEzWDk5Y2RyajA4OUhx?=
 =?utf-8?B?eDJIRG5zRmZmOWNnZThBVHY0bk1TSXI1RTY1MjBLQ000OUFRbHprQVgvbkth?=
 =?utf-8?B?Yy80Q2Q4bjBSb1c4YXFUK0FiTU1lOFQ4VmtMdVp5UkRPUTBKTjlxUE5DUW5B?=
 =?utf-8?B?RUkzNDA2MGZkSDVDVXB4MzJYSzIyNFdHcEpEN3NJYnUySG4yRVJZVkpVRm5a?=
 =?utf-8?B?RlE4Zk9iMWFvTzljN2loZHVtQm53NzB0bldDQkNkWXdGZVBxTklDcTZxSEw1?=
 =?utf-8?B?bnA2MUdWcyt3eUpyVFoxR0hKaWhUOGkvemF2MS9FQWFOZ1dObGUyYUZBNFht?=
 =?utf-8?B?cnUrdStlSEN1bHowaFRtcHFCYm5vYjN0SUJwNHlCdWtaaVU1dzhWSms2aWNv?=
 =?utf-8?B?YVZWemZKZEtRaGxIbHZKOHZ0QXpobWU5THlsS1Jnak91TkhoV1VXTXQwVjNp?=
 =?utf-8?B?MUV3QW5pZTlwMTFCa042cE5ZYVdTY21ZcFQ1TGgrK25ubERSV2FrYXRMLzRq?=
 =?utf-8?B?U1VyS09aZVp1bHJaNnJFTWhOTkh2UG5zQlJoeU0xR0dhK29oWE5QQVppWjd3?=
 =?utf-8?B?cnRkY0JxTnZNUFlSdUdhR2RINHNTaGVSRnliTlV5RWQxOXhVdTN3TnNGSml3?=
 =?utf-8?B?Yjg3WGlpNWRlVWEzd3A0UFppY1UvemxMZTQ0K3NKUVAxbHl2dlVHTGVSMTNz?=
 =?utf-8?B?SitUWW1ET3VjRW9aV0xKYzFXdjNLbytoV2c0c1BnbmpnOW5pQXVhT21qdmZP?=
 =?utf-8?B?eTZRNkk4WjFiMktCVkJDOU1iUG1jS3RtdU4rT1duNjNQSVdJd2k5VnRILyt1?=
 =?utf-8?B?Q0ZjTWw4OGwxNm5FL3lvSFVVNWpSSTFsbzR0YUQrejM0Y0VzeDlBUGYvUm92?=
 =?utf-8?B?RFZteG11RlFJMU1CaWxhUnlta0NpY1hraWhkVEQ1Q3NaSnRXL3NYaEoxYXlN?=
 =?utf-8?B?V2I2KzlmTU1odlY2aHdmc3JDUDBrVWQ5dkRqYVZlZHhJUjFKMkZEVktoZEpD?=
 =?utf-8?B?blNwUVRUYVBQMVpKaS9nMllHU1JOOWFBTWR3TVFHR1c5K1Z2R2pWcTFHUFp0?=
 =?utf-8?B?a0xnOGg5eTAzWm5VY1NJYjR0Q3puWE51RlNYS0hkVVhSSzJueGgxR1V4b2Jw?=
 =?utf-8?B?MkR4SlRTVUM0WE01UjJoNUFoTkxSU1BENFhNRGJ1MnI4UEtURmpSc2dUd1Jl?=
 =?utf-8?B?RTVXemw4ZmNzczBuRDVNSUN1Wm1Ed1hTVGpDSEFZNXF0cS9YTDB6Slh3RHlE?=
 =?utf-8?B?VTBQQ1M4cXZCamU0Yi9xSWhPK3lZdnR1bDV1MVdwYmM4cVcrM3RPM2tLdmlq?=
 =?utf-8?B?UUNlS2s5KzBrK3lydkJpNFc1MWNvNE5MRGpzL1cyQkkvUnJXNHladys2ZDVQ?=
 =?utf-8?B?aGNDcndWOXVzYzVZRHJJekloaDQvRmVwQzBIdVdGL0pJMTlqc2RtMEF0cnc4?=
 =?utf-8?Q?6SZKWAGaBh/CHcCc3JThXtU8scUUgz8JR5oSool8Rr3U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1566E99A3A0E042B4D1AC315396AE99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68a3c57-b9eb-43c2-8701-08dad232b317
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 17:54:02.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qsg+CDXOb7TP2iQbzhxwfo2+aZC+KX5b5+JN+2bdMJ1xbWGxf/ogBqU57QP5Hw3fezcqfsMLdqohiduBLbSUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_095408_633376_C634FC80 
X-CRM114-Status: GOOD (  18.91  )
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

T24gMTEvMjkvMjIgMDE6MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBVbmZvcnR1bmF0
ZWx5IFdyaXRlIFplcm9lcyBpcyBjb2RlZCBhcyBhIG5vIGRhdGEgdHJhbnNmZXIgb3Bjb2RlIGlu
IE5WTWUsDQo+IHNvIGRvbid0IGFsbG93IGl0IG9uIGEgcmVhZC1vbmx5IEZEIGZvciB1bnByaXZp
bGVnZWQgdXNlcnMuDQo+IA0KPiBGaXhlczogODU1Yjc3MTdmNDRiICgibnZtZTogZmluZS1ncmFu
dWxhciBDQVBfU1lTX0FETUlOIGZvciBudm1lIGlvIGNvbW1hbmRzIikNCj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZt
ZS9ob3N0L2lvY3RsLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvaW9j
dGwuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gaW5kZXggOTU1MGE2OTAyOWIzNjgu
LjhhZWZlOWM5MDRkYzlhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5j
DQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gQEAgLTQ1LDcgKzQ1LDcgQEAg
c3RhdGljIGJvb2wgbnZtZV9jbWRfYWxsb3dlZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCBu
dm1lX2NvbW1hbmQgKmMsDQo+ICAgCSAqIHNwZWNpYWwgZmlsZSBpcyBvcGVuIGZvciB3cml0aW5n
LCBidXQgYWx3YXlzIGFsbG93IEkvTyBjb21tYW5kcyB0aGF0DQo+ICAgCSAqIHRyYW5zZmVyIGRh
dGEgZnJvbSB0aGUgY29udHJvbGxlci4NCj4gICAJICovDQo+IC0JaWYgKG52bWVfaXNfd3JpdGUo
YykpDQo+ICsJaWYgKG52bWVfaXNfd3JpdGUoYykgfHwgYy0+Y29tbW9uLm9wY29kZSA9PSBudm1l
X2NtZF93cml0ZV96ZXJvZXMpDQo+ICAgCQlyZXR1cm4gbW9kZSAmIEZNT0RFX1dSSVRFOw0KPiAg
IAlyZXR1cm4gdHJ1ZTsNCj4gICB9DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

