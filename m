Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78913C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bP2so1mLSymv5N2AwZaEgWugONZZ+NL+veWRuzhncFk=; b=GY+lGyI+NCdn/wGiaFsKP+G/Vz
	NVFxCouGLgt3bZV3o4bceBXono4YQxJcQhvw0ymDm2VEPuSBOPrWM3iE9PQ0aDpcinZ+ch5B85e+x
	xmxBNiqANdm7VqpfXKFAHPXRxGcl4WkQFk6hLhP6QMc9ItK2T+6/QEncPY0V9C3pj8lkTh0y+WsIs
	De6xA5VNvj04g3WOSBnLkTx4uJq6xVoRuITxL/SBcGvIMBc+byTJ0wm0i0UJ+RsvqHexziGo0BVUw
	Nn4ZhHyoffL4/ZAYQsY5Vy4VcLThcWex8v8NRRKCTKp3O9XmWeOv7e9z+Kix9cJdi/iaMHs/wDdmi
	4sBt+4Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwtvH-00Bmgv-MX; Mon, 13 Dec 2021 22:35:55 +0000
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com
 ([40.107.237.42] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwtX6-00Bd3x-SL
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcjLgaXpFRhoWxWo1FS3JckRyhyyhwAAlZEfTdHTYbrJR6laqDTNHdmNHtisAhM9ySg8ZrNBVbjt9MIEjIvylckZsUDz9cfN14qPQ2nUHc586HVdsfMpletTBfx7WsYHh7VlalVlIAON56SpGUkU+HQ1H5b2Hhb6pp+vGkDrHuIfoZUzpIUGBFZQbm9btXUdfVbS9Tv2+vZfbHsLd29eWGnV0Q26axLs2dQ1JMA1Sb/yw+PTBP+rxf50PgKfMHu02vYQ44xfO4S+ZvyK8QXz+Z1G0Q15rElmBHfOoikWBeiR9w8FAlAUeheQIx4fpBYl/TB+PzY6v0yqJSDd2No2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP2so1mLSymv5N2AwZaEgWugONZZ+NL+veWRuzhncFk=;
 b=mGR6HtwEtt4l4HwH1OqYRBEVzK6cw6tW3vkMFdH7k/AmW7DQ5+E6Q6tmX+nFvufhXdsiKgISlhRk+FnjrAv9ni2c3wFJuRKtO9AAZTC37LXMHTvjO9NbJerQ8fpJmLJVMcR0n4siIQt+rKOTJ9ynp/z+aC4AQHOml1zJIlHRe9H6Xj8m0P2/BSPqK62AyPUwiGDAImCZ5t04a7KOVYnmgWxoSguv3evBPUE1DxoF22589LOhen7QM5VwCLI+TSn/oSRhwVREmJJGVTxXGsL8XP6YKY6UlCgfKslLgthbbfr05d/xzJJ5IcMp7lVmdO5tFMabht1LomIkHnpMhKG4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP2so1mLSymv5N2AwZaEgWugONZZ+NL+veWRuzhncFk=;
 b=BQOF6iv/VuJufiybXxCsisY2NI67nWNMyfZbpqRzGeFIYUMMTLkf7RqNMbT8c4Q7EcJPHITiK+3tE+pvABFOORH8BcciPgBh8khyrCmI6AzY5GiLx/J0o9ClOHawPRinuadpWTy2B/lCsbFJIMsibH/jeaeFr5xK2vYK/djhlx5ut/15x6BEELhRjZaC4hu9lNh4+4oWvNL3sfRzAGUhW7HD67rUGWxOEfXi60Jl33NtQdgkL8uomjbIES2wzuBFe/KCDvrNuP/0jNKkkRcSdLUEsD+KM70/s0TKM0PKNIcYi3ZnIjQNZ69RnbfDFC0rC4iK8EcnhjzDum6qoHkJLg==
Received: from MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:10:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 22:10:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:10:51 +0000
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
 <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v4 10/23] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
