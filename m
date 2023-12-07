Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F765C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 20:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V64s/Q5cByvR4DK7RHLY49f4gdg6Rtxk9/VlzX0Pink=; b=COTUtZtaK3sO/LJ1rszNIETl37
	DspO3EPE/96yEZUvqHchMAas4kLVDPcQMSkJQ51yn572Xobo1Ct8EmEnpnSItDrlQU2Oz6ozZooDp
	lcDG1dWiqDzxEMzY8vCWHE8VcG4zqqaVnHOjlGZ1nYheKa8SFLl9838GncpWBI/DrBTZO50eK4qcO
	22BZiarW/0BEcVgvXnuyAmbnGyiHc5r458cc5lNqUHN8deMEH1DdSl9nyk1J3+4IE5G48kwno5AB4
	RBoYj5XAt/uDk+TakhoSQAu6+s2eF2q63OESB6G4oNL0VC+7uJ5O88gWReGimpKR4OJgG9lx+ZAkq
	32dvBgNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBLHL-00Dsm4-1x;
	Thu, 07 Dec 2023 20:47:27 +0000
Received: from mail-dm6nam11on2062e.outbound.protection.outlook.com ([2a01:111:f400:7eaa::62e] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBLHJ-00DskZ-25
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 20:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQb9dphry8ZgVxZGC5U4n1V0XzZnQKlB65wak8cvUiC4Y3rdQQI6DoGN8OdmPfVbhHmAtdPE1KO07YwMSdsAuF33h5tmPSkB8zeLzmCJf3LSA/XyxudtzhsRZMdMP5SsKsVcNQhtk79YveI+lis3H2ax2MjZbZjlhCt5+4RFwlE4sbXlQqU4YinAmvVzHhYeGogQFFmL9SqUyzNOxT8VimnIuMWB6+g0HZ/UC9+V/hI8XitF5NF7oL8yF8GS99DyipKB3He5smVJky8MWfAyR9cDLYsllNDowJq5tvdpr84xlfI0ow7OUFUw8dmSAq+E7Ru2irtX9YCK3X8XBF1qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V64s/Q5cByvR4DK7RHLY49f4gdg6Rtxk9/VlzX0Pink=;
 b=HTwajZQyvXn8Jc4Q98NsEEhkOaRJC5QEEgnFAd3DhJT7MpgPcVUiqWAoMCiOvjErXUUwrnYIh8mAqoxjnvL9A4G9ayf5eUEsFhaeTjszAOqdz1JgGxeEX//d2XliXuhKq6TRADEpQRQA+iEf8t/UlWqUjMPRrM7K/4wUYtFiBE6vZIQrX716tLOG7jCVw7424NhSYdjJvCUDK0eunmbXvZCwTKuDx1TMTbVL5+0Tc0nj0tKWG60iuGbx3coshFQipP+KyOX44NsZBcWPD0aml/VRz7h3+X8mWTOXiMLHRJjowtKsS4Wx26jRH0+lwYEeeNZAQkK/IkZdmR6LU1LNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V64s/Q5cByvR4DK7RHLY49f4gdg6Rtxk9/VlzX0Pink=;
 b=i3WlD7XOQjIJIj+o0rvO4FLmNCErd3RvdMup1//y/3iVvxTu5llJcaVpwAlTAkVRb/gHrHTqcloFBwPCgwquUQr1jNdSvZ5Rx/vcyBp+18h/VagTBU6wgpx54lYxSiS6u7J4Ul/Owy/Fdxgo0sUieti9TLsuibxeClvO0/nCbrRVfIDBFjFm1RwDG7HahVpP9C0uv3yeDbyyn+VH+OYP+CfWs6oHe4iFJlTF0VEtxdqForPoVvZgFT5QFcuzdewe2XtCgZPGaME1mbwZvcUghd6sptXShPEdBB05l6RQNaCEfBItm3j2JWsyj+O+pfVSd9kBB2cgaSiUuorRUcd7hw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 20:47:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 20:47:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: enhance timeout kernel log
Thread-Topic: [PATCH] nvme-pci: enhance timeout kernel log
Thread-Index: AQHaKTvsgLcA5jkEU0a+IzNRC4YQgLCeSBYAgAAA/YCAAAGVAA==
Date: Thu, 7 Dec 2023 20:47:16 +0000
Message-ID: <ea10ea9c-7f60-4d47-bd79-0b25d66d4ba6@nvidia.com>
References: <20231207183250.2947699-1-kbusch@meta.com>
 <d66d032f-e564-4a76-b9ce-cc09ab94188c@kernel.dk>
 <ZXIuAZ_mfnW6Ydhm@kbusch-mbp>
In-Reply-To: <ZXIuAZ_mfnW6Ydhm@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7493:EE_
x-ms-office365-filtering-correlation-id: c6b1af11-2639-4aa3-0a6b-08dbf765b2dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 379JHsjbvNNica05pMdwdjCSS0XB91qEtLwVHxTpw6NXB6Pt6lCjChP7NvIY2wYHLcVOSvNZnt75sFmz04j3O9y0SS7E5wNq+++H7xkoQ8q2d6AxQdiu7Hmz2/AEeN4f9jJaHiOapH/9nWpoUXmjRPpxXXeejfo5fDFDc3zKuFA+Achn2hyp9YWtmhSpdwQym7NW8RureLGG80fwRu+tYmCy4j956Q0CuPGfEFm7GIcmwbfvSZRngbNNaIP/Chq1Ez+rcZxEtv/8kudp5+RA2eGu9RqkQvsJViPzc6kqV9bgWNykBjmbQGdmAC7A7I9TfToV4qkf9IwKMhmOm3KtZKOQaXZMwXf37VARD0HeS2VS0JygdyR4ITJqmCNLpRF05roarmNTkFkhGOzfnOlo5jVqCC3Hu4+uR6Y2O8Erqx/FNr6zFQxw9NU2YIQfwtPdN1dOBBwN5WrD6ilgC6x7EBXIVKQuRz7hNwA9V3oR8dcvyyqs2NHIdszDbVEWLqh/VQv1gOFyP94ks0yGwtmjSBeG6edC5/9IiBwarRuhpX+xSWohx4K9AWYp249Sl/SrGSpO1ZDGCD1j68gS8+EVloUVGgU0GTuJJlEo1UYmC61lQxuC6uAI8GTEE/oOH0VEoofglo5AboDp+86bdelSTlvCupN4YbzNyPGLcahJiTlYiepiBbu4dl3nAe3Ixx3g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38070700009)(31686004)(53546011)(83380400001)(478600001)(2616005)(2906002)(6512007)(71200400001)(122000001)(6486002)(6506007)(4326008)(8676002)(8936002)(86362001)(66556008)(5660300002)(36756003)(41300700001)(54906003)(31696002)(316002)(38100700002)(66476007)(66446008)(66946007)(76116006)(64756008)(91956017)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDlLMFdwS3dvSmtMc2Mxd0JYMFgrVlB3VmtyNm1GWkx2VGUwTm5Ma0ZNeUYw?=
 =?utf-8?B?anBvMXFsTHNYN25haXZ1THBhaVAyUTZPRXN5K2NYMTBGSE5IYVluQTU3TTFS?=
 =?utf-8?B?bHBsM09udXh1S2Z6TU9pb0UvVll4YUVSVzFqbmFINms2eEtFdWx6QzZQZER3?=
 =?utf-8?B?RkVUMk5ocklMeU53TGdIRmNkUFQ0RXNRc0YvM3BFaXFWcEpXQVlCNGpkQ3Y4?=
 =?utf-8?B?ZjZDNzlDcUxVZzgvd25VQktwUmdhaENXWG5TREtqTnFjWk5qRXI5ei9BWkQ3?=
 =?utf-8?B?UTVDTzJKWWJpL2tCQU1mVG8rNVlteUFmRlhEZmpvU1R0NWwvTHZ0cnNTcGkv?=
 =?utf-8?B?OFpyUmZvdGFrc05Ta0tFYzB6VllEdFpYM3ozcmdNR01RMjVmZEh4RWw4WVln?=
 =?utf-8?B?RTNOV2NJZFdDKzNaQWJuMTBheHp3SjB2b29MN2JVQXZ4YWpaYVR3eHhlUm9i?=
 =?utf-8?B?STRpZXhYT256eHFjc29ZSXZObTlLNHRBRG1rSldSSk1RT3dEMFR5SFV1RHdP?=
 =?utf-8?B?K0QzMDJ0WlcvNG9SRFovWVNhblBTTEkxZ05STGFIbXRWbjdwZ3NjYXdibm1P?=
 =?utf-8?B?OFNRUk0wdnlYS2pKSXczYm9XNVV1NHB5NjJ4eWxnQ1ZiN0kvWTFmVklaME9z?=
 =?utf-8?B?cngrdVhNVW9BK2F5RnJIVi9qZzZnNDgwS1JqNndic3NhRzRPZHJ6WkV5MW1Y?=
 =?utf-8?B?YXlTcWJzUnZTRU5kSVV1R1d3MFJieGlvNXJJckIzRmc5WDJlWGZVOENCN0p3?=
 =?utf-8?B?c0U3dDFmMW43OWNHdTJzZGhHZldVT3RDL3FZM3picUdpVWhrV3RScTFtYWZz?=
 =?utf-8?B?UHhPajFtY1ptUmx2NkV2S0JkTGdtN016Y3c2b2VWaVJPMGthVHQ1ZnFOYzJ4?=
 =?utf-8?B?eUFKYXhnbEtOWHhxaGxuWTZxYmJtbEJOVlR1N3E5aW0xeVZzTHNSTkdHd2kz?=
 =?utf-8?B?aStlMDVuN1V0b3M3dnB5eXRWaENwZWw1NGhiWUVPWi9YeEs2MXNWYmt3Ym1a?=
 =?utf-8?B?c0l6aStiNU80bDMxa01SS1JTaVRYRFVVZmZwWjZmaW5sdDI4TXVpdzlHcVlY?=
 =?utf-8?B?SW5QZXRnOU9RbkNhSTd5UU1scVdIeUdqaHl6bmc4dnZuc3cvMitZdFVNOVVo?=
 =?utf-8?B?VUlKV3BJY3dWNkFiQ1FJMnBWeVlPMjJnZ3N1OUkwQ0ZQTW92MG5lczFWbGJW?=
 =?utf-8?B?REh3azNmZGJ4QnNjZExia3N5Q3B0TFJoL2VMSitYdHZnR2FOQ25KQkcwL1N1?=
 =?utf-8?B?a3NQRGM2ZHVWalZCbXJta3g5Q3VEZTVmZVh5WjJoRjFmWlZMV1FHSG8yWnls?=
 =?utf-8?B?YzF6Sy9iR2E2UUlWcTFGZXpubXUrblBoWmhuank1aVJuVy9PNGxRLytWay9p?=
 =?utf-8?B?SmdqNVo3MmxGRXJNRnZBL0w4ZTZLcWRucVdaQnZNdm1LLytMK0RSNkZlcklw?=
 =?utf-8?B?UnMyWlZ1b1FiSlNPSk9VbndHOGo0b2wzZXN5dmhYeG5GU3NRanQ0eDRJNW9C?=
 =?utf-8?B?ODZKc28ycUZ4WHFzU0hLVnU0WTErTzRjMUFqKzBsWFpLdHczV3d0SnZmOXdp?=
 =?utf-8?B?bkFPZ3NMRnhBMm1nZkVKVjdnQTFkbThtK3h2RFBmYUtXZU50bm9EaEo1L0Rt?=
 =?utf-8?B?b08vUnZNWnA2Q2pVa3RUeHVBUEN4VzlVNkZrZFRaUXJOYUJ5eHcrVW82V0tL?=
 =?utf-8?B?dC9YbGVEZ253UG0vbW9vS25pTXJKaTRtV3JRTnFkOFVlOFFnekEvYlQrajFZ?=
 =?utf-8?B?eXMrSGJJaE1Nak9rcnZLazhKc0Y5cFRLYlArbDBUcXp0SkQ0WDltMHZZOVBQ?=
 =?utf-8?B?QVg2TzhZVm5kWUU2TmM4MEVBRVpqejdDejAyNkcvRWdocnAwYUtIQUF5YXEv?=
 =?utf-8?B?dHROaHZHOWIwdUdHdU0vcS9EY2MzbjdBOFhvR24wNjM1dm9XbmUrQzBvVGxR?=
 =?utf-8?B?dXdvbEsvQmUzUkZNODBpTEF0d21sWGZQMlk0QUdTQzhDajh0d1hlMjZvekJ4?=
 =?utf-8?B?dm9Ed29JUm1KejBZT1ZuTmtQNUlFL3pucXRYZkFVaGtCaFRoS2NsUWZNeE54?=
 =?utf-8?B?L3FsZjhQZWNqR2NTcXQ5dmYrdnpIYzkzT29jQ0pQYVJiRm9sRjhLQUFWVmpM?=
 =?utf-8?B?WG40UGtWT3U4T1dBb1NVWWxJeXhtOVFEanM4K2RubGh5U3VEc0xFYjQ1MTRF?=
 =?utf-8?Q?IR029fxCIXoJ17WdTey69lDWaEUkEy4SzEJyQoheguZs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BF8461BFFBD9249BC3A279D34F3DD66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b1af11-2639-4aa3-0a6b-08dbf765b2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 20:47:16.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PD9aI7x93OpOJ/MyHnft6xu/qQ7cVyIpdyPs9RVvTPgT7U+QjDQUj9D9i0LUpmEEQrNlYLFxeQL6PC+SCxYSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_124725_800685_159B3BBA 
