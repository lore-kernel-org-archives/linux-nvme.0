Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C592C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 05:06:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F336134F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 05:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31F336134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TI7rUf7sZKyMFHn+UuLxoWM9mENNW2HEqAslClAJrww=; b=t+8DxmVJxZ2E21B4rCNqzAKW9S
	T7hxCUWc2l8S/u8EO93cMam3fbTRJVOBjdJD3+ihVqalCx5hamd4fxZ7xKziYm0lmtfnIgqzKPkxz
	v9jPvcf4ABqjzIgTCXtoCcURbR/y2PUWFhl5iVT/jMzNU+0mc6ZvOA4prsgMfwt/ZyF7DhhLKJZ98
	SUWwtAiXD/YipYK8dKGLYEXG26AX1G4kNCJ06XQoweqLaGyarJHCdqA5TSjesW1gKiPssh1vUKYaE
	PHAD/Gi0PhYB0rP6saSwylcd04X+cZMNBF3tLeYFAa4A267nogHA2ZobRRYh31Uzh/re2W3pgHg9N
	5jSjw7YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ml2IE-007FoQ-F5; Thu, 11 Nov 2021 05:06:34 +0000
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com
 ([40.107.92.52] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml2I9-007Fnu-L8
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 05:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPFfTfB+gLzsdVlXOy37RKLPvYVY7UWDRtRvAglMn+TFDzRQCQv4rG87QX9YLZN+h/KXChFLC4biN4TNH2gH66Sgnipe48zI6lgHUTC6oGedezzbIxKKVGbbyO1U+R0MKbibLtFddNR5iJLnk2o7SpIt2p992aK62zY4BxhYPgqB+VlxfTcOXXFdC3cS42H11jHa1xLhu49Rmbt1uHe5bakhx8c1sSYWwKVHuAFRK+hSB+jxjJkNO8DdQN4VdC0UjcTd3iIVPVkyzu7Ge11nZn+szHAjap/QOrXKoxbFuWo5trvIKRho4E21tiAuTZm9Ct2EyiJmveq/eNqlw2xn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI7rUf7sZKyMFHn+UuLxoWM9mENNW2HEqAslClAJrww=;
 b=YuCJSwTJC5dPmKk7t1OngZ74AttOdDZl0L0FNP4OaWoLrV8Lr3ThIC6rNQQj538OD5WRJqS8K6vRi/6SAMz6nEsan7pYreYyWi+BpLuLn4Ajuxv58q5lAdb8oyp9xxVTcw6AzzCb7noGwEvFTmSAOHRoNOcslxj9HeMf949Wt7WwWn4gA+fi9DpRRTGIXyYe+J5pHdcgye1S7seGSpsoC0k3KvhKzVuXo+9gPXVocA8+HcHRGladjNXwgRHgFt3oCJdI/lIwScclxmkUsIqjkVzWupw4yjbAkw4npIshYnaZyKeZ55rqck/afzSFjksn/SwdFblbQklmt+9kLUI+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI7rUf7sZKyMFHn+UuLxoWM9mENNW2HEqAslClAJrww=;
 b=UbulXP2gd9JL3BIkZeQiR1YniGB/Z05UTpPlYhfIN2Xov9fDDBT49YRMizmRqhns/zssFxgWp/k3I2NTOdK7Md+do5RWhDqvXW6XzYHiqU9sDOI/zLiK1K6nP2N1Pq1Z5yedkzL8dV/Noo+07EQi2b03UYstvzX1WExvk7nIi1nTTQMfqS9RgUyb/cwk+jsXyewFEdAtWGPj4SxpuEE9fBAmxtDYw73EzaACrk+pzElaO1j6AlXFumZJ4A03YmlnueoKdXn3Ter123/cdtGswoS849EvsEyS33NteST+ohkjsXYDmoYWowA8j0vEowvekjyiR3u+XbfKXoRtLDfSmg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 05:06:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 05:06:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Klaus Jensen <its@irrelevant.dk>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: fix write zeroes pi
Thread-Topic: [PATCH] nvme: fix write zeroes pi
Thread-Index: AQHX0ahdoiiPVPBuf0SAQrCEhrQcWav8T/WAgAA0I4CAAUxSgA==
Date: Thu, 11 Nov 2021 05:06:20 +0000
Message-ID: <8b4cc02d-92a7-4be7-5af5-26054ec36535@nvidia.com>
References: <20211104181618.864157-1-its@irrelevant.dk>
 <db739cda-2dd7-015a-5ad9-d2d6e44131c6@nvidia.com>
 <YYuOB9VytsFiDox2@apples.localdomain>
In-Reply-To: <YYuOB9VytsFiDox2@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51bcc978-d678-47e0-3bcc-08d9a4d0ffe7
x-ms-traffictypediagnostic: MW3PR12MB4540:
x-microsoft-antispam-prvs: <MW3PR12MB4540F9AB8F20B762F70E6A0CA3949@MW3PR12MB4540.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OplXQLYF3f0cqadUKaWBcn2Jq0Mz2hmk8zNuJqI7eLEH3XDA5AjClVzQkI/czHygSk8W/SwVSkK2p2Nj/T8htSRumB83+G3TzJybpG5+jtUolGF0IEaZ7U07KFWSBS9TwGVk7gl3TF+e0a2XDBobQ3AUwz+2lskB8l4u393AuJ6l9IXSEIcdvQp7/ifrBwBFnGTsxBGVkTy9YibOnKl6QS5zSm0TLTNiTll2ZyoMVuthXdHtAyTdQqra0jkb+EZgDOaCY5F+9NvkPh6O7Up1kuoYk/AB8rxM6lejihB191+yEw5sEVLEYrQf72B2RQmMwxVtH64snDVLP+OElF/NCOcXbTxe90Ks7u4GeqL1S3ucFRkq9LT9pw2w0cyEGhY0QxrcY6U0n9zjtkEmyb0odYJlD4dA28gKYMC+sKX5CVxFipG3LngCvI1ctQEeGDsqd/7otlPKoZABz776NHnJtFTBrjXGelTiCbVAMhgcH1Z+jKfJz5x7muW/iLSdfx3yv0jn+afJeZR/EB7XbY+7LUBjKd8lg3/LZaNrVJyNGqFAmURQLcFTYt/r8toppZFKBOt2ZN+tSH3jhE+uFRokZLv6rGmYO/FSor0AKEbnhnSk15b0zocuY9lSWdgvPOunaASiH0+QoEUewXPe9+DT4IIT6ExvVHVjjuMeP0+GqbiTjmEQowObHMmSQMc4OfbN/InkIDZ5JASosy4tl84jUbe9dl9/bESoGmhKLLIfFLoBMbFj8RyRMXEkeApjRCnejcf7Q8EtgDl6KUg9nzaLJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(86362001)(316002)(53546011)(91956017)(66946007)(76116006)(122000001)(5660300002)(4326008)(6506007)(71200400001)(8676002)(38100700002)(38070700005)(2616005)(2906002)(36756003)(54906003)(186003)(31686004)(66556008)(66446008)(508600001)(66476007)(64756008)(558084003)(31696002)(6916009)(83380400001)(8936002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUcrc0JydklMb2NKbUdLQXhEeTRlQXBaUHhUUStTNjg5VGFNekVJN0ZDRWgx?=
 =?utf-8?B?eDhxMVp2bTlvcFQ4cW8vWU1yWVVSOFdBWEUwRDh5b0YvVHpNZjFZZW9yMFhq?=
 =?utf-8?B?Qnd6QzBQakFLdXU0SXBRMzh6aG52ZUdwRWhZKzJtYmtaanpJYzRQWlN0S0tH?=
 =?utf-8?B?RHFMNnl4a1dRelY4T3B4dVllUWtHN2hzZzF3dWVuVDFIUkFPOXBMVG1NZS9u?=
 =?utf-8?B?N3l6RUFQMHdzeUV5WEVzQ2o2TDlTNVgrK2ErTW0vblIvYTRESVJ1Y3hmSjAy?=
 =?utf-8?B?amJyRDdQbE9Jd2E3QlpsRHJHVFVjUkNJSExUYit6N1FMQ0FaWkxoZURocjZx?=
 =?utf-8?B?ZTlDZEpTckRBblppWHVsVTJMUURYdU1MN0ZOMmV3eGlFZU91T29TdnF3ajB2?=
 =?utf-8?B?dHpaeE5vZk5ZWTdLb3pNYjRTMEtaZGNpWXdkRTZqeVFPaWFXTzVvcklnS1Jx?=
 =?utf-8?B?UXR0eTByTHcyc2k2clo2Z1p2MGNUZlVkYU5ZRkJlVjR2SnE4eklhZUhxV0RK?=
 =?utf-8?B?ZlNINEtsVEdobnYzeklzZTYyZjM4MmRkb215MnlyZHlsK1JmWlpxODd4ZDds?=
 =?utf-8?B?UEltK2tTd0MweHkwZHJydnpjZW0vclBtb0dPQmxnb0ZrdlhIRzRiUkRpZFUy?=
 =?utf-8?B?Y2lLbGo5RWxLajhFTzdKTC9wOURXTmVIaUR4UkJwRjhXVnI5M2dKWk9hY051?=
 =?utf-8?B?OG5lNTR1ZUlVOEltVXdWUEtVZGVsRWJXbmtwQ2pGRytJaFc3dE5JNXMzVG10?=
 =?utf-8?B?TThvbk83TEFxRE4xL0NwVHFIMHFMZHpEUjFVZ3h2UTMyVUVLS2Q2OXNJM0tK?=
 =?utf-8?B?Zm5qWTBaaWFYWXY2Q0tnWEVaS00wb3FJM0J0Ykpka2RERituZE1RcDRycUht?=
 =?utf-8?B?Mk9YT2NpN0tnS2RjTnpjVWNGUGxudFlLSmF4OTV1ZWFsQU9SYlVULzEyYzM0?=
 =?utf-8?B?Z2lIQWUzNTNOOHp1NWJacFdmZVlWc3dxUjJkRERabjV1Y0VaMUovWk9CZFpo?=
 =?utf-8?B?b20vK2w0cVNleDhEalcvVDlPTXZrQmZEaTRtVlMxaENjWklrZW9zT0cvWkV0?=
 =?utf-8?B?Ri9QNHNmc01KUU1Ka0FZdGhHa2M2aktTcmVVdWhVaDJyNUxPcjN6a2VyUGo1?=
 =?utf-8?B?WjlFMnZRMG4vb2g5azB6NHhLTXRLVmlWcU1LQjZLeUdQZFNqbW9aaFNlVXh0?=
 =?utf-8?B?QTdGdGQvZjZGYjduTEtFZnRDUU5zL1c2cjBQNitYNitPU0lFNEhWZFhNNWN3?=
 =?utf-8?B?KzRURDVUb2YySGFNc1NxZlF4Y0FaZFpJNjQ3RnhpZ0p4WjFNeVhHa0RTSXVk?=
 =?utf-8?B?QUhYQXFScmQyLzduVTdMMjVmb2FlYm02K3dTRHZYYlk1TTBVOVpRZFFCZ0xO?=
 =?utf-8?B?OUFFdUlCcTVzeWl0WVQwbC9QbzNmYi80WFV0OWRMcUdjYXg5aGhUc21Lc2Rl?=
 =?utf-8?B?VlgydDQxdlcyVThRb09KYlVuYjhlc0RZc3hlM3NRSGtRWVIwR2ZkUkVMdnlq?=
 =?utf-8?B?VzBaNE5iK0hCbWx0WlNNNDNhWTJ2N1ZEamVwSnJ2R3FEMThVbWtoUTR0UGIr?=
 =?utf-8?B?YkI5VEljZCttekFaL0dYcUtQakcvV0dKdUQzV0FjME9PTm44QU1WZ0EzR2da?=
 =?utf-8?B?VnJ0WGQwUHJFSXFla2FENE5kWlliUVl0a0NNUjBuSFhBNC8rWWM0QVJYVGor?=
 =?utf-8?B?eEh5SGY2cjArUHRYUngvWjM2UTA3TmhMRW5leEhrd3IwaURiZGxCQWxHWk1K?=
 =?utf-8?B?a01Na1QydVk4TmFhRzBZVFcyb2ZhRDNHeXpvREttOUVLQW15MU5COHpINDlE?=
 =?utf-8?B?RnBkTldVUVEwSXpYa2FBTTNOZUg1V1c2ckRMZVRmVmN4eThjT041MkZ3VFBk?=
 =?utf-8?B?ck83bThiQ2l4MThhNXpNMDM4UGZCUDB5a3J3eGprSDRjQWFVZGxiVUcrVG5E?=
 =?utf-8?B?NFRKR0JkNzNydlY4cVZuOS8wam9lbGx5MkZPTHp2bURTMHBBRUkzdG1mSmxZ?=
 =?utf-8?B?aHJuMUt5YmRmdGhNRVV5YkoyWEdmWmllMk1WK3J6aGdMS3NubGdRUUpOUG9T?=
 =?utf-8?B?TnpOM0ZVUVRwT3p3RGZ3UENzelU2U0dteW03ZnR6bzV5ZGtNU3hlUUZodHk5?=
 =?utf-8?B?a1RYRjVzVC95Ny9pSVVxNmJTdU9TRXBSeXFHNkEwVldvQTRDTXJvQmhBTy9t?=
 =?utf-8?B?QUd2VWxHdHFxWnFaSXFyUTRaaUg0aWw1STRhQWU1WGJ0SHdkTnczZDNKSEVx?=
 =?utf-8?Q?A1AhsHKRRbGbXNPuk9KV6Y4L545ym7UBQPp98E0OQ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00D0A43E5268484AAE8A356CD5DDD6C8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bcc978-d678-47e0-3bcc-08d9a4d0ffe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 05:06:20.1643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txElQPOs34sAFLuLOwxovT6mijacW6Sg5Pz5Nl23mySl6JM44zwmDifAIILEOYdcEL3AdXGftXbIU1gOLOLGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_210629_780030_0C9A2A57 
X-CRM114-Status: UNSURE (   7.14  )
X-CRM114-Notice: Please train this message.
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

T24gMTEvMTAvMjAyMSAxOjE2IEFNLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQoNCg0KSSB0aGluayB3
ZSBzaG91bGQgd2FpdCB1bnRpbCB5b3UgdGVzdCB0aGlzIG9uIHJlYWwgSC9XLg0KDQpQbGVhc2Ug
ZG8gdXBkYXRlIHVzIHdpdGggbmV4dCB2ZXJzaW9uIG9uY2UgeW91IGRvIHNvLA0KYXMgdGhpcyBu
ZWVkcyB0byBiZSB0ZXN0ZWQgb24gZmFicmljcyBjb250cm9sbGVyIHRvbw0Kc2luY2Ugd2Ugbm93
IHN1cHBvcnQgUEkgdGhlcmUuDQoNCg0K

