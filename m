Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0F2C678D4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:To:Subject:From:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=A0yGnPez8iWUrOqfV2wx3Y0xAJmD5vPR6FAk/mIOyfQ=; b=k3h+GimZOROLHt
	zVvEYPlY1+cV3bDOqsv3Qkk5d3jFgekMkQnlP2soo62I3NdkhpQWuEpMMBaNO0i/hdtzV3RtNGnr0
	KfYEIx6IgmPbmoIJh8Uu5Ly/nGYLX/hrSAx1t0pDUcTN/uUXOnAHmLm1WjgqR1j2w96PMGoHXKUNO
	7JwVo84tEovS0DD8+GEQ71gllf2CJlDvadWz2rPrcpeAi92OAvejt54Elef3Ibbz72fSNWUkVnF2M
	a7YC7iog2Fm3Gl/0FB9PzVlENj/8uLXoM2IRpAKJs3Gg969GVNFxDEplQRjtayBvri30hfLJlfBJT
	zkjSxdVsR3rG6JH8VJBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXWVx-000LQL-Uw; Thu, 02 Mar 2023 00:09:42 +0000
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com ([2a01:111:f400:fe5b::61b] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXWVu-000LPk-KM
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 00:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1VbrfHJyC/MF+UMBgye/36GPWsJ+6iA9aTzE/JuogepPzc/vvVGEriQO5/wT3pCgF4tXx/PucPQ3r8OG4A+mtfUPuNd1d9osPQK3zAxo2raSxzk9DXvEQ4cCxM/d0Zx8BrtDLWEHca2jBKi00FfWQUEtRweP6xwY1m43z1KdHRSB7UPNgQqO+XTshxJOQzzEsuu9bKaofpO1ZFrfA1EBlIleijlszEvgPDqB0sLlq7iGHq+BqiMYQmrksHJnSRz9aRVdZwRk/4NAvpIaUo8RYx09OXgCv1859778xt/NkiCnsyiwGPY5ZmCK1wv4TSj+SeG1yiIe6jYN8JuzhiVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0yGnPez8iWUrOqfV2wx3Y0xAJmD5vPR6FAk/mIOyfQ=;
 b=bZmydt8clCzCt/6JdyxFid3PuEGtJc4AvxQjf5TXIs7k1ShSVmGa26fu7pQlIoZZl9VQFzHcjk9SN4U+fAT+76z/qTFpTwWzze2ZoSVhffrTJaeG7XOukf17IjIu4S8q13tWemowCbcq3KZ10KS8KQU/ISZjENapMAm42ScheNoUHVGURgB/vit16w/I9pnANhnxRmXSxugwK83XiEdhrnQ64ezRok0+kg7X2mqMIj83XlF9cXGTITakryM8WK2EkIUL1+ENgN9VYUGnoBWkzsH0E7HaXPgM1OAmF/14yhG0qaTmX8rKIvY0VIZtkHBh0qSekqCYvzL+oXi94X8UKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0yGnPez8iWUrOqfV2wx3Y0xAJmD5vPR6FAk/mIOyfQ=;
 b=B05KcKuz88uLXQZIXAVaIgl47hdmMn0b7Xg9sgGCj0WH0ooLoYhxSLltWhZf3vHxByhJtXW3hWyNnqeLQC1SXUklvgAT3jFxMdT2/ybAMPRnnOhtiClNnuQiEApXo6yX6PY229jFhw1ep2Ri3UWWsgVhiuXMEesrLCzgga9c03lfUm/2FHjaa98CCfJIfKdZ7/vsuI5Azf01qWa0RuZBs5XJ1ULrEI2RjkhhJRjgHRUKGOuIi1+v2/dFIKwKRtEqp4qnPGCXDu7WvIcrn/QFuulCzvmf3BKd3rqbhfZhDi8GVibpmbigcHmDt2+FUfWhvcC5GFhnmK1wefTRgIlVxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 00:09:30 +0000
Received: from BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d]) by BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d%5]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 00:09:30 +0000
Message-ID: <de1b20e5-ded1-0aae-2221-f5d470d91015@nvidia.com>
Date: Wed, 1 Mar 2023 16:09:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
Subject: nvme-pci: Disabling device after reset failure: -5 occurs while AER
 recovery
