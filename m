Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D65FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3k6iJlr5uFxedS/3AiXo/EHYASjL8kqZpL6g/FLOv7c=; b=pBnZ2aLZhGtV4nmFWaNgtzg939
	C7F+yo1Io8vE5wp1d04hHREKYiqcHCL05tmutxO8Vn6EX4oAvYNTSkpAOVzOSAMZN2rcOaohT+JCL
	b5NVzzrzkk/cV1NehKcsiyKUBiafZ9GnJjYURVLK2aqjTI73b6xLEuDtr1TAB6fPD/IxDlK+pv3Cc
	Mfwf7qNVME+INFUb98SZ2N0cVAz5GTM1rKR0WgzOyLrugVGCDRW3cooj1dPX58zGYAepqHftDR+vS
	9Yulr7lJ62cCLa5SafydsarPOMqVCU6HZBvPyu+a7CeUj3AFk3RoMk0luPV2UAgNhuZ/ScfWDj5p1
	BONtHmaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrmIP-009BTX-4D; Thu, 19 May 2022 19:58:53 +0000
Received: from mail-bn8nam12on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::60d]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrmIM-009BSp-Sh
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 19:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4RdehQKaFBvWs/fXvCaxX/I8mi5J4g0iOccodzfQzTRjlYKcfEnx1Q2vb5WmYAh7CtaLkvHg5qEdkUUZBFZC1VoZ85ln/fOE8chxOastsC+FzAMRnKcmTttCGR0IPxiKxZNYuJVqbH7/J5DD/rmhOaQpSFZrKBjOJlg7X4XDGMeH38TEmmQ+EBuMuw/3NFSdkkg87e7Y7ARvge1vQ5MOaU7dXi4HxnyVS3gtoya35/OMzo0PVuiHsh7BpPzsYiupyFFLHBR1cDWNJigmJ/3tycVvsDd6EuVJAX9M06Y6yUJ9oIHagLSahE3pdrMugoaO5cXOs5ll8cbBA0Tmfxq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k6iJlr5uFxedS/3AiXo/EHYASjL8kqZpL6g/FLOv7c=;
 b=c3RFfnGz4pEa7i+3jUSCZEuXzM6GBwu3gY0wDC4/EZwRdNI67uqYpwE2wXGyU8V/JX7wezxw4ytqLBLb8q0rzG0sJMjzxs4Ykz5bbeRKkBHoADMTGTUnYpraMM7+n+THayNN//dAIMnYQz8mjdQBLoJa+oqsCcxWZlkOVIXotbNy6VX0n0vseDpbpMawsfsyJQKrxg8Dt+NDJYJ+p8eYU2C0YMst2haZupoYq5EmRrbk3YxZodzpG5TJkEJNeqdnvoy9lRxV1cUzqVX6LieL77BxPy+6mwB94+HoUMxWjbFqdZ0XGQWmoZjun+OvA8HD2+OAsDohixyTJEl0fof2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k6iJlr5uFxedS/3AiXo/EHYASjL8kqZpL6g/FLOv7c=;
 b=UqqqS2JOI8yMkVJYa7NDVe11WMCP+UZDbK/ntMl/FsFtJp994MIdKfARYcxlr49kYrconmBM5Zo/dlaA5imzEhzgjCwf5pCAETI4iTXms0Rt3IDJnXvz3TpL1AzwpVq49BlHi4FrOA2UTOZmfgBn7RWjONqdPfZG7D9xiyx62wnUJ3Uyq+TL3f6Llgy8Ed7kr7Sz8KNGvtYmo7WCKGxJ8z+E/h20OWzWCjjQfuq49+PQpUu4jkRE0EN95EqlSlP7hNLwhj752Co2g+V1UMx3vHV7LFHqy3Xl7pvjNTBtnr96l9/rUZv9xbGsgnXAeDHZNTUEDbsHze3ap3dPLvQJcA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3409.namprd12.prod.outlook.com (2603:10b6:408:46::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 19:44:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6%7]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 19:44:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3] nvme: set non-mdts limits in nvme_scan_work
