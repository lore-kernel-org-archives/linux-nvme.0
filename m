Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB6CAC5A7
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lcRJL/RiTmyTGMlV2kzpcsGJ2XZANhKurUaCrqNJCLk=; b=b/KsaLBVWExEMUzCEywwnz5hNY
	LKgKinR5ZyNXZuTHsR9Exs4qXNqU6R0Lkn2LRDusjgx+WUkoc/i71grz776yanfe8bpZ3U6pAFxFx
	BW5YK0B7bsne1cxDcBWnqLBTRdDsxruAojG57cAt58/hC0FHI8Rh4adM1T/dQ/kaJmhKFFU13nY6H
	N78iOFAK77xqVNfVYSZMy4vrcdt67mCCPwnIE94rc1Tom0f9P0LXb2VU1+zi+yPkA7SRkPCcvCcxU
	/Dw1eUjI+BRnfy7333NZnyjF2UEja6oyca7HUrSiqgAAJx0i0PgXBIul3VUuJr76jQX48DSDSgmC+
	5dNcfUbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1kkR-00000008ns7-32xv;
	Thu, 25 Sep 2025 12:06:55 +0000
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1kkP-00000008nqX-2i4S
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 12:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOonxDakc9e+qQQvjPuSKenZtWAoLyC/Vh4wMoRIvP5yk+9t7fIfmIggs3KDIzN49XX5Ox+MkWTMciGLMmTvdrYl5/8OZ8SuZq3SRmw+oemk6JNySI8Rzksl38KvgZcfq+hdnjDG3k+SyCfnaFpICmnd8QEMUuEAtpKiRf+Kdl1juspDDvwGEIw4ARWQkwq+LZCYrlBOFjF6gGxKiOv5sWa9wKAN71PN6ZT+yr7u5lrvxSvcmbg3rKKktGiLlIgj3gLBM6TqA7UCCVI6JlInvupQSBFm0bRzXes5zMwCfY6MZlTgaGz5701OhMIRgCYmFduPuJwEUQ+E353ZIGIKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcRJL/RiTmyTGMlV2kzpcsGJ2XZANhKurUaCrqNJCLk=;
 b=r9jjfm+ZiZYTjPRCWW7J39ttOb00pzCDvbhGp3GglcQCbuiMmcAj39dOMWUBaaHsTIa4NVmr0LGTHHC0SOcLKF8Up+FDcoPi3A9scLat06DlYp+lna09IUTCPhEZbuIrPSPj5PTLckxpQXmGGNqB1n3sYne0GWWMW8JwIQ6w/HqvTFyrnD+k04HTC98Hi4XnMuGEmH0fFQgLA3EMW+kum0HIRICUWGOM+CMlwU52RzTIMepb7QroBh0uozpklOMXlqP8gfKhtX6KR6Fk0De6n/MCJaIyHurTheDlJmBoXj+nwaBPrE/vHYrxzS+/8Ao/ePtUajcyXQKwIaC7ZqXrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcRJL/RiTmyTGMlV2kzpcsGJ2XZANhKurUaCrqNJCLk=;
 b=mGRSVBm3NqjRaS431SR3jxi5CyB6xyPjDFLk4fiNrt4QjpishYbhz2opeEwzBV1ahObGGq7nt6RCQyFmG+/JX2JBy7TXCD5fS9KMYBfd02IrdeHSV9qjUdPdXqRUitAr0D5hfm4Qe12iSQq2gNbF0jCMEOzn0y6rMfrPYko5NCZ8JZpHI1X8JrUiNSMbIbmTsZ03S5npN2oGmfDgLcL19b1Zkc1k6SVDRlenYBZcFPY5wk8ND29TVJmJ8K8c4MPi6zyeqsrr6XXumocm9n15Xu6nDrTFsWs8qLzfmRr5g25nERL7mXczBPg5J5hbSkHRgb9n/SHHa1KldPVQFe8gBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 12:06:47 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:06:47 +0000
