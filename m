Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB31BC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 16:00:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6839C61164
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 16:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6839C61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ClWQezg+xDPFTQQhdr33pXJyVy1wD7GKGSy8MpvcQdo=; b=QEoOACo8ckzzLQ/oK4GW3f8YW4
	DRARdX6sX+CkEBOw/JEzDyrviedSIOk73Exy7nlHq0nbRJxEH0Kzmg16aszWS2BOR+3FKKRFmmYuy
	l4DJFf3hGog6c7wugg7yE0bAsxgK2XuR3aG3CWMxdYZ2hHOkoHTVKJAFHly054e5HwN9P2FvMf/3k
	acvgwa8nFl+r3GbCoXOMGTDY/d5R61jheABknhevA0CsMw8xA+8U8Ms5GnSaR2w++zDBlIa7NC9DY
	lF+AEDhXvu2+Sr+1sseO/ZWNZbfDY4DnDQKtsHxaWIKusnAf+nJe+7gKXTAXxw3Ownz9yZ0H2Qtu8
	HOx9+sRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltXxq-0071vm-UX; Wed, 16 Jun 2021 16:00:27 +0000
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com
 ([40.107.223.85] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltXxm-0071sa-W0
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 16:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8DrF7JpDSwIbS5TFqtwYoCRXlIzpNhnOkCn8SJq4pWb7OXRAF3vKKljzZYXQT13S/f1CnYgz8CmLWUvWDVFwKiqF27t+S0owgAfyovKdiEJwMM96gCwLm3tP47XsJ1oNJScymRX14KBFHVRt5a4HL64hT61Und1YIsMf0M0M7tXuwRvFORgbuAFMrmqcVSqwT+zJFcXUonANnUGKc4Upu8S/rtqi+CiHFnGDxJnx6OGpHYMoBCN6VKBPWZG7oi2HtTpyCkZdrw+iQ0GTL/hzqiplEMBG1cVSO2fyWXm1Ie4Vo2I1vsgARUzrUlC4MsvWg3WPWek7UBBOoOZ8+74xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPP7F/q5gpdRIgAOFT4s+RBI0ZW1Xmb2DSceLMYY2ew=;
 b=X9wneyWaH5GuvU8qFNefWgB0C+v9lG1XVW2W0VBTM/CzRJ7ZYs7PHhFOysZufKnDAOBbwUQkse1ufwplBp3OV802tDARNrYRSDtFmPaBtxvu4xzXMtCoS/A2XMFLYJo0L6ikkCrE9SZQ6wNy8VkYZmf4J5mrf3fnyNr/3YqkYRGQ0UvLGXEKHRbXRTdHIpKT64Fd7RV3oCqdsfyGVBQcJCytNCy4gwoD6pIDz3LwXf4o2g9/zc6NRE3Z5zzkSlt5DwzposMrz4pTZoBTalmoqgn0gQUP3/Fr5ogX2ewqtF4Q4ZORfdx0d8icIRSqWeb3wQetRXw+Q5Fb4V5137SywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPP7F/q5gpdRIgAOFT4s+RBI0ZW1Xmb2DSceLMYY2ew=;
 b=fiE4qBmURlU1djouV4Ga8zrCpgFp6H4Wm1GQT20fPHcdWx+ihCeNVP/Gp7yJP3jfc0Xs7D43ys1WQhlNenXvUp9kzFPXjVtSdviuUGCNKhg2oX/voo5iDkZGRZd4IpGqfo7iI0Z5XS7iOX0Zy7sM7opgd/nJElYbK4kLIqulCTw=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 16:00:17 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 16:00:17 +0000
Subject: Re: [RFC PATCH linux-nvme] ACPI: storage_d3_cpu_ids[] can be static
To: kernel test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <202106161145.HdBOaJkF-lkp@intel.com>
 <20210616032219.GA70875@d00c18f5cb94>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <854b9bdd-7bc2-1210-4523-9def184b3e04@amd.com>
Date: Wed, 16 Jun 2021 10:59:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210616032219.GA70875@d00c18f5cb94>
Content-Language: en-US
X-Originating-IP: [2600:1700:70:f700:90a2:58b1:d040:28ea]
X-ClientProxiedBy: SN6PR01CA0030.prod.exchangelabs.com (2603:10b6:805:b6::43)
 To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:70:f700:90a2:58b1:d040:28ea]
 (2600:1700:70:f700:90a2:58b1:d040:28ea) by
 SN6PR01CA0030.prod.exchangelabs.com (2603:10b6:805:b6::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22 via Frontend Transport; Wed, 16 Jun 2021 16:00:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311bfd95-914e-470c-a80a-08d930dfd593
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-Microsoft-Antispam-PRVS: <SA0PR12MB455920B662B6520AAE5B09E2E20F9@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yl0rglS366ml7zvxD7aGLsQTlpEjas0Tmluoy4bwHiGonQX1/wh3XE/AmyaQD3nFxznxp0G3hvWLzBnxuhYmm+LSA3ioc5XCf6gD3Hv+eayEl+EDYQG/Xmk1PgHt+AumqOzJQw74uyzQSQF1Ju8OlSdBKeBChQM4Xsvl0Dzf+Pc1LOFxe5aVEq0MmjRySoPUkmNHe17RZsBZxls8tK8XJjHOc7iSSo4kSVAX438hMjMuyQnJ5w1OfY6LtyW9B2yCZtHDs25LXfNhnGMttbWNB0Rh3L8Ez3zSdvjOYOsEUNDYHwSGZHJWTedv9p5U4ub+TLPiAkQMWwZtxZw8NApL2qV9IW/QqyQEdCHnAsthkZRvgH9/D8ssQUJHfHNLqxwZtlMn6RWleqMpBggd6/NsGdbt0u5lWXzm01zrRgwXgoPDY+8Ib/V/GGzHK6wLYe5od3AwT75lSnbitJ6bnaU1GVywyJGF8jkfwGrVeV227zF4aDgwyhjN0JuvOPgyBYG1aaTnmSfLR72u6TbpRyEL2Rz1iEfX0EcCZrr9Gg+61YcE4XMkYlA/6z/QZXbv7tyabVFTKsVMg5u651YbyDxfruGiVUpRU90rVOsj1ZMCCOCBXBTREJ1qOSSNWBEAcUBCR0wTX8pVtSDeL5goHA0G3ltZJ2Yf60OS8cUlf8Rb2eE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(31686004)(66946007)(66476007)(6666004)(66556008)(316002)(186003)(2616005)(2906002)(38100700002)(16526019)(31696002)(53546011)(6916009)(86362001)(83380400001)(8936002)(6486002)(36756003)(478600001)(8676002)(4326008)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVnelkrTGEySkloU0Q0ejFUazZUQi9EMFFvc1l4NCtIL1pSVnFXUUloUStC?=
 =?utf-8?B?d25oVnVtWDBPajFvSks5ZE8vSVZHYnpRK3ZwbERCTEtRckJPK21Za1BPU25L?=
 =?utf-8?B?VXl2Z3VkNzUvSWV6NnlRemVtOHphdTFhU2JLb1J0d1FrWVhSdmtLZjlWTGFQ?=
 =?utf-8?B?QlhYWnRLRU5yTEV0R1VyeHM0Ylo1VGx2OFhiUHBLTURHSjFEK01Ob1NrVFh5?=
 =?utf-8?B?Z2hhYVMwMmJPTFhLc0E0V0VFcVllbGRCNWp2TVRENGhaVW1VVXJKSCswUTVx?=
 =?utf-8?B?SGVrUEM3RzdCOEdWSXB5RDl0Zjg3SndhWUNnYTVpT1lCK3BoaHBMN0t5dEs5?=
 =?utf-8?B?dWhsZGVhSTZ6dXlnZ0VVZUU3bjZVaVlvSWxGZk5FUzVDWTByVVBFeWZOaVpW?=
 =?utf-8?B?cUsrMmFaVk90eWVldjhoZlhERDg2RE5kN3Q0VXF5aWhVSmJkMVY0M2E4eVFj?=
 =?utf-8?B?cDJQWXBrVE1SZW82Qncwc2dXU2oxdjdHVVpHNXdDa3o0aG5NczJQYmhxdGpl?=
 =?utf-8?B?Zm4xamgzSWZkZ2tsMjZzVkg5NnNNaXJweU9mOFhsWFh1MHBVcXZPd0xUWnQ2?=
 =?utf-8?B?dDVnRlh2SHVHNjV5Zk1rQVRJK0s3em0xSmVmUzJWcjI4QWptcmN5MjlaZG9F?=
 =?utf-8?B?YSs1M0xiN0dSRU43NDd5SDBSWTVRVW81L0hMeFhabUJYTndaVXdLTEZPOGxm?=
 =?utf-8?B?RXNpYWo3aUZ6b0FLRVE4UkFqWVVlWVpaWUgzQ2traC9BOUFobzgyL21Hcmlo?=
 =?utf-8?B?Ym50bTQ4ZlZabGdkNGdCNEc3MWRJY1hERDBOZFBYRlhTNlZESmFvRjdFU2lG?=
 =?utf-8?B?QUJSZ3RnRENVZXVlSXNqVDBUcUxaWTMwRjVvYmcrWFhPM0l2bXRua3VVQStH?=
 =?utf-8?B?RkRaV2I3aWUxZ2FzK2FhNjZlTkk1Qzd3VzhpTE9mYkxjMEczditzL2tCYjhI?=
 =?utf-8?B?UnhRV1BvR002c3pxZ2tJNTNaeHEyakZSNnRPMTQzUEJ2cThMbVo3OENpa1I0?=
 =?utf-8?B?by9EWnRVQkZESXBhY1pQSmxtSUVabFFMcStaenVRclRHczhYUDFxemdGN1Bj?=
 =?utf-8?B?MVJVZXVLaENXcGE5OU11NkxncmVtZEhRSFU1bTYxSTVMR0w3Vml1Vy9OVHZK?=
 =?utf-8?B?QXZKeGFSN2gvL3I2QUJvTFdwcXFKV013YTJCSm1OUDl1QTc1VERMc2Urcnp5?=
 =?utf-8?B?Z3Y4aHFEN09tQ1NjRUNpRS81MXQwNlZkVHlVNUQ5NVM2akhsSGhqb0lsYTRC?=
 =?utf-8?B?TU81MVBPbGVOOFJxUFoxWlZmcGgzU2pnSW1nTHpqWUltOVlhM1V0RjFaaVc4?=
 =?utf-8?B?bTMzRWxnYTdadEoxMFMyNXhvSzNqd0tQbHozQjBYbENaZVFMbUMxMHpTSFNR?=
 =?utf-8?B?YllxTkFFZmVhYXpOZVdTUW5BREoxV21tRXhZbGkzQWkzb0w3UWczWFh0UlFJ?=
 =?utf-8?B?dy9TL3pFdGxzMW01ZVN6NlhkNTI3aVBZTlV4TE5yNlRLQ2hoTStzZUtJOFFt?=
 =?utf-8?B?VnBRa3JkV3RWdGJYV2dOTW5UQUdjTFdNVGduWHN4ak1WMTF5RUxkanBDWjJB?=
 =?utf-8?B?S2Qvb295Y3JMSUZnbjhWa1hLK25aaDFRV28vQ1RsZmZ5K05HekF6YVpPUnBs?=
 =?utf-8?B?S29LUzI4VW9CK01pNkxqZEFCbS9jOGsxVlIwSDlFcnpJOGZ6UFM0MGlNUExi?=
 =?utf-8?B?elUrd0E4emo4ZmlXeThmN2dKekZrbmVzSzR3QWxQdHRCMVd3VmhvejBpOER0?=
 =?utf-8?B?cVEwWWxKZUpqQS9ka3g5ajBnZ3JMRndKaG1HTnE3RmdkZCt3K0JTcUZVK1hG?=
 =?utf-8?B?NFpmMlpmOWhzK3d4RXRTYmxueFUrMVFqSVlKNWd0M1VrUWdGalB3UEpqWFpD?=
 =?utf-8?Q?FwcXtdvRbA2f9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311bfd95-914e-470c-a80a-08d930dfd593
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 16:00:16.9561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7AA/9g+arli5PeVK+V2SgU+0uGPZ4sJmo65+yXcTvkdYIHZAcjJVMZz9HPBzMzmZE0v4bcaP23okxJ2ftOWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_090023_077237_70BBF9CF 
X-CRM114-Status: GOOD (  15.21  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/15/2021 22:22, kernel test robot wrote:
> drivers/acpi/x86/utils.c:153:25: warning: symbol 'storage_d3_cpu_ids' was not declared. Should it be static?
> 
> Fixes: 7c20093d34bc ("ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>   utils.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 5298bb4d81fea..f22f23933063b 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -150,7 +150,7 @@ bool acpi_device_always_present(struct acpi_device *adev)
>    *
>    * This allows quirking on Linux in a similar fashion.
>    */
> -const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
>   	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
>   	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
>   	{}
> 

Acked-By: Mario Limonciello <mario.limonciello@amd.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
