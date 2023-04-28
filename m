Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F89EC77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hLG9Swj5Ev86w/CLPrQDsTMamuM8ZMmCNkXkuCU9kBk=; b=R7Nj0kY4ULG5VjimIjHVZSIgo1
	b70ng1ATv5Aed248/UY7f3qh2J8HwBbFdt0FnR2FqRQzUfyEC5BPU5iowap8setkac7Bd5Iokae8B
	/EuVMxPIjI72O+UugDFFWe2LGUzZ6qt9C/asRdK9aoL7++vdDy4pKNIFSuuSdUjizcjG02d7yTgi0
	s4BPSS6wXjftoJXf1155X+YO1n82nu0xHzs3yIVnJov+cIL9zKm9AjYKRWyubhxWctan7t8NR3Pft
	Pood40Mv5J/nG44yUHyxCdg2UrXIU7v48XZfGr7f1rxHU4cfZ+9rI8eO6xrjFJhNvCmi4LsjyneXS
	jRDEeDMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psJfg-008ZC0-3D;
	Fri, 28 Apr 2023 08:41:41 +0000
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psJfe-008ZB9-1F
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 08:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyKJxloo8akovvdgF5Urr/luMOuAT3pH57fCDLuR+ua1qwRTAk0sIvdbPbSlcfgpW34Dk/EuH32nlUv6XsuEvZ8tIcCiNYwkLkIYWNnaZ/Zz2IjRCbu0s9LwAWRGoPlnVi2DNtXl35+eu9EzHafTCWEsRGU/K+heaDoEpScSAioXk6uoeNaqm3G/nu26bPLbAJFcgVThh2Il1YLEgdeQO75XF+vcaFJ6HnmTLY2HPnDl6rPu+Hi9k90qIOzX73BwkYW0HE4/VTjX49NJPZhZCBVx08FKuv2IPBQefyCF1t57TIOexZKVAJSp4nwKzBnsmAtYheb05/ia9prjvsKM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLG9Swj5Ev86w/CLPrQDsTMamuM8ZMmCNkXkuCU9kBk=;
 b=nN5YaGVVO20mPs5w5xCB4339lOwXp3xFvFJlOrTu6Xpn0RBNhjzKBVZtMLJGz6+AQAnaiklInQkbGVPgcGm4pAhYlCPuiws+GAOM/WYqZfh7980TbhE8bI8yZJzA6Ypt3L49UaORjj/s4rcdph78nzZEIfK7d9lCMB6Kwqc770v57ZaITCL7jw7FjfQrKWlizX16TXPyFUHAMi7e0Gx/QznndNz8ifgnR+MrW7fSL1k9MA91l3Psi69vIOLUUCPuli33yui90zg9nNZG9nePL4d64ruq590Ejh9TJyvElcY0VV323KT6qLWjb1FdKotrhC4eUGmJN2IunptO+iR9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLG9Swj5Ev86w/CLPrQDsTMamuM8ZMmCNkXkuCU9kBk=;
 b=nsqrxUStb2pNGk5OUoW5EukJgBL5ymHZAEuVmQJCTU+o6t6EoYVnKsFQKHFrsYp/AXgPrWsTuTVfdTldSWpg0hjnqKmypjkyXTCP2ddmcISDcXj3vz3hquSXVfDkMdAXhN6qwSGngV2/Jct5N7S5vJ5en3d+8mLRpZ7emZ+V1KnECqvCN1d1aCS0LyI/hsUs0oonZLjCF6Ry8B1qq/xHvW7yLqb5FSUS7GxtjLRuKgtk7FMWGskq3/tpk5kKSlj6qKwC6+eJmqrM4SQopyQrGQ41y7Pg4t4cCL+a5nhtx2OZ66KBUIAKdz4qAarpYwduhi6vXsyWYGxX1dVYPdetgw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Fri, 28 Apr
 2023 08:41:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 08:41:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V2 0/4] nvme: init ctrl memleak and debugfs fix
