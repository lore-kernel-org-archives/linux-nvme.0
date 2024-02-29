Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B9C54E41
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1wiFOOB0vodd3ndWJyTY30nJMVnCIIJoDLddmW2DfQ8=; b=XqpL0YSYg6aApxAmI9fHPx9Isp
	Svn69/9fgX+TC9upPRSNnfXjKL6qCqAMMz1uyqB8LSCZ3wOZbdcpXYRBXvKr4oF/kttehBOH8986m
	yc9Oaf1LpaNLZNLWacFFaOGevRUte8LKXzAgXuND9QgmMPWfL6Ep4Px020zAzK3uydA/qMZN6WqP+
	rDG7hPpZUKSZV6aSbbyS9Le98wpWzjioHq7MkvnRkV30QxEJHYfd+oSO+wJFXBPFLUpWf2WYH4l67
	giHPA3oxGneF+r0oyQ5hOPGIPT4P+eBS94ejnXL4CZrerNGVWcMbJ5KWkfYvK7lWXJODFwbr97oXW
	TtJDyaig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfg3q-0000000DaSi-2YNN;
	Thu, 29 Feb 2024 13:02:54 +0000
Received: from mail-dm6nam10on20624.outbound.protection.outlook.com ([2a01:111:f400:7e88::624] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfg3n-0000000DaRp-2cA2
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 13:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X86MooohPXPfJ5Ar3U8k58A18h2VNUtcNCuPxvXa4ujBlXPB8fKAyPCztRerzte0wJL3w1UxFt5+tXK2PuS/AaJYER6w9DrJhcilnZ+j8xyxvQCx0D/cLW8ENp/3aFpM+reLUicUxBWX+a9P1pIyTsS13WFI9+iaUzBXPG0zzQ7OQ5/8+Hzb9pL1BHwkjfUxCQReBxyfTpOv1d6NTt64jiOGafDN46Bq+8GZQyVN7tYEHh7EqHAY1RrfARIYbL1mbjriVnmYHr9a07t4tZJOZo7nqgiSFD2rLfHuSdeTxY4SGE754gLCGuYXhYKZRclxa3e4UkA/nLOk1ehRrdMamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wiFOOB0vodd3ndWJyTY30nJMVnCIIJoDLddmW2DfQ8=;
 b=BXEXdsOc3suULHmHMlSF+Z8WEUWtpX8NliAsdY7ZRHYm+BHTBc2vtXb1bRNJDJ/4Ls1DP7hIHkXAHCk5SIWr1DOd1g3E8u/GugG4fY9n+mbHhA16zPF0qgQJUWUT4hmH783TEf7NwyjFe6Mdvm767gN3iU+xaxODNbP9EZ0PwDlmwI8qsGj52yPrc+oQ3Gm26cq7G+dhcq5XOEDGFqAGZ0LfYC2dZppQMAsI3dcRRlGva+qImmSNwdtc7q5AuKeT8wRw9RW3nKzMGRD4P9lHzvbymKEVNxpw2vxZY71sySxK2OtIjjEG941F/EPwzDTKnyo04z1mkIqd5o+9ej3fQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wiFOOB0vodd3ndWJyTY30nJMVnCIIJoDLddmW2DfQ8=;
 b=cj/Ul30EdlVxgDusUn399Ebadzk4dUP8ZeCIxFU0yvUwypVTwO/Ix+LWiQesBcGIVpVwV3MLi5Gcc0qNUAEmIKjnEGRYugovERJXXoYiEMx8olFqBjO5g5YuZErpejn4OktqvCdrY7AVZo8JxI2dVd7yGoD/45h4w2CD9EXir0dfqD6DGKFrwwtfbVyyQkvTmqwc+sPbMKKPU5dqkDmxa5H/EX51PPeREzhphnp96PRGBYPD3Sl2OoeswRm2yLy8KxV1joiWDPSB/sB5LyLQjxbBzgW0nIHbTY/fLKs5YK4WD2tlxP3QS7IQusrEteCCKkouy3Y7CRePKgsRWiqsDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 13:02:45 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 13:02:45 +0000
Message-ID: <7ae0cc72-d0f5-4c2c-9bde-bfb6682d1d0b@nvidia.com>
Date: Thu, 29 Feb 2024 15:02:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] nvme: don't use nvme_update_disk_info for the
 multipath disk
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240228181215.873854-1-hch@lst.de>
 <20240228181215.873854-10-hch@lst.de>
 <009a747a-0c56-46cf-8cc1-1b66d9b2a5c6@nvidia.com>
