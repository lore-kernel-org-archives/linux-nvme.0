Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43746C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPpFFaazgr5le0oyVRUnpwCHnp5XJJyhMT5G5mZKWc4=; b=HspHTBOlhxNqWLQsqzHIzz6nXt
	k2oV/VK/h4pSivneY9VUaJbFEDU8jUhLHqln/QW4oCyYSZt4FhkiOa/0sDKn7q9rKiRFMXT4SThNx
	S2/eXEPaPTNlDPbpEKHHQa+AaLDdi4I+2YNtYiVtttLVkEcBukniYytIiS/f3hTM2V9M1FRTSIFQZ
	qCz/m8pfAvQec3FXFkdWz/V28jcpk6cDC0F7DGf9IlKMpGHbrE0zh7Jl96C42kiTyb0k3sROiKRac
	7oQSZ584Qiq9yrQjmsETHYBDxmdUHYc1YNklYTcZUHuzgTe99r9EsCCd71lQMMx75NvPoz9t+W+y+
	40PjW6mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCzm0-00EhDk-He; Thu, 27 Jan 2022 08:04:52 +0000
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCzlx-00EhD5-NP
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 08:04:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD/gHvtzV3DxFpJBZk8HZYDTLTH/XFGs9XPc9keFYu6Er2oc+Vue2nwsAiwntjZ31WOKy4DhWtSX+gwCE2AJF+OTlojOPJI7D9vaGcmqfYQ2P3/SugEW5960Pij8ZKH6GmN/yoQ6+Lw2xWor6lB6LSbj9mMdzh+N2tD2Z60d/nnkdN/9gBW+3l0dmeOOOJgd8mBzW+vgNG9+FylBIBf5i91iiIavUtT4EnbWkz+JdFly6+dyOXL1klmn99Sw3++rUxoT+VSCFa0ypNh9leREUMAh4klPqxjSaNKQbNoFEBNa4/tZZOY9Qvvi+xUDf12SBlKcVyQBC1ZGTsdPS43cMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPpFFaazgr5le0oyVRUnpwCHnp5XJJyhMT5G5mZKWc4=;
 b=KRDT6e5VIbNUIgz2qZAakQ1uqDQW0+GBwp/+FuVNmP5Uklv2my/TqUoEh1o5lK+/UuD3s+fe9nthXVokUEEnmGPxL7pLY6K07pnAnY7tQnl0vBgFueeVJAaZodNPW2lT/r5+PlmP/Umr0PrO9GhpTNNfyc720IEpKFIunYkvqaJUqQgm+xeOLufRzJpsb7HNG44glbXoYUj9XvjEPWswdi2Bu2kFYX2+aqY/qjT+7t6cYRZ0EN8M7gbBMuMXuhmlUAR28XAJ9t5qcYnDqfGhTegaUBPQd5fIkQ9SPL7jnjoYhxPSIZkyUmlS6lfe66mwr0AYDcUWofkMYLsQljs6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPpFFaazgr5le0oyVRUnpwCHnp5XJJyhMT5G5mZKWc4=;
 b=rNAPXyeK6VPgxbLNGFCZ5NRnMlwEOR0JadnG8exlCyP0yD0PmjMhvookkO0Zmyjba4B9+yeArSQMMAJgCa1KEhewngj0xuhqLZmwx0b10A/f7USE4N25eQrPdC2pqIjhvPdBALNUNWDs3lqRykbY/sy1/4jw3WURgvi6T6nW9gxv3EtlVbi3JrO7PvfR1edy2SdahDLkaFnF4isVsEPU7fB+9+bjagPFk7LGSHYQxKszSNoJCsQgY7MxCjNLdHr4BWiVbuxaEVMzvbItJJ8roZij8KA3gMafIagVvp5URFDmmWSDjAiMRWhO2/W9mGhd2N9KKRhY76+2X2NLUUMSLA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB3947.namprd12.prod.outlook.com (2603:10b6:5:148::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 08:04:45 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::7948:75c7:913d:cffc]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::7948:75c7:913d:cffc%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 08:04:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH 0/3] nvmet: add buffered_io support for bdev-ns
Thread-Topic: [PATCH 0/3] nvmet: add buffered_io support for bdev-ns
Thread-Index: AQHYDQUddRisECpbZEqYGsT/RGt2Wax1iUSAgAEApgCAAAUjgA==
Date: Thu, 27 Jan 2022 08:04:45 +0000
Message-ID: <0facd607-8345-432c-4105-6fd84bb0dcd2@nvidia.com>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
 <20220126162747.GB31431@lst.de>
 <47264e99-cb1a-8eef-b49b-140b4de51150@nvidia.com>
