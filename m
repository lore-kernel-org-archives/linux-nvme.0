Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636DDC27C53
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:To:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=licSTxBxXLVDqi6nw+BB0NOz4c3XbrhViXQ2V/F7ucU=; b=szz1VKQxnRqeJX
	8gFr+oZ+2bI1OTpICamwGOdRHrH1KUJstcVhTsNlHcvDJv9e2fzKDOkVQIso26hTkdZvDIHL/ATzh
	YJQ1Ps0pJ8j/1sGueUUyRRFhxsdBf3sf3B/J861Qg2MtjrELw7AK8K6uCVZqVnUnvG6KbfBv80V5x
	+RqkWb/6vpxdfwoWOdXOEFcM2IxnNYI7StqbWY/ahsNfQT8WX4xnpINXJKzA6zpPzxD4gt+WMSzb2
	TceTHv2udRzurfti1J3OCHAa1KTnja1GS996r3kzWflyW2ojU0z27VuacXW6LeEwVPSpm2pUGi+f9
	33Iigesc8rArPaC9Fv0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEbQX-00000003nXX-2829;
	Tue, 04 Jun 2024 21:10:41 +0000
Received: from mail-db8eur05acsn20809.outbound.protection.outlook.com ([2a01:111:f400:7e1a::809] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEbQU-00000003nW6-09j1
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 21:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFDdTWMl2UI+u8vgQ2wE5cLHNmQiuSU7+LzE1NBaCG8rQh19BYd6gSNMi3IaHCUKx6NbJK66w7+UzW8NrxF4UE3fAMGnz0MvZAkYUwKQtvkw/xlioIf07OvNGpscm2ElS+lMqyN/Joiv2f9ivkoD5ybiuqQtYgy0dxyi+fRHbgB+RDwZRqjVIXBRqKm18aBDcsL04mudz8/fwFKBZI6oK2mloaJtv+/o97Sa3E5OwRwIe5ZotK4HiU7dXNM9NiJjmmbXHdWSnMIh/a4xSfS04HTSKfltzIOlkGq/jVDXmxRfs+nJ0Fc7J/b/pp/NwNutS98m5xmEti2cbt+FVDjJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=licSTxBxXLVDqi6nw+BB0NOz4c3XbrhViXQ2V/F7ucU=;
 b=k6sAU0hVSyVX27jrlrkZZbwXjZZ9s8w8qDXu0F1lYhiY7NnWFVXRa7izX83vSFaP+r0EnEfV+8OJYa1vfNWwTLqMSJ6P0ELwyJ1Xc5gl74PRPCVy7BSrSJt19T0YPgDzcy4jgsF5qgPyOZcMatz4oGROJMFaM2oRhvLhumjGxHQMVDBh0dQICfr/btEcchp41KizLMfFOZ/AU1wARsudzVtzvOfIw+2ZCrT5YvV+zA3OsozKVngJcUeeNF4o3EydsrNag0EMnLx74+L/PvqLj+P014HMlDKkdW4V7Pev3hE7oFcudf8M+th0EHQmHveWHUztviP/VKkyu5vGbr4QyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=licSTxBxXLVDqi6nw+BB0NOz4c3XbrhViXQ2V/F7ucU=;
 b=SXm/EFEyKxzdMsXjooc04M3VTjCpqsu1pGx0L9r3cXttB7PkiVsFGr4kbhJBP+iMwyy7YnCe7EtB5oFfP8SKRBn8jCeMiCJ/K3wPZSMGUW/h3dyyN5wPz55o/OvfBWHbjun+ouv0iP1oQTS4jAQIYMm/mo4hexy/GmXNg7E4Nprm/urSfoufMX97CiZ/5EsOnJPIaUBy0c4WAPPaZNvuqNF+2YV38Dpbzx1UwZGGNk5KM5TQ6F+fuGBXS52OmMJxlqI03w+XuzUiTDsRU9rp1swv5d9SRpxtcnpl3xqSovvkk9ZYH0ZOmYut32cnEiQlhW43YIs86n5rWXyfbCCMyQ==
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a1::5) by
 PR3P195MB0895.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 21:10:32 +0000
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f]) by GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f%5]) with mapi id 15.20.7587.035; Tue, 4 Jun 2024
 21:10:32 +0000
