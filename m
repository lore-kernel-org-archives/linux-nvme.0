Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E0DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 17:33:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30F161104
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 17:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C30F161104
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t0scKG1ib1ByUvNEB1mgY7LHJxZTF0pn4cTddBfcggc=; b=qPxz6PjCG9JvIEvkHXX6N5uInq
	hdM1e4cPOG8AmCPkcnlF8Gt1oXIiEMmdRHviJV+QtsOaOxKBj7/Nsbgio8CXCOg8/POrjF7tXHocA
	bhYnix3P3ao/hSz8SbxQmoAKj5rKVOBHVjbRIUfiAqLO67esv/p3E6BZRuSd1N30oQVTupVCj1WFb
	fR38ofC1kPmEQuylIAcwVaU5nIAcojOEMb/WNF6Ezkzls2URK+PtMUfxQ85bQI13Yt+eJDYBCYtnj
	GfSPcNvwDlTu7h4o2yuuwCtBbCoCyQGVllX52QDEwQqGFHGtP7TBMTQ8nI5SYNVnIRlOy/SHSFx/L
	yG0TChIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mONur-00AWVm-MI; Thu, 09 Sep 2021 17:32:49 +0000
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com
 ([40.107.93.78] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mONuo-00AWUI-Co
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 17:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moUGcP7g3gxH/E55asFu9RTcj1yT5bPKiiQ2VEvIDgjfMbqJ8o0UnjB4Hlpf/M35HMJkKIty4PXbzs9/v4yFXgbHfoUe0IQ+w9HairVJJkV3pLOTBfiCG1/ymx6VvUGJj3BBT9mImNz4ORTuQZUE16xoB0KRXduJXoTXRfWO1y7PEBOPx/hGB2+afwg52+tPruCCa3y0hX2lfkZYaKTUcakXbqy47Q0qmFlNpbv5qBcBs/4R1ZzGyGwFRjuZhEfd93vQaKHnBLIjRA8diibnEgMMETBprE8YRR0qJMjdtSqheS9IqJ8GeYJsa+NB5INDUHF7m+ZmpNwXrJDwGlz5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SYihE70K6a7YKPoYBZTo4zG1QaFnXujOvyka5P/b8VY=;
 b=WTmARf0/d6L0OSHdTp/sPJ9C1fjQxelu4YNy0+vSPUeYORcfKSSGRtM4EtyR3iw1VCAJlbNUhl22JqDjV8UJnL2yj6/BgbrjMLTpjX+UFnd1+qLaJKF1Ww9hE9rB5hGGEQ7LmWR2YGQxRIFQU4MZ4tkoBtsR5AaTgyQwBXHSWwtwq+uAvTKwcNpaCsZ09GKMGelzDrYm8jHdyrwIzNfrzyyqX4N6u0s8waY8lFh9dhkPppK8AhcZKRrrzDrCsfbIebv8TbPUjK2lL1maGRDPTORZTY2Rj3n4sUu6T7E1dMHch++5U9Nh8E90pgp88EAxSd3MSaVNaUL3TgBxBg8sTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYihE70K6a7YKPoYBZTo4zG1QaFnXujOvyka5P/b8VY=;
 b=sxnh17qGC5mL5mvlie1FHn4xByEjVEJTkac3maCQNEqUEMPsXOQQhDX/RF9GiL3WBPuCBJlrB8/xSzZWNGcMrlXhjPQYYoR0qDjU4rLos7bG+nZBpD/HXqATmiTscRfDcq3GznGUjcjhnvhnuQqwcApB3QC8ONZ5uoLL7M5H+GxJkv/ruudQl2FqEvHOjSAhKuJ6tqEKkNuF1SRomS89TW3yqYphCmDxZwXkFcCN3f+5kyoPbzE06hkxl7lHd6KuWlpMTLTtVEpEk01sRMxDbTchxLay+JwiVOUGMXFizs58A6+KFk2JRWLxXMN6yXR/sY7Y4NyA0RH/EchPtYL12w==
Received: from MWHPR03CA0014.namprd03.prod.outlook.com (2603:10b6:300:117::24)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 17:32:44 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::4b) by MWHPR03CA0014.outlook.office365.com
 (2603:10b6:300:117::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Thu, 9 Sep 2021 17:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 17:32:43 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep
 2021 17:32:42 +0000
Received: from [172.27.14.161] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep
 2021 17:32:41 +0000
Subject: Re: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid
 use after free
To: Christoph Hellwig <hch@infradead.org>, Ruozhu Li <liruozhu@huawei.com>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>
References: <20210906035134.14789-1-liruozhu@huawei.com>
 <20210906035134.14789-2-liruozhu@huawei.com> <YToUji9WujpL9vnt@infradead.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <90356fc2-837c-0ba2-5fcf-d9e9dcc06dba@nvidia.com>
Date: Thu, 9 Sep 2021 20:32:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YToUji9WujpL9vnt@infradead.org>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3ee8f39-3962-4bb5-f40d-08d973b7d4ea
X-MS-TrafficTypeDiagnostic: PH0PR12MB5404:
X-Microsoft-Antispam-PRVS: <PH0PR12MB540465D1BCF3998541437E26DED59@PH0PR12MB5404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQvAaEaOaEWtsObXJ+8TllLvT5HMnm3MAG8FKtI9oKRk4eV9716Gag95BD2Ih26cbNmdr4Sk4FO0OUOVF4juy1mwC0s5wZnqI7F9G4n4zY1jWgr9E4gVRD0sOghTG72iVcosWy2G5OUBtJaDer024q2BQ6BU5QP7xMIO/4OocXcr6blve91cWTScmew23lmmXeXzgklxDMYQHpiRMUFJRHGAPfRT06QV8V7fYUvAdkeLB+qgt0fXhGVHPoaIgTgoh4QTE50fzVRkeQ7GjwY/kPBKjK1DNKSnlxDGUf5slVvzCky3pnEoic+ndEFB77ekwERC9eT2Zfm13bvGSLeCanNzu67MxRDJYT0+4iajlRYDXZHzHUBRhHIh1jVRpFR8stNy7C1oVL9nxYjzJ2Xujfmp376W0HYB+brgJ2LDGYqPgzVJxsCQ/wP0pWPdUNcV9w8n00wpQKbJNOyBAR8BtzCLoFHPw6L2Jx0F50j+qqu0vJ/haC2I/b9ZC6ysr7Ostems64scn4q7rbwwhDSnuqM7/ri46wLS4N9jmGizV2KrDS6mnXWKR+ArZeQm4X0b3j26hGcblaiXzlOzBmp6gkcAHkycEeilK3hsmfqTi+xlvcnBBD6Avqsk6mXVOeZoID7ndW/PrAhLLM2SWL/8omcHaSOuJkkw4kpsoCLA6QK76LUqI2nB41ZVQfU33jt+LkeO2mR/lWjON3l7ASqGRYZdWCt9NdokfhlsQuT9XdUIO0lwflb8XlaS6IG8u/b5iRGOCbxCz9nO4HSzDCdCZIt5XMtu0tKC7ypFZvYL12HZ2VlvaisB+1JdeeaMNlkN
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(186003)(426003)(70206006)(2906002)(53546011)(5660300002)(7636003)(356005)(26005)(31696002)(8936002)(86362001)(36860700001)(47076005)(966005)(508600001)(16576012)(4326008)(36756003)(316002)(82310400003)(8676002)(2616005)(31686004)(336012)(83380400001)(16526019)(36906005)(54906003)(6666004)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 17:32:43.6913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ee8f39-3962-4bb5-f40d-08d973b7d4ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_103246_517165_117DC3A4 
X-CRM114-Status: GOOD (  17.44  )
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


On 9/9/2021 5:05 PM, Christoph Hellwig wrote:
> This looks reasonable to me.  Sagi, Max: any comments?
>
> On Mon, Sep 06, 2021 at 11:51:34AM +0800, Ruozhu Li wrote:
>> We should always destroy cm_id before destroy qp to avoid to get cma
>> event after qp was destroyed, which may lead to use after free.

Do you really encounter use-after-free ?

I think the code looks correct but from experience with RDMA-CM I would 
like to know which tests did you run with this code ?

interesting tests are: port toggling with/without IO, unload 
mlx5/other_rdma_hw drivers during connection establishment or during IO, 
reboot target, reboot target during connection establishment, reboot 
target during IO.

Thanks.


>> In RDMA connection establishment error flow, don't destroy qp in cm
>> event handler.Just report cm_error to upper level, qp will be destroy
>> in nvme_rdma_alloc_queue() after destroy cm id.
>>
>> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
>> ---
>>   drivers/nvme/host/rdma.c | 16 +++-------------
>>   1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index a68704e39084..042c594bc57e 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -656,8 +656,8 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
>>   	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
>>   		return;
>>   
>> -	nvme_rdma_destroy_queue_ib(queue);
>>   	rdma_destroy_id(queue->cm_id);
>> +	nvme_rdma_destroy_queue_ib(queue);
>>   	mutex_destroy(&queue->queue_lock);
>>   }
>>   
>> @@ -1815,14 +1815,10 @@ static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
>>   	for (i = 0; i < queue->queue_size; i++) {
>>   		ret = nvme_rdma_post_recv(queue, &queue->rsp_ring[i]);
>>   		if (ret)
>> -			goto out_destroy_queue_ib;
>> +			return ret;
>>   	}
>>   
>>   	return 0;
>> -
>> -out_destroy_queue_ib:
>> -	nvme_rdma_destroy_queue_ib(queue);
>> -	return ret;
>>   }
>>   
>>   static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
>> @@ -1916,14 +1912,10 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
>>   	if (ret) {
>>   		dev_err(ctrl->ctrl.device,
>>   			"rdma_connect_locked failed (%d).\n", ret);
>> -		goto out_destroy_queue_ib;
>> +		return ret;
>>   	}
>>   
>>   	return 0;
>> -
>> -out_destroy_queue_ib:
>> -	nvme_rdma_destroy_queue_ib(queue);
>> -	return ret;
>>   }
>>   
>>   static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>> @@ -1954,8 +1946,6 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>>   	case RDMA_CM_EVENT_ROUTE_ERROR:
>>   	case RDMA_CM_EVENT_CONNECT_ERROR:
>>   	case RDMA_CM_EVENT_UNREACHABLE:
>> -		nvme_rdma_destroy_queue_ib(queue);
>> -		fallthrough;
>>   	case RDMA_CM_EVENT_ADDR_ERROR:
>>   		dev_dbg(queue->ctrl->ctrl.device,
>>   			"CM error event %d\n", ev->event);
>> -- 
>> 2.16.4
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
> ---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