In-Reply-To: <47264e99-cb1a-8eef-b49b-140b4de51150@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 818cf640-9b49-4890-30de-08d9e16baea9
x-ms-traffictypediagnostic: DM6PR12MB3947:EE_
x-microsoft-antispam-prvs: <DM6PR12MB39479FF00AF66145361219ACA3219@DM6PR12MB3947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhsz/I/kjuuyBn/4orNKxtV/k7Tms0jnN9FiqhW95C5SKbOJ6peuP37UB2Efb23dFjCIv6WrgYGoY7chiHcaNOBAzrUZWgHfMhtkXMSbWkxOkirqnS8b9hOQTzzD1Ne3+a09ki87C2NkOKiKZJHV75xuRvc3HNbAY18vlTGFb7cN5xsJ5VORoHZiGCnycjNo1jhKmqTB5zw9M5b5QeGb3banyS7ytpqUMszOc4eBFzWlXqWwb6nOVCbRKaD0/B9S6AsE8Kgcf3+ieUjrziQ38hgJgy84fA10ZZdoQomEcXUlYxEK6OghN+QzYq9j20yTFSNyWWcJO5iEP5NEnoHmNOnHyGmd0tTUXbLPpbVTnX2O+/G0PKlg1CShNPJmL2Plfnz/vvu5iVXp0RynvlZrC7bvyQQxBbNtJTxutlw6kuWidcy24HjLpbxL9BdxXB+8jqnpCdZqk/XjU4gF3er4fkEWRv+sGkwpFbHmZ+kh0G+GqX8aDw5xn+2hcGoIdLdCis0hP91HOqqsmgLF81CA9ZAmr9e4HTz5e95MCCne3V4t7fG6gJFwsc2zL0m7AAxKqvIZkEDXg/Gas21AbuBF6t1ersr7P0al925lj7ak9u8bDZWBxQZ6gRK+H8cIGjTvojy4BmU01ISHSkJdQFij1/ay6Hb6XoMjwBDPp0ZtWZFAmqL0x4HZPTRrfsy4lPwAQ7m25/kOVbgtqVhU3VS0zAGMKnQZfJ0tCJIAgQ6i1/iibahoGIMLX7923KB6tWFY8MbICkRN7h+DevtSx3rZcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(2616005)(86362001)(38100700002)(6506007)(54906003)(508600001)(5660300002)(31696002)(316002)(2906002)(31686004)(186003)(6916009)(83380400001)(6512007)(66446008)(91956017)(66476007)(66556008)(76116006)(4326008)(8676002)(8936002)(66946007)(64756008)(122000001)(53546011)(71200400001)(6486002)(38070700005)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTJaQUdycC9uVUs1MGJyOEd4TVZUSEpHWmpMTW1LeG5FbEwzYW9Xc1ZUQVIv?=
 =?utf-8?B?OWczTk96MmMwS2Q2clczVzlYUVI2cGgxbDFOQTk4UDdzY2k0RXBUcjZtY2xS?=
 =?utf-8?B?cWxDQ01DQVV4YmROZmxRcm5INXhvcjJtWUMvWXExYk1TRXZ6QTZCWnM2cVpN?=
 =?utf-8?B?Tlh5U0RLdkNxR09ucUpUUzlBVFVIMFZ4OXVxM0IxUTZBUDhrTVJmc1N0WThz?=
 =?utf-8?B?d3AxN1BxUzJEdGR5cThtSWhRaGpPK2NhbjJQekZ3VWR5YzZ5U1VqR2s5SThY?=
 =?utf-8?B?YkYxazNUN3RrOUw3SHd5R3Y0NWtWSE5scGl2TDRiMVpvVzVPZmRFbWhCRVdH?=
 =?utf-8?B?R2N0MnBVRng3QmZjditYS0Z5aU45OFkxaGt3MnpQejEvSlIrN0NxMzVaQjJk?=
 =?utf-8?B?NStMM3I2U3VLNTNtay9KcVJlSUhRQk5ZYzM0bGgwb2dsWHd4ZlpQcndJWUdB?=
 =?utf-8?B?Q2lpUGZYWVV2alFpc2F3T1Y1ME9qdGREN2c2cHpKcmczaGwxbmFDeDlkS2RD?=
 =?utf-8?B?K3VqTkpVQ1FIaTJrRTZPbTU4VG41U3FxZldBVi8wcnRKdi9HbjExTlQ0Z3RL?=
 =?utf-8?B?VHVNbFZVREU1K2QwbWQ3NUQxdjFGbzlrc1Z6QVZoNW9ONkUxY2pNWG5SZDFx?=
 =?utf-8?B?TStVZEVvVmE5UTJUdGpUWjBtWXFWK2w3N1FVSDVuNmZNLy9OKzNJQmR4cUlI?=
 =?utf-8?B?RE1UdDlXdDBySWFUNDlVTFR6UkFucE9ZdEY3VUlQd0tXQUlOVTByQjNXUDhF?=
 =?utf-8?B?OVFBMG1PSVloeVdPRG1nRmdMV3Z1bXpSejBNUHlPbENFWnBoWnhzLyt3bHMz?=
 =?utf-8?B?NVNjRWdsaUZ1WVdVQnQ4NUJKMjN6ME90aWUzc2NpY0xtcHNJcFQ0ZHZUS09y?=
 =?utf-8?B?U0RqcUthVWVCYVJGUnROSVUybXcvQnM4bVVMbysvc2lOcTVMM2h5RVNsdzc5?=
 =?utf-8?B?bHA2YmgzTjlOMndIaDhzMXpUMVQrZlA0eVRaN2M3cEFjS3A1eUR0S2gvbzZT?=
 =?utf-8?B?OGFRVWx3REZRdG1OQTNSK1VKRE9OTjhGSHFyZHA4a2FLMUNYSHM5RVZPblVL?=
 =?utf-8?B?RENHWEQ0YzFQY3JoOHo0YlRtakxrR3VKZnZtRnBJV2xXVUg2UXYvNTh3eTFk?=
 =?utf-8?B?SVJCWFBkVCtXUVdnUkRBdHNDTjAzMml1eXNJZmlZaWhIcTRDeVNKakxIZW9B?=
 =?utf-8?B?WVZLS2N1cHduRk13Z1hBdm1hUFRMaHhNak9lTGNTdGUwZHdLY1ZETUl0cncw?=
 =?utf-8?B?UWdmQ0tjS2JRVUJWOUpOaHdiS1l6S1ZES2lnYUpJMjdtWkhpSHJIWTZJRmNr?=
 =?utf-8?B?MmdZV09WUHh0SzF0dFQ3RXh2bFUxcjN5UWdDS1lUeTFVZ2huQzAxbFI3eUR1?=
 =?utf-8?B?UlFmWHI3S3U1dWY1MlhHVnpNTjc1UURWMXJEN045V1NqMXNtVkZYYXNDcDRF?=
 =?utf-8?B?UXgyNCtoTnBkOTRQdlR6Vm9taFBrMFM1MWgxNkJDSW5tcURaSUIwVWJKVzVC?=
 =?utf-8?B?WWc0MDRuNmZVMFYvcjNpdmNDQ3N1MUxpTjRsNDJmYXhLZGVtb3FOUHpTb3Bs?=
 =?utf-8?B?djNCOWhSRGNmME5CcVpRVkVGRFhFb3c5TG0yd0x5cmI0Wks4bmZ2bG8yeExh?=
 =?utf-8?B?bGFoK3Q3bTJIejk3UC9odnFJQ3poMXg3Z0ZoS2k3c1IweWxFU2EvVmZBTkdT?=
 =?utf-8?B?WGowT25kNWZkbG9malA5MC9Ybm4wQkVJamtNOFBJM2czMSswMEwySTlpN1oy?=
 =?utf-8?B?dzNseDNJQlZ1TlA5cE01RExvNWRza1VFRUJIZlV4SXhCMU9TS1F4UU5mNS9n?=
 =?utf-8?B?WU8vbFNmbGZMb0NkT2t0bUpMVG9QdVczMFpya202dU1xS05PcU05ZG9mN3hq?=
 =?utf-8?B?bDl2SjFVbzV0Q1VJcHdFVWN4b2lmVE1xcmlybEhhREpKL01xMUFmbHA0R25a?=
 =?utf-8?B?UTcxVDdnL2l1RlcvZGwxWVdmL1dCT01tWjJrcFJTNzJSd0hmbXlEUjQ4Z2l6?=
 =?utf-8?B?cWk5d3NHaE5BQkY0NkErSG5COEE3T3pKaENqbHhiMlNROHpueW5HRHhtS2Ns?=
 =?utf-8?B?NXBiaGg3cGtERVp6NWcwMmU0R3pYRzNLcHorREp1MEJtUUhTbEVGK3pZY3RB?=
 =?utf-8?B?Q2dFU3gvV2pzVVNzeTJuSXQrQjRSaU5aOW5ONHhVSEZvSU82MlB4QzJITFJF?=
 =?utf-8?Q?/Vvy1MZ696jCnNMF34spB1fgjBnKwaCPo+jkLp+gS8VK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8688299E47443449E95231090FA2D2C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818cf640-9b49-4890-30de-08d9e16baea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 08:04:45.6928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+sqeOzK2TFhi5AubyvCd1tMJ4N+lC5OMoKAvIis++xTqtQRkBRPv75kLTr18HnUkNP7rFyLqy+z4BxrZeBxtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_000449_813660_268B17AD 