In-Reply-To: <009a747a-0c56-46cf-8cc1-1b66d9b2a5c6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0568.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: b30e3073-5b79-489a-9433-08dc3926b8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 078Zt5p6pRdiS0iL7bCYdVuNvh01YjSKuUKNuFDCVT8KKGt3QpHNscAuijkT03YHDtLBeSzL1XZJ4pCmobUjdn4YPmyqc9UxPIyGhQdwnWUuayC9G9LtGrO/LOdvTw5fk9Z6Ypx47Dc/ZGwQFrUo/R4lIUhqZt5GEkdQHmmLHb+aoY70PgMlSBKZBYI+jaIBXNzZRUYEHQ6lbV4/f3DVzC7WRoHbp1rxsnbKaGqfFoFHMG5OaEcrp4ZejJxoIIfIav1tjHUIeetFkxAHYyADwE2n9iXS8+oRCBLlGsoQB8wCUzltcyqd9ZmDSszEdWTTc3lygqK/sAvohmYCTxRaXjogezYORlutuiFk6cnOj1pawZFYyKASLah8JFNZAlqWLqt8rFo6Ri3ct/3uwxQzWsnufifuOZ+zK9cCx2Y8Hx2ZU6aeGfiHz13gRkLs36LXRvlUmpcygvJ1OiExjRX3StNw540bWAYwc2pefvMe1vlLSTGLrZPT/CcHW7eoXCxEpWrHKvH8EG+bpRSrx4x8DohmMTOajdY6RugbodPNalCBMZexGXCqF5Af5fiH9LIT/UPwJMPXKsggfh1uDJ225/nUwyL97jdPed3nJDgJ3MVAJWeKhOqrMEO8q4PVMzcVtf81n5nE7gOb4LVXvq+ZIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVHWklwcEFxUHVCTGpSYkd2T3FJdWJEY0lBblpnSjRlRUpmYW1UTjNxMlEx?=
 =?utf-8?B?WndGTTZwekg3UG9ESG9DMUh5MHhORklITlNCNHdrTkhsS1o3RytZb0w2bUlm?=
 =?utf-8?B?L0R5S01COWRPSExRNGw3L3BWVWZxR3Yrazl6YW5WM3A5Ym91YmVrVzlmckdM?=
 =?utf-8?B?cXNPS1VHYndGUzBIcnQ0TDdIeGlEUFYwcE96dmlycWN3ZTNVLzJKWFRlNTFM?=
 =?utf-8?B?eWFBVk10QkpsSnZmS1I5R2RJdkdwTWxvWnVlQU9oNFZYVzY3N3FhYkQyZFB2?=
 =?utf-8?B?SHhPbklvSFFZZXdDN0I4aG1xcHRwejZuU1lxRVFjd3F3SURzanRnb0krRDFI?=
 =?utf-8?B?QUcxSmJNbUxyMjRUajZaS3RsYjR2aE1OUGVkUGtObURvRXprQmVHbDNUZVA5?=
 =?utf-8?B?clRtSWZ5eGlBOFcyQkhUWFErSU43WjVEYmRQS3YwYTRQckVXczJ5bG1EL0Zk?=
 =?utf-8?B?KzkyQ1ZGYnJIbG5xVkdTWWVKcm5GdHNhSUgzRStXQnJqakM2a2FwdnBrODJC?=
 =?utf-8?B?Z0lkOTd6UEtIbnBjSUFieDZBbGdvYkttNG8xbFNoYmNSZkNPQUxXYUFKSEtZ?=
 =?utf-8?B?K052U3ludCtIS1dnTUMvLzhBNmVUZ0ZIbHdSSVRlcUUwbHNSd0xLYXRUZGcr?=
 =?utf-8?B?dVVSY2FoYXdMRTlyUEZkSkppZTVtd1ZZaXhzNTl4L01ia2I0NGh2ekdzZm1U?=
 =?utf-8?B?TGRuSFg0S3FMUHJoZ0k4b2xZQXorTUJSc284aGZaLzhjYjVBcWNZMjRtMm1p?=
 =?utf-8?B?Vy81L3k1SE9DdHltK1doRU1wSkNxN2JwelkyeUdVaFZPTllqWWlPaENOeEFT?=
 =?utf-8?B?UjBBT0pjOFpqUGt4K0RubDI2R0RVTTFiUHhlUm5iVHd3Vm4yZGNuYnZQSSth?=
 =?utf-8?B?djAvY29IdEZmNS85N1pNNEx0RTkyVmN6TnAyMTB0aTFnc3k5YklaZTZtK3lP?=
 =?utf-8?B?aWRiVDJseGlGUUdaenNyQW9xOGp0WWtyODR0dyttS0RpOHpRMnVFMkFFZURZ?=
 =?utf-8?B?MkZWOG5LbGpJWlFQNHdvcmZpVGVjT2FxbUlxM0NDdVptKzRmVzN6QWJTVnha?=
 =?utf-8?B?bHI3OGVidVUzNUt4Zk9vNW1WaUFUU21URTZ2Zk5Qakx1TFE1WHROcFRYL1U5?=
 =?utf-8?B?S0ZvekN0YW9JOStVeVIvYytIZEJjemVQWGQ1c2I5SFFqRktxaUNNNjdyZEQy?=
 =?utf-8?B?QnZvK0loZmxtdjBGQysxbGhSVG1pcndEUkhUREZOZnJQVis1SHFmK0NxSUVZ?=
 =?utf-8?B?cEZaRDB5VDMveDAzUTEyYnB6T24vNitWZkZneDJWakhUb0dUbTJ4QVRlWUIv?=
 =?utf-8?B?Q1JZOUsxSk1TN3VJVWZJd1U2bVRrbnhjYTdvNXV1YWVLSDBDNnlMUDdhV2lm?=
 =?utf-8?B?WDdNMENjcEEzRGZ2dHFSZEl2dnJQc29UMVRBbTBhR2pkanFpa2lnSk5PbGVW?=
 =?utf-8?B?V1FlOWlQVWlBMjNKcGEwdkRIbDBSSmlXT2p5TGJRZ1pJaS83ZXExUFMxWnV0?=
 =?utf-8?B?QURpUzgrZkFwTUd3OFR4TklkbUNJbUZFM3A1WTY1OHhsdWFEa0J0cEdkcjhn?=
 =?utf-8?B?SGRVQ1ErdkJUY0RtYWNqSS9CZmxZQkZRZWJCaHQ0NnlPWU1CK3lWamRkNUNy?=
 =?utf-8?B?ZU5OK2tMZ2k0UDE3Z3A4U2Rjc1ZmTXMwVll5VHRpMGRUekwvU2RsYlZSRDlx?=
 =?utf-8?B?K25GOWovUVhtTjlnS3ZaaDBZN3dob09ldzZrb1pZVWgvZkxkUDN5YmUzZFR5?=
 =?utf-8?B?VmwrdURLbUMvdWVkNFZPSVZKb3UrZ1Y0OUdpcFdxMFp0TE9BN3dVRXc4dGNF?=
 =?utf-8?B?QkhlOTN5WTFobDFwejYydzhLcmNOUHVhanNhcWpRSWJKUmRaU2l6U0V6YVNF?=
 =?utf-8?B?dTRiY0EwL3RucVR0K2J6R0x5S0ZrbEhKM0FZN1NaT0JLWk1rc3A5TW94SFlm?=
 =?utf-8?B?amNNS3NBZUNUQS9WWHBmb1FUWGprVm84OFoweGRtYmtySllCeWhvdmdHSHhq?=
 =?utf-8?B?MGFaWFBLbm5NVmNCSi9USEVueW9JbkVJNExJZzVlVzRYc3BlcEdEeGd1Nm5q?=
 =?utf-8?B?emZFZnRBSENKS295SUYyRTArdzRSQkFkMm5WcTZEVU40VnUvMDExTUM4L0Jo?=
 =?utf-8?B?MUllOExiSVVpMC8rMkVyZkZHVVk0UCtLaFJrUnNPc2gwZkIvTnlYT0x1US9O?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30e3073-5b79-489a-9433-08dc3926b8ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 13:02:45.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m05G14TYCSLCmYDXbmTXDEGSNmSgLe6IsvBmKmhgZTmjseFhPZ8RZq84W9jVH/qbY7QMNEPH5xHnTK+V7PVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_050251_694568_99E16D9B 
