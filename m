Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D18C4725D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p17z+EFjw58cyG6zavzYHR2ql3Y32GDCu41VN4dsSR8=; b=efsS5AKJlOZQEpm6afYnWtgzcE
	2zIKjTuY8CSutixhobiBHAitWVgPHabIh9GAPkrLFchqfFAgyldESEOh5Ay+Tz/flaHQXnXGitCCc
	RnsBPT9IjWLt2AinIZ0ELAJrDsTmi6kNO8RUqEs1aFL4usZQQcDh4PTC4mYDU9ijDZDYcwh1M/Q19
	Kzz+/Hbet73NXHW8SJ88XavHw4khukKmXXOkA5Hi/b/tFGiGNuWGq+RcrcORjTYX/s8+7AxaQ+J20
	ViRnp7ZXr516n0MZEnNmH8jgpTXezRnLJ9D+QZYuVhwke1KtgfUv6N0+d6+Y6ZP4WKA+YWdJ45BKq
	+BVvDD7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRt7Q-00C259-27;
	Mon, 22 Jan 2024 12:09:36 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRt7O-00C24V-1M
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 12:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a81KtLlUw7rVLZ2hq6N+GfVi2U4sxmnDwb8cZrrrHT+gqDqSCqvwotAHHcM+JwfP48QfzZPMCBMzaZz4/wwmepGz9L0mBBNinxFduO4aLP7jKu3YQH8rZrz+WU2e0pbiPQUZVRDjVkRK0DGuM9kqqG7EoKpumSKG3Ch09q4cMgJ1kw2kf9vgTKPLvFH/ptBbUSXFlP27KZfpa1tTdh+YB/judJil+OTG6bra564XbpJEhA1aWiaLvtemCX9rS0Qmz6d1MK7SJAQayEssXe8C/qeZuagyqOnG1D3eaxBtnJQSaBZUuO+yiFQQwd88aS9sQ4pxm4je5YL6BZMi8XEEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p17z+EFjw58cyG6zavzYHR2ql3Y32GDCu41VN4dsSR8=;
 b=nVPw4vwb7Jyfam6FdAiLDXabQrbBGCzoGNAxLLwaFJwWoQORogPWGC74VOb5lxhY1JjuaWclrAvkMn85DCZndM1MI57kAn49izXzOgk/wA2iYfvSISKGV4SKBKP7+HaK2y83HgQbusWKnouCImCk+nNCwr2i6ufYR5Cp82/364QL8HYdg5CNZaX/z/WLO6mRQ0GlyUTuWU0OhmXI6/OpKddNj06DPyGjp3TiWri3qus/gNh4NURS/XIOTVSqpyWSqg2SIyTdlIoOZlk+YkfVQ2FYv5g5zIV3fiUurbtEUOYt2wnI6rnxvE6qy8p8bLsFwsA4qWDGIIEoEv/B7aBUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p17z+EFjw58cyG6zavzYHR2ql3Y32GDCu41VN4dsSR8=;
 b=nhklnyA1NDWt7gy7LoBIEI8NVRPeAwwzTsEf+OlCxi1MW9+qzfyv+mO5hVMHwbRJ67gU/Qj0eM8zgo16J8Hn6X426Erz0pFlJW4Dk/nSOYyr+8j68Rrd+u6DD9lflpNXI2e8cx7bFcjD5Oq5wj+vvEgzA3coPseQTpkCOkRgLtHIAfEFV/aB8uAgrFJPHrW02lNyYRKqr8NdhHg0qSfSE0tcVaz+w9/Q5NljfiU+lM1Pd4u2TEHE6M8r1GfSaamDA8gnAoODSbzdf9JYGsl3ELVGJ+0EuyS96cTG9TR1AoOx9xbmx4Fg1FCf0TxwKZp79AxKbXz808qB7CiflRygww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 12:09:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:09:24 +0000
