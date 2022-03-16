Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C943C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 09:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4qv6WYAU5jlar5ZSXa/duDkmYwsKOF/SAw7TaVR5Uc=; b=4KKXf35rGSDA1kHmZSX0EC6bzM
	PGM10/KV3PEkFOB7tLuBD4lfUBcea90ZNSnaGgoco96bYTlTKQDSDa7EiGfXCj41ihxiWaW64PWC/
	/t7aztleN4rCbA/jo8wacvjSSvTV2lUIPLvp2Dl/itND+eTqTuovSsnyKeWcTUFtQdpWQFEhVO3l2
	SxdQjdHJlOnMSaMnWW/3ym0FO6BT2C+Ap6eder7VuXBaajjFI8+wQTV+VP5FzWI7JyoVXbQ60ZDUq
	vC55D5bW2sZv2US0BiXOd1+BBZtGcvj8/IVX7LcUiZAjZcEu9YgtR6tO3lZGNgTA75Szh8l53uua9
	k5w1SDTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUQNh-00COLt-Mn; Wed, 16 Mar 2022 09:55:49 +0000
Received: from mail-dm6nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::60b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUQMk-00CNpY-IN
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 09:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXGTJ8QdBygHpZKxrrDkjL4iDMDNvobBsdBFse6FQPmR1pwZtaF/wUHmutLzXioIs9VTxQguQkdqcZaRNg1tMg5Rjw2eqYDJw78SSBHivdaZRHG34evdCLPeXilLacAIEPaXV9HHfN7C1HAnRoxEh+G9bKpZD9eN0R18Rs9TV5fFrDrGfCTON7FCMJGD2K1DQJ0Tx59dAnd69d2fKnHN0qwIL4xLIR9aHk0rqfHpGQJXxBk2PcdIzRb5sOPd/v4+yZ6bMqXRhmFSg6UIn5NdSiNspz1MXL7bEpL2sijD/sg4zVWSat3W9ViTQi54NUPo83104D5xDq/EJjg198BPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4qv6WYAU5jlar5ZSXa/duDkmYwsKOF/SAw7TaVR5Uc=;
 b=mqN10dRnsQUJntnCFLhD8TZURt1/AEGVGNwsLJCNbmMH+dxb7424NP8O7HLdNe7iVYFHEDT/VAioPPciCYa7NiNMFQqE5jFjwVJu9SYYRfOhPYLnma6xrMwUY0B02SIzThDjGt5BrgjGj+Sp4CSgfV1uxnYoTQISa9cvIkvVp/mJ4/A0r3QuiwvWX8+Vw7a3ocDTNbO2rWrnXEjcesA4CofaEejZwj8mbZJ81u9/C64bnrZpqlzoU09CHjC/ejMZrwPXTdv/BLN3sWnLZtMMId6w0+taGUQ/ZM3w32W0g9zcAMyBBXhX1yU9gnt1H7qqhYa6QyHq1WUnYIV28iqtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4qv6WYAU5jlar5ZSXa/duDkmYwsKOF/SAw7TaVR5Uc=;
 b=lvhHmWLVKACmWzrxAL/7SyrfitkcNgkt+B7wo+0WVBoVkmiR9giBD4AczMB7cKZJ9PkUHObWqDZHF1h01+otUr1hfqwe50+AU61eSb8mROVzfY0H0GhVPjCweuwMnqFTktj1ECJJlUDyxjUkZgHzkoFBrx3VgmGFvJqVc+m7HndFViFzlTtbu9e3QlJCAeKG3ASaMoPBDxv7C9iyMhrK0SXbqBCldFmbvcUS/NI7LGLkLw/sNMDBr7jFvHxWNVcKGeV2weoXuKjCjxnnXN70V97WQZF+rghGptBF5/tRJMccA49/7fpalKB5DdXdsYadq+C3yfIuK92ERJ4rQTpB1g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 09:54:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 09:54:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Pankaj Raghav <p.raghav@samsung.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, Jens Axboe
 <axboe@kernel.dk>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
 <javier.gonz@samsung.com>, Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Topic: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Index: AQHYORlQ7U3+JbEzPUiEJOfuOlviEqzBxYiA
