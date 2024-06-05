Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34C1C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUSnVXmdxI4H78wQtioIjCopgxkAnIk5jewWUCX7060=; b=eElnI/hQ+IxUobimWosk7YRrDa
	mIjeXpOPESC8PROh3SY2RPWoAbryJRGKeWwpAar++mrb23mOkjoiTB9aeHuD29/QXRXqn1+uXEu9W
	MstZwN19kFu0IZpoWfHoo+YhC3eHN2f2r9+pB7WADYpYSWQ17LXwrAtJ8rFQtPLL/13SHMWutTZpq
	ktR/C8PJGpmcoBnZ7oKzw3WCFZA5RJupmL4NBDpArN0fZ8a9+DeIdxI0mHlpM177kFy5YIIe3/+GD
	NoQZKu2SjrfJMxE+G1ELDba8GpQ6oluJ7dwsZHcUQoUzRKpQBZ8td34M+BKfQd4o/TFP2Bk8af7/7
	V+vKTQ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEqlA-00000006Fqq-3nQ0;
	Wed, 05 Jun 2024 13:33:00 +0000
Received: from mail-vi1eur05olkn20800.outbound.protection.outlook.com ([2a01:111:f403:2e13::800] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEql3-00000006FpD-2r3m
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 13:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jgv9ijZsILIXXmSfbeoOBZiGGiBnsMp5++HQZ6z46nWoXQrcB1NYol+Btr1jWNHk/tzUAy+ffiui+bE0pWc7ZWyEOpc4jopNFEdvXKHESLqze9J2cPXwWOg59/YTcbOV1Bflm6hdzQ4KJYhiCtwa1RwmLsf6et7jMr6/k8eC3MRTbSEQCP85tMtSal1to2+bu+d5mniWnZuvzn3lED45xaxeWUxXufYl6t2U6XKqUJTWISX5aNkV8UPPSb5gZ56SGgQBz9av/gvtN+UrbL1FnOibdHHGZJ7TII7FcHlUmm23jJcgBu2agNPUFY1QuBaOXei3vnBiTl5nFvVUimh4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUSnVXmdxI4H78wQtioIjCopgxkAnIk5jewWUCX7060=;
 b=NL5MmlR0VD6cGY3KqsARoKvYHC3em1wd4S/ieAHTdxgQxTjHGHVZNsBShcHxHNKkj4+NVewWoYkzmDgv+o86eggwEpfIdWXSBeb2iLdd3Uk5xINFglKC8OqoQnMkzQPaofnme7/g1ebvH+F8iVul5kGVKWSdSirxAVPH+JYWe8QDTFB99ME47tGd3Ua+EO6ul5cvDpvRlGGwpbd0bYb/p8j0ZZ/Qpz0w/QTzo624Isp5+8ZnMfXK0pssHqdMVA+bS6LSNV4+VbmP6+TzAWzVTzDTyf43wNWu884N4KEcS+xv0l3gs9iXA0B6/kDrZ8tEmRKfpFK4AJuwU80X5bLEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUSnVXmdxI4H78wQtioIjCopgxkAnIk5jewWUCX7060=;
 b=k+7LH5qbK+dZHX8p3CVGMWhYfHaoXVMBUIfYXqXaljATMpvVUiTHBvj1Dtw2xWJzJ0OwZ7cfR6YJPxt9jVB8UZ8/2JWHVx91FnI8cLJoDmqj/hvn9ftUk2PG+zlwi0Y7QSuQcxqszaX/TDURQMwmTHYGTeuzHhws12qeE3KhZOqlyx8wJjILZQSbisAFB5bXk4NBmYFI46OLN70ltn6pE5jlq6boRV6jnersTcVrWxwc/H656kFw8uD4o9Yd2VnwzykHiaiAWt7hBtOkUAO+mYpYfZ/TVyVAE3I7avfrMaLW48aFpbLuvwu1h9KZqOG+auHYzX46ujd5FlvbtP0etw==
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a1::5) by
 PR3P195MB0700.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:37::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Wed, 5 Jun 2024 13:32:47 +0000
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f]) by GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f%5]) with mapi id 15.20.7587.035; Wed, 5 Jun 2024
 13:32:47 +0000
Message-ID: <GV1P195MB2055E2A004FFB8DAFED2AC5CEEF92@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
Date: Wed, 5 Jun 2024 15:32:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Configuring CPU Cores for NVMe Target & Host in Linux
 Kernel
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <GV1P195MB205539399CE53BDAF0D58AE6EEF82@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
 <Zl-JNqNySZk71_3F@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jigao Luo <jigao.luo@outlook.com>