Message-ID: <d0c49fe2-98fa-49a2-93aa-36d1ecf63d5e@nvidia.com>
Date: Mon, 22 Jan 2024 14:09:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Introduce new max-queue-size configuration
Content-Language: en-US
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Cc: israelr@nvidia.com, kch@nvidia.com, oren@nvidia.com
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0347.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: cefeffd0-a687-4829-f06d-08dc1b42f942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wx+Yt2eo/vXqeb2PSGr9uktqM5dE1TMagdADZMymPsZq1kNmwP7t6qk96gt3XBJX6K2tgGraXz04X78fO+4zQO8nxeHN1mNYNgso6so1zQ01/0JBQR1b3iiW5BJ2dOkyPNvAtTz1PHjXXHTCgpKTz7/c5WgtNA8B5Hzw0Z4YA5oHdGZNz0rdKkXZSPae8NTGcJneFVDGfnZ09JwP1qhjmB4fo8YS1uULeNVSgJf25ODlcnjYbPRdiYrSADAPJygCB4qyfTMzgx8eswzzycoXmE//E7KutkW0mu+Nr7QfYW8bkkGRv9MdJzlg2gwp5ksbN74DARryQwUplarx+8AeTpMQotuXrdqwMBYfCjdThPYisOIAsTnmDbiL/sXQntOfS+2whlPU1QL205kzQpVXg1G2pKdsp9O5G9B7XjKsPd2yckOGtP8jkYqRNnr8VuANxeNo3wjExDB6kyq5guYU6BH3VthIvIfnp3HfN8Bu0nZBs4B162tjQXI2TkjuCT86IX0ox/gi8wHMyZdrb1dL8uuU4PBwCblM0siFWgNj/iEkjiAnLwamtSx7uywmWMNyAxE6vyQfkpla3r4HyQZQW/V2PYjY3i7JnT7tPExL0nrFPLtwWfaq0F0Ksocb6hlhSZJQ7ShW6Tb2Db2t204lOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6666004)(6506007)(6512007)(53546011)(2616005)(26005)(107886003)(38100700002)(86362001)(31696002)(36756003)(41300700001)(83380400001)(5660300002)(2906002)(8936002)(8676002)(4326008)(478600001)(6486002)(66556008)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3p4WW8yQmNpT3Vxa1owc0NLaFgwNUt1RzhQc3RaWUM1MTkwV28yQXR5dkxT?=
 =?utf-8?B?alpXNG9naU03M0xlZXBhYi9yOEdWbTgyWnNhZExLcEExTnhYVzlteTJSTmpV?=
 =?utf-8?B?M1BENVp4VEllV3ZDWmVtclh6Snpob1pyMTV3dDFqZ3FkWHMrRXRBcVJaZWZX?=
 =?utf-8?B?cTZTRXRQVy9MV3RRWXZxYWxadEdwVzJkNHJpOTBHMzg4M2tyYnU4T3B2Smd0?=
 =?utf-8?B?bFFpWTZaTUphQUhRcXp6N2htRWdhRFNqbzdidUhsQVpQdEEveUdFVEtzVGhJ?=
 =?utf-8?B?Q2h2eXFZcDNHMm9nZ3BNK05MMFd6cU1iRUxhUk1Gc0NwM0hFQ3BOYTl6M1ox?=
 =?utf-8?B?emxCT1hmUGpURmtHQkpqQVZ0SG9qK1UvdUJycWgyN0JtRXE0eDkweWcrak5F?=
 =?utf-8?B?Umx2WUEya1UxZEZYWDRpTGwzSWFYaHIwcDROY2t3TDFzWnovNjFBUXZlU2Y2?=
 =?utf-8?B?Ny9VYThtYW5hakdLZFQ5VUtyb083WTlJblJLeW5pYzhaejRVMFJPc0c5dXEx?=
 =?utf-8?B?YTQ2UnZDNWRNMFdNMDRmT0hybFNWVmExTUhnMWlPM1ZWQjlXTzN4RUY2MjRB?=
 =?utf-8?B?ckU1SDdBQlZRYmxmSkFoZTM1amY3dVljY3NvNGNBcVhlMjQ1UHFXdHpSd29N?=
 =?utf-8?B?VDBLbEVsblVObTFFR2ROcjFkdVovczBub1BJd0ZWL1BMS1ByVWsxaFFZUWc2?=
 =?utf-8?B?MjhHVXdVNm1WaHFReUNFUkRBZ0dwMnFseHFOZ2FEQnlaZmtSODFDQ3JXRzh1?=
 =?utf-8?B?OC9HbkxhekptRVJQamQxTkJRd3FVTFFIb1k2Rmk5blRvanVxNmIwN3huTTRZ?=
 =?utf-8?B?TE01TEFicDJjQWNpNzQ3Y2s0NmxQNlFUeGtPemxoY3h5cm0zdnRDZEs3OUZt?=
 =?utf-8?B?ZEV4MTc2S1crbDFnQjhKOXhGd2NSa2syakJuMVI2QThHdkx2U2Q2cll3N3FB?=
 =?utf-8?B?emNjY0pGbEhuUi8rRHIraEZEM3Npd01NSkJoQmV0TDBJVGtldFNNYmpkZi9l?=
 =?utf-8?B?YTBlQTVESFdBTkxaT3M2a2FvMHVVeUtOZTFScFRPWVdKVzNnbjcwYmdXK3cy?=
 =?utf-8?B?NnJTNnhaSmNNclZycUZnYTFQWEdCbFlPYjJVVzVSRmRwNEZLK1BuTks1OUs4?=
 =?utf-8?B?OUYwT0tZZCt0OHI0Q2pkSS83MEl0eUlWbXlrKytwbitjQURBSUxnbmNJTnBX?=
 =?utf-8?B?V050Q011ejdwaXducThpVDY2MEtKMUxmTG9EVitxVEdSRmp1b1RtdmxlYVRH?=
 =?utf-8?B?RXFyU1N3Z3JTSGpaYXRidEFQdTlrNmtNdkNQMndkQUZIaGQrSTlPOGhXQ3hO?=
 =?utf-8?B?Z0ttbWMva09LaU15Z2NGUGxjTUUwNDU4OHZuU3lDVnFrTTVBRTdFbUFzQ2hu?=
 =?utf-8?B?b1FWMWp6VFhwN3NWMU4rb1FqNFBLd2FYMHQyODROVjVLTzFYRUJaQXFxUGh5?=
 =?utf-8?B?cXlWQ3l1NzhzNVRsQ3l5VDl5RlJNaGE5QmVOU1JOY3pPMWxHN3AxNUpRdGJk?=
 =?utf-8?B?S3hGNmRWRmN4MU42WWtLMUN0eWNmOUJBWWdBK3VBSkIvL3dYSkRkQVc4aXZi?=
 =?utf-8?B?QWlFWStqM0FDQnFBT1lQWnd0Y3hiSUcrbCt1VldqNmRWUmMwTnhERGxGRStV?=
 =?utf-8?B?N1FIYzNTS0FKaHlRZkZSY1d1VjluNGtMQzZUS0hkYU5zdEx4SDRnWWFZbnN0?=
 =?utf-8?B?OGg1OGNMR0lnNXcwemdXWDdIdHlNQmhNOWt1SjVQZnl4dmRkQnE3YUNDRWhP?=
 =?utf-8?B?L2VMb3B0VEtTVWtxaHpraE9kYTJ3c0hBZWlQN2NjY1FhYTdCNTUyRHpwNCtR?=
 =?utf-8?B?cWxNYnZWZThXRFdJRVNoL2VjNWxHUnZHUHN6Mk50QXhmYmQzcWJURC8yMUNJ?=
 =?utf-8?B?ODlPNHdPMlk1YStmYWxkRzlvY3ZCbE1hM1grdVZkS3YvS0crV3ljNVU2YnBs?=
 =?utf-8?B?YmlwdlMwaFo3SUVOQlRMWDFGV3FoWFNyRFU2ZitTbVozcFM1Q09QM1dERStz?=
 =?utf-8?B?S1lGV1lMR2Vwa0oyNkZVTHVYdy9YMUtjM2VYSkdGTUViWEZTWGc5TElwVGgx?=
 =?utf-8?B?ajUzQUdZaUwwVFVuLzRtRnAyb3ptb2p6Y1RPQkhBREZWUlo3Z082ck9xOXR2?=
 =?utf-8?B?alAxS1hWUTllZmJTeGZNQ1U0Z2h5N2t5K2tqM2J6bjNka1pySndtMDNXUGR0?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefeffd0-a687-4829-f06d-08dc1b42f942
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:09:24.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PO3NfsDdYSOrDjhYG4jRuXM7H3qUnTWVRY3/ewbWKpccn6vyyz1rVG5e3ns7LX/u3OYo2C/S6Z1bCwFKlNlmAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_040934_492554_8795947A 
X-CRM114-Status: GOOD (  17.18  )
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



