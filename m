Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B437D72373
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jan 2026 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RLOejmUdh0tB9DAIXFwdnW3trxRA2d1RmjSbolJcXOc=; b=Pxg6oPMimc3gW6lCgPzTfc/06L
	bSzI878JfqS+l66OnVkqL6H6gbv7EbjOit2jWvWwSFmLp56JTgnhxCMG0kVD37TH5/Iuv8ICrW3PI
	NDktp32u1aOQoJbyEyukGNluykJUp1DPg8x1DYGfYZMcfondgunM400JpclzNq6g2WWTXICBqZn4o
	Xupr5zwiIeJ+/TN2LL2RA3IsTH208+tsuLjh2dHZ43HqvY4g+kXB1SHqTJoQkzhFxuvQpeOHvhRMy
	B7hroXYfBdLoPAArCEQTB4tJxa8A6SShsMhqLZOSvzQMUz+jlhHKB1fdRTbJvYnCGMtY76HGU5O6j
	GLsnmwBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjEpK-00000008lB1-28Qe;
	Fri, 23 Jan 2026 10:55:42 +0000
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjEpI-00000008lAW-1fwG
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jan 2026 10:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz6O4DGNxdJsAeVIBV+dXpm6mCDKlws9jtzr4uaIPiHNzwT5agEZ8j2/pDeLqmYvY5znJiZ9DJcElL7ilrxYPC9tglqJpyFYxEFPH8BDhwliAHYa6wRYSgimqacwCSo1WDxW+FxhY4P5WfaWc2f3e0mrEScZDQrclfVbUUOPwSCnMR6ErVidCPSNAR7iOCChAPgZK15+YJSUCcARVM5959nfeXMYFEiFx14mFFNfGB/PKmtpedxiLPNlT1ICMbpeqDn4BM8IxY1U12Vt1vSls9J3wG+6IVHmx8RJOdtJ5+shq5WlggQVpOO1C0v7OXZmrcsol96k62LJQuxnOf51Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLOejmUdh0tB9DAIXFwdnW3trxRA2d1RmjSbolJcXOc=;
 b=NwDuYcmnk/a0lCHFikttJx1ENwZmkDjg1qke1SNKCcNLwCsLgluuxMCGfCHFuQ5rBHoKIctsmasnFUPs/qGiSLG/79tbkN17D0JW7i5X4fqZLSiOHwiNfjMCGZHUN6YgEgUmxONwYYshlhZFu0+Q0svo7u7knA0w5oyR5l40k9iA77joVd9T3lfQqkCHYskOb6oqmJg5SDDnIS+CA96rvOX51oOHZ4sgXVZkiExKAliwozOs0rv8G62tMlQ7RzLJ2DC59y6nx4kSWFV4S0ukScGuInbH/7MVUjTjoIxMgxuuKN+9G1lmQJsf1UtuRSEC4oSHW61YnQ6/oUC+oQWHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLOejmUdh0tB9DAIXFwdnW3trxRA2d1RmjSbolJcXOc=;
 b=ZUu2VHwGtB+a/PjXznWxq9vbYsi2O4E2dApjWTrKi1GfIqHet2IQVwD/JAZ2BPe9MK/xV14oIEM+5nnU4db/oya5qk93d001SCFTpF2Bss/gd+6t+RdUbJnFQmUhM/5DEC8N1uJgdWSlymW47fiHxoOsp+D8frnHTdKsQ6CdFn4srv6GiivOSM7x4S3/MiLlhfM6s36zUOLS2o7lkl23PQFrUtsCtNcorwPhq/zIzU/wXZFOvq9yFeTvZln50Bku1RCGKtU0Acbw/e2agZsvn41X3iKVCIUH8GLDhk0Q+ffurEPswBOSG3oEZ54VqcGR09kV1Tt+FTbhcI9r2qOJRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:55:33 +0000
