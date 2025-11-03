Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68469CCFA00
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 02:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SDvpEc6wzyyaL9ZedOVS/eo5AuSRjYUlKUD2Ng4Fjfg=; b=n9lZVjoJGzlreA5rafhtRjJpnl
	I+F4pGBy5QP9BiMhLFSUZog82N4AZG7G2MYqC4tp0MwRUUWZgZ8PpW6s+4ALXSUdoxi7OjU/IY9W0
	rH3aW5GU5z3MG9YHnWZih1SQwXvI0LC3LFl4rtBxjXNoZwg1TiCUsUoohKzut0/YH4mbsXf+u6aA1
	bjInuBnZE0huiaIp9YzzFMoLS6C1hVH77YFJOnr/a75H2OKdhU+w8N+IQzIFsO6WPkQqRnLhSn5dk
	uG432eNouNKNKTfiH3TASi/OGh5lGECs8Pdc+PiA+rnnsyp2LLQCL7yjQriYt7m7dZTVVm91ZVVM+
	FPPDaM7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFjxM-000000092tb-02Us;
	Mon, 03 Nov 2025 02:06:04 +0000
Received: from mail-southcentralusazon11012062.outbound.protection.outlook.com ([40.93.195.62] helo=SN4PR2101CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFjxI-000000092t8-1LGE
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 02:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNLZAaU7VO/gwHOUiE4lho52tf4F6zqhzwGpGKkaPLk7zJeZc5JK1Xsh7dsnteLMedk/i18ubHLrQBWUmDJtZl+nFchH9IVmo+jF0yhw5CJYPj2RqMcxyMpBSeqj1uGxyKDk7NNfSHDoCsa5wUxozOyGiVu9ZzMrdzryOYvHxlHnwn6aHa6lsdvIoQA5WLwdx5FRGyxeJi9nypjkV31lV9ktw7jU4hj5TOADuwWJNVCFjVHdbH2V9oLfyJJ+6SkmSYnAXAFKXIwA2F0I4kjsGVtQM6X0MUMlCMFOCa5spqmEESWGMK/204n+DTL7O/Cx4o3mffZKtAj/gX14vfJMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDvpEc6wzyyaL9ZedOVS/eo5AuSRjYUlKUD2Ng4Fjfg=;
 b=nOi2wl/7nzVeD3WnWPuj1nBivZb1JJiqyHliSPw4aZr0sOj4cz/u+9Gjv19E2fTw4z3+IZapNsqtMb4nubwhit/D61XMKXSvFAtRqL+9OLOvN6CqEQORRU85d+ozhbWPWOBuLBwrXXLOp6SOmNNZQ7JfiauiYWTKaQDR66y3U9mhw93bXuuOaG228/H0yIiSkDOsNkl7RJAIOA/RPuAlC03ZuFP7ZyOnB4sGwiZa8QnRCIyW1xshnubxpluQUGetqgc1XWHJaUUfehv6CgrB4W1+RzS2gRdIVtrKAlRrrdfbmThJvNWmmmaa7sen2Rs/IVRUWP5l9rEpwv5p5JZ1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDvpEc6wzyyaL9ZedOVS/eo5AuSRjYUlKUD2Ng4Fjfg=;
 b=AV3Mml2bKZMGIWyl0NGg1Wtw9a3qO4XQYdxeJe6EM7axSMtu1G+nQpVxzOWQCJqqyjn6T32pGGeevqtxQJ7B+NL7eRLsmvceOGdFnal0PIKlbiT2psHhrQzJB8WhcY7CB5AD2zOxc708yLdEVTCvzUlXW0n4kAFDwkl+6xPUeVwvA6MJNdxFlYxKJgpwzEXzGSNDFfc+NHAm4y/8XdSEbWjJuoCNcC3cXzdssn39MoCsn6Y1sYKFTDMX3d4ri5MwlqBCb+ozYJAH/JpKgj9wvoMA5wkvK6UfjPqQrMyQrASglhx1Fmoyy4DWmaXL2P+xqK7P9Y7tCe1Bat9EGj9GQw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 02:05:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 02:05:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de"
	<hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alistair
 Francis <alistair.francis@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Thread-Topic: [PATCH 3/3] nvme: Allow reauth from sysfs
Thread-Index: AQHcSVCCMmRH7tj5UEabgx2Ww4HvrbTcTECAgAPot4CAAAUugA==
Date: Mon, 3 Nov 2025 02:05:55 +0000
Message-ID: <b684812e-8ade-4adc-aa08-2e4fcc9811d7@nvidia.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com>
 <20251031140541.GB17006@lst.de>
 <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
In-Reply-To: <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6419:EE_
x-ms-office365-filtering-correlation-id: 6a484bd4-95c7-42a1-8aaa-08de1a7d85f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Ym55a1BFQ1l1d1ZEWXJVSTFMK1JZQnFveVNCVTlwMWVUQnJ5dElUWU5EYXBh?=
 =?utf-8?B?OGlPNmg0U0FBOVZ0NDBTN3Jwb0JMWWRKLytVd0hHUkFMV2NiR0JuL1hmd21a?=
 =?utf-8?B?bDNjSXEzcWp6V0NVaGxpYVY2c3gza0ZRNWQvbW1SeUl5bXB6V0pRV0FmbW1x?=
 =?utf-8?B?U3hEWUN6U1hJVU1QUU5McXN2SHgvME9Ed2JqMjA2Wk9EZGtzbUNNSmNjcXdT?=
 =?utf-8?B?bE1yczFFWElXWXJaZmJUU3p6Q28wZW9HNWlhOVBscEs2Y1QrOG5jNUNNTmV3?=
 =?utf-8?B?ZFgwa05KQU02M1Y3NlduZEFTS2J6LzlsRGh5WVVvNjRaZVNzTWxGU0ZWamkr?=
 =?utf-8?B?QXF0V3l0RGJFWGFJSDlUK0kxWmdBVWVkaUFxM3dxVDRRcGpWeW5HMjNhdlds?=
 =?utf-8?B?QzFON0laM2JyYVlJQmZERVJVS3YzU0JTbnNlSTVjWjFncnh3KzAvN3hlSWp6?=
 =?utf-8?B?a2JZUG9PNWFyamhnT1MyNzNhWW53TEhtVmc1UnE2RUR2UjZ4eEI2WHZ0UmRJ?=
 =?utf-8?B?SC9iU2hIcSs1bWxLU0U1bnlPOUtrOGs5RDh2cTRLSXlMdG1xSzV1Q2diTk42?=
 =?utf-8?B?QjYyMUQzV1JZMjhKdFBWN0ZJTlNNV2R6ay9kOHhOYXBjN3FuRnBDNHdGazFE?=
 =?utf-8?B?Rm5reUNuODBYWTFhZXdOemc5Qkx1ZTVpUk54YWpVNzdEM3cvRkhuOG1BYTNy?=
 =?utf-8?B?WVhGU01jV0VjT3d3ZXM2QUk0cEQxeGlNeFpGRStkTEY3N2Zlck5FZFZ3YWpI?=
 =?utf-8?B?WFg4dURScGlUZ2tjWWRTNXUwcHB2bzlJTmZ6bXRmdm1tQUVBSHR1d2d0cnFo?=
 =?utf-8?B?RDRyc0hpNmhBUFVVcS9GOXUzMHJFSmgzWUxGaHFaNFYzaFV5WjluS0h4WVM5?=
 =?utf-8?B?cnBCYkhNUWczNkwzUi83WU8yTW9RbERqbFNGdW8xcTNwQXNoS0pkSWlGdFFR?=
 =?utf-8?B?S255SmtkRi9HRHAvc25FMG5uUVRzUExmb052ZUpjdzFObzgvNnY5cVFab3pY?=
 =?utf-8?B?UkZLNUcvdGR1UlIxdHZNZW5RT2hWekxhbEd6MTRrYkZNRjliVGdjaHZhU05s?=
 =?utf-8?B?cDBDL1NsOHFSUjZRdWRJRExXZnpZdWtVanU2eXNHQkRkV3ZUQ0tvME9KNmt3?=
 =?utf-8?B?SjdnRHoyZ0FUd0dxOTJLTnMwZGVpZDFSL3FrWk1tOGVMeUdseGpNSVlLa3c2?=
 =?utf-8?B?cFpNMTRZaXFkYmx2KzdHRGppOW5nUUtMWmFrMzM5bE9pNldLWTdJdzF3WEdH?=
 =?utf-8?B?bWxzd3BPbnVoQTNwRkI2MTVpNi8wOFo2M2JYK2NjMGVIa2I5VVN3ejNzMXRj?=
 =?utf-8?B?SnpOWTYzZXBkei9TTnJsTjFBcmRjeGhWTXNEK1FudEtCTTN6T01OUXdKbCtE?=
 =?utf-8?B?eVdTc0trTWF1djdnajlnN0JrZ1NYMC9GSitOMWJpM1ViR1o0djBFWHpZaUtB?=
 =?utf-8?B?MU9sdkJlV2wzYUpSU2hpUElIL1FVUVd4U2tEblZ2MzRUdnhCMWFTZnNyOGFS?=
 =?utf-8?B?c21Za25aaTRqWFV0YWhXV0lTNFZQUVBDNUJEUE1haEFtYXh4Yk9VTmYzNDI5?=
 =?utf-8?B?QzB6WjNQNUduT2Jsb1RKWi9NU29QbzZXK0NKby9DbEZmNjR2dWszMUw2dEdO?=
 =?utf-8?B?cHlzUlQrTld1OElIYWVhRWc3cVBHQTdZSGM5RVM2YnlFaGZ5blRzdTVIME1z?=
 =?utf-8?B?dVdhRTVZbmJ3dmQ5d3hPN3JtUERITTZrUmNEdmJ1RjJidlk5Yk81Qkkyb2Iw?=
 =?utf-8?B?V1FrL0YvSzZueHNZYkdUdnpadjdvVkZDMlBZOFhRY1VIbklzWmNtS0NZZWdm?=
 =?utf-8?B?eFcrVmtQSWlJb2pzSGxCZnJCeElJZ0IycndTQ0NUbk9sS1pIVUdYL0FXYzFm?=
 =?utf-8?B?SC9JaHE4WEpBZUtOTWdocHpqN1FHQktTYUEvMm5EZExDdEhwQ3dYRVllQ3J3?=
 =?utf-8?B?Sm1VY2dCMVk3RE9ZK0crUGdFNCtWOEFKVFl6OENtRmJValprQUdWekx2TzJN?=
 =?utf-8?B?eHp0MGFQRzdOY1puN0diT1BDZTFFaE9ZWkMxYm5YeE9uK2RXdlJqV096K2tM?=
 =?utf-8?Q?vfZQFU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGExcDA4RTczME1RZStDRFFVVE9zTHVRTG5meEczb0hhWEhINWdCa05RVFBN?=
 =?utf-8?B?czVSWGUwSnFTeFIvaVExcyt0eWduWE1FY2RlVyt4SHBIa0lSRllVVWc1Tm85?=
 =?utf-8?B?RVdoSTAyem9Hck4vN203SmFuWVFobWNlbzdLYUhsV2MrcXhoZ0FPYTZlVWxI?=
 =?utf-8?B?NnJtNlExLzFHcDVKamJqeUlyZnZLbkxnNXdiaUtJTVZpRnRnakVsdWFacnY2?=
 =?utf-8?B?SjVkYTYrQ2JOZzVmN3RtRE53dkxzaUJaWHQ4VzlZd0MxelB1c1VaOHZ3V1BK?=
 =?utf-8?B?a1QvWFkram5nZHlhMG8xQlliOWp0VllUczB3SFF6Rk5rSmFRQXNGWnQ5Ull4?=
 =?utf-8?B?UFVQeWxQcTNkSzJoVkZrTThMelZGeVNBM2J3QituWmlMeVlMUTNNMkJjd3pv?=
 =?utf-8?B?b1lDYS8rNWhKcGlhQk5XQUZzeWtDbkVKUmN6cFYvVytIYXdZbG9ZNExFNUZO?=
 =?utf-8?B?V3Vxbk9nSnhQTzdXSHgzY2xIQ1pGT2JrNzRkYm5ETFZsNHVXZiswdnFzOHYv?=
 =?utf-8?B?NmNxSUdKRHA0VjY3L3hKVkxEWk42cnJEeHNQMGJCck5VaFIrVEp5TGF2YWpQ?=
 =?utf-8?B?cFlJQmJJNEhTMzFPVEhyYksyQ3crRkdjUGpnRkFWcm8xSzBRdWp1S3d5d2JS?=
 =?utf-8?B?Rkt1bVc0T0cvbW1mLzlqbXlNVUNKYzgyL1VQZHhGWW84MllqQWFHb29LMGlw?=
 =?utf-8?B?OE9RYWxERUFNZjFpTzdqS0tldjluT0tneGpsMTV6bWwrQ0I2M040emVpYm8r?=
 =?utf-8?B?b1k0bm00bHhvNzMyUEpScFR4SU05OFpmTlZzdk44R0FqRWZKN01zMTM0dDBx?=
 =?utf-8?B?aHFuOVptT2g4TzZGVjNLTG5ieCtUelhIQnhSbldaNC9QZkZzc0RHSGRiaUlH?=
 =?utf-8?B?VFVsN1k2eFFDVU9vTDVlUWpRSWE3Nk1OcU1IRXlUS1R0b3Nhb2RXd0pMYnlx?=
 =?utf-8?B?V3N2aWltQis3d1RrLzBEOW1QbnFPdWNIKzI1a2thYVdUS3Z1R1d1QkZNRjRC?=
 =?utf-8?B?eUI5VmVTTmNrUGJkMEsra1djdHNuZWFQUlQvcndHS2ZtNE1KMUJVUEx3VWxX?=
 =?utf-8?B?ZVpMQ2VGSGRkNitQSXBnSmxOTEFKOWZ6NHJ6enBhUEdTck9WNFFwNGFuK04y?=
 =?utf-8?B?UGhGRi9MZHp0ZGRQazFEak55VlJmWXNCRUdQSzdLdjBVQVRwaDVqRFhrcnZ3?=
 =?utf-8?B?S1FvbUFGd0hncVcwenVvSW9kME52djI1KzVGM2t1aWJJRTdNNTJ4cC9COGI3?=
 =?utf-8?B?SU5qdlJ0SW1vTmJtS1FwdERlL1g5SFZ2eE81U0VNR1A3enkzcTNwU1ZWUlRS?=
 =?utf-8?B?RTRPV2xHODdpc2MxVkRTcU95YngvbXRBK01ac1hMK0t2MWVuaTB3SnU0ejQ5?=
 =?utf-8?B?MG1yMm9NSHFMeGRIenBYSjNPM0lzYkJRUDYrZ0NEa2lieXNzMEE1akdMc0RW?=
 =?utf-8?B?Q2JRZk80aFYyNENQdWd3WGlETVVscFdDcmIraXIzZlpmaXBoOG5TSHc1c3dB?=
 =?utf-8?B?THFmaWhqSWIveEYxWmQ1VWlHZjI1QzQ2TWdaQUEyc1h3WGpZbWk0RlhXc1V3?=
 =?utf-8?B?am9xdU9TQ1dveGVYWlFyL1NRQkxjVm5PaEQxTDV6RmxIQ1dweXhVUXE1QlpY?=
 =?utf-8?B?QkZObFE2YmxIYmVrWERNalVJUjhCcnp2VVFwUitvenh4TmVwV0cvVkREK3lC?=
 =?utf-8?B?dkZjZmpxRkI4UzJFY1hrQTVONWdpWEc5b0tna3hDano1VldHTSs5QVFDM2Ja?=
 =?utf-8?B?VEZCYmsvK1Fmb3lhSHlnc3IwNmZGWjZ1Sy8wTWZjODdoYjIrWDJYa3F3TjJw?=
 =?utf-8?B?YWJkTW9IYmM2QXpNVHczUzhFTWZIWFp4Rlp0aUJOYUdvSlZ3U3BlcmJtU3VP?=
 =?utf-8?B?NDdNNi8yZjkzSCtBQ3N4c0h0a1FtdWtCTjZNa2xmaXhhZnBZazl3ZkM0cTBv?=
 =?utf-8?B?UlBRN253ankzSkRqdmVGYXc2M2Y0Y3k0WXd2YnByV3REYUpQaTRFSE5QVDd4?=
 =?utf-8?B?S3JHYTdtSHBiTklWMzduN0o4eTBNbkJQdTc4MFNuMHJwYXZwT2wvWGFRY3Nt?=
 =?utf-8?B?MThFK0grSEgzdWYyUkU1cWhuM2RITWtlMlp4ejRDK0w2TC9aMFZXdkZvaVJt?=
 =?utf-8?B?SWVzaWZjMmREMzdNRWVmVVVaZlMySVVMeUhLZVdoeTJVY0FoZFVrbGkvUE5B?=
 =?utf-8?Q?yqErvtq8vVaB9tPOXd1lZPYM1NOreIDXrwOvbHNnwzmV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A66201F5351CFF43817C60B893DAF060@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a484bd4-95c7-42a1-8aaa-08de1a7d85f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 02:05:55.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sx2oi+NUIsXIawRlUv32OvwNqpV7M9dI9cz+jDl7uBUP1O2phSM1S0RB1sEbuyDBnwSt8hx2Gju2ICPTfLjwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_180600_567997_4C92997B 
X-CRM114-Status: GOOD (  16.60  )
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

T24gMTEvMi8yNSA1OjQ3IFBNLCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBPbiBTYXQsIE5v
diAxLCAyMDI1IGF0IDEyOjA14oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4gd3Jv
dGU6DQo+PiBPbiBUaHUsIE9jdCAzMCwgMjAyNSBhdCAwMTo1MToxNFBNICsxMDAwLGFsaXN0YWly
MjNAZ21haWwuY29tIHdyb3RlOg0KPj4+IEZyb206IEFsaXN0YWlyIEZyYW5jaXM8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KPj4+DQo+Pj4gQWxsb3cgdXNlcnNwYWNlIHRvIHRyaWdnZXIgYSBy
ZWF1dGggKFJFUExBQ0VUTFNQU0spIGZyb20gc3lzZnMuDQo+Pj4gVGhpcyBjYW4gYmUgZG9uZSBi
eSB3cml0aW5nIHRoZSBxdWV1ZSBJRCB0byB0ZSBzeXNmcyBmaWxlLg0KPj4+DQo+Pj4gZWNobyAw
ID4gL3N5cy9kZXZpY2VzL3ZpcnR1YWwvbnZtZS1mYWJyaWNzL2N0bC9udm1lMC9yZXBsYWNlX3Bz
aw0KPj4+DQo+Pj4gTm90ZSB0aGF0IG9ubHkgUUlEIDAgKGFkbWluIHF1ZXVlKSBpcyBzdXBwb3J0
ZWQuDQo+PiBXaHkgcGFzcyB0aGUgcXVldWUgSUQgdGhlbiBpbnN0ZWFkIG9mIGEgYm9vbGVhbiB2
YWx1ZT8NCj4gSSBsaWtlZCB0aGUgZXhwbGljaXRuZXNzIG9mIHBhc3NpbmcgYSBxdWV1ZSBJRCBp
bnN0ZWFkIG9mIGEgYm9vbCBhbmQNCj4gaXQgYWxsb3dzIHN1cHBvcnRpbmcgbW9yZSBxdWV1ZXMg
aW4gdGhlIGZ1dHVyZSBpZiB0aGF0IGNoYW5nZXMgaW4gdGhlDQo+IHNwZWMuDQo+DQo+IEkgY2Fu
IGNoYW5nZSBpdCB0byBhIGJvb2wgaW5zdGVhZCBpZiB0aGF0J3MgcHJlZmVycmVkPw0KPg0KPiBB
bGlzdGFpcg0KDQpkbyB5b3UgaGF2ZSBhbnkgcGxhbnMgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBJ
L08gcXVldWVzIGluIGZ1dHVyZSA/DQpPUg0KaGF2ZSBhIHN0cm9uZyB1c2VjYXNlIGZvciBJL08g
cXVldWVzIHRvIHN1cHBvcnQgdGhpcyBmZWF0dXJlID8NCg0KLWNrDQoNCg==

