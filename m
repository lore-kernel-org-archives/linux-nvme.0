Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A14C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 06:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKSNNm61nO2Ex8j9s0dyMZ4bYHJhgxdOqEs1GU14X70=; b=ZiBV9mHb30G2cuDjbGTMvvySZa
	vQ09a5CmGrOIe4YZnREjI8o992FN8hasA1wePsqZkkFMZM/qNBGoajwunc11wxcgbVISwHx2KDJnW
	f0y31RIY/FjGne4IYDmVgV6zL1rc499fNDFtdHyVk76/KMgQtEr174lw6PrMHjhXjS7vuZGB1FJDx
	18dqUDf/3eqTGxqu4VOe0V43wwTNsFzUhJwT/vzR+nG7Cz/licALYVZeeRd6luaexi/eyB7ikFako
	HqljD0yL7hacvNX8j+L0Vz4Gn3z/5q9Vue6jUz15NYXGNqqQ+hLRTk4LvEnkNkO5DBjFqlC6lm2lB
	4O9c0kxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7VoM-00A37B-IA; Tue, 20 Dec 2022 06:09:10 +0000
Received: from mail-mw2nam04on2063.outbound.protection.outlook.com ([40.107.101.63] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7VoI-00A33V-DN
	for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 06:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSSafNF/JthaTf1NG4l7oGHHx4rA2HuoGD03Ki3bhf35uJffbOAknw4XHBth6u8yCzTqRb7xbdwSSNOMYS+fEQ9BnZmQsPK1gc48e/DG56rkm++05cunY/WucGUUU3MhqypOeyTmDN74gcEVWySlyM1oRLTFsb80KTG6WXqZZ1NkwbpS3j90tEJh8ALMUDFv+2ZHPosjOOrrG/F3iW2m0T/jQNDb7TeeMtXkNf2Znq2QEq3yUTJ1QJ6xoUq8UolxTmfK5CLTdy6W0ftTLIjQrinU9oCVAgu5kjTXjvPewtkaMha0xVTKNbmJqPs2vZdasCDYvsGPLtR2LINYNBzROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKSNNm61nO2Ex8j9s0dyMZ4bYHJhgxdOqEs1GU14X70=;
 b=oM4kiwBJMtOYmUjV4/ckHytoCrumcxasdrb7oxS1S9Xgv1TQhgOiX+IEvUPQTpiw+ad1quO6YAek1rf48hhCL7/BmKrq3KXPIp0Yd9MKfxxfE6iFfQ+zNWJZWXBo/a7TWjn8geZKej9oOSoW/ydyRvNWxsyApGPxGPg3t/2qbXG/Ozz9MnRT3JmKrRjJAykW3WqfmOrCBkdjfjzm71zu0jBJ5Q+JH8y0N9a52Cc6N28ranYhvDzY5kuFd+OB1SWkUzhktL6UmzOjijfROg32r1qXqt2Jq88ndc+5IIKTspEjSWuhgBGpI71bkTBT3Se4a0y/9yjXIBku8cErdOzhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKSNNm61nO2Ex8j9s0dyMZ4bYHJhgxdOqEs1GU14X70=;
 b=eT1cKtzO3ZKTR7j7c/kGmHf3VHggj58vt1kRjN01599qAIpSdvVpIMM+61mpovTH+jpVk1hGMktQ12mc4hcjozGpo0rhQNixc0981tS0isF28ant3qNtGFcu7dOP0o39m65awlUs9xsbR6OaA1u0WInDs8sg0wFvZWxkS9448tLndlUn2ROg60bpkrKFkyU/baCovJvwSBwjDuB1yLHFwiQLqpAXZxxXjg/uQBr6KlWtxhP9QsrF7UIU5FJnUAUHrbm0W8R2+vBW8CLFZbwQrxdom3ilHurHhMb5uPY4bExzaKegAOQ5N5KekAIHshkS3vxyqLJiWYWVJdzBYLjb4Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:08:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:08:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: Fix mempool alloc size
Thread-Topic: [PATCH] nvme-pci: Fix mempool alloc size
Thread-Index: AQHZE+NNyayW3UdF6kqYkuqqXvJTka52S1EA
Date: Tue, 20 Dec 2022 06:08:59 +0000
Message-ID: <f3061faf-0102-c111-f39b-0b29eaafa703@nvidia.com>
References: <20221219185906.3595984-1-kbusch@meta.com>
In-Reply-To: <20221219185906.3595984-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5885:EE_
x-ms-office365-filtering-correlation-id: 23358802-dbf3-48dc-f383-08dae250af66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wmFQ4RZOXGf8UuE1v9XueszR2nj0WO6XvHtbNWsSfF7txmklsYuL/JdPcP4Uggy73o1OJnTTju35NelL4rJ3r3uXFHjxWlZ4rwJUvSNljkIb2gz/rqruV+Mr8HbLSi4NpmZih6mPaia4ZP4hLkxU4DSShB3zRrXBg4n4CscTkWyREn3eOi3pMrcb7aiRb7nanU79aA8S6USAyNJeNzFuW3RbquaViwmWb1sV/vO3Gqqm2hqb1ifymWtUnd6SPyk2KUr0oVD/0EraNDe0oMqfXmgyQM40C/mw2b8bMYycw+OwlizMc0HSLq9fbxU6YZjwTLUgmhILBaZE0Ij4IINjerjXIQRl4XeazfBnfyAdYGMGCdrt2Ls0STWTPYA22NxwwX9bU5EtF+j4zTxf/g0fenxmRXAh5TCigvxoRFXdAwr/j8VQzb/dhKYacyw7Bb3jQlW+ixcXE2gRPidAjEnNNKU+tmWweTfg0Bo5WCOkhcRFPouyYiuY2nTW1/i/w7FSLkQTQjMS/8YJpX2DC4k7x385IxJSiTy8p5az31ElJGQWBfvF7F/ROOfZBVrEPenzR/AD2wwRbObMBSuWDNxColmCAh1rbAAKGwqvhkT9qxE0vPg4CVtkQNJdCDRVKQLZ/LE35ROo4EHQ6hQBMf1ZFtCP0O07q8LrWn+lFnJOstgL4upJ21Fy8Bnelg/dUzB4INF/wNn4CdgCFyBHFpNbsqe7nX3KcHirQQo0NM9rMY0mJpZ6F1WEsh8H12XpdCH4dM+QKcvXq+WvZsSO/qjNhA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(186003)(6512007)(64756008)(6916009)(66946007)(66476007)(8676002)(66556008)(76116006)(91956017)(66446008)(4326008)(5660300002)(122000001)(8936002)(54906003)(53546011)(38100700002)(36756003)(6506007)(71200400001)(316002)(86362001)(31696002)(38070700005)(83380400001)(4744005)(2616005)(2906002)(41300700001)(478600001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RnR6bEJyNnpRaUdLYnRNbHNKWGxtYklqbExIY2FqKy9KbXp3TXJlMUd0UFVw?=
 =?utf-8?B?WFJkUUp6bHd0Z2E5MjhDdkJhZmpLaTI1VTZqa3d3aU5mMzdFNERYSXR6ZlNP?=
 =?utf-8?B?VWtSdkk0SUMrOWJzT2x3MXdPU3ZyV1ZnMUREdS9ObWlyUm9NOUZOOUxVLzdP?=
 =?utf-8?B?SjhaaUFUL1kxNUtFRXBXWCttem1QaUlYNy9lSGVDUUhNbHVvK2I2SGZIamxD?=
 =?utf-8?B?aVJONXdnU1pQcWhmelVYbWo5ZGl3Y0JuMlZ5dFJnRFBoZW5idlV1enZSQ0VM?=
 =?utf-8?B?N0VUQmorWFROZ0FNVVpPNlNocE5HRHFyeE9JOC9aUDBkZk1DSk8vNE56VlBu?=
 =?utf-8?B?L0k0SDdySjNLVkVUUER6Wjd0TFhHTThVVytwcklHb1RvZnBXaGxWQWZac0xy?=
 =?utf-8?B?ZWRwcnY2UDNoYmpYQXIrdkRiY3pSTjROSTlHaTNJZmR4WldPb2Y3c093cndx?=
 =?utf-8?B?clNaN2VLR1dXMWNUS3l3MW5pMWxkVGJpTXUxN0hpMlJ3Zi9uZ0pJdmpsUk5Q?=
 =?utf-8?B?cmRZeW5qcmFLY0d5dzFiNUk5a2Z3bmluc05nWUE4ODkybzFYdHJPT2I2bXNI?=
 =?utf-8?B?K3NjN0czd2x0T0MzS1pzTGdzdEpzWUNiWEZOQ3dwWUh2dXJtY2Y2a0dlbXYr?=
 =?utf-8?B?NTVwQ0dtM2o2N0VMMFNFeDgzMGt5VnRHRFIwWG0xM2lTdjdhcURVZHczeUNX?=
 =?utf-8?B?eDNQNndxaTROZjI5OUdFTjRLK1U4RVJ4V0M3eTZzbk10Q0hKQjRXK2hOL3Jy?=
 =?utf-8?B?QWVibUh5UTlYYWFzUXdaZFU5WXNoS05XTGVrZ3lrZUd2QTAvWDMvcWZ2QWN3?=
 =?utf-8?B?bXFQc2ZBTEtnbHNVWWpDY01XUE1KQlAvVXpONmxRQzF6NW1iZWFPWUY5VXhI?=
 =?utf-8?B?eGtpMVRLR1Y1Y004ejJNcVVuMkZ3dTVTeHZOczQ2OEJ5STEwVTlFRFJDRm55?=
 =?utf-8?B?ZzdNbkVPRHAxdHBoV2Rva1JicGZtczJQeDhWU0xIa2FrbU1OWjk2V2hTOWZK?=
 =?utf-8?B?emZsL1U2T0xUYnFKSzJ6UVJvYmdmdlZ1YlVnd3ZsWDlDUXhuYXovT1BDM1R0?=
 =?utf-8?B?SWJDZzBKZWs1MEJLNUJUTW1rRVBZZHJjeXZHMDRwUlpjdTBnbkVORVNiRFFG?=
 =?utf-8?B?QlFlc2lrZG1QVE8zWjNpejdZRTFkOVFtdVFmUkhKdFFnTnF5aXJnV0ZIY0dr?=
 =?utf-8?B?NzNqKzcvL0paUHlCTWliMjIxdjJnQ2NGanM2dDRGajlCbTErTXJ4K2VBY0h6?=
 =?utf-8?B?SDFFTHMxT1huMjZBU3l2QkZ5d0RKeis1U3RTcnlOQ3ZJRWJsZzVqWDMzRlVi?=
 =?utf-8?B?NHlyc2ZxNXJ5azNhZG9vZFRBY2JIaFRnSGtIekRzSUk5ZXZwT3dhV2NOU3ZQ?=
 =?utf-8?B?b0E1TWdsd1o3QW1qNUt3OURrNjUvZjBFUVIvM3lXTmU0SDJmSDJKSUhDc0ky?=
 =?utf-8?B?UHkvcVhPMnVUMVRCSm1DejY5anYrZjAyWkdoN2NtU3JidWdvS281VXFNdFQ0?=
 =?utf-8?B?RnIwcXRpQ1ZSSVpMdERMUWFqb1BLbzl2b2dXNUtGYjJIMEVrS1RDK3o5cGtJ?=
 =?utf-8?B?bDhHeWF5b2pCeWhUZ05DT2ZBZWUyUGluRDA4cnFIQjVQRGNpMnI0d051aHhP?=
 =?utf-8?B?Z05QdFJLZzY5WnlUemRDckpqY0hMdC9TbVpSSkdmRmNwdFN0TmJsYnVNclo2?=
 =?utf-8?B?SGhCUW9LeXE4ZWZaZzBsMmsrQ1lzZWZQOGZ6OGpKOFVNcWhCVGFjVVgrbjAr?=
 =?utf-8?B?RFAxckN0VWgzbWt4N0dsWEhaVDA0ak9mOHFXOWFjdjV2cU9IVUhkbHg2c2pD?=
 =?utf-8?B?SDY2TlFudGxiYWkySHlPb0tlUnNQZkNqbzlEODVYdDRBblZtYitFcTZwVGln?=
 =?utf-8?B?ZmhheTZZT1JEVnZLNjR0YlljK3UrWVBYT1RJbWMzZDBjYmFhMU9qaEVUQjV6?=
 =?utf-8?B?Z05mK1g1OWpZV2JHV2cwemJ3bkFrT0YzSHQ1cU9ONFVtSFduQWtNTkZJc2hF?=
 =?utf-8?B?bnhNZ01sVTdWcnczRzU4Z0NMR1pSa096Mit3bERMaFRrc2R6cmhpWFozODRs?=
 =?utf-8?B?V292TmdobFFIUUY0eGNySWNNUFk5Ym4wcUZPS0swMHpVeXhDZUZrUkloMHFy?=
 =?utf-8?B?SmMrTW1OL3hGelVReGgrMHRNc1E4QW01TVhlRXBOTFdPSERSRHlZdFhtcDEw?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B941D9E40290A479B8641A59EA5C5FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23358802-dbf3-48dc-f383-08dae250af66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 06:08:59.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Paeo99sFFfEVM0ov4otKqIrrJvPLnXm9rly/sDHWJuerpsPKzJVgNufLDF2f0RXrJXVjV2YFkCsGuXj6tW3eaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_220906_705107_C31C5549 
X-CRM114-Status: GOOD (  14.67  )
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

T24gMTIvMTkvMjIgMTA6NTksIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IA0KPiBDb252ZXJ0IHRoZSBtYXggc2l6ZSB0byBieXRl
cyB0byBtYXRjaCB0aGUgdW5pdHMgb2YgdGhlIGRpdmlzb3IgdGhhdA0KPiBjYWxjdWxhdGVzIHRo
ZSB3b3JzdC1jYXNlIG51bWJlciBvZiBQUlAgZW50cmllcy4NCj4gDQo+IFRoZSByZXN1bHQgaXMg
dXNlZCB0byBkZXRlcm1pbmUgaG93IG1hbnkgUFJQIExpc3RzIGFyZSByZXF1aXJlZC4gVGhlDQo+
IGNvZGUgd2FzIHByZXZpb3VzbHkgcm91bmRpbmcgdGhpcyB0byAxIGxpc3QsIGJ1dCB3ZSBjYW4g
cmVxdWlyZSAyIGluIHRoZQ0KPiB3b3JzdCBjYXNlLiBJbiB0aGF0IHNjZW5hcmlvLCB0aGUgZHJp
dmVyIHdvdWxkIGNvcnJ1cHQgbWVtb3J5IGJleW9uZCB0aGUNCj4gc2l6ZSBwcm92aWRlZCBieSB0
aGUgbWVtcG9vbC4NCj4gDQo+IFdoaWxlIHVubGlrZWx5IHRvIG9jY3VyICh5b3UnZCBuZWVkIGEg
NE1CIGluIGV4YWN0bHkgMTI3IHBoeXMgc2VnbWVudHMNCj4gb24gYSBxdWV1ZSB0aGF0IGRvZXNu
J3Qgc3VwcG9ydCBTR0xzKSwgdGhpcyBtZW1vcnkgY29ycnVwdGlvbiBoYXMgYmVlbg0KPiBvYnNl
cnZlZCBieSBrZmVuY2UuDQo+IA0KPiBDYzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0K
PiBGaXhlczogOTQzZTk0MmU2MjY2ZiAoIm52bWUtcGNpOiBsaW1pdCBtYXggSU8gc2l6ZSBhbmQg
c2VnbWVudHMgdG8gYXZvaWQgaGlnaCBvcmRlciBhbGxvY2F0aW9ucyIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNCmhtbSwgc3VycHJp
c2luZyB0byBzZWUgdGhhdCB3ZSBuZXZlciBjYXVnaHQgdGhpcyB1bnRpbCB0b2RheS4uLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg==

