Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA75C67871
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZa79dephRHEJYjYTFtMQpnvTcmhwqiQhNVYKG1WjNA=; b=kyEa/L3D3iDMYzohNL/iqitM5P
	D5q9njWu6qARY51oslhmKz2LVWkYFnyb1rAj7jNSVuzqP8N0naZfjB61RFuDV0UBVo4cMXpjneEu8
	1XHgjTZOP0Bc7VcqwoLl15xsHZU/G1oGeEOG87fAuqHZ3bQb831vha8fXvSZpct6LSppU38dgm3iY
	WjlKyRkjhVTQgGw/MSlQaMfzFTls3+683KfctGessl0Dt2HX0IFxKudNO/De9b2hYd8emtDMuNi31
	cfUsuQntNRJ1oijtawFWtMUIUfswbkkYAUDobvK16k4cgdpY64lDRStS9TSLBK9YbD96/kz4m4UUD
	GMvYr/yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on8PE-003Upm-I3; Tue, 25 Oct 2022 01:07:00 +0000
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com ([40.107.223.85] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on8PB-003Uol-NM
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 01:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIeNtvrYHygoG7D03tu/XAe4Tt/qls1EHkzuS35tloH8BhoXL2J4b9s/6YzuGBVYjiB6BR9WDCCZ85uF4lSvcijl/ecdYAWQNQtRjLd5Qf3aPHHNMPJxggqrpHpMrFWX8E5htBHNzOaKm1aQw6tX15aedTmpzS4wQrk0day9hKdEAxzhjcamVe18JO7BkDO6WMFWO2aUuLYJEK43q3ZyvT7bjXI7x5nG+6xtMtXdMrpROKw2467k5qBP5AaUlfn/tePkK0xLj69YH7S1vNR2wC4ir1qnjXk75XKuM2E2LaPs9V21NaRD8vssY4rUP+G1itWXpiZu8GMLmqMglO774A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZa79dephRHEJYjYTFtMQpnvTcmhwqiQhNVYKG1WjNA=;
 b=j8pcb58f+8zp005YRZlrFtX0FT3L0zKlsfvRtw0mmLPIEx8XMetHVsUKRJhP9JwQvpcRGZqHP9EWhk3zeUOF6uMGEPav54IE4wnm4lzo1JwG+FJBVXqTfiWfEXMRnvweX8manXt6wUP/CiIj3J2ZlhckHYvWViF25WKRbnmzH4DCwrYBC+nthPlV/z1hnlkTT0IYwkGyhF15lxWf97ZpZr4rhJ2aLAqPnqt9Of3FliZvFSptNzUY67RGypY1ln3SpFJudHKwD4CBmP7wNqs55BOnHfSU7+kWFofDmnsyws+HvF1IWtk5psUeWqXcsJ+vQ22MYac0Cr70dN8GrAnCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZa79dephRHEJYjYTFtMQpnvTcmhwqiQhNVYKG1WjNA=;
 b=RSTO1RxAr+d9juO1cxwbEtkzQi2zzlu53dj4DI5rl9k0gtYIS0ZmV/vSpbBeCHxWZtGgDUAv/756cX7JUuEc/pqMOdRkzEY7QREn3mNgMC0PBtJzQTDK2BEFiFwj1DhdKtyejXdyGz5DziDDum4An9YAEYP1qMmtBfDr4XU3Wk49NFXqDfd027bPJj4hWlgqkSNB1lUZxVLyrbmyd+VfYeKejDfUFE2kKPg1yBMDLOuAWcdGwb78R871lvUmm7SnsMsLRFikiSU2v4McxEaUSHrKfGC0c94xEbOuwEBkP9Lvrfq0IvFKv4WDW70s1uXtLinUNBuU68NK/FUieLhNNA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 01:06:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:06:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>, John Hubbard <jhubbard@nvidia.com>, Don Dutile
	<ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>, Jason
 Ekstrand <jason@jlekstrand.net>, Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>, Martin
 Oliveira <martin.oliveira@eideticom.com>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, Ralph Campbell <rcampbell@nvidia.com>, Stephen
 Bates <sbates@raithlin.com>
Subject: Re: [PATCH v11 1/9] mm: allow multiple error returns in
 try_grab_page()
Thread-Topic: [PATCH v11 1/9] mm: allow multiple error returns in
 try_grab_page()
Thread-Index: AQHY5XRhl0xU4gKBX0OUrinPZx6EA64eUTWA
Date: Tue, 25 Oct 2022 01:06:50 +0000
Message-ID: <32dc3dd6-5d44-e1b0-b716-4ea52187fb4f@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-2-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-2-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5947:EE_
x-ms-office365-filtering-correlation-id: 50ef498e-43a5-47c4-dc52-08dab6253288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  FA4mvBU47WYnrCY5xfjIevswboq1rmEs0Fa5Psl8gGPrbKO1Ui4os4R+Fr/0bHD4e3Ow+9O689WYeCTF32K+sCfkP98UBeY+ie2faNKNBlRlZ5QYpkrmIyR0aMQWmM4KFuppOjsejIlDoJnsaKRNNn/rhRSy8V/d85kQWS3DfUsAALm/tk/LKIRxi0/oDZPk7dFlBSYia5YqiYFlkeJmuVsDX8vJ9APWGSWRBt3W8SXTfh4j5h0tmoplg4WxI5UxO1NlOPHUMaV1LxrcjElftTRY5unnQGbTwRLtC6u+PJZUMx3lZTaD2Qt3YGi56KgI+PHkA15bDoIokY+QUchj1EPzOP0PVeSgi61woWtzkcNm5fSrYOT/XVvXpuMxuK2saWx8DEZdtlc5eFwDi3syj7LVKAtzV3/a5HsYssahAGUggnPbyLMjBn2wenfeXvKPD8h2jTJVUcC9kI8pwwtEq5HF4br+D+oiyuYUgw1uaQF0K65jQIzNtzI6PZxGHhXNnV30Wgt67rvSaZH0w58l+IWuwUVTNWvRKTYdgcB8J/PlVjGl29Hy4Oeq+fzfqQf258z3UCbhESEmj55Id7j5Vvz8rggwLplSoboiyLO11egoNXYDn2Z5F/0FwwXxyehKtGnNa3+ePVrUWhZBK4Y5jsGkzl8Wu6ZO6e5LF6P/5Xr+hq4Jdcql1PWjOSZy9/qFz/Dt2Aul+PMWT7jAylxs4u4QNGO10pLPpMOGyPp2JFfhoHVD4TSmV7MR3lLWeu/lBkdEDXWCPf/SlCqQ4qngo493TyNW3ZXUmU/kOAaQH9CWmZGm4hUpRl3Jbiao9RozAZ9bFCvGHQ2a2/CJaEFz7w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(41300700001)(7416002)(91956017)(31696002)(66556008)(8676002)(6506007)(66476007)(66446008)(36756003)(86362001)(38100700002)(5660300002)(76116006)(66946007)(2906002)(4326008)(6486002)(83380400001)(8936002)(64756008)(6512007)(38070700005)(122000001)(186003)(2616005)(54906003)(71200400001)(316002)(478600001)(110136005)(53546011)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?U1luZnllbVpyWGM1MWxRMWRWVzZ2SE5jUWU4ZTZ6THo3eHJzMFhsbUt5WnFG?=
 =?utf-8?B?RFZiejhKTFg2SlB6WFZ5bUs2Sk1TV2paczBhQldOdGN6N0ZlajhFM2REVEdj?=
 =?utf-8?B?RnR2UFFzdXpadEFrUmIzMVNtT0tOdlNLcGlaS0R0bTNsRW1yM0YvVmlPKzdS?=
 =?utf-8?B?M3hzcXFGUHRZQk1WalVZb3NSV1M0UDlDN3BqdGU5cGZCM2dlMnpieXVkM2JX?=
 =?utf-8?B?ZW4yQUt1bFN6K0UwTlp0T3p2VnJwOHFHdFhZMHUrYTM5Uzc3MUFCcXNXUnZk?=
 =?utf-8?B?TWVsZkowRmRpVmx5Y3VkZkd0RWhueFNiQ3F5VEJXYXFWQ0VyMFZFdXNYMEZt?=
 =?utf-8?B?SGZCcWZ3RWlMckV0YlpiSEM2RHBqdVpCb01vY2JieUlFTTB2QXZtU3RWYjFJ?=
 =?utf-8?B?NnBJOWM3YlRjakIzdGZQRmNFWElUdVJoSldScXZ5ekVQdmw5VDQ4biswQ2sr?=
 =?utf-8?B?NWNDaXBqdW9KYjg2OTc4TmtNdUs2cjc2dkM5TmR6Tlo2Tzd5THpiOEwwV2VX?=
 =?utf-8?B?cWtkWDBlVEFPSUdxTTFzNFVRWm5YSVJnbW1jNjZvSWNaMlF1UTg3aXlBYlVZ?=
 =?utf-8?B?NVF4STBGOXRFWEtRTjg1TG1tZjFXZUpLbmk5WGJ5a2wraFlUdnlFUkdPdTcr?=
 =?utf-8?B?Zlo4bjgwTGZxK2dIV3lwQXpRYXVJdklxc3NEL0N0NXNaaUhDeEtzQW93WGNJ?=
 =?utf-8?B?TE9jYkV3YVV6WDVPOVFMTkNOUFZoMFR5enI2RjA2ZjJCY2FsY1hnRUtPU3dz?=
 =?utf-8?B?aGJTOWIzTEM4T2lSaUFkS1pZUmZLMkllNDRHZTluMTJUOXpabEpNSjBIZ1Z1?=
 =?utf-8?B?Ry9rSDZKZmI3NWNmM1dML0NUak1LVGRlM2ZPckxoWUpxdDFGRGxualVWZm1Q?=
 =?utf-8?B?b1kyckNqUG1sdkNHNDZzRTJ2bk9JWXI2R25rTWlYQS9JMUZVZVFSWUVJNlJE?=
 =?utf-8?B?RzdleTJhN2l4QnBpV2l5OEwyK2pBdm01L28vZ3NkZ2RnbC9MUjVYUG5yOXV0?=
 =?utf-8?B?eFU0LzBXWGdnLzlkYWcrQk52M1RvT1pOUTJWRGhwNjFVdlpKbjZGYVo1eHI1?=
 =?utf-8?B?M01kV240T3VSMElrejZYdjJPYVAza3hrY3pVOHpJWWpDYkxNT2pDTnJjZkdv?=
 =?utf-8?B?ZCtkZFdyNGxHV2FSTWdjVkxITTdIVTRVZjI0bU9Obmw1M0FCTFkyYjhibEhy?=
 =?utf-8?B?RHhTQ3podXovSURnTFRWT09LcFRzV3hKSnJURDhyZHhmbTZhS0FWR3ZsVWdC?=
 =?utf-8?B?d3RBYUV2c0JqQTlndlcrU1hZNWk3VmZFb1MzU1BmbW9LUnd0Z3lqNXd3SUhS?=
 =?utf-8?B?cEdqQndlUnFkQmZlMDBkMnJjR0RNV3RmdDBFZ1Q0aTlNbEZQR3pDNEYwMDky?=
 =?utf-8?B?eFJqQ1p6bTdYZ21Qb3ZOS3diR1lVdSthREVjWlpnaE5DYWFpbmk1WjBmUmdH?=
 =?utf-8?B?K0NKWDI0QURWY1U2RnQxbnhhTk0rekVPYStEeThJcDNhRGx0dkNTZGlJOWFa?=
 =?utf-8?B?eTB0R3Rkdm02azM5SWp0OW8yR2lvMGdOay9iN3lWVXQ5TnRyOVZLTS9YZm1X?=
 =?utf-8?B?R2xQODh6TXllSmZWc01TSllkV1g3QnRKQXFIcHJVQkVFWjlRVnFleHhVa2Q1?=
 =?utf-8?B?NnJHc1pJUlFIZTcrZTBUR2hjYzVzU0lTSlJhdHM4V2NCYzBmNnF5MlhYbzJv?=
 =?utf-8?B?dVZIM2MxRWlpZmlOaWFWTTdwazJWc1o2V1BpMmNTTDN4NWYwUk51ZXFPZlZy?=
 =?utf-8?B?VDI3LzVqSzY1aXFMcjkyY1lmZ21yZ3lZRkNucVo3b2tsNmpDdHlUcHMyd1A4?=
 =?utf-8?B?d1dVZ1dMTkw4RDkzSTVibjFldkh6Q0VXMDNqbTZDQy9qR3RSNlpYN25BRFpK?=
 =?utf-8?B?Rk1TWEttZEVVd1pFbVMwa2xON3M1VCtjcUh5eXVEWVJ4VmE4YnZkT3BoVURW?=
 =?utf-8?B?Y0dqNFRNcDBvSEVpTE51NWczZUJoMmVtUTZkZTVmenZveDFvc0RzWTVYN3Ex?=
 =?utf-8?B?cFVxK2ozSEFkQUk5NkNBNDB4T0lIZWMybmdWK01LUWpJYzN0N1llVnRBc0Nw?=
 =?utf-8?B?WWhsRTJ1T2szZmlsWUxqTVk4bjl4OGhBVHZhM3h0UVNKMmdhdUVYR3g5QUho?=
 =?utf-8?B?dVBVN0JYdGpYZGYyL3ZDTkY2eitmckROcWRrbFUyTW40ajhsYlRZL1ZYaE1W?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B950645C17B8BA44ABA979A92D213AF1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ef498e-43a5-47c4-dc52-08dab6253288
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:06:50.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvmjnLIcLRGSVdbJ4ohlr/+tLelTBcDQotYKopmCoCWlNyqEArtq4FZICIUpwcrKd8eBM0zwoWEmHWfzA5+FBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_180657_781750_0A3FD1E4 
X-CRM114-Status: GOOD (  11.25  )
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

T24gMTAvMjEvMjIgMTA6NDEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToNCj4gSW4gb3JkZXIgdG8g
YWRkIGNoZWNrcyBmb3IgUDJQRE1BIG1lbW9yeSBpbnRvIHRyeV9ncmFiX3BhZ2UoKSwgZXhwYW5k
DQo+IHRoZSBlcnJvciByZXR1cm4gZnJvbSBhIGJvb2wgdG8gYW4gaW50L2Vycm9yIGNvZGUuIFVw
ZGF0ZSBhbGwgdGhlDQo+IGNhbGxzaXRlcyBoYW5kbGUgY2hhbmdlIGluIHVzYWdlLg0KPiANCj4g
QWxzbyByZW1vdmUgdGhlIFdBUk5fT05fT05DRSgpIGNhbGwgYXQgdGhlIGNhbGxzaXRlcyBzZWVp
bmcgdGhlcmUNCj4gYWxyZWFkeSBpcyBhIFdBUk5fT05fT05DRSgpIGluc2lkZSB0aGUgZnVuY3Rp
b24gaWYgaXQgZmFpbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxv
Z2FuZ0BkZWx0YXRlZS5jb20+DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0K

