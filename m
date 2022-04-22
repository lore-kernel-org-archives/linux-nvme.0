Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6B7C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Apr 2022 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jDLqOxVmodpb05ZIdtwGXDN2M79mzWO+QWW831NRGOo=; b=GgEE38Z3u49nnLDLBrC73za3SA
	fateCagAsOKi5sipXwsXPFGZ5Jf0S5tn/L2SUqXJtjPgtGRPOhIRsxOMK85m3ENvnCD7RBV3Jqc5J
	7FNGR+nLoYP6Aj+SvgP/hlQQE9sGAhvJHbCwTvb8b8PfrwTOy1Ve1dlJHICYw30shUDrv/i5pJQpz
	X+76Z/xVeBAMJVvP0xnL3t8B7wvzvlLPHbFcZ7+JBDAf3yv8MYpS/Rpzzb9cgCVHB3Pys3iaQsDKz
	SeuUKUXdg2YSjRnUxGDWY74yv+UMFBpJ++T3y4S3AmZZAUTZYNi+mmDh16uRu3n3Cjc0xg3w4adm7
	1374OZlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhyXU-0024Ev-3X; Fri, 22 Apr 2022 19:01:56 +0000
Received: from mail-co1nam11on20610.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::610]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhyXR-0024EG-01
 for linux-nvme@lists.infradead.org; Fri, 22 Apr 2022 19:01:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lql8de/3h04ImSg7TZT9YAFFx3bvn+jmE0Vdp5RdEIJXRyBC5XcS8Ngsxdr/RJErlJScq0033dDlxET/KdQxbLGF4vxeIiQExNl/duy8vUYZAHO4+wWCOoKg/RoSEnKrTRtYLQZUfFZs+fnmfdBY8ZYZtNocHeJ5gZQDcgeZgk1/KisycZkdy44Cm9x49EoQMDQK0j0UPI6qts3KXVPohjTOnwIrOZsvII60s9Bkb7l6hMgwNIOW5E5mRqbEOyMFBBFlvgtDpTq9zmnOniGIuF3EcMtgq4yJYsCkxKGd0sMzPittMTjq9CwzUjBwZDKgzjQJ4Ascwc4Odn2qSDLMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDLqOxVmodpb05ZIdtwGXDN2M79mzWO+QWW831NRGOo=;
 b=MdYfQxBCnwZd6WEFaz+MOiEqCm6bN8ADp3Pob/ayiyRXlIffZZi4rlBi3QWpEX1z7FgmlK49xBEn1YrryONGieqhw2nELV7cfcE3sIWnbDVyQd12GtNK/ESHDoIIL5C3pltITCmH22p8rSVxx2EN/uo82HyZTWjbyTF00s5MEll15djtCs9V6od5AXpOONliGpA7GAzdLG1Efz+HzawMKgjhKJ5G4EBvhhXeoiRoVfioyJ94SFHdlxaVhVU5WaxZYwNamL+G+hS1EVOozCUyuZ4rq+cDH3NPqoglYQc22mzXiKAlSYGzrP7DWQWnOTk/uDQ/xs2ANgOxde74vJRrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDLqOxVmodpb05ZIdtwGXDN2M79mzWO+QWW831NRGOo=;
 b=lBEFZUFBD1P74ndHs731/1OXk6BfsGvbtXUUwQMc9aLJMYesyTwf5tP0U97zRmuUUIj/+zyt3I9PwP6ouxaUsMSDEmFc+o7jBsY/2Rb7tBWbUAEqnqsPJ5vsOOJRcuVGH8D1stCNIlv09yBE8W5pfRALr87alzLgGujJEPhKOImVKnZNzKHO0oN+SwtykkFDxnaVKag8vNK1cCuT3dklWjmEa9EUUR4AjHmm+u/J7BE8R4yLouLbwyMBq8BkDMCFfLXB8P7LWZDAdjOrU//895cvvTSFXf2rOd2U1+ir+Rr4mWPj5zwIBXGrelSsqJvoEMTssiEmFz6TiX8M4LcWjQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 19:01:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.026; Fri, 22 Apr 2022
 19:01:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Topic: [PATCH v2] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Index: AdhWVSiSpagPZ2D9Q6uv/JCTFru/fQAJkI0A
