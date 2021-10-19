Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA3AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:30:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17AD61027
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F17AD61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dvm1Jnix4EPjZmNoiu21U2y37ix4ktT6+gekEOUS12s=; b=mgd7miZZMcTERcwePDKCCo67Q8
	pDGSIwQeuAzLQw0CSoEo/URbM0nsuMASo7S8PE3v+swNU9hXrAcOHtmDXEXI9+tFs/6yeljrMPjrC
	Q6kf4mAbdrSUgGqkkjXF4aOvQu8sc/5hBryrCZ6QAh2Id0DFAaD10p1n4Miw2Lt48VsBv4cWOx98o
	a5QKZL0P7qmJI2ZrS0h6DK7SYoc42CIdPH1nFAHCoVA8i/by2ZLRFUFtjdMqJow7W03l5KBSWFbyZ
	a4OWbiOmiual9CBkCoTKDVfMGx8pCxLq8BrTubDHQuzTiptot30r+vop/BYoY3LKWyShULfklAc9d
	TKveCnUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcidY-000IFk-4Q; Tue, 19 Oct 2021 06:30:12 +0000
Received: from mail-bn1nam07on2050.outbound.protection.outlook.com
 ([40.107.212.50] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcidG-000IBp-R4
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 06:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZpddHDZRMU+Wb1IiDmEpiFEqy7vEdc/xlcsHEWsjeSxnlz1nIe4hVeMYp9+68B265iRB4bbSiWkukn3g1x+OP5fA1DfKIGvVl8nYbh0LsDivetA/tl3crBkmUJa9nkAEgoUtB1OsCh5iByKg87+NdlXdD9K2DewgLoyIlhjSAL7KifiNMzjjkwGOmzRID+dmU0KxqoV/9L+vkbXiTdSW6sfZDtEHzfvKokpoiO324zwyjUne/OpZDqxZeRrHimUiq574bBtxIXQdTeINhQg1fYJqWjlg/vMTI+81IWVPLOA29wC3e/BlbpU5qNmsngmo1TW5jg1VOJMzFOYhjRhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvm1Jnix4EPjZmNoiu21U2y37ix4ktT6+gekEOUS12s=;
 b=hkj/jWw1TpfMrsuL0dQTUD+hXyW2mxXWqD4HnkYOcXyHEZ/1HPOhYO9cpSqN/TRwW+QLVYjSbX2Nce0UOlha8+3+FIBZ0TPiOdMhH1mqESMberXG7vT9iZLzSCTn9hqWkTygoFhMH7Z1XxnlU25lSCuSg60i0h8r/H7NC5PDnF/xElYCo+0RFOg1oqYBWxH2OUmS6IelzyUfNGaJVx+Fwdztw3Ik4dwE9uTVoR3x/AeSK+hCkLGIqPALGzSZIUDsaVTX+kVdPTpwBX8iYdj+0YC/9CO8k8YaeeNH7gC6ZtcyKkdSwz75nPaaCsitJOJuukJrECgTRBkWS1OTZ1yldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvm1Jnix4EPjZmNoiu21U2y37ix4ktT6+gekEOUS12s=;
 b=ct0YZYuBWAuAv4nKPBNivyDzleRmDnMUrC9MATwCHhXX1eNiQELtyR+TDObhvtaH9KGG2/4RgvZFm0fP3kHz2Avazwh4pLW6zCAnZfC43R0iWpoLqXbhQApKv18W3nUrYZPpk0mGhvySH5HCgqVA6CH/MTI/1J44jwSWWuay22Evu7kDJ5bJxAzy0AffcfU4NEaMr5vJo/z8yE2VTMz8S7Z153ldci0G0cUu3dwkTrIC5nfKQeO63IPiLBzLKPuu3DhlMfw7qI/P9syI9DvA3H2TFlr7Px7DPKKYypVQH2Afh7zU+8aR1I4hwZKfRiWhKLxyhfdzxKiVb7DRS0z9Cw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0014.namprd12.prod.outlook.com (2603:10b6:300:e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 06:29:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:29:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Israel Rukshin <israelr@nvidia.com>, Oren Duer <oren@nvidia.com>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH 6/7] nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work
 API
Thread-Topic: [PATCH 6/7] nvme/nvme-fabrics: introduce
 nvmf_reconnect_ctrl_work API
Thread-Index: AQHXxCXIEAFT0iC/VUaoWP2HmKNowavZ3SWA
Date: Tue, 19 Oct 2021 06:29:52 +0000
Message-ID: <0674c57c-7618-9ea4-d4cf-0a1e57e6a782@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-7-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-7-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 613e6a03-9aac-46f3-0373-08d992c9dbb1
x-ms-traffictypediagnostic: MWHPR1201MB0014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0014131959A506D7380FDB40A3BD9@MWHPR1201MB0014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6pXxa3R9Lzj2A8vCzpmOhdwOTCRZZGv0hou1t5hVR8Nlnyk0Uk02q5h83OwJ2Sz3Dv4y2a19q7f5+7BNS7I4rG7mErmvl7uxHCdBNNN9x/l991RVfsWZc0RZdJnT5zAhoU9t32gzP7eTIjPIP2qyR/jqbtwBNu6WDEeojP2Pdm58cJ8UywSJTmgzNvgPf4KJ6IJ/gKWtAQ0HYxvs7VECDWCKKX4bvqlAkPpSjp3lNIzDMQ0qIJcqHOKVVUnrhNVSueVaiBtA2+fKzBOQOg3JGYnLrXBCdzbY+jcx4YNUODYWvM/D3ehft6p9TwoiYTVlJeMphpmVZEP8nTI3pKxuVTGIh9z7+LWETZw32cA2kzyVkEmr6PcxjNgqLu+CknAnZ2go1e5oudpsNKxnLtP+h3JPyZZctWsrqIC04IJQO9ix4cquSB3HRuTiHJfb3p+npn6WkW0f8gKYwbLfXgGRiwbQucYOQxKTOKKw1Ge0qzPf8SyBLn1YMhePbwuoiToBSTas2II/u1F+0LrCkdOzorqci4AZ2XBFnR8YdaD4CnSkEuEc+cxRkCtcm/pIpaPHM97rWDmDdNdeADDScdBD6U+78RBwbYcgJgp1/BWOrUTv7M3Mc9fZKcyEGegKC+8lH+fh4uRGmop+INovm2J8/Fe573P7eQVQAycNLNOGAXL7rcNcaKsI4I2R5EHvFvlMzK+SebYz9ty2m88GC3XOFLrMuLz5R0uhCCuWVGs/s4wzybEfSMMaQYNK+sv3tJgJt+UZCVxH0BzU/Bsgu1OCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6506007)(5660300002)(4326008)(54906003)(110136005)(316002)(71200400001)(4744005)(66556008)(38070700005)(122000001)(36756003)(31696002)(6486002)(31686004)(86362001)(2906002)(2616005)(6512007)(38100700002)(8676002)(508600001)(186003)(8936002)(76116006)(53546011)(66476007)(64756008)(91956017)(66946007)(66446008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STJGNEJIM0UwT3g2SWwzUGJLUHF0amlRTGRsaE5iZlNRU2dlaHo4cXdMc3dD?=
 =?utf-8?B?aWtxaGNpN29oNUxKZjVLOWk1RVhoeUErVEovYlNFMkxZekN0aDhvTFZqb05V?=
 =?utf-8?B?a1owcWcwU29hMGM4bXc3Vm1USVNKT3RvdEpwRzRhY0RTREZVSUZHaUdFWXQ5?=
 =?utf-8?B?QzNsUGF2VzlvRjJVWVlZcG50LzdNMFdDSkFFR09iSlUrOEtiWU10YVFuSVh4?=
 =?utf-8?B?eW42SWxVdmY0WE02bEVWSzU5eldJVVRmSEY2ejBuQlNwWTBuY2ZqKzhqbldw?=
 =?utf-8?B?Y1Y1VUNoK2EydFFDRURQL1N0Q1BJV2YrZXM4RUhnTU52RnBXLyszM25Fam1a?=
 =?utf-8?B?QUlyY2liYlhKb0c3czhnSW9EUWJXalhGMC9UdmVnbCtzR0YvQUtVTFJWbVg4?=
 =?utf-8?B?OTh4K2pwaUsrOStDRTlnNmU3SUNMZ3pjVlVLZ21SZ0tlWjdEU3F5cXY3MzFk?=
 =?utf-8?B?OUZUWUJCajY0ZVJidGFFOUN1bHFrTU1Wa1I0c0FSY3NjZyswNU56MkV4eXFX?=
 =?utf-8?B?ZytsZWxPQ3M2c0JZWHhRekpBdEk0YzM5bVNMYzFMWU1ZSXBRRERETGRkUFZt?=
 =?utf-8?B?aUNNWVBzUkZLTFNoTGNPc2hsQmZyQmVsN3dYbG1ONThxaTI3Z1ZlU2dpVzc4?=
 =?utf-8?B?bXBJTFA1RjZ6Wk1HT3gySmczTkRoV1grcVBRUFo1Z3hrcGNhcTRIbkZqOHlx?=
 =?utf-8?B?ekJvWlREZ01wQXYvZ0QxVjRtQnVhaTRBWnlhQ1NsUWd0OFpQQjJaUmFwNzNy?=
 =?utf-8?B?aFVwUTNHMHVuTzU0QTRiT1BYU2VOb3Z1cS9hd2RqeVY1WVR1dXlRYWdHQUUx?=
 =?utf-8?B?VGc2cjR2WFc3c3JVdjlpUnNFd2Vic1hnTHVHcXdURmJBQmFVdUc5SGo4aXBE?=
 =?utf-8?B?SEFIZjJPeUhhL1Q0TTkyL0o1aGNYNmZGR05nVnVYb1RmQzVlQW5PcXh0WW5n?=
 =?utf-8?B?TlB0cUJselNWdGVxZ2lsS2MwK05YSS9FTVNrajFBRlIxSFRpekFaZ080TUdq?=
 =?utf-8?B?cG41M1pSWFNSbkhvS041cHRoOWVVRmdMcFUxaWVXV1JDSmlEUkZRYjUxNm9C?=
 =?utf-8?B?ZzhEWmxQdlM5YndhUE9PRkVOcUZreTVuVUVWd3pBdnJYOW9UV3JuaTJLb1NT?=
 =?utf-8?B?bjl6WlpSWnR2d3RLeHc5NFBKYzZRNmlJZXJLWG5OcXEreU1xc1kwcDhIOVZG?=
 =?utf-8?B?VXVXa3B1T2dOemJtTzI3cndhSHBCdFhhcDNMbm1VUGlkN0NlQXdMRjdROUZW?=
 =?utf-8?B?KzRWYSswSmY0V0JWSU9tY1JYNHVra2VjSkhFUVlaWFdhanNmRmxQSmoyOExI?=
 =?utf-8?B?UDZDUmZuRlBxOHlhRHhhRUcyN0lJcFhyR0JvYUlhUENPS1RyKzNzdlQzQVFX?=
 =?utf-8?B?T1dBSlNFNThUaTJpdEh0bDI0VVorV1UzajdEYkhOUjh2ZkxjdFBrd3FUSyt6?=
 =?utf-8?B?dGFuTTNjbGVpVDlCT1ZTV2JCdXN6VEFjME9yT3BYQ3hhQW5ieGFhSnFNSjl0?=
 =?utf-8?B?dGxxWHNyYk5Vc055dmlNWjJCS0FsWjdGT3p6RWFEUW14ckNDK2IxUmtjSzR6?=
 =?utf-8?B?NGxhaVFRU3FuMFFKQVdvdnU0eEczeFlxd0cyL05KNHF4UCt1Yll5WTF0eEpq?=
 =?utf-8?B?clVwR2w4UWlGbm9JRjluWmZyNWxBb2E1eTl6WTZNa0F1WWZBWFptb2FDSVJr?=
 =?utf-8?B?VkZHQmNSQllEMFJReGx6YmNRWTVYaExlZnA0NW4yVjBQMEw1TE5xVzd0NzlC?=
 =?utf-8?B?aW1vNzBuUFAwVmJqYWU4MWNFSFF2MDJiN09waGxJVjY1V2VWZEhEZ2JMYU1T?=
 =?utf-8?B?c3ZCNDE1a2xrSDRDYnpISU9HUWZYSjlkL0UxVjZERlhWM2pZdTNuWi9xa1B2?=
 =?utf-8?Q?RFvMQY0LWV0nV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4874C9C4C01B72488A3383F3006E97D4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613e6a03-9aac-46f3-0373-08d992c9dbb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:29:52.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnPB3ot7mVR/UzdA/GIjdzGP/ufqJnsGrB8me+Q6IWaxRIBiGLf2LAcxB8O8t+WWECacWMCZTKQ73LUmtat8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0014
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_232954_957113_B30E29BF 
X-CRM114-Status: UNSURE (   8.66  )
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

T24gMTAvMTgvMjAyMSA2OjQwIEFNLCBNYXggR3VydG92b3kgd3JvdGU6DQo+IFJlY29ubmVjdCB3
b3JrIGlzIGR1cGxpY2F0ZWQgaW4gUkRNQSBhbmQgVENQIHRyYW5zcG9ydHMuIE1vdmUgdGhpcyBs
b2dpYw0KPiB0byBjb21tb24gY29kZS4gRm9yIHRoYXQsIGludHJvZHVjZSBhIG5ldyBjdHJsIG9w
IHRvIHNldHVwIGEgY3RybC4NCj4gDQo+IEFsc28gdXBkYXRlIHRoZSBSRE1BL1RDUCB0cmFuc3Bv
cnQgZHJpdmVycyB0byB1c2UgdGhpcyBBUEkgYW5kIHJlbW92ZQ0KPiB0aGUgZHVwbGljYXRlZCBj
b2RlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IElzcmFlbCBSdWtzaGluIDxpc3JhZWxyQG52aWRpYS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+
DQoNClNhbWUgYXMgcHJldmlvdXMgcGF0Y2ggOi0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

