Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BEEC77B61
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBNaFn5/oASlZP+/eXOOJzueIQjzTtCtVv2WS6Sy4RE=; b=kiWzUH601uAn//qgtpSJLCDvYm
	oRey6jtkgkZEjVCg0e6dqMWiltZScaGMM8xlR22NMbufX69j7ffCallyhHUKGeU1m+8RMgPsba2Bc
	Rz0aguaXVNCZz7+sMU6Q4HqPadZJ20Rx/s9rSDlAV+Bz8tzf0jKqeuc/sZY6RJhkYG9ntppLbDscq
	zqNv5OqWn9+bGxsz6ELfYxUuEt1hnC7NR4gkU9u+aS3VoBgf999zZOHBw1A26TQ3lNQxmRR358UJ3
	/BcC7aySD+fI+zOCI1423jWHKi4a+v+FfAFM8d2h8L8h+STYyN4wWMBB5vnWKegRYVntjtnYkPC6f
	uV16lNSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptUpB-00GAGP-2u;
	Mon, 01 May 2023 14:48:21 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptUp9-00GAG6-1n
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 14:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfYTzKhOen7YK1dz3Td14UBjODKxbKlr+4dSDSP+Obi1D4Ae7ay70OYsXNZy5IPs3XLVvRjWueGdSd0tvhkV6wNJTYYVwNJOC1sL4P8eYAUx0+84gAPj/KYdi40Oora1oNCG8G6xuiwRGhOPjvsPzJ+lWLCOGEwx4P7y5NZuVNEX/Rdvs8/1a2JCMC4f1aJxcs+QcVvy6q+n8e/DnTIvAWdPC2lIZalNW0YWix1O7AzUNZxaZ5fq1+HToM0UDRTnSnACH1M/g0tsdX45EPJo6+9cuwaJTJLENUiDOmTEn1/qdLY2pFzuWx4VFmOgTGEdUNh0mmpJ0FvprgaRzLKWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBNaFn5/oASlZP+/eXOOJzueIQjzTtCtVv2WS6Sy4RE=;
 b=NgSSoUjujYJu2eQcQ+ZYXwq/9a/8bTl/Qjnayt5PmFeIoH9criHsKK0qaEIw5nmKxd1Oge3lCNwWkJUjIQoYf4hGo9aStcE/7NrSy5RjzYRLIkIPLRzk9yRZ9c9EbgcnoZJ1u94PBho/I7EKXiGq/Z1i2y/Po5p3qzFuieAnydOrXjrSIrfZOX/zONiFG116BKc78w/umHg9wJiS8SSBYZmoZm745dG0x8Ze5rBsPveB69heZAFqxePArr3BLgqwv8HJrjuyKkH2fIXL6dyXNhYzkf5wBePrgAvbomK7xLwSb0WKB/CY+b7tF6PV+lhYMxIErVQP5YefHWMPqLoioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBNaFn5/oASlZP+/eXOOJzueIQjzTtCtVv2WS6Sy4RE=;
 b=JuPBXY1KT4dEk6eWNNJ4fEynh7f1kB2mqm5EU+dj/TnyUmMIRtspMFCTs78/JPCfsGzKDv+dUGsi/aT7jOpnCoL237j35I30ATzud0jxHf08hkZw1/yoXGx6ZQQwmFGkQYh5Id2+aPRgoxG4iYtrnsLkQbaU3uNONxarrMkJPcGDeX+ij5Y9IZ6nPcYbUbzPv65nr/gAHLkV3rLOpjxrtiuyYlfffp0KWzcKPU8z5k71uHRnMmZFnZxRGSxDsoqXEUI0wskBePgJcltmu2wyGFHT5Ci1LP3ncgs1L8qBrJ/I9S3tRTTrnn7GJWE5e1IwJiGKADEl7V5Q1/L9JbY0pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 14:48:12 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 14:48:12 +0000