Thread-Topic: [PATCH v4 10/23] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
Thread-Index: AQHX2/8UcUfWqRR6hEqhcPDgZktvsawxJJWA
Date: Mon, 13 Dec 2021 22:10:51 +0000
Message-ID: <cf0eeb5f-3a60-eb38-83fd-809947ca2fb3@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-11-logang@deltatee.com>
In-Reply-To: <20211117215410.3695-11-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 425b5b38-6578-4954-3363-08d9be856d09
x-ms-traffictypediagnostic: MW2PR12MB2569:EE_|MW3PR12MB4347:EE_
x-microsoft-antispam-prvs: <MW2PR12MB2569536131B65E7BEABBB81AA3749@MW2PR12MB2569.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4FZOtpx0G+DIUkuvU7DEsi9YtECefJcH7N+2Z35sqH85v2VALfe6GkNxKyL/0YmLjBUSNBvP3qAmb+lUyH7LEDdcl92xO1Uzen05cpyVBLvtXwdkkMnbWH8BN3ueH+qpBlaUXro5CfXTeUcAbkGrdtCQAEketxf//vnWvqqGGoQZmn19eRRauSf1U8rRXDSNJu0J+6sytijvR1MnoX149YAgBmkIkgFxiyGKM+AVyNwIAvVAkXmwsingiqnkGaISZnURgWBPlXHcmbLZGemMsOzrWVRzg+EJZBPbv8cFgu84Meuoayyi5XGjo34NVCe9Xs1h8CEzpcAbKOH+PRxE/pN9TJMEfc5ww3tg5Km8abXg5ONidI+hdxEH1yhubA+xyFRYb+ZoortJNFwUtNAHJcasNYoled/zluDZtQvkGQlRLNuYl01qa9+xOcFvuHuqI+tyoCVtfteEPgLb2todFDXy9xMRYH7RCmGyocVIsf2kv12QPA+tyKydGs44+A+3HXeP+lnH0etGv4xk66IOX1em0VTfPqXqIHEqoIpj8VIibnJg/40tp3n2nD6/eoCMar/f7i6q5YQ6PKxZRttwHIcPDkIySYeeqDi1912Oj9sq8w1yTDgTNCmcI7Ayd4dvq4kOKmHk3RYHYDgqsNfBZ/yhDbQQBnn/7vD3CkThsbIZkl03y4ngaTR1w7wutJtbYzsLmpirwv8t3DVUcclPNqNcMDSJMo263yzdQRUHoUhX4iRLENe/3/PkUVmu+MPMc+oJWg5qGlF7nxUl8ouaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2569.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(122000001)(31696002)(6512007)(2906002)(76116006)(91956017)(4744005)(6486002)(86362001)(64756008)(66946007)(316002)(38070700005)(66556008)(54906003)(8676002)(36756003)(186003)(66446008)(66476007)(53546011)(8936002)(5660300002)(110136005)(7416002)(6506007)(2616005)(4326008)(71200400001)(508600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3lEbjlIRkNtOVFLU1ZiVlJ6U1lKem42MTJXODRFNWFIUDdzdS93TENzdlpN?=
 =?utf-8?B?bkR6YzJDYW1xQk1NU1BoeGhrT21WTFF6ejJ3ckpzMUM1SGRYaHpYVnpCZEo1?=
 =?utf-8?B?M0FWUHZNSis4bmt3a1hSbnpRdHRVSjBrWHR0azFMYWNtbll1cjgrMWVNYWxh?=
 =?utf-8?B?RFVkRTN1RkN1cG5qb0NoQmMxNmUzTEJnelF1WmZ4RlBQNTZHVFg1b0FkQkd1?=
 =?utf-8?B?Uk5Wb2pDRE9waFBpNHFBL0N5NGF1MzRPbFpiOE4vUVppSVJVMGs5REhLd3da?=
 =?utf-8?B?RnVCNnVDTHRISVJ0ak01UlhCTVNKUkdNZE1lcytUZXZSRnZ5SktGY0hBWUJ4?=
 =?utf-8?B?aXU3eVMzb2h2T1BrME05Zk5YdUFwaVRhbHJBSVd4cWc1NTg5OEVueTV6QkYv?=
 =?utf-8?B?a2RzaEpXSmk5ZitIUGJrNDVSYnBzQTQ5bDFvZHdWcHJNdUFweTRxUVE0MG51?=
 =?utf-8?B?WmlONUF6K0Q5cElNV1RLckplNmhBZ2JuYUtWc1YzRy9wVEdheExOQ0Z5dCtQ?=
 =?utf-8?B?SnNFNG1QSExXeDA3cVZldlJKa3FpYTBuakUxQzA3ZlJ5OWFMY3FoOVRsWDRj?=
 =?utf-8?B?TUx4cGpYUTJtME1zMzV0MlZZQXh1OTZnS2kxNkh0ZXVXei82cnpTcG1vUWkw?=
 =?utf-8?B?VlNLY1JmTFJBOVFpVEUyaktKR2VMMm5ERVJqYmtpbUFGQnBZclVlOGk1QkVS?=
 =?utf-8?B?cWpkNy9nWVFFR0RaUkR4UFREd1VrRndwYzJYeENldVFQZ2hLdjNMQ0VBM3Bn?=
 =?utf-8?B?TTRQSHUrTFhCeXFZUnZhd1lSOS9MYUpuZjF1OU9tOGtGT2lCL3BHVFY1elJy?=
 =?utf-8?B?M2J3cGlueWdBaTgxclNZZUVuOVZZNkhmQytWSGNxNlJWNmpHZmQ0eUszdkRX?=
 =?utf-8?B?ZmU1ZCtNMEZzSFBOd2ZoZ1VMdlhLaUFiRlN1SEs0bGlZbW5HdkszdmlJRkNr?=
 =?utf-8?B?d1FSMmZ2aTBMWGNjSTFrOWcrSVNDdk5MTUtSRmNqdG83RDVsK3V4WnpLTm5y?=
 =?utf-8?B?a0hIZkY4Zkd5SGxGQnVaU2JKZ3NIanYybitQTWJYT3FNblUreFF3UzhYSDdK?=
 =?utf-8?B?ancvS2lGOVRyWlJ5ZmNZUGgvckxNOTJBNXY0M0hMY0E5ODhUSGhkRXE3QlU0?=
 =?utf-8?B?WS8vRitTNm95MDhLdWJDNTQvVDlUM2JsYmNnVmE5VnFVTEl5dS93eDFWdXJo?=
 =?utf-8?B?WW5FRkx5d2hDWDhJMWFsUEV0NVJvUVBEK3JCTnk3T21IOEw4ODBCZUkwaUNZ?=
 =?utf-8?B?MkpheS9NMkY2MnA3ZER2VUJaT2VRV2VmcktmY3dXS1h0QnlZaTMzWmovbmo5?=
 =?utf-8?B?dnpPbVFHd1ZQYXl6TTdXRkhCcFR6QmN0aW5HWTBhd3F2NkJDS1RHcUZpZHVj?=
 =?utf-8?B?SDUwVGlDdmtTRmxKdFpsZDdZN3pQa3pCWk42bEV3bU51WnNwRm8xQlg0aWlI?=
 =?utf-8?B?ak0rOFNXVFZxUDBoeWN6U3ZydHIrVGErQ3V6ZS9WNTFEWTJ4ZE10cTdrdUdG?=
 =?utf-8?B?OHZWek5hdVZ5U0J6Mmp0djJkWkdhUUQ5R2h5TnFtV0g1OGxBejZyV012SVJ0?=
 =?utf-8?B?TXZRRmFCd1VNNEdzOXp0SnJudktIS0ZQTThvOFIwRmw1dUVYWjdtQlZHRS9I?=
 =?utf-8?B?QWIwK2NFYlA2VlhBS1VBamppTVpOaHZ5Y08vSGZ4cW50T29NcWJOMENvdGwv?=
 =?utf-8?B?OGFvbTU3Rm1UWTZNeWgzU25ldHBMZkE5U3B4Y1VEVHFYVDhmdERaQml0a2M0?=
 =?utf-8?B?cXo4QUNLWk5NRkRDVmVPMTEzaWpIN0NNcWpZVkRoZWZYWlFKUEdpMDV5NUoz?=
 =?utf-8?B?ZkxKVnlkNnc3ZlZJeFVtZStHT0piRVhCUDNyZkxlMVlIVjBjRkZ0RkRrbkVD?=
 =?utf-8?B?c0dCQzY2Zmk2V0t2WEkvVE9PK2N3eHlrQUQrQ3RScGNiQlZ2TE5jbnVYVlZ0?=
 =?utf-8?B?QUs2VkZTbnV2WUdzMStZbWxuREZUL09uZTRWUGsrN20rVlVKSjhpQzEyRTQy?=
 =?utf-8?B?V3JTTTczalZjR1lYZkVncWYvR0dJaDgzOEQ2YUxrWHk5R0wzdmtTT1AwbzJy?=
 =?utf-8?B?Qkl6K1c2WjZxOW8vQ1JXaFFqdWMxLzV0WW05bTVrNmQwUU1JMy9WdnhSdW5U?=
 =?utf-8?B?R0cxREsxSmRaR1Q0UytrTGdoaHg1SDJ6TFFoZ0svV0tCTGVWM0l2T3FWKzV4?=
 =?utf-8?Q?gRl9NnezgoTXUNS/agmbsoTryXt7RzBWKj6m5LUCCKu0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0549D3DA745D624B8D12108D8C49BBCC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425b5b38-6578-4954-3363-08d9be856d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:10:51.6074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTu9DQ1rOPk+yVjc5i2+rMv2/Lo4xwKxM3S8TyDq798+JC59XYyMgrNiJdr3daDYy2mG0xVRTLXrCieMGytxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_141056_963513_148B3E1E 
X-CRM114-Status: GOOD (  10.13  )
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

T24gMTEvMTcvMjEgMTo1MyBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOg0KPiBJbnRyb2R1Y2Ug
YSBzdXBwb3J0c19wY2lfcDJwZG1hKCkgb3BlcmF0aW9uIGluIG52bWVfY3RybF9vcHMgdG8NCj4g
cmVwbGFjZSB0aGUgZml4ZWQgTlZNRV9GX1BDSV9QMlBETUEgZmxhZyBzdWNoIHRoYXQgdGhlIGRt
YV9tYXBfb3BzDQo+IGZsYWdzIGNhbiBiZSBjaGVja2VkIGZvciBQQ0kgUDJQRE1BIHN1cHBvcnQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5j
b20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K

