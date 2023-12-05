Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2566C07E97
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 05:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1JWG31b4uBlgwX5/8wpykBgUO84Ls4mdr/Dgi+Dq3Vo=; b=2LpT27da6xSltufiOlH0ZF3G9z
	OH1owlXWzjmlUe4Ue6+ytEiuoOYcenzXR5tLOEvFZ7Zl+UF0ITQLRh2h4dQuZCN48Rp21XsgZRf9t
	HVRL/QSjzHnWYOJnvfiwLhOluLMN/VXIkm8znzN5QNXW3PzWOz0HILa/Pl+4IDmlMt7CAjcFPcpMu
	9dqEhg1+1vTHUa5hmAghsc5i2R56rRFOmxw9UsZPxytTTq6Fq0w7kG04albDx3VEzDrS1qU6o4ioR
	Fr6kMQph9iOowhVIGdgrIJGOJZTD1jzTDvm5+FWMGz86QatmNkNVkgBzHG5kbl5RqAl51lJfqAT00
	MPy6cJGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAORp-006LiR-2r;
	Tue, 05 Dec 2023 05:58:21 +0000
Received: from mail-co1nam11on20627.outbound.protection.outlook.com ([2a01:111:f400:7eab::627] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAORn-006Li2-0E
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 05:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt3F8k0GxI250lqNXJccex062clHxCpPOUdDE5KoOsVWFBOcbY//OGSerh2ttvdD/RYEIqyhG/tx5xmnhUtMMbNxK/YF+Mj+UivumghUxgGcBH0itbfbsL3sQsH3qoEfyUwYmVKIHfyUf9XaUzUjLAiY6JfD7NIkqMueuxUwnUm+2bU28iOH5q+wud6J7DvhlHL7CzwS4G56hm+d6RL/+gXZZyx//IjhC3C3ahGNA2g1UoASxnM7TvS5w9CJnfW1iemhdGUdUC0kXBcUOBMv0my1dPXWid3TLaPxj7woPLaKNp1QHoq5jZdYifEN6Dh9S5hyhqe87IrVQgUK6yilFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JWG31b4uBlgwX5/8wpykBgUO84Ls4mdr/Dgi+Dq3Vo=;
 b=GSjwuuq0/VMlKUvAeL7B9HQh7Lkl8X3kWQ6zIO6Cc8a8KcWjj3iL4F4tR1Lv33GOGM3Fr7f4XOty1RN4AGNmy7LPZGnuOqvpaWBSoKAmRYfa0/zAOREX4SECn++olA6m7aO3dAl3duL/bf7J7vR6rXxiCnvo8n083A4CB+L8Fk7wLQbjg0vb+PqP5AGvIPzCzy4y3G7N9KaVN4R4qdbeZN41EliZ/vNS1Y2nyLkU8oxg2yh7IgTpyCjpf5fNpJV/wtzkYEKSzG+W2ZJGgNsQR4D1QPzbMBZxfx4tv1Uns31O/JEgq+R6mv/cA6slPRq41LKOXV7Gn9IBqzi84YUztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JWG31b4uBlgwX5/8wpykBgUO84Ls4mdr/Dgi+Dq3Vo=;
 b=NAjh7+6NQOm93wiD1cfTcGdfeubp+kqY2va9+h80T6DgerUyVgFKocbhzpiXMopAQ88IjD/hcWuO9CJXtJUmB2FCxMLB8MTc/oP4+MZczh0m6Rlpofb2HogoZ8SiRUqIYyUeeHsRqkPd5kD/QFtu73kOs4UVOph/RYl2Lrq3FnC9TisqhwEk6Dlp1y6Mu/abVEkxHAjWpEJSfZVgVYU7Lg5RIEDGRJrACouZViaEwcN1yTDeMmECqwdlCrgF/ERBP9NwiyfjWtFsm64KuBPQrqv1sdauY90T7jh4PiRKExjmQ/jxxSiPh2rIWyKH9nHlVLRq2vB+zMPrF6s+goC6Fg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 05:58:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 05:58:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 0/5] nvmetcli: REST API for remote configuration