Date: Wed, 16 Mar 2022 09:54:46 +0000
Message-ID: <9498d380-0172-dae0-9354-bd4d725fff5c@nvidia.com>
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
In-Reply-To: <20220316093423.17906-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39272525-77fb-4845-2ab0-08da073300ae
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_
x-microsoft-antispam-prvs: <BN8PR12MB4787CF333754D2479B6F316DA3119@BN8PR12MB4787.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVAjhUlOjspzuvCBCSoOpszf3u9nWgYrnRUvZ/5I2ZXAQCh98VUhiiHcAMmVHl2lZcsLBMHZ/5xlOedtKTWvNQ7IWegm1TNK11vPNhlGSmOiEKGc1rWgrofB31wnl0kQbX06cLAVjvnX+91Tg/U1DVbdQJTEh98Rjnj5RXr34XE3s3CvsqW467cKvxhqEjKbxkPxNqkONX6PMJbLMuhX+4wgkbHVcHKBx7Dn84PEDzdYXZWN6r+qJsQvnjEEKoinJxj9zHAapChlRD0UKJUJcUNn3nxsPFg1UbcMpZsVfNcFhiaMUNfMWRcbXnptaCrtUXpEGvWkHoGnkBI9Bil3wjSRV+fbG7wHgl3hQPqlibG4+jPYuFH08h2SBCsmpzYTOTfq3vrWGOxsrg0R5SlqsB2wtBKjlJozNjYDbwQR7Be55HFEtsX2lSECoHMkdZMfBwkcIitnh/MP3j1qe3ZJB/TAQWZ7Fc3uUHB/rWwxMB+HwyzSqNsq5T0COviDNtCO4u3Ty/QYaivnJUhBONgQcH3hWwLbUFrTfTQvd5uRNvEo1x6PK0ZWTTcBO3zpJAsj9i9aRTY43NE6sOMJIWAkE3z1vjF7NEcJueVHKX3eGi0GKK6dt5pY49Ygk51J3QnZrJzALCLck8fpfjovpc17DWQEp8T07nYUmv56dZk2HW5eGiCUzR1mR1W+dlOeJzmTzdI0k5lRPl3wbzPslINpA2X/mn7BoE/fUUhlMPw1az3jBnc2HBhiwDUIl2DNDLrRkE4in2uo2cfD/bKZnQIrpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(186003)(38100700002)(122000001)(83380400001)(8936002)(54906003)(5660300002)(7416002)(66946007)(66556008)(66476007)(8676002)(64756008)(66446008)(4326008)(558084003)(2906002)(76116006)(508600001)(2616005)(6512007)(316002)(91956017)(71200400001)(6486002)(6916009)(86362001)(6506007)(31686004)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkdBVVRSUEx2QTBEMDFuV2VDQ25IUUM2UWxzTEdoRVJNVUZUeGlOc2p5MXFK?=
 =?utf-8?B?MWNDZU1ZdjBPVGJJZndvT0VjTm8vNk5nSXJUS0hJZm5sMmsyWng4ekEvYU9m?=
 =?utf-8?B?ZkVBSmNRTXpTblZyZ282L0wrQmtZdUNIN2tQWGovR2kzZkpJL2hrQnk5bXFz?=
 =?utf-8?B?MFJNRmRybU5SQTd1STVpOVFyQmhpTzRwL1JvWHlFd0tCRTBETnF0VTFhNnlM?=
 =?utf-8?B?Vkp0VXZ1MytZdmV1NVViNmc5TmhsaHpIejg4blhSSHhzNVlYTDVmeGY0ejFJ?=
 =?utf-8?B?NlRNTGw4Y1dzckRNWGJISkNocnBBeE9pdGxzcG44ODMvcG9jQ0UwV2RCeXlG?=
 =?utf-8?B?NS9mNC9WakYxZmM4R2FMWk1kU3lJbitZOGFja0t3ME5SaVNmc3l2WEx2UDlT?=
 =?utf-8?B?ZU9VbVNodVdXdVZGNjBRYWJLNC9rNFhlR1dzZmE3dE53VDMrWDBWUUxsTnUz?=
 =?utf-8?B?V0l4U0doQk82cHpmbmpOdnV2djlnMi9RYWltcEVUSmlSd0ttcjdGS0M0Ynp3?=
 =?utf-8?B?d01ISE1BbU11b0pXbWFmSE11ZWJKVGlqRVpZbEpuR2lucUNiSmNLMHBQMEhk?=
 =?utf-8?B?dkxrQ0UxY3FaQlUyZG5icVRVemlidGtJM1V3TysyTmlTUUJGdjFERzN1UzhE?=
 =?utf-8?B?VitWcnFhZjArcWErRTQ3NjFvZm5KVjVYeW5pSnozWEFkeWExanJHVTZNZjlu?=
 =?utf-8?B?UlRDRzVKTTlIbkNDSGxpS083OXU1bUhKTUJTYWlYamhtSFpzREVXUnVybG1L?=
 =?utf-8?B?R0NZTG5XMnBNdjVWbjlJbk94Y3FVendZYnBxWmtqeW4vdGZQbXhtaFBubFNP?=
 =?utf-8?B?dE1tODhSSW43cjZESjBGdGY3ZjluenhSZmg1eE5hdE5JSktuZ29kU1dTOWtH?=
 =?utf-8?B?TEgzb1RpaEo3R3BFWTNYSW1UM3lOdXZMMjJUK3ROMFp5REdJV1h2NjB6ZUU0?=
 =?utf-8?B?c1VKelNnR0hLWkFLcWFuQUpkODF0OHg1UktiNlFHa0lraFVFUGNNbVFqNFFO?=
 =?utf-8?B?TElIK0VnODJ5dkVWRkFsS0dKUmg3aUY5U25tWGp3UnNUYUtQWDg4R1VGWXR5?=
 =?utf-8?B?bmpmWWJJR0dLMjJtdVNtVXhPNEFPcmQvS1pySE9ITTZQNDJiWUZ1M3M2b0E1?=
 =?utf-8?B?RHBvWnRLVlJ6MjljNzFEbUUwUVNqZnhXcENkUW1jTXRUMTk1c3NrS1NxbzZL?=
 =?utf-8?B?bm1iVTVtRlcyU1FtMEZVL3FFQjNuY0xaS3ZTQllibWdSd1BQaXk1NjU2dkV2?=
 =?utf-8?B?QzJvV1JLdkQ3OHpFeENMTzVJYTFkWkpYR1BGZUoxMW8vektINTd1NTZXNDBv?=
 =?utf-8?B?NmVOTWVlaEZQdlZoZ2RHcTI2UDRoUTBQOU8wTTJHTGcxeXZaMHlzUlpyeTlI?=
 =?utf-8?B?S2FQTUFWTnNPZWtBdzJhL1JnM0Izd3BCQjVIb3Y5andVdHJ4UDA4K2tiNHFw?=
 =?utf-8?B?aG9yNGxjZUljZ2xJOWh4SnQyS1pYMmZWS1BLS0xaR2EzU1l4Ny80K3hZb0xa?=
 =?utf-8?B?djM3S3RITktubWVtUUdaM3lCNDdUMUdLamxmRmMrS3ZXM0pnRmxGZE5NTFM5?=
 =?utf-8?B?YVVTZEhJM2NjaER4U2sxOFk3Z0hQU2NqcFNyZ3ZVK3RoS21sd1EyV0VIVTE0?=
 =?utf-8?B?K2IwWU1pN1FtSUx0dldGWCt2ZS9McEpkTVpXS1lRRjRMc3RkQWZVVGNsb1FJ?=
 =?utf-8?B?VHJUUmd5MjlxVlRKL0NhN0tQZlhNcTFsVk5Bc3lzY1p1b2xrR0ppb0huVkFN?=
 =?utf-8?B?eU0yS0VDR3cveGVua2lUOExITkZUY1lMOEkrR1E2Mml5UHVCTE92T3lEbmdQ?=
 =?utf-8?B?c09uZnJuOEc3M2NLalQ4MUVUbXBKc214dXllQzZnbVJORjNldEZVMzNxdHZz?=
 =?utf-8?B?c3J5dXJsMWhHNm92QWtkbDdYR2lFNjN4dWhES2ZEbXdSMktVQ2RoRzdoMVNs?=
 =?utf-8?B?YzFiS252NUlRb25lb2xtNzYzQ3l4bWV6MzV4bkxFeGRoZ1pIMFc0Z05ET24v?=
 =?utf-8?B?Nm8yKzc1bTVYMXFVc3oyaWpaQ2xoNmxLVC83Y2VZOGhhdkxmQU1NcU9EU0x1?=
 =?utf-8?Q?fgHX6b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95083F8E85ABA34C9A18B53E433E616C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39272525-77fb-4845-2ab0-08da073300ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 09:54:46.1393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0sUr5wEIeYApAfFlybliVFoUkOja4U0vFOXf5yWT4G9Kdd0DhSqgVi638IhFi/RExTR1BqwSQrSJeNC4PIaCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4787
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_025450_686797_483AD62D 
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

DQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9zZXRfZGlza19tb2RlX3JvKHN0cnVjdCBudm1l
X25zICpucykNCj4gK3sNCj4gKwlzZXRfZGlza19ybyhucy0+ZGlzaywgdGVzdF9iaXQoTlZNRV9O
U19GT1JDRV9STywgJm5zLT5mbGFncykpOw0KPiArfQ0KPiArDQoNCkRvIHlvdSBoYXZlIGEgc2Vj
b25kIGNhbGxlciBmb3IgYWJvdmUgZnVuY3Rpb24gPw0KDQoNCg==