X-CRM114-Status: GOOD (  16.76  )
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



On 29/02/2024 14:47, Max Gurtovoy wrote:
> 
> 
> On 28/02/2024 20:12, Christoph Hellwig wrote:
>> Currently nvme_update_ns_info_block calls nvme_update_disk_info both for
>> the namespace attached disk, and the multipath one (if it exists).  This
>> is very different from how other stacking drivers work, and leads to
>> a lot of complexity.
>>
>> Switch to setting the disk capacity and initializing the integrity
>> profile, and let blk_stack_limits which already is called just below
>> deal with updating the other limits.
> 
> where does the blk_stack_limits called in the nvme/core ?
> Is it part of some preparation series ?

please ignore, I missed the last line in the chunk..

> 
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 105046a7957272..0bf30580f29d5b 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2159,7 +2159,8 @@ static int nvme_update_ns_info_block(struct 
>> nvme_ns *ns,
>>       if (nvme_ns_head_multipath(ns->head)) {
>>           blk_mq_freeze_queue(ns->head->disk->queue);
>> -        nvme_update_disk_info(ns->ctrl, ns->head->disk, ns->head, id);
>> +        nvme_init_integrity(ns->head->disk, ns->head);
>> +        set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
>>           set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>>           nvme_mpath_revalidate_paths(ns);
>>           blk_stack_limits(&ns->head->disk->queue->limits,
> 