Thread-Topic: [RFC PATCH 0/5] nvmetcli: REST API for remote configuration
Thread-Index: AQHaFkXpVRWNA1XKkUucd0I2YeCaebB5N1kAgCEcIAA=
Date: Tue, 5 Dec 2023 05:58:04 +0000
Message-ID: <e72f68dc-455c-47dc-ac1e-e5e7bb009ddc@nvidia.com>
References: <20231113152709.30894-1-hare@suse.de>
 <2c945f01-2b57-4b89-99c5-5cecdbb697c5@nvidia.com>
In-Reply-To: <2c945f01-2b57-4b89-99c5-5cecdbb697c5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7637:EE_
x-ms-office365-filtering-correlation-id: 37feb560-0931-4c9b-04e4-08dbf5572582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44dp9/oord4tWMfL4eise1b5xSBXJ7ZNYeUpuXWRejiNZXZUUCuvolqgd+Y0ZHEPwPmyzfNRFd11Ps5GX7ChbEfJTM0/KR2ZWrY377/TqXijbdLNlhodTuc2DhhRHULtTyYdcQwabLJTKoJPLIZmpZtHnf8eLafscbwo3JK5Vw/KFO+HXhwApdI782telJXF/ymUnG0mp9UhuN1NJsnutzZtPFzpTnSLZK6/ZTYJMMWcgPIO8OAKq4d275iDlkv5O58LDk/1ddyCWwPM1/lCe79dNK8Ksvjm3jE+FfD4Z4lAnGOzKVykA83YLUllNY1DU/RVqN9E7mNnrEUAqsoBx+1F/xhbqvBJjR7RhJ021aEJ5B13SUlYa78gVHN3lNQ1sQKSnuCnR5r2jAXnLyz9kOrUILeevPeL4ZTbiXCpx5KV3DmS0G34NQqrtUo3cLntEaJbIY6j6zr64ByU3czlrrL0/YSc+2KUN94zgIIMMOGLVptOITXQpq5EMMZDUdNpfzoPxbdzaZ8i4rQ6Np3VcPvARCNLNby48qRswUCuhZi2nsXo14dBeMRg0wDogMwC+/CJvGHjheHlZpPTKGUL6ekel8q+4iIwcjKqW/x7Z8w29xFxwCiugHReoZ+a6yBTB+d3X1pQXQaIruQlXXtRLIZutekoSduMI77MNf7wcB8bJ9er31knGMbE/KJa2osvrbu0sOBNJMYN/MqknAzkXlF7a0x/VoxCW7QbJTBOcyc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6019001)(346002)(376002)(366004)(396003)(39860400002)(136003)(279900001)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2616005)(122000001)(8676002)(8936002)(4326008)(6512007)(6506007)(53546011)(6486002)(71200400001)(478600001)(66899024)(91956017)(66476007)(76116006)(64756008)(66946007)(54906003)(66556008)(66446008)(110136005)(38100700002)(316002)(2906002)(36756003)(41300700001)(38070700009)(86362001)(31696002)(4744005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnZWWjVYTk1yZ2dlSWxad1FwaEpvclM3MFJUV3FPVXBDc2grMEt1QW05enRx?=
 =?utf-8?B?cHEzR08vOVBkMjJOWVNTbDcyL0FYQ3NndUREU2VZUnFlRTBRQnFWVWxDdUMw?=
 =?utf-8?B?ZlNsTnNUZkRHa1hTNU9WVHJ2TUQvNkxNSzRJMUVDYVV0bXBzazdnWGo0SHBJ?=
 =?utf-8?B?T1ZWL2YxcnZHbmdhekJHNjNIUlQ1TDhSRlpoZDc2aDlpeGFRbnRUbHk0Ris1?=
 =?utf-8?B?ZGRUUEhXZERQMFBsVEV3c2pENTl0ZWV0QW1iYzYrdHRrdTFhNjUxMzUvUVQz?=
 =?utf-8?B?VFIvSXp0b1VGMkYxcXRaYXpUWnp1THdBazQxUTR3RWlIcWErNFBnTDhjaU84?=
 =?utf-8?B?UFBYRENoamlBanN6TzRZZThvMHNRRDZCaDlpMHdKRkw2UVhobkF4cmZQTldH?=
 =?utf-8?B?dUdRWFNoK1ExNFdkVHowdk9YaExkNW9yR29HMnlnVWplaDRpR1FIdXA5UWJv?=
 =?utf-8?B?elhlQWt4YVpHeGhjcGI1VTdBbE41SEo4RzRWUzRzU2g1ZkVnaGlLOGZJZUF0?=
 =?utf-8?B?dWZuQkgvMVZwbmcvZDBxaWh2cmZzc3FURnJQbStvTWJGalBmaloyZ2R2SHhI?=
 =?utf-8?B?bHZsK1EyUmpJc2kxUStnYTB2c0s0Z2JXRUIyUy9XSm1KZ1ZBNXpnMlVqL2Vz?=
 =?utf-8?B?azFlY1FxN2RHd09VWGNZNlRwRGJlTkVZT0VsVDArdlpCOHpBcHVkR3M3bXpi?=
 =?utf-8?B?bXFtM3dnZDRKRzVtazNVeEpQL3M4ZWI3S2k0MEs0eE5KT05CUU9NTkcyUkp0?=
 =?utf-8?B?SkIvUEpOczgrRXNUSW80cytJazh0WTQvM29sSE5mWTZDZG0rVHdlRlkxYTM4?=
 =?utf-8?B?em5VUmRzWjFnU1RsaW1QK0RSVGN1bnVaQ3JWU0xMMFNTOVd1U3J6YktLa0V1?=
 =?utf-8?B?bUk0c2tvaE9LUFBFb1NZaXZQb2RXNjNVQXNZeVk4R0haaFJmOTRhUFBrVVV1?=
 =?utf-8?B?OWoxSXM4Wm9rSmFaTGdicTlQdVAvbWRQVkJkenpNVk9oQWUrMDJ4WTZFZGJy?=
 =?utf-8?B?T1NsUXlhK1lCVTJURXppVksyWmNkQ01ockJhSTJFejdZcGVmNGJtclFzOXJ2?=
 =?utf-8?B?QjZpVnN5NGVOZVJuVzRpMGxmaHBuWHJvVno4UVV2aWV1NzA3K0s4MVRwNmFa?=
 =?utf-8?B?L3Jka2o3UDFRK1FGOTZSbXA5ak03SkpkMlUzVGpHYkE3d0NNYk5sWWlrR2pG?=
 =?utf-8?B?Y1lmZXNJYXpHNGhTNXBvdFVoZnZKNmlhRUE4T2gwN2lxeHBGRHJqd1AxTXNj?=
 =?utf-8?B?K0NsNVR1eTNBekdYTTJISTdGSFVnSG1xQUlIVVdmOHNrNm4wZldlUnI2SUJK?=
 =?utf-8?B?Tk1MSUNOL3czcnNPai9DTk1TbDIwUXBUK3ZlNTdUUWs4Z0Y4TmdlZ29zNkM4?=
 =?utf-8?B?OU9GZnR2VDhjNHlocFV4Ukl1Q2NQZjMyaDk3NnRCbVhOMUFmWkVHNmpZZE9D?=
 =?utf-8?B?VG4wby9oM2h3MTVQeFdkczZhRk9ldjZSQ2R0L2VNcUpkS3oveDV6QmtXN3RD?=
 =?utf-8?B?Nk5VWlY1dE5OekR5MDlTcDhjbUhzWDMyR1RZTWovdVRPa1RmVW5kV29CMUU4?=
 =?utf-8?B?cGU4bmI3cmREaVBsSjdJYmJKeWQ5UDkyWWdRdjJkQ3JhaHJrTVcyV1dhaERD?=
 =?utf-8?B?QUVWME5xZnB6azdESGxNaC9LODBmeGM5am13T3BNR2daaEtkams2dlY2djB3?=
 =?utf-8?B?UXNObGFEcTRNNXFjRFoyU3M1aExCeTE1Y3lObk1yMFU2ZFB6MTFvcnpvQmpD?=
 =?utf-8?B?cE9Dc0lOZkQ5VGxCT1VleUZsRnJ3cnRiTGVEVUlFYnN3RzZpZ0lFK05mY1p1?=
 =?utf-8?B?a3loSHQ2UGIvZXBPNjJqajJCdzNoVkUxNjE0UEFxNXFCTm9PSWJ1Q2loMUtX?=
 =?utf-8?B?dWw4SVlUSFZRcWx2MnV5MmJTNjdISEl5cVY1c3pQSDgxb2Jhc2lqK21tQnp4?=
 =?utf-8?B?SHNtZzhNQzR4SVpCcjluUlBKK2piOCtNQTd2bzE0SytnMG43S1R5cXByWTlH?=
 =?utf-8?B?UkRzUDZpVXZZMTlQZ1VJcDVCL2dGUm9JZTdyZHJsSjlRZ2dzZUtlUDJadG5n?=
 =?utf-8?B?OTVCOHlRRG5Pc3pRNjYyYlViTWlTeGtVeWM2aFZUUnlVNHhDbFhSNXQ3cFZT?=
 =?utf-8?B?YnNzc2lYUGF4SjJGMmJsS3hOSSs4LzBZc2lyTFNIV0xRamtmWjByalpVRndT?=
 =?utf-8?Q?Cx1PtT7V/5OJAtzV8kRPg5XuxFoGhflI3sHn6Z8HqCkh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13F7B37F074D394F8AE0421961D714A1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37feb560-0931-4c9b-04e4-08dbf5572582
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 05:58:04.2771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K72wDzAO6zk+9un9mQhAy9wqPO8Pc/hTC3nUvzKMNr/MGP6DS5GfsIsGt8K4F83MbYT2nHGdJL0bTavsLgavyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_215819_134262_EB5C5AF0 
X-CRM114-Status: GOOD (  15.45  )
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

T24gMTEvMTMvMjMgMjA6MjAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gT24gMTEvMTMv
MjAyMyA3OjI3IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+PiBIaSBhbGwsDQo+Pg0KPj4g
aGVyZSdzIGFuIGF0dGVtcHQgdG8gYWxsb3cgcmVtb3RlIGNvbmZpZ3VyYXRpb24gdmlhIGEgSlNP
TiBSRVNUIEFQSS4NCj4+IEl0J3MgYmFzaWNhbGx5IHVzaW5nIHRoZSBjb25maWdmcyBwYXRocyBh
cyB0aGUgd2ViIFVSSSwgYW5kIHVzaW5nDQo+PiBodHRwICdHRVQnLCAnUFVUJywgYW5kICdQQVRD
SCcgdG8gcmV0cmlldmUsIGNyZWF0ZSwgb3IgbW9kaWZ5IHRoZQ0KPj4gbnZtZXQgY29uZmlndXJh
dGlvbi4NCj4+IEkndmUgYWxzbyBpbmNsdWRlZCBhIFJFU1QgQVBJIHJlc3BvbmRlciBiYXNlZCBv
biBmbGFzayB0byBoYW5kbGUgQVBJDQo+PiBjYWxscy4NCj4+IFRvIHRlc3QgaXQgb3V0IGp1c3Qg
ZG86DQo+Pg0KPj4gIyBweXRob24gbnZtZXRhcGkNCj4+DQo+PiBhbmQgb24gYW5vdGhlciBjb25z
b2xlOg0KPj4NCj4+ICMgZXhwb3J0IE5WTUVUX1VSST1odHRwOi8vMTI3LjAuMC4xOjUwMDAvDQo+
PiAjIHB5dGhvbiAuL252bWV0Y2xpIGxzDQo+Pg0KPj4gYW5kIHlvdSBzaG91bGQgYmUgc2VlaW5n
IHRoZSBzYW1lIG91dHB1dCBhcyB5b3Ugd291bGQgd2hlbiBydW5uaW5nDQo+PiBsb2NhbCAoYWxi
ZWl0IHdpdGggYSAnc21hbGwnIGRlbGF5IGFzIGl0IGZldGNoZXMgdGhlIGRhdGEgdmlhIHRoZSBu
ZXR3b3JrKS4NCj4+DQo+PiBBcyB1c3VhbCwgY29tbWVudHMgYW5kIHJldmlld3MgYXJlIHdlbGNv
bWUuDQo+DQo+IEknbSBhdCBMUEMsIEknbGwgZ2l2ZSBpdCBhIHRyeSBvbmNlIEknbSBiYWNrLg0K
Pg0KPiAtY2sNCj4NCj4NCj4NCg0KSSBkaWQgdGFrZSBhIHF1aWNrIGxvb2sgaW50byB0aGlzIHNl
cmllcywgb3ZlcmFsbCBJIGxpa2UgdGhpcyBpZGVhIG9mIA0KYWxsb3dpbmcNCnJlbW90ZSBjb25m
aWd1cmF0aW9uLCBTYWdpL0NocmlzdG9waCBkbyB5b3UgZ3V5cyBoYXZlIGFueSBvYmplY3Rpb25z
ID8NCg0KLWNrDQoNCg0K

