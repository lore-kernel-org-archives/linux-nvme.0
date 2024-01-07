Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA4DC46CD2
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jan 2024 00:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tziN/5QKaXoC44A4z/wVr93bn6CKdOnOXW33S3SzHOo=; b=iiuyb6zd8iFzbhZiO0QTKl1/33
	/MK9van8iC/DbIPxjzsMENoy9l5ss/7DnGGhSiDB3Zyj3PlblckW/CSDcqVRL5PJt34tAYyFcZHNs
	jVN7v9akPAs+3saFcIAHNsSCIIWPsGEvU4Ahx0SNxjbEbvCSvcDIPP8umAl/gp3qUsQn7pWr7ReMb
	yID0jg8JmLSHJMzOo8Kp+8OS0C2jN3fTXyvth7NVWsSyRXs9aECucratF5RIMQuFVmitlPgkBDhQI
	Odd9q+zBpmHPcjYrg62qH+TOokbauDFShD4zMQfPlzg1JrJeqf+7EVF1fIaW2V7IHcG9zgFeOijan
	Q3PTqVAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMH0c-0026d4-0i;
	Sun, 07 Jan 2024 00:27:22 +0000
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com ([2a01:111:f400:fe5a::613] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMH0Y-0026ca-2I
	for linux-nvme@lists.infradead.org;
	Sun, 07 Jan 2024 00:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcKG25cqhLpXpywZ0UDOAcbKsf39n02wUttH5a1SVghVRd1YcJV9WZzgM6i9umN2xSObj2hKp1EbjzM3Tjzq8x6voOqUYSDw+bZyvGiJ1s/jwxlesrX/5BvBE33UECU3KnqzKbsepAS8r4Wttsy/ao9Yn+cldRqAVC4t4E04VlmzKqmYyhJ//+hkogKM4iN62mM6ebhXKFgvoxnxxWmp1y+xLSUIR3gMREUorGbE8+wkuZSCK47NR9wkAWbXCNYj27/uzykOxBcUUuQe77p/7F4dzHJczSuWQd+J9fWyBy7YcHXXBCnIQ1fxghvYk5rPEbpqixaUxmD31GtEUIa4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tziN/5QKaXoC44A4z/wVr93bn6CKdOnOXW33S3SzHOo=;
 b=AUmPL4UxvLlY7bQwqw6pTAUOOV2BcnIjnb2wPZJboDpBqIhHfMz6twEBA/2O2TEJvACCSdSAqC3xgiwZASevCqdl35mP+fUCUHU90JOCoOIQsSAnjdUcCnwHCSRAYDtmZum5idi1bpKqljhn8flVUwdDgPvXhV67mHV/6oABNNHqbG2pPzLFKq2zH890qqHmmJlfAhwYwmsx8ZYSNNq0R9btUpDVS9T0Aa1OcYMy5AW6hKuxYCMPCUbBa17wd+KyMCswrtaFt/0VqNI/MHYPWUh44fCNPGHQrrKtbn9ixAv06/ShjAU2MYN+cfMrwZHulAMn1NphrdXM8FNc4Wtqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tziN/5QKaXoC44A4z/wVr93bn6CKdOnOXW33S3SzHOo=;
 b=pvpXsS2E38JHYkcUe4QEAF2vpIuOi4OAchxGjuIZqI7N7zufeEUypdJCzZY15GeX51jwv8qMENwUUSMwONypAAOOTRYxAMbrCRMTgIY8xac9nmel6Boijkfm1DwVAsPs3ligwzGM7ccG0miZqZ3X2ZXF/LLtB/z/PX43eEsvZyEYj8m1eSvjQ5rYQQycklUtQAMHM//SLX8rH0W9UGDkSfboM+ncKjc4p/KcPZUa79jA2lB48PL6tfmfwq9n6hTUyYM2sZEO4R7yJrhi73VKYf5aDtXD0z/ajmnWBpdP9dNG1DA51PlSnnIHCY5T8fdIlElC3rP2Xb/iDRb+W2nNPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 00:27:00 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 00:27:00 +0000
Message-ID: <0ec0e324-8261-4e4c-9797-7b3154355305@nvidia.com>
Date: Sun, 7 Jan 2024 02:26:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme-pci: enhance timeout kernel log
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
 Keith Busch <kbusch@kernel.org>
References: <20240105182020.2721350-1-kbusch@meta.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240105182020.2721350-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0506.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f845b85-cdce-42a5-cac3-08dc0f175cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKPaBAGBAM2ifdPRtKrU+7JVcTEwDc+scApd5tAt3Vli3i9/WM/yVIAOGWgBhSb2Y0mMTnSW4beHF61ge1OO2SVoUec7Iez52Tl/yyYwt6K/kOMOKheUZfn+9dMrwdizcrdvcSI5mNN1HeW8d1h/nXjpBUNrsb8KcbSZB9q9sOapv2PwK2rB9lqJvDOM0xD6LCKBahyIt+5XRGYQBQDL2cnVNbG6agH6Q6xPbnlFdQvCPmtDnGYajMV+dvcXOx4n5jLYOsIoqBuno6suukVRNc1ubR9m0CombnoHMXINNJicQjoh3L0+2Rm0s64z+NcmO9MTDhKBa/OniSdrfZCU0LRAsHP8kwuSfJ6N//MjqKp3zsnIksVGwCKhMQM933zhDq4f9lsYcNeEUlV+S66Y5H+5h7xPD1LBy7/CLUjsAB4C+4fDolzMH9ETXGRp5PD80gGV7co0vS8F12YfUokxH3dCd6i6QaMASDtKPcVtcwvsmg8R9iemmPKwC1JBTlArQkLXcWWR5VBoRwHjTfFSP39Eeix4E0TcfkxgPTh0fjENRTEIs1qOY2KOBPFuRVW6y296DUKckx2V1AExXFdq+8d2MH9/ORpUX7o8KEl8Olf4+rj38k3Y2ubAk3JlcjmmdiVhuNthl4Gy5I28FQcSJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66946007)(66476007)(66556008)(316002)(4326008)(8676002)(8936002)(26005)(478600001)(2616005)(83380400001)(31696002)(2906002)(5660300002)(41300700001)(38100700002)(31686004)(86362001)(6666004)(6512007)(6506007)(6486002)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hLYkd5SVBZbUl3TDNEMWdkTTMwMFBuM2VPdXlJYjdqbVZvWk1ZMEswZ2RK?=
 =?utf-8?B?RmQ0dURQdGFoK2lQMEQ2Q2ZMUGg1WDdUQllTM0x5Q25ZVEU4Rml3UWQrUXR5?=
 =?utf-8?B?aUwvR0ZYOGE0WnNJcHJZUzBVN3h4V0dDRjY5V01YZW0wZCsyUHNSWGhhTDhm?=
 =?utf-8?B?SU01dTZCcmM0bGg3VmtXUzIvdjVLTUxCdTBJMTRzSldpTmJQYVhRWGF4V1lK?=
 =?utf-8?B?Mk1ha0NocmJoSWNYTFJuSGx4anRMZVJTZERsOFFWK2p4ak84cFkrYk5BN1Uz?=
 =?utf-8?B?OE9kQ2c1bjRvLzdsbnluMzIvUlcwZFJmZEFxTis3clNQT1JuZmxpamZDeXhD?=
 =?utf-8?B?R3dxdEJnQVoxSklQNmYxNUNFNnVsUmdYeS9xZUNrUE9URlo1R29ac1VVY1or?=
 =?utf-8?B?QnpENVA0L1puK21nY2FiT3cyb3JlNjREdUlZVHpkVC9hL2J4c3VoVTBIMXhp?=
 =?utf-8?B?YThyVW13dWQwamQvRFVEamxLVkdLL00rOExibHplQXdkZFZtQVlyYmFFRHFB?=
 =?utf-8?B?NFgyUXN0a20xdFBYRTUrKzRzMHB2aUdVYnczOUs5dURMcjgyelZlN25lSkx1?=
 =?utf-8?B?WHRLRnJqaFg1S2R0dU9XVFBXVkRudUVmZGxLYXNFR0QwbXN5UHBSZG94SHFv?=
 =?utf-8?B?Y0dKNXp5alZGMEVqbXhKd1FjMGVGWFYzUTNDWjdkcndtcEduZE5laVpmT1Nn?=
 =?utf-8?B?RDZVcW9lZm5lbVBNZnFFTWJWM1RpNUp5SHI1R3laTnBmQnRQL3Q1UGNOalJx?=
 =?utf-8?B?OE1QR3JaMzlLTjhpTmh5QVZTU3RpM252UHVGcmZ3QkVkZHFCUHJveEFrS3VR?=
 =?utf-8?B?bEJvbVMxVnRScjJkZXhISGJtYnN5UExacTZqQ2FaLzBHeityV1J5RHNiMWF0?=
 =?utf-8?B?cW1zbnJqTHgyZ3E3dW45czFoaHJVeEtOTytselFiNDRiTnU3QjNqc1cweHdY?=
 =?utf-8?B?amVCaUViVWcrNTBmZGVLdHBYMkFuK3lCdElRbm9RSmFoeWZEVmJZa2NTbjF5?=
 =?utf-8?B?aGZiS2dkK00wa09vR21aTXlwRGVkVE9jSEh0QWtTRjdVS3JnM3Z5d0Ezd3pJ?=
 =?utf-8?B?RUZ2RzBLd01welBKMU5QWllIMnpYZm9Nc2s5N1VIR2NaYnB5K0h6cE5lNm01?=
 =?utf-8?B?NFYwbEk4KzVBeWhIVUNDUGhQdGJrK0Z1dGU3T2NqUUZ4ODN2N29Vb1ZUMU01?=
 =?utf-8?B?dXU5UTNqUUNPeW9xZ3VVSG1ZZ0ZVM01meEFpQ2oyQnJMTVJVWkxrNFNsclow?=
 =?utf-8?B?NFV3dGRMN2xPdlRzaldSRjl0K2RzaUEySlpqalJYaVVXZVFKSHNUVU5JT2J1?=
 =?utf-8?B?SGQ1cUFMMUU1OHVkK2VzZGQrUmxOV08yTzkyQ21FV0ZlQ291ckZhM2R6aWhK?=
 =?utf-8?B?Ny81dVZXQjFOQXZER01iUmJDT0JIMmhpQmh0RzdLV0wyOTlFSEk1Mm9rajh5?=
 =?utf-8?B?QWJqSjVua3R0VUxQV3UvVEFnaE1sRW9RbUdxY1ZIMDE2UDl4OE0wWFlpVlJY?=
 =?utf-8?B?VEdYOVBEQmRmSWkyTWZvTjdOV2dndWV0ZVlGaUZmajVpbS90by95RUpMakgr?=
 =?utf-8?B?WDMzWjdKRWU0bGU4ejQ2VkxuSHNCWmttckhBTzBMNDBVUGZMS0pVV3h5OUIx?=
 =?utf-8?B?NU1CSGN0RW5vSkxCVVBEVXhvSHpNayt0VG04NGdibGw1TjJrS25mc1llZjZJ?=
 =?utf-8?B?MHlpK0t3UE1zU2pJR2lsS1dkYzIrQlY4dnpERTNLNGk2Z2c3aVJHMUQybTl6?=
 =?utf-8?B?RkRDWXgwdDZXdFpwaGxwTEhTeXpiSll0TVhiVHYxMHcwV0lQeVB0ZEVQT2Qz?=
 =?utf-8?B?akFMb20zNit0akhjTTB2b1lOK2xLRGdHZnlKaytzemw1L1IwREg2SzFuQ0Rn?=
 =?utf-8?B?cWd1cTlhOGNoYU9CdWg3TUNNaTNWdnhOMjhpMjFqb09CZUFvMWRwb202UDJx?=
 =?utf-8?B?R0dwaEpoZ0FyNHRsN21LVXdmNlFRNWJVekpFbEZLOWJCckxDNUxmYzJKWFJi?=
 =?utf-8?B?a09CdXJGQWJySE5PVnJrU0RFVEtIMmFncys3YVZkMWhGOEplS2tXam5aL0li?=
 =?utf-8?B?SW12T1hEMS8wZXdQMy8vNXl2VWdRSzVvcVQxNUR4RGMyQ0JjbXlFTUJLbFll?=
 =?utf-8?Q?IttParhd1cMUNJMcGW3TehOM4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f845b85-cdce-42a5-cac3-08dc0f175cd8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 00:27:00.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT28N/+wgmF2nVYDnZtzUnNogq9brVntBs79SuX2RD8fi7yarRA1aEhzzOKI/8glQVPCMz1JVak0NfKxQUS/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240106_162718_859309_3FAAE083 
X-CRM114-Status: GOOD (  16.22  )
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



On 05/01/2024 20:20, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Kernel configs don't necessarily have opcode decoding, and some opcodes
> are not even decodable. It is still interesting for debugging SSD issues
> to know what opcode is timing out, what request type it came from, and
> the data size (if applicable).
> 
> Also print the command_id along side blk-mq's tag to help match commands
> with protocol wire traces and firmware logs,
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3: formatting updates and print out the command_id too
> 
>   drivers/nvme/host/pci.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f272026807419..698c6e497a22e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1284,6 +1284,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>   	struct request *abort_req;
>   	struct nvme_command cmd = { };
>   	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	u8 opcode;
>   
>   	/* If PCI error recovery process is happening, we cannot reset or
>   	 * the recovery mechanism will surely fail.
> @@ -1310,8 +1311,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>   
>   	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT) {
>   		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, completion polled\n",
> -			 req->tag, nvmeq->qid);
> +			 "I/O tag %d (%04x) QID %d timeout, completion polled\n",
> +			 req->tag, nvme_cid(req), nvmeq->qid);
>   		return BLK_EH_DONE;
>   	}
>   
> @@ -1327,8 +1328,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>   		fallthrough;
>   	case NVME_CTRL_DELETING:
>   		dev_warn_ratelimited(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, disable controller\n",
> -			 req->tag, nvmeq->qid);
> +			 "I/O tag %d (%04x) QID %d timeout, disable controller\n",
> +			 req->tag, nvme_cid(req), nvmeq->qid);
>   		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   		nvme_dev_disable(dev, true);
>   		return BLK_EH_DONE;
> @@ -1343,10 +1344,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>   	 * command was already aborted once before and still hasn't been
>   	 * returned to the driver, or if this is the admin queue.
>   	 */
> +	opcode = nvme_req(req)->cmd->common.opcode;
>   	if (!nvmeq->qid || iod->aborted) {
>   		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, reset controller\n",
> -			 req->tag, nvmeq->qid);
> +			 "I/O tag %d (%04x) opcode %s %x QID %d timeout, reset controller\n",

maybe:

"I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",

I'm sending patches to align rdma and tcp to print tag and cid as well.

otherwise looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

> +			 req->tag, nvme_cid(req),
> +			 nvme_opcode_str(nvmeq->qid, opcode, 0), opcode,
> +			 nvmeq->qid);
>   		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   		goto disable;
>   	}
> @@ -1362,10 +1366,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>   	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
>   
>   	dev_warn(nvmeq->dev->ctrl.device,
> -		"I/O %d (%s) QID %d timeout, aborting\n",
> -		 req->tag,
> -		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
> -		 nvmeq->qid);
> +		 "I/O tag %d (%04x) opcode %s %x QID %d timeout, aborting req_op:%s(%u) size:%u\n",
> +		 req->tag, nvme_cid(req), nvme_get_opcode_str(opcode), opcode,
> +		 nvmeq->qid, blk_op_str(req_op(req)), req_op(req),
> +		 blk_rq_bytes(req));
>   
>   	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd),
>   					 BLK_MQ_REQ_NOWAIT);