Received: from LV5PR12MB9754.namprd12.prod.outlook.com
 ([fe80::9667:3c95:27d2:73da]) by LV5PR12MB9754.namprd12.prod.outlook.com
 ([fe80::9667:3c95:27d2:73da%7]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:55:33 +0000
Message-ID: <bf37b6a5-268d-4c07-a536-a826b3d5953b@nvidia.com>
Date: Fri, 23 Jan 2026 10:55:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
From: Jon Hunter <jonathanh@nvidia.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <7306256a-b380-489b-8248-b774e6d3d80e@nvidia.com>
 <20260122152903.GA1247682@bhelgaas>
 <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
 <e44c330b-778b-4fa1-b678-fa909cc05b03@nvidia.com>
Content-Language: en-US
In-Reply-To: <e44c330b-778b-4fa1-b678-fa909cc05b03@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0202.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::9) To LV5PR12MB9754.namprd12.prod.outlook.com
 (2603:10b6:408:305::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9754:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 2241408e-0d20-4042-a423-08de5a6dee47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODBXNjdvTXBEak9mMEllMmFzL3hDSDdVcWhBNUE2WW9uREpuRWxFQWE4a1BY?=
 =?utf-8?B?eVlJZURaaWNabzQxUlcrclIvUjZMTWtrdGVUMVU5Z29tSGQ1RHdLbHo5RnVE?=
 =?utf-8?B?OExWVmhsY29pWFRsZ1oyNmtIOW1aU2NndnFVTWRNKzlPd05VaXFLa2dpVXhI?=
 =?utf-8?B?Rnl5MTEvdFY0MkRkTElvTlMwTmtycHE0N3gzdlVhUVkrMnVOdi9uOVVRZUNZ?=
 =?utf-8?B?OTQ4MUlIc0ZxUUxrYlFFUXFVWXBhQlpVS0k1YkkyaVVTczBKTVZIWkNOMFhJ?=
 =?utf-8?B?T1dxYlRJeFBoTjcwRDdwTUNScXRUNVdZbnFDZTFWNmxod3NuUEZKN0FlVWlH?=
 =?utf-8?B?L0djV1d2UDJ6bWZrQ1lTck9oZzc5aDN4eEJLQmFFZ09CRDlOeUhaSmc5dTVE?=
 =?utf-8?B?L1lRcVBaS2NUYkduNUdpVkpvd0hrOVVEYUNJVGdwSm0veWsydDRQTVc3RE5k?=
 =?utf-8?B?NjJiakd4OVVtK1NpczExbG1ac0RUbnBMWFRpUzBueGNIWE1tRS8wdWJIcktl?=
 =?utf-8?B?RW1tenZMRmwxUVdERTdpZm9aTEUwSHFrbCtGMW14clJYaVk1SkhJQmZ6ZjhP?=
 =?utf-8?B?bjQ2Tjh4OGJWcGFzMFhOa0tRYmlRbjQva2lQS2xXL2xRV1J5ekZCaWNCWlla?=
 =?utf-8?B?MjBFT0VIR1lnaTBUajhJQUpvYk0yUGZWRWtlZVhucEpqSVJrcUFqUlJQZTEy?=
 =?utf-8?B?UHdvcWZBSnFmQ1VDTVNoWmt3YU5zWEh3OHBxaUVZR2FFZ1dOUzZaV20zOGh6?=
 =?utf-8?B?b3dQOEczcWt3Z0V4eittMGw2VkFmcnpNZ3FLSnBvZ1VReTBDcE9STFI2Y3Ey?=
 =?utf-8?B?M1RrQ2VqL2Z5ZDdBT21aSDltMGw1eGUxek14bUkrQ2Z1ZEhQYmRXOUZRMTVo?=
 =?utf-8?B?L2FwR3AyeUxOZjRFeFkrUHIrQmFackNMYVJSZSt4MFpUVXdGd0VKSTFGN0Np?=
 =?utf-8?B?WTJObDMvWDdrOFREL0hDZjFXNnFtN1lsV1BNQVA0UGxFVmg0NGQvOUJ5Sm54?=
 =?utf-8?B?YlM5bnkyeEtkZUM1d0RneFl4N0VzZC9wazZBY0xoSFRQSTczT01yRGpKUG9V?=
 =?utf-8?B?N0gvdWVzK3NOSjhiZDBCK0pkNStXenZLUy8vdmZUVkVFdGhHeW9iMUNqWDZi?=
 =?utf-8?B?ZU5GalRtT0Y1ejNtdEk2WW52Z3FJK2VvZldqWG1NU1BWVGdBb0UzWjk1MVBs?=
 =?utf-8?B?aUtVZThFS2NVaHhCbmFJTGdkZTVVaEZybnN0cTc3alNWRitGYmhsSEtrZWt5?=
 =?utf-8?B?ZkFUYUJPVzFkeC9yK2NHNG5IUGlOU00vb0NGcE55K1ZINTZWM00xV3RFSlU3?=
 =?utf-8?B?SnhTVDZXRUhzTHJSTUJzaVFBSnd4TDBLTzRmSDJiTjlRL0tCVUZIR2lTaDZq?=
 =?utf-8?B?NEZETmlLOFhGK1ROZGcvN3NHTWN2UkRXUlk5Qi9iYWZ1aXNRUFl6RTdFc3ZV?=
 =?utf-8?B?UDhaTTM0eVN2MWpaMHJEUUtHUXRLR3lvTExybE5wNG9hdWVmWHQzUkFkR0ZG?=
 =?utf-8?B?am4xUU5TRmdiV1lLdW43VTdpOEQzQlpVZjdUZ0Q3TGd4ZWJWODE0WUU1c3Vl?=
 =?utf-8?B?WFVBZ3pud0JKRVA2QWhyc2U1Q0dLM25UcmJ4M0lvbkNNaWRZZTlzelg4Q2Qw?=
 =?utf-8?B?b2haQkE0ZGR5a0I3YTQxNUt1VWEyNDRVckk3RVpTb3NEZU90Q05sLzVidlV4?=
 =?utf-8?B?UGxvL05adi9MUmRuZkVaWktNSmh0N0wyZ0dGZGVaRHJnYzhwYUFCaWVMTDNE?=
 =?utf-8?B?MGV0Y2ptbE15ak4yeWVMMEUzQktUSXRYSEIrNW9hTTIrQ3oyelEvVXVqUStv?=
 =?utf-8?B?dFA1OHloUSt3SHRrdXBiM0RQdE1ZR3BoM1hSZXZlWUtoQXNVUWFxdW9zcTYr?=
 =?utf-8?B?RDdIQnJ5ZytLazVLOXNtKzREY0dPbHZLaHIxSmUzaE81cTBMRUxpUkRhVXZG?=
 =?utf-8?B?bStwUjJLUmpuTGxySVlRWXljYVdISEZsVjBlT0U3UTVCM1NmOURySHpOU09w?=
 =?utf-8?B?L25WRDRrMldremFVS0JmRGFUMnloNmV1b3crWisvbzBKcXB4c1Z4NjFyOEJN?=
 =?utf-8?B?V3dsQ3U2TFc1dFptSVdDazl4Q29qVjFONWJ6TmlWZWFsN0VnbGhkOUpqNC82?=
 =?utf-8?Q?epDY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hzQmJkekIzaHFNOU5WcXNqZTltamZlZHBZQjJGeUZHWlJUSHVzUTZyb1V3?=
 =?utf-8?B?Y3Vvb0F1dlorNkpwa0NFUjV6U2czcHV4YXgzT3FLZ0tOVmNhWEQ5bWl1cVFo?=
 =?utf-8?B?OHRvdkR0SzVmSi9WekxTdGhZV0dZV0tua3dVeE95R3VaRER3bE9WaE52ZUhB?=
 =?utf-8?B?Ung1alRHMVZnOHR6YnYvQThoaGxIZXpzNHJOa0VHK1l3NFQzTVprcnhXNC9y?=
 =?utf-8?B?VTY3YnE2SWpQdE5PWEhHejlBR3ovSWhLbTFhbXNMemtJY3ZTNi9aVUl1azNX?=
 =?utf-8?B?WU1OdEVxUXBWRE9DTm1jL0Z3MjBabHdIYWxkK24rbW9zeWsvc3RUdXQyRGRB?=
 =?utf-8?B?RjJzYUlOcUM2UXl3ZWptMVBISHJ1NTlFOWRTWU5sRHAvTXlrN0VETTRXS0hI?=
 =?utf-8?B?eE14S01sbjVmQlZ1S2tNaXBzUHNDNHRTbTJHOThxd1dydXpObzE4cU1PV1dM?=
 =?utf-8?B?c2ZpSTNzUk9HNFlRekRrYkd3b3IraTh4Z1NaM05GditkNmQzc1o3S2E4emlj?=
 =?utf-8?B?MWRSZUZSWFNaUWRIU3JBRUpUWFVHMFlJYmFpVnVoMkYvSGFnSXpqY1NCVHNj?=
 =?utf-8?B?RDdNb1lhQXNPdzJHcGdrQmxwUkpxOGl1RjNraVk4bWdacHRvTGYvZldtT2dW?=
 =?utf-8?B?N0dYVnpWWk1vNm5Ga2o5cnd2MHZWR2dHcXFIYmRGaDFMcXE3Q1h5RVM3akRZ?=
 =?utf-8?B?WlMxNjlBT1ZiMzFLZkxZVWJLWmdUSU5seWVIVDJzbVMzOXlVcWZ5RGRENG9F?=
 =?utf-8?B?MS9GOEppZEVyekNUWFJmTmNZNGpmOTdIN1NqZUtXWkhlaEp6Wk4xekQ0WWx5?=
 =?utf-8?B?aWtvVkViK3dwZDZmRVlLRWI0T1c5YzVaWk1GUy94SHFaSkRFVlVDeEQzL0ZD?=
 =?utf-8?B?YmFVVDA5UnVLNU1GYUxlU0MxTCtoQW9JVlZaeE05ZEFBeUM3R1NNb3ROUzV6?=
 =?utf-8?B?RlZTZUtGcGxlVmFnOTdpSVFhVkZ1cHFDUGFuOGYwOHBaejlhdG1KZi9maURi?=
 =?utf-8?B?WC9xdGQwWHkyWFdjTGdpbExTa0ZaRVNJQnYyajAwYjliMlhRZEZXVFphdHJ1?=
 =?utf-8?B?M0toM3pyWjFJaGozUG9WS3NhRVBHT3E1RFlwNENXS21XV3YvM2VpTTF4aGMy?=
 =?utf-8?B?emFvK3pwWnZOY09wUHVuYTk5WkhNbzJwL2V2ZWtWdTdhTTZiTFlYU3NPVWNq?=
 =?utf-8?B?RHlTY01IQ0tIdHJqNW9wcFQ1S0pKd21vTkREb2pUVHhWSmxkQ0cyd1VmclBG?=
 =?utf-8?B?TmFaVkpUTGtlYTRWNzBxaWIwVG9JU0JNWUxad0p2aUtMZ01TZWh0UFl2ZG96?=
 =?utf-8?B?NjhMSWp0aWV5Mi9ONWFTWkZidXUzZ09yYnorcHZ5S3VWY2NTQzlleUliV3li?=
 =?utf-8?B?OC9SNk93NmhTNmoyMzBPSkNMcGc0K2FQTWVQVkRaeElkVDY3NDAvdEhHdkRv?=
 =?utf-8?B?V1VWRzhudkw5K3NJVzI2RGJLOGxyMHV0dm5HWHNaaktLN2c2Wko0YWhkL1dY?=
 =?utf-8?B?WXhFaTQ0bitTZE4rTEw1OGVDeFVYNkxRUmI3YkFhYVF4cG5EUENRWEowSzhJ?=
 =?utf-8?B?amprOGlrVVpUaU5TRWIvL2dmclNBM1J3L0VmY2VpK2pjQ0pLZjFOa2JKSHlj?=
 =?utf-8?B?Z0kwNEZ0T3BZclBzUWVldnc0Uk1OZnptRGQwZFlmTXl5QnJUUDVEbkZoZlR2?=
 =?utf-8?B?a1VQVGp5STJKQ1poSFlxSTBCSFJoUzB3NXNsMDNCdkZFV2tzTWNmTlVFRTZi?=
 =?utf-8?B?NVRSUUd0QzIwUEhIbUZHajVtaFRhVlBvcVBxTjZzdkg5TFZ3LzNPeE9NRlpk?=
 =?utf-8?B?VnRIOFhBL3FsazlyWjB1N1BpTDh3TThlYlZ4Z1BhbUs1ZFROMWdDdEFtbVN2?=
 =?utf-8?B?Q0RwYlUwV0w0SU83K0cyNjJsTWVXaGpyU294dDd6Wm5KdEY5b3pwNURvdmxl?=
 =?utf-8?B?VWFLMUxqQjFrWXpGSGNBZGxJVDVsZGtXaUNRK2pMQ1VSaEdKMHFmV3pjN1Rq?=
 =?utf-8?B?cTc4VEFuamxZVExNS3U0eWVUOEx6RFhzYU9UNnZBVUlnYnpVUGQ4TzZCUURz?=
 =?utf-8?B?SU40SUcyR3RTZ0g4QkFNQWFaMWQzVXNPSHhkVXNBUUJvU0NZRlNkZXVKa05n?=
 =?utf-8?B?cVVVNzIweFRYTmJlNFZuTXBrbTlsZUpoamFiT1pJZjV4aTJzWFlaZ2tTMWxW?=
 =?utf-8?B?clJZYnQzWXRaaFRab2lKZ0k4YUxObmFTbWhpNnQzTkRTSGlMREV3bnptS0NE?=
 =?utf-8?B?dSsrREM0TkhRWTQzOUtwMllLTU4zemNNMkZCQmFSOENmNzVJeUJmNjA1d3Zj?=
 =?utf-8?B?NnRKenBrVUVuQllGZVBRejdKQm9GOFdqT1UyaDlIMWlYTXJXTUh2R3RXaVlo?=
 =?utf-8?Q?0sLbqgS+3/9SIBopaXCWSJwYf2rU4crw1mz5ec/Wh37dT?=
X-MS-Exchange-AntiSpam-MessageData-1: 0lv48YQI6HwMqQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2241408e-0d20-4042-a423-08de5a6dee47
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:55:32.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeCOJhJn1kfvZqIBu6NHQy/TYorF/8sDEjzz9KvXpLL8pcdeO3Gy6WqnIfrsBBXofqTgmtxoGvPsl2u5cumScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_025540_438849_17262B8F 
X-CRM114-Status: GOOD (  20.55  )
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


On 22/01/2026 19:14, Jon Hunter wrote:

...

>> I think what is going on here is that since before commits 
>> f3ac2ff14834 and
>> df5192d9bb0e, !pcie_aspm_enabled() check was passing as ASPM was not 
>> enabled for
>> the device (and upstream port) and after those commits, this check is not
>> passing and the NVMe driver is not shutting down the controller and 
>> expects the
>> link to be in L0/L1ss. But the Tegra controller driver initiates L2/L3
>> transition, and also turns off the device. So all the NVMe context is 
>> lost
>> during suspend and while resuming, the NVMe driver got confused due to 
>> lost
>> context.
>>
>> Jon, could you please try the below hack and see if it fixes the issue?
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 0e4caeab739c..4b8d261117f5 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3723,7 +3723,7 @@ static int nvme_suspend(struct device *dev)
>>           * state (which may not be possible if the link is up).
>>           */
>>          if (pm_suspend_via_firmware() || !ctrl->npss ||
>> -           !pcie_aspm_enabled(pdev) ||
>> +           pcie_aspm_enabled(pdev) ||
>>              (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
>>                  return nvme_disable_prepare_reset(ndev, true);
>> This will confirm whether the issue is due to Tegra controller driver 
>> breaking
>> the NVMe driver assumption or not.
> 
> Yes that appears to be working! I will test some more boards to confirm.

So yes with the above all boards appear to be working fine.

How is this usually coordinated between the NVMe driver and Host 
controller driver? It is not clear to me exactly where the problem is 
and if the NVMe is not shutting down, then what should be preventing the 
Host controller from shutting down.

Thanks
Jon

-- 
nvpublic


