Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D905CECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CfofOT1jzJCdoDv4i8QXOccsDS4jr7fNWCdP+y7S0c=; b=kXIRBuJ4EkjCCsQJwtbg415maq
	+FdwYSCd3YjGlgjXIy+RPIZ+Cu8R22jsKqoA1M3NxWdIy6yWvXfeVYhIQbb/4OIAEcOtwu3i3Gr/r
	TYrscq/vKdm/lMY3YD9VUZgrlgVwL5dxl+FUyxFR8EktsBY1H+d7RbhZw0Pctm+s9w+OQywu0je+e
	WvpQcgX1VGyqGkqXuLLHD2VRdRS0VMHwq1phXdgsT9nAQa9PRQhbbS62u07Gevw46QQsg99Z0VezW
	MnyfHMU3DK4rzqZEj/Q4q9Zs2rQzC/Ct9e8azbFN3ynh3cW2qLY6QwenmhANMAPEBGGA7WgjrvTDL
	ccNzIrag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oScEr-007V6Q-S5; Mon, 29 Aug 2022 10:43:30 +0000
Received: from mail-dm3nam02on2063.outbound.protection.outlook.com ([40.107.95.63] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oScEm-007V0p-Qx
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 10:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTsYsJIKoSUdPGPVUSmbBOcPXuYyQvgpmVuvSq2ny4zoIV86JEzhGpMvEX/rJui3E2BlB45qlvVxCt/VpvF1LA8G/+dahvxYNuDbSfKK5skzTlhBkDHA84DVw4pZijrcdHNbH/53qRpCugCGYRTcBbZn7qCHz1/4VidDMf0ZTCcAaVREEAFFLhi8Ncpq8QeIY0ZH7+Da30fzOuG2vd4yrr4ytD0DTf98BYF4cI5X4DALEQwowwz8xIFSQ3Mtw9/EUm2aNyWMid9arSgnYtSGyFGw2V+IqQzRX89ZedEQzVYqupvW5BBD9WUSq5fPYZC32Z9JZ1S5nvKg96p4rJ2z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CfofOT1jzJCdoDv4i8QXOccsDS4jr7fNWCdP+y7S0c=;
 b=U078FV6c2zPOmtcdOFRnfkRZy+6AOf2ykG0KKAEuxqHn96F2rniVyD/7UEs0mNZautmeU7rLW0OYOwx32b4SMas3Xnh/DNhO5egQ0qFJk2UYAdf+pvKMUynzcC4KY2j9oW3wi6cdlrlF4Mkz5KQ/XqIjOPODF4wMnlqEQ9McVtOrv2tO07ZJYInotV3mFnhUPticN9356h1WguZRRXmwy18nXTC6zdoeRE0WMdfVlQjhbn1E1NNHZZXeeKYRM5RA/jPVOoalyQuF9lMUhwH4eCiUmtWShX3BPmXX4046ikjcnmSow5ljIN1QNPfNJku69aUlqsEnn8s97jz8VK3xvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CfofOT1jzJCdoDv4i8QXOccsDS4jr7fNWCdP+y7S0c=;
 b=r4dmKWj1awYe5a6hByJXP4LelaLO1BcQJa8Z0/tnSDlCSdOZPPTMw/ZofUo6cAWq5ToiaHjiSH3qUDj/5La6q7/hhUlPimrUZbHsh6UHgpNQbuGu3WeKNb6+by4etdh9SEeol7vlfY4810DObJUFTvDs7Hc/KG1O5t0C0nfixZ+rFR4ItbXAiz4qmdHoOv3A85EdegaYlFt/clNfyOYnFFUhVBci+2xc7PCLjx4E39wNcQitXKM/nEEFmyBIdpQYVVg+zU/FtugGR2zb1BdqHVry8Af54h8DqCYPO9YQoG1KrXGUWjOAPwA6Q/FaLvRncdPx2/kC6WJDv9dc5QlKQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 10:43:18 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 10:43:18 +0000
Message-ID: <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
Date: Mon, 29 Aug 2022 13:43:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
References: <20220829081256.24570-1-lengchao@huawei.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220829081256.24570-1-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec6aa3a4-fb69-4d19-4421-08da89ab4912
X-MS-TrafficTypeDiagnostic: DM6PR12MB4403:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ukZWhrDNzKklQdFMe74BeSmHH9+dOtj5e6uoaWMfr4TcAI64Vc459255da4oJq7OsXDgk1H7ikImn3WjrUvJ92BBGT/cW5Ig3wu3qyCqDmejBqk6ZprS+wUpiw9DOTUt9jw+C02KZm1Q1xMIWdrYLIQuB54cWon7Oo19q+JHecaKav3keoDezIAsg1liaFZ6sbd3+SRDUziDxv2eGOsC130bGv7z8oOq0k05X7FEv02zDWevmn21sVG4S3dgK37I43FUu8itDp0RP/bJ1l+8LCEdNwUrPF5PvfVBwPpY8h8O/cxKbXMqb8Zq75HYSP2q0RJjMMamDwBPNXP2BqZ4xvG0Hj9VxribXDgxC+4R4v7kHlHEbtBaYZWP4gSr0pAZcoPeHnRqoGEkejrO+kdkCtVwsc+FUQS6W6ApcP+2d/j5YGezkXU2usYagQMvSA6XSRGLXEOiDDXCzBeCkuJx67TIRvhdQSZUeZEz67d8K2toUEa30Jv+eDUz2G7LeBMIpsJNT/mhOLX0QW8ncG1GW2WxJPPheIBRUdaXF/6eeGiiLTkRv6rLrzr1nXsRVoNzB9l2qM/0Cux4Q6ZzwlUp2ox16pFIP32BABFCjx3Dxn7e5GnYjEyjXnslxZG+jPsglV3HD0kjlByMC+kaVKwZpirIjQhRlnOkevwctqGM7tGNJIWjAjI8FHmnuazbEr4blhsB5u/gL8Nxxnl7GZrLsvxo1I5nugZ/+sCRWwIed34uBFp93+9oZW7Hf9u/4qJ0eeT6LxILnGdNzhm/Cz/mVqCI/B8zDU+afKHnE3+U900=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(31686004)(316002)(86362001)(6486002)(4326008)(66946007)(8676002)(66476007)(31696002)(66556008)(5660300002)(478600001)(36756003)(8936002)(41300700001)(2616005)(6666004)(6506007)(38100700002)(26005)(53546011)(2906002)(83380400001)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?dEZmS0E5aDJBVlZZYkh1TlFjTWgrb2NJZFltL1pFUUE4L2lKK2hPelZza0Jt?=
 =?utf-8?B?dnpkQkExQ3BuaGk5T0pYb3gzcWYwVFJaMzFjU0c3dXE3eExNNU9NQXdwRXRs?=
 =?utf-8?B?akNDOTZwb2pTa3Q1QXR6V0xGYVJ3bktlaDBydjJiWm9veWlNQ0tKM1JJTk01?=
 =?utf-8?B?dDA3VjhvMzZCa0JHV0dWNU1iWitiRVR1cnMyMTB3UDdHR3lUUllYbjg2aWI1?=
 =?utf-8?B?UFlrc0U4SjN5YXlYM0lxaTljV2MzUXlsa2Y4SXcxS2JHdjBpU2lWOTZuWVJR?=
 =?utf-8?B?Rlh5ZXdVNm1vdFBUMGJFcEhGZWsyTnlwbmZuZk9VUFlMU1p6L0RIWVd6RXd4?=
 =?utf-8?B?R015R1FFYzZpRVdLMFg5b1MxUzZqdjRQbXRLYlhMbVV3ZGlrT0o2Rm5lOEpr?=
 =?utf-8?B?eENlbjdmUTBnYjBWZ0luRlhuV2JQNThqYlBGbWhWeXZYeTJlcE9EU0NqK2VI?=
 =?utf-8?B?K0habXE3QlQ2QXVhTjNBY3MxUEprUG5QTklFbjJMQWF4K3dzb3FmYmFBVjli?=
 =?utf-8?B?ZzBkQjRLUmJLYTlNeTNTYnZSOWh5eXFCS05QSmVlRllod3JGZFowUXUvN1hF?=
 =?utf-8?B?Z282MmR2d0p4bmZ5QXlGZjUwQnNBV0xTdlJ2M0dteG9ZeWw3TXQ2ZEpGWVU0?=
 =?utf-8?B?VGdwbG50WVBxQUVOeThJeitTekJQNDVmd1ZtTmhES2h5czMvVFJRYXg4NEtD?=
 =?utf-8?B?TkkxQUduRVNHWDRWaHpVdlhkdk9hZVd5MWNQQzlQRy9QamdZd0JvL1JDSlhR?=
 =?utf-8?B?VlNtaUNBK0VCL3JhZCt2T3VZcHVFTlIxaXYyTDJoYW4zVXk0NDA0NmFxRHds?=
 =?utf-8?B?OGZjdXd0NWFUYXM0RVVpN0dVYmYydnN4NC9kRzJqZXFqNlhkQmJlR3pzaEs2?=
 =?utf-8?B?QmdTM0pVSUNkVFI1TmltQitSVk9ZUXVqK1laeGVwNW1TanREU2IzR3JDRExw?=
 =?utf-8?B?MUFjZlJkeFk3Nld6WjlOMk1DaGN6dUgxTDVrTWZSNHVtVFZBUmVOSGFkZkE0?=
 =?utf-8?B?dEZ4SVpIRWwwSGgzV1h3dkdKZDVUQWpaVlVycG4rbDdOd21LOHlNYnNWTktW?=
 =?utf-8?B?ZG5UT0pVdW1ZcjhtVlRLY3lXcFEzU0JIdHV2ekd4aVphbk9qWWVLSlMwV2x1?=
 =?utf-8?B?citBanI4UWtGeVcwSFdlTjJoMDgvTFkxbTNtRlBQL2dxSUkzOUNqUm82bGJi?=
 =?utf-8?B?bnVSR1pEeEx5V29kWVJjV3M1TTZ2Zk5nQk00dmVyZFZvOVcwR1lnQjAvTUly?=
 =?utf-8?B?K0VkRHMwSWxMdk1WdDd6TmVYRVFRSEM5Rks0YnlzUzcraWRsMU1EOFpycFlH?=
 =?utf-8?B?NDJJTU9BVEIrbkJ5TjIwWEsxZlNTY2kza3BncFZyZFd6Q2NUOXNLbjZZQUxn?=
 =?utf-8?B?bkxJbXhYZ1NNcjhTTHNMbkN2NFQwamtDZmt3UUFNeCtwK0xHSFdwS3BtOUkw?=
 =?utf-8?B?MitYZkpNVm1qMk1qUDNoNENtZldFWDFnMU9KdlU2bjRQS083T3krd2Jma2hp?=
 =?utf-8?B?Z1Q4azlKdGNNV0FYazJWYzdMaG5FcWhhZ1BnZU0xWE1VRGhjWmxXejNBNFR6?=
 =?utf-8?B?K08xeGpjTTFtcWQvMXhKdGllc1NZT3NCREdPZEdvOElqcGZLZ0tUcFFMUno5?=
 =?utf-8?B?UU5Ub1poaWFTTGxWYTZIL2RSV2w0ejJKdVdEUU5nY2I5ckxweHRkYm90V3NM?=
 =?utf-8?B?Zzk3b0ZUME9Zby9zdkJNWVljdnlmbGk2WU0vaWlKTWRzVE9hYVdYM0Vzb3hX?=
 =?utf-8?B?Yi9jeUtqM2dQSGdnSkt4RGNmUXkxRDB1MWhUZElBNDQ4TnlnNU0xYStoWldP?=
 =?utf-8?B?ZVQxYVlVejI2L1F6TGdlUUZmTnZud3I3ZGU5TGNLeDFTQjErSXVuY2c5WkxO?=
 =?utf-8?B?aTNoNXRqT1JXQ05acHdDMHNtNWJKc2Vkb0hpeWxBYnlBQkhUYlNWRWFxd05o?=
 =?utf-8?B?S1VkMjNFRDh1aU1aUGN6cFo4cXRKb3ZMTGhuOTdwSVVOYmRZQmdTK0UyaUNt?=
 =?utf-8?B?NTV1ZTA4N3EvVkgzYU5TaXc1bUVLS2lyMyt0Y3d5ZEZSeUNzSTRta2JvQllr?=
 =?utf-8?B?NkRYMWJNZ1Vibzl1NXlOMnNqd1lQdytwcUdmUEFPN01BRTROWk80M3gxUDk2?=
 =?utf-8?Q?oyOIoab+5YHZlpQP1kPFwLA6C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6aa3a4-fb69-4d19-4421-08da89ab4912
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 10:43:18.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6+ccThwW+8euE0aJnH5524s0Vtq7nHg37LmOPOsi2DYk8GDr0CzsOjCB4B7xfLqOazQoYU6QQcQFXT5Z+6FPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_034325_262652_45FAD0A9 
X-CRM114-Status: GOOD (  24.50  )
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

hi,

On 8/29/2022 11:12 AM, Chao Leng wrote:
> Now some rdma HBA alread support DIX-DIF: host buffer to host HBA use
> DIX, host HBA to target use DIF.
> This patch add DIX support for nvme-rdma.
> Test results:
> The performance of different I/O sizes all be optimized.
> The CPU usage of 256k size I/Os can reduce more than 20%.

You're adding a new PI guard type for 16bit mode only, aren't you ?

I don't think the subject and commit message is correct.

Can you attach to commit message please the table of performance numbers 
before and after the patch ?

You can mention that also in iser, if supported, the default is to use 
IP_CHECKSUM for DIX and not CRC.


>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/core.c | 19 ++++++++++++++-----
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/rdma.c | 24 ++++++++++++++++--------
>   3 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2429b11eb9a8..7055d3b7b582 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1623,7 +1623,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>   
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
> -				u32 max_integrity_segments)
> +				u32 max_integrity_segments, bool dix_support)
>   {
>   	struct blk_integrity integrity = { };
>   
> @@ -1631,7 +1631,11 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>   	case NVME_NS_DPS_PI_TYPE3:
>   		switch (ns->guard_type) {
>   		case NVME_NVM_NS_16B_GUARD:
> -			integrity.profile = &t10_pi_type3_crc;
> +			if (dix_support)
> +				integrity.profile = &t10_pi_type3_ip;
> +			else
> +				integrity.profile = &t10_pi_type3_crc;
> +
>   			integrity.tag_size = sizeof(u16) + sizeof(u32);
>   			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
>   			break;
> @@ -1649,7 +1653,11 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>   	case NVME_NS_DPS_PI_TYPE2:
>   		switch (ns->guard_type) {
>   		case NVME_NVM_NS_16B_GUARD:
> -			integrity.profile = &t10_pi_type1_crc;
> +			if (dix_support)
> +				integrity.profile = &t10_pi_type1_ip;
> +			else
> +				integrity.profile = &t10_pi_type1_crc;
> +
>   			integrity.tag_size = sizeof(u16);
>   			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
>   			break;
> @@ -1674,7 +1682,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>   }
>   #else
>   static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
> -				u32 max_integrity_segments)
> +				u32 max_integrity_segments, bool dix_support)
>   {
>   }
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
> @@ -1900,7 +1908,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>   		    (ns->features & NVME_NS_METADATA_SUPPORTED))
>   			nvme_init_integrity(disk, ns,
> -					    ns->ctrl->max_integrity_segments);
> +					    ns->ctrl->max_integrity_segments,
> +					    ns->ctrl->dix_support);
>   		else if (!nvme_ns_has_pi(ns))
>   			capacity = 0;
>   	}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bdc0ff7ed9ab..92cf93cf120b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -276,6 +276,7 @@ struct nvme_ctrl {
>   	u32 max_hw_sectors;
>   	u32 max_segments;
>   	u32 max_integrity_segments;
> +	bool dix_support;
>   	u32 max_discard_sectors;
>   	u32 max_discard_segments;
>   	u32 max_zeroes_sectors;
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 3100643be299..0f63b626b3d4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -872,6 +872,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   	    IBK_INTEGRITY_HANDOVER)
>   		pi_capable = true;
>   
> +	if (ctrl->device->dev->attrs.sig_guard_cap & IB_GUARD_T10DIF_CSUM)
> +		ctrl->ctrl.dix_support = true;
> +
>   	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
>   							pi_capable);
>   
> @@ -1423,10 +1426,10 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
>   
>   static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
>   		struct nvme_command *cmd, struct ib_sig_domain *domain,
> -		u16 control, u8 pi_type)
> +		u16 control, u8 pi_type, enum ib_t10_dif_bg_type dif_type)
>   {
>   	domain->sig_type = IB_SIG_TYPE_T10_DIF;
> -	domain->sig.dif.bg_type = IB_T10DIF_CRC;
> +	domain->sig.dif.bg_type = dif_type;
>   	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
>   	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
>   	if (control & NVME_RW_PRINFO_PRCHK_REF)
> @@ -1441,7 +1444,7 @@ static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
>   
>   static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
>   		struct nvme_command *cmd, struct ib_sig_attrs *sig_attrs,
> -		u8 pi_type)
> +		u8 pi_type, bool dix_support)
>   {
>   	u16 control = le16_to_cpu(cmd->rw.control);
>   
> @@ -1450,16 +1453,20 @@ static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
>   		/* for WRITE_INSERT/READ_STRIP no memory domain */
>   		sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
>   		nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control,
> -					 pi_type);
> +					 pi_type, IB_T10DIF_CRC);
>   		/* Clear the PRACT bit since HCA will generate/verify the PI */
>   		control &= ~NVME_RW_PRINFO_PRACT;
>   		cmd->rw.control = cpu_to_le16(control);
>   	} else {
>   		/* for WRITE_PASS/READ_PASS both wire/memory domains exist */
>   		nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control,
> -					 pi_type);
> -		nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control,
> -					 pi_type);
> +					 pi_type, IB_T10DIF_CRC);
> +		if (dix_support)
> +			nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem,
> +					control, pi_type, IB_T10DIF_CSUM);
> +		else
> +			nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem,
> +					control, pi_type, IB_T10DIF_CRC);
>   	}
>   }
>   
> @@ -1501,7 +1508,8 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
>   		goto mr_put;
>   
>   	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
> -				req->mr->sig_attrs, ns->pi_type);
> +				req->mr->sig_attrs, ns->pi_type,
> +				ns->ctrl->dix_support);
>   	nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
>   
>   	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));

