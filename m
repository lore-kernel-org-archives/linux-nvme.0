Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16FCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:17:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D46D6112D
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D46D6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=htu35/Ha1/yITC+5n2jXoTf3L1f+fLWy1kpfZjw6el0=; b=CwTQbybMwX2TcRRj0BTsXu6URN
	oIBmYVJ8mICCmuISAS+tPvV7jzaEpjHw81Qq0j+9GR5PViFr6rL6WdR42RNmbtipIq/QKwzvF2FPe
	zlT0MuapxS4IXG+wfxi8FGA1XW8wI7d/sRjO7T/NsWAYCBQArBumPX9uJNxLDLW577q7qRe2h7NOO
	kEVYH+gchoXhZXqyEuUzIDBQexLOY/YvzXo70ygfI2bRFVtCT4g3pZZh1CW9NIdD1xw9ldRm20Qfc
	lbFjQxLhT0ZYX/JiCX2CO5k9ISYCLaGgSKYu9dd04Igud50WA23GJHcg3yuwqvNOa1S1tPeOCP0bl
	c2B12UUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcozd-001Nu5-8z; Tue, 19 Oct 2021 13:17:25 +0000
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com
 ([40.107.237.52] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoza-001NtB-6P
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 13:17:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiVQ2JBLk80gxlcG82mlAGVyRKR6XB9+cOYH3PezQJaRGRHKugk56M9xuGck21T/eagBhj36mHkxw9GxVGx4NAhC/jTysSk4fviXx/InY3p9fBnkSZ1lrLPf7Fw1OXsW3LzDn3U8YKPD96Z3sP8RQgvcY4QoMEnKGJ+ZFBac2AozU9X7XXMXifQP0Cx1bUFb+CR0lVy7dbxxcpPzQktWv1E380K0dRjrKtjw63oGchuZpsHpTIxsRCZ3AVWude7/m23DRTFl7R6+XOCH8DiI0tyfvU54O6dhACdzA0jEcU8oZ1DdQGDUkdTvTKSP9mbR46wqA0KA0IuAG0Ts2i8R7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htu35/Ha1/yITC+5n2jXoTf3L1f+fLWy1kpfZjw6el0=;
 b=H5x0e88U7BIQms+bK5+gFTq0KOlf9bDXL/t9ZX0ASHTTijGtPIw65Yub/qsUiShYbWp/YPfZODFs2IoUoCzgaBgR4KZqBWIoOsdMTJJsMfOhsGHvYd66ErH6ZEfU0T7YardbEulyK/rBi9Y4WTo0Xnn95uQOQ0jVnEkbjHv4eU/ZD8vwitYaZz5AJ72HQGFGRlqPirL2AjKPhK7hkbO1QY2f4wDlMgqVuCMWy1YyWKpd8J2daFAtQiCkqZVIAu7q0CgK5n3R9u4nDI+QvQn1dzUjDK8pt7qhLPzZ/0o/T9uuGmxZ3N0zRqfmHjedvx7FilfxKwAnZvVDFxlK6yP77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htu35/Ha1/yITC+5n2jXoTf3L1f+fLWy1kpfZjw6el0=;
 b=fbGB70HGKPZMcMtGj00jDb3kMc98cTAv/VfCRBF6TepBYYG5unkrfFrerO3vIFB6RhKwSCyy9kY5ea1LUGiYEsKCOkpU9Nx+IENrm6jszN83XaDYbYQtDU8m2R8vkOIE01/w3CQmOkT7gDW0zhsZ/PDxGLCIYbhTssoraea2VJvR4s1k8e/5O+JAzxJ0Wu7BT8qA53hxszHQp2unAiVR98sLs3lXJx9oq60bPcRhWwHdnS9wKzhsYDlky2uyHNwgMYZggMsl7b0+rG/ln0UAR4TdJ6ARWXf+QiacLKAbwU1xT+mKP0LG1qSUoZRqCB4zH3vJh14KqGyNG06llRNsyA==
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 13:17:19 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::56) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Tue, 19 Oct 2021 13:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 13:17:18 +0000
Received: from [172.27.13.79] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 19 Oct
 2021 13:17:15 +0000