Message-ID: <8f8d7c9a-02f5-47c0-8f8c-9aae6b969c73@nvidia.com>
Date: Thu, 25 Sep 2025 15:06:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
To: Daniel Wagner <dwagner@suse.de>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
 <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
 <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b51768d-cbd4-42bf-d955-08ddfc2c0074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWRTbDVZV25hQ0FLLzNBdlhJV2tQZDF5a1JYU0srcExDNFh1MXJPS2Z2N0ZW?=
 =?utf-8?B?dmdXUFZoRngyMDNEZDhYMnZ6QlZaQ3o1WWx3b1lvU3hBcFJSN3dvam55TEV3?=
 =?utf-8?B?NFBRQVRQSXpKcmt4d1J4TkpsMHlPdkJWUEFZa0VZTW9kQWZkWU05dU44bVpM?=
 =?utf-8?B?Y1RPNlN1bWpBK0pyRkJqam1wVjROMHV5ZG9ZZUhHSENLMjlOU0NkdkFYTDhW?=
 =?utf-8?B?Ti9uT09nZmg4L1ZlNEVMYkFrdnVqMXNxNkJoN01DTEVZNEtaaHlqcmVIeWU1?=
 =?utf-8?B?OUpzZFFhMSsvUUdLV1RRNllVMmxyU285cW9NZ1M3aDllZWJHbmpFNFdFYVNk?=
 =?utf-8?B?cWxZYmcyMlpsU2lvbHZqTlgybDg0aUFZdnY0OXFJbW1lTFl1Y1l0RTVHb3Vm?=
 =?utf-8?B?eU9qTXlSV0lYSCtSSHFYZit1M01jNzFCU1BMMHdTYVR2cG1vUnVtWTBiY3ZM?=
 =?utf-8?B?dTVzLzdVb3hLNlhyNVRNaHdlNU5GNDhOeFdKYWg3bUV2cks4ZXplRlpVRlA1?=
 =?utf-8?B?bkpNSllMK3IyOC9yK0EvbXo0Vkc3SzJuaTFpSWNQVlo2L3FlYnM5cWtOeVh5?=
 =?utf-8?B?dUxCbW96R1ZJV2s4aWxuVXJsbm1SVEJveVF3ZXd4NTd5K0tjVnJSR2o3cWNM?=
 =?utf-8?B?SGl3MnJPZW9nSUZabFR4bFVxUm5XcUd2bXhqNjc3TmhkYmNTSUt2OUlacmtu?=
 =?utf-8?B?bjBWeHhvSk5UNXJzRFROZGQ5TWxLWUE5MmpNZ21PNi92MDlsaFJDZUtWeFAv?=
 =?utf-8?B?Z090cFF0QXlKcnFkb0tnRGVuR3I0Y0Ewdzh0L2pGWkpTRGxqemNUTmhKMEFN?=
 =?utf-8?B?TDlqSHZBNmcxU0EvR0pvenZGTjY5dlo0Wkt3eCtqdjU3UWtPZi9JT2pWYWZP?=
 =?utf-8?B?amFuZGlPcVdPV2dyUFFFaFdMSktjMkZaT3FrRlA4YVZaWHMzdjVFeTBhUzc3?=
 =?utf-8?B?K0lTMjBXeHJybTRmQ1RlK2hlSzNRU1NtRy9nbkFCbHF6ZEk3ZHN1OTQ0eS9x?=
 =?utf-8?B?M0dxWGY1Z0E1d2NYZTBCTXlvQ0IxdUN5ZVh5RGgxRy9LcTIyblJkTUtOR21Z?=
 =?utf-8?B?MjZqTGdoaHJaYXFSYjRwdElMa1FHMXBFTmVGb2JhalI3VE1CV08xSHlqY2lF?=
 =?utf-8?B?RW5XVUZFc3VDUTZsbzZQZlgzMWk5RzlQWlVRV1Z1cGIwVnloamoyUUFDU3p2?=
 =?utf-8?B?MHBOVURNNU1EWDNxNEkyTjRPYjNpdE5CRkVTTE9oODhCaFRJckIzRldPQ1ow?=
 =?utf-8?B?ZTJrbG9ELzY3UUhxVS8wVTVFb2dhcWducmZ3VERpRlpjTGVFNGg4c3pzbFNj?=
 =?utf-8?B?MWlDQkZUbFBEbXdlTFpNWUxkVkFLL1JCSjBLK3FoTURZRHN3c1BxR0o0VnFa?=
 =?utf-8?B?SEFhMjZ4TFdUTSs4WHQ3eGhSSkNyUWUvZEtVenUydjNpMUtIRVU0QUowSWZR?=
 =?utf-8?B?YkF4YTJQWUlVU0ZtaFBWVjltYnpJbkdyVWpTZGxrWnRSZERrZ21nVEtGSFUx?=
 =?utf-8?B?dHhSWEdyK2g2ZG1mQUZlV2J4bWpSWTd3bjZYeVo3U3B1ZitJdlp0elQzSWl3?=
 =?utf-8?B?b2krMlRPRytCMW9sYm1EVkRsdlhxOVN2c3ZGeEw2NVNRTm8xaC9wQU8vUG1a?=
 =?utf-8?B?SE5IU1dkK1doaDk5VWcxUnVwY0NOSXk5aDJFSTViMjJCMTg5ZDMva2FxSVJS?=
 =?utf-8?B?cXBTWElvWVVEUys0U2hIVjZrWmpZVXhTcy9XdDIzaTVaNXF0bkcrSjZnRnV5?=
 =?utf-8?B?UmJxSCtHQmdiWGlWaEZqVXBPYmR2YUFoZlJnOEJ6NkRGZ0JzM3VNd1hrUkR4?=
 =?utf-8?B?U0F3YnhvM2dKQXNXSVVKTy9xT1NWdGkvemU1a1dqUkUyMU9JUTNTVWNBbGgv?=
 =?utf-8?B?V1ZFbHdydXFWb2l6RzFQTjR3VXRYNk1TeHhtR3E1dmhHbEhzcXc1OXREZFNB?=
 =?utf-8?Q?C7PzoPwAf/g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmIrQU5RUkMvQTNGYWhhVzNzMzlxcVNBVXNadHMwVTdWbmcrY3pzZk9ubkky?=
 =?utf-8?B?Vk16azhoQkkvTzk2YnVROU0zS3kwanptQjNQeXpWbVpyK29PTDM3dGhkUzB5?=
 =?utf-8?B?OUtySG5IQVl1NmVGc08zV1pIbTBkT0taTjBkM2FnSHlYMW9OMGpQL21CWFBK?=
 =?utf-8?B?QmdJK2ZmTkJUWHNaZWxrTjJ6YkFjUldBOHpWdm1LUlNIMWRNc3htcmxsMzl4?=
 =?utf-8?B?MzllZVFhSWFoZW1pNXJ3VzBDdWd4OG5Vd1VMZHBwRUYzdXFlWCsyZDY0eFd3?=
 =?utf-8?B?REJXcXpmUVV3eEV0Z2J6UEZVL3BEQW9oR2E2OTdLOE9BMzgzclBIbTc5VjAr?=
 =?utf-8?B?TmcwdnhNN1ZHeUF4dEcvZ1A1Q1g4L3I1ZitmME16dTNyU0ZYU0RYZklKeDFP?=
 =?utf-8?B?SUNNa1hFM0RmNnBOUlcrRDBIbzlQNHI5K1lWdUZPTllCbFhMb1czSWhxUXhT?=
 =?utf-8?B?RVdZUjFKbC9HNUtZN1oySzFyZkVnSUsrYllsMXdjNjRmaXlnN25Kc2M5K3hO?=
 =?utf-8?B?UVdXWkdwZ2VYV1JjUWNkMm1HcWYxcmw0SU1BK1ZZRmdKYUlmcXhkZlFmY2s0?=
 =?utf-8?B?S2k4TmlXWkxBYUM1bTFqbGd1bURWUU84NVl2WkJXeEpIOWR5ZEg0OWJwTVJs?=
 =?utf-8?B?dnQrYmZIb21GQ0xVTWRkNWFtN3hRZnpHU0VQNExGU2RtTE5qZjFWZjB5VUQ3?=
 =?utf-8?B?UzNNa0RWeEVNVm9TVHN4cHc1cFJnOGxHV1c5ZmFtZjhPUWtZVi94Tjh6Tm12?=
 =?utf-8?B?OUlpZUl2YUwrbDd2bWlnN3RjR3pzdzNRMGdyN0JyWHZMbWFucnIzaFRNTzhv?=
 =?utf-8?B?emhMWG16Wk5TaEcvVHRsODJlS2dOSndvM2lFSzIvc3QzU0EyK2lhaUdLVnl3?=
 =?utf-8?B?NHQ3eFljbVRSa2FDeWFLQk85bm5NQkY2Mkppd0paTXFiR3JCZ25JNkYxaXdX?=
 =?utf-8?B?WUpqUlJKUTcxaDI4Y25INkNqTHdKR3VPZktJTkt4U3o0Sm1lMjJiSGVQTGxT?=
 =?utf-8?B?MnlKYW5wNjlEWXJqb0xYOUEwRGRYeW13Y3Via1IyNm9xajlBSmFWNjRYWTlD?=
 =?utf-8?B?VjVIQmV6WXB4dW9yNzdBcFJza0g4NW9iUFh6V2R0STlVSnFCUnNjWFBJZ2lC?=
 =?utf-8?B?eUpVRTFyL3RrWkFORkNDSkZiN3FvWTkyUjVVYmJVK29pYjVKNzYzNGJKcWdu?=
 =?utf-8?B?T1EvejlZaDNCSHJCWmZlQ2R4VlQ0M014Y1NQaWNFUTlpVjRGemtoRnVGVS84?=
 =?utf-8?B?NkdJcFVDK0pndTRZOSswTWlMMFJTeDlCZVZlZ0plOEExaXRYUWRmaUYyMnd2?=
 =?utf-8?B?Zm9xUEZnY3FiZmFYZUE3VGFCNW5odThFMjhmeXNFSHVjUm1qSytyNVBpbWZr?=
 =?utf-8?B?a0hidnVvZEFRWmdQamlEMGdGSmdhWE4ycFFlV2N5NXJzeTU2OUEvWE5URVox?=
 =?utf-8?B?WnRKQUVSK3IzMWs2WGZlVWliWmZmV1FQOGszZUl4bmtBRHZ0b2dYczRhWFJD?=
 =?utf-8?B?aWp5SHJ3SENld1BCQ2lYMld5eXZIbmNtT3JGVjdmV2dIcnRqT0o2RS9KaUls?=
 =?utf-8?B?MTdDREYvdXFONHJxTlhSWlZUQjR2TVJNK1ZIWjV0eUc5aVptbTZ0YkpIWDNV?=
 =?utf-8?B?ZTRjTm1XWlY4UEtOSEpZS1FCakJWcUdyMWlPRnVOSklRdU5rTUZuM1R1MDls?=
 =?utf-8?B?SkpzNmYxM1YyQ3BoTzdlWC95WUpGbGJLZ01vYkJSNFFmVjVZNDVud2JiUWwr?=
 =?utf-8?B?ZUNkZVVsMzQ5RWRMbldNVnF3WUJxejVHT3FjbFFyTTBGZUZja3d1QWZDVis2?=
 =?utf-8?B?QVdJNC9WSElzRDVJenYzcHV0Z3d6YmlRSmRXZDRxL0RNYmtSTjkxMndoK1Jo?=
 =?utf-8?B?Q1ZiNjNPd3Jmb283N3N3aFowLy9YUlRncUlQNldtck1jTkZaQVFza05kekRR?=
 =?utf-8?B?WFhuY0F5L3NpWktsbXAzZVJLNXRYeUZhbFpFY21TczlKdGhJYUhLT1Zqd1Zh?=
 =?utf-8?B?VUJpWC9haXZsNldTMzVKNHFmZUgxWjVGNkZIQkxUT0xSa1JyZGl4N0lUeWt4?=
 =?utf-8?B?VFFxaXdvd2lzSHB3YkdNR00xQlZLdTZnMXhleUVHcFI4ajdvWE9xQTNvK1dW?=
 =?utf-8?Q?c9XMPZzkIIli5xUY1ZzQWaTau?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b51768d-cbd4-42bf-d955-08ddfc2c0074
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:06:47.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex9YH0v+JIbwrXESL1yj8jrQ4eiJtMWv0SkNYNpZ47OhzZ8sOe5TAeltfWgFExrj64BqHE1/MxPFKs8dQEYo8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_050653_693418_2688FE94 
X-CRM114-Status: GOOD (  21.10  )
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