Message-ID: <9e503b24-6345-fabd-be9e-1120226a17cb@nvidia.com>
Date: Mon, 1 May 2023 17:48:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] nvme: move sysfs code to a dedicated sysfs.c file
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424211242.19614-1-mgurtovoy@nvidia.com>
 <0ad22261-6a4e-4f0d-eedf-04dbf2c483a7@kernel.dk>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <0ad22261-6a4e-4f0d-eedf-04dbf2c483a7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7731cea3-4e8e-4ce3-dd39-08db4a53160c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	GMF2dcWxrE4v9KQXKS/6VGZ8APFtbVbQTuVtKN1m/oZsNDyk4uXrIKzZ5vEu6RYQAy5XBqgUf41J/J9yU84PHR2CJvm///E27WPvYyZQ6i6uBhhd9LDt1GDgyZwu9stdIckodqKRoXJn6Wy6/A9mlKsOB0ld4w02MwnfcEBoXrUr2r6HEgxa5CDt9wnAtQCJc2an3wAjxJVkEzpWU9kBQjEK2kiTaECEjghYNz6A1XJd4PsF7rEV/FzDpRb3qMo5d7OKCPKi4dKHWtLNz9o7EZMxsoqPXRtyqb0TuDZlaBXmGUUPaCNN35K+ovj/jCLyXSthZhNdQCDfoOpDWkhOHq17uR2EgrC0Q590hwqz89OsvCIssq8DjaezKaq4vPbp0ZiRn4f2Wzzd0cJkXQysEdWg5tSH3kRN16ksScwkCDgnWjQe1yVPjgIqBthfkM3fAfKrA45uBrpGMzsRkQTEZGDSTXzrnv/5fZH+3nMgMW/2QF3W1lOKG+ZpPy9andKalCfbeWutgdhHs3EpERYp/dhaBqmm/GaAlJXjiJIE7P3CxC85DQHCzSqEJHEbd55NsiO4e9A20aCwq4VFeERXjKxU3kazS4Q04MFlPF5G/B8xnuY9jp1C8NojZ5hqWB+fJsetggv0HQ2wH4qxRHattw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(2906002)(4744005)(6486002)(6666004)(5660300002)(4326008)(66946007)(36756003)(66556008)(66476007)(8676002)(41300700001)(316002)(8936002)(38100700002)(478600001)(6512007)(26005)(31696002)(6506007)(53546011)(186003)(86362001)(107886003)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Mi9RUTFYTGc2eWowTmFHbjBTSlJMWU5IbThTcTJyVmFDYXRycFU5ZisvVWhM?=
 =?utf-8?B?bXZVY3VkQ01XR0VVbmVyNldPemtSUlF0aTdEcFVTMER2WVMzVFJPS3lkUnM4?=
 =?utf-8?B?Tjd0bHpkVHJnT0pZNzhvc0NJWU9yR3FIeGxhMWFBN3kzSXJoM1VCbkc0Wm8z?=
 =?utf-8?B?VkZUZnhFblVDTzBiTThwdTBqQWx1dGdvNjhYWlo3RkVQdVFpdWRSSGFJbk9L?=
 =?utf-8?B?OUdJRG5LbWg2a2dZL2JMdlNQb2haRkFqR1dlbWtoTXB4YUxONVl1QVhXamdk?=
 =?utf-8?B?amJYbWpCWHBzVW9LbklzSk1ZcFllL045Z0x5Q3BFY3VIcFFVRmNJdXZGSnNq?=
 =?utf-8?B?bXpiNUNDR0xPd25TU2kyNW83K1dFMDRnL2ZYTXdPQ08zWWFNY3gyQ3FuK2pW?=
 =?utf-8?B?WXpkbWdkNmlac29ackhYZkFQMlFVaVY5aUgzK1NDbWlwa2psdWl6Q084dndr?=
 =?utf-8?B?Lys4NFlqRVloMFEwaWd6WnJzSUdiYVE4NTJSbFpYdkQwcFNFUDlibHdHMHZ5?=
 =?utf-8?B?SStnREtGTk5DcmkwMWszaFRlWDFQNkJrUjhOREE5Tlc5cHl2cjJZekgvNmRj?=
 =?utf-8?B?QUpwQW1taGhuUm53TmNaMzR3d1ljTTJTcFVsYXAzSmtpcmt3bTBVY1NBWnZC?=
 =?utf-8?B?WGZ4RzJNY25OdDJMKzBQMXZOM3YrdVFadkZZL0M5RExqb0QrT1lwZUJ1QVBL?=
 =?utf-8?B?NVF1VkdOaE5WUGtwWXNiZENxSXVMcnQyYUJqM1E4SE5HSlhWdFVQOFhldExR?=
 =?utf-8?B?UHZGdmxzZXFzYW9iQ0xYbWJxaTRJcHZMTlRQK05GTEg0VjZPK1ZoMDlLazQv?=
 =?utf-8?B?YnQyTUxCUnF1RTFtTkNDZTAyRm81ZlQycHlsNU1iZjFSSmlMbysrOW51Z2U2?=
 =?utf-8?B?UDVQL3paejJKaVZZNkJ4bnRvN2RqeEJxdjMzdEJ2MTlDNnlRblcycnFhUm80?=
 =?utf-8?B?eVd0MGRCbFR0Z0VQcnBoTUpldS9IVHRENW5Eei9sOU91R0tYaDdyQzVlVG9W?=
 =?utf-8?B?MkkrTTFPZ3UzbEZUeXVlSW9OdDJFM3VpbXRYa0YyU3pKazQrMHdXVXEvblJj?=
 =?utf-8?B?L3M1dnRPbTUydDNEdkhuTkdpOVNQdzM0WE80ZDkwa1Z0TGcraStWZHgzdVo5?=
 =?utf-8?B?WVBYQXpLZzFnMmxvYlBKUjN1b2RuQlNKTmJjb1g4UmxhVkdxZzRFa2FyenZo?=
 =?utf-8?B?L0RBaC9jaXl0eWJIZ1hNVHNJS3UvWnRycGRPZklOSGRySFJ4TXUvNzNjRjFO?=
 =?utf-8?B?aXZnanZDTXg4RWh6ZjdhUEJ5bGd1NFF6UkluQkJhZTlFL3VxZko4bGpyYmk1?=
 =?utf-8?B?eDBoRDJzUmhJUnh5eEJJeGYyQ3FPSFNlcE1jRGQ3dW1VOVVOTFlLM0F0TGJ4?=
 =?utf-8?B?dmFmZEovZnZDWUpUTkFBcDVNaUhsTkl2Ylhxams0dSsxcUtDenlPc21RaXZQ?=
 =?utf-8?B?VjJPdUFBYTZIOHhCVmJ3ckY4UGpkZVBIdXVnK2tqc3NuK0QwRUE0TVB6NVVw?=
 =?utf-8?B?MXVhSUZlck5yRTZZaW9SektxZFhHb0JWN1d5aHVLczFGQ1QybVRBUkNaOEI4?=
 =?utf-8?B?VllMeHdrd0ptdU83eHErb2M1YUo2eVRUdUJPS3E1TDF5UWRQYjdXaW5sajB5?=
 =?utf-8?B?a2FRbEFMbGdsblU2cEVnYWd0azl2eFFXeWxaR3hGWCtSMk9PaHc0b2plOFQ2?=
 =?utf-8?B?NHdUUTJmZ05RTVFlY3UvWTcyNmpqOEMvWUVxU1dPQmdIZ25RVzdJdUxrRms0?=
 =?utf-8?B?Y1NEbVZGMDF4SkhZY1gyQi9wZkt4QXRIcStsb2dIZUtaNytneVhVR1JuZzBw?=
 =?utf-8?B?K3dTSVVyS3NwdElKU05pOGJUNVdkczYyN3N3TTI0OEwwcWVTMnl6QnRtb3Z4?=
 =?utf-8?B?bW1NU1doaW16a1VPYXhHT1hXVGxUS0JPMThKaW51U1FERlVQeFFKWk1DaE1I?=
 =?utf-8?B?NUVSNE5SU2dwSy9TKytzODV3OFZ3UWpzNmRoNDVhaS96QVp4aGQ3MHBCaWE4?=
 =?utf-8?B?QnNnNVhpQ3JrdTRXRVBUS0xXaHBkUjV5ZjZNLzM4cUYzZUtIVnVYQ1VNbzg1?=
 =?utf-8?B?WHIvVlp3RkRXQmNQMkszVC91c1JCdGdQUzA4SGx6K0F2TVlvMkRQYkRoZmZJ?=
 =?utf-8?Q?ZdyDaD8K83uglRi9elNMXBtJs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7731cea3-4e8e-4ce3-dd39-08db4a53160c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 14:48:11.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgjbL29kcAegD5tCAG5QT1YPMHJQ2gOnrzalWcHVB+zRlKPXJcsBKvNi/gipDLeEOn2+nWwDDdOsQIkiM/h/YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_074819_624555_97D62DD9 
X-CRM114-Status: UNSURE (   9.08  )
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

Hi Christoph,

On 25/04/2023 18:27, Jens Axboe wrote:
> On 4/24/23 3:12?PM, Max Gurtovoy wrote:
>> The core.c file became long and hard to maintain. Create a dedicated
>> file to centralize the sysfs functionality. This is a common practice to
>> separate sysfs/configfs related logic from the main driver logic .c file.
>> For example, in the nvmet module the configfs interface has its own
>> dedicated file.
>>
>> This patch does not include any functional changes.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 

Is there a chance to merge this for the next round of nvme PR ?
We have pretty good agreement for this patch :)