Date: Fri, 22 Apr 2022 19:01:48 +0000
Message-ID: <612d22b5-ec79-75b6-3bd5-72c891d6d4ec@nvidia.com>
References: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d2de1b5-c1b0-4311-c0d4-08da24928d9c
x-ms-traffictypediagnostic: CY4PR1201MB0120:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB01208EC7B3CF72A0CE1BCFA1A3F79@CY4PR1201MB0120.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEfsJEcFHGm1QbGJMZ+cdSLYoGKZFPCanh50vBWaG5lElpMnILmfXw1uxHFiiu3Y8/RcCNoT52K1FgGvMuj2Cmcgv4yh3639wsRF8m4m0Ty9xyUg8BMNyXjnEMPmoU4EMwcyJPMCmrpsTcNDCBv0xYD3yoWYEvVjL5LL7O2qaXgOqkACt7EQx0ECah8f3jX231uwRmPkrc9UL1mK1RpFOjGfPF/fnuB1Mw25oSLGNcVsV6fz74AoEgso1HLYOGegXFPDGu2oTzwSfbACx248wSZ44uWTI6uglmuJpvGsmOykXp/RL7xPT16LmSd66YffwqfGC5QzB7UwvXG/gRrvEePEN/boSO3AIFI9D8dDN2Av/Zy4ogs8ERKazUV/4RsTcT9dwesdhML+X7Mn/uaqPTTv98bLhRaUFyB9xJuUMhvF+JjZSbyKtj+/bWzCnQpHypGM7Nvl8H1DDPVn2gA4T+SJ9GWmojYoQUsLGTdnJyaepy9NHFE5juj44N/gW6ngXniChr1OnqCVoTMPNg85YufgsiLN2thxkpUpMhtwv20F7uZsZcfsRuy6geyOB2uQ9sfso/vXaIvTNW+iy+roaV9VslGvvh0EGE9vspDzOFXgOb94GAUc2C+oHrndp64gOJkLgIOq6FhZXHMlH1fISyvu0alwfhicvqussOzYTbV+x96knHerxb0iMQ3iA3foN/sN2WH4dLmoLWDbKMpLLJx/3dr/s0QcbruKxj1g+NQy7LHMZvPJoXcflGGixQc9u0HP5JB0GP4pT0AFyDjYZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(36756003)(38100700002)(86362001)(31686004)(122000001)(6506007)(8936002)(2906002)(508600001)(6916009)(2616005)(38070700005)(316002)(6512007)(83380400001)(53546011)(186003)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(8676002)(5660300002)(31696002)(71200400001)(91956017)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlpDR0hJQVJqM3Frd2c3NHEvUCtQTENvQ01rTzZtVUtQSzJEdFVoY082YkJ0?=
 =?utf-8?B?bW9pU3FzeFJmd2ZZRlVoWFhFRE9sckNIOWNQVWhaYlEwcVNkZGlaTUZqUUF2?=
 =?utf-8?B?MytDTllsU1Ara052QlVIcWlsdEY5eG8zYXdjM1RVd2NORHJvYk8zN1BSVW9q?=
 =?utf-8?B?bWRoekFCWFp3QVNjSTUySWZ2YUhCSHEyVXRyK0NENkJpMkFxeXlFNSsxWGhF?=
 =?utf-8?B?VHo2MnN5V3BWNDJvRlZuQ0swcnRnQTRjU0tRUTdUK0RwM1c4Z0ZIakhGYVdH?=
 =?utf-8?B?MFdmVFpSNGxZdTRHRlNTTE5Ob3FSUHQrWjB0d2VhOGlWMkp4bVp4SU91aXAw?=
 =?utf-8?B?MnNSMll5NVUrSFBQbk1heXEydU0xa2RPSzF1TUltbTNGcjg0QVhNa1NENzA2?=
 =?utf-8?B?R082NEwzdjBoekFjVjJnU0VwV2h6Vm1vSnFhdXdXZlEwK3BmSi81S2puV0tv?=
 =?utf-8?B?anMxd3pzS3hlUUlRcHY2QjA2aVZHN2J1MmRmaHdkak9qbS9Rc0U4UVp4VEYz?=
 =?utf-8?B?VDdnZkhtVnVtRlJnNS9TN1FrNnZ4eFlZSTR1Y0FsdjgyU3lXQlFFNWM1Z2J0?=
 =?utf-8?B?OWlLR0UvT3NPZUp4Qjdmamh5d2ZCbEtpUzVua2N4NUFiQ09ySkxjakU0dm5r?=
 =?utf-8?B?MnJJRktKSlBmc0hqZ0JjenhJMVVFbE1UQ3ZHUm95eDhzVWdQVmpPeUFBSjJC?=
 =?utf-8?B?V3RQV0xJeXlBNDlxZ0dTWGw5eHhUSzBuemNraThnKzJ2MUUvS2l0T1dlOW1X?=
 =?utf-8?B?RFcwWU1EajY5RlR0RExhMWpiN29ZYXRnTFVYcUxMR1dtbU5pVVVid0d5VUx4?=
 =?utf-8?B?MWhycnlSV3pmS1NsNktNaFRMQ0QxdzRCbytZUkF3R1FYZGlUKzRFblptOE91?=
 =?utf-8?B?MjNwSDNvRC9iTTJNU2p3Ym5FQzAvMVovZEU0amZROS9POTJjbjVjNkR1b0RF?=
 =?utf-8?B?NzF0UUtrNVFOM2c3YjlDcWpLMVpDSkNoYzEwdWNyQ2pheDM3Z2NFZENQZ05S?=
 =?utf-8?B?ZExoU0xpR0hwWnQ4QWNIc0pOVnAzTGtDWStWT2RrWDdoM2VmSFg1czlVM1lN?=
 =?utf-8?B?ZGM1bFhTMWtnRmFRSWJLVnhxa3N0SmpIYURwVFp6MDJLR0pXMmUyc0w4L1FW?=
 =?utf-8?B?cE8xRGNDNDV1T3QzTnpwTmp3OU05ajNtZ2NwZmRxSGFGRjRpYnVMTnNicWd1?=
 =?utf-8?B?UWJWbnhtUEVwS2VFVlZldTJ3T3BobTRYOFhJbEp4RmVNQ2pzM2Q2OXlLQW53?=
 =?utf-8?B?UG52dm1Vc1ZPRlNHY0dFZEkwUFVFck5IN29KQ3JUSE5SY1E5NnJvQitFOHhv?=
 =?utf-8?B?c1lNN1NTTHpJVUlFMnJ2Q2h2UkZtWWVmSGl5enhyUUZhTWdFNGtVOVdGcU9v?=
 =?utf-8?B?NDFCbVdGTWh2byt2bmgrd0tVQWc5cCtFaUVIVmRKQzAzdlFzRG5laTNScXU3?=
 =?utf-8?B?RXQ1cXNDbGl4Z0dIdEpQTzB1cTBpczFldE1sZXJhbFUyVTMzTFBoTkE2L0ww?=
 =?utf-8?B?ckxCWStRQktraEt4alZFcWJaUkt0b0pVamZHNWV1MnkzcWxBYlN5ZnMxUnBt?=
 =?utf-8?B?d3pjOU95b1NiN28vMUVsd1NHUXhsbHhra2pvWUtpMjdnUzVnVTdhQVZzWXJr?=
 =?utf-8?B?M2Y2bHNvek9kSy81L1FNZFlkWkw0MTBnM0lWdlkwQnpwSlRmMDJ0aXBhcFBR?=
 =?utf-8?B?eVZFR084ckoxZFJZVHAzZW5BTEs1aWZHL0k4R1F6MW5uQ1VTekdSRi9EWW03?=
 =?utf-8?B?cHppWW1odjBSUUZTS0pqUGZDRDRVdmQ4UnVQaVU1SGdsWElTbzcwSmJpd0Fu?=
 =?utf-8?B?UUdhVS82RWRNdEpFUDB6Q2luMGxQMlNVb0Z3alRpRG5xeUF5bGQ0MTFmU0Jm?=
 =?utf-8?B?VXZxbnVxY3EzSW1DTWlTM3RzVkEyWHpKRmhaMjB4VW5xaFVCK1cvSDR3R3Qx?=
 =?utf-8?B?amhJT1pnWlkxc2o3NXMrdGJJcG1qK0VDKzZpa2tQZGhuZktGYzZJOVJLZlVE?=
 =?utf-8?B?aVR5YnJVY3ZSTTNKOGl0a0Vic0xVallNeldxUU8xZzlnNFdyVGI2YUt4OUZm?=
 =?utf-8?B?eis4bk8zekg2anVyZlVKMjE4RmNwa3RCdHVlaTFZWHczdEJEaUNMdlBnZnl4?=
 =?utf-8?B?NEVidHJwSUFsUlRpY2xaMmJoZkJHQ0pCVWxFdG1hemRvcFgxQ3p6bU9rN2xz?=
 =?utf-8?B?c2dKaVVSTU1SWFFCbzlQTXlUcTNYb25kTmNHelRwOEtsZFhDUWJsUTRZOUdC?=
 =?utf-8?B?S0NRVHlFb2FXYmE4Rk56MTRqMHNlR0FTRklmYmFranYyYjZuSXRTK0xWN3VQ?=
 =?utf-8?B?dVJ1TU9LU2N5ZW9YNm4rK1dEUGl5cS9sUnhleXg1aXlzM0M1aGVhUUJFV2tk?=
 =?utf-8?Q?NJbPm9+RIlAw5TXdEhEnVNJzyhd1LAQ5zz7QEO0s+agoU?=
