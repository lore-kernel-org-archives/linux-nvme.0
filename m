Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C9FC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctoE1qiDQu3XhKX2J/FFwj6E3kiDmXj5LgVzQSLslGQ=; b=t9Xku4ygNqxrXMGrNBMm7gkgOx
	rKiUvEVF0odutQGuO5RHqwVGfTgKHXVTrJiHBYXWMjL+WxJ6JwB0DcG5W0huqvfbBXMszqb9j8GJO
	h7x7ROuFGhprzf7yjo5PK2+TELEWJD/DjQju2Z7SqoTpdDb1eLwrBy/ISAS2b+BVJV4gsXC0v+ixc
	c61rjpKDK4h25jNYQCWFypWLLYIeRlASPvi/u7Wo9NnyP8GmPiUbuNXfqpAVFrNCz79XJqNMqjoia
	T/Q/4YOSgE7F6yrYCH7sWgVCRytdJiWb1cSJ0iop9mtLKW6Nf4Hg/QTobOLcBM4mJsR1U9hIgA9Mp
	UyHddsIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVK8v-00000005xjA-2axH;
	Wed, 31 Jan 2024 23:37:21 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVK8t-00000005xhm-21Kb
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 23:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaN6IyujLoUtM4CDQwGA2surnGCxootmJdYO0cXEQgxkYhw/H6sKiyhj8KUuuA2tHjvLTnQYKLFGLCdvY1dS/por2/BhMC/CNbxeOiiSJx2QQG8NKAuPzdgDEBrK32sCF1XZUYIHU5YzL2xh6TVUETW5x7LLNOcSDn6eui8e0YsvbYTMIQhajxSOtFHHDySvJDAmY7CmzgOa3xgr5ThV356XjW6bYI+FDGfg6mzUzylTG8rOrpVAA2kt79rE1ohMU2ePnYvvK5JjrjSxny0sU5n9MSdaDdPKmm/gcRRgPnUZpBqfMu8ncDYNypf/K8zNdZq8j9Q6G4LU0NiVWUqKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctoE1qiDQu3XhKX2J/FFwj6E3kiDmXj5LgVzQSLslGQ=;
 b=KmmlwX7/vG5AhmAOdRwKHZWc8sVv89gqIMP48Xkze4d9JDOj0JLHd2VTdObzy4eGMW2oLnPjrrHqc1FdsWUVGyNdqGEx0y/0sfZkjdID3HmvyPqaJN8kSXT3w8/GztlE9AvTZuQl9/rNA/I/e36Y7SP9eat64SHwrxEBqVlbAiVHEDfqqj2Cx/Af5EtcHY41gHhHF+n4i+7SnVhficHg9W6cdloVB7qPqDDUxrK7odHKETiYQaMfvfvRXCHOcQWKqS/uhafWr9DipAXGSAghlXXfIpiUcxAo9eG9I6khvGy18JTOBit+gx5J5ghVErKzlgqAWhIpkTnmTMT/q5XwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctoE1qiDQu3XhKX2J/FFwj6E3kiDmXj5LgVzQSLslGQ=;
 b=QDSrY7G8KcXVpqcRTjIS0Cbtfx06/qskd03MUCxjbc+cPHk1qf1ZTZho1DpXU47SpBpWnftJmYWLg0vdZ0XeUfII9HXEQ6bHHiMf4q2VLIB2Jo4nUzCnb7am9Hi30mk5KunW2JiXU8nbFnOSLYuYTySdOL+14EvYi13NVEYynXYt/r5Y4v9XYece4HQ/0UCpJcHaqnHDRKCvhVGyPNkFZHrkTBdd4Cnk9WmdCYKxOQVALL4MmZEsAqQe9Umf8m22MK47TnSDDMmjeToL9YK6AcCIsvUF7vWuLZQqjsoAvucYYHhNS+d8cBsFCNHBRoI+qVqfMS6oZyZKDCiJMfQ8zQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:37:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:37:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH 11/14] virtio_blk: pass queue_limits to blk_mq_alloc_disk
