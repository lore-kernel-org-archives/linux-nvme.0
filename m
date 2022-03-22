Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285D3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CA/dTTcZXd2qVidp6HD2DpLPobKNELGfOgCPAPUT3JM=; b=2wSe4utYgrBj87IxgPitrp+HUd
	PyAupsYVPZssRL9VqUq1vt7Zil2T83aUgZ+FPtAzzI5ojIraHl600kUNYMWPH8QJzzaWNLs/qbV1K
	gf6F2HuKm06ZS8hVK1OiVsfs41IghaopBbMaaJitPf6HlIL9G3lcVSdw5BiOYSrhqhFQJioP9hDAG
	k9oI2A+dq205zRNxGEE6/+jSWYL88SvthQv8Dx64g3VdgiFYZ9VRuzI0DLMIVu4a9Jyx/TyJDV1FB
	wiH/x4fflL4QZOhoP9j/wB/4e4ANoeSRmlvWvMCgi54STI8fFRwwwG6wEucYT2istukeGAEVKrZYb
	GSiBAQaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWdXY-00Awwh-Od; Tue, 22 Mar 2022 12:23:08 +0000
Received: from mail-mw2nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::614]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWdXW-00Aww7-Ro
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 12:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh5eM1ykxTjB2v8ztc41AodQDp3IXMvcVy7OyIlWSYLIbNkyvxIkwSnCivFNUWs/h7EF18EqbdjvTTd0ZxhibGM9794OgI682Pra5aRHbssy4aI4FXhk1XHPYbUDtQcyY8N1OkE3uYkW4T6dafG2aLTGBHEtJcPCUZd/7uSIy5AtPSATiHaLkt52YpXUwu+7inwimoZZKS2iYKO1MNnDYhkaGFBnLt58ioJv/+y1KAN59TiHQiRCeDZm/okmy83mZX2weXBlTM4ASXjtnltUrvwTw2e5ElyDF40Gmdy19Y/mlfkRpnNiNyIfoquFqCcpFY287Dw6K24gtSRJc3ouqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA/dTTcZXd2qVidp6HD2DpLPobKNELGfOgCPAPUT3JM=;
 b=a6AiDDWVwiDxLpJPoqkKkj/cEHiZEh1JTTKnthn9GhkV96M2HtqbmADVA+3a/Ui2Ggq0pn4rkYyGyR7KDUHGAaMcCmYq25jIB6l2edcJ5fPzglXpGILXvoHoBFXkknCnVoGX0jllrAJHtM0aX+OUSoezXSwNQJIQ0YrS3DrX0HNiE9dQeiB3hs+LFq0r5qEy9fZFQFKXqIBQsl7TE4lYEdUDImzx/v1AcZCtO+2y2iq8rj4aytvuNcmbV69E8of8xbWbf8jq9kI3xm1EDjvlvLOEX45zvaFhATrujmLFIvucasoZKuyVPFztirE6o7NvP2ItfmXdgawSfb6A4BB8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA/dTTcZXd2qVidp6HD2DpLPobKNELGfOgCPAPUT3JM=;
 b=hf3vRt2LumoEPwyBaoZu7AiVd/DaviUzVIU7M+RlH1miKU6qXyoFhZ/6WW5LJ+yNCIbxrhSZhf+NXOJmAf6R6VYUlBt+Zb2qgig7R8SKr2G9ipB1xBqEB1tOsdUZR4MSeYMIQC+VKMlxuPG4MLdgTEvb4ojJInwEmLKqVvW+Y1iIDdT8tFNBtXHgZT/TEMb5CDDL42YJimnyKGayHrYeENanLBu4dWcc6DbvoVV5KIv+k2UjIv9oC40mqO6lZ37sxe5Ekblx34+cCJ0Qpk3iU+b/VeXKWgJvbYCL1bOZUrCFx11/NXP9ARjKvhbSv3+yCv3U0fY11clHKXUodD+sCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MWHPR12MB1184.namprd12.prod.outlook.com (2603:10b6:300:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 12:07:42 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 12:07:41 +0000
Message-ID: <43893170-e958-3cdd-e01f-c766126e896a@nvidia.com>
Date: Tue, 22 Mar 2022 14:07:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nvmet: use a private workqueue instead of the system
 workqueue
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: James Smart <james.smart@broadcom.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20220321115727.774650-1-sagi@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220321115727.774650-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0151.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2381f726-5dfa-4073-11d2-08da0bfc90ba
X-MS-TrafficTypeDiagnostic: MWHPR12MB1184:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11845FB0C5FBF0290318A8F5DE179@MWHPR12MB1184.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHBmae4pHTDaj8VgAU78iwFSsFhwwcSe2Didz4kBbC4L39FmcDiFEdlvqP1523wxPm6h3O13aC9G5pDB5HbNWL0I+6QwGX60u8/RDlHVkZEm8cg9uj6i5fsVUY8EZNyezQvK/TtpGqXDa9PRdYw3J/lbfArQY94An/W4Aae0KaNcy+nxlafIIXA9/iaI2uDpIQ4Um7Cu4baJJdAj47pQtpyuA8phsgIC8tNT9wGaIWJBBKKNbmDXrKepnYjMER4NwiuGdKEQqq1xAo5KvGkSc6OfKrltsEAP8/VIKuYeOfVn9k5cjQPlK+gMUskFqEPu+ZukFzg10EJ9qPXCU2Z/bpUEFpnVbHaOwYlFknDvcm1pVfb9Y2+xbFKtO4G8KPHzVGkn4OKNa1jitKO+96KDHV47kOOoMrEiHjzFahZfW7mkM9VdXcLJKKrSUVX/wdcdssY1v9HXc/WXdl91Ed5dOtuPKxy3jIVLtcCOw594excvFl6rNBDQpHm//IKo7wEhWys1g15DcCGMqfCYYe9zgWI1SOy5whfnYH6qy/mr7rYWR+7SOOx0bTnaIThulEwDD7co3U3WjF0nsWhqxRAnTf4JEhV5tDP72gGCq+W65fmE8i89sbBNpvb8aT2X291a7nC3llDQqVcTpJhljULXU+9SwAkrbK7oxXHkJlwRaGJLwxNyTXR3l6n40ZHxJNWx2P5Yf0sbDHn1ZttY8i0cNG0JyHKHeLVqEmOnzt0vueBIqNGiEC6xzr0CbIzM0ozu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(26005)(2906002)(36756003)(186003)(316002)(31696002)(107886003)(8676002)(110136005)(54906003)(86362001)(8936002)(6486002)(2616005)(5660300002)(38100700002)(508600001)(6512007)(66556008)(66946007)(66476007)(6506007)(53546011)(6666004)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5XUUtzZ3NuaDlrMEJzN2dPSm5rMEVhL2MyZnQ3b1ZOZUlWMzJHcFVvZm16?=
 =?utf-8?B?c0duUjBmSVJ4ZmZJWFpDZWVMa2FyWEFtNDN1T0t3bHlHZllzUStFQ3pqNTZN?=
 =?utf-8?B?bFcwU2ljUVo3UDRKU20vQisxYXNYelhOcWw2VTQreE1vM3E4ZVNmK0hGUGV3?=
 =?utf-8?B?NTJFUm9sY0VWR3BMeWNJK243cHFkRndRZG9Pa1Q5MUtmdXBoeENZQXh1T3E1?=
 =?utf-8?B?MnVKWEFTa284M3hKZkRqWjJnVGdOcW9UM0FEeGhIUmlySUtscVE3SWU2WDBJ?=
 =?utf-8?B?QU5kbVVscy9VU0lSNk5OdVl0Y1YwakVqbStEb3Z6YmU0VUZpMmR1c1VvdU1o?=
 =?utf-8?B?ZURqbDJ6bDRkaTE4SFVERWhOenhsU1Y5cWFoRTEreVE5cXcxaml3d2FjYkl1?=
 =?utf-8?B?YUg0N2xUcFFGdHZNMFdyZW8xc1ErKzlpU1NaWnpNSi9YM1FWRytLNGduMEZZ?=
 =?utf-8?B?VTJMVHFLRUFtam4yUXEzeWRKVSt5TmRORFJBeFpYc09TNms4UHAxdTJ6UE0w?=
 =?utf-8?B?ZXZlOG5lUlM4REEzZW4xU3NFYlZGaHZFOU04YmlDb21BemZoSEpkSlBvOEo4?=
 =?utf-8?B?M0Z6emdaMTJONlQ4amFOQlViZml4dUdSZStOWXdGSERXa0FleGcxRlcrd0FS?=
 =?utf-8?B?Zm4zTHVXSVFxa3U5Nml6dk1HRnladXNOZjBPaFE0TExDRTVVcUtWaGtFWGJI?=
 =?utf-8?B?R3F3c2JVcE4rV3lrVy92SXo5M3RwM1p3Nk9sc0JrNFl5VlpGSFBUS3pOMVFT?=
 =?utf-8?B?VjZUOTh5elpiTVo2ZVBLZmNRMTIvQVl3VHRKbkx4dDZwZ1dIdnd3d3NGN1dO?=
 =?utf-8?B?Z1VnWm5taURaMHRsUkgwbll6bG1VQkxwODlRek14Q2VyY0pQUmFnZTVrVEJV?=
 =?utf-8?B?WGQxQkFTRDd5Rmd1M0RONmg5a0Rocmo0YUJKQWZEWDZSWEVwNDdaaDcrQlln?=
 =?utf-8?B?S2JDWktnTlVINmpEeDd6QmNyaTkwUnUxbkFVeDBrQy9xRUlleGhzR3BOMll5?=
 =?utf-8?B?SWVQQ0s0ZkZReWk4djNDcjJPSUFxa2FFVWM0M2pURkEyZE1MSFhRbUlKWVMy?=
 =?utf-8?B?S2tHMGFSeHNQZ3NxczFrdDdhZmhHemJHWkJiR29uSWkrZDlEV3k0dnRnOTVv?=
 =?utf-8?B?a1picHdnOExsM0k3WkxVY3MvN3JWQUszRmZwam9aN29mMUNRRVRMZE9ndmJG?=
 =?utf-8?B?a0NFWkNNY1kxSUlDeTZrL0tzUHFFbWR1NzY3WlkrbFpqMzY5c0Q5c24zU2dC?=
 =?utf-8?B?c1ltOHRGZ09RTmo0Zk9xUjhkMFIxQ0NqQnB6YnlmcDZzNzJkRnFxaWN0YnY4?=
 =?utf-8?B?UXFVWEVDWmZzOUNsbTNySklVcC9BMjB4NEdHNlMzajhDc1ZqOTd5QUN0VUlJ?=
 =?utf-8?B?NU0yTUlLc2hUakw5UloyYzAvSG9HR3M5SVJFWS9BQzd6bWRObTFEVitmUXo5?=
 =?utf-8?B?Q0xJVWFWNEVCVHRDV2FNWkw4eGdQODZJV2QzTnpKTEt5VkpxS3A2NzByUVZo?=
 =?utf-8?B?cVVUWk11RWh0Nm9EeGNOSXd2ZzlLaXQyYlBldFRLdTNuaitpYnpLbU5RUGRO?=
 =?utf-8?B?bGVKd2hJdzZIRloxRVQ0SHByckZFS0RuaGxVbWZ1ZGY1UWJBYlUzaGhaNzNV?=
 =?utf-8?B?QlI0RXFaSnkvUTgrMFVDQzI5ZFdNRWplaTYrbTJnMllBTDV6S2t6b1lJVXM4?=
 =?utf-8?B?RDU2NEh2ZHVzT051cmVhTTJLRUVFdUlhRWNwVW5IblNMcXlLS2dVR3dKc0hQ?=
 =?utf-8?B?c0pPSjdHNzhuZk1PSTVDWjhHWE1xTFhWL01iZU81L0hNNmM2S1JJeTFReVF0?=
 =?utf-8?B?Q0Jia2dUOWhFOVMyUlc2VU5EV2JrSDNhZVpuREM0NDBoODJPRHFISXg3ZU1k?=
 =?utf-8?B?RnN5TFV5R0J2YndHQnBkekNUajNVVWc3SXRCN3BmVm14OS9HYmZQc0VMNGQr?=
 =?utf-8?B?MW41bU05ZkxrSWdyN1RHNHdLNllrZkVtUVNwZlRGY3dxMjd6UUhNTnRNMmJ0?=
 =?utf-8?B?cHVHaXdURTlBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2381f726-5dfa-4073-11d2-08da0bfc90ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 12:07:41.9447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh/LKowRdD4UFlU8RJUnzJ3NnIT7MMwBczSGiAXiPCf+fleaNTwxZJPUT3rhFkc1gQC8bKO9TWAdprSQ7sVtLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_052306_919396_BCED3432 
X-CRM114-Status: GOOD (  15.77  )
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

Sagi,

On 3/21/2022 1:57 PM, Sagi Grimberg wrote:
> Any attempt to flush kernel-global WQs has possibility of deadlock
> so we should simply stop using them, instead introduce nvmet_wq
> which is the generic nvmet workqueue for work elements that
> don't explicitly require a dedicated workqueue (by the mere fact
> that they are using the system_wq).
>
> Changes were done using the following replaces:
> s/schedule_work(/queue_work(nvmet_wq, /g
> s/schedule_delayed_work(/queue_delayed_work(nvmet_wq, /g
> s/flush_scheduled_work()/flush_workqueue(nvmet_wq)/g

should we have the same commit for iser Target ?

it uses schedule_delayed_work & flush_scheduled_work as well..


> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/admin-cmd.c     |  2 +-
>   drivers/nvme/target/configfs.c      |  2 +-
>   drivers/nvme/target/core.c          | 22 ++++++++++++++++------
>   drivers/nvme/target/fc.c            |  8 ++++----
>   drivers/nvme/target/fcloop.c        | 16 ++++++++--------
>   drivers/nvme/target/io-cmd-file.c   |  6 +++---
>   drivers/nvme/target/loop.c          |  4 ++--
>   drivers/nvme/target/modules.builtin |  0
>   drivers/nvme/target/nvmet.h         |  1 +
>   drivers/nvme/target/passthru.c      |  2 +-
>   drivers/nvme/target/rdma.c          | 12 ++++++------
>   drivers/nvme/target/tcp.c           | 10 +++++-----
>   12 files changed, 48 insertions(+), 37 deletions(-)
>   create mode 100644 drivers/nvme/target/modules.builtin

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>



