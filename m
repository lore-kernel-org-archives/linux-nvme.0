Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5915C19F21
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 08:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+41ytu61vdH0zbnN+gWNT3IsowVvCHIfBukIw5XwvpI=; b=TLyeYh9Tv5aasZb0ZwMPCn5Yha
	OuNB2PfhkfWZDl6oFXmCRNlNVHI6kp58IMdhKkJk7zEkTXcETFpI9VUaruXN6rQi8Ohz318lT8fY1
	jmFvCQhqj23xvTgDJ2pO9T8/FxJ/ai65Ha5LG1sSbaW6YDzC6UFxe5CW6JiCBt81DV7GTLejoxS7N
	fDFlZtLPv02W0qTZIb4uVDj+xuwhALKN7Ro/y/5++WbY+uEPNUlhRgm/NVoYGJSwQSL67xHkYPzLh
	9QF1g+q+WIOpJHx9t8gl+2YJWz7R/XXd5PwualPHUM0vaMwbwBHGV1KWWpAnce8va0D4HagZ9umXz
	O4sXouFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGc5U-00Aw06-Hl; Wed, 27 Jul 2022 08:08:12 +0000
Received: from mail-bn8nam04on2068.outbound.protection.outlook.com ([40.107.100.68] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGc5Q-00Avsz-I8
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 08:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8EWW/uj2dt1mZETiUtxdp2WaMbFjFxzfpuHsWfkwNjUYpjoIpqQk2/SHTs6RUlBONAjDUK6aaBK6biQMaIpJgblGWJGSryeqmnMCfdPOlnr0Txi0X/18hOGWPBF9jQHmbnccqmW5V9y+bjk7petOzqvm4W/5D3LMgJ9cELfzsuEzOZhBZm5v05jOfzYJKR8hgopTzaUkPT4MnlQqxy/8/+KQJYffLEnwiCeDSpJOTklk+WJYChITvMumAJEtvp9WY6eYUMpC27eR/LrHc395s7ruPgVufL0P1d/Qw8uICe2FPh1XGU0cZr141DqPRf0GHX4JA0MH2SRGM1knCnppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+41ytu61vdH0zbnN+gWNT3IsowVvCHIfBukIw5XwvpI=;
 b=koZFAoyJRlCmspzld2D8scCa3taRnYr5DvX/3bvdO6ZjWaGnagdoI1vca8RlQxMHcLA82H9+q6dxH51S3ZnmgyNpWcU8B41tGy6f5whSnkTuV2t4lA4IBYVVadZ2EnpaE11k4pcQMItLITpjC1CTAI4+r96qyBHrAliuMl1dX11KmVx+eONZWvDIS+ETD/dZnT0E6oIUm/8UPzThXH2LeHBdi8e7C+uV5ItP5t1pgY4+T+behVgLdYFwZQdw7+1dSMbtdx+nV28e+p1aADich2Zg3RGIGo6Y6een0JqSyoGqP3OnBqcr0QUXUI/UHzrs0b8FYwyar6DVw4zHj7XX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+41ytu61vdH0zbnN+gWNT3IsowVvCHIfBukIw5XwvpI=;
 b=k1o6EH2LJ5/sWyIS7HVyyomqyAQpBaWlXe7wvvAIsSiyx57teb2UfGCiYs5CTErDTA5zAbX4p/2YU72kr11RaY9EYoIU4/zq6+6+nB+eaZ6/638oHp/pQuh5jn5iIlP20rthcw/TqdWI+T6gJ2mkET26RwygXMeLbr7FSglmNry/q0zOKe+DsAj4i5ZZycVK8d1YT1RpUcAIeC2oKGAXQl0agqM48t8NtgRd1scnc6nBJVtdgrRMoW9WA2vn9Ny5vttqOADvs8nLIPR998m/gRi4lVKf4Ebww7EGsViuLPXABp9cA+Tz/v7MIfH2djeFdOJEaergdxL4C3IM1BcDtw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN6PR12MB1633.namprd12.prod.outlook.com (2603:10b6:405:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 08:08:02 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 08:08:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet: avoid unnecessary fsync and flush bio
Thread-Topic: [PATCH v2] nvmet: avoid unnecessary fsync and flush bio
Thread-Index: AQHYn++/mGmmktemIE6tvGsDVUi4Gq2QhzOAgAFXtICAAAE0gA==
Date: Wed, 27 Jul 2022 08:08:01 +0000
Message-ID: <8d202380-7ad5-ab95-de20-88ec730c7dbe@nvidia.com>
References: <1658730498-11857-1-git-send-email-kanie@linux.alibaba.com>
 <20220726113333.GA2867@lst.de>
 <5a28ee53-0bed-11ab-6817-e60f2ca70ed9@linux.alibaba.com>
In-Reply-To: <5a28ee53-0bed-11ab-6817-e60f2ca70ed9@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1224fb29-831d-495d-8d8f-08da6fa7205c
x-ms-traffictypediagnostic: BN6PR12MB1633:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  OJ/CRkhYKo0kmKARHMxaBQuyWbLCW97h6tLZ1mulgtzXtKAtqQs3mWty3yKjVKN/T5LrBDxYNmZyiZwzL6WAWNaSCrgiEFwm5F24kNRzNHG3DDaKMCsHGI4mwfDvUnLLMBCizNvJ7f58ScXgGQbZK5Z80Y9oTx/9C6zDTvfcnIRgcvkhY0wVTLik2Q7u7SELbe364DRNT9KkqlAxBJCx8GG/53nx857/9jX2iveJyzra77CL9mvEseJEZQ6g8RmdIdTPBgx3VDJaCScvXeaa2EwFmbn32DLAuil8MW+XSLMhb3UhDDCN/gxQNO6ezWJQ0y1Q7fLoGfi9oXbyIOFdR+3+ZTCfkPWJxnj/SoRyv+MPKxRpr/rY8OHt8urdpWMh73iBNxcf7uHLgUZZc/c4bK55lPDkIfsc7ioK7+e9ll/UjzYOjk62JUei9WUoJQnQHWe72cAi1fKth8HKo7EouBRztNIZKovWMmR0Lzr5Z4GvH3ki7QXNdS9gdNMFnoMzK7Gki70FbhTWFB3Xxy8E/M/sAYvInwBcAb/FUQM+5i8j6tLJwbLbaP4U/WpKlY4Glp0c0JfE+y9KAeaYJmHhK0znkM7qRnGsE/ucM+MqlT7xztkipY+l2bB9cSBUado9Ey9JNIqIhs+vZDeOKEDwbFHBXbok/PgrLunUQpSq0VxUoiSmsCi7Z1kvRjFZcoWkwcCFusWELOYmj+2x/p4bml+DpNTtoa0+nLVx2PQV0U70J8XDhHHCORCakVw07aHDUtY0hkdH2VQ+wg2g037WgBSlZozHDG5+SVN+P0N/E1Mfq+bzi7FnHuk/AfNiHVlLw9W37qF0hV24X8Urz5/X5e7gdYALmaKyFFcp9ZhDr2NgzhTQIdzE0bAIAsI5piZO
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8676002)(4326008)(76116006)(91956017)(66946007)(64756008)(66556008)(66446008)(66476007)(54906003)(122000001)(6916009)(316002)(86362001)(478600001)(38100700002)(2906002)(8936002)(71200400001)(6486002)(4744005)(38070700005)(31696002)(5660300002)(41300700001)(6512007)(53546011)(6506007)(31686004)(2616005)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Vjc5TjJCcTFHcHhjWFFPV1pvdFBKNWZWSUI1UzRndDh2bnhXalQxNG5sY3hM?=
 =?utf-8?B?VmFwS1ZMa2N3VWRPcjJ2N2VMM3c4d2RpdU9RREJnb1VEMDY5a2pQSkpBYm1I?=
 =?utf-8?B?STFJUS9HakFCWXJuMGVGdkhuMGMrYTZadkthaGFqNnVOU1pnNGdXMjZrclI1?=
 =?utf-8?B?TmZ1bDlNbWpsWFlsR1BDNmo4S0M0RzJ5ZGc2Yzlic0x6OWRyVlkyY1huTEQ4?=
 =?utf-8?B?V3B3bE5VUmprUGJCSjA5Qmp2UnhCMmdCZFZhYXgwU1V4dGRLeGdGNUNIR0ti?=
 =?utf-8?B?MzEzdlgvSldhNStGemFRRG9wbDVoU2RRMmdYaTFOdWdpZmtoUEJ1cDY3d3VY?=
 =?utf-8?B?WitMcnd5UTU0dUYzbEZPTC9yeHNwZ28zUjRPZVRGRGZ3UVVBMzBzRXlOdHBm?=
 =?utf-8?B?NmlEUzcvKzBKVUo3N1NFVmFUZ3VhMnlBWTloM1daWFFYT2JxK1MxWWw1VDgw?=
 =?utf-8?B?TU9sT2FZck80R0k0dW5lZk9LQ3EvaG43ajNWWktWTkQveGpkdllvNDdWbFR2?=
 =?utf-8?B?NTl4My9SR05jeXdLbXAzYWgwaTJhVzdCcitvNmNyd2ZUV29nSEh5SmhvVHdx?=
 =?utf-8?B?N1F2RmVUNXlHQzh1NWp2d3VPZTlWcS83SXp5RTVXWU5EN0NOcWdzc0NzdHE1?=
 =?utf-8?B?TVl0QUJRL1hTMVFvZGE1bjMzcnYrNnhUWEJudHgrejFoNFVLWnJCVjRROEtS?=
 =?utf-8?B?WGdKRnRpRnBzTXBwd3RGZHVvTWg4Ni8xNWIvOTFPODhVSU1Edkh6aEQ4VytT?=
 =?utf-8?B?TmwvVlJ5U1krNWl5OG5Na24vNE1ESmxoKzNGUGJoSUcwa09zby9jYXYrL0l1?=
 =?utf-8?B?M3Erdm1nbXFheHlnMEZDaXhudkhhdFJrL2F4RUNtdFNoRmZ4ZjFpVHljZzBi?=
 =?utf-8?B?ckZCdkhqQkR1Ti9XbHRwY1V2QzlNN1IvbmFtWVBFVzdZSHZKMVY3ZTNrckg4?=
 =?utf-8?B?MThDS2hKN2pQU1YremNOWXdXdW4xY1dCL0VqNmFtV0J0bDVNVkluaEFFTXZs?=
 =?utf-8?B?OWlnWm9KYU5qVit6SHgrSmd6Yi9GZXNNYmtWRnFxNU5hRjQzOGJTc1hEN0V4?=
 =?utf-8?B?SjkwY0toT3gzc2tkNmowRmNsZlRUNVNrdllTY0V6VHVQclhBc0RyTHg0NnpV?=
 =?utf-8?B?UFcwQWZJUExHbVBvMmFQWCtSaFdmbnhQOVZVc0I2RmNHcWgzL0hOaWZlcmRx?=
 =?utf-8?B?bXJMcG5mdXBWcXJtSVVlVjZJc0ltSlp1aDZYaGdQUmsrc0NuSTFBR1h1S09H?=
 =?utf-8?B?bGJ1K0txbkFzaWx0ZDl5VXFyWU5SV3lPV3ZWTVEwMGNUSEV4UTZtUzl5cm5v?=
 =?utf-8?B?SUNMa2dsemlCMy9RN0x6T2wvbHpJQkZiRUlVd0hIeVhDMDRYWEdGYkNnWW5a?=
 =?utf-8?B?cXRJSVMyL3pVNUllQnhBRWFZeHF5L1VaTzF3elhyUEN0eW5UdHZrSStLWVl1?=
 =?utf-8?B?bEh6R1lycVJWMk9LL3FOOEp1cTh4bmRXcDNKN0IybmYxWkdUN0M3VFVJbTN3?=
 =?utf-8?B?Qmp3RGtuRDhXRGdMV0s0NitOSU5HK2VUU0ZSbFNIWGRvYUx1YkZ1eUR3R2Nj?=
 =?utf-8?B?NjY1YWRSK3FBUGk1c09WZ3cySkhnVmlNZTJLYUZpYUFTNldvWndSS1NXTi9l?=
 =?utf-8?B?TVprS0lhRWlxaFdYQ1FVRVhIREoxL1pvOHNqbERxQ0ZjMTlBd2hiQ2pPUEl4?=
 =?utf-8?B?NTRNT3pTam1ySGtJS25WS2FIZGRCUE5oSHRsMEFhZnpoWjhHbFF5MG9hQVMx?=
 =?utf-8?B?M1FCaUNOMWlHOGZFVlIwRFZac1pUdTlUWGFUZjlHdGtScHE2V2s0OU9HRjFp?=
 =?utf-8?B?VVRROEdUSlRYUDJ5WVlKSXh5eGVHL2hGZC9qeU9mS2wzNlVncUFhWHJoNHVj?=
 =?utf-8?B?RnFlN2V4dzk3VDNRbVZhQnNUQWp2Tis5WjdjV3ZDalBwWGVQTFhNakRCcEo1?=
 =?utf-8?B?VFBEZnZvOGlDK2pVanNKeVhvcFZ3d0IzNDFmUnpYb3N5S2d4MUNYclBaVzll?=
 =?utf-8?B?ZC93cHQwUjBlTHN3VnBpaW83ZVNTbEtHbFJ2VUJoKzVtc1ozNmsxbmhraXFs?=
 =?utf-8?B?dnNldmMzeFFvQ21jMmQwNVZTeUhWN2YwYXRYSTZKbERNK0xuZG9zamtodXRt?=
 =?utf-8?B?cStwOG9zejd3cVpHRlpHejg2cm1RRkZPUmNLRW8rOXNLVU5mcFVKRk9HTFRl?=
 =?utf-8?Q?Akmb4MoYHT6X2haRYf3Lp6+LnzQlBgGTJthQOfmq/7lB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <078AC425A21C14448E9EC26A9EE0BEBA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1224fb29-831d-495d-8d8f-08da6fa7205c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 08:08:01.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFOjDDL1SctunJKQyqvwJN2bj/uSW1xo8yiEp6nKpELPTeUYjWisDpwnvrXYQHfxXCGNvCJ+sZnIjnkeCusR8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_010808_654588_D46B593F 
X-CRM114-Status: GOOD (  12.13  )
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

T24gNy8yNy8yMiAwMTowMywgR3VpeGluIExpdSB3cm90ZToNCj4gDQo+IOWcqCAyMDIyLzcvMjYg
MTk6MzMsIENocmlzdG9waCBIZWxsd2lnIOWGmemBkzoNCj4+IE9uIE1vbiwgSnVsIDI1LCAyMDIy
IGF0IDAyOjI4OjE4UE0gKzA4MDAsIEd1aXhpbiBMaXUgd3JvdGU6DQo+Pj4gwqAgdTE2IG52bWV0
X2ZpbGVfZmx1c2goc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPj4+IMKgIHsNCj4+PiAtwqDCoMKg
IHJldHVybiBlcnJub190b19udm1lX3N0YXR1cyhyZXEsIHZmc19mc3luYyhyZXEtPm5zLT5maWxl
LCAxKSk7DQo+Pj4gK8KgwqDCoCBpZiAocmVxLT5ucy0+YnVmZmVyZWRfaW8pDQo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiBlcnJub190b19udm1lX3N0YXR1cyhyZXEsIHZmc19mc3luYyhyZXEt
Pm5zLT5maWxlLCAxKSk7DQo+Pj4gK8KgwqDCoCByZXR1cm4gTlZNRV9TQ19TVUNDRVNTOw0KPj4g
VGhpcyBpcyBicm9rZW4uwqAgRXZlbiBkaXJlY3QgSS9PIG5lZWRzIGFuIGZzeW5jIHRvIGNvbW1p
dCBtZXRhZGF0YQ0KPj4gY2hhbmdlcy4NCj4gDQo+IFdlbGwsIHlvdSBhcmUgcmlnaHQsIEkgd2ls
bCBzZW5kIFYzIHBhdGNoIHdpdGggcmVtb3ZlIHRoaXMgY2hhbmdlLg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gR3VpeGluIExpdQ0KPiANCg0KUGxlYXNlIHByb3ZpZGUgdGhlIHRlc3Rsb2cgZm9yIHRo
aXMgcGF0Y2ggd2l0aCBWMy4NCg0KLWNrDQoNCg0K