Thread-Topic: [PATCH 11/14] virtio_blk: pass queue_limits to blk_mq_alloc_disk
Thread-Index: AQHaVEYfdgFHmb0BRUiFstDsQbuUabD0lEuA
Date: Wed, 31 Jan 2024 23:37:15 +0000
Message-ID: <65873ff0-7275-424e-afeb-6c9ad5485b5b@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-12-hch@lst.de>
In-Reply-To: <20240131130400.625836-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV8PR12MB9206:EE_
x-ms-office365-filtering-correlation-id: 7f55c57d-7fd8-4d91-be75-08dc22b58e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqrLP3yQNH1sBkXUCS1/1yNXRgRI1X7EQOUVTqO8Uo5hpYDulik58pH+/Bd3BLFA61WDrCAp4z3WTDCPFQYErJox79jT8Brcbbfn/t5TSwQiU8RK0DEGe5Py2400lXLT9ieuXI/ZYGzMKUl9LrMu948/eAme3Ugo3w8m2Kk2gkr2G2GyjjJsFm9e6vDgCRib+4STZcpp0T9NsgYjulgnaM2D5+FhiB1Oa4CdX8EZpdDx+Gtt74gVPQBZpok5rmTVypUWdRCWqX4JI8hAO+2ghqfUM8Pq2dCkaP7ZuEHgFTeoy6PL/9khV/ot5vf+0hkfIYfmAdv7eStxyD17z3FKlmYb0OCxKkKhiJqtj+kI9QMAMFU8kSxLWu15pzC3qVRNek5XWvJJ24NTd9j1++mvJq1Z+6HUme44l/HZ8p2MkjGkJ9EObY1+BVZ5dbBxBabCxmlJY3K+jsvVPWaKYi8dogUbqVsHtvyZPfOGbVgfzteewH1yUdEqLbDUgmVhTw4LLK3c4MFH9QBD2R8fIm0k5+EFYCyjw8rRbwj/8FW0p9jh78fEa0vLgYSyFQyCNAe6WYchirw86FvAnKuWJP3TtTh2A2L0tl88LwP1J1r0+KhZfacdaZuvCs+FtrtpfR+/Ef0zIbjEnhiXA3J51bWMvmxEdhMZ4yFraTMLmZyLOw2zVvcjgOxsBuzEyHsc8OFd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(2616005)(41300700001)(66476007)(316002)(54906003)(66446008)(38070700009)(36756003)(478600001)(6506007)(6512007)(6486002)(53546011)(71200400001)(83380400001)(38100700002)(66556008)(122000001)(64756008)(110136005)(2906002)(8936002)(31696002)(5660300002)(86362001)(4744005)(66946007)(76116006)(7416002)(4326008)(8676002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnRwNjdWMENRMWMyTmVDaVI0M3h3ekpVUldqdzhHVzRmcHZEdHloNmVOZ2h6?=
 =?utf-8?B?S2ZDZFBxR0VmVGN0YXFMbUFrVk83TGE5UjRtWmNQZmRTT2NRVVJOTFc2VVRZ?=
 =?utf-8?B?OVd4dk5LYUU2dUpKdUxZclovUUpERjM2MzYreXl0TWg0V3ViTkFHcUpjM3gx?=
 =?utf-8?B?citKZ0ZFUCtpclFVb1FOc2VPSWxIMkE5Q1VrQ3FHWFRUV1FzRmgwN2JmblE1?=
 =?utf-8?B?L3ZNVVoxcXVtSHNUdHpMNGluZmlNOUc5VE9WbnY1cUk1a0doS2VvMW0zWUxy?=
 =?utf-8?B?V1dBdURTaytINWo5YmNTVE1zK0RhUUNSTytkQ2pMK2pEWUFObVJUelhXVU04?=
 =?utf-8?B?TSsxL3pmZXF4Q1JKSjN0OFZLWTFqTGdJQlFZRjRSVC80MVJIcUxGUFhLd3lz?=
 =?utf-8?B?cm5xSS9RZE0zczhxdVVYQ2NXZlZ3SzRGaWMxdGZFOTJNQldycTFiZkFSSkpt?=
 =?utf-8?B?ZXpZSDJVZFY4WlFqRVVjSXhSZ3Vmc2dnRzl3MWJqVHhKUTFCRVRScGIxR2dK?=
 =?utf-8?B?REg1K1ErOHlVbDA1M2hvV2dYeDBhSnU3SStwTml0Z1ZOSnU1bWZYNThGeDU4?=
 =?utf-8?B?OGh2N2hxd01mZlRlSG1CVGl4K2ZhRzA3RGk4bE5NUG9qZWdsenE2LzRXS3ZM?=
 =?utf-8?B?NGRFT1BjbXQyZExZeC9panozZ29oQ1I4U2JwbWQ1V2RkTmhLSjBRKy9wUXhL?=
 =?utf-8?B?MmJLRlFCbjhUQk1jNjR1OWRGRExSTlh2R0tadE1EUGZZL1ljcDhuSkZqQ2tk?=
 =?utf-8?B?UXl2Rm1MZ0crR1hPT1kyOGI0S1FRdzIzSjVuY3hHWktMZzJMZTlZSDJaM0RK?=
 =?utf-8?B?STRqUEtWWTdFY09mNjBidEc4N2ttcDVVZjVTbS9UdXJkdXI5ZXEzYU1OMjQr?=
 =?utf-8?B?VURWUGNyMU9NeFB6TzZvQVRRV0twMFYvV28zZVRxamFxb3RLYWhXS0E3blcr?=
 =?utf-8?B?VWZhaEZoaEg3QXRlSWF0amtnRG1CbC9BVk4vYkFWdm51UllKaTV0QkFjQ0FK?=
 =?utf-8?B?Y3dnY0RUdGFXZnIvaVN6N3B4NnI1TUgvcVFUaUcrQVJ3WVczbzg3cEo2aTZE?=
 =?utf-8?B?WGNGOGl0TmRyb1Z4ak5TRUZML1ltcXZGRUc2US9hcDlNdVF1bTFPcmszM1B0?=
 =?utf-8?B?NjJKWXhISlp2djBuK0V1OFYvMVd2cjE1aW50VExML2tFODNVbllDK3M3YXJl?=
 =?utf-8?B?b2U3SU5LMG9seExlK21ONVV3U0tmcVhiSWFJcnpzQWJ2NzNOTWt4VmVpblg0?=
 =?utf-8?B?cTY4eUNQais4N3hnUDZTTHdyMHYvZm9PSmJweFAraEIvUi95YnVuUUN1NWR5?=
 =?utf-8?B?Y3RoSkp3b000ai9CTTJRSEltRDZmd2ZGdFNFYi9reDYvckd1UWhiNUw2YjBo?=
 =?utf-8?B?S2NPa0haMVN4OGZzU2d6NTJaOVBpc0NnSDZTY25qakZOSDdMMTZSbUYyRXVX?=
 =?utf-8?B?MFE4eGx0aXFIb1BOamFyT0tCaVczRjNVcTBSYlY3aW5OMXJJRzV6Z2psU1hN?=
 =?utf-8?B?R2h0dG04U0dQdVJHN3BHK3JDR3BvZXVlQ3ZiRGZMUld5MVROeGszb0ZwN1NV?=
 =?utf-8?B?SlhsZEprVzQvWEFOTFU2MERaUXhsQk9XanFoOUVybGtFeFBUc1Q1dnJyNSt3?=
 =?utf-8?B?Q0xBd1lWV3dOaVlmSUtpVlQyZnpjNWYwdDQwSUtYTGcyVTM0ZjMxTVpJTWFy?=
 =?utf-8?B?c3VYQzU5OFVOR3A3L2dEdDJienRXb3pjTW5VSDRyZzBoSUVxV1ZFQ3psN2hG?=
 =?utf-8?B?YzNObzIwekZ1dlplODRlS0ErMGttQ1ZnSXp0UEYrNFJvaG5MZ05XR1JFelNZ?=
 =?utf-8?B?T1N5UjhpaXRKYklDZzROTGYxTi8yWEJzQ0xUbkFRR1FtSWxxTDFHU0M0ZFpY?=
 =?utf-8?B?N2lmSFhDbkhJSWN1YlhmNDYrcmZMQ0tIMUJBb2JtUkZQbmtJYVBGdnM2WHdS?=
 =?utf-8?B?ZXhmY3lLNXVJRmRPaDc2RHg4dy8rZllZMDZnVnQzZDBqeUt0UFNVZlFtVnNu?=
 =?utf-8?B?WTVldG5NbGdma2FvUXl0N3o0TXhLc0NFaVpabTJPODhEZHNLWGxoS2tzbzg2?=
 =?utf-8?B?NFF0MmJ4eUd2MkcvVlRBVWNsSUZwR1NLUEd6cUlpR3hFbDczQXJaSE9YczRx?=
 =?utf-8?B?TldLUzdxRXYvTGRXVmRjazBxTkRsZ3RoTGkxK0FWcW44YUxoQTB2MWtwUU1r?=
 =?utf-8?Q?VkQ9T76goyIqCJIF1/ZU8x1cQxfTqDszApPyi7fWylC1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3D178AFAB8CB241B9381768CFE69E4B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f55c57d-7fd8-4d91-be75-08dc22b58e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:37:15.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDfMLutsDdoR+UoJ/XnZ7fvYYJ/JB56EnWuvqSupbjGg/DG+CBpJC6XJ+x3jankYu05npLZ1Kdza+A5cJXd4yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_153719_543946_52395133 
X-CRM114-Status: GOOD (  11.92  )
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

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IENhbGwgdmlydGJs
a19yZWFkX2xpbWl0cyBhbmQgbW9zdCBvZiB2aXJ0YmxrX3Byb2JlX3pvbmVkX2RldmljZSBiZWZv
cmUNCj4gYWxsb2NhdGluZyB0aGUgZ2VuZGlzayBhbmQgdGh1cyByZXF1ZXN0X3F1ZXVlIGFuZCBt
YWtlIHRoZW0gcmVhZCBpbnRvDQo+IGEgcXVldWVfbGltaXRzIHN0cnVjdHVyZSBpbnN0ZWFkLiAg
UGFzcyB0aGlzIGluaXRpYWxpemVkIHF1ZXVlX2xpbWl0cw0KPiB0byBibGtfbXFfYWxsb2NfZGlz
ayB0byBzZXQgdGhlIHF1ZXVlIHVwIHdpdGggdGhlIHJpZ2h0IHBhcmFtZXRlcnMNCj4gZnJvbSB0
aGUgc3RhcnQgYW5kIG9ubHkgbGVhdmUgYSBmZXcgZmluYWwgdG91Y2hlcyBmb3Igem9uZWQgZGV2
aWNlcw0KPiB0byBiZSBkb25lIGp1c3QgYmVmb3JlIGFkZGluZyB0aGUgZGlzay4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBE
YW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIA0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K