On 04/01/2024 11:25, Max Gurtovoy wrote:
> Hi Christoph/Sagi/Keith,

Hi Christoph/Keith,
are we considering taking this series into nvme-6.8 ?
Most of it was reviewed by Sagi, the rest is pretty trivial

> This patch series is mainly for adding an interface for a user to
> configure the maximal queue size for fabrics via port configfs. Using
> this interface a user will be able to better control the system and HW
> resources.
> 
> Also, I've increased the maximal queue depth for RDMA controllers to be
> 256 after request from Guixin Liu. This new value will be valid only for
> controllers that don't support PI.
> 
> While developing this feature I've made some minor cleanups as well.
> 
> Changes from v1:
>   - collected Reviewed-by signatures (Sagi and Guixin Liu)
>   - removed the patches that unify fabric host and target max/min/default
>     queue size definitions (Sagi)
>   - align MQES and SQ size according to the NVMe Spec (patch 2/8)
> 
> Max Gurtovoy (8):
>    nvme-rdma: move NVME_RDMA_IP_PORT from common file
>    nvmet: compare mqes and sqsize only for IO SQ
>    nvmet: set maxcmd to be per controller
>    nvmet: set ctrl pi_support cap before initializing cap reg
>    nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
>    nvme-rdma: clamp queue size according to ctrl cap
>    nvmet: introduce new max queue size configuration entry
>    nvmet-rdma: set max_queue_size for RDMA transport
> 
>   drivers/nvme/host/rdma.c          | 19 ++++++++++++++-----
>   drivers/nvme/target/admin-cmd.c   |  2 +-
>   drivers/nvme/target/configfs.c    | 28 ++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c        | 18 ++++++++++++++++--
>   drivers/nvme/target/discovery.c   |  2 +-
>   drivers/nvme/target/fabrics-cmd.c |  5 ++---
>   drivers/nvme/target/nvmet.h       |  6 ++++--
>   drivers/nvme/target/passthru.c    |  2 +-
>   drivers/nvme/target/rdma.c        | 10 ++++++++++
>   include/linux/nvme-rdma.h         |  6 +++++-
>   include/linux/nvme.h              |  2 --
>   11 files changed, 82 insertions(+), 18 deletions(-)
> 

