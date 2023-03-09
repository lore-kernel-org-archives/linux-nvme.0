Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C30C64EC4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 01:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HPHdF6kj2X7hKMHrofHxExNT6RvgEhdCxPczpOrGirA=; b=q7L2lkZjzRRAYEheu62jFM349l
	Ez9NLgy5SsBUhk23spD9qfGXqMYFBnhvvnjf+89DdzduRft5PqwCbPPjLaJALpb47im/XBmrgoKsv
	kivb2+yynxx50uXswG1+o2L4G34a2j72zvJENtgqqks0bToZkSGCXjFeNpnebteVyou9LncWZriTw
	zcBnv3yHaw79nPpA4nNPtXxVBdNpTpk+cWfIOuDnlJXkuKvIUtp0Mw3UOgyyIxdGFMZfsjHghBTo7
	vZZo1qhuCq++OxE2ZKjRMFF2Ui2ZTNAlGfIK7d/awj2/szlh90/spEo5b+KMXlpzQlFot3qSkhTgx
	5whJ3ikA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pa5MN-007Ric-OL; Thu, 09 Mar 2023 01:46:23 +0000
Received: from mail-bn7nam10on20624.outbound.protection.outlook.com ([2a01:111:f400:7e8a::624] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pa5MD-007RgL-BS
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 01:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk3hReeJx12Xqg2MrD3GZVG2QjqOy7sPpg51hNMXh1Xa8jksKQ4vdYT+1/wh8u/lFRVl+nQFVlC4Tj8Ika9/zDUyfONTExA25P9c5IsiddEaIEfVispd6CtCOXch7LQv/gq7sD08Rx6+7vE35mzKHc691uD11JaVDEEqz/wK+trkpBqG8aba6hhNTd1gB3ZBl77wwYDVnkH2BXJqStTkG3Ak6t2paNnPfApgP7KW/nMPq4KLI5Puh8Ww368wCuTAJxJKTSkSOY1dX2n0wzImtHn+ipnS/H35DXD2Jbz5tNU3JVavXuQsUNcoRUNYhcOeuVgemYbGCTnYDqvKvfC58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPHdF6kj2X7hKMHrofHxExNT6RvgEhdCxPczpOrGirA=;
 b=jDqbIhGnu3pne4sybJ1dLATBnN2OhxELjFO0Uu8+hk42PQ2Ta1HdV9r1zlchYNUqf4Z1xgjzALHkHRiqnHjA6y2jTUiCn8itvuNjnl6NWjzjrLCQvCUTMUAsG8H7z3wu8ES++NXQ+YUkj2ZHHYiWemHCOe2g905qLZsdFmhEA3tFk0UdtBXnprg0zb/OihVa9rPBe2zY4cDrY7U7Ck7oJKCQlYw3luaJwqDx/olrcgQmlga9gTa5upesFR3HZKJTQI+dSs8SN1/+SCB9Ft0b7sKWU6kUgY24S731w4C4xuaJtG0uLvrlEpS5s96TqjqQ3jPw6xRfp/NcGk1F5boyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPHdF6kj2X7hKMHrofHxExNT6RvgEhdCxPczpOrGirA=;
 b=Om+vlsUpLWQmuYnUObs7YlOQbjFXa2tEmXvZHMho4Ktr0KJld7QL4pfRlDnJFROSNbX13jw1SXnBE+qLdmuVbMfmlur61HnyRfjl3StGg6mHsqqjpjlj0XFoHEanuWOusMVua+a8lkRlz4BOOtLSVWWfKCCtLV4Ji6FatRKrasjPcOapZ1XKusD0eWtfaw0/rQCOMkugh0ziGlAcIQYdL8b/u0kHovmzeBc2BSkewGpWBypDRVxoT0xgYwstN3iaJrZ/rds6FuRJ7j4ynIXNTqUC/789ua0s/pHDXXR4xhtUGk2hk6O2mj/b/Pb86K9fLvMO130B/IpOHZJIsPn8dQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 01:46:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 01:46:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@fb.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Akinobu Mita <akinobu.mita@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: print correct opcode on timeout and error
 handling
Thread-Topic: [PATCH] nvme-tcp: print correct opcode on timeout and error
 handling
Thread-Index: AQHZURI3wtfLFMkIQkW0lpUmsl9Yya7wufWAgADVqoCAAAHEAIAAHk2A
Date: Thu, 9 Mar 2023 01:46:08 +0000
Message-ID: <216fc76f-e101-698f-e35f-f24139e038ca@nvidia.com>
References: <20230307163045.5882-1-akinobu.mita@gmail.com>
 <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
 <1e81d4f4-6b3a-ab7e-e81f-dd0af6590a50@nvidia.com>
 <ZAkg9J+Br3EF2oCU@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZAkg9J+Br3EF2oCU@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5199:EE_
x-ms-office365-filtering-correlation-id: dbd56960-daa8-42c8-56f5-08db20400d8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  A6mPsXBMlGUKaroygT2uNAIsDAvkaDJQ+zDBfJdscY3Bcf2nzr/Ub2T+w9ptvKgn0WqH05gOpsGPO3QttIiCRUQkgDAdC/P0CdSMNmYRHbtJKiyHOtypc1goj7kDUEGaLf867eAZoFqY26fprnr28yGA9f7VOgE2/sp/dHKM2O4NX9Zkmw2rK6GlvQno9QQdw43gNgAFMt+QYcePPH87nM/rQ0crczK1+NLnjWM5jb0QUTbAvNI3JQNrSmaAWWvBWnqio6P6A8TxeaBNtEwOTxnJL/YOkyAoVpy3ZcXcfzjgU/om16Qp2vMKyhMVHJwJmz4RVaUaTN5wZQKtAOcI+LBOWDX9phHmDtV0NmiPT5DgiCGu2/B/0aSICpskA9PUdE+nO61hT7RNqjnLW7cmgE7ppO/CFQGPVUOJEVlkSsdJpqxWy0M6QDyZ4iDxY8rH2OGh/FmXuQR2CFrIo7KeH2FN04/PQkUQBgb2r2zB7F+rfQPI153e8VmltpCEvaylwT08MTDA1hOj5O3hJeITv6ceaSjz11oRJbQHGz+wL5OVIM6RdrTeFzcSCcx/p33dfIaWzdAJZXUQ7kX4JMKx0GDI/7hPMpgGjlf8HhrbGZRg+g6u01T9Cl6u2SYodnuhvgIlpPfAFbRu/AqiW4tYQhsq9d09yZNkidRNbX1Tw63zLH4K+at4RQZHuVx0YVAOK+F8HXTB6VjtqDGxjKMipJmO6elow69jFHJ3Y5mykTSt0znUlbGxZ7dHIlwWjTZwZcWuG46KsAvHgBIpCZtP5w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199018)(36756003)(54906003)(478600001)(6486002)(316002)(71200400001)(5660300002)(4326008)(2906002)(8936002)(4744005)(91956017)(76116006)(66556008)(66476007)(66446008)(8676002)(66946007)(64756008)(41300700001)(6916009)(122000001)(38070700005)(86362001)(31696002)(38100700002)(186003)(2616005)(6512007)(6506007)(26005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VUFTdFVVdE85ZlVqTHFyL0UvWUFQSlV4Q0s3K0tmZWFjK2YrV1phUy9ZbkVJ?=
 =?utf-8?B?OWVqSy9IanZ4QUZ5MlUwMmFnSExPWkFyaDNJK3YvWEFhNndvOGd0U2dnY2dX?=
 =?utf-8?B?SytJc3VlYSs1M3JsZWhyN3lmdW1qNXdianM5ZHRsZW4xUUR0Z0crN1Z5MjIv?=
 =?utf-8?B?RmozYkk3ZlkyWnFoc1JiQVFBNG9nZUlyNkxBMzdLc003VG5JcVRZSTE3aHk5?=
 =?utf-8?B?UVdoT09rZVdjWTdadFptRk1na29sWk4wMk4zRjVnOUlYWTJkbWIxSFQ4OWI4?=
 =?utf-8?B?Yy9DeStsSHZHaXNyTENBcEhxanc5cWZYc2RFcmxoeU56Z3czalZDa1pubjE5?=
 =?utf-8?B?MHl5M0hCcVl2dkRhbzhyKzhjcmtvT253UzVEeTVTKzJwdWh1dW5sbkozS1kv?=
 =?utf-8?B?R3U5emd0VndEVkJxQjZNNnA4TWRzVytJRS8wc1UwaWtmS0l3Z2orRVNieElH?=
 =?utf-8?B?MFk2YWdLYXhnVlp6WHNsek9EakZOaDd5aHJ4TjdGNC9ZelpEZGJENXFLcWxB?=
 =?utf-8?B?dnY5Qi9PT0ZuU1pqeW85aVFSQXpUUDlMQ2VlK3doaUMwdUhnQW1OTkVPeDV1?=
 =?utf-8?B?V0dyNmJMZHVBdWNBMS9CdmJ5SHBWcW5sMEExVVIycHNuUUZET3pBMUdUeERE?=
 =?utf-8?B?ejg3Qi9wMmVCZFcrVGZEbVdkZ291UGNSa3BzSDF6eG9mRUcrOGZEY3FEcTZn?=
 =?utf-8?B?dkJuZjdJcy90Y1lMak9jN01KcU5QcUFsKzBRd3RoamNYU0twUDBKNG9SbmhW?=
 =?utf-8?B?eWF2S0sxb2tRNDByV3RSR3N4UTRVL1hYdDdodVRUbllVc2grYlFMTVVVL1hn?=
 =?utf-8?B?UXNHTWdLdytUOWFEWnpXR2Y5WWx5dlBNaHA2T0RhenR5WlNoMEFNd3ZidW91?=
 =?utf-8?B?U1djREZpS0UwWGV2d2ZuZjdzZlN6bGdSZ0l1WDZuek9WT2oybXM0VzMyRkt2?=
 =?utf-8?B?NHA3ankyeENCMEI1dnVOSytxUG5hbkl5TGd5ZTdoY0hZYm4vREJWLzh4OGFh?=
 =?utf-8?B?QkR4RmlOcS9iSnhBdWE1dmhWRDVBYzhrMXI2dFo1Y2t1bjZXTGZpYzk1LzQ5?=
 =?utf-8?B?UmZyeENiWUl1aUpXdFpwZmdwenlxWkhRU3lhUDdLWjZiSFFZbVVQS1JsWitw?=
 =?utf-8?B?R1RxOFJjNXZZemlXK1V5NzR5cDhENlRCVUZWNmtEQlNBNDh1MG82N1RMNDJm?=
 =?utf-8?B?T0F1Mk9YMXkzeDArRGJzNlNmZ0RyNVpiNGsxNi9tMHBXREhhaXNOVkpEQ29w?=
 =?utf-8?B?QU41OFI4OHNGdlhuNHI0STZIN2d5ak9JeHlXWXhQVE1sNnVOZXd4QlFvZEJj?=
 =?utf-8?B?aGR3NGFsYkxHakF2UTZ3UGFLeFNHdHBLZXBKMGtXeS9YMEN1ZjM4aHNzcEpT?=
 =?utf-8?B?SzhRN0FHcis5clF1TXlDcGQ0ckpkcFBlOURBY2ZNd3ZxOWcwVEZXRUVKWFU3?=
 =?utf-8?B?WGxhUTg1dEgwL0syYXUwcE9ZNGk3RmFvalpQUVd6eXhJVU54QWMzSlo3a0pK?=
 =?utf-8?B?R2FlVXhxQVJqMU15MEhjMzdNNGpZMHJKUk5ka1lJVi81blk4Rm14L0d0dzR2?=
 =?utf-8?B?bXIybmdKNDJiV1pyb3J6ME1GajU5ektRMUlXYU1qcWV0di9ROVd5UkpxQ0hn?=
 =?utf-8?B?TktsOEhUYTFWeFVwQzVUT242a1ZYaXp1Q0pYY0RnbW5UOW9ZVGFOUS9aWEpq?=
 =?utf-8?B?QURaWlp4anRSQzE0T1lySSs4dVRXdmhMSGVrSmNzM0NmaHFnQml3RjEzZGJH?=
 =?utf-8?B?aWErRHpTR2NPRGRIMEExM3I2SzZtV0NPckt4Ly8zZFI2YWR4R3VWMTQxMVFM?=
 =?utf-8?B?ZDVFVS9qWU1oNUZWVHNjYXoxT0xraUdVTGdxTGVpY3d2KzRiNitVLzR4cVpz?=
 =?utf-8?B?a0FhUURzcU9zOE1wK0RJMHd3N0t3YnJ5S2FFZ2dtdlkwWUcwZkZPbERtQ0Rw?=
 =?utf-8?B?K0JlbU5JMlFKNVNiMCt6VkY5aUdpNUVyMzhxUHZzSDc4b1BZQ3d0ZVZSZWFk?=
 =?utf-8?B?MkJXenZIUVlRV2Q4VjZNck96UThUcHFWTFpKN1liWDhvMnJJdng2NXk0dy9H?=
 =?utf-8?B?WjJES2ptU0lWNmZHQmtkdkxSdm9VYkUwTENWSGJBT3dNSlBzUHJZTjJpYlFp?=
 =?utf-8?Q?bBersFmMMBSGvkfnVqLzLPr+p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E19F3E97A01A342A5C5BEB41ECC34BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd56960-daa8-42c8-56f5-08db20400d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:46:08.0238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IzWOI9uIID/0Py9walEIbbOtzukKOBBnD8Bj3XvV/NdnaaNkyEZjwGaZUR5iaAzY/xIYcjP5PW5Vgsw5SMxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_174613_413927_01DB8DFF 
X-CRM114-Status: GOOD (  13.84  )
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

DQo+Pj4+IFRvIGZpeCB0aGlzIHByb2JsZW0sIHdoZW4gc2V0dGluZyB1cCB0aGUgbnZtZV9jb21t
YW5kLCBrZWVwIHRoZQ0KPj4+PiBvcGNvZGUgaW4NCj4+Pj4gYSBuZXdseSBhZGRlZCBtZW1iZXIg
aW4gdGhlIG52bWVfdGNwX3JlcXVlc3QgYW5kIHVzZSB0aGF0IGluc3RlYWQuDQo+Pj4gSSdtIHdh
bmRlcmluZyBpZiB3ZSBzaG91bGQganVzdCBub3QgcmV1c2UgdGhlIGNtZCBwZHUgZm9yIGEgc3Vi
c2VxdWVudA0KPj4+IGRhdGEgcGR1Li4uDQo+Pj4NCj4+PiBJdCB3aWxsIHRha2UgbW9yZSBzcGFj
ZSBhbGxvY2F0ZWQgcGVyIHJlcXVlc3QgKHVwIHRvIGEgZmV3IE1CcyBmb3IgbG90cw0KPj4+IG9m
IHJlcXVlc3RzIGFuZCBjb250cm9sbGVycykuLi4NCj4+Pg0KPj4+IGJ1dCB3aWxsIHByZXZlbnQg
ZnJvbSBwcm9wYWdhdGluZyB0aGlzIHRvIG52bWUgY29yZS4uLg0KPj4+DQo+PiBJcyB0aGVyZSBh
IHdheSB3ZSBjYW4gZG8gdGhpcyB3aXRob3V0IGluY3JlYXNpbmcgdGhlIG1lbW9yeSB1c2FnZSA/
DQo+IFRoZSBkYXRhIHBkdSBoYXMgdG8gZ28gc29tZXdoZXJlLiBUaGVyZSBkb2Vzbid0IGFwcGVh
ciB0byBiZSBhbm90aGVyIGZyZWUgYXJlYQ0KPiBvdGhlciB0aGFuIHRoZSBjb21tYW5kIHBkdSwg
c28gaWYgdGhhdCdzIG9mZiBsaW1pdHMgdG8gcHJlc2VydmUgdGhlIG9yaWdpbmFsDQo+IHNxZSwg
dGhlbiBtb3JlIG1lbW9yeSBpcyBuZWVkZWQuDQoNCmhtbW0gSSBndWVzcyB0aGVyZSBpcyBub3Qg
b3B0aW9uIHRoZW4gLi4uDQoNCi1jaw0KDQoNCg==

