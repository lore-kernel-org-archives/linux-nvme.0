Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE24C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oj9tXjsD3O4KTsR5wBsR5h67vrdF1UfKEPFN93q425U=; b=WVJoYUCVaJpImhPAGQLCnp6CJB
	cR1LfQmI3ZcZc/TouUPSM7Fa5+llQdIMjSF5qELaVoBtKM5IUIIXNMQvHBCYSMQVmJEEkZzKf2RT7
	b2cp8y5Ps4zbWutaZnk9z3GnSu1Zf7LWPZVsSJtmggoSRXJvpDtzWriJGALAVRWQIShuwj98T0Ugu
	kb7LeBC4A5KhoQyMtJyuLnli9PP+G918OvxRNngPNip5j9+PIC3CzELwFXkWhEgnQ0gi3PhWKamf9
	9sU3HcnNnIxsWiWZmZDXY4+ous2I6GQ5uUfKVPsrBaHVebG/xCQUbSKMxagwme/m75tRsQ14fZJeV
	pVzOqVkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwttL-00BlxJ-R9; Mon, 13 Dec 2021 22:33:56 +0000
Received: from mail-co1nam11on2087.outbound.protection.outlook.com
 ([40.107.220.87] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwtRq-00Bb6J-KP
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edK4Qj7AUlabr8w3MDnmuq+sO3TXypD7d+0BUoDIdlQdrUzwz5UaDHmjJzfLmjZ8TR9ih1JUg8e77N72tsgBxaxhpWECOxGWxrhEviO+pP4yxd0tivw4TrppI0obP9E5XL6QXPp5q/2MeRRuoMJTf7N6OVTmgFbeFoPKmHjSYnKojlCTkNEiNP0xZjyySwFwTroB+J47AR26+lQ5ZETf2e0YS/L2bmNEi4K75SK3mFWSwQNys56evMvmoJ8uIBwqzCZQhGWe1rIRQxsIQGEk+KReZOXw2KfZJKN/4WsZXqA4cozaYqbS7+IhnI0BD+GfklhpR3Rked7NSvy5M45jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj9tXjsD3O4KTsR5wBsR5h67vrdF1UfKEPFN93q425U=;
 b=Zy+S1+9KAEkxJouBJgw0UrGL/JafFztn7X7iP0DgjS6prdhpvLjQSz0ZljCySEt0ft7OZVZJXoeaGjklKzMojbwNaXe41d0arWQTlMuO3fqo2JwkiJsYpJMTB3k6A6E3+Tyuoce3EMRDj2OFFaE+4xgKoOh5czpEwRs/qsP0YDXyt0nHW3YyrAiUCSEBc161nBeHKh7IH9iglN3lMHci9XPamTfoAqplVe20Hu7heGHAXlWebVGVNzWCWNUGY1eIzEKInjW6D8daVI+HkxPQrlBcQsVZVpStQoU7jFiobKD8dJU75tEBpJNMQB+ew+RGoosnZG+6jBnrd6bceNCqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj9tXjsD3O4KTsR5wBsR5h67vrdF1UfKEPFN93q425U=;
 b=EhkYmJtB7l2LWh3pWftGb4EG6Dum3kBLWtxA4QiaSK+0MRQZrqlUml5zZSOFoastKz3zMzLhSlb6MnKCFQVdf8fMBUXvd7QiaT+QPnZWUCGtW+Mkl/UMjvH3cx16uP5NDWx47hN6nG9Z5SijClxLWzoX83eXJy5xaBZuC14uDrnil7Cyyx93OyN3pz5RoQN8hdMDa0rbTY8wloLACD+N1x4rmqeMJ6YSmEeGooTeAXltiFvUbUKNQiJL4qG7I7jlsiZQYd6l1PFD2GDe0gaLhTzfB/3I9nXnRpJ+rVXKMJNjj85wLorVl6Ig8Bi8Ij3hvfbsNglr4PbHLqHwOanSqw==
Received: from MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 by MWHPR12MB1470.namprd12.prod.outlook.com (2603:10b6:301:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:05:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 22:05:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:05:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Dan
 Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, John Hubbard
 <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jakowski
 Andrzej <andrzej.jakowski@intel.com>, Minturn Dave B
 <dave.b.minturn@intel.com>, Jason Ekstrand <jason@jlekstrand.net>, Dave
 Hansen <dave.hansen@linux.intel.com>, Xiong Jianxin
 <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny
 <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>, Martin Oliveira
 <martin.oliveira@eideticom.com>, Chaitanya Kulkarni
 <ckulkarnilinux@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Jason
 Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 04/23] PCI/P2PDMA: Expose pci_p2pdma_map_type()
Thread-Topic: [PATCH v4 04/23] PCI/P2PDMA: Expose pci_p2pdma_map_type()
Thread-Index: AQHX3ACMMQbhQ+l4yUuKi4dY3Fp6YqwxIw8A
Date: Mon, 13 Dec 2021 22:05:27 +0000
Message-ID: <1130d3ee-9b40-56b9-7cbb-48e2eae3ada8@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-5-logang@deltatee.com>
In-Reply-To: <20211117215410.3695-5-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a3bed8b-6a07-49ac-613f-08d9be84ab85
x-ms-traffictypediagnostic: MW2PR12MB2569:EE_|MWHPR12MB1470:EE_
x-microsoft-antispam-prvs: <MW2PR12MB2569CEB50DA4C1F45528162FA3749@MW2PR12MB2569.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9EVdpEZomfrvmWifbhdZhlrDL6NvI76AkWtx/vduuGXUyw0W+/V6Ite5p3P7hLzj4vyETJu6HsO4YLwEZ14VzkGQ+rYYKnkmohifejSrLpA1v1vhzs4hHvadcP+dkU+80a082MLQbjXcqEsfN2hGVBo6rbhgvyLmqsgxDIqhaPaeDCZJNdkVOzIBQeJGxbKlaRxW1pGva4Qmjo7537OKuItRWLnwokXH6Hnvg6d/SlccAM8L8PPnX1fKwrJG/4gP50Rz8d2rx0WvO9qiKlxebIbLuHgq8uHBr89Mlod41U0PTrQ1IbjHMP55REi5u4DznHJp8p8WMzDMohJtCVszyxn7BUFaQOxtu5974JicQAhUdBJVllBg7RhQNKkVgRsxrhNmKV2KU4v7FZVNXwnmzVPVQdjQ8szsisM/BN/+dvomeHbOYyc3F6mq07gHHjIaRt7QcshHU6mQ7lPkwnQArZESQgIZGmHNVpCT1iBlsXH4jAbC2zeNW7pjikuVXRnpOk58HRwj5C5SB4VBJUhVqzF3oFBB3kOGGHQ5HbkJGfcuiNGxeufbF2re6+O9GiTX9lWsA5MoZmpmD89rVLrflkEVGSTblLLSWlOlv2cAPOUNTIDr5R922tASSxkDIQ1EHUUHp0hlFgoSy7TXQPiofk0R30q5YQNjNuSVLUEQDRMjq/KFFQDoLL2Ofv6QzwidobLXsiLZjqKcjMG71yCk1UOQdzoEuj2bDIwBCyQPtQwy5+Rcg/vimFq6DwtnCWWC/bJcxUA4hHocpiX0wUPYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2569.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66446008)(64756008)(91956017)(71200400001)(53546011)(66946007)(86362001)(6506007)(66476007)(4326008)(76116006)(36756003)(38070700005)(7416002)(508600001)(186003)(2616005)(316002)(110136005)(54906003)(38100700002)(31696002)(6486002)(31686004)(2906002)(122000001)(5660300002)(8676002)(8936002)(6512007)(107886003)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkw3SWltRWVQYU1nbGkxblBqc1dZL29hQUJibHFCczlzOXpzZHp0WE1pZzlr?=
 =?utf-8?B?cFZDTWgwR3ZDa29hRWFvalhENk5iUGRnRE5MVGN2MUhleGpyWTRoY1ZtTFVP?=
 =?utf-8?B?RFMvcmRaMnRqNEtVd1gxdUxPWUpBOE11SWh2cWp3ZjM4QjZhRTNMOW9zTzB6?=
 =?utf-8?B?a3NYYWYrVGNkNWdLdUJ3dEo0QVdMSjRKWnFjY0VDYktBSUdJVkpmY012TTJK?=
 =?utf-8?B?WnRtdUZIb296UDlVZm04SmoySjhVdHFBWEFmZGZYUnhGUGRLSXNUSHNLMkVh?=
 =?utf-8?B?VkZtZ3cwbkttRm95Vjd5ME1XUjVwNEkwaU85RHRNK1ZNbWpuK0FLT09Hd0dk?=
 =?utf-8?B?YWRuNGZmV3haamxuVmVpbUFLYXN6eEVUcE52THdsWDlteWNHajIvKzF1SnV0?=
 =?utf-8?B?RTJUbklXZ1NuNERBSHdTT3IrblZzNVk2TWtzTG5Vd0NIRGRmVmN2SGNDL3Rr?=
 =?utf-8?B?d2N6V1A3SkorTUZsRDB4dUs3K1ZDUCtld24vcVgzYkNUT2cybGpNc1h3QXc0?=
 =?utf-8?B?U1ZFVWc5blNsbjUwdlcyUG9xcy9SRFZzN2NlcGJPZ2orbzJtU3JINXZ6Vml5?=
 =?utf-8?B?YlA5RXRKNk1wWmw4b1ZJRWp3NGt0REcvajZFRWlMNmpQUS9DSEhvREhma3Jk?=
 =?utf-8?B?cXpmcStEclVMZ0FPSjZVOU5CSDZseHhDTCtKVnNMY3gvQ2pHK2FiOG1CYXAy?=
 =?utf-8?B?VzhVLzh0Mjd6ZHY2Q3FOdGh6Q3IrM1ZQSE5QMHRHVTdtWGY1U3NCYW9jYzlT?=
 =?utf-8?B?QnJ1Z1VNa2R1UXRreVpQL3dueFZHSDhsenVFTjVMTXFGdFlWaHlRQVEwWjk0?=
 =?utf-8?B?SlRXNmFZLzh0di9yU1pWTlNzaG1tV1U0WXdBZHpmVURBQ3BSdDhsVHZMbDhp?=
 =?utf-8?B?SjI5cUJEMk9MaFNpNDg1S1VpanhKL3lveGxCZWdpdXVybWZ5cXd2K29FZ1ZQ?=
 =?utf-8?B?OXdTNWZ3U0c0MFBBd2M1UlJwQW5Wc25oZWw3UFk5WS9BZmFqcFJwVGpxdVZ2?=
 =?utf-8?B?NXBRaTZlOWNvSDYrMi9OeTN6VDF5Y1RzQmdwbG1Qa29Bb3hrdGxKemp2UGxZ?=
 =?utf-8?B?c3NkeHZyYkQ0dkpvMWp3ZFZNdDRCNllrQVJubGV6Kzg5QlJDYTIzTGZIcGVr?=
 =?utf-8?B?eWJ1VTh6V2ZxdzN4U0RXOUNCMFhCV3hZT0J2SGdvK3NMLzlsMU5jUnpYYk9G?=
 =?utf-8?B?QkRCbUVIeXd4ZmtwL2VkZWxEc1VrNS9Jb1hRNHNTRVFETXkweEVLT0tReVcr?=
 =?utf-8?B?L1lKK2FqaUVvVmFOZ3A4QW56Sk9TUkxJbU13bEdjanR1bE8zYzR4LzllazRk?=
 =?utf-8?B?UUJqMTBHay9WaW1Hc096cXd6UWhYWnM1ZWdjK3ZmVkp1K0V4ZjR1Mm9HS1BK?=
 =?utf-8?B?SWFrSFJnVEhXRE00NW41NUdVVzhoN0Z0TjE4ZkVsTEtrVUk3b2Q0dGxmV3V2?=
 =?utf-8?B?eVNrOVBMcnU3eEpRcFhTZGhnbFpkVTNmV0M5Um9ObmxXK1VIZExIWVNqMzFN?=
 =?utf-8?B?UkJ2Z3lvTjkwbUtDTGZjUEM2NVBReW9nSUtiYkxJLzgvN085Y1BLQUZHWTRl?=
 =?utf-8?B?Rmlvek1IQkJWMWxZWEFDNXVmdGN4QTRORXdPaGxlSTJ2cDROMGs3WFVXUE85?=
 =?utf-8?B?ek1kekJ2MXhUWlFBWWo3VU0vSVZyTnhsT3Z0ck5iT3RBR1QzNjdJTVczSFg3?=
 =?utf-8?B?UW5WcEl1OTdkVnI5NnBLaUZRN3RqVXExMXRCOFlHSGJLdWxncmNWOUk1U2hT?=
 =?utf-8?B?THprdW4rTkNzbm9wM0FSYTNvdXdLaWdjTk5SYzhZZUFvbmNVcDY5MmpYNGNG?=
 =?utf-8?B?NTRPdXlQZ2EwWHR1SXJFRWszZVhWYWxwSzRPRFlHdzFIcEhvNFhNZ3BWVkl2?=
 =?utf-8?B?ZncyTG44T1JJR0daaHphRFozMUF6MWFDNGI0bUlkdVIrclFvcDlESVQ4U2JL?=
 =?utf-8?B?Q2JQV3VmWnNqMytBYXluZDhRM0o5U1lRUHRBeFhwdUp4eXBVWksxR21LeUt1?=
 =?utf-8?B?OHkvNkkrMG8zWm51WEhZb3hWUEdhOFE0V2ZkajZUOG8zT0JvYnhERGxVeU5y?=
 =?utf-8?B?ZHVxa0dwVkFMaVhwUkFpYWViSDM0d2xscm8ySXg0N3lTM1JibWlTNXkyU29w?=
 =?utf-8?B?YS9FYm01Uk9rUkszcVRzNkYrWEI2U1ZhaFkwMnpzWHJteGUvc1lwQXkvQWFI?=
 =?utf-8?Q?Kn4dw1o2mYCrdN8JVLOwRJQBMnJ5yqlznHPkKfATAPCb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <414D95F6E5D67742969473BD77A26BB6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3bed8b-6a07-49ac-613f-08d9be84ab85
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:05:27.0342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 518G23sbmV7OQYa4TNLhJbx401uj64byJa+ld0/YC+G1xjuXlSBEXPXQzNeAjXJFLWx9Co/ryeUKzFSyeAClKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1470
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_140530_717176_2AD1AA26 
X-CRM114-Status: GOOD (  12.16  )
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