Message-ID: <GV1P195MB205539399CE53BDAF0D58AE6EEF82@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
Date: Tue, 4 Jun 2024 23:10:30 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nvme@lists.infradead.org
From: Jigao Luo <jigao.luo@outlook.com>
Subject: [Question] Configuring CPU Cores for NVMe Target & Host in Linux
 Kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [U9/PABxdf/YYWodltdxTwUWXEQhF4XLv]
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:a1::5)
X-Microsoft-Original-Message-ID: <62e42ac5-dee5-45f4-9d7a-817e538cafb0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P195MB2055:EE_|PR3P195MB0895:EE_
X-MS-Office365-Filtering-Correlation-Id: c73ebf09-df1b-48d6-c1c2-08dc84dac521
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003;
X-Microsoft-Antispam-Message-Info: Jju8hYCAgsgU+y4mwHDTc6fmGCWyzRJB6Wx0KTsfvnRc+YKmgI25XwKxxIcX5ZTjMBKxJxalR61vVWV7Goepul0FiF+RBeWjfyCxpZB2+1ZkGHvUaLNS21LpKeOwCCKLvjQj8gxRHHQ6gdZ+httoplmZa+z8oC2sDKKKwbgohkEPRPN2KbVQuFB8txlamF5ZGdHaYCTDuXDGk5XAc7fZZDzdbk4P4NqobnLCNCcWWZElstPgt4p4GDNcdyfPR3pZYOm/enI8LtEI21c9fvvdY5x+Sg7srJVxM5tju5vVyteT9VkKo+jsR6srdOahisbOgBLxV6wNJgvYs/e1g6AZwHajjKg/4d4L88ztoblAPXKrClbIJRyIuOOpqeYDummxbR0g/Jyjl9HxT8LmfnpWey37+hMd3NXV4D1UjDigyk37ubFCfS8ANLQ3utm8ryStsZ9x5BVmr8Onp6WqWSTkeaG4Feu25pOhpGf5Hbr1bpX/7U9x4H2BQkhA5bV/Q61MJOrX0lkaGJ9llZat4tCWh67iIFO6F4UDGLq7SXXdnxAjzMQ7mOmIdlBp5k9eMTRN8iY1EOoAAoQgdAdlg9Tcm9OJzYMu6atgVAeekDhRkn8olAkR09kILEElZKFyD3Idx66QUdY39UlMW2XNTKbTBJTSsFOGPD3DXvgk7zoLDpI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWcxU0VTWkFwc0s1MlZVcmpHdko1NzBLRVRxUk1YSzRYbFMxZ3IySWdoVlhu?=
 =?utf-8?B?cWZPTjlVRlpYR01RQjhkUzlHR2I3WkNWMTZDbFRXTFhRTGVLcWhKV29nbDNZ?=
 =?utf-8?B?RStoTGpQUk5kcEdLdFAzV2krbzRIZmFQOFhtWGx6S0M5a0lma2dqbXYzNktJ?=
 =?utf-8?B?MDRXUFZTVjdYajdvMUh3OHFRYVdBUFBaMnpudVQvSU9EOVlERm9STWExSFQ3?=
 =?utf-8?B?S2lYcysxZDlZR3dhZEpwbWJmQW51anFYVXQycXB2QWRxcjFvVGJMbytlYkl1?=
 =?utf-8?B?VEs4MmxjMkZPUVQ5K3BuVzU0dTFRMmVDeVR5TTlsZmcyS21yWXplMEpueHVm?=
 =?utf-8?B?VXM1NVpvVlBoWGlYazduS3FzeGJpNkpKWVdPN04zSER0UXVKMi9VbFVjTVVy?=
 =?utf-8?B?RnJNSDVJWDhGWURtUllia0tEdE9TQ0prL1YyUFEzbktnM2twVm5jTVVhQXMx?=
 =?utf-8?B?b2VhQUhzMEgvR01xYkxIMzJ3a00yc1QyUlFjbXpoZ3hWQUdUUlFTcStGbGli?=
 =?utf-8?B?TkNuZXdpd0sxdkZIRWpuSTlIbFN5V2E3YWJ0Ym0wT2xUVVVUUnhYVjYzOVdN?=
 =?utf-8?B?S3o0RXVXRmdjVFVmU3BldGQzL0VRN1NIK2diNjFZSVhKam50ZEg3YmVkRVBO?=
 =?utf-8?B?WEdPRVJ5MlBYRTVta3JkRks0alVMMmRMQVJoR2tDQVhPMC9TalRHdERDYmNx?=
 =?utf-8?B?Y3diTkw3aURXc05yVlN5NU5rUEZ6L2dWTVRkcmwrS1ZCSlIyN0FJb3FKMFM1?=
 =?utf-8?B?cHA3ZVNsNGdtWnJQVGdwbWJWUVdVWk5KQ2N0eFBFancxVlBNaEhmZkFnQzlV?=
 =?utf-8?B?MGVyejl0WjdlbDRyeWJFWURCcThHNGpuSjVuSzlDVlRrNG9FVTljcEVyS2h0?=
 =?utf-8?B?dWp1THR2QlRQMXZTbWVhMUl6Rnl1Tlp1TTBHSmxFaDFmQVQxaUR0c2VZL0FN?=
 =?utf-8?B?WnZBSnJuR1FISGFVZVp5cVArUnY1Sm5rbm5KNVBjR2tlWTlsdFd2SEdHRE5K?=
 =?utf-8?B?SmtQTktjeVR3T21ySlp6cklKQ3ZpOWxBSFlyU2N1SnFHMHRHWUh1QVN4NENE?=
 =?utf-8?B?WTJlMUJyZmxnNmRYVnFZeUQ5RkV3ZS9haUJCbGNSWm52Wk11cXNtRFVENzA0?=
 =?utf-8?B?VnZnVTJELzhSLzVCbjBFek5nMm1lblA5bHdGZHQxMzRBMnM2NDM3Y24zTkdC?=
 =?utf-8?B?aStDRE8yeWRpeWY4VENvby9RWVdpSDJtcDVOWlc3bEZVV0JKUEZNOXdHUDNF?=
 =?utf-8?B?OTlkUEpqSWxaMHBQM0pUVTVUbmhuQU13ci9Ca3BNS0o3UFNZTXpXUllZQTNw?=
 =?utf-8?B?RjFmTnVqcVU3TWpEZlNIR1NaZTJZdW5uQnpubjk1ZmdwVW1GUFdsL3lKQS9L?=
 =?utf-8?B?cHFYNmk5SGNDMnpHR3U0MXVWeEgvcnhOQkZ5S084MkRPRXdIYkZiUEZ5cjdY?=
 =?utf-8?B?MG5qeFdWSFpoaVN0N29TczR1dHV2am9DNXl2WnhaK0UxQ0d5WkwvZnFhcTc0?=
 =?utf-8?B?ajY5YVY4dURGdUtybWtPQ3hqYmZaQStWTU1qbzdlN3Y4eWw0RVRzZXZlM2ZL?=
 =?utf-8?B?ZnJRZmZjQVp4TzJyRkt6YXEzQ1RmN2NJampydXNwdVFoK1orODZ6MDEyMG9K?=
 =?utf-8?Q?n3lQSN1gJwpM5fWz4mZRImzqpZpkaq3kgZKCvDh1ewj4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73ebf09-df1b-48d6-c1c2-08dc84dac521
X-MS-Exchange-CrossTenant-AuthSource: GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:10:32.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_141038_147001_1414323D 
X-CRM114-Status: GOOD (  10.80  )
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

Hi everyone,

I am benchmarking NVMe over Fabrics Target and Host using both the Linux 
kernel driver and the SPDK driver. In SPDK, there is an option to 
specify a core mask that limits the CPU cores on which SPDK can execute 
work items. The SPDK team provides a benchmark report that demonstrates 
the core scalability of NVMe over Fabrics Target and Host: 
https://ci.spdk.io/download/performance-reports/SPDK_rdma_mlx_perf_report_2401.pdf

I am curious if there is a similar parameter available in the Linux 
kernel target/host driver. I have not been able to find such a 
parameter. Can you confirm if it is possible to configure the number of 
cores used by the Linux kernel NVMe driver? If this configuration is not 
available, could you provide me guidance on understanding core 
scalability in the Linux implementation?

Additionally, I have a question regarding the Linux NVMe target driver 
(RDMA): Is it possible to configure multiple NVMe SSDs on the same 
addr_trsvcid (e.g., port 4420) on the target machine?

Thank you for your assistance.

Best regards,
Jigao


