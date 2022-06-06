Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8A8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LOHVsn5mHzhj+LHH+OY3Cu5POeViiS1FYslWUELPshs=; b=OzfKsGEVLMcLx9clpJMiOaEQNt
	iWtpecorTyRiaw3bHWGerONp+LODlm391ALVR+CoSFhq+IlOQ6MY/0/cMk9FXP6ersG/Ez4NWaEnm
	JxHzAShkksdNSZKSMl/V9G+smDPhQZP7ZN5NGxSDaahlf1riLZRrGp0Bm4daxFB7SSgFMXAKFxmcM
	94FMxMjJDGD4Giw6MMkSghLrZX4w6HlLbOgHzmC7vUAWxdVb1KRUW2AnQVqYnTsF+faBgQvvmdi3V
	pd53ytm7Jzyt0dyaix2DqCYZzNLyt9kQAj0g2DlE3DlWeRh2TrQ3o5h8Z3VKGRlprsClq72niNsqj
	xKTcT0jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGME-002BY6-Vr; Mon, 06 Jun 2022 17:17:39 +0000
Received: from mail-bn7nam10on2060d.outbound.protection.outlook.com ([2a01:111:f400:7e8a::60d] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGMB-002BWn-RQ
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 17:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbRZuGxxdqUzMZfGUYAPi4ALos+GkDVvaj/QqOrjUi9/2UGIwGpa8lbAeO8zPUvUrSgtMfXUOuOR6utpkEDEkomI5Q34iDRkZM1qK08w/8w4ZTB+oNCkzOSJ9tNHsigWiw9P42NQmzJECyWA3Rc8W5Ip8eOlPu7lZTcujv5QOP2+Uu0saTCkm6R+dqB98bBCatpBo+xrkT5aTduNwGSgBz2FgCUgfomF5K2qBpeYkXZj4klo5uiylsahVG1NWseg2gtwbx8AdaQAxUjcv6cimviwiavPsPwkTq1RW7ROZYhf0SWCRRMEeMedA8JD9BwWru5+jiuIvcG6U2bz1+rVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOHVsn5mHzhj+LHH+OY3Cu5POeViiS1FYslWUELPshs=;
 b=SdtWRZl/Zky0y3RR8bMxOglnltgWVudJQyC31DgwQyqvOnmfVmBLTYhw8Ho3OJ7Xl/t7hyMjycdu7OLrNJIXNBcCnBDB3O+wIOmc1ZbBkMOAP78igKNOCAdMNoXxz9q37FkfTQLs4h5bvzBnHHEEeu7mtSNeK+Sy37EDLRwXSpPY0WgWD0fwNpqnrLUFGvpHxF89XlRMC563+sQ24K0S0EC8h/cKBAUZ0xwxOqTYFmPK65R4u3iFa/hRRYiuEHSfLNPBNN+tn1bn/5s08XxKCZ6dQ+kDrRZFGRiEDZlo+Hz/86xwIGAG15eDt6r6dv40j5J/1iLVbpYQDxwxvQYKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOHVsn5mHzhj+LHH+OY3Cu5POeViiS1FYslWUELPshs=;
 b=cTX5oAXvwCCzJoVzDTnz2R+XvyASJC9pTSE2StwB+Kv77gKqJgEKe5vVLF9pnu6/frbVX+1JULAdUzBi2YnBovEpDzn/gmiss+g4HR32PW6dyY2PjyQSAxsAktOxd2ZausM10Lw4MGzO8ziC3XRfIknTk042ecSkFJL0YDx8tJgrVnZ6d43Icn0hWzIhL6LkNPDf3n2y51sxxMAOjFgAl0CUrfcJvhEhwyRbmQJraWO8BQHTEJX2W0FsBcarpLGCfNeP/P1ffAthc1s0VqUder0dqqcP/FuWpbNS/j46bGKDBi3QrdElBvL3uSsHwifojdlBq3fc+x43wpS1jf8mpA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 17:17:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 17:17:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Stefan Reiter <stefan@pimaker.at>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX
 S50
Thread-Topic: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX
 S50
Thread-Index: AQHYeaZwjwvmME7Yf0ymVKOET/TQBK1Cn06A
Date: Mon, 6 Jun 2022 17:17:31 +0000
Message-ID: <033e457a-c984-aa13-4198-6ba808bdc7f8@nvidia.com>
References: <20220606130116.87146-1-stefan@pimaker.at>
In-Reply-To: <20220606130116.87146-1-stefan@pimaker.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6f7fbf8-8358-4988-363e-08da47e07090
x-ms-traffictypediagnostic: DM5PR12MB1513:EE_
x-microsoft-antispam-prvs:  <DM5PR12MB151387BDD07EE4582B46F91CA3A29@DM5PR12MB1513.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  2808DFSCCJkt+x+9/qxVk5CroQv6g583xxdu6njVlUaLF6LFrMtmzfw3MBnxXCIGjMinlfSWYV9HoDcoKgrdR+hB6gRG+Lu7PLwMer4Iex4Bg8hCOnOq38+bzzqHEEvf9KgJAkNDLwZZD5ghMCsIMKMP6bsFIz5UonsHH3SYlIzI8EJS13BXCLHRJNJp3tDdm7b47A4zggHyubxWeXu1AOeZ4cQZghQ5H1Jh3To00k5V84WnfU5X5fp+yToO9zbereAmohAfdKzU2j3Gis3ljG64rrwxTTM7EYhGTj2lvNmV/EEOecebfP6ogqcOmCrq4EEqnZdm1DzBN87D8RQl1kdxdMg4jy9kqZ3gkAwyy0qN1YJnCI4KUi/4h6A/COGj6L2LvXNSV67nqmB2L42+/LCN6J1ti668j7yKY8H6Z5Vmp1Nl0wmmIkeUhpc519+2wj7Em4/1JOzFV5bWZ+5BSw/80/MtNGRUCQBRnNhNutUc0ndZUWzY5CquB6xbFNhBtIvHtMc4nB+k+Rf4CGLFbdNCRsfFdwmbMDf4hycHSVUq6m4mFUMqGswPqM6XO23K/DoMvblwQxX13XFLkY1O95EFZbRa76mK/aknT+aN2c6KboWZmOw1RDSnXp0X0qhfZgRkOdOjjwKMBdl/UxxO6NHwK4gN1jiXLZEZ7HV9UavJMTpAI0FcxHBcHtAVx8DF9uj4mtLye7cG7lIJX/EMQvEv3PdgXCtDYQvwubMlup+z5vVPb/fPwSCRexqT3nAI5NzZEaX2wpGd+JjFB2Butw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(316002)(110136005)(6506007)(186003)(71200400001)(6486002)(2906002)(508600001)(38100700002)(38070700005)(2616005)(122000001)(66946007)(66556008)(64756008)(66476007)(66446008)(36756003)(31686004)(8676002)(76116006)(53546011)(91956017)(5660300002)(6512007)(86362001)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WHduWlNwb2hMOFVoU0pBOE5HWDgzbXozbWQ3dkhQdENFdzkzRlBTUTdnSGVT?=
 =?utf-8?B?VmRmaWZMdHhQNEVaWGFQR3VYSzV0MU1aRUd4cEhZZE5pVWRFM3lrS016K0lZ?=
 =?utf-8?B?QVQ3SkhkbWJJUDRHMzYwVVVLUk9ucHNBZDkvd1locThSVzBScFlNZmcxSlEy?=
 =?utf-8?B?MGk3Q2oxbGJ1L1NyRjRMcUNpbDQzY2pJTFJoVU9pZXBnaDhYNlJnOTRFckVE?=
 =?utf-8?B?aCtOVjViSXVRSHRZTFdmQjFTekVUNWxmcmtvWWt1SkpUd1pEV0ExenUrUjF5?=
 =?utf-8?B?YWhNc2NxMW9rejdVazNHejlFY2xhRmRZOXFvakFWYzdpMjRzQk5PelF0Z2gw?=
 =?utf-8?B?VjM1OW90dm5NMGZ5aDluV1gzb1I2OUtMcDdSVE9kcFpENkpnK0h2d05YRHFK?=
 =?utf-8?B?VmpxK1dFeVc4YXBHazhZem03UjRWWnE2WFNlWVlUNkxKTmh3NDlJcGVIOFdN?=
 =?utf-8?B?L1F5SW9VSi94dmRHS0Vlb1ZVeFpGbFo2NFlTK1UzSUlsRElRaWtraXRPWUxD?=
 =?utf-8?B?N2s3N2Fqdndqc1p2bGRwYVA0bmhoTG5yZWVVKzVrWHBObjVWbFdaOURiV0Z2?=
 =?utf-8?B?cW91L3lUdGEvaUhHeWovR0J6REtwZDVRYlhvejJhZWtqN0hYVU9vWmhlam54?=
 =?utf-8?B?M21RK1JKM3BQTlpwbHNMbFBVOEFqaTRLUytZS0dOOTFkbk5qelJ4OEs0bmtN?=
 =?utf-8?B?TlZYVkVZbzZwOFZPc2c3NXNJVjkzNXJLRHFUaC94eXJpN2RKWjRnOXM1azRJ?=
 =?utf-8?B?U25DeGdJc2tRV1ZZcUpuZ2hJVE1uNmI1SEZWSFNHNXFkMkVPUzVCdC9JWjNt?=
 =?utf-8?B?cFQ5R0l1RGVRQkI0SE5YYjlveFVoNEd5THhiTkNTZEh6WlZGQTBMR1A5cGRq?=
 =?utf-8?B?NXRYQkFpMmVGZFZaNXJIR1VOZWFTbVhSNDZpU1VPalkwYzhMTS9yUk82dkUx?=
 =?utf-8?B?Skx6VlJwSGtSdDRLYmtDQjZLejJYTzNGMWtjY2RSUXF4S1JMRmt1Y1VBZzl0?=
 =?utf-8?B?NzVoMkZMb2w1OTBjSEpZYkt1Q05MYUNWUHpjSnBNVzN3SXhISHdTekI1ei9i?=
 =?utf-8?B?QXZEWHhNNDNvZjdEYlhQeGdpNTVBMHBoU3I3QXkwYkljMmZ4Y0R5dTJEMUhn?=
 =?utf-8?B?UGFDSEg0YlY1bnJtbmM0OGl4cytBeS8rN0Z6N0hCQy9JSElTOTB1R0pObzFj?=
 =?utf-8?B?SVdrdDJXS3B4WVlRb2haVVZ3c1NjOE13T1hGbDU3V29QdEU1NTVFUkpCMlIx?=
 =?utf-8?B?U0lscVNCWHZ2c3JWQnlGdTgvTHJWVk5HSTlwSW9JUG1maXd6Qys4MkQrVlBh?=
 =?utf-8?B?RmJGU2Qrek5nOWkwZDN0QmlTaVVneVRTT2V5MzhBS1diV3RMaDJnamdFeFd3?=
 =?utf-8?B?aHVYdDU0QjR4RGJlWDBnNGtraTZlc010aG01S2VwcVl1Z1hIaHdjWjhmR2NK?=
 =?utf-8?B?ZmZCMS94RElyTXJDSTJTN0M5RjJyMklpUERnZ2g1VDU0L293dVdQVmRsUFFu?=
 =?utf-8?B?bG1ZeVV4TjlwcEJTdVJiV3NrMFFWVkhqWTlZQlNsa25yRlNhaHYzQmdmdnVT?=
 =?utf-8?B?RzBPb0hndTNNQkJBQ1dYelB4UXVrUUR5TlY2cE5LQmNmN3puNWNDM3JnZTRB?=
 =?utf-8?B?VkZsdlhEQ3ZFaDlHM2Fxc3U4aU90MkhTR1o0VnNWYzFGNUN0ZVBROWVuOHE5?=
 =?utf-8?B?ajBjT2dwZFN1UGhRcEdoNHhFVXo5MFJVK3FpTG02NlZ5Nmxrc3N5aHprTHZn?=
 =?utf-8?B?VUMrU3Z0eS85U2JnNlhZYnJzM0VXdndybkwyb3gyektNcTl0UHdJM1NKZ0ZQ?=
 =?utf-8?B?SkxUQWRzcW5PTy9YQlh3emlzekJ2NERRb0tEMlVsRmRNWjFMcVRFa1BUUTNw?=
 =?utf-8?B?QTdOVDRPSDA0enAxNis5aUI4RTRHRVNZL2YzbngzeFhTS1Q4OUFocU1CVER2?=
 =?utf-8?B?M05NZHl3dkxDMXo1cENhdVYyWEY1aFB6UTNkU1lYdGh6MzlqUEJCUnBnL3Rn?=
 =?utf-8?B?NzlXSUtneUdrS2txNjNBZ05uQXowa1hiQTFuazgxVDRLSnYwcC9BenFxMDEz?=
 =?utf-8?B?MEwrd1MyYWsvWW9oeEFja252S0gwa01hR0QvYVRnbzN2SElRc3Bsbm90UTgv?=
 =?utf-8?B?akJPWXBWTWVYU2s3TVB4Q0FJUnFkdUI4TW9EbTl4L1dCOWgydi9pRTVRTm41?=
 =?utf-8?B?OVpCMFBoOHh3dkxER0NmMmpiK3ZOU2k3cEtEdVcvRlBkVjlZVmFURTkzZ1Iw?=
 =?utf-8?B?cG9MQU9RM0ZOeWY4NDV5T3U5RXI1SmdENUxxM2czbUR4SFdnL1orY3lQdysw?=
 =?utf-8?B?MFl2T3o1Q1o1NnJubUY3OFBXYXJpVEMvQXhqVmkzKzBsTlpTaFBDTWd5VGgw?=
 =?utf-8?Q?uliBfpU0v+Vo1UFaxzgePqtMxShyZKKd1pdATsx8fbqBy?=
x-ms-exchange-antispam-messagedata-1: M1j/+KyDx8scog==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8463E267785D41979726DA475FAB0C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f7fbf8-8358-4988-363e-08da47e07090
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 17:17:31.2935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08tlVdtmWW7uTnq2wybiTJ0jUxDisjITGFCTAXZoq+wQ5UHLQRfguXs+6le/ZTNJo1uxQQ4OgaXPfJ7bgCCElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_101735_931879_9ECC2E98 
X-CRM114-Status: GOOD (  10.10  )
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

T24gNi82LzIyIDA2OjAxLCBTdGVmYW4gUmVpdGVyIHdyb3RlOg0KPiBBREFUQSBYUEcgR0FNTUlY
IFM1MCBkcml2ZXMgcmVwb3J0IGJvZ3VzIGV1aTY0IHZhbHVlcyB0aGF0IGFwcGVhciB0bw0KPiBi
ZSB0aGUgc2FtZSBhY3Jvc3MgZHJpdmVzIGluIG9uZSBzeXN0ZW0uIFF1aXJrIHRoZW0gb3V0IHNv
IHRoZXkgYXJlDQo+IG5vdCBtYXJrZWQgYXMgIm5vbiBnbG9iYWxseSB1bmlxdWUiIGR1cGxpY2F0
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gUmVpdGVyIDxzdGVmYW5AcGltYWtlci5h
dD4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

