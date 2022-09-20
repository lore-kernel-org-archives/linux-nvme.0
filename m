Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71769C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7ztfcu48bA6MH1MBhR2eHUxk8tbaAygs5JYpVEvIFQ=; b=L44xWQNVSOJe/h3d1yXdmpSL7w
	pWyMWeZNmsBzH6MCDG1+rsp//oiHnLXe5F8/dH7euGW9cyYE8EcJ8etMKsi7mUTw2qAwkXDhkIxvM
	Dh5eJw4xUdUbjDjw9yGWAdVdejayjfKkjCbC12FGzLEJ1qIxx6BLtbtaULCPYtgYszCxZWKbD8Dfb
	yhqpkC+TkUZaO3MMQHzEeCEG93x8U0WXmu25RUHi0+CcVy8kL0SAX/zppueipWx9MrZDEbjga0l/r
	NQ9ELtfO5QGcDAn8vbprfhIU+9mk4nfIScrCNh+1FP00T1hd8Tr16JmLCqi0ZMT9Al1gMVayT25YI
	kRL8eWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal0l-0079oG-T9; Tue, 20 Sep 2022 21:42:35 +0000
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal0j-0079mE-Ac
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACTasj0+KoZ9iBGhK2xsCu0MnAYWnmz+pke4cJlb5azynrHRqtdRtgBxhqVbBZITWM9aLChEBTzvYetfe8Y4KIAJEDgMzLsBWMwfu92M5EmcHuW1N2DK6SJdGa6ItCm9d8Go/5adVNPy0Qkr+3+Fth5et8XQL3YBIdoFuOVx8iOeEShlqO/kDhevRqE0Wk80enILhMOOTyXZ9+V9AvPeC/dqJseDPC31CtTwoc1KKDNn+4rfhqntEoRqFAVbCy2SohzZuke2OLp8E+VxUKa6KxVWWFiC8Dun+wVTU/zvZO+7m+1SF3blTfWdpeBmGQeR7U6XT5bZefyhtuv8xjcOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7ztfcu48bA6MH1MBhR2eHUxk8tbaAygs5JYpVEvIFQ=;
 b=hbaEwj25jjO086+/efdBHBpHIo5yj0VGgdoejULswYTPo2uxI8tzuH271lc/uE8G0ROrS9z6gsFtkZUlD2N9CdIacuLkRgSXmESYyfE764xZtkv3jxbjJSEaJsVVuN1pkx55aCncpKA/65YhgLjRM0I7PqEKz/dS1MGtOPqVgP0tXB9/PIK51TRbda+wwc0ZNYKAuFfPqyDRD1waODHkYkpCP+hox8aR8Mpx6FgCiJGs2a0HJlCcYH2+3gOZrDNh9oIUsKnrrhkf7AOAnbO85bgC/reU2oXtps77YbmhCwjf/HZLDohaiv7C7Z04BPX4xyr9Hkcil3H9BktoZKzbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7ztfcu48bA6MH1MBhR2eHUxk8tbaAygs5JYpVEvIFQ=;
 b=iFU6vJYqIJb1ALttDkDnaAoLG/GmEPIP3gaZ7UOF15FWy+9aubLgYWydn5NMI7/Gax3r9ydFrx3XgLPnqan5ibF8PKoBDjf2FoK7UcKqteXj60URkBMn+LpNnpb5UNlZhLCVEZ3WEqhRLufRGUnz2+r6hKyR5byMw3q/S5Iy1a2UOCmJEDF4KXlb7z2ku9Wb/3tA1SXkWZcC9nhGhcUnEteOwIO39DN6l+aDH8Uq0GAh+sq9IIzJRloqyfXK9T8n3XmcMGvZ+clSblnxctcqdbH2l19804prS+ld/9ba+p6ew3mzleFOns+1XH07ZtwlHNdjoZSkPG0EX9OXOZzVuQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 21:42:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:42:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, James Smart
	<james.smart@broadcom.com>
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
Thread-Topic: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
Thread-Index: AQHYzRTUXhKv6aL7AUeWCA7j4uz+sa3o2ZgA
Date: Tue, 20 Sep 2022 21:42:28 +0000
Message-ID: <b7e771d1-8ecb-3e84-bc94-af0b8fcb8259@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-2-hch@lst.de>
In-Reply-To: <20220920171611.1289361-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5052:EE_
x-ms-office365-filtering-correlation-id: 50ad4e3e-ede4-414f-b285-08da9b510411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  EotzahfH4Z/YZN/Rnka+PhG789Rsh1LTm66EiZuL7rprbyou1mqKs7M8UJa7sMCeHeySKPTZcG++HUUvcj75SFf52H4hDfZ9JulzkUhTXtDopL/kFHX7n5Gjd1uPXU6DOv1RO5hDyCzX8FXo9UFq8E/MmRkbEAGfUmzbFDLcLmq/yTnb53MjRBwRiSFAD6U0fpVk5nzatU5Oyk8LlQ0E2bdj5hA4NyPFpJXsarPp8RujCbd5gFCvQVlZE92Agcxsn7Hkxn6+/SdHarSGMDjsFGf3lOExwMSpyGPjT5ogwW/kvHcJ59sWG87fffU3OOuslZd+KF/3osFkdfP2FjHwcl699kx+huFdRngUQarXJUfavRaFmdoZZW6vxbThUVKeDOK1m4O22TBhpl4R2qV5XuAY79sbwmun9pCUy7aCHs5WdvKjDE8H/lTXU7Xu/S7aDUnqKPar5spUGeqZeFuyuip9ZXHeg3qhG99ivodPEDBzVu4xDzEDMXn3BiWzcNG60hNHfUnYJtG6Yu9Y57DLbfgIh8av4a3MiUiertDLw44DuJJ2uBVLRZzR+w1PvQh6W0RwFMsiolmYc29QE3Owjj8zp6UHPWnJniZ9gmgHGZmfjYc+NVo14D9fZgE94iYb2ng9h/LMT0U3/w19TAGnavTIA4+Cwvr9N9FLu4B1JoryuGDjWNwatT6s8SKDsu6ALWdIWLpDPgicOwibblwHG/mDbbyXIIaCYnaHjAPZlQvk8SS8cblujJFrQGn/mxQwC41P5QHnCRFMrC0ZHcF6y2qrR0TwSTvSE6bbkC4eCXfquovLRBJnC0eKKXP+R7PjBJc0ICT593oj5Kkhvf/ViA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(5660300002)(4744005)(31686004)(122000001)(83380400001)(71200400001)(54906003)(6512007)(2906002)(316002)(6916009)(478600001)(6486002)(38070700005)(38100700002)(2616005)(8936002)(186003)(86362001)(31696002)(36756003)(41300700001)(76116006)(66476007)(66556008)(66446008)(66946007)(64756008)(8676002)(91956017)(4326008)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SzFwdzlLUFJXM2FkeXVtM3lCdG0wU1JDbXQvZ08yRndmcS9KVjJ1akdTQm9a?=
 =?utf-8?B?bnkwejY0R3hXd2pyZjdxOFkzdXc3cmNYMExNc1VKMHBYU1h1Qk53WXR5Mms3?=
 =?utf-8?B?Smp4bjJlUmtwVEk1UDYzMGk2Z1VuMGxIM3hEaFZneDVuMllBYk5xbm5ydXRQ?=
 =?utf-8?B?LzVSNjVqR3ZicDIwcmNGRVVUREwzUnkrTldOTjdpSlJSbDZJQWg2aGQxRXNQ?=
 =?utf-8?B?SlRVT1pKaVZkZkkzcXNTSGE3aTl1dERPN0FwOGdaRkdpMXcyVG9XS2tpb0hK?=
 =?utf-8?B?UkdkS3h0dXdaMmdtQUlZUjV4U1p0ZkprQVMvN1pDcXZsZHZUOVk3VG96VC9m?=
 =?utf-8?B?MDdEcjdZRDBtelhkVzBZbHdxWlZyZkdTVUpiNEgyZmhHU2JUc1FsY3NEWkU0?=
 =?utf-8?B?VG9vVTc3Z3F4ekRSQVFRZDJlb29zT1pNdUVUWUFDZkEyRS9IbXREN0pNS0Ny?=
 =?utf-8?B?a082alFHeTVteFR0L1ZzdUM5Z1BLTlVWWG9JUHcwWUozN2hDMjd3Z05LbW1n?=
 =?utf-8?B?K2UrSEFJREtQT0FpZmlJTXlLeDJ4ZmVxTUhyZjFVZ21hdjIrampRRlUyTzNW?=
 =?utf-8?B?ejB2ZVkzM1p0NU5pNkc3bGcwTW9PR2c3a0dwb2grL010amVxLzFaT0dYNDgx?=
 =?utf-8?B?c0JYNUNjeUFsQ3QxL1M4MTZ5ZStaYzd6Snl5TnZ1YWtJa2w2ejkrZ0s4Tnl4?=
 =?utf-8?B?WWJOTTFpdmdBby81VUhRNzdtaFZLVnZKOE9CSWJnQzRuYTkzUDlSVVZFK2Jr?=
 =?utf-8?B?L2lTaWVvWWx4YlhsSWpPbkxUNnRDbDRqdEExOFhwN2IvTHoxekQrVE4vMmRk?=
 =?utf-8?B?cGJBbVBhL29ZeHpCMDFxVENWdFVLdVVmNFFUbzdVb1Y3cGNJRVFFNWlBMTdq?=
 =?utf-8?B?dS83UWViUVFLYWQ2U1MzQ0VmRm9EelBIUWNrM1pSQVYyc2J4RXptNG1saHBn?=
 =?utf-8?B?YllzRXlHZ3V2N0hXRXRGYzhYYUgwUUZrYmRlcjhoR0Z1bDczNzhsaTVOQ0Ju?=
 =?utf-8?B?eU9hMWZIQW83NkhvUWpwODFGdkNreXVjWVNyNkExZERHdGc5c2g2Znp0YktK?=
 =?utf-8?B?RmVBNDFNTTFRQjVPNFU1TUVRdlNheHlBeUt2cVhlVlBOVys5NkwyTFZqa2hJ?=
 =?utf-8?B?NlZDUWpRaksrZjZhaU4wRTl4NEd6S2tpZi9uU3lwK3E5WWNqTXY3UWNzSWdG?=
 =?utf-8?B?NkZEcXNSZVhsR01JeEhyL3dvdk8vT2JaNHM1OXA1M1J6cjZUUHBkTnk0MzRX?=
 =?utf-8?B?Wkp1N0hiZEM1WFR4czl6WG5DQTl1RWx6eXkxRzg2NFBPOVQ1djc2SlRIWm1z?=
 =?utf-8?B?cW9qSzVjbHoyWlRTWTA1RklScll6TXN3YkkvWU1ZRnVqcFNjb2pwRG1VNlAx?=
 =?utf-8?B?bGdzbWZ3bm50eTJoOE1ZR1dBQ2d3UUUyb1NkSUd6WDlwaGcwVHRRU2NPbXc1?=
 =?utf-8?B?TUZEMlBwUlZIZGdtSUlxOG9zQ1NQSllZb3pmUVNVM05PK1FDbUhFWDV0aGZZ?=
 =?utf-8?B?ZjA1TGJWUitKUEhOU3Zock5JVzFwOTRnaERsSU1GbjNTTEluQlp4MnpwSWN3?=
 =?utf-8?B?SXNCajNGNWczcXBJcTJKL0NlRWRPMUZwNVpteEtZZ21paS8zR1ViWFE4dzRE?=
 =?utf-8?B?eFhmQUoybi9XMWsvSk5kOElnRlN4N0NYeXQ4cStMRDYraW9mUXk3WVVmR2ph?=
 =?utf-8?B?dTFGTkdQdW1rN1Z1ZUtSUzZYcGpsdlRaUDFMV2VQTnNwcURnZkF5cjZxb3Vy?=
 =?utf-8?B?c2ptTEhLa29QcC9hVEM0NjZjWitxODA4QnhYRnB3U3ZBa2NsM01Vb3ZVTmVQ?=
 =?utf-8?B?alI3czcwbjFZbnRFMDBBYkxuVWhtdTg2Nnd4U1g1Sm5CeXl2dHhIOU12N0dh?=
 =?utf-8?B?TTE2N0hCOTRQZENmL2tyam41Q3RkOHdQTUxPdGZEZk1zM1JIaVVvUkdrK2VY?=
 =?utf-8?B?NXpUK0hZSUhQSFg1V1FVWHJ1M1JSc3NOcEJQNnpObDZkSE5MTGpMbEVrZ2VY?=
 =?utf-8?B?RCtvN2gyOFJZbmtacmhNNW5ER0JqaFpaNnprZ3lmMXBRdFhna1IyV3p1NFRz?=
 =?utf-8?B?VWRPZ1dOM3pZV3Jnb1BibHM3QlFKY1lPRjYwc0xzbTR6aVFyZmh6Ny9IYldM?=
 =?utf-8?B?dFhGUi9vbXB1TGFUdVc4OUxBaEhsZHpUNzlsa3o2L2V5S3p3eU5mVW5ETzVJ?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E64C2C0F67A5F94EA8F4C0C4AA581789@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ad4e3e-ede4-414f-b285-08da9b510411
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:42:28.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABWPScNvU7Pu3n4x9wKvu3lZF+M4nSsYvRazX6pfo6G4qgXJlWUgAwYUJcRBaa+5vEefmyYQr53+1Xuwh6/xAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144233_612443_1B93CB14 
X-CRM114-Status: GOOD (  11.07  )
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

T24gOS8yMC8yMiAxMDoxNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBjb21tb24g
aGVscGVycyB0byBhbGxvY2F0ZSBhbmQgdGVhciBkb3duIHRoZSBhZG1pbiBhbmQgSS9PIHRhZyBz
ZXRzLA0KPiBpbmNsdWRpbmcgdGhlIHNwZWNpYWwgcXVldWVzIGFsbG9jYXRlZCB3aXRoIHRoZW0u
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0K
VGhhbmtzIGZvciBkb2luZyB0aGlzLCBJIHJlbWVtYmVyIHNlbmRpbmcgc2ltaWxhciBzZXJpZXMs
IGRpZG4ndCBnZXQNCmEgY2hhbmNlIHRvIHBlcnVzZSB0aGF0IHRvIGNvbXBsZXRpb24uDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQo=