In-Reply-To: <Zl-JNqNySZk71_3F@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [omacDaShlaiGKRt3Qcd7HpXCTRes4yz7]
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:a1::5)
X-Microsoft-Original-Message-ID: <482e05f4-a0dc-4fb9-8ca3-c2f458f93cdb@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P195MB2055:EE_|PR3P195MB0700:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b61815-0e1b-4262-3a4d-08dc8563fce6
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016;
X-Microsoft-Antispam-Message-Info: aFnkPQrK7H0Tk35JPV3WuBzIoa2xrYOVta/GLd2tmJSbbP5GT0SI+qA8p7XzxOKbctO6cPNVexRnLrwOWz3L4/y5s2CiqSFpQKzOQQVC5lt/6gQuJUSo2XajUm7PF9e9YUH6g1loFrzmrY8wTukP4HDuqkjkU0qwZJ0ph0jQ0A56zKoH+IkHfthA/ZXinAM2UdocSHQseB4d0kgxk/ucYBQ8npoRu4xLNPAENviBMZJclWSSCGEXnecGhF+zHZzzgl5MX7YwdhcBtRTkiSJk/0Fe9um/aLYdT8fbeseiY5LQBF7ojIAQ2+bQSmH3HLH2OWTuDv5Uz6hMlbYbpQUUQyL/FmgBlOsNMm0/V7P6Oe8EsGjsl7vAMEdxU4eIeEA170yNNH7hYDvEcyY7XKtnaLxKdQg/Y4OniIvcCNdLMbeM2nIy1OH8MJt/rUVYSr9fcd3qK4eNgJnRPJualVHepiUyRCmwnsJLy3Z4DeCztAvk8Ea6+r8uG/u3+MC7NA2iAAX5JN1Ah/ArHXM3BsXXx2RkxcMki3v6CEMdpPhNl/jh+K1aOimE4rc3WuagomkAfA9ikCZG/rWvdezkpTkkIHmuBWGq9/kdGG1fD4aCK4db2+iupTZp21v4xivjvUVDUw9WITCWAVf4M3wxf3IutGBa+2Oz0KBQxJQke/K3v/g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlZS3BHOVhkek1ubU5XSWdLL25SbW9nY2pDNWFGL056aU5hQncvanArNjRt?=
 =?utf-8?B?NjNvQ0Z2RXN2ajdPYm1ZWU9IVDRkbVF2cExjYktMV2xSL3NiUHNIL2VhL3VG?=
 =?utf-8?B?dHNIVExzeWpEY21udmZwTTV5WmVaQTN3NndPNTNMWHVCQ09pWnpWNjRacHNp?=
 =?utf-8?B?RmRadndHNElSK3ROZy9IOWJOZ2Y1MU96TVVyMVlVQTJMNjVsYzV4Z2k2OW1U?=
 =?utf-8?B?Zk1BOXdqSmtGZlVTcksxSk9lZFhNU0hpTmF1Q054RVY0aTVjZ2ZHcmlxRHRI?=
 =?utf-8?B?TUxPSlVqdE9KK2F4d3BYU0tWL1hQdWtYVGZSbExBUlc0OXJRWHNqc3g0dWtn?=
 =?utf-8?B?ZGRzYTEzYllXRUREMHQrQU5YOU9RWUoyMkxNRkJkTkhJazlEV1gwRUVPU1ZE?=
 =?utf-8?B?OTIrMlJhb1VRSm1GMHhCZU1oV2J0S1ZrVTBPMW84UGZ5Sk8zQzV4N1UvSW9q?=
 =?utf-8?B?MmRkWWhaUHB1ZExaRnVuNGVLOUVJNkJSRnVtaFR6YnFzVFZ6cmJhQi9idjlB?=
 =?utf-8?B?M28vV3hRUVJMVG56RzFQMUcxa3ZQNDdJYnlEMWdQV2Z3RlJSZjB4UlEyYUx5?=
 =?utf-8?B?ektvKzFiS0l1N0ticEl6TU5qOGdybTJCNnQ5ODhpTURaWTJHQ0kzSTVzbytm?=
 =?utf-8?B?N1JncXROVDhCaE83bDZsRWRaUmVQUTVWQjFldG9KMFp1ams5L3dZMURxNUdV?=
 =?utf-8?B?ODJiV0d3clBXem5Md2RIZFExcGRkT3hrVURVdXU3US94TlhWRVBVNUdKc0ZQ?=
 =?utf-8?B?SzBramthdGFBRzZEd2dha051V2txZkI3cEJiN2VrKy81OFdxWlZiL2pCdlpC?=
 =?utf-8?B?b2dxT0REZUpvRWdmMENNSmtpVVFUYjVnTk1QMHRmODdwVjR6YlFzRXhnMzM2?=
 =?utf-8?B?d0RJU0lvNWdLTXlRZ2lWWll5N1NQbGkyQTcwQm4vN01CeTFBUGJqc09HRmNM?=
 =?utf-8?B?SE1mdVF5b00rS0g3VEltWnpHNS8zRDg3RW9uNy9YZjRvaFExNEFzUWtpK3l6?=
 =?utf-8?B?b3IycStaL3AyVy9NMTFVcHlTaVE4THVHUHQxYUp3NXg0UHZVZGpQalNPUTZm?=
 =?utf-8?B?T25RMVh0M3hZSEtHYnBDaWRISHE0SHpEMFlRK1RCMWtubHNWM0ZUVSsvNkRW?=
 =?utf-8?B?UllMeFdLYVVodWJWaTdSRnBpRVhJWXdMckdVNnIrS2M5TUdEeWpmVXAwNjY4?=
 =?utf-8?B?enVPUkFkb0FVeUdsemdJWDkwS0tXSTROSmt1Y1pZNG43VmFHRXpHMUVVUkF6?=
 =?utf-8?B?UjZHOVdzK2pVUVYwNnJ2dW5rNnJWTmlzcFVwdk5lQnZvcFRMZlNRS1hJRENS?=
 =?utf-8?B?K0llcmphVEYwT2xwa3Fqd1dxMWQzYXFxTVZSRkdFNE0rOG9ucU12SUEwdmlw?=
 =?utf-8?B?REtCbzdMbklnVEVFTFBncG9EWlkwcVltUWFtNWdwT1ptZ3lFNGpIa1dPQS8y?=
 =?utf-8?B?bzcxdHVnNHZyZkFQQ2hFTFAycXlWcU91NDdJSit1Qmo1d1JhQ2txNWV5WDVy?=
 =?utf-8?B?MTc4RWxoTFV3c2FadHRQbytDcDFaK2tUenpyYnJFV2kvVjg2czhxeE85Y3Js?=
 =?utf-8?B?UVJ4NHpmYmoxSFA0L015RG16dEpUSElUeFd0SHpwTVZKWDZEdS81VkovYUJ2?=
 =?utf-8?Q?i4ejGeyi9gwMjEOHM34WuZYEbf24kHpm8sn26INw8z/0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b61815-0e1b-4262-3a4d-08dc8563fce6