x-ms-exchange-antispam-messagedata-1: BkZajKbx3qEj4Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E535C061115B459F47AF1E59B3D22C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2de1b5-c1b0-4311-c0d4-08da24928d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 19:01:48.4782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSNKj8oIf/l9PzrhZiEpw7oHj+cawFGlz6kqgTr5ywBrZlJOm1jg6NKPotQdppb9lvk2DAOCh+twuaj6H0353A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220422_120153_292181_C69EABC5 
X-CRM114-Status: GOOD (  13.44  )
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

T24gNC8yMi8yMiAwNzo0MCwgU21pdGgsIEt5bGUgTWlsbGVyIChOaW1ibGUgS2VybmVsKSB3cm90
ZToNCj4gSW4gbnZtZV9hbGxvY19hZG1pbl90YWdzLCB0aGUgYWRtaW5fcSBjYW4gYmUgc2V0IHRv
IGFuIGVycm9yICh0eXBpY2FsbHkNCj4gLUVOT01FTSkgaWYgdGhlIGJsa19tcV9pbml0X3F1ZXVl
IGNhbGwgZmFpbHMgdG8gc2V0IHVwIHRoZSBxdWV1ZSwgd2hpY2gNCj4gaXMgY2hlY2tlZCBpbW1l
ZGlhdGVseSBhZnRlciB0aGUgY2FsbC4gSG93ZXZlciwgd2hlbiB3ZSByZXR1cm4gdGhlIGVycm9y
DQo+IG1lc3NhZ2UgdXAgdGhlIHN0YWNrLCB0byBudm1lX3Jlc2V0X3dvcmsgdGhlIGVycm9yIHRh
a2VzIHVzIHRvDQo+IG52bWVfcmVtb3ZlX2RlYWRfY3RybCgpDQo+ICAgIG52bWVfZGV2X2Rpc2Fi
bGUoKQ0KPiAgICAgbnZtZV9zdXNwZW5kX3F1ZXVlKCZkZXYtPnF1ZXVlc1swXSkuDQo+IA0KPiBI
ZXJlLCB3ZSBvbmx5IGNoZWNrIHRoYXQgdGhlIGFkbWluX3EgaXMgbm9uLU5VTEwsIHJhdGhlciB0
aGFuIG5vdA0KPiBhbiBlcnJvciBvciBOVUxMLCBhbmQgYmVnaW4gcXVpZXNjaW5nIGEgcXVldWUg
dGhhdCBuZXZlciBleGlzdGVkLCBsZWFkaW5nDQo+IHRvIGJhZCAvIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt5bGUgU21pdGggPGt5bGVzQGhwZS5jb20+
DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

