Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFCAC47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 19:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2016135C
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 19:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2016135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDSAzNrj/1s2NIXlReu19MaPQh1zsBzvm5qUNdvs8kw=; b=Xf1d5gKxJ5zNrwwBqc5D9Ivfer
	hudzpJlcg7SDUXk215cEDkGTppl7bsuSgPIH2U9lBsRBvGdZ8rQpwwBtqhwmsMqQZM/w7lNDB0uvy
	HaTt+/1Ka/ViBt2XBQ3WH6W5At88yvHolR+oIjHYxRFJGGPzNudta/lubvjRMMI3t+zZMM6sRMsXP
	Zuxdypm+KaJqlCMdiWIsHjFPnJn0lkDihcrsCOlwaeAtrPZ+S/KJpywWifs1Fpvp+tZ/x8bWdl0mE
	ver+cIInM1K2i8udu+MRc1peIqdblh4wgpxUbQNx+rjDskIdW0CduIz1vyhWZHICQL7YFThFN2AGl
	AzrkKyUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmLHY-008lS3-Pw; Thu, 27 May 2021 19:03:01 +0000
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com
 ([40.107.93.73] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmK82-008ELj-QG
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 17:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft8Z8rQ8dr/sC259O9nn3ddPLMQmG1R1CTrD1tRdXm+5XrgC6bxUmMTuWRlWZNUfcELfMD/9oYem22avfT1h6ZA7I+20Dfxaob7fmznI84mTLHXMv/sDjmrqdlDmzJXdS90oWXpa+kbj+o9I+JcmGd0qlYRQxQbtu0jEO/INdfStl2Qiyd/YmBBwiKL7NGfxZ2og/++3yVfinT2l7VcU+UnLQZjgttxdgvvYbTwoc9XLe3LGb9o2nikgcUqftUhSdd4EmMfmAz/bsgiCTQa4a4n+IYAO8jERnGnsxP7x/nEYcWXoRRCQ0Y+7+W0Q3QvfE3N46CrF5kD+PwjIu9mazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUORhu6ZIlF+7WhjHQcL4HGsUUw/mjIW0xvtcaEFMVc=;
 b=lPnR7sXU0lPaw80GTYlVQHokk0JjWUTFB8qV0UpDAyNjV2f8MbBTG+5PJmhqAJ9aUl/q6OvpqnLo1F7ETgsw4LqXFyFqznZz9psv7ai+N3tCI7Jl4h46T63HP4HFD0ruOHvoDg7DqvKUgIrDY/iqad+8QkKm5JdztkOlahZV/fNPnIz7c1kSd41DHvmuilxRGkQ5OjwgYkQNouBmh1fOc5+/m6BJ8KkyXIu58eix5uslLbzHZKs9nADRF1kVNXbwMLHZSWqxxHSZKnEPTs0PG4ljwkM+ax+072WTPgDfsF34rvS1X3dvYRlziwxPqO9CTquP6B16QXDR3I06dUammw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUORhu6ZIlF+7WhjHQcL4HGsUUw/mjIW0xvtcaEFMVc=;
 b=k3lxLrIwaq/rVEf2ejr9zYPg5t9g1hzqwlw/pdhghMPbys+znvqULjLLCb84PLQSKrSsnSPm7oQyCfSEAtlZiO6pmw0JXc0I3omx3HNo5pVnr0lJC/j0zPwwByBfFkh+ePYXRUC9nZhngL9eIaPOXlxJj2qNmDjjSWs7SaSK/xfhuYa2t0dYdl4cj9ZVBwuNflWj8i7VGUwx9FeOWfPlRWcw1+iN8Op9J0j0kGnY+eVpqxyqrjbDNj8iIjCG1ilMNQ2ZIjeimT7dq3Kaz14HqOm0lIqTl57V/kpO7J47aeJXTt1pI7UH0cQ564bMjtAp6KqEbPC1mdUQ1lkBU6jptg==
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by DM6PR12MB3338.namprd12.prod.outlook.com (2603:10b6:5:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 17:49:04 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::23) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 17:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 17:49:04 +0000
Received: from [172.27.15.200] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 17:49:02 +0000
Subject: Re: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
To: "Walker, Benjamin" <benjamin.walker@intel.com>, Christoph Hellwig
 <hch@infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Israel Rukshin <israelr@nvidia.com>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
 <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
 <YK5W7F5DD4grBZLB@infradead.org>
 <3c944010-a9e7-cab2-07ad-78d50c8bd82f@nvidia.com>
 <YK5wh91yAcOlu+3J@infradead.org>
 <638819e9-8d4f-7b00-41f3-75062e4c076d@nvidia.com>
 <BYAPR11MB282487506792423203DCD350EF239@BYAPR11MB2824.namprd11.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <719b3040-a3de-ab26-425b-d5ec3a1532db@nvidia.com>
Date: Thu, 27 May 2021 20:48:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB282487506792423203DCD350EF239@BYAPR11MB2824.namprd11.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9245c200-8868-4768-4d08-08d92137b848
X-MS-TrafficTypeDiagnostic: DM6PR12MB3338:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33387E22DF9E32BEEE8FBD72DE239@DM6PR12MB3338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0POgPGYnRZHLvpuVdY62v4KcGUKf+ziJ/zAAB6wqq9bUTLkLxtfhkajJc9Mk1xC4mUBLZ4/8l1EqZkHk1Rfc6+zY2apEtxCWXC5VZObtJB3FEq9jmS57U4uoI009pzvuABq/8ir2eYxVn5/gxjTidXYc74NUSEZLqS1BNLaBSzndVEgA61uDk9ub5l8F2lRy3svP8Ki2V1OclsRhVqVKA5Ydn0jEYo8ux6zcejgje+1glrYvxBHxMnU6NQ1dNX9dvQYpyWswUkYmpF7oPai40+aWYInSPVVBhpGYAVS13evSUHJg8Y/c14r2/aWCc4B75/afpSisLY6Rt4/uoZ51P8gDF5n2eX2xUD/KeyJ8wvvpjim++J9hM9WtdsADE/lGpspiJ8jGAW5BJPjRktrN3+DxWZ/FLChMcnR+rEKs/tuAYsE0Lwd1kG2RUL+7UjF4JZnjaWLAiAjdbp+/4Bh31LhPfVi+yQcCapF29UEU3KAv3tIV5fTuUEq8EykfFs6e8RMyXMEBcTi375of3pN0CziaAT0JJJzd7qVP2YQP54CqK2IxqeFtT0okRY5eYIyVRSE4ZGaOejb8sQ8aOvxOwPrL98sMqQjTXqcS7EG0e9CYfn0xUEXJ76UOR8NOMzBOJ1mfmvRp5D6NvHdgukNru/riFrgOTUaky4dsZ/0YAF/qSDXoxmdgjrnXfFo21oxG
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(478600001)(336012)(426003)(36906005)(8936002)(356005)(31686004)(4326008)(6666004)(47076005)(36860700001)(16576012)(2616005)(107886003)(5660300002)(316002)(31696002)(16526019)(186003)(86362001)(82310400003)(70206006)(2906002)(8676002)(110136005)(54906003)(82740400003)(7636003)(70586007)(26005)(53546011)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 17:49:04.6011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9245c200-8868-4768-4d08-08d92137b848
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3338
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_104906_957638_909F4AB4 
X-CRM114-Status: GOOD (  20.19  )
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


On 5/27/2021 8:43 PM, Walker, Benjamin wrote:
>> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>   
>> On 5/26/2021 7:00 PM, Christoph Hellwig wrote:
>>> On Wed, May 26, 2021 at 05:49:41PM +0300, Max Gurtovoy wrote:
>>>>> We do need for_each_sg here indeed, but you also need to keep
>>>>> incrementing sge for each loop iteration.  I think we can also drop
>>>>> the scat local variable with just a single users and all the
>>>>> renaming while we're at it.
>>>> Is the above fixing the issue ?
>>>>
>>>> Seems like code refactoring to me, right ?
>>> It fixes support for chained SGLs when using inline segments.  Not
>>> sure if it fixes the original bug report, but the current code is broken.
>> ohh, I see the usage of sg_next is missing.
>>
>> Well the original bug is for sure using inline chained SGLs but I thought it's using
>> 2 sg_nents and NVME_INLINE_SG_CNT == 2.
>>
>> maybe there is a split and the IO is using sg_nents == 3 ? and then we chain.
>>
>> Let's wait for Ben's test report (Ben please make sure to fix Sagi's suggestion
>> with Christoph's comment in your test).
> This patch fixes the bug:
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 37943dc4c2c1..6a3f7f6bd1ab 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1320,16 +1320,17 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
>                  int count)
>   {
>          struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> -       struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
> +      struct scatterlist *sgl, *scat = req->data_sgl.sg_table.sgl;
>          struct ib_sge *sge = &req->sge[1];
>          u32 len = 0;
>          int i;
>
> -       for (i = 0; i < count; i++, sgl++, sge++) {
> +      for_each_sg(scat, sgl, count, i) {
>                  sge->addr = sg_dma_address(sgl);
>                  sge->length = sg_dma_len(sgl);
>                  sge->lkey = queue->device->pd->local_dma_lkey;
>                  len += sge->length;
> +              sge++;

good news.

So either we use the sge[i].length or sge++.

Both will do the job.


>          }

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