On 25/09/2025 14:32, Daniel Wagner wrote:
> On Thu, Sep 25, 2025 at 11:28:04AM +0300, Max Gurtovoy wrote:
>> The above mentioned commit 555f66d0f8a3 ("nvme-fc: update hardware queues
>> before using them") was added to Linux-v5.15.
>>
>> The qid_max support was added to Linux-v6.1 commit 3e980f5995e0 ("nvmet:
>> expose max queues to configfs").
>>
>> IMO the real objective of adding qid_max support is to make the subsystem
>> more configurable and not for testing reconnect attempts of the host, as was
>> mentioned in the commit message.
> The nvmet change took a bit longer to get added. My main objective when
> I wrote this ode was to test the reconnect attempt.
>
>> This re-connect scenario can be easily tested in a different manner, and the
>> target driver code is not there for testing the host driver unique
>> scenarios. At least it is not its main goal.
> As I said, I don't mind to change/adapt the test infrastructure, but not
> the test case. FWIW, it found more than the above bug over time.

Sure, test case can stay.

for example one can:

1. create a port/subsystem with max_qid = 20
2. connect from a host
3. destroy the subsystem/port (this will issue a 
reconnect/error_recovery flow from host)
4. create the same port/subsystem with max_qid = 10
5. reconnect attempt X will succeed and new host controller will have 10 
IO queues - tagset should be updated as it does today.

WDYT ?

>
>> I don't know how the driver will handle it but for sure this is a situation
>> we would like to avoid.
> No objection.
>
>> I guess we can try fixing this problem in other ways, but why should we
>> complicate the code so much ? let's try to avoid this scenario to happen and
>> simplify the code where we can...
> Sure. Maybe the failover tests should setup two controllers instead a
> single one. But not sure if this is supported at all from nvmet or
> blktests perspective.

