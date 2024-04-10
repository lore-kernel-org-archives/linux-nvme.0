Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4459ECD1296
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 06:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eMZid5d9vhxiHw9q2DE1tVbKMEIcSD8A5f0Z8rzjuQ8=; b=VIC/XI5IHA1Kj8UplNKzB4/wYU
	P9fQqdPWnw5wv9zcXSeJTgpzWOHUl+ybKxvuKJm/ibreKyJ0LecdDBFKr5iyAko3BNVl+hJrIuhlo
	IOBXlUXrfn+Z61xovNTTn1q8uFRq/SogiCfpNb+2k0Z3317oVlqBsY9yuj/IyXocnf7+PK00GV4C0
	Q+1lIGbsUZ7Ixy2E++pPC4AKlAJ3MMaDlnJ9IKkEEb5xNNYVtOq+U4jZf49FpITAqBYPN0UmpJmdk
	pNC51VoLvaB9YHCQyP73ZK4EnH72lISx2dfLJzkB5aW8ykpPQMJimoUZVu+dOHo+sxzGDfNedgn9e
	QFDS5ImQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRUn-00000005Ooa-3iSH;
	Wed, 10 Apr 2024 06:31:45 +0000
Received: from mail-mw2nam10on20701.outbound.protection.outlook.com ([2a01:111:f403:2412::701] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRUl-00000005OnT-2WJB
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 06:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL+FVfaSYmtyZMhBHUQZyfSxWmUDYOrFraryn0wVUao4JfWsY6DEa6QOspQtKyfbmZ+ZqtTdgb7bol46VZcur1ND4bt1UP2fc3SFKxhEXQPGT7bBoX5Sdq2Evzt817I6wuAK6zidhcWxMW4OGkIxXmlnYft8ykbnZfnPq5KzFkDrIb1vrYBfxLnq6j9u+T4kduYHTwTPFoUADpJNeOhCPGl8ZCj7bMXpLxhG8VHcqmOjAltVIeQa63GL1yt63JjUIBJDKiOi3gp1Tgb/jjhwaJLHyWN0D0Mw5nJXeRh9aQZl068WwyfK/0VyFsp4f7aj78u78H3YJe6gO8PnD3aMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMZid5d9vhxiHw9q2DE1tVbKMEIcSD8A5f0Z8rzjuQ8=;
 b=aCtA79Sulp3Sm2/u74dl1iDDf0Zvz2d7DhkdHbsMxyRje0J+LyBN5jBQ3+oP2eHWYymj1hyjXAz9rnNSVgzf/z+559il4YALRavvg8DuZ1EZVy4jEgJhQDRNrkp1GWwTKA4ZTABfNjyP4TLExWx+rjUI9a2bYWEwxxBPARUHGbs+NYUpaxExuroqS7Aj8FxldhPlalzRx3J/Dc8ZQ72HJWZdt2SOXYBckur+gs4iAjEdW8Kubr1wnsC+VlEVcJRN/632aqMlcAZWtqKDnITzkIewDWvT0CWeNBycleyZV4d5w9PErCp3docBdz7obt/ccXwvWSP/oqpjg4S/28SDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMZid5d9vhxiHw9q2DE1tVbKMEIcSD8A5f0Z8rzjuQ8=;
 b=N1SYqS1oCrHbHU7J+mYhp8a1n78YwTglNVamRPrakCnezPVZsqI81G3MGWPJ8nhET11aK/wF+sO9Y5rAW4wVFeHjwWsqf06FmjN437rMB9sz/hc4RIid+mP5fq1mnjxKuM3OsFstGWwGheDz0b9RHIbJxcAVgRftcTfQZbU8FpEWpZFXUSdD7g8KSxjLAXcFgilCub/S0pzPLRq1k1B388M8Q0J/8dBpnGdlGzGE2EGePfP1O5+p6FQhNbyvXT1i5AJITRky175s0LxxD7zE6jmDgzE0XGMBmMwULQRnR+nNEvTwOMdreRm+zYxOyjn98VDgUvSS67WLys0azem0og==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 06:31:36 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 06:31:32 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "aurelien.aptel@gmail.com"
	<aurelien.aptel@gmail.com>, Shai Malin <smalin@nvidia.com>,
	"malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Gal Shalom
	<galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: RE: [PATCH v24 05/20] nvme-tcp: Add DDP offload control path
Thread-Topic: [PATCH v24 05/20] nvme-tcp: Add DDP offload control path
Thread-Index: AQHahozouB5ThOj+0Eaix8CMe4wuqrFdYwmAgAOxM4A=
Date: Wed, 10 Apr 2024 06:31:32 +0000
Message-ID: <SJ1PR12MB60759F1B575FD36E62A8BB49A5062@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-6-aaptel@nvidia.com>
 <c9b64779-2e8d-4d32-bfc3-c1281f59fa9e@grimberg.me>
In-Reply-To: <c9b64779-2e8d-4d32-bfc3-c1281f59fa9e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7896:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IefALiebltY9C6A3z311aN3m8Xbo+ww1updS2Qt6jlz78asQZnwjTCgDPEZH8IeEr6jHlPJynDFc5dwyae51ehi+1yX2z/yyw5Hhi/pdi9nW6R8LdUNPAhlEZxoHO5MJHNPVYv/qAHFUtEZcw44A3fiyfNLTQWv4n3QVANY617ddy7FxykBKtIjcT6imJFccux2n1ceHuA+GTpaIfC6omgIt5WxcBf5gO8U4aV6VxwcFbk/wR5YyyXJhbwDwRAAVzBdwyie20IG86sbemArN5H0O+3B5t5cQFC3dJcGHdJWT8irbfz4TdlOOlitbp+9VyLvH+mNox8PntF1xL51fP+2NpwPcozhcE6DOnY4Y3zEYwrspyy53TPneHeTALaIBYQPKnaCOoL6l78D6rhpuCEgBFbTA2y/6r7LwZSz6iPzWA9QPUoBkU58/WkLkZyiPY45NZjW3VzpVOHpIqLT7lpC03oPlXqAW2o6Ub6Tv4+FPWCAv/oQjT9EMHinoVFL9N2RW3RWyJApce9ZCaOCSZXAyHQmOARxb1Fy7dFjSAi6IMGPP0kI/UzWA6piRHH8NTlcEdKjEH7tOHnVGZf9nVY2xCGy5Vc9RdFNlNvmMUgjUH2aoJnvs7/spzWOHdxJkY3fs+mbhnHmdb2occIBRcBsT8/GgK+FN1gYx0yfgYvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzBONjlFYWlURjlyNVlHM1FXcVlxMDBPcDR5c1FleGVqMFJ6YTNaQmYwVXRO?=
 =?utf-8?B?MTB3NDlDYXV6TERHRHFGYkVxQlpmaHE4bDNjTnhFOXV5L0xjYlM3cXZ2a0tj?=
 =?utf-8?B?NUs5ZkxNeGZIQkNCQWtvUytnZFBqRks1b2lTNDJLS0tYOG1DdDlVdXdXKytl?=
 =?utf-8?B?NmNpQ0ZLN3U3NUpNQ2Z4eTluWXRMNmFBcWgydzE0WVNOTVBsV3hNVE12ekpw?=
 =?utf-8?B?MWFvZTREUmpMZmNUcS8va2txbzkveVZYSHJhMWpGMmN6aDArNnl1UjZjK1ZP?=
 =?utf-8?B?SzdsMXFzMEpBVHJYd1pDMFVkNitlTTFjWWhBUElJSnBHNllnTk44M3hzaVdV?=
 =?utf-8?B?L082TlNCd3NGaUdTQm9RdGErMWRXN0t1NVFGcFoxdkNaWFUvTkJtbXd5MUda?=
 =?utf-8?B?M2RFc0RpM2ZnVEVJM2thOHJ4LzRPOHZQd1E3TVN6OVhIR244VE5jSmtMS2Z1?=
 =?utf-8?B?TFVtaXhqQTdGSTZMWlpML3NlQlRKaHRoK3pxK0ZUMFIycHFySngzYUxhWnN6?=
 =?utf-8?B?eTMzN2pCZVJITUlqc0hWeVNIVnZDUUFNdmhSdVdsYU1pZzN6QU1rWmFtUEVo?=
 =?utf-8?B?UkRhVDd6U1pIVnk2UEhyMnRzaGovMkwxbjZXSDBiWE5KckpwNjVpZE9xNWVr?=
 =?utf-8?B?eXI1K2NMZzVHbzJxNHlCZ0ZjMnFZV0RXR2xONmw3d3BPejAyeEI4Qi9SUXdt?=
 =?utf-8?B?b1ExQWNMaW9ubjBPb3lBdkRDNG9RNkIrZEtJMCtwSkQ1TC8rRHZ5dFJvRTVo?=
 =?utf-8?B?ZEJhd0FnbVFSaEs5TUhFa3hzTUh1YnFEOXhwUjJqR0M2WEZTSmxBUzNDc0Vo?=
 =?utf-8?B?eGZZSTQwd1l6eDQxWDNXWjFrOTRjVE5nOEpYaGxHenIwdTZ0dy8rd3JIVmxx?=
 =?utf-8?B?cVhqK2RqYVFPOVVOOSthL09kMGVGeVYzb1Y3cFQ1a1F3N0ZmbEhtdEN1ZTVN?=
 =?utf-8?B?NGpNZTJoQkF6M1hqU21XVTd0VGxvRzdUTDMvQUEyOVVwVDBmKzQ0aWNoZSta?=
 =?utf-8?B?MjljdHVVclZwOWpLQWZlTVBmWG9qS3lYNm9LZGZxeTZ0VU5hUDcya2dxeWs1?=
 =?utf-8?B?QWh6eERTMi82UWpwTVhlSCtGazh5bjIvSG92RS82RDJXK2tUaFIyc3A4bnVu?=
 =?utf-8?B?ZFFqZ1hyVFZ2VnowMDF0L1VnWmlLMGdGV1U2UmlDZDJudXhXaWlVdHNuaU4v?=
 =?utf-8?B?VEphcy80SUF4cWxjaFNBNXp2R0owVGxKQ28yemVjMXQ0RmlSTzBCbHV3WTly?=
 =?utf-8?B?dzdyaG4wa1I2Ry9DWC9WMHJtL2U4V3l5dHo4UkM2YTNLYTloK0MwMmtWWHY2?=
 =?utf-8?B?NmRPdmFRb05yUG41NzNnNVRTYXVPaDJEMTZKMFpNNmFwT2o0NlQvUGlsV1VR?=
 =?utf-8?B?TEVRSXVUc0ZFSGJLN3VMWEgyVHc5ajNDbG0rVHBERFBXN0lWQ2U4Q01icE1r?=
 =?utf-8?B?TEpmVlhmd0ZZQ1ZRTGNCeEsxL05PSVpBcDRuYzFSQldjWlBYOG9YNVpmMncy?=
 =?utf-8?B?R1Q5bEhWMUtPTzdUcWU4L216N3d5U1FJOVQ1RkRDdkI5d0lzMnVReDdkZFhB?=
 =?utf-8?B?cVhhc2NyL0ZmVlRVNDR6N1FiZG5ta3puUjJiU2pYLzdHeGJpKzRlOVMvc2FU?=
 =?utf-8?B?ZWRwUmQ4U2lyTmN6MXB0bFBkV292TkJQUnhiTmJTYWpSVVZVY2RXc25FeElD?=
 =?utf-8?B?K2pjdEhwWkY2OWl1K1A3UC92RkdOWTR4d3lHY1JKTnJXSzcrQ3ZVWW1uQy83?=
 =?utf-8?B?NG95Q3gvUnFTNUhEaGpzMk41enhRTWU0S2RGd05hOGZsQzVzMWxXMDR1V28x?=
 =?utf-8?B?bzd1bFlYN2pRTTB1L0hKTTBidG9FOUNVTnJPaVNyajVMMGI4NXlNbW5ubCt1?=
 =?utf-8?B?ZDl2SEp2eXNocFFySFhtRXFiVEJQcGZZSTlwK05ReDdZZU4rK3VkaDBXRTJy?=
 =?utf-8?B?bXg2cUY1VVdsaDJpNGpBc3o0UjdBajkzOGtmNFBVbGdiMmdCUGRFMDlpdW5x?=
 =?utf-8?B?Yjc1U21oVWVNUTE2YWhuTVYwTkNtTy9rdlM5UXVtUTQ3YUlxeWhxcG5BY0NF?=
 =?utf-8?B?cGRPZ3UvMCtvOTlwVjJ2RUxnQThLWmNGWjlnbmtJM3lhZXdUc0VaZ0RsaXZs?=
 =?utf-8?Q?zpQw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e688fb1f-1204-4f0a-98dc-08dc5927dcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 06:31:32.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLmujXCnVLGmcryuNecpcUym0eNdCD5fitqUvyJeyz09BR1dh0F2KKQKeSCrkP6zoueA0KB3pHVxwgRw3jv7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_233143_698152_9BECE20B 
X-CRM114-Status: UNSURE (   5.55  )
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

VGhhbmtzIGZvciB0aGUgcmV2aWV3cyENCg==