X-MS-Exchange-CrossTenant-AuthSource: GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 13:32:47.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0700
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_063253_758097_A752F4DB 
X-CRM114-Status: GOOD (  18.62  )
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

Hi Keith,

Thank you for your response.

My question is more focused on the Linux NVMe-oF RDMA target side. 
Specifically, is there a parameter for e.g. `modprobe nvmet-rdma` (or 
similar approach) that allows configuring the number of cores the 
NVMe-oF RDMA target can run on? Additionally, how can we benchmark and 
collect data on the number of kernel cycles used solely for the NVMe-oF 
RDMA target? I understand isolcpus, but want to find a way only for 
NVMe-oF RDMA target.

In comparison, SPDK, due to its user-space properties, can be easily 
configured with the number of cores and benchmarked to collect CPU cycles.

Thank you for your assistance.

Best regards,
Jigao

On 6/4/24 11:37 PM, Keith Busch wrote:
> On Tue, Jun 04, 2024 at 11:10:30PM +0200, Jigao Luo wrote:
>> I am benchmarking NVMe over Fabrics Target and Host using both the Linux
>> kernel driver and the SPDK driver. In SPDK, there is an option to specify a
>> core mask that limits the CPU cores on which SPDK can execute work items.
>> The SPDK team provides a benchmark report that demonstrates the core
>> scalability of NVMe over Fabrics Target and Host: https://ci.spdk.io/download/performance-reports/SPDK_rdma_mlx_perf_report_2401.pdf
>>
>> I am curious if there is a similar parameter available in the Linux kernel
>> target/host driver. I have not been able to find such a parameter. Can you
>> confirm if it is possible to configure the number of cores used by the Linux
>> kernel NVMe driver? If this configuration is not available, could you
>> provide me guidance on understanding core scalability in the Linux
>> implementation?
> You're using RDMA, so you can assign CPU completion interrupts however
> you like through the /proc/irq/*/smp_affinity interface.
>
> On the submission side, you can steer user space programs to some subset
> of CPUs with the "taskset -c" command.
>
> For the kernel side, you can mostly set which CPUs can dispatch IO with
> the "isolcpus=" kernel parameter.

