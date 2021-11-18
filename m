Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7ECC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:41:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA7261B30
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CA7261B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o5ICRYVfNaUWCMNXw4dXU1v/P41ifBWE7PSUF+y6h54=; b=4q5aX2VqRtt0mWEmQighs+/UI7
	6O1114UeZXRqYxS7xzHNDvab3fKoY+PkqpMGPOwVzTnMJDSctywTWHJXL4NyD5fNvevEeszpPgq7a
	EmrxaBwFn7S9J7PBTXetM+nPS9Z/JLYpj0hUNk4dmDmasfvMuO23/pWFdKK7QMc1BLgtq7yRhw6e3
	iDVJc0WBGelpx7ygksRcScXPkzUr6RgEZHu4edRoMX8ro2wfzEIOlUryCaepN1OlH0U9EImu2P6gy
	gHy2kue9pvYIs72EmE9yNNMuY2bdHp4vNyW1maHNoQvEu2vYHESmE47pUBxO5Apg1QTrZXltrOH1p
	7utzpEYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mncyu-007EIF-UZ; Thu, 18 Nov 2021 08:41:21 +0000
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com
 ([40.107.236.69] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mncys-007EGg-4y
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 08:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAdAEvoKtnlshXsx8UOp+oTm965EidMgj9MOa4/oPiTlCnGe8Ig3ozRz7rZj4P+iBUFNWMM3SpV3mrIdGSnQbb9DcT8yibYav9FV1MA/IZKgRMKp4r4Sj6UXVG2nDpAQZ872lXLid1b/4tFqzigTyLjhu5Z5PWg0WeHmeh5i5EJWNyp2e7RV8MkpjfLPYo+pUzxmEwzd3Q5eQ1tI1VA1PjUxeaIp7fFbC2y68EaXwKukMEoUMxgQGg8MtSgT+5jjL5p7ntusWM7hfGjWLF2woLO9n8GljpBLI2H3Y9690+wT1iS7tqRMIe1GDjDLPFI1DaMAnCgOcAAbZWe4WqEhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5ICRYVfNaUWCMNXw4dXU1v/P41ifBWE7PSUF+y6h54=;
 b=jrCl4micOzutVcFNwWL6xNtJyMVWRgtHiKdsO+FwPSpJIR6tRFsd4gXCjgFx/d1S3SYxj/jYxrIuXlWBYMAZ12G25aom5G8cy5P+YV+kuPJLFoTbMfgqqVPNzKFaRiz/S+ioro/g9yFqXKUVqHnnpJRIbawFWTrEOWHEswHCqSj3eBpPUKiTGtUz6HFx8cCptZGaYjZGSQ81Jaz51e0xhN7yFRPlp624b+zab2iymumLvcO2zaQbU9GZ7wpdFFtuTdafTt33wjx2ufLSFsSrQ/QZvc6YBbDrxkwKtgTuZJDmIVoEsPor9+3gaKe11ya3CMt5NH4XWDBDH32Si/2OiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5ICRYVfNaUWCMNXw4dXU1v/P41ifBWE7PSUF+y6h54=;
 b=jNnC0Aaj9yXNPSXUcdk+jtAgfwRFMyyRxkImbIBcyGfyZtAIHXb2jonmdhhPscMxfcGJ7oTL13qK1lIgHgMimcGPBW6xA0I8zOZ4iVFkKX3uNQr8BjWVTfGdgcWJd22P4R2mKJOefP88qmrvWhrQP47CLtm3VtkEkPpVCnV6gvvVCk2Q6jUcgnL0XE/FKBnwGmccjSdP4v4tlFuuS9viG5gbnhnZ8B1t6IXPQGf0T51dfCB40O3ywTh/tPD2gmqEY4DhsImbMrtHnL5jI19amprqDprhSuAjLPofwmNt+X6AHqINq+Oxe6RWX1eVfBQ+54kLyS//oKrqJ1Wgts0sCA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 08:41:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 08:41:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Thread-Topic: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Thread-Index: AQHX28dMLa7pEe33C0eG5lxvCwWZk6wIiEmAgABs9QCAAANFAA==
Date: Thu, 18 Nov 2021 08:41:10 +0000
Message-ID: <b057568e-3b91-c17d-c4ba-71825a6dc262@nvidia.com>
References: <20211117152454.122014-1-mlombard@redhat.com>
 <b0c0a83c-df9a-0a91-1dff-f6bc647a5b81@nvidia.com>
 <20211118082928.GA82729@raketa>
In-Reply-To: <20211118082928.GA82729@raketa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fe4a77c-8df1-45ba-4837-08d9aa6f2c14
x-ms-traffictypediagnostic: MWHPR1201MB0160:
x-microsoft-antispam-prvs: <MWHPR1201MB01601A895DBB021D41DD07CEA39B9@MWHPR1201MB0160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EiZfMsm7DrqARfC6jqS9fWjrBIp5ORunnFahHCspckdgI9m+JcjYevvo4sRzxVl/yT12Vyvmq80p4V63h5PZcGIn90bGnxOT65uHxMEDYNwCqT2CqPw0sm6A9k/eYcFbrT0b7nC2xpdRSsV46CLjj95w/e0rupyyj3qrrVJBgXgrqbPfOCa1YeyNmk7nNxyQ/gN5JPj8KB9XZ2rgMK3eoB03AeIy8S3XLKLFyv6ykIviW8goXx4YM8tY40bU43fY86BX4A5nBJO1orVM5/NpaMYVyOeVX9YGqZBO+aU+nE5g8CY22Z3OU4lTbA7D3ocZ6YIxXglbhurXA836KaUQdzC6DfPZLfHu454BgyDPZ7r3AXwaPRX7TYqJVZdVykmsL5skntKx1XlL66JTPIcfkUbeF34R9/EwDriLP1KZJZq+kdjKqEU08/m/DSl5lED6/KGDhuxPb2U2XsGkzEkQF3iK4phhuj5iqJ/FEqDKVc3LAI+dHkw75ZotxrdIhGwmmKxzg8stozXrKGLJtxqUljJtqkkgId59LzxEIJIbRORXU+iJpaMK211jQGNLcyErorctGMdwynzPDvE0SYPXtCoKZ7SIwiawF8t44PjZIix7t9yNS7Xef8+w/+9AK6PYJwuiKIhi4Vb+K4GQup6+rm/dCJR8gE62pD6EvBDp1NdKP9ZqXHjIW9BMRkV/j5daAIayKe7m9EtL7BI3gP/4eJ6RoABrVq+rRg6ouutRmbkkBAed/nTOYmpSZSjTY1YAWtudAADxkWX43HRWW8h+ervnpHGM+7xe2ZBA6h5uFeO9MHqqR1kLlraTxbr97/Cf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66476007)(66556008)(64756008)(66446008)(31686004)(122000001)(83380400001)(38100700002)(66946007)(316002)(4326008)(54906003)(91956017)(71200400001)(2616005)(8936002)(86362001)(5660300002)(186003)(8676002)(6486002)(6506007)(2906002)(53546011)(6512007)(508600001)(36756003)(38070700005)(31696002)(6916009)(45980500001)(43740500002)(505234007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0ZsUmJXMGJmSmZlekVsSEdqak1sVWRQejNrbWxFVndEVWk4ZUdHdEJYVTNi?=
 =?utf-8?B?Rm91dGdIMndta2JkamlzNGNHbThZekdZbUQ3MkFMZ3pJRDRpWklzNEhCamFF?=
 =?utf-8?B?aUpISHhTVlZMS3NvcHFJRTltcmlYL3FIQmJqNXhhTjlLS0lQSlBDbEU1SXdl?=
 =?utf-8?B?aGN5REZ4Y1NiaFh2Y3F2cy9JTU85bExpQXVpME1yYm54NS9WNDB0Tk8yYXBO?=
 =?utf-8?B?ZlJ2RkFYWEZDNWpaTlJpZDh4aW4vaVFPY21OWkw0RmRiZUdtb0JDNkpFSTJ0?=
 =?utf-8?B?QlpYMUE4cVRuN0t0UHpreHI2VlYxUDhvUzVVUW5VU0J6N2E0TGZ0NWJtVWxy?=
 =?utf-8?B?eWJVY1hhT0c5WEVqbGZQdVU5VEc4OFkwMDgwWjlKRldlYThJVVQyd2NiU2to?=
 =?utf-8?B?QmwxZzRvMm83SHpma1RhcGgxZVAwWVVpemNJek4vaURJUC9OWnZDMjZ2bDNL?=
 =?utf-8?B?QWR2RDByYVlYT3h6K2RsQy9rd0c1ZmZHa21BNGpNNlBKdzN3ZXhnKzV6Nkkv?=
 =?utf-8?B?dHZRU2R0US9CVFA2YnhCbzVFRWdJT3hoaDJrc2lGTnZLV01Wa3dzRGs0QjFE?=
 =?utf-8?B?UnA0L3JmcE9CS0J0c3FhZ2dWWmdkeDZxNjhqTG5IQThUZjNqVmkwOTMyalBW?=
 =?utf-8?B?em5ZbktzRGl6b0xkbC82bFg2S3pRejQvRi9lVGg3QWVsTFQycjBSTXFIUlJS?=
 =?utf-8?B?TExMcVlqR0tTU0RJb1U0ZTJzWlZEbmhBQ29LQ3dMakdsdzg4UEoyL21ZM1M4?=
 =?utf-8?B?VWFrZXBXS29OS2R5K2NLQVMvTUtEOGpVNEZzRjlqSU5YazFuRTJuSGc2dFVE?=
 =?utf-8?B?ZlU0RmVXNWdod3pCMG91bXYzbDV0M0NPa0FGN3VCK2ptaWNPeFB1OXp0U0tQ?=
 =?utf-8?B?QnRBb1h1N2ZxZUNpN1FlSElUTDJJc29aWlIzU2w2a0F5c1U5Z05ra1F4QVoz?=
 =?utf-8?B?bmEzMzZTS1k5TGNrUmo2VHJnUVhQTC9YUEEyenZOT3JUM1hFc3hzcFZlNndB?=
 =?utf-8?B?M2p1VXJ1TnZnc2YxVUF5ZWpSbldqZXZJNDhrd2lyZUc5Zy9XY3NheXdGYUFO?=
 =?utf-8?B?RmZtZGR1M3Vqb00ydXRJTXUvL0lLS2p0dXA0MHJkNk5yY1l1V29XN09HbDAy?=
 =?utf-8?B?aTE3SU93N2I1YkdLOUE4WWhISEdsY0g5Tlh2Tm1qNUROZ2hRcDV1TnNLNWJO?=
 =?utf-8?B?eFo0dWg5Y1RXekpUaVNZMVVaVDN0V2UzL0dSSnkzeko1MXhCcFZVSDA4NzAv?=
 =?utf-8?B?Y3k4M3VtenRHcy9VckIzYU5veUs2cWRBSDdYN0tMWGFlL1EzYUlJRkN4cnNs?=
 =?utf-8?B?ZXVyMEFPYmpnY3M3d3I3WG5OK2tBeVNpT3J6MUpYWjF1eFJoMTBFdjlCTW1Q?=
 =?utf-8?B?V09kbzhXZTdQSkRWVktUVFZMMzdhQmw0RFRDZ3RPYkdrWWdCUmM3VDlVK001?=
 =?utf-8?B?N2wremxFZ1pkczNFZHFFYWdFUGpRUEpwNG5HNVBTbGdtbGc5QUlLa0E2dHNk?=
 =?utf-8?B?M3hFQ2ROYkpNbTJmczFySDhpTEhxTzdRZzdIR1I0UTZKWmNtOWQ2eldBdits?=
 =?utf-8?B?QUpRNlh5dS91ZUFDNDNhM0xnZ3hqZTVrR0RaOXVzODBhOHgrM0FUcGlOSGJP?=
 =?utf-8?B?cE9UU1JHWHpxSnpjWVJKdTlsL3FoNm1ieS8vQVN4b1F5OERQZVZYdEdJcW5G?=
 =?utf-8?B?ekhNRy8rRDNXVzFYN1FTUXlSekNHVExLNzhEOTFDT0Y0cmx1bHg1WExPTHA0?=
 =?utf-8?B?d09MR1ZiRVNHTmwxbUluUEdPcytnUDRkU3g3Vzdnc3F4WG1ScHdmc2hJRUNx?=
 =?utf-8?B?bHdJdC9VZCt0ZE5iVUQ5Y2JaNDY1ZGJsZEM2bzV4M0FDME9uNmVlZ2RaU2sy?=
 =?utf-8?B?ZGg5U3JzalBhS2MrSndEbmtQWGdXbHJpWDJsNU9GRmxOcFNGandnQzlmWUUv?=
 =?utf-8?B?RHg0SFFFN1BxWGxNKzBQMGJuVTk3REo5OEF2RXdDbTB0bGRLRzZMeXlUR2gv?=
 =?utf-8?B?bTJqREFHRjhFWjRNTUhZeERzNmNPajdqMzNGWGtFRzZMY2hmZDdVRHA4VVFT?=
 =?utf-8?B?SWxnenloa0RJc1AyS1FSN3FZZDdUVnFXYk1jQ2hGWU8yM2swUWxsZzNacW8y?=
 =?utf-8?B?MlBmSEpkbkxZdHMxT09yREFnNXhKQVRDWmlPVWhwbHVZcVZmb20wbE5rRlo2?=
 =?utf-8?B?NnhtY1FhWWVKV3JMbjJIOERLbFhaeCtDRVNGWVRFOStndTlOVFdvekVkT3dk?=
 =?utf-8?Q?rw1SA1040y0KzbDrd/eUuksFDnhDQm+wUhKpg7B+N8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BE080E74D413E40BB5B2E4EB7605E43@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe4a77c-8df1-45ba-4837-08d9aa6f2c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 08:41:10.6284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hq8KTP0vc0+Fr4Hc77ShImxZD2P12HyB2IatdAaZhAwgZkjpiDDs5M7BykZTRgcTR+yRzxVW1BbkRLVHOrO/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_004118_234176_6105983D 
X-CRM114-Status: GOOD (  13.38  )
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

T24gMTEvMTgvMjAyMSAxMjoyOSBBTSwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0K
PiANCj4gT24gVGh1LCBOb3YgMTgsIDIwMjEgYXQgMDE6NTk6MjlBTSArMDAwMCwgQ2hhaXRhbnlh
IEt1bGthcm5pIHdyb3RlOg0KPj4gV2Ugd2lsbCBuZWVkIGJsa3Rlc3RzIGZvciB0aGlzLg0KPj4N
Cj4+IEFsc28sIGNhbiB5b3Ugc2hhcmUgcGVyZm9ybWFuY2UgbnVtYmVycyB3aXRoIHRoaXMgcGF0
Y2ggYW5kDQo+PiB0aGUgZXJyb3JzIHRoYXQgeW91IGFyZSBnZXR0aW5nIHdpdGhvdXQgdGhpcyBw
YXRjaCA/DQo+IA0KPiBPaywgSSB3aWxsIHRyeSB0byBydW4gYmxrdGVzdHMgYW5kIHByb3ZpZGUg
c29tZSBwZXJmb3JtYW5jZSBudW1iZXJzLg0KPiANCj4gV2l0aG91dCB0aGlzIHBhdGNoLCB3cml0
ZXMgZ2V0IGxvc3Q6DQo+IA0KPiBbcm9vdEBrdm0tMDItZ3Vlc3QwMyB+XSMgbnZtZSBjb25uZWN0
IC10IHRjcCAtYSAxMC4zNy4xNTMuNzUgLW4gdGVzdC1ucW4gLXMgNDA4MA0KPiBbcm9vdEBrdm0t
MDItZ3Vlc3QwMyB+XSMgZGQgaWY9L2Rldi91cmFuZG9tIG9mPS9kZXYvbnZtZTBuMSBicz0xTSBj
b3VudD0xDQo+IDErMCByZWNvcmRzIGluDQo+IDErMCByZWNvcmRzIG91dA0KPiAxMDQ4NTc2IGJ5
dGVzICgxLjAgTUIsIDEuMCBNaUIpIGNvcGllZCwgMC4wNjA0NTUxIHMsIDE3LjMgTUIvcw0KPiBb
cm9vdEBrdm0tMDItZ3Vlc3QwMyB+XSMgaGV4ZHVtcCAtQyAvZGV2L252bWUwbjENCj4gMDAwMDAw
MDAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgfC4u
Li4uLi4uLi4uLi4uLi58DQo+ICoNCj4gMDY0MDAwMDANCj4gDQo+IGRtZXNnIG91dHB1dDoNCj4g
DQo+IFs4MTQ4OS42ODc1NDhdIGJsa191cGRhdGVfcmVxdWVzdDogY3JpdGljYWwgdGFyZ2V0IGVy
cm9yLCBkZXYgbnZtZTBjMG4xLCBzZWN0b3IgMCBvcCAweDE6KFdSSVRFKSBmbGFncyAweDIwMDA4
MDAgcGh5c19zZWcgMjU2IHByaW8gY2xhc3MgMA0KPiBbODE0ODkuNjkxMTM5XSBidWZmZXJfaW9f
ZXJyb3I6IDI0NiBjYWxsYmFja3Mgc3VwcHJlc3NlZA0KPiBbODE0ODkuNjkxMTQxXSBCdWZmZXIg
SS9PIGVycm9yIG9uIGRldiBudm1lMG4xLCBsb2dpY2FsIGJsb2NrIDAsIGxvc3QgYXN5bmMgcGFn
ZSB3cml0ZQ0KPiBbODE0ODkuNjk1MDEzXSBCdWZmZXIgSS9PIGVycm9yIG9uIGRldiBudm1lMG4x
LCBsb2dpY2FsIGJsb2NrIDEsIGxvc3QgYXN5bmMgcGFnZSB3cml0ZQ0KPiBbODE0ODkuNjk3MTgz
XSBCdWZmZXIgSS9PIGVycm9yIG9uIGRldiBudm1lMG4xLCBsb2dpY2FsIGJsb2NrIDIsIGxvc3Qg
YXN5bmMgcGFnZSB3cml0ZQ0KPiBbODE0ODkuNjk5MjM5XSBCdWZmZXIgSS9PIGVycm9yIG9uIGRl
diBudm1lMG4xLCBsb2dpY2FsIGJsb2NrIDMsIGxvc3QgYXN5bmMgcGFnZSB3cml0ZQ0KPiBbODE0
ODkuNzAxMjk3XSBCdWZmZXIgSS9PIGVycm9yIG9uIGRldiBudm1lMG4xLCBsb2dpY2FsIGJsb2Nr
IDQsIGxvc3QgYXN5bmMgcGFnZSB3cml0ZQ0KPiBbODE0ODkuNzAzMzc0XSBCdWZmZXIgSS9PIGVy
cm9yIG9uIGRldiBudm1lMG4xLCBsb2dpY2FsIGJsb2NrIDUsIGxvc3QgYXN5bmMgcGFnZSB3cml0
ZQ0KPiBbODE0ODkuNzA1NDU5XSBCdWZmZXIgSS9PIGVycm9yIG9uIGRldiBudm1lMG4xLCBsb2dp
Y2FsIGJsb2NrIDYsIGxvc3QgYXN5bmMgcGFnZSB3cml0ZQ0KPiBbODE0ODkuNzA3NTExXSBCdWZm
ZXIgSS9PIGVycm9yIG9uIGRldiBudm1lMG4xLCBsb2dpY2FsIGJsb2NrIDcsIGxvc3QgYXN5bmMg
cGFnZSB3cml0ZQ0KPiBbODE0ODkuNzA5NDM4XSBCdWZmZXIgSS9PIGVycm9yIG9uIGRldiBudm1l
MG4xLCBsb2dpY2FsIGJsb2NrIDgsIGxvc3QgYXN5bmMgcGFnZSB3cml0ZQ0KPiBbODE0ODkuNzEx
MzY0XSBCdWZmZXIgSS9PIGVycm9yIG9uIGRldiBudm1lMG4xLCBsb2dpY2FsIGJsb2NrIDksIGxv
c3QgYXN5bmMgcGFnZSB3cml0ZQ0KPiANCj4gTWF1cml6aW8NCj4gDQoNClRoYW5rcyBmb3IgdGhl
IHByb21wdCByZXBseSBhbmQgc2hhcmluZyB0aGlzIC4uDQoNClBsZWFzZSBzZW5kIGEgZm9ybWFs
LXBhdGNoIChub24tUkZDKSB3aXRoIHRoZSB0ZXN0aW5nIGRvbmUuDQoNCg0K