Thread-Topic: [PATCH V2 0/4] nvme: init ctrl memleak and debugfs fix
Thread-Index: AQHZeaN6InaUrp9aEU6nHWZTWJu1wa9AZyqA
Date: Fri, 28 Apr 2023 08:41:28 +0000
Message-ID: <680d9848-a186-8d45-c512-92037e0a69d3@nvidia.com>
References: <20230428073115.22987-1-kch@nvidia.com>
In-Reply-To: <20230428073115.22987-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB6728:EE_
x-ms-office365-filtering-correlation-id: cce3527d-5f46-49dc-a166-08db47c45bc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  py0qCkHjAKkL78yUo49ASkcl7PDUO3D/WnAs6yufuMWNjSnQZ6Vnnt0eMuD5UiBJtGpx0pI2+CR2HG3SaeC52E7qSe5B4ct8SEXCCpS03UYroHqRX74msHQdkZJ5bMpfdXGnnvq5FHwJxBVgyWyTSJzSk08fh7DIbBZ6/onvqH3mmn5QKNk5M6D0u6pgm3Sj957XSziIgRHqeIldNeC+tKxn8BlYpfgO3+nYPSoq6sSQCB9095C3t4krrfOAHDQEALSUywwenyy5XK/ZFJh3WnDeYXs50G2Dl8lsJoLPljjJEozOBh6yPABqQ4C5lYFy5shPowLxLCE8ac/aFY5N3V4N1i/a3aNKLJBsj4x7RcgXVpENw9nscsVJPpOreRWJs9ch8m6f6JiY4iD3NiQynu3Rbt6D3u6E/TheKfYfWAogK/hCk3+TZAMVqDvEykwpzvieOaiWTtCWoaUVWJkxP89dBhTm4LguWNxCyYCNe4BnFIbZ+CS1w0joq1sDLY9NVfWF/R9WofnfuJHuPU3IXQmYpbYp3P9b5oaIAVQr+sKq80pwSd0xpBpbVCHISB1l/IvEDTR9fqs5FbzFRlz2ZGwjVdN0Z8CupZCuq+U5DPdsG+2FPECf/9PBOAkuDe55i/VumYYCpmE1QVHb+xiRgc8J8c4hfZauqJPTxMbFApevadNtNv5PwX3UYhAsi5wjW9F1n/9B8aVv0ScW1lVjYw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(31686004)(8676002)(66476007)(66446008)(64756008)(66556008)(8936002)(91956017)(54906003)(66946007)(31696002)(76116006)(122000001)(38100700002)(478600001)(86362001)(41300700001)(2906002)(316002)(4326008)(6486002)(71200400001)(110136005)(5660300002)(38070700005)(53546011)(6506007)(6512007)(186003)(2616005)(36756003)(83380400001)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?alhodDRoT0ZiNklYTXlUSThMdUZpVWJVTDlWSlVzQWNaYlREZmJ3WVQ1b2hY?=
 =?utf-8?B?QmducHdBeG9NdDQwK0VCNHZqY0hONEphZ3d0LzkraXN0Ty94eFg3Qlp1RFZI?=
 =?utf-8?B?Zm9wTDVkbVF1NVRxN3BlcVhKZ3dkbnk3M2hhbk1GcmhxVkhiLzhUbTVNb1d0?=
 =?utf-8?B?ellyNjhsV25jazQ1ajIxUnI5VGY0dW9PdTkzZXhKeG0yMHFscXhpUUQwZTB1?=
 =?utf-8?B?M2Irck1xekpLaiswa2tBRjhUa0JxRkQ2aFUybXdqcTg0TENkTVVNUEpVcWhk?=
 =?utf-8?B?dzZkaTFKNEZDUWJuODZxK3pUdUZvWmZkSjFuQ1NqNjl5RzMvZnJQckRCWkVX?=
 =?utf-8?B?MzlLdmYwSnZsc1p1dERDWG9acUx1TVZ4SkU1ZnNsYmxJRldkRFZRVTRjQ3pX?=
 =?utf-8?B?ZmdZaEZMa2pDZVdNN0N0Qmtrd2c4cXZ2Mk1WMmNzWXgwL25iZjRoTXBmSVNs?=
 =?utf-8?B?ZTVyVE51eVV3aUEyTVliZ2Y2cVN2TXkydmpIOFV5elpFWEMrQ1NEdHp5WXda?=
 =?utf-8?B?YVpzWktqRnhnTkc2ZFRNWStPRDZScEl1YW1pUHlRa1pQMko2OFI0dUt4Vllp?=
 =?utf-8?B?NEczRWE4OHZDRGlVdjl3NFJZWkZJdGpRd2JtTU43eFU5NURvMGlXZmlFRk5L?=
 =?utf-8?B?dzZBSU51OXBPaWV1YkZ6ZStHYnh2Nk9uMVF3ZVQ2V01aUXZoUEJIbDlXOFQz?=
 =?utf-8?B?cmxhT2FwQk9obHE4cE8yM3FHYWI3VTR2MFhHMEVUUTU0M2tQZDUrVU9YSVVp?=
 =?utf-8?B?ei9laVdxVkVMVFNjV1Vpa3JnRVlmbTc5VXo5SlJJckdvRGM1akZIcmt2TU80?=
 =?utf-8?B?Z0NrTjhjL1VlSDdyMXI1R3N5M1l5cW1IYkZuelZYQ0ZLYXllYjhET1dVam5N?=
 =?utf-8?B?Qy9YOElMdzRZU0VMZXNrcG1rb1p5N1lKbjd5U1ZtZXRRcjA0bFcrdFdUbVpr?=
 =?utf-8?B?cUF2Sjk0aUhWUDFVT3ZRR0c3TGEvdUNlRVE0MWw1djdJbjFiTGJiS000WURQ?=
 =?utf-8?B?TGtNdXZ4TVZlVFlrZHpIaHgyRk8ySVlMVFJjVWZ2ZTV3ZEpLaTBjbEF6bFdC?=
 =?utf-8?B?ZXovcWRBNkpCVy91ODlNaitWck43YkxPVnBpN2szUVNSOUtmaHluZkZ2ZlRw?=
 =?utf-8?B?TmRCZjZ3N2JBS0dUV3IvV3pLT3ZKZHczbDNMZGJIY1k2MXhrYmVXVWFybUxJ?=
 =?utf-8?B?bXJzNERwSi9sOEhzMkd5bzQ1b09XblJXUjZ6K3ZTQ1dITlhZYThmZm40RW9h?=
 =?utf-8?B?OVhHMTVYdXg1ZTR0Y0VBNXBTZlNJQk1GL0czTC9IR2EwVThsMG1pbG9xak9F?=
 =?utf-8?B?eDdwQ3IxR3d6bUJ3M0FlQ0pXNHMvWHhzbnBVTFhUbDMvalUwYkdvaXMvdVhW?=
 =?utf-8?B?MXJlMDltb3NpY0xxd0lhb2FLYWZQYXpUOXhHY1VUZzhyR2M0bnhsK0ZSNGM2?=
 =?utf-8?B?L0hqRFhpd2pPSEdPWFZ6dWtNYzNOd0lXRlpsMnNlTmVzZkRSLzhUQjhOam0y?=
 =?utf-8?B?bWNDbmk4OUFPRFhuVE5UZGlHUU83Q1VFTWlvNllWejdWa3czeGxTZkVOOEJo?=
 =?utf-8?B?S0VlS2JOQXJnZEtUTGRHQ1NjNUtQMVlPM2IvWDJScWloWmdRQWJQd3dHR3RY?=
 =?utf-8?B?WVVpTDdjU1VlZTNBbkgxbGU4czFaeVl1TFBNR2F5UTg4bXJCTWdrR2k4ZW1H?=
 =?utf-8?B?QnFaQVp4blRHdUZKM2ZEY3F3ZnJWRE9DbDVaRWdJZlVmZnVjbVpmMDA2NVAw?=
 =?utf-8?B?YnNnZWpvRGRhVXA2MzY4VWlGdnBjaEFWVkdoMUh1YlRFTDVQenlJNWg1VTZC?=
 =?utf-8?B?ZG8weTVQV1dadU9qcHJOaU5sRkxlbnkyZ1ZQU29WbXNDbFRoWWp3RGlBOXh4?=
 =?utf-8?B?R1BzSzBZRjJjN1VEaHljT0lBY3hwYU9JQm9pWUlZekw3SUZCanBXbEtyVnlO?=
 =?utf-8?B?N1BaSlFtNTRuV0JCUzdleGtyTEZ1UUd0WElxa2l5UFRrQXE5RWZSb0JXbHFt?=
 =?utf-8?B?RmFhaEt4Z050aUpOV0VneDZnRVM3R01Ob1g5d0VRNWp3cHBNL0tTc0orbGdE?=
 =?utf-8?B?ak5pVVp1UStiamVNa3hhQ3BCZzVaUlZkcHVMZS9HU29SalFJdVRmdUszaDgr?=
 =?utf-8?B?RnRTeTlGQWsyRkNhSEJQREJLM3ltWjYzZkUwWVRVeVJLYkorOUNzSmFuNHVn?=
 =?utf-8?Q?4T4sa5XbuRbDz+1C9ItafAY9iCqAFVtftspkGxhYXJ78?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FE053D756CADF45BDCA4B8B5409F10F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce3527d-5f46-49dc-a166-08db47c45bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 08:41:28.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGdJpRFP4R9IThHI8lvFyJb/mCcgAoqTz6bsLYDXe6PNpv+mI+DE67PO7Iaj4UVn//MTKFP6ixhUQMSJVcYh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_014138_520315_BB70849A 