Message-ID: <7ed884cd-7f54-a719-36dd-5151655d05da@nvidia.com>
Date: Tue, 19 Oct 2021 16:17:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/7] nvme/nvme-fabrics: introduce nvmf_error_recovery_work
 API
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>, <kbusch@kernel.org>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-6-mgurtovoy@nvidia.com>
 <f170b07c-0307-eeb4-72d8-196a471b660b@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <f170b07c-0307-eeb4-72d8-196a471b660b@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f79b81f-b819-44b9-99ed-08d99302c727
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:
X-Microsoft-Antispam-PRVS: <DM5PR12MB243975C22CED435561C0D4D9DEBD9@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPLFCZWFFGVpV7hACr/VvYQUqXPK9bndoqKoLFO3Nco8swn5yOclj0PyatWZ4ZSyOuAtAeG70zBI9+ROcUQEI9GTgVGIINKR7kpgeb3jC7EOICadboOXyuoJhHDQXlOzOkw4cqT6RkwXM7GapGYeMXhJcFH69bBuk+IdABNmupose++cDy1d5i/WnTZqDEgYzOSex8uSOR6dITV6QCM/tbRrP7k2aPPCuJDkutomj65X4Y4HK2kOq9WSNH2ogEgRtDxAOwnhWv4yn8IHeskrLCaTCDz8qQ7jze9OeaXlELPsOYd/ytz2pu567I1+sgvdVmwLJnOvvJWODqV47rNZ6DYuwSasT0hx53YpcXxLp2fU37NwYV1pjjtVvbEV9R6jzMIQsEe47JBTQBqbpu8Fa1CmCjoLa7J7jEtUuU52jI5MVxkzftR+amoPANAtZDC6ZO8NYogbzeEyUExSk2y7DsFuKywbF5Vcwiqw74vhMxMTk29AxYNCLQI89+k/aibsP3Wqy1kZ7geILXZrO/7LT5SAxOQ9J+F49JJQHHJlTXF5tAPHTzWAAgYejUs6aEfm+EBIQG93H3OjtW7MVtEAXZhO1QEkaWFxDgDa4tC5FRNeFhu/kxmtqCqq7Wd/nbcbAPqDGsGZ18N0/pUcQeQtVGOrdqpw9KCRyCBAREQz9x53ULy2R6vdXhdC8ng/OWWNKzURteMKgiYxHGjrID3/AfR1A2+O8x3OZG/Fyc7Nw7w=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(82310400003)(31696002)(16526019)(83380400001)(70586007)(53546011)(426003)(316002)(186003)(2616005)(26005)(54906003)(356005)(110136005)(336012)(31686004)(36860700001)(8676002)(16576012)(6666004)(7636003)(70206006)(4326008)(508600001)(5660300002)(47076005)(2906002)(36906005)(36756003)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 13:17:18.5477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f79b81f-b819-44b9-99ed-08d99302c727
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_061722_329730_3F25360D 
X-CRM114-Status: GOOD (  19.75  )
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


On 10/19/2021 3:43 PM, Sagi Grimberg wrote:
>
>
> On 10/18/21 4:40 PM, Max Gurtovoy wrote:
>> Error recovery work is duplicated in RDMA and TCP transports. Move this
>> logic to common code. For that, introduce 2 new ctrl ops to teardown IO
>> and admin queue.
>>
>> Also update the RDMA/TCP transport drivers to use this API and remove
>> the duplicated code.
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/fabrics.c | 23 +++++++++++++++
>>   drivers/nvme/host/fabrics.h |  1 +
>>   drivers/nvme/host/nvme.h    |  4 +++
>>   drivers/nvme/host/rdma.c    | 56 ++++++++++++++++---------------------
>>   drivers/nvme/host/tcp.c     | 56 +++++++++++++++----------------------
>>   5 files changed, 75 insertions(+), 65 deletions(-)
>
> Diffstat dry stats are not in your favor...
>
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 2edd086fa922..544195369c97 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -493,6 +493,29 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl 
>> *ctrl)
>>   }
>>   EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
>>   +void nvmf_error_recovery_work(struct work_struct *work)
>> +{
>> +    struct nvme_ctrl *ctrl = container_of(work,
>> +                struct nvme_ctrl, err_work);
>> +
>> +    nvme_stop_keep_alive(ctrl);
>> +    ctrl->ops->teardown_ctrl_io_queues(ctrl);
>> +    /* unquiesce to fail fast pending requests */
>> +    nvme_start_queues(ctrl);
>> +    ctrl->ops->teardown_ctrl_admin_queue(ctrl);
>> +    blk_mq_unquiesce_queue(ctrl->admin_q);
>> +
>> +    if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
>> +        /* state change failure is ok if we started ctrl delete */
>> +        WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
>> +                 ctrl->state != NVME_CTRL_DELETING_NOIO);
>> +        return;
>> +    }
>> +
>> +    nvmf_reconnect_or_remove(ctrl);
>
> We need James to provide feedback how can this be useful for FC.
>
>> +}
>> +EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
>> +
>>   void nvmf_error_recovery(struct nvme_ctrl *ctrl)
>>   {
>>       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index 3d8ec7133fc8..8655eff74ed0 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -190,6 +190,7 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char 
>> *buf, int size);
>>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>>   void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
>>   void nvmf_error_recovery(struct nvme_ctrl *ctrl);
>> +void nvmf_error_recovery_work(struct work_struct *work);
>>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>>           struct nvmf_ctrl_options *opts);
>>   diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index f9e1ce93d61d..1573edf6e97f 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -493,6 +493,10 @@ struct nvme_ctrl_ops {
>>       void (*submit_async_event)(struct nvme_ctrl *ctrl);
>>       void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>>       int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>> +
>> +    /* Fabrics only */
>> +    void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl);
>> +    void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl);
>
> This becomes strange that we have teardown without a setup callback...

