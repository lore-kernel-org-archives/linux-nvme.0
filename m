Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA898C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 06:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrdcjioohJwn/CKhYtzhCGCU/O+K/1ehBbneSgqRFtQ=; b=Rito7fJOMUr1C41gMrB/44o3SM
	ZwIFSyQcPLSbw5BmEErS05g5GeEkJyDJxWDJ3il1VRE2TBiP0e4QZW20B0q0MmPFGtXJNZi0FZNSq
	HwKPT7Ix02cu3g620YXwZ/FZ+jqg34O3XsxBmoakrEeo7hwV7n7wSUQl+a+UZSE7b25mYo0/D2dhq
	bw1E62dofWaAn1hA9vhiaB7hLNF3BjDWzen8g/ADqFEfYfy2ERwqDyPACdpYpshf3/jLuQsqf7xmN
	SxBaxixgYMLJm8dmTI1iAm0966VhUBrgX5M7ldGGDvyfORJG3NWsfs49LtYLV92sIIx8htyJj2fp8
	Z7d2U/Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAOZY-006MkE-2g;
	Tue, 05 Dec 2023 06:06:20 +0000
Received: from mail-mw2nam12on20631.outbound.protection.outlook.com ([2a01:111:f400:fe5a::631] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAOZV-006Mjj-26
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 06:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHWYiyjfVnE/h+bgGB+iAcTRYLFM+erAPgAS+TqBeB7UCzLsvyvQMtkqgHEI9G+Awt29Wdw1DpA/bVRWCznV+HGeSL4WCmD96S/6q7CwH9rgJRoJTTEKtNi+ORbq1lSiA4OpSjbzClf7V4BuaJ7/ucAhiNsfxAbAv9bxPNRNSMOyCrJSDztBE9E5HCSt1B+OsFQSTbtmm2shJm3ycXljzlW6fp2YT8NVUO7d5cH2gPGRdVx2jHXMCBd0jLyMZuQAQKNcvwf/9r80WCiutluhwouF6592jhvNmPjT6N7taC+Gny+JV4prBiToTN4lgzfOzEHNXOhlzNTLQDwhnt8HyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrdcjioohJwn/CKhYtzhCGCU/O+K/1ehBbneSgqRFtQ=;
 b=a1nH/+khU8I4E34W+sInA8Eqs82fnOXpAEiSKdb8pimgZvvLyIJvu2dPLc7BAxe27Jeq+/Fal/gFJINbMJ6VfuDqkkQJM4f5Wmnx/XYSjtXjjzBnnKH1LjIcnlscGX+v9tPKLM1bQrYQ7bjXN7fgIEXvsyEBnLP3GaMqNgvDhNy3gsr2OzVaplW3n99kQIzYfGxjXrqTjFmy0thI21BJxy/ZlpSouxkvCNJl0nlrUaepJlobVN26XqBNLVnzpgLL/lbH0tmT80ktVpLuVYjAJ4prWhUm7Ikv+1np6zhIF+ogGLBlqIpaYjfJbggx/ViKYel2OdJpXHD0yBMWY8nlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrdcjioohJwn/CKhYtzhCGCU/O+K/1ehBbneSgqRFtQ=;
 b=HywdeZqhV/q9Jfg2eBqYlh+FLTyT+qOj9Zet6WGjlkTuX4HLJ6NDViiW4g8CkpyQXGNxyKBO6JoxfMM2xyanaDU/vvf47m5nK7jEyQeA9rC/cGWsTf18FhRGhiN6q7qNNwsRT/vp+YAHHCLdi/rHnANMyIEtyIehVu9Ke7uz1zvCZCd4khMZo/y3+dzuqMmgSg+xBL2EEjI58AU6J5lBMgFkYDCj09PP7XsuBT9x8/glBGQHfmskFym5DAkMp5n+pkS1JDja30LFBL5Gugvps/UJ5pSAxGzXubGrZX2bqMUazDPMUW/4fPsQ2MGAdQot2ZHB4sxjlIQQizeC039T7w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 06:06:09 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 06:06:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "alan.adamson@oracle.com" <alan.adamson@oracle.com>
Subject: Re: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHZ3GF/546pqQEEskm1xtQBvfX9jLAL0q0AgAEBfgCACk6bAIALSdWAgHhc6YA=
Date: Tue, 5 Dec 2023 06:06:09 +0000
Message-ID: <a2ce93a3-0427-4a37-8c1d-b70eb34a23ad@nvidia.com>
References: <20230831231827.3896883-1-alan.adamson@oracle.com>
 <20230831231827.3896883-2-alan.adamson@oracle.com>
 <20230905065348.GB19754@lst.de>
 <9d199a50-9f0b-a69d-4061-d443e6286dba@oracle.com>
 <bb57e86e-654b-a4b1-e60a-7573e59c30ed@grimberg.me>
 <8ffd46aa-81f8-4b82-9bfa-1753bb7610c9@oracle.com>
In-Reply-To: <8ffd46aa-81f8-4b82-9bfa-1753bb7610c9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7637:EE_
x-ms-office365-filtering-correlation-id: 02ae76dc-9507-4cf3-f949-08dbf55846c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ktgcOiy+xSEphNA5rL9Hm39wus5IFLd6a1t4KYzBV6WPJGSeJPWJj8pIDDvkUrx++u5dhP2vcD8zB682HKysdl+B8dTPOqC/+xBjSAn3YhYNiV+EqPCCGyanFzv4PMPE7vR+QQBgvKV2nRuFumN98DBQs5Wxay8iH3NwUuhAZhLC3NoOYRFwxSraR8ceUfQbQheViQq7x9bysC0DnUaM5ze43DLT/rs/MJdBk3LQ+NERmpQGXA7lcbdfd+qGMP3YhzmZ+d78Fjmtv5SuLiSaz8wfuCH4BzcU0vw/o3LxNuDCVJniaP6DA2FSoYBU1Ktb0N4gOw/fdpjpTeC2OVd8VKc5uul18f7GYXRMndpMmFFbQKbV2Qx0SlLRyzq9bRg5ZnvRM3opGMz75AsuFTmNwGjYElF9b1ZhJ/HTow4M6Bb1Sy2PO8exk7Zr4Z1zcru+YqBfv/ETsyj9h7IB+A9hs2DrFGBq47cWuA7vk1jct0l20yWq17UmIEZF0w7wJHRe2J5ifvAlUwIr8Ktc+9B2t6NK7yrVtjq3MTU7SLlXAhlDzuyheUOXrCnboGxNDi+pEqQtrp6KZDyzBsVv+eLCin6d9rzOKeJEvo2jc5ysbubQuq8bjuN9lWcwxHVxCkpynlptFB/thYmVtQAZlDJWLs9K46xALmtPRRoNkwZfEt9AxmkCM0VaMTsvvpNn7tn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2616005)(122000001)(8676002)(8936002)(4326008)(6512007)(6506007)(53546011)(83380400001)(6486002)(71200400001)(478600001)(91956017)(66476007)(76116006)(64756008)(66946007)(54906003)(66556008)(66446008)(110136005)(38100700002)(316002)(2906002)(36756003)(41300700001)(38070700009)(86362001)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkdjSU5talNiaTZRYVF3TEdaWkwyLzFvNXhDcUFKbW9uN3F5aGhxVlN4a1dD?=
 =?utf-8?B?WUpXZHF5YVNTUXpZNDFhZVlFcDhyZkZia2U0SklHZ0U1ZTZyQ29vKzdRdTNW?=
 =?utf-8?B?K1BLbUdNL1c5UEluYXhFRWF6NkZQSFJWOU80dHI0TzFvYjI2SjRHaTBmZm81?=
 =?utf-8?B?ckRVVU8yNS91aVc3R01NSFBXdWFXaVlXa3Bkcm1odEpDWUhQOWFnQlJrdGVu?=
 =?utf-8?B?YXZEd2t3RTEvSVk0dGx5WUM5a2c3QVM5aTdnbEc4djcraVBZK0R4T3h1dXh0?=
 =?utf-8?B?NkVuRlg4Z3FTWDEvQWxiT0tMWVlDU3NqV2RiRGJHMGZuaTI0czFrS3VFdlB5?=
 =?utf-8?B?RjlhNkFjSHJ0TnVrS01kQUF6YS9JY1pEQW1nZE5RMW5aMGRUS2FkK1hwK1pq?=
 =?utf-8?B?MEZKVVBiZ01sYkpZWmNRTldoYzdNVkkyQnFsODZJUDVyQUlNdlZyalFBZkRw?=
 =?utf-8?B?SWtEU0lURlVlU29tTHRmQXdNNldxZGcxSWFXaTBoR1FwV284U2hMMUxOUSsw?=
 =?utf-8?B?UkYxeHFzY0V6ODFaVWUzcGIzYndyRW1NdmJBbGxrQlUwVmQ3djBUWHJVMnlL?=
 =?utf-8?B?bjBYWVFzdlBpOWFNWXRYV0VGNEx6RUw1UVVPOWQ5eTV0K0JNT3MvcEpBV0Fs?=
 =?utf-8?B?bzgvbmVONWRrSi9qN0pQK2p0TmJGWWpqOGlVYTdBSjhIdmw5d3kvbUhWTGVD?=
 =?utf-8?B?bS80aVg5ZDR1RUg0ako2NHNlbUQzVi85ZjJmSVk3bURsUjh4SXdiMHNBcElR?=
 =?utf-8?B?WWR2TUlYNEVFZ0czZjN6OUtOV3c4UVUra0ZWbGVuRldPL0Yzb2Zqc2hJSHdu?=
 =?utf-8?B?eEZuT2l6YWJkaXROMTdwS2NVODZydkp3K0F4b3dBQlM2TVNPL1VnYkR6NzJ6?=
 =?utf-8?B?alBuQW9GKzg1SzBXeW5Hb3ByMko2VTVBa3FJUElFRWZHa050WTVGQVJwZVdH?=
 =?utf-8?B?eVpQdmhITDlNNEw0SFBTMUoxdS9OeDlrc3l1N2I4NzQ3WHVhRm1EZktxV2dT?=
 =?utf-8?B?aGZuMGdDeWlXUUxrUFhoc1Bpek9TRml1MnJTc2h2Tk1yTk40Q2pFaVBWc2Rl?=
 =?utf-8?B?bGNFUUtIbHYrbjdOejIwUWIxU1FnTkhKR1dBaGwrVTJlc1ZwOFJTY0pRYS9O?=
 =?utf-8?B?ME9RbWt2RXhWTUJWWG1vYlFLWTErVmRQRHZ6aTdGNDdsVTBrVGVFVkZZZ2RQ?=
 =?utf-8?B?RlBEZUVwUHB2TzBrVGg4YzkzVlRSbDgvSWxaeXFRZWVvaGluWUlnUmEyekdP?=
 =?utf-8?B?a1RaMTIwbEY3RjNZUHNzUmYwZDVIaFdQbmlvTUR4SGMyNTI2Y2ZIQlBoWkJF?=
 =?utf-8?B?YkVYTk1HazRla2ZzcmhVY0VTaXVZaW5kbnRGMmNSSnFxYUpHOXEzSGpOZDBr?=
 =?utf-8?B?UWtiRjh4OW83cVVtQXphU0VQbFB6QzBod2VnQXo0dWNPWTI4V25ESU01c3k0?=
 =?utf-8?B?M1ZzbzZDbW55STFBb0NuK0JyTXYzMlNZalhiT1Q0K0VNbmdlL0ZUREpQZU1z?=
 =?utf-8?B?UG1IdW9Fa2wrQXR5NmhZanBJTk5TcFcyVEwwV3pJREQ3OXpjaW91WWRGV0Mr?=
 =?utf-8?B?bnBTLzd1WStEV2Y0SGo1VUJFTFlQVWQxL2QxekhuR2t6Qys4bkg2MUNUZ1pq?=
 =?utf-8?B?bWN3Z2lCc0dGYTVLQVNpVmRXK1VSZ1lWVWNVUHNETHdNeGJ6MnhudDdMajNN?=
 =?utf-8?B?SEJ4Yi9tY014S2tBQ3I4cTB1TjRGYlF6R1BBM2Z3cTRDQ1pCWkw0TnNGZTlV?=
 =?utf-8?B?OVFMcGpHenB5cUk2YXVGY2thSFBQWEdsVnl6ZEhCMjV5dXVPUWllK0xDUFR4?=
 =?utf-8?B?U0VMbXhLaU8zTTFlNytYMUlPZkpwRTR0T1VlSThCcXV6WmJxcGNBQWFiNjF6?=
 =?utf-8?B?OXNOL1lkVnF5WmZ1UGQ0UnF5OWhJYkhWQ0lxazBxZ2dUdk51V1czaU4zc04w?=
 =?utf-8?B?ajUvN0cweXNaa3JNdWppcW5vaE5QQlQ1VHBQK2g1M3MyMFRpdTM4a1p5TExK?=
 =?utf-8?B?QlNuZFpGTWhBRUd0aXFwaHJybUpkSk5JWnpGd0p4ZHMxejVMWE45QmRYTlBB?=
 =?utf-8?B?VG5MVEk5MnJPRlEwT21KR0IxakVpaW9CazZpUTlwT0YyUm8rT1IxMFVoOHJy?=
 =?utf-8?B?VHhJQktjL01NMzhWZmVlZkhMdkdNRjF0OFVGVXljK0srOXpFMWZwakxHNWRI?=
 =?utf-8?Q?csk5KUNdwfwe6J3/pzuMK+KOI91v4beB2NOvNR4dfYOM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7E5335BABE6104C97E4856DEE72111F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ae76dc-9507-4cf3-f949-08dbf55846c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 06:06:09.6106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyHCtLv9BtN25+l9YDMVS0yEZ81sXTSM9wQCGORxyRo871LPx8ywjht4QqGpuhZcrPe/Eeq142m++8Mj3NMvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_220617_699706_FDF7734D 