T24gMTEvMTcvMjEgMTo1MyBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOg0KPiBwY2lfcDJwZG1h
X21hcF90eXBlKCkgd2lsbCBiZSBuZWVkZWQgYnkgdGhlIGRtYS1pb21tdSBtYXBfc2cNCj4gaW1w
bGVtZW50YXRpb24gYmVjYXVzZSBpdCB3aWxsIG5lZWQgdG8gZGV0ZXJtaW5lIHRoZSBtYXBwaW5n
IHR5cGUNCj4gYWhlYWQgb2YgYWN0dWFsbHkgZG9pbmcgdGhlIG1hcHBpbmcgdG8gY3JlYXRlIHRo
ZSBhY3R1YWwgSU9NTVUgbWFwcGluZy4NCj4gDQo+IFByb3RvdHlwZXMgZm9yIHRoaXMgaGVscGVy
IGFyZSBhZGRlZCB0byBkbWEtbWFwLW9wcy5oIGFzIHRoZXkgYXJlIG9ubHkNCj4gdXNlZnVsIHRv
IGRtYSBtYXAgaW1wbGVtZW50YXRpb25zIGFuZCBkb24ndCBuZWVkIHRvIHBvbGx1dGUgdGhlIHB1
YmxpYw0KPiBwY2ktcDJwZG1hIGhlYWRlcg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTG9nYW4gR3Vu
dGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPiBBY2tlZC1ieTogQmpvcm4gSGVsZ2FhcyA8
YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdn
QG52aWRpYS5jb20+DQo+IC0tLQ0KDQpUaGUgZG9jdW1lbnRhdGlvbiBsb29rcyBtdWNoIGJldHRl
ciBmcm9tIHJldmlld2VyIHBvaW50IG9mIHZpZXcuDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==