X-CRM114-Status: GOOD (  15.75  )
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

T24gMTIvNy8yMDIzIDEyOjQxIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gVGh1LCBEZWMg
MDcsIDIwMjMgYXQgMDE6Mzg6MDRQTSAtMDcwMCwgSmVucyBBeGJvZSB3cm90ZToNCj4+IE9uIDEy
LzcvMjMgMTE6MzIgQU0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4+Pg0KPj4+IEtlcm5lbCBjb25maWdzIGRvbid0IG5lY2Vz
c2FyaWx5IGhhdmUgb3Bjb2RlIGRlY29kaW5nLCBhbmQgc29tZSBvcGNvZGVzDQo+Pj4gYXJlIG5v
dCBldmVuIGRlY29kYWJsZS4gSXQgaXMgc3RpbGwgaW50ZXJlc3RpbmcgZm9yIGRlYnVnZ2luZyBT
U0QgaXNzdWVzDQo+Pj4gdG8ga25vdyB3aGF0IG9wY29kZSBpcyB0aW1pbmcgb3V0LCB3aGF0IHJl
cXVlc3QgdHlwZSBpdCBjYW1lIGZyb20sIGFuZA0KPj4+IHRoZSBkYXRhIHNpemUgKGlmIGFwcGxp
Y2FibGUpLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgfCA5ICsrKysr
LS0tLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L3BjaS5jDQo+Pj4gaW5kZXggZmFkNGNjY2NlNzQ1Yy4uNDk3NzE5MTliMDFm
MSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KPj4+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+Pj4gQEAgLTEyODQsNiArMTI4NCw3IEBAIHN0YXRpYyBl
bnVtIGJsa19laF90aW1lcl9yZXR1cm4gbnZtZV90aW1lb3V0KHN0cnVjdCByZXF1ZXN0ICpyZXEp
DQo+Pj4gICAJc3RydWN0IHJlcXVlc3QgKmFib3J0X3JlcTsNCj4+PiAgIAlzdHJ1Y3QgbnZtZV9j
b21tYW5kIGNtZCA9IHsgfTsNCj4+PiAgIAl1MzIgY3N0cyA9IHJlYWRsKGRldi0+YmFyICsgTlZN
RV9SRUdfQ1NUUyk7DQo+Pj4gKwl1OCBvcGNvZGU7DQo+Pj4gICANCj4+PiAgIAkvKiBJZiBQQ0kg
ZXJyb3IgcmVjb3ZlcnkgcHJvY2VzcyBpcyBoYXBwZW5pbmcsIHdlIGNhbm5vdCByZXNldCBvcg0K
Pj4+ICAgCSAqIHRoZSByZWNvdmVyeSBtZWNoYW5pc20gd2lsbCBzdXJlbHkgZmFpbC4NCj4+PiBA
QCAtMTM2MSwxMSArMTM2MiwxMSBAQCBzdGF0aWMgZW51bSBibGtfZWhfdGltZXJfcmV0dXJuIG52
bWVfdGltZW91dChzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPj4+ICAgCWNtZC5hYm9ydC5jaWQgPSBu
dm1lX2NpZChyZXEpOw0KPj4+ICAgCWNtZC5hYm9ydC5zcWlkID0gY3B1X3RvX2xlMTYobnZtZXEt
PnFpZCk7DQo+Pj4gICANCj4+PiArCW9wY29kZSA9IG52bWVfcmVxKHJlcSktPmNtZC0+Y29tbW9u
Lm9wY29kZSwNCj4+PiAgIAlkZXZfd2Fybihudm1lcS0+ZGV2LT5jdHJsLmRldmljZSwNCj4+PiAt
CQkiSS9PICVkICglcykgUUlEICVkIHRpbWVvdXQsIGFib3J0aW5nXG4iLA0KPj4+IC0JCSByZXEt
PnRhZywNCj4+PiAtCQkgbnZtZV9nZXRfb3Bjb2RlX3N0cihudm1lX3JlcShyZXEpLT5jbWQtPmNv
bW1vbi5vcGNvZGUpLA0KPj4+IC0JCSBudm1lcS0+cWlkKTsNCj4+PiArCQkgIkkvTyAlZCAoJXMg
JWQpIFFJRCAlZCB0aW1lb3V0LCBhYm9ydGluZyByZXFfb3A6JXUgc2l6ZToldVxuIiwNCj4+PiAr
CQkgcmVxLT50YWcsIG52bWVfZ2V0X29wY29kZV9zdHIob3Bjb2RlKSwgb3Bjb2RlLCBudm1lcS0+
cWlkLA0KPj4+ICsJCSByZXFfb3AocmVxKSwgYmxrX3JxX2J5dGVzKHJlcSkpOw0KPj4NCj4+IFlv
dXIgYWRkaXRpb25zIGxvb2sgZ29vZCB0byBtZSwgYnV0IEkgZG8gd2lzaCB0aGF0IHdlJ2QgYmUg
ZXF1YWxseQ0KPj4gdmVyYm9zZSBvbiB3aGF0IHRoZSBvdGhlciB2YWx1ZXMgYXJlLiBBbGE6DQo+
Pg0KPj4gCUkvTyB0YWcgJWQgKG9wY29kZTogJXMgJWQpIC4uLg0KPj4NCj4+IHdvdWxkIGJlIGEg
bG90IG1vcmUgdXNlZnVsLCBmb3IgZXhhbXBsZS4gSSBmaW5kIG15c2VsZiBoYXZpbmcgdG8gZGln
DQo+PiBpbnRvIHRoZSBzb3VyY2UgZm9yIGEgc3BlY2lmaWMga2VybmVsIHNvbWV0aW1lcyB3aGVu
IGxvb2tpbmcgYXQgdmFyaW91cw0KPj4gbnZtZSBlcnJvcnMsIHdoaWNoIGlzIHJlYWxseSBhbm5v
eWluZy4NCj4gDQo+IFRoYXQgaXMgYW5ub3lpbmcuIEknbGwgYWRkIHlvdXIgc3VnZ2VzdGlvbiBp
bi4NCj4gDQoNCndoaWxlIGRvaW5nIHRoYXQgaXMgaXQgd29ydGggcHJpbnRpbmcgdGhlIGJsa19v
cF9zdHIocmVxX29wKHJlcSkpIGFsb25nDQp3aXRoIHRoZSByZXFfb3AocmVxKSBzaW5jZSB3ZSBh
cmUgZG9pbmcgdmVyYm9zZSBhbnl3YXkgPyBpZiBpdCBpcyBub3QNCndvcnRoIGRpc3JlZ2FyZCBt
eSBzdWdnZXN0aW9uIC4uLg0KDQotY2sNCg0KDQo=