We can do it incrementally.

It's not the first time we do it :)

>
>>   };
>>     /*
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 1c57e371af61..f4e4ebf673d2 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1031,6 +1031,11 @@ static void 
>> nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
>>       nvme_rdma_destroy_admin_queue(ctrl, remove);
>>   }
>>   +static void _nvme_rdma_teardown_admin_queue(struct nvme_ctrl *ctrl)
>> +{
>> +    nvme_rdma_teardown_admin_queue(to_rdma_ctrl(ctrl), false);
>> +}
>> +
>>   static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
>>           bool remove)
>>   {
>> @@ -1046,6 +1051,11 @@ static void 
>> nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
>>       }
>>   }
>>   +static void _nvme_rdma_teardown_io_queues(struct nvme_ctrl *ctrl)
>> +{
>> +    nvme_rdma_teardown_io_queues(to_rdma_ctrl(ctrl), false);
>> +}
>> +
>>   static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>>   {
>>       struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
>> @@ -1164,27 +1174,6 @@ static void 
>> nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
>>       nvmf_reconnect_or_remove(&ctrl->ctrl);
>>   }
>>   -static void nvme_rdma_error_recovery_work(struct work_struct *work)
>> -{
>> -    struct nvme_rdma_ctrl *ctrl = container_of(work,
>> -            struct nvme_rdma_ctrl, ctrl.err_work);
>> -
>> -    nvme_stop_keep_alive(&ctrl->ctrl);
>> -    nvme_rdma_teardown_io_queues(ctrl, false);
>> -    nvme_start_queues(&ctrl->ctrl);
>> -    nvme_rdma_teardown_admin_queue(ctrl, false);
>> -    blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>> -
>> -    if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
>> -        /* state change failure is ok if we started ctrl delete */
>> -        WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
>> -                 ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
>> -        return;
>> -    }
>> -
>> -    nvmf_reconnect_or_remove(&ctrl->ctrl);
>> -}
>> -
>>   static void nvme_rdma_end_request(struct nvme_rdma_request *req)
>>   {
>>       struct request *rq = blk_mq_rq_from_pdu(req);
>> @@ -2240,16 +2229,19 @@ static void nvme_rdma_reset_ctrl_work(struct 
>> work_struct *work)
>>   }
>>     static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
>> -    .name            = "rdma",
>> -    .module            = THIS_MODULE,
>> -    .flags            = NVME_F_FABRICS | NVME_F_METADATA_SUPPORTED,
>> -    .reg_read32        = nvmf_reg_read32,
>> -    .reg_read64        = nvmf_reg_read64,
>> -    .reg_write32        = nvmf_reg_write32,
>> -    .free_ctrl        = nvme_rdma_free_ctrl,
>> -    .submit_async_event    = nvme_rdma_submit_async_event,
>> -    .delete_ctrl        = nvme_rdma_delete_ctrl,
>> -    .get_address        = nvmf_get_address,
>> +    .name                = "rdma",
>> +    .module                = THIS_MODULE,
>> +    .flags                = NVME_F_FABRICS |
>> +                      NVME_F_METADATA_SUPPORTED,
>> +    .reg_read32            = nvmf_reg_read32,
>> +    .reg_read64            = nvmf_reg_read64,
>> +    .reg_write32            = nvmf_reg_write32,
>> +    .free_ctrl            = nvme_rdma_free_ctrl,
>> +    .submit_async_event        = nvme_rdma_submit_async_event,
>> +    .delete_ctrl            = nvme_rdma_delete_ctrl,
>> +    .get_address            = nvmf_get_address,
>> +    .teardown_ctrl_io_queues    = _nvme_rdma_teardown_io_queues,
>> +    .teardown_ctrl_admin_queue    = _nvme_rdma_teardown_admin_queue,
>>   };
>>     /*
>> @@ -2329,7 +2321,7 @@ static struct nvme_ctrl 
>> *nvme_rdma_create_ctrl(struct device *dev,
>>         INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
>>               nvme_rdma_reconnect_ctrl_work);
>> -    INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
>> +    INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
>
> This initialization needs to move to the core or fabrics lib.

It's done in the next patches.