Thread-Topic: [PATCH V3] nvme: set non-mdts limits in nvme_scan_work
Thread-Index: AQHYas8+JT52e1MJ3UG45soQGFfOY60ml4IAgAAEhAA=
Date: Thu, 19 May 2022 19:44:16 +0000
Message-ID: <6ab0141b-b02c-24f2-016f-4277096d5be3@nvidia.com>
References: <20220518155138.120470-1-kch@nvidia.com>
 <YoaaRlK8MF7UQrA0@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YoaaRlK8MF7UQrA0@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1746bab4-fa07-4127-2261-08da39cff579
x-ms-traffictypediagnostic: BN8PR12MB3409:EE_
x-microsoft-antispam-prvs: <BN8PR12MB340965BFCE2CBD0AC57C1C66A3D09@BN8PR12MB3409.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9P08gazmjVZsKc1e44nNek2DSmAC/kGrASy2EX58sZMyu3V5faoJkg6Zodho3oezNUdzf34vXqPidMvhUeOM3qUy/nUpX+70TwEsQyzC+2ai+GF30qjO8tLiHE+TIwVWvELs8N22NeV/r74CkhMCGmaIxEtS71F1xOMXgFdQwMduH3jf7IbdOSXLYyLE0L9cdZntAIgS3Om+UNBzF+NZmFjcRa+tM6A/WoxIxOsgmx1uhGk9fG1LMmzXIy1uvq+B5Dc96rjOt0U3DPJCjGlk82Uyuc7m/OkiJTFJTGJdQGYtkTFHZZagHoAu0LPll7hDnQpMK8CzkVxNqTyTexMXFkI2WysPE+Rw6njazeEbUxzK6AKEp5/9n7ECVuMgvi2jvqDKnEJePJtgDCDXhraJNwqsefr0nRS42Jm5RZKNdNBL1Vhb/+u2/0+vESmLNlHiujAgQ5ddfFNP3nJyXT+umM6v7FPQcCx7Q3L7+CxUJ45IgEgESivoADVePnnxAD54GoYqNBZ+RbAaGRJWy3oeptQNLs5dV6JAQWLwIHeXZlrzAU88SkQFLW+HgicmD6Zpm3sTWbnBY5PrvRt7qt+caPvxJUNIUh6YNMOibkZaubb3DMAg9TxMUmmGVoFTu8ZU/0KJSvwN9EDe4N8Ut+xJadJoPVY5iLwhr23v6ys8DQzu9ZSUBo97OqcHMrG3FY/EW1sVUwaexpGYyZDY4yx7UOGgVrPgEGnJ026qI+TbJb3BLY87SZfsllcHLNSM+6Oqlo4s1iBfMWE4dX9KPXUW9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66446008)(66476007)(66556008)(8676002)(4326008)(110136005)(66946007)(91956017)(36756003)(76116006)(38100700002)(31686004)(4744005)(71200400001)(54906003)(38070700005)(122000001)(316002)(6506007)(6486002)(508600001)(6512007)(8936002)(5660300002)(86362001)(2616005)(31696002)(186003)(53546011)(2906002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFJCWUVwRk9Pbm8zSEhxTXhCSnp5ZkxIYWhZQnhNTzNQdHZLR3NydVd0aFly?=
 =?utf-8?B?ajlIMWpaUW5vTkRPcm5JZW5xQmVmdHE4cGs4aWZxZGtOZ1R6MTg3WDd1NGFO?=
 =?utf-8?B?OGNqUm5LaHk4WVM5Z1JNUDZKWitlTSsrYllkRGhWUXZXZkthRzJFUmtmRlBy?=
 =?utf-8?B?ak02Uy9vQTc2ZWd0aDAxVVJqUUpmVlBjQVRtdFFXcmxaNEJNck1TYk9LY0xY?=
 =?utf-8?B?L3NicU04WFpkUkFTdEhuU3gzM3FvNHJkejVZd2RGcE5vNEdTMlMrTzdXc0pn?=
 =?utf-8?B?Q0RFN1EyYXk2UmltZTN1cFIyMTlqUzM3dUlHSU1Sd2dzZXJVMVMycGppWmhD?=
 =?utf-8?B?dVlqNnhDcFlmZjh5enJCaU1Hc25sZGFEQmlVMEM4STJvYWUvdk1IMEpMcklq?=
 =?utf-8?B?a2NWWjlzWDR6Zy9qa2tKd2FlNEl6MU1rcm10SVcwQjZOZERTM0lXUFRNREZU?=
 =?utf-8?B?YXBpdGJXUzhCYU9rbm5xM3hCVldnRjM1ZzJDaTFKZkR3Mm5yQWczS1FJTmND?=
 =?utf-8?B?WkNFQTZEV3JMUWFxMWlERXlsT09sUjNaTW5ZMTRhQWtEcjhZTnBVelByNDFk?=
 =?utf-8?B?M29NempnazlSNUJVbFdNSWhVclVVckdHNzNTMCt4c3U0N056bGxNTEZ3SzhH?=
 =?utf-8?B?amxNUDB2MVdoZGMwUVhoaWNMLzdFeWVUcTRTNW91VHlFSlgrdnlQWmsvVGZO?=
 =?utf-8?B?R0NRRlNWK0YydHdKTEZoZ2VZQ3FPNDU2ZFhBNGdUQnRFZDJWbVhuL0hudkRu?=
 =?utf-8?B?Qkl0L013Q0ErN01lVit2bmhVdGNSbXBhamJxc1ZqMTN5ZG4vVnNlbERrZ0o5?=
 =?utf-8?B?KytDSjJXRkdnMjJSVHU5SU1lWUFmNjh5WEkrTGR4eERNb3BxQXQ4ZmI2NmxQ?=
 =?utf-8?B?N2s4S0RRaFBwTUhod0ZaUUNMQ2pXeTJFdHRhQi93cXI1aE9qcENuaTFvK2FQ?=
 =?utf-8?B?MjVMaEJUTEx3Q2lRTHZ6QW92WnEzODNoMEhvMjRhM0cySWdEQ2ZFZGpoVWRD?=
 =?utf-8?B?WHo5SHdzeHlRazFDcmUybmVRQ0NmYndON2pTaGt0VGVkYUE2QlRiNkVoYitM?=
 =?utf-8?B?a3dycTZnVmRyU1M4VzhMOXNqaktOUzYwMXFGS1c5cEhJRlpCLzRkV0lIRGNa?=
 =?utf-8?B?MTdzVlZUMGg2RmZoaTZQT291Rk90cTBjNmN0bkVEb3VsMTl3USt0MzhUdzl1?=
 =?utf-8?B?SC9SdlNySSttYXBKZy8vYTJBa3RIVTExSEU5VC92ekMySkc0MUtFVlpDempQ?=
 =?utf-8?B?YWU3NTdibUN5VVV0bVhWcEV5T0tvT0FReFhONU15emZoWXdhWllaOHEyQ0x1?=
 =?utf-8?B?ZEMvM0NJUnhwdmo2OW9sRmtMcUd0WHpJeEJlMW8rRnAwNHhHNkFZT1hPeWtD?=
 =?utf-8?B?dlZvVklkTTN1NUxpTHYzOFdLZGlCQWd1dlZ4VmhIZEk2Qm1uUno1L1B2SW1F?=
 =?utf-8?B?bWhQRVN4NDdkY0FyTENhcys4Umc1YisyRjgzMnd5M1JvWER0N2FuZWpKdkhw?=
 =?utf-8?B?NVJOOWRiRGZSQ0lEUktuOW9xdWJCWDFScGdxbERMT0lvSmpJRlp1dURrR3Yw?=
 =?utf-8?B?M2ZSY2NwbTNqUk0zeXZUcGxOVWVjM0N1cEpvbFN5NUxMZDVXZVduK3NVcnBw?=
 =?utf-8?B?RzM3aERCZytzbVFWRzRZM0JZNkdqNmFqVVlNOHF6dElCZThRa1J3UzJYREFo?=
 =?utf-8?B?TmJRZ1pLVjdOSnlRaHpmVFdxMUJCeTg3NzVnbXl3aDFkQTErWHpURFhDUlAx?=
 =?utf-8?B?cit3ZERJbTRUY3FEWG1BeURmVzVqQTMxeitOQzloUzVhNm82R1lyOWtZTldT?=
 =?utf-8?B?cmFLdUwwbWRzQnpNdjVxMy82eS85NXYzdXN1OUNMcDZSYXVwVjJ4SVZoU2FG?=
 =?utf-8?B?RlRES3IyQVBhS3pjdWtGdFR1ZjJ3WU1ZNXJyTkNxMWNoa25LaWZITkpSYlNR?=
 =?utf-8?B?bEVwaFVrbFVOdG11bERWK0ozZ1B4c2NiNnYyNXpabG5nMDI5b0Rhd09NTTUr?=
 =?utf-8?B?UjJIS2JMWFJVVmhhV2d0T2FMb2JaajVvSER1MGt6bjNYd2tZS0xrYktwbXln?=
 =?utf-8?B?aVFhWjJuSmNuNWkzU0tBbURLTGZvQmllZkxvZzBQS0hrUGloQUNaaGFhZ0Ix?=
 =?utf-8?B?UVdMMkZpWkk2QzlXYU9EN0orTzhzM3dHZHdET05TeU1LalZWZHdBQU9LTTBs?=
 =?utf-8?B?L0NyaXltTjVKeHhZVXNxY28yMUE3WUhscEFCZW5YUWhoSmhxT0FBNWRhWlpC?=
 =?utf-8?B?eC8waGFybmhmc3lyMUdFeHV2c3UxK3hyYmV5bFlRaHd6MDJqRzV0bTJrc3hz?=
 =?utf-8?B?T2pwU1NpNHI1Y01TU3hlMTEwK3FncTJqM3hXOXNnbW9Dd2VBQ1ptbzBOSUZK?=
 =?utf-8?Q?TUqBhq6Yfc0+BQ3NAbk6CMDV9uqAkyrv0tAPLVlo0zeCl?=
x-ms-exchange-antispam-messagedata-1: ZBPEyJ+i7QD4Xw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <17C69AD85911C6458C8BCAE29B17871B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1746bab4-fa07-4127-2261-08da39cff579
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 19:44:16.5247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s47AQ/C7Eocn+rKjpqrudHqoRAhVbA4kqkEmY9YWbu3gtREESol7O2wQkZkiBcZ2+eELYcyPyXyEe2BVSuuIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3409
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_125850_957595_3DA7C88D 
X-CRM114-Status: GOOD (  14.45  )
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

T24gNS8xOS8yMiAxMjoyOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDE4LCAy
MDIyIGF0IDA4OjUxOjM4QU0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+ICsJ
LyoqDQo+PiArCSAqIElkZW50aWZ5IGNvbnRyb2xsZXIgbGltaXRzIGNhbiBjaGFuZ2UgYXQgY29u
dHJvbGxlciByZXNldCBkdWUgdG8NCj4+ICsJICogbmV3IGZpcm13YXJlIGRvd25sb2FkLCBldmVu
IHRob3VnaCBpdCBpcyBub3QgY29tbW9uIHdlIGNhbm5vdCBpZ25vcmUNCj4+ICsJICogc3VjaCBz
Y2VuYXJpby4gQ29udHJvbGxlcidzIG5vbi1tZHRzIGxpbWl0cyBhcmUgcmVwb3J0ZWQgaW4gdGhl
IHVuaXQNCj4+ICsJICogb2YgbG9naWNhbCBibG9ja3MgdGhhdCBpcyBkZXBlbmRlbnQgb24gdGhl
IGZvcm1hdCBvZiBhdHRhY2hlZA0KPj4gKwkgKiBuYW1lc3BhY2UuIEhlbmNlIHJlLXJlYWQgdGhl
IGxpbWl0cyBhdCB0aGUgdGltZSBvZiBucyBhbGxvY2F0aW9uLg0KPj4gKwkgKi8NCj4gDQo+IEkg
dGhpbmsgd2UgdXN1YWxseSBzZWUgdGhlICIvKioiIGNvbW1lbnQgc3R5bGUgZm9yIGtlcm5lbCBk
b2MuDQo+IA0KPiBCdXQgb3RoZXJ3aXNlLCBwYXRjaCBsb29rcyBnb29kLg0KPiANCj4gUmV2aWV3
ZWQtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCg0KWWVzLCBJIHdhbnRlZCBp
dCB0byBiZSBkb2N1bWVudGVkIGluIGtlcm5lbCBkb2MuDQoNCi1jaw0KDQoNCg==