X-CRM114-Status: GOOD (  14.55  )
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

T24gNC8yOC8yMyAwMDozMSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4NCj4g
VGhlcmUgaXMgbWVtbGVhayBpbiBudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZSgpLA0KPiBu
dm1lX2N0cmxfZGhjaGFwX2N0cmxfc2VjcmV0X3N0b3JlKCksIGFuZCBudm1lX2luaXRfY3RybCgp
Lg0KPg0KPiBGaXggZGhjaGFwIG1lbWxlYWtzIGJ5IGFkZGluZyByaWdodCBrZnJlZSgpIDotDQo+
DQo+IHVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmODg4NjM3NmVhODAwIChzaXplIDY0KToNCj4g
ICAgY29tbSAiY2hlY2siLCBwaWQgMjIwNDgsIGppZmZpZXMgNDM0NDMxNjcwNSAoYWdlIDkyLjE5
OXMpDQo+ICAgIGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6DQo+ICAgICAgNDQgNDggNDggNDMg
MmQgMzEgM2EgMzAgMzAgM2EgNmUgNzggNzIgMzUgNGIgNjcgIERISEMtMTowMDpueHI1S2cNCj4g
ICAgICA3NSA1OCAzNCA3NSA2ZiA0MSA3OCA3MyA0YSA2MSAzNCA2MyAyZiA2OCA3NSA0YyAgdVg0
dW9BeHNKYTRjL2h1TA0KPiAgICBiYWNrdHJhY2U6DQo+ICAgICAgWzwwMDAwMDAwMDMwY2U1ZDRi
Pl0gX19rbWFsbG9jKzB4NGIvMHgxMzANCj4gICAgICBbPDAwMDAwMDAwOWJlMWNkYzE+XSBudm1l
X2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZSsweDhmLzB4MTYwIFtudm1lX2NvcmVdDQo+ICAgICAg
WzwwMDAwMDAwMGFjMDZjOTZhPl0ga2VybmZzX2ZvcF93cml0ZV9pdGVyKzB4MTJiLzB4MWMwDQo+
ICAgICAgWzwwMDAwMDAwMDQzN2U3Y2VkPl0gdmZzX3dyaXRlKzB4MmJhLzB4M2MwDQo+ICAgICAg
WzwwMDAwMDAwMGY5NDkxYmFmPl0ga3N5c193cml0ZSsweDVmLzB4ZTANCj4gICAgICBbPDAwMDAw
MDAwMWM0NjUxM2Q+XSBkb19zeXNjYWxsXzY0KzB4M2IvMHg5MA0KPiAgICAgIFs8MDAwMDAwMDBl
Y2YzNDhmZT5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDcyLzB4ZGMNCj4NCj4g
Rml4IGRldl9wbV9xb3MgcmVsYXRlZCBtZW1sZWFrIGluIG52bWVfaW5pdF9jdHJsKCkgd2l0aCBh
ZGRpbmcNCj4gZGV2X3BtX3Fvc19oaWRlX2xhdGVuY3lfdG9sZXJhbmNlKCkgaW4gdGhlIGVycm9y
IHVud2luZCBjb2RlIDotDQo+DQo+IG52bWUvMDQ0IChUZXN0IGJpLWRpcmVjdGlvbmFsIGF1dGhl
bnRpY2F0aW9uKSAgICAgICAgICAgICAgICBbcGFzc2VkXQ0KPiAgICAgIHJ1bnRpbWUgIDIuMTEx
cyAgLi4uICAyLjEyNHMNCj4gdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmZmY4ODgxMTBjNDYyNDAg
KHNpemUgOTYpOg0KPiAgICBjb21tICJudm1lIiwgcGlkIDMzNDYxLCBqaWZmaWVzIDQzNDUzNjUz
NTMgKGFnZSA3NS41ODZzKQ0KPiAgICBoZXggZHVtcCAoZmlyc3QgMzIgYnl0ZXMpOg0KPiAgICAg
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4u
Li4uLi4uLi4uDQo+ICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4NCj4gICAgYmFja3RyYWNlOg0KPiAgICAgIFs8MDAw
MDAwMDA2OWFjMmNlYz5dIGttYWxsb2NfdHJhY2UrMHgyNS8weDkwDQo+ICAgICAgWzwwMDAwMDAw
MDZhY2M2NmQ1Pl0gZGV2X3BtX3Fvc191cGRhdGVfdXNlcl9sYXRlbmN5X3RvbGVyYW5jZSsweDZm
LzB4MTAwDQo+ICAgICAgWzwwMDAwMDAwMGNjMzc2ZWE3Pl0gbnZtZV9pbml0X2N0cmwrMHgzOGUv
MHg0MTAgW252bWVfY29yZV0NCj4gICAgICBbPDAwMDAwMDAwN2RmNjFiNGI+XSAweGZmZmZmZmZm
YzA1ZTg4YjMNCj4gICAgICBbPDAwMDAwMDAwZDE1MmI5ODU+XSAweGZmZmZmZmZmYzA1NzQ0Y2IN
Cj4gICAgICBbPDAwMDAwMDAwZjA0YTQwNDE+XSB2ZnNfd3JpdGUrMHhjNS8weDNjMA0KPiAgICAg
IFs8MDAwMDAwMDBmOTQ5MWJhZj5dIGtzeXNfd3JpdGUrMHg1Zi8weGUwDQo+ICAgICAgWzwwMDAw
MDAwMDFjNDY1MTNkPl0gZG9fc3lzY2FsbF82NCsweDNiLzB4OTANCj4gICAgICBbPDAwMDAwMDAw
ZWNmMzQ4ZmU+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Mi8weGRjDQo+DQo+
IFdoZW4gYmxrdGVzdHMgYXJlIHJ1bm5pbmcgbXVsdGlwbGUgdGltZXMgd2UgZ2V0IGZvbGxvd2lu
ZyBtZXNzYWdlcw0KPiBjb25zaXN0ZW50bHkgOi0NCj4NCj4gWyAgMTQ3Ljg1MzQ2NF0gZGVidWdm
czogRGlyZWN0b3J5ICdudm1lMScgd2l0aCBwYXJlbnQgJy8nIGFscmVhZHkgcHJlc2VudCENCj4g
WyAgMTQ3Ljg1Mzk3M10gbnZtZTE6IGZhaWxlZCB0byBjcmVhdGUgZGVidWdmcyBhdHRyDQo+IFsg
IDE0OC44MDI0OTBdIGRlYnVnZnM6IERpcmVjdG9yeSAnbnZtZTEnIHdpdGggcGFyZW50ICcvJyBh
bHJlYWR5IHByZXNlbnQhDQo+IFsgIDE0OC44MDMyNDRdIG52bWUxOiBmYWlsZWQgdG8gY3JlYXRl
IGRlYnVnZnMgYXR0cg0KPiBbICAxNDguODc3MzA0XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ252bWUx
JyB3aXRoIHBhcmVudCAnLycgYWxyZWFkeSBwcmVzZW50IQ0KPiBbICAxNDguODc3Nzc1XSBudm1l
MTogZmFpbGVkIHRvIGNyZWF0ZSBkZWJ1Z2ZzIGF0dHINCj4gWyAgMTQ5LjgxNjY1Ml0gZGVidWdm
czogRGlyZWN0b3J5ICdudm1lMScgd2l0aCBwYXJlbnQgJy8nIGFscmVhZHkgcHJlc2VudCENCj4g
WyAgMTQ5LjgxODAxMV0gbnZtZTE6IGZhaWxlZCB0byBjcmVhdGUgZGVidWdmcyBhdHRyDQo+DQo+
IEZpeCB0aG9zZSBieSBhZGRpbmcgbnZtZV9mYXVsdCBpbmplY3RfZmluaSgpIGNhbGwgaW4gdGhl
IGVycm9yIHVud2luZA0KPiBjb2RlIHBhdGguDQo+DQo+IFN0aWxsIHRyeWluZyB0byBmaW5kIG91
dCBkZXZpY2VfYWRkKCkgbWVtbGVhaywgd2lsbCBzZW5kIHBhdGNoIHNvb24uDQo+DQo+IC1jaw0K
Pg0KPg0KDQpJJ3ZlIGdlbmVyYXRlZCB0aGlzIHNlcmllcyBvbiB0aGUgbGludXgtYmxvY2svZm9y
LW5leHQsIGZvcmdldCB0bw0KbWVudGlvbmVkIHRoYXQgaW4gdGhlIGNvdmVyLWxldHRlciwgcGx6
IGxldCBtZSBrbm93IGlmIEkgc2hvdWxkDQpyZS1wb3N0IHRoaXMgb24gbGludXgtYmxvY2sgbWFp
bGluZyBsaXN0Li4uDQoNCi1jaw0KDQoNCg==

