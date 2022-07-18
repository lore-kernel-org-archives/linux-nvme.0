Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC922C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 21:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JCxEULfZg7HgUfqItgD0qjKC+aJYgb0vuXig5JCMEk=; b=oH4U3K7kUofQrIHg3E4JyFvrGP
	gCsF51Ft3/cdDfzRkEtcwpIWWWklpt8t3vKB3oAK5s9OynLThSNMWEH+Aymv8PRSNfqmO11ikfWlp
	+INxyhayezVuDPNpiyeGXxStT5XSvJuVXTNBCB5DDPZuTNT+3a+wmFgkDjtB3O9h+XNdJR6X+2SL8
	4jSrvJ4cP1Nx6DiJVkV3zkIvMzbI4Wa5Ve6S6izNuoXxb5oFLuTGk7mMQrWI5xecTWlEhuJOqHTq2
	c7WiH77vZWO51uMl/zzkSwCF8D/1lRYv4miudVyE/2oNysoU4ROl2HZ2Mi/Tq5Vd7FSKPVQr46U8I
	qEa5ZJdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDY1r-001ReF-Jn; Mon, 18 Jul 2022 21:11:47 +0000
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDY1o-001Rcl-K3
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 21:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEIxxgVkQJnkyCP5Fg1WYf3y3r8OSjUKlLcqsN1aS1JwtXP//F3AeUu/JKYgO+aBAtF5PYg32+pNg6K4jGX7lgzXz1bpfZcIJb6MUEAaRUh5iOWDPpy90GCeTEJ4e/JqUU/XTgAr5X5c22M9mcaFgK3PHrpQDlPkxj/y2n1bQxdgPmCQMNM/RE3g3CbA3LLm0hzL4MvhhIuJH95ZUJhxUas8Kb9hRkfc7AfL1/1rE0PKKVMLnmeo7wEAK9dr6sucCZpUxlPqpJPXj3snuAUXhVg+6IZlC8AD39sgW1M/O3wHz0B/iBA5VH33UqD/SibLmE7dV+pF08h6o88cOh+bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JCxEULfZg7HgUfqItgD0qjKC+aJYgb0vuXig5JCMEk=;
 b=d3hEpBr4/Hbf54xZh1ayZldL7+mMT3pKPGO/0oOVepKa54bJc3dm77ujn5+ONcWDh/OJErTrjCUg4aNQfrPdHg4Xag5cOV3mV3inFlZdn9MBgrl0TNPeODcWcyTByAdFrwmnQnik1sktoUIQrk9UQsI0KcHoS17FbTrs9f/t6hZpRLdV1POF30hY6HHxk+6GvoRAfk9U+XkP40xwHsDbRDk0a+c6YLoD6UgrbabQoBuqfigoWxrolmUyTO7BvIVgVn7Xk0G+E09a2YRzrWFE0OV4C+brqTGj5L/k5A7peJYAJdB1FXb8B2l+PRVUXgk2ibt+XvOHVySriuXVyKSgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JCxEULfZg7HgUfqItgD0qjKC+aJYgb0vuXig5JCMEk=;
 b=p15TN0oez3gebVGnOSd/loLv6T1hZnYCbLG79+nAloTPGwxiT3Hk6cES2zJcrhHo56Bz3mN9svaVcDSf2ME+qkec4EbhfcGvGZ8MjNC8aPBW/2LYynrO1OYQLDLU/QKKOkPwkMTKtoSWBP2Lmav05xIZR0/IZaJHWTp/hre3PQDnStqCxOPCVL2scpOmS11zB0NpE/w/otkWCnkTaRgoDlThuD+UujdXNUkej9aqLTJN4aJ6QrbD+pYFs65v5VMldaf7nEmWTup+3e1WitdTqyroP7oGNljGUZ/J5zs7uCQtt8DC9Q62FQtnUaO56Rzp4xED7XLaF1uhuJ+WNFCLcA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR12MB1860.namprd12.prod.outlook.com (2603:10b6:404:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 21:11:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:11:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>
Subject: Re: [PATCH] nvme: don't always build constants.o
Thread-Topic: [PATCH] nvme: don't always build constants.o
Thread-Index: AQHYmmUlEFavnzKKx0GAUzzz9ip6462EoSUA
Date: Mon, 18 Jul 2022 21:11:39 +0000
Message-ID: <3d761060-1c88-dd77-0fee-0d77d6cff566@nvidia.com>
References: <20220718051252.231757-1-hch@lst.de>
In-Reply-To: <20220718051252.231757-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f676823c-c7a8-4503-e536-08da69021b14
x-ms-traffictypediagnostic: BN6PR12MB1860:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  c1LCbor+lSunKSgQoivKrNMcO/LYgQppHwK82jpUqvPJOK+wN91GOeavRfbZIrXRY2OcxJeKE4ezImczzadI+sb+ld3UmieKdqpJI/sreejdGqIGNWvvMo9CnNGnmyxpsKdP2nGtxXg1FLESa/ymUdX8oBTYEriTHw1FBDZX6vTHOaAhOaIuZYxkeXFoWT5B4TAOZ+Z/LeXJ+f05kavGvsIwjwzb3kY3raWQXjK2UpZAdqva5wapH2k6wZxnqdQ5vq6eMJIEy7361bCS5xGxDFTxxcnidiK0WE+XjDoVpFokhUaWqxcl1X0mQopDAX5KMRAdxXr1V5s2Q4m7ibcLWs1wI9O6+JcMasKcgXRE+HwqiQIv6mgLT3OsM26aR1vEdj/ZS6+mbTR2SDN+vg+JPErj6wz2CQJteOcEB9U/NTdF1csUmwAiNjYVxiqK4JIJMT5On+Y01FC+P5HWRdDEzQlR0zefAJNwcP1xLNLfE1cm/5SJPiY9MwGXisXBtYa4L4YxuJNhcHkJIVbfpp4zbPcr1Rg9o4MhvL3Vh3FLKFiTp8E1TI+8iHDR3/xEGNpmDhDERx71VlsKx9dwMN+DBmAudIUr/8bSAXxWxIxtNprOKcgOAUUGXykQrRMcbUrA2nrFd4kgJGF1JEWpf03BfnY+bjU20YYcErmq/ywgs5eI+6h1LOguQRMXckHau0VORDsXb6PM+dJjheNbe4mC7c0lszgiIJu9ig7+S+ZPm6txV3P9tnsMT86zUhSVT8L3mdCtgWV3oZmYvpamThmlag0Z4caYuFFBHjgZNoL4/Wl3T65r1r2KG9hbRy0t9lGwV6tKscC3gPv3vByyaU25mUJ8/kEoYza3LqYQZHvIfV4=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(71200400001)(478600001)(6486002)(38070700005)(2616005)(6512007)(53546011)(31686004)(41300700001)(6506007)(91956017)(186003)(316002)(36756003)(38100700002)(110136005)(8676002)(66446008)(66946007)(5660300002)(66556008)(8936002)(76116006)(66476007)(64756008)(4326008)(86362001)(122000001)(31696002)(2906002)(558084003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?U1RMVmh3cUtxd0xuYnNId3RseCtkTzJvTTc1bWw3OHJmSG5WYW5ndzgyOUJP?=
 =?utf-8?B?TXR6WnJvaC9XY2FyOFNKYWNLSzc4QXNTbFh3VnlmTXFCczlUWjVVd240dERB?=
 =?utf-8?B?VnR2SC9UOEpibW9mRzNNK054b1RRRzFzR3FUZ0JsTFllZWxUK0NDQ3U5bzBM?=
 =?utf-8?B?ZFpBU1VHa2dZNUpGZExKV1JnSHhja0Z0TTl2b3k0TTRUNU14WjNwNFJNU2d3?=
 =?utf-8?B?YlhWMmxJRTZJUXArVmUwYXVaVi9hRFQ3RmpxK09haEtkZDZYN2d2dXNveWNK?=
 =?utf-8?B?b1M2VDRLR3VPQWpwTEZFRE94ZkptbTQ1Ti95Mk1WVTFsdFQvUmtmSkd5YU9K?=
 =?utf-8?B?R2hnT2xBVEVSMkl0Y3FoaU9wOHdva3A2TUdTZzNHbk5aOEtUNFNRa3MrTnVu?=
 =?utf-8?B?UTJGRmZMZFAvNkxaRzM5aGpHazUrci82L0VuMlo5a25Sb2xINWxlb3Y5UHdK?=
 =?utf-8?B?L3BDNEI5VThvSXZYZEdtRXdLS083eVcwcUZJNVNLckZwNFdidXJYZE9NOUxV?=
 =?utf-8?B?RXhHbTJCWGtQWjdhL1U5dUhkbGVvT0V5OUhSMElSTEJtYTh0a0NtMFJBNDJC?=
 =?utf-8?B?ajhrREE0TFhsWHpoZ3VaWCtrWHVxUytKVUg2ZnAxbUNTR0pXNjFBMzAyc2RG?=
 =?utf-8?B?dVZGK2lSK3BjNDNaVjhpK25BT3V0a25lTnJzNnNSWGM1b1lLU2ZYZjI4RDRY?=
 =?utf-8?B?UkVQVW83VGVXdVU1NXZ3ZzFVaFZ5MlhmdVcyRXRhOXQxM1BWS0s2NkZpVFhn?=
 =?utf-8?B?REZMMjZvbmJvcVZMZUx0MG82blU2TWVDK3VNYXNJRFk4RWtOcXM3TWtjSmVY?=
 =?utf-8?B?czdJNzdCWXg1QmVCd1B6dzFaOXYveHB4eERTYThzKytFSWtRbythTmNwenY4?=
 =?utf-8?B?VGZpNkEzM2kzU0x4VllGYWVLVG5LdndQbFNJUTcvR2ZlM2FzcTJKNUxzKzRU?=
 =?utf-8?B?UlNsdWNlQ0Y5N0dRQWtIU3AwM0g2em8xaUZLb1I2OXhVTTBUYzEyaXFOc2E5?=
 =?utf-8?B?UkFxa3hlT1RIcDlDbWM0OGRFUzB1anE5RXNCTDJYbnh1WkcxbzRmcjdkWGpM?=
 =?utf-8?B?TFp0clQrdDNUeUhrK21YOEhlalNTTWZHdlkrQkVyaUtFS2ZHS1p6bk5kZGQw?=
 =?utf-8?B?K24zUm9FZlJOaXJWdngvWGtCallhcGRVYVVldndMMkVjS2FpcGJCd1lkR2Vu?=
 =?utf-8?B?cVZ2ZnkxUU9BYlNJSGwreFRkMTF6REwvaXBvdXdWdkUrWmJCYVkzejlzd1Vu?=
 =?utf-8?B?bkhEaHFBMHVRMGVQMTZWdlhpYlg4Q3hVdy9zZTlUeUtQQ2Vha3cvdERqRUJE?=
 =?utf-8?B?ZmNhUHh5RjBUVTBBVEhGTENCb1FjVjVobmI0K2h6b01wZGtQM05vckFhMUM3?=
 =?utf-8?B?THpyZEZSNWFYSm1HNlVwTUZDUDBCOWJYTEl1TkpIWEZ4ZjRnYWFra1B2TEl0?=
 =?utf-8?B?bjA3dUFpbXpLNU05V1VkeWN0RENESGhXZEF5WlRMbFczazRjWHovN0E2UUcw?=
 =?utf-8?B?MkJ1TWRNdEtJYkhmdmRxeVl3TFR3Y1N4RlB4QXowTDA3SlJlVEJVUm5XWVNz?=
 =?utf-8?B?UFRSTHhTZ2orOWlyMVlFNitkNm1FcTFDSEk2RzI0T2RQZEY3MUhHNk92V0hG?=
 =?utf-8?B?aHZ3SURvZ0hyTURRTUVaUzJwVXlZRmtyUkRjcE9wRlBKNVU1QkdZV08yaUVw?=
 =?utf-8?B?TFU2M1pObFZqb1hJV1dGaTZjcTBzdllXS0VNaGI4RFJkWmVDMjBLbGlMUXdr?=
 =?utf-8?B?NE5ZQVhUc3YzYjZlWnpvZmVzR0VIOUpxajJGQjVMVnNmZk1CV3VRR3pWdHc3?=
 =?utf-8?B?UkdnbFRPaVdCeUQ0dkwvdUNVek5leDBDcEtrelo5VTVWRWZOQWMxS3JCbWZ1?=
 =?utf-8?B?VTZFbGVLL2VHZDd3SFpnd0x6NkRFbllPUFR0Z2p5c1lWYTdDRWNEN2FYdy9k?=
 =?utf-8?B?RlUvdW4zVGRpellvL3F3Rjh4c2VSVWt6OFFGS3FKVFF6M21WMDNBVXQ5TjN6?=
 =?utf-8?B?eFJVeld1bGZPUVlmeDk5cHJZZWFVb1NvbDN6MWI0SXVnei9mc3BickJJYkN5?=
 =?utf-8?B?c3NVeTRoR0d2ejBIK0xkRUxxTmNTa3RiT29YWFE1cUFwWU1SdFNyQWltR2cx?=
 =?utf-8?B?Z1pTSDJHK1RlaTBSVXlRV001ekpPQjFDcDJXdTdNNFNWNFlVMmxoZzNpL1VL?=
 =?utf-8?Q?E7KfMDqk1Z+B7TFCHVlMsYtRvlXMzUIJYMtvAvt0ru3h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C4B4DFE4A9D6F4582548DC320237448@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f676823c-c7a8-4503-e536-08da69021b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 21:11:39.1083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLO8OVWwzOfG694wkljb/7rJzUwB3oirY7XphEv0JRfBq3l+zgrbUquwXQAdXai+KuA5lXLbWkZaUfxlN8OKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1860
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_141144_903137_E8EA571F 
X-CRM114-Status: UNSURE (   9.69  )
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

T24gNy8xNy8yMiAyMjoxMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBlbnRpcmUg
Y29udGVudCBvZiBjb25zdGFudHMuYyBpZiBndWFyZGVkIGJ5IGFuIGlmZGVmLCBzbyBzd2l0Y2gg
dG8NCj4ganVzdCBidWlsZGluZyB0aGUgZmlsZSBjb25kaXRpb25hbGx5IGluc3RlYWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoN
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0K

