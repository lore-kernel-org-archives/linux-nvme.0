Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8B9C369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 06:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9SoZHtHDTeMFkGBoQ+Ouf6OWHyPouexTA3xDjsVTsw=; b=bT9Ei36fwoY5jfiDbECAai5WTl
	EB+4wzpf+uBoYQBc3cnQqmq2eppYRL5IOCLQY4Ldln10FHaOhIPsdq6l9yiysMHsiH5QxWUq1oWbX
	KCqzotoxbuDfdOyY9LkDlSTMM/VeVEZ2gezg2Rb1hjXSw8jt7BaT9buLzXl+ZXuh0VBzmC2WePvuT
	hQJggWFggN5UM5fXCTw1bIBZshHjccveFS/FvLfNaU1poBnvuO0jhDHn+Zt/HC2Zxmf2VDpTdGfvD
	JmCGm7naeqL5YWX0yObBvmACOWepUZHd06pm1h7/Xo36lUljANEAcG526sNg1OyZXZlqhnguLUXvM
	0Ycb6Xrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wa4-00000008TlC-0CeU;
	Wed, 16 Apr 2025 06:49:08 +0000
Received: from mail-mw2nam10on20617.outbound.protection.outlook.com ([2a01:111:f403:2412::617] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wa1-00000008Tj2-210n
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 06:49:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjiGMRZIYf1XfUOdZBidEKRiSADWilstGuNDQjaH9vQfA2qX5aZYn3h9ACwaeR2nIcv6+5M8BIVvNmj72/Vm67qgtqQhFlpYPRCN9WZhVEFskVq5WxYR2Pmu9dE7NNRlQFuI0iimedUf8CoimAmo4ak32QCBfkEnqDICRowaOz7xfEL0UaR5yFV/GhR0mWO6K9/8z9Bb2fzPP3KhKScgPcxu1j7WmHHWwQTX/iV6zcF2XRLflHsrk94/ptQSwNpBNWdVVLpLntD/cilQbt0w92DFhC7TxP4BA2A14tcSAlbt+jdPZg9/ruDWlBVN9KmyGtaY7SFzlCFCLtrjIbQPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9SoZHtHDTeMFkGBoQ+Ouf6OWHyPouexTA3xDjsVTsw=;
 b=k3Yl6a1ZekCPyNpra3Z/TYj9MowdM7Cx+q7FJv8M9inUoQ5YaJZ9j16g12V6Vri5HK8nJ1wOurkSsWuT/B8K1UgetfS0bDarLjCEvJUaNWOPmHX1BDNQ5zc0a/zEerY7IjszATBpCPCTTkyOJ/L7ER9doYRez2fysTkFrilr9sxdp4J1b2Sq5y4TGiU1zN4O0xGE8PP9kWjwE1oBQ/6lQciay94bo4cbscQVZDUrP2XqPhB2qAJKTzQL3VZCMEsoWZxvQG3p+CLLnqy4ewU+E0X2KUOi848zjMQGAwJKqrGMUheJXwNjZOHTOjuzmj9upUNuqDWd2OMHG+F9EE+HCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9SoZHtHDTeMFkGBoQ+Ouf6OWHyPouexTA3xDjsVTsw=;
 b=P5IklGfM94vnGH/6Y5y47iZhvASHQ16Efo1/4GwIC80WLmTCToiDe1brdsMVh2VrofRyXI+UMocSx9YWxYwLhFSmO2WuLzFQ34ScONUXqitgU2AUYVqJEeawFIdbVyf6O1Ye7WoxCrQ9JJ1FZexg6IO30v2NdNi2jRXmzeDr7w8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 06:48:59 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:48:59 +0000
Message-ID: <e8c11699-459d-41f4-8af6-75a70e82d12e@amd.com>
Date: Wed, 16 Apr 2025 12:18:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fixup boot failure on nvme-pci
To: Christoph Hellwig <hch@lst.de>, hare@kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20250414120509.49638-1-hare@kernel.org>
 <20250414122616.GA14884@lst.de>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20250414122616.GA14884@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 69945d56-4872-491d-96a4-08dd7cb2c3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1FQd0k0RVhmcThnOW5RSjBiem82dnVrM25YejhwM2doOGpCWWtaMTNpN1Vh?=
 =?utf-8?B?bVMvRHU1V0RJQ0E4TmJuRFZpNW1HVlhOa3NPRTcvdno1UU56Si9FYVhMek1z?=
 =?utf-8?B?dWpHRFhhenlDZGdNYVRLSVRsemc4bGFYa3I2VFVoNE53M0t1aGd4eUJkSnZp?=
 =?utf-8?B?dTIxdlRpdTBqK3I1U1hZL2JKYThSYWRYbjZSVzFBM1dLVytBbnV1R1pZZ1pX?=
 =?utf-8?B?RjlFWkcvMVpkb0RFOUdkNklkZmg4K29BRy9xVjJxSm1KZHFRcGt1QXZ1ZUhL?=
 =?utf-8?B?eTgvR0trZmVpQkViZkF2RXhkWHdQTGNBcVRCb1FGc1NNdzd5SlFIZUF5Z1Ew?=
 =?utf-8?B?ZFNZSGZkTVZOVFY5cjhublhNT3FMUUNCbU5sL0VVVE5hY01jZ2Z6RXhrN1Nr?=
 =?utf-8?B?NjVHaGVRaVFHNCswVWo4akNXQ2dxTW1GenlxTmFhRmJTb1V6QnBocXIyRVVp?=
 =?utf-8?B?RW5wUkFvcW50akFnK0NJVDZIdUZCbDZHd0NyY0tuQk5YTy9ZdW5qcXRPV29a?=
 =?utf-8?B?MUFOUVJPdE05UVhoSFpzbHQvL2FPamRSV0dyYy9OcktHdjFCazZweDA1blVl?=
 =?utf-8?B?WWxreDF1UEV3NGFVZks3eWE0YmtpWTdtYmtQMHAxMEFsdElqTGhJYjB1OVNT?=
 =?utf-8?B?Q0JTdVZZa1ErMW9aUlR5OFNURTBFaUN1Myt1cjRRVGd6WHk3MmptdXQ4RldZ?=
 =?utf-8?B?YWFOdDhDVm0vZFZhZFM5MHc0bnJ4bFA2ZVRMV2E2WkdncEJpMFpaVDlZRm5l?=
 =?utf-8?B?MUEvSk85dEFuZmJ3dWY4cU8yanFwai85dk00R3VlSE9aOU1xemFwNWFqUnA1?=
 =?utf-8?B?SXkxNDg4WmdkdEp2a3ZNSWIzWWxDem5xcmNxQmxVaWdSbXRXUEhuVk1lcFpa?=
 =?utf-8?B?aUYzSHYxRSthL1cvblRxTWZMc0NlWXp6c1JYWFBtNHgydnlVWjA3Zk1wSU84?=
 =?utf-8?B?RVlMeFcwUWpCaWNSVU1SRTRBb1UyOU9IWnNTRmtjemtaazFadDhLSWJJdjZJ?=
 =?utf-8?B?QlByUmxOYXZlK0xFNHcyeUhKb0luNXJ5SE1qVU8xcC9XR3ZseWtQaWpzVXJ0?=
 =?utf-8?B?UDNEdEdSZWtkVkZiYW5QdTlqcUkrQXY1OGlncXdUbXd6cHgxMCtTaVlIdzRY?=
 =?utf-8?B?SFkwOTFYdXR5UmtNMk9QQndJV1RnNnVKelRkZjZQRUZrNUI4REVkSkl6dUcy?=
 =?utf-8?B?MnIrSTl4cGR5L3hrWXNXRjVTWnFJMU9iT0V0NE10NHUyNDVzUWVUVHowQXdY?=
 =?utf-8?B?amFGRjJDS2hpR05JeGxzU1F2Ui95ZERrdncvOHF4N2ptQnc2TFh6OXNuWTdN?=
 =?utf-8?B?LzNMY2xxQzNseWZ2cXUrRmxMTWh4RVdvQVFVNXhESmpjZlNKYnA3VkVUWFda?=
 =?utf-8?B?MS9QSkVHK2k1c3RrSDVkNDFrczJudFBjYmZnYUVDNUN3Z2gvNUhMRUYwczRO?=
 =?utf-8?B?UHdXU0ZndEc1V2NPRU13NlBFWmJOQllPb0d5NUJmRFZndklVa09XK0hOcVlR?=
 =?utf-8?B?ZmpVejNPZEwzSHJRQ0txU2ZMNm9FV0FWMTNLTkJQUjN5V2REa2pURnJhSUlt?=
 =?utf-8?B?K28vcjdqUU5ZVlQwY0ZwdlIxbnNocyt3WERTRGJ4eXpPL2pBaDhCdXZsa1Mr?=
 =?utf-8?B?eEhzWGFLalg3c3IrOXRJa3ZJM0taYUtxQW1VSkFhbmhuem1JaXR4NW1oZzM2?=
 =?utf-8?B?TmVXKzBieElnNzBDQlgrUmF2MktVbG5YTlMxTGM1aWxVUm9qaUpFT25UZUpr?=
 =?utf-8?B?ZXh2UEd3Q0tVelVFbTAyd1Exb1BEM1pUbkMwamhqVlAxWDVoMTFmbzdnWmdN?=
 =?utf-8?B?b2NYQWJvN1dkMUsydUpPOGp3VE9YaUJUUS9XK2U2VUsvWUlRWVhKdHVleDVh?=
 =?utf-8?B?T29NUmlOeHY3cVp3ejhnak5jWGMwOFdleVlESitSVmNLUDkydG8vS0d4OUlK?=
 =?utf-8?Q?ZtU79almtSQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRVd2ViL2dySEhoNVZlbUtuYmcydmVaOUpqL2dNNkgvSEtxQ1B6QzZPYmI4?=
 =?utf-8?B?NjJ2VnVLVldUdytSMEFFelpkZkEwdTlBejNxaEZVNko3ZDYxYWpHLzVRR2dt?=
 =?utf-8?B?VkEyNDIrNjFvTmFjWnZiRHdNMjhVa09qUXdvTENnNDNKQUFiTWFma2RxUWRL?=
 =?utf-8?B?RmFQVXgzQzU1SFdPNkxWUmhkZXZUNEEyOUl5d25RTG1GeG5uVXhiWjJxRWlq?=
 =?utf-8?B?RTR2YW8wNHhjQlMxMSt3ampxdzJxRjBQUTh5UElZS0t3WENtN3ZzSXFXeTA3?=
 =?utf-8?B?b1FFRFpmUXhwRWlyMUJmMVo1TkhkR1RsZlZDb2NVaERKSFk1dHZFYlllRXpO?=
 =?utf-8?B?KzJzSjJHYmN2bGdLQWpQc0hqTEVSa09tYUlBdEZEZlZpN1VleFNRcVRvUkZX?=
 =?utf-8?B?alZaZFBGVDA1VUVieUtMTzZic09CWERIUDJHbU5ybmg2UmdxRnd6L3BVQVBj?=
 =?utf-8?B?YVlaczNCRksrYS85L0VLNDZiT3lENFhuM2lHYjdVT1NjMkFxaGFubitQdmk3?=
 =?utf-8?B?T09oZjdlU0lwb0FpSGMvRDREZnh2Q0FMUDBEOXhRM24xSy9rUGpoaHB0c1VB?=
 =?utf-8?B?VDREMzFtSlM1MzRta05EZWNhY0IwU3BJem1RSE5jZEFFeDArNDcwQkVHU1lK?=
 =?utf-8?B?SlM3d0tsRFR3NFlHK09nOUtJN2JpZ01SbG1wK3EyMFI2TTdpNUhnRjc3MU1Q?=
 =?utf-8?B?WkxhOTJKekFNMyszUEVnbmRhYU5NeVllNG44a3FTdkNsbFZLdmFENVVvV2VU?=
 =?utf-8?B?dmpXSisrbFB1d2FkM2FQK1ZTV3M4T1Rod24vQW5KMFFlbkYzZHQyd0xJUjBE?=
 =?utf-8?B?b09ETEpMUUc3dFdxRmxpak5XUG01K3RyMU5CVHhWQ1U0UzVrN0hCMllMTFJV?=
 =?utf-8?B?eVBmNkxFNmoyTG5FMzN3OEFYS0lyc1J6V0ZKMTZnbGg0VUF4Z3NuRjJ4ZUtQ?=
 =?utf-8?B?RVlVK3FWZVoxT3RVdHRHYnRla3FxZ0FMLzYrY3h5TVNVN2RXK3QyUHpkWE83?=
 =?utf-8?B?WGhTckxobVZRcWlHWUdkZmk0NHc0bVRXMzBzcW9HT1VhT3EwUDRNL2Y3MmdJ?=
 =?utf-8?B?VFdMVkR3Y290RmR2UUJOeVhDTEUyNUV4QnVNc0FBRFlDQzVwakVFYWU4czVu?=
 =?utf-8?B?aXY0cCt1aloyZlBXU1l0dHJqaGhNM09YZE03VTVLUDdSeXNDcSsxaE1RbEhm?=
 =?utf-8?B?QTlCWXpCREdveGljVDcxakdIc0JVUXc0dGhyaEdkMkE1TjJVSXpEZ3RzY3F4?=
 =?utf-8?B?R2U0SnQ1NS95Zjh5aUhCRHZxWUlEK2hNUTlIRjVqQzg3TWNuNjFOYmxmb0lm?=
 =?utf-8?B?aTJyUGNZVHE0ZnhQTEhtK0dlMktQaU1sYlkwbEpuVmxaSlErWjlSZ3luVnVj?=
 =?utf-8?B?NXdtWUJobjIwNDFNYnlZcU83ampvbDJlRVdpM2J0N3FmcVFVV2Z4U3pEcFZY?=
 =?utf-8?B?anM1OUdRblZTVk9UelZtd0RYenhIZ3lncGVPdG5vQ3g3SXBWVkVjRnhmdHlW?=
 =?utf-8?B?QVpVYThhU0xaYWxFd2lTczlWaGFpZkprQXJieE5vQnRYcFV4SmVrQVdhYzRF?=
 =?utf-8?B?bi9ZYk8zQmZKUExJbVhtQU9xRWZkYUJnRDFDOUl1eDZheE9mWG9yZ1RqZHFl?=
 =?utf-8?B?b0sxdzdOMm1mZi9qSVcyQmxZRTFOUnlyTTVDSnIxTi92cW9RUlBVQzFJS0Yz?=
 =?utf-8?B?WE1wSzF1Tnh6NEg3TENpSWwxeGNueTg2Y3p0QlJUd1BIKzh4Z01lVk1sUzRR?=
 =?utf-8?B?SVdTMkNWdUFiSEs5MUw3Ymsxc2JSSnpqQVJobmJac3JrczJhUzFqeHRJYTVv?=
 =?utf-8?B?WmR0dUZLeGpseUgrTUVPZlF6eVB5ZmY2QmZ1bUU5ZHhNY25sM0s2bmxrd1Nk?=
 =?utf-8?B?WnJVRkZlZW5jcit2cUtwR05CcE9oK0p5cE10bXVQdnBpZ0txNnhlanIwMkxs?=
 =?utf-8?B?bVZ1Qndtd2Q4UFZXRnQxL05iRFJ2ZWtoVkZGcTF4aUNSWWU5NmlSaGFxQjlw?=
 =?utf-8?B?dFAwaFdCYXpSY1psNVdtRmU4cGN5OVAxYitGQTJWSkJldmhDQUV1bDFaR0pQ?=
 =?utf-8?B?MFNEd0dETEliZG94ZXFDYmlxOGFSQ0hWcEhVejY2bkp0Ri9BdUZFbHgyRFZn?=
 =?utf-8?Q?Qd9JixM2e7x0XrobLph5bUwzc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69945d56-4872-491d-96a4-08dd7cb2c3ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:48:59.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLHa27njPJjWkkeRP6IvOoDzY0QEFZcyun30oPDtw97EMatbTc1EuKHKCZAs3JC/qmRkpoxsVgkN7wTx7bi6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_234905_564054_66147449 
X-CRM114-Status: GOOD (  16.16  )
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

Hello,

When will this fix be included in the Linux-next build? Please let me know.


On 4/14/2025 5:56 PM, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 02:05:09PM +0200, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> Commit 62baf70c3274 caused the ANA log page to be re-read, even on systems
>> where the ANA is not supported.
> And unsupported log page should normally not cause a boot failure, but
> it seems the controller in question does not handle it well.  I've
> applied the patch with a better subjet and commit message explaining this.
>
> But if the controller handles unsupported log pages so badly it will
> probably cause trouble in the future as well, or even now when
> applications ask for unsupported log pages using the passthrough
> interfaces.
>
> Srikanth: what controller is this?  I'd like to add that to the commit
> message as well.
>