To: linux-nvme@lists.infradead.org, kbusch@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To BYAPR12MB3189.namprd12.prod.outlook.com
 (2603:10b6:a03:134::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: d1587a51-2712-41b3-8659-08db1ab26497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ZdW92gDBnyiACirgnS5D4Mxaw9tj0miRu4pSYDUc0a+Lgr3Sq74r4FGmaBOadqxoY0UI+n0OxvM09V0CxvtwOhLplwt99FJ2fV9VJjvKTW97hLWN/CNSKBx1DdcDSb/szRrXy6qAYFpKIw6IgSESLzssTTdaLM5SFmE7rXPeLzTKRMnMs+wpu3gW544h0dO4ycxEAGKm4hXdjNf/gOIqiKal+O4iNDnQ9lGDj/oteUo2u4OqSo3nCk5VRSy5BKr6WOAIg0TPZIQ3KrBIUsvPK5jUC+D5ekJGljYKW9uBwkdSmeuGMGEVQMzkREbRWx95Z1mdwArWGmoq9unmBoieQSMrZbfx4zxwreK4lkr1nWQ9zTBCLurVrEwi/7ZGOeD3VEm16pUjK/nRxp2xy2E3rGHa9M+CWwQy5bLuzT/9VcQv2/krogMVe1GtS6bAgqWB9rVjsPyjPihzJg0TSYBECPrJhk/wSzcdFlmAIUbWU5nfd6j6ixCKFwbAuI++EcjLBs5cZXTzu9oOB8WzAVK6W50w132G+4J6aHeUdUAwV9OYcoK1ywSlP9gIR/ak1QumqDeQ0S/ZcZFxkeiU3g4wFJbdGZ3uoSOMlK3xwKF4gNTzy1YY6DvR3lmUMLD7yIi8TOxNJCLSvXdhD9m5A0lHhZDSZQV6hMJzteuf5vxmvY8E5p993/n0b40nwwClMsTtt/yUT8aXhqGPhd640RAOm43itPrYp0Or/6qu8F7yKn4=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199018)(31686004)(83380400001)(36756003)(38100700002)(5660300002)(8936002)(478600001)(86362001)(31696002)(66556008)(186003)(2616005)(26005)(6512007)(6486002)(66476007)(2906002)(8676002)(66946007)(316002)(6506007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?RUd2ai94NVp2MXpmWk5nTEZCMWhUanErb2F1bGN0cGFuZzltTTlJSXhsUjNi?=
 =?utf-8?B?OWlKRXQ4aTFHemorcUxYNmhJaEpxUXBRRGZSV2tYd2grbC9lSjRDeWNMSWQx?=
 =?utf-8?B?d1owa2plcjhvOEE4M1ljWU1FNzN3empRd1hqd0ozWU5KcGZQdWRQVW95TG9i?=
 =?utf-8?B?SkhrNXFoUFQ0YlF1d0JITlRBSDhjbzdsUDIyQksrUDBYZ2x5NDIvTFVPcDUw?=
 =?utf-8?B?aExKUWRlVlFMbUNQVC9YZDFhYkNmdmhPWCtwaFpiV2x5RTZHYjdPdjFCOUZ3?=
 =?utf-8?B?S1pqcDcxREdUOUt6eXNsbE9raU1wYk00UGFXRkFkNHYzRTlCS0l6UlkzOEhX?=
 =?utf-8?B?YWI3VkhlOHg2R0ZXTENLUksyVCtxYUhkUDZac3MzL09sVXhPU0NyVnBJTWx2?=
 =?utf-8?B?UDZUeExFcU1hcFJuK3lyRkgrbkhoZ1ZzOUgwVzFpWkJBb2ErL1ZGYWZ1eTVW?=
 =?utf-8?B?OVZZL0RPOXVUYUJTaTRlNi9CMHVHN1IyYUJJQTdFcHpIbFFzK3Rwd2ZTMko4?=
 =?utf-8?B?WGpqNUVUL0ZRZGVmQi9qdTdqTVV5UldxQ2RKaEx5ZnhyN2NGTGJDU0RobFFW?=
 =?utf-8?B?bW1kKzBGUHZ0NHo3OTdkclRtNkh4VHBIcUhma0lZY0JiV1FQQk0yUWprKzll?=
 =?utf-8?B?NVdvQ2VJNDlrdkVKWHk4NkdNQjVuVHpBcDMvS0ZKWnFaMDlicUw3NDFqVVpt?=
 =?utf-8?B?Zk1ucEJqRk13M2FDMkszSU1MNGZ4Y0lqYnpGSXJvM0xSbzNWM3NWOWlRN212?=
 =?utf-8?B?YktvenYvL25pVlFxbWpWdGhFMEFWSHhEbis0eVNscUVTbjlmVEc3K2h0RzlD?=
 =?utf-8?B?ODYya0l0TjJSWW5YTFYwa21HbnhKemtuMWtYdEU3eDVJVG1XQWFkVXZycGZx?=
 =?utf-8?B?NHJWQndINlk5eFc1ZjI0Mmk3MnlHMlBTVm1FdzhqdVRFT2ZMamp0YlFXeDhU?=
 =?utf-8?B?SmxTTUFUS2w5MmZSRGFZZnB5Sms3a3h1QkFXdnQ2SVBKdDBzdDlWY0ptNm1E?=
 =?utf-8?B?RE5BdGhQUHltRkUwK3V0YkFMVUFXMUYrOVcvaGVIYVZXYWN3cE9kT0ZBek5R?=
 =?utf-8?B?elg5c3hlQ0Z3aXhkbVZZZElBazJjQVRjSXFSUFFkTTd2SzhBN0g0SFM4Qzgw?=
 =?utf-8?B?Z2xkeWM4NkNZcXdFbit1Tm9BejdlYUZvbFpWMWhHd1E2UTI0Q1BNVGZUNGlu?=
 =?utf-8?B?VVdpaFJDVFdtRzl0eGVsbWptVkE3L09LOS9Pd2dBOTArczlXUFpkc1pzQURu?=
 =?utf-8?B?bnVkS25UVkI0K3ZIdnh5UHdlWHBoK2I3M0U3N2lIc2tFbXlIOG1MQTZNWHVm?=
 =?utf-8?B?RjZ0VktXZ0hqTGRqUlArQ0NmeXEvV0NHUVp0WERXUWxGRXkwdUpKemw2Mklr?=
 =?utf-8?B?Wm9lWDRRQjFlUGRhSUI5akJ0TWZocEFjcW0rNFpjUkpaTkN6UUpTMlZTeFFU?=
 =?utf-8?B?K0hqQlA1SUJGTVlVYUJ0V0VwUjdubmNyU2h4VWxGb2Z3ZXBwbGc4TXh2TUZ0?=
 =?utf-8?B?d3lldGVFb3hQZU1WM1JDVk41Ni8zRGdJRzNYNHhCUTIrTDR4dVExajQ4RXA1?=
 =?utf-8?B?UldGaDJiRnBaMmVINDkwMkNPVXJaN1ZIYW16N2F0dDdWZ0dXRTU0YVo3Y1Ay?=
 =?utf-8?B?UnZJa3E1NDdZUTdaanRKNzRob2pIcmk5cmQ5VUJkSUtPQnYxS0FvOHVMaCtY?=
 =?utf-8?B?U0MwQysyVWVaR1R3V1dFYSs2Q2tqcXprN3Z1QlRXNmlzYnZJdDlFZ1kwVTU0?=
 =?utf-8?B?ZHJNQzBMNFR6VHlhaVhUb3ZVQTFkZjhraXVJbzBLVW1SbkIwWHRKNzZaQXVZ?=
 =?utf-8?B?cHdrVi9yQ0lwWUhzWW1OM0pON21IN29naTZuVzlrc3lBY2JXNG1zMHZiODFa?=
 =?utf-8?B?WlplUTJvTTBNZGNoNG5hcFB3MkVmcW0rOFozREtqM0hObDJON3FXNXBIS3Uz?=
 =?utf-8?B?R1ZaNVVkSHp3bHhaR0ovbkZsK0U2bjRLL2FaS0VJL3o4VHl4WUQwcVlhTVJq?=
 =?utf-8?B?NGFnY2tzQ3VDeG1La0RJaHZnVy85UUY2QVFabWd6YVJSUXl2TmQrQ1dIL3dB?=
 =?utf-8?B?MXBkRmlWUnVmRk11Mk9ZYlZzY3FOVW85ZzN4TU1rbDZPbSthUDZEUkNsTUpZ?=
 =?utf-8?Q?FTyDX4Ol2HIIHhpGbIAviM0ud?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1587a51-2712-41b3-8659-08db1ab26497
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 00:09:29.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toZYde9aQSiKajQJRHYiKgLgMLbF/uozAXQb2ieFMcjp3W1TsZYV2FF5ww/0g0CHzHgkCw9qJn1XphZ70shaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_160939_030270_29952CAB 
X-CRM114-Status: GOOD (  11.49  )
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

Hi,

We are observing NVMe device disabled due to reset failure after injecting Malformed TLP. DPC/AER recovery succeed but NVMe fails.
I tried this on 2 different system and it is 100% reproducible with 6.2 kernel.

On my system, Samsung NVMe SSD Controller PM173X is directly behind the Broadcom PCIe Switch Downstream Port.
MalformedTLP is injected by changing MaxPayload Size(MPS) of PCIe switch to 128B (keeping NVMe device MPS 512B).

e.g.
# change MPS of PCIe switch (a9:10.0)
$ setpci -v -s a9:10.0 cap_exp+0x8.w
0000:a9:10.0 (cap 10 @68) @70 = 0857
$ setpci -v -s a9:10.0 cap_exp+0x8.w=0x0817
0000:a9:10.0 (cap 10 @68) @70 0817
$ lspci -s a9:10.0 -vvv | grep -w DevCtl -A 2
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes

# run some traffic on nvme (ab:00.0)
$ dd if=/dev/nvme0n1 of=/tmp/test bs=4K
dd: error reading '/dev/nvme0n1': Input/output error
2+0 records in
2+0 records out
8192 bytes (8.2 kB, 8.0 KiB) copied, 0.0115304 s, 710 kB/s

#kernel log:
[  163.034889] pcieport 0000:a5:01.0: EDR: EDR event received
[  163.041671] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
[  163.049071] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 source:0x0000
[  163.058014] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
[  163.066081] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
[  163.078151] pcieport 0000:a9:10.0:   device [1000:c030] error status/mask=00040000/00180000
[  163.087613] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
[  163.095281] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 00000001 d1fd0000
[  163.104517] pcieport 0000:a9:10.0: AER: broadcast error_detected message
[  163.112095] nvme nvme0: frozen state error detected, reset controller
[  163.150716] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error (sct 0x3 / sc 0x71)
[  163.159802] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags 0x4080700 phys_seg 4 prio class 2
[  163.383661] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
[  163.390895] nvme nvme0: restart after slot reset
[  163.396230] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
[  163.406079] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 0x0, writing 0xe0600000)
[  163.416212] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 0x4, writing 0xe0710004)
[  163.426326] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, writing 0x8)
[  163.435666] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100546)
[  163.446026] pcieport 0000:a9:10.0: AER: broadcast resume message
[  163.468311] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading 0xa824144d)
[  163.477209] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading 0x100546)
[  163.485876] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading 0x1080200)
[  163.495399] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
[  163.504149] nvme 0000:ab:00.0: saving config space at offset 0x10 (reading 0xe0710004)
[  163.513596] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
[  163.522310] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
[  163.531013] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
[  163.539704] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
[  163.548353] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
[  163.556983] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
[  163.565615] nvme 0000:ab:00.0: saving config space at offset 0x2c (reading 0xa80a144d)
[  163.574899] nvme 0000:ab:00.0: saving config space at offset 0x30 (reading 0xe0600000)
[  163.584215] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
[  163.592941] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
[  163.601554] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
[  210.089132] block nvme0n1: no usable path - requeuing I/O
[  223.776595] nvme nvme0: I/O 18 QID 0 timeout, disable controller
[  223.825236] nvme nvme0: Identify Controller failed (-4)
[  223.832145] nvme nvme0: Disabling device after reset failure: -5
[  223.876833] Buffer I/O error on dev nvme0n1, logical block 2, async page read
[  223.876939] pcieport 0000:a9:10.0: AER: device recovery successful
[  223.893404] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
[  223.901469] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
[  223.938902] pcieport 0000:a5:01.0: EDR: EDR event received
[  223.946077] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
[  223.953901] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 source:0x0000
[  223.963243] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
[  223.971691] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
[  223.984144] pcieport 0000:a9:10.0:   device [1000:c030] error status/mask=00040000/00180000
[  223.993966] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
[  224.002023] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 00000001 1e659000
[  224.011644] pcieport 0000:a9:10.0: AER: broadcast error_detected message
[  224.019604] nvme nvme0: frozen state error detected, reset controller
[  224.236597] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
[  224.244676] nvme nvme0: restart after slot reset
[  224.250584] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
[  224.260945] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 0x0, writing 0xe0600000)
[  224.271460] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 0x4, writing 0xe0710004)
[  224.282012] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, writing 0x8)
[  224.291713] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100546)
[  224.302430] pcieport 0000:a9:10.0: AER: broadcast resume message
[  224.309618] pcieport 0000:a9:10.0: AER: device recovery successful
[  224.316968] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
[  224.324865] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80

After test, NVMe device still shows up in lspci and I can read pcie config space but cannot read/write from/to the nvme controller.

I am trying to narrow down but would appreciate help from linux-nvme.

Thanks.
-Tushar

