Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA3FCCA47F
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Jul 2022 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7jIllrcNm/spyCwY066amMjVjiAyBrUrDTe7OU93NA=; b=192f3z1jMqd+MBC6QyOV6+LBNk
	NPJtCVB/Idyzzd702gjiiCxVKgo/bJmn9UaxE4jeCJL8sMQAHuvwxirf/qvZWvgZW6mWO2t5mns0n
	mL4NunrPqL8TIUb3KcFCdh4qvx5cQI7aJ6/Uki5hhYfIeUaXIfpDkSzA/bUByLcpJ6oWS6RuoGU4m
	s1+SrOaKOR2w4+tMetvLC6xQJS0qg2HxbW5y9oE0JB4+NTXdT/BYOBllqMkDd/a+ZUthdlKLuICGJ
	WLSC4UC9Rn5Bk+7QveDHoFi+rzu1dqyimuwfRP5/ze/Oo2SFDQgMf3gbAZKsbSNiCZ/lqat+UTDD8
	sLxgb25A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7DBB-003uy2-76; Fri, 01 Jul 2022 09:43:13 +0000
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7DB8-003uwG-7d
	for linux-nvme@lists.infradead.org; Fri, 01 Jul 2022 09:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov+BIIgJIHcvdw9iR5DIJ8Rw3JG+/vnxPzFHbfzrk16i0Mx3KJ7PyDf9yeg0kaDCuoXUKhMM2owSuFpFrdFAxXCIqxZLiOPwCkUBsRSwx+AX7AWgITs2B5yNlYAwcakfwnAGnbuWHIy4qVbtUjiCE3+6nTo260mwe1qAd5pfCBEWrwBwVVcEwNa8wx7Hx3WJefbe/1efLXuwYdMXNyV62X7V540bCOQTop4FVzxu2ZlgooJm78HUQQYUzz7uQRQuh3a3qDTx03Oyqx/NPx8cysRYyXtJCcz5tUC8DgRs/OXe/v5AxTp7mSkdBkN7jPAZH7F6t2KqXeEIJY7YyjJgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7jIllrcNm/spyCwY066amMjVjiAyBrUrDTe7OU93NA=;
 b=Zp/CKZfJnHLllKg9EsCCTphI0Tsd5suPo4sYadJyKcULtR7trT+ZVGhSNaZCFB/pSe7rI7kFv7KSWcRt5nMgx0D64YTcUCVUWzwLUaeF4N+r4SB7fOVbQinP6zZWfk8RroTLSpvHm/as7+dM/ecp2Leg7IfxeLNOwxHzZ/WetICJB0+t8aoNM24bLQtaHY5SkD66s42jcLFwuOt/g/FIS51dOPM+16tQh6LKBe2zYbMhPFIczIOCPj+M4s8qpNOzfHLXzskyEcqjyLJQcpQy7oBGryNi8fzF5zuioHLGXOb1Hnm9pdQPpDR7dm73VpGQEG7lIn7r88Bx419DirJ/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7jIllrcNm/spyCwY066amMjVjiAyBrUrDTe7OU93NA=;
 b=mUVJNKtPU6WnDddzAbWGVQcCNcYGnI9ZSbgkw0VEa/qW+ciBTwlqsFkNRL8rXcVHeOw0gRaNufNhGcovj6mi/JJJ2omt4FkZ/x08+3josb56+0K2mD4dwOmVDqyc/txrDCu/ddf9mHOc34m+xHayR2KZjG5RZmk3TZa6HBR0jA+SvvgAaq8Bxc8CIG0lEcSd12egCjMGo5REAp372ft3et8TGxJ03NQXJ7AwNBxMGGGjnDS/qzrA2KYpkWNkYUzI9c44QxZJF9ooUZNcuBm/Gw00lJrGEaGMzGIhDz39gZyS6s6NuM41/UlD2QKPc7AHLyZQnvZDV+pnXA7+6JSO6Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR12MB1761.namprd12.prod.outlook.com (2603:10b6:404:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:43:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Fri, 1 Jul 2022
 09:43:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Hannes Reinecke <hare@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Topic: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Index: AQHYjJiOXRUbM0a5XE6vAZIRxt3SRK1pRLmA
Date: Fri, 1 Jul 2022 09:43:04 +0000
Message-ID: <dbb827f5-6202-eb09-dc32-d49d00d59cd1@nvidia.com>
References: <20220630154444.475600-1-sagi@grimberg.me>
In-Reply-To: <20220630154444.475600-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0a5df98-834a-4210-7e4b-08da5b461872
x-ms-traffictypediagnostic: BN6PR12MB1761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  fR9erlYnZX/kJ0+HkjZCyjmQXlHGZimgEIhRywXiv4JneSgWuJNIseZSYYAmSd9kwFb6vUQltSUlWDY5/4iRo7wx4p0bPrbdj4tHsn7rJ8OqMpNdh8XKGOrA3oRSl+XYmO6x1DpHM0xhjmL85Gszc/chy3UH8zSWSkgGDMkYkuNvYOeuVs9h78kTX+UfMnA/dCDmWJnmD7quxO5YLvvI/JKwLbuhDh7cl7TKJ8jcO6EbNV2qAktbGJmRFSU/M7ntouRhgAJKOklSE0IYVR/SnoXDrf6cWrjwKgzmi09bDdm/vlsRusb9T/iIhZuhK3J1aycE5QvOwFsQNVqHEemSXN9JOyzGu+ofCH58AeWWzxWgfXkLbgzSbGj2+wVSL42OvMxpTHNsOjJ/teBTSOFu6Dz75o3UUKA1ybWASulWJmUm9/1tbQ2WpDct7sOrcPWAukrjVW7Na2WkIpi+P6mkpF1QQzR3CjmNnMgPf1XhY/JbpaiTvh3XeGS+ILf/18gnm+L7hgJzITRiSv4oLMVSHUpaWjFz+cxejo3B4PHJ4w/+TXSuVbBTRWpdkGmSEZ3Sos5093C66cVe9KU8PS7QHwfB1zO9n9ecHxHz2oKSF63F2+bUBkYIPSCQiAs+lINBqaY85T8fRBaRhjQZxQZLa906FO0Z6wHnSJ77UvNuSTOiwei8vHsEREyyEvh73KLRxsrgfBTap2ezRW9u/IejhbFunjcfofta58E4bTlqB7Nu6fn2fGnlZ07QMsSlmM/4sLHstK2oJLtIIX3iv8E5ZlnwAx7z8R6QEZjZCrp9+W74FYnKY5gasKqWKQnvpIrRV4VaOsYnYnz+pknCtNiAZsb/yG125Dg8SmGKWZms3o1X2OXnP6ItfZAu/U3tlxMc
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(2616005)(2906002)(186003)(6506007)(66946007)(66446008)(41300700001)(83380400001)(86362001)(8936002)(6486002)(31696002)(5660300002)(478600001)(4326008)(38100700002)(36756003)(6512007)(76116006)(316002)(54906003)(31686004)(122000001)(8676002)(6916009)(71200400001)(91956017)(64756008)(38070700005)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?T3BkKy9zVHIybFNTL09VQzQ4WjltdEg1N0NiVk9QQmNsU3gzaitCbjRLdjJq?=
 =?utf-8?B?STY1K0NhOXlvdzBpWmc0V2lTU2NzcEJ6d3NhODQ3MlU0cW41UWIrN0RsLzJ3?=
 =?utf-8?B?S1VIM2xhOTNoKzZrZXJpV214dWdIV05FQzlUYUFhL1BMZ3lyMHBVNnVpWFJr?=
 =?utf-8?B?c2RXeUl0T2tXM1g5dTU0bjlzVktwU3NRclovZE1odmJYNTVPT2FyMDJCdkc2?=
 =?utf-8?B?WW9GRFNCVk85UCtVWm1UTzhFR2hUNDFhYWlLcjE0eXNKL3RaVXVHd3RLMm96?=
 =?utf-8?B?cDY5RUtZZjNjQXU2TlBIYWRwdzJZZUlOZWNMMjlXdDgyQ21CQlJQRnh2YU01?=
 =?utf-8?B?Y0ZGODJRTkQranhCckQ4K2huTG42dXoxVWZxM2NoaEtDY0RCUDZyNHVVWXdt?=
 =?utf-8?B?Nm5lKzRBQWVvU2drM0twTlc1Sm9reEoxa1g4dUFwak1IV1NHM2hyOXpNODIr?=
 =?utf-8?B?RjVtZFd5QmwyOW5palUwZktLT0N3Z0ZOdzJieFM5aGhPY0NMUXdsdlV6MVht?=
 =?utf-8?B?SHM4L3A5ZGNvRjljb21INkxIUkJXaWthdnJxSUh6Q3Y1eHhZZ1RqeEppOGtQ?=
 =?utf-8?B?czhnbHJDSmZhRTFXeHg5bnhaZDA2YmRhTXdzVWJtd1Nhd3dSWVl1bWMwN2lK?=
 =?utf-8?B?L1RZTmExZGVZelNkaDRjeVFRem9wTUZrOFB5NFo2RDlFZDhKaUJBRzdGbVFF?=
 =?utf-8?B?VHRGZ3RtTHRaNXBxaXc4NXJRTHV6alo3OVhkQVRJcGlvcEdydVovUWJKQ0Zv?=
 =?utf-8?B?RTNqMVgyTFNITU1hb2pVeU5USWozaExtVC82YnF3UlMzQTBQaG1YRDM0dTNP?=
 =?utf-8?B?cFkrbEc0K2tTYnRQSXpBOG81dzM5U2RoR3k1bjNreDV1UmltTmlYRC95N0RC?=
 =?utf-8?B?cmJiaEdWSXN0L0NpTFhxREE5Y3BlNXlqYVo3UGwzcFNQak94UzZsOTVDbTkx?=
 =?utf-8?B?SDREYzRxTTNQV0F4d2NSTERRdld3WStHbk1pNTFXSHlpWG14ZERDcXp2ZGkr?=
 =?utf-8?B?SnMrRlhQNTJRTzFVQkhlaTNQQzVBS1VuT24zQUd3Q0dhblB5RUdPNUdyZTg4?=
 =?utf-8?B?WGcrTjVHS051dWgvejB6VjF3SXBXZnRMVlRqU2NJaXVsK2pKVTFZa2pPU0hl?=
 =?utf-8?B?dlJXVEFaL2VkbEw5R2NYRlUrWmFBL1hSd2cybktobWxGanJua2NodU1ZUVd4?=
 =?utf-8?B?bVV2NE9DMzdmbkwxVWdBdGxGajdrdENXeE81SlczYjJqMHFuRlJodmh3Vm1T?=
 =?utf-8?B?QThMUDZUWi9QaGJSa3lPWlB6MUdmVEhoR2NlNDBhSjFVdFhNMFBHc3dxRHlN?=
 =?utf-8?B?Mi9ZZ1FmS0cwRTZXeE9XSHBpbU5qK085QUdpY3A3VmNHTnJtajBPYm91eENF?=
 =?utf-8?B?QVRmaTdhaTIrT2hQK1lqbDEzUW1IUmFQNlRuMnMxc05hQzE3bmNLaDlNRU9W?=
 =?utf-8?B?VjE4bFRZelVUeUJqWE1BQjVVYTZRYldnZUNDSDNJVmtORmZ6VTF0SDNyRTdr?=
 =?utf-8?B?R3RmNUhiNVVKYXA3b1Nra0xkd1BIR0N6N25PMllyS0kyanAzbFJBZUsvWWdO?=
 =?utf-8?B?YWtaemtDM1lmeDlMODdWT3RUWERoa1p6TWRUVkVublgxL0FEcms2SlRQWEdk?=
 =?utf-8?B?a0RGMmlJaTZmM2cvQVYxaU1yQ0EvRWJ2L1BxcC9tVytBZStRS2ZxbUdZTHEr?=
 =?utf-8?B?T0tUUDNwemZKYWpVTmdzeFJmeWhpMlRLamxIenJZVXp3bG1zRlZiYW43OW1L?=
 =?utf-8?B?NEdJT0lRMTVWS29QbGM3R3NlcmV5Zlg0MXdSYTg0WktyZGJuc2hCb0Z4UnVK?=
 =?utf-8?B?RG1wK2xSdUZSbkZWWVdkMm4wWmtUN1NQYnpFbzVSSjNMV0xsWEtHVWxuS0NN?=
 =?utf-8?B?STVPTUhGZVdsQ0txMlJZNFhFZTdHc2RXZlN0TDZNSy9PeFVMVGUweWE3Nkht?=
 =?utf-8?B?SEZDY2t0UjdnYjJvcGpWTVdiNUdTdjZaU1ZHOFVqclUrODNxOG1vRlNaNWNI?=
 =?utf-8?B?UDNmc0dWWE9IT3lCYi8vZFk1bmdUL3F5cDRtUFByZWF3aG90RTBSR1BsNkxy?=
 =?utf-8?B?T0dRNWtLTFBKbmNtQWV6MW1hSTFadDN3ckNwdWlvd2Zzb0FTZnk0TXBYV1pP?=
 =?utf-8?B?emxIbkNMTXVpeUpvOXJ5c21aY3BseVo1YUVMcnZMQlVtMGx6K1hCSC8vK1No?=
 =?utf-8?Q?9maOjNyWBIs/YpaC+1wqia8fVyX6oA9/rVEJPUwG7bsx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5AF81E9F1CD524981A666C269274B67@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5df98-834a-4210-7e4b-08da5b461872
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 09:43:04.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQbK6he9OKG/klto5XY6d1KTQ6pnvzEsX2xGglKVjs3zVxWNDrP7D2QX0PexPhOG0p09cjfHLhism1YdknJPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220701_024310_494704_F2B7BFAF 
X-CRM114-Status: GOOD (  10.83  )
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

Tw0KPiArDQo+ICsJIyBkbyByZXNldC9yZW1vdmUgb3BlcmF0aW9uDQo+ICsJZWNobyAicmVzZXR0
aW5nIGNvbnRyb2xsZXIiDQo+ICsJX252bWVfcmVzZXRfY3RybCAke252bWVkZXZ9DQo+ICsJc2xl
ZXAgMQ0KPiArCWVjaG8gImRlbGV0aW5nIGNvbnRyb2xsZXIiDQo+ICsJX252bWVfZGVsZXRlX2N0
cmwgJHtudm1lZGV2fQ0KPiArDQo+ICsJZWNobyAic3RvcHBpbmcgYmFja2dyb3VuZCBmaW8iDQo+
ICsJeyBraWxsICQhOyB3YWl0OyB9ICY+IC9kZXYvbnVsbA0KDQpkbyB3ZSByZWFsbHkgbmVlZCB0
byBraWxsIHRoZSBmaW8gcHJvY2VzcyBleHBsaWNpdGx5ID8NCkkgdGhpbmsgZ3JhY2VmdWwgdGVy
bWluYXRpb24gb2YgdGhlIHRyYWZmaWMgYXBwbGljYXRpb24gc2hvdWxkIGJlDQphIHBhcnQgb2Yg
dGhpcyB0ZXN0IHdpdGhvdXQgZXhwbGljaXRseSBraWxsaW5nIHRoZSBwcm9jZXNzLg0KDQpJIHJh
biB0aGUgdGVzdCB3aXRoIGNvbW1lbnRpbmcgYWJvdmUgbGluZSBpdCBydW5zIGZpbmUgOi0NCg0K
YmxrdGVzdHMgKG1hc3RlcikgIyBnaXQgZGlmZg0KZGlmZiAtLWdpdCBhL3Rlc3RzL252bWUvMDQw
IGIvdGVzdHMvbnZtZS8wNDANCmluZGV4IGQyNTk3ODQuLjBkY2UxMjggMTAwNzU1DQotLS0gYS90
ZXN0cy9udm1lLzA0MA0KKysrIGIvdGVzdHMvbnZtZS8wNDANCkBAIC00OSw3ICs0OSw3IEBAIHRl
c3QoKSB7DQogICAgICAgICBfbnZtZV9kZWxldGVfY3RybCAke252bWVkZXZ9DQoNCiAgICAgICAg
IGVjaG8gInN0b3BwaW5nIGJhY2tncm91bmQgZmlvIg0KLSAgICAgICB7IGtpbGwgJCE7IHdhaXQ7
IH0gJj4gL2Rldi9udWxsDQorI3sga2lsbCAkITsgd2FpdDsgfSAmPiAvZGV2L251bGwNCg0KICAg
ICAgICAgX3JlbW92ZV9udm1ldF9zdWJzeXN0ZW1fZnJvbV9wb3J0ICIke3BvcnR9IiAiJHtzdWJz
eXN9Ig0KICAgICAgICAgX3JlbW92ZV9udm1ldF9zdWJzeXN0ZW0gIiR7c3Vic3lzfSINCmJsa3Rl
c3RzIChtYXN0ZXIpICMgLi9jaGVjayBudm1lLzA0MA0KbnZtZS8wNDAgKHRlc3QgbnZtZSBmYWJy
aWNzIGNvbnRyb2xsZXIgcmVzZXQvZGlzY29ubmVjdCBvcGVyYXRpb24gZHVyaW5nIA0KSS9PKSBb
cGFzc2VkXQ0KICAgICBydW50aW1lICA4LjExOXMgIC4uLiAgOC4wODRzDQpibGt0ZXN0cyAobWFz
dGVyKSAjDQoNCi1jaw0KDQoNCg==