X-CRM114-Status: GOOD (  13.92  )
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

U2FnaS9DaHJpc3RvcGgsDQoNCk9uIDkvMTkvMjMgMDk6MDIsIGFsYW4uYWRhbXNvbkBvcmFjbGUu
Y29tIHdyb3RlOg0KPg0KPiBPbiA5LzEyLzIzIDQ6MzkgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6
DQo+Pg0KPj4+Pj4gwqDCoMKgwqDCoCBpZiAocmVxLT5xLT5xdWV1ZWRhdGEpDQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVxLT50aW1lb3V0ID0gTlZNRV9JT19USU1FT1VUOw0KPj4+Pj4gLcKg
wqDCoCBlbHNlIC8qIG5vIHF1ZXVlZGF0YSBpbXBsaWVzIGFkbWluIHF1ZXVlICovDQo+Pj4+PiAr
wqDCoMKgIGVsc2UgeyAvKiBubyBxdWV1ZWRhdGEgaW1wbGllcyBhZG1pbiBxdWV1ZSAqLw0KPj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+dGltZW91dCA9IE5WTUVfQURNSU5fVElNRU9VVDsN
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW5yLT5jdHJsLT5wYXNzdGhydV9lcnJfbG9nX2Vu
YWJsZWQpDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEtPnJxX2ZsYWdzIHw9IFJR
Rl9RVUlFVDsNCj4+Pj4+ICvCoMKgwqAgfQ0KPj4+Pj4gwqDCoMKgwqDCoCAvKiBwYXNzdGhydSBj
b21tYW5kcyBzaG91bGQgbGV0IHRoZSBkcml2ZXIgc2V0IHRoZSBTR0wgZmxhZ3MgKi8NCj4+Pj4+
IMKgwqDCoMKgwqAgY21kLT5jb21tb24uZmxhZ3MgJj0gfk5WTUVfQ01EX1NHTF9BTEw7DQo+Pj4+
PiBAQCAtNjg3LDggKzcyMCw3IEBAIHZvaWQgbnZtZV9pbml0X3JlcXVlc3Qoc3RydWN0IHJlcXVl
c3QgKnJlcSwgDQo+Pj4+PiBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQpDQo+Pj4+PiDCoMKgwqDC
oMKgIGlmIChyZXEtPm1xX2hjdHgtPnR5cGUgPT0gSENUWF9UWVBFX1BPTEwpDQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVxLT5jbWRfZmxhZ3MgfD0gUkVRX1BPTExFRDsNCj4+Pj4+IMKgwqDC
oMKgwqAgbnZtZV9jbGVhcl9udm1lX3JlcXVlc3QocmVxKTsNCj4+Pj4+IC3CoMKgwqAgcmVxLT5y
cV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+Pj4+IElzbid0IHRoaXN3IG5vdyBkcm9wcGluZyB0aGUg
UlFGX1FVSUVUIGZsYWcgSS9PIGNvbW1hbmRzIHRoYXQgd2UNCj4+Pj4gcHJldmlvdXNseSBzZXQ/
wqAgV2hpbGUgd2UncmUgYXQgaXQsIHdoeSBkbyB3ZSBvbmx5IGFsbG93IHBhc3N0aHJvdWdoDQo+
Pj4+IGVycm9yIGxvZ2dpbmcgZm9yIGFkbWluIGNvbW1hbmRzIGFueXdheT8NCj4+Pg0KPj4+IFdo
aWxlIHdvcmtpbmcgdGhyb3VnaCB0aGlzLCB3ZSBkZWNpZGVkIHRoYXQgZm9yIElPIGNvbW1hbmRz
IA0KPj4+IChwYXNzdGhyb3VnaCBvciBub3QpIGVycm9yIGxvZ2dpbmcgd291bGQgYWx3YXlzIGJl
IGVuYWJsZWQuIEZvciANCj4+PiBwYXNzdGhyb3VnaCBhZG1pbiBjb21tYW5kcywgZXJyb3IgbG9n
Z2luZyBjb3VsZCBiZSBlbmFibGVkIG9yIGRpc2FibGVkLg0KPj4NCj4+IFdoeSBzaG91bGRuJ3Qg
aXQgYXBwbHkgdG8gYm90aD8NCj4NCj4gQ3VycmVudGx5LCB3ZSBoYXZlIC9zeXMvY2xhc3MvbnZt
ZS9udm1lMC9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWQgdGhhdCANCj4gZW5hYmxlcy9kaXNhYmxl
cyBsb2dnaW5nIGZvciBhZG1pbiBjb21tYW5kIG9ubHkuwqAgQXJlIHlvdSBzYXlpbmcgaXQgDQo+
IHNob3VsZCBhbHNvIGVuYWJsZS9kaXNhYmxlIGZvciBJTyBjb21tYW5kcyBhY3Jvc3MgYWxsIG5h
bWVzcGFjZXMgb3IgDQo+IHNob3VsZCB0aGVyZSBhbHNvIGJlOg0KPg0KPiAvc3lzL2NsYXNzL252
bWUvbnZtZTAvbnZtZTBuMS9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWQNCj4NCj4gL3N5cy9jbGFz
cy9udm1lL252bWUwL252bWUwbjIvcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkDQo+DQo+IC4NCj4N
Cj4gLg0KPg0KPiBBbGFuDQo+DQo+DQo+DQoNCkNhbiB3ZSBwbGVhc2UgaGF2ZSByZXNvbHV0aW9u
IG9uIHRoaXMgcGF0Y2ggc28gd2UgY2FuIG1lcmdlIGl0ID8NCg0KLWNrDQoNCg0K