X-CRM114-Status: GOOD (  17.48  )
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

T24gMS8yNi8yMiAxMTo0NiBQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBDaHJpc3Rv
cGgsDQo+IA0KPiBPbiAxLzI2LzIyIDg6MjcgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0K
Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4+DQo+Pg0KPj4gU2hvdWxkbid0IHNvbWV0aGluZyBsaWtlIHRoZSBwYXRjaCBiZWxvdyBi
ZSBhbGwgd2UgbmVlZCB0byB1c2UNCj4+IGJ1ZmZlcmVkIEkvTyBvbiBhIGJsb2NrIGRldmljZT8N
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jIGIv
ZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jDQo+PiBpbmRleCA3MGNhOWRmYzE3NzFh
Li43ZDlkYTJmNzdiODNhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9pby1j
bWQtYmRldi5jDQo+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMNCj4+
IEBAIC03Niw2ICs3NiwxMCBAQCBpbnQgbnZtZXRfYmRldl9uc19lbmFibGUoc3RydWN0IG52bWV0
X25zICpucykNCj4+ICAgIHsNCj4+ICAgICAgICAgICBpbnQgcmV0Ow0KPj4NCj4+ICsgICAgICAg
LyogZm9yY2UgZmFsbGJhY2sgdG8gdGhlIGZpbGUgYmFja2VuZCBmb3IgYnVmZmVyZWQgSS9PIG1v
ZGUgKi8NCj4+ICsgICAgICAgaWYgKG5zLT5idWZmZXJlZF9pbykNCj4+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT1RCTEs7DQo+PiArDQo+PiAgICAgICAgICAgbnMtPmJkZXYgPSBibGtkZXZf
Z2V0X2J5X3BhdGgobnMtPmRldmljZV9wYXRoLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICBGTU9ERV9SRUFEIHwgRk1PREVfV1JJVEUsIE5VTEwpOw0KPj4gICAgICAgICAgIGlmIChJU19F
UlIobnMtPmJkZXYpKSB7DQo+Pg0KPiANCj4gVGhpcyBpcyBleGFjdGx5IGhvdyBJIHN0YXJlZCB0
aGlzIHBhdGNoLXNlcmllcywgYnV0IGFib3ZlIGRvZXNuJ3QNCj4gd29yayBzaW5jZSBpdCBlcnJv
cnMgb3V0IGluIHRoZSBudm1lX2lkZW50aWZ5X25zKCkgZHVlIHRvIG5jYXAgdmFsdWUNCj4gc2V0
IHRvIDAgKHNldCBmcm9tIG5zLT5zaXplIGluIGlkLW5zIGFkbWluIG9uIHRhcmdldCBzaWRlKSBz
ZWUgWzFdLA0KPiBzaW5jZSBucy0+c2l6ZSB2YWx1ZSB3ZSBnZXQgaXMgMCwgdGhhdCBpcyBzZXQg
dXNpbmcgY2FsbCB0bw0KPiB2ZnNfZ2V0YXR0cihTVEFUWF9TSVpFKSBpbiB0aGUgbnZtZXRfZmls
ZV9uc19yZXZhbGlkYXRlKCkNCj4gZm9yIGZpbGUgYmFja2VuZC4NCj4gDQo+IA0KDQpBbHNvLCBJ
IGJlbGlldmUgd2UgbmVlZCB0byBtYWtlIHN1cmUgbnMtPmRldmljZV9wYXRoIGlzIGJsb2NrIGRl
dmljZQ0KdHlwZSB3aXRoIHZmc19nZXRhdHRyKFNUQVRYX01PREUpLg0KDQoNCg==

