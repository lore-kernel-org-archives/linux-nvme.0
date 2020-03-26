Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD90C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 22:14:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24D520658
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 22:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oEnwgWgH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GqUjL3jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24D520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5VPI6uAqQ74kUtIp2JzbMIg+UIm65J7FvU0URlfuDxw=; b=oEnwgWgHRSRUPunK9abiACweS
	APzW7HfYv/t+kZzuLB6204g0o2m90MgwiihpsJPswAMuc10pJP0PBcdKtFY1pyg97yJly35QYLPri
	ijJCFXMZXZP0qkEGZQ7h9/am5L/giTFbDZUp4OIo6xrLlRzTZjvyjCKpiGPlwhLwkyeqab4fVCFRZ
	51jAdueQ8MBSPfO6vRT8Qf2Bm7IZg10C5Eyv6kebY0CHtwN0+a/XXWIisOhvSX+c9kSE7zQNFcOln
	iGywZxay/GZv2cDqPEostiUzMK91FIS+UE0VjJyi7XjJHMhznurrKRdD2UljbH4MEyTOOGon2Az5E
	3JSIN0vjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHaln-00010j-3o; Thu, 26 Mar 2020 22:14:35 +0000
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHali-000109-Pi
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 22:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9+b1Qm8EPMOQRxRfP/+GsOnlu1bxmkvk81EoKy0gvPp2VMHzl7GrTCFLDWxCoREoxjhqceTtLrUOfTfC0///7D007lPPZ1diKKSAehHrsuax0uyvaBLUx/obPPGgtap/VzXV/RjlWPzBFW6OQ5FnQc0XykFOoXowPXRg5wCDiJz5T4Xfvz1RKDjs+GSzBGLBD4AaFYrPx5fA1e45uJIVlsvOEs5CEBolNGj8FzlQ02V2HQO3HbXKuAxzaih3Qh3CDDzLccWI+LqkYgO0iQoK6A4GzECToT5QBP/xeqUAinDtTMzOBVYwOS4LkDmsXrRA3f1JQXNfWdXDl4Uip/1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtsFY5QtuYK644aXScsXNQ6hbGlOMoQJQK/0+TShBfE=;
 b=A8AMkpBbYl83d1iDkn47EksD+b99jM1qx6YiIKnhs5S2Een7Sn1LQvSw9tKIy/uUWS2VdA9x2d1rhFGXWoxsCYD94mrze2WwFG/hO1/H4yXfT5YEKM6pW1m4HPESb7fYin14u/fsW4CsX6vYaZKkyw6cg+IB3438Vh6iuk9gqaQoX2zwSGwhQG5iHPCytnHIpXisYSHozSeoM8q6QumPQvYitAlLGO0u/es2UuQAlYO+aXx5ld2O5UNKhk5kMybwPJkcdLhg8HmKbvtYMFd+IBs0+rbmX8L54G08EwiiqwqW4D+YjWf7O1NDfmlmc2tbdlOknAVAuUapRZJ3PZ9oLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=acm.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtsFY5QtuYK644aXScsXNQ6hbGlOMoQJQK/0+TShBfE=;
 b=GqUjL3jopouMbumodSCJDtn5ptf87c/sBBpfyJiU1sOmOL6jUQSxq2pDa/PPd7UfUNKeqOaeJT2wPKrBcYNWZlk05fcNKLoB76Xy/rtQdy4l2fQ95OlhqsGEq8s2JkHvffoweWzc79IKFFAKqkmW1eOJNBOm8So26jn/0DlUZMA=
Received: from AM6P195CA0047.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::24)
 by HE1PR05MB3338.eurprd05.prod.outlook.com (2603:10a6:7:2e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 22:14:25 +0000
Received: from VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::3e) by AM6P195CA0047.outlook.office365.com
 (2603:10a6:209:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 22:14:25 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT036.mail.protection.outlook.com (10.152.19.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 22:14:25 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 27 Mar 2020 00:14:24
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 27 Mar 2020 00:14:24 +0200
Received: from [172.27.0.77] (172.27.0.77) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 27 Mar 2020 00:14:22
 +0200
Subject: Re: [PATCH v4 1/1] nvmet-rdma: use SRQ per completion vector
To: Laurence Oberman <loberman@redhat.com>, <linux-nvme@lists.infradead.org>, 
 <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
References: <20200326181512.58053-1-maxg@mellanox.com>
 <62fefed0e5d459563dfd3e0e027ceef529dce803.camel@redhat.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a176a10a-2915-76a8-e672-61e764ca582a@mellanox.com>
Date: Fri, 27 Mar 2020 00:14:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <62fefed0e5d459563dfd3e0e027ceef529dce803.camel@redhat.com>
Content-Language: en-US
X-Originating-IP: [172.27.0.77]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(186003)(16526019)(26005)(110136005)(316002)(82740400003)(2906002)(2616005)(478600001)(336012)(54906003)(36906005)(53546011)(356004)(4326008)(81166006)(16576012)(70206006)(107886003)(8676002)(81156014)(5660300002)(31686004)(30864003)(8936002)(70586007)(36756003)(47076004)(86362001)(31696002)(3940600001)(21314003)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad1563e-2050-4d40-fe85-08d7d1d30b49
X-MS-TrafficTypeDiagnostic: HE1PR05MB3338:
X-Microsoft-Antispam-PRVS: <HE1PR05MB3338F1C90B22A60856150BE4B6CF0@HE1PR05MB3338.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0354B4BED2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvydTER7X7rXKhmY2xi3/PRY5obyS+A/fLG2WNcYXbPSqDeUhgibOQ8F6PqyOMReBfv9KORHR7vOYPExPtKMIqUMsUOTLgh05JCo2mGof/SnnyjgLg6gpd6Rj9SH5y75hOSq9xhPZkXsanoidJXSUJK5LNNfqcz4VZGpg6AzRfAOE9/6VXQyY1SgxVqxkBrODwW0POmHZxn9JNPf2AnyY18+h5SF5wLY6j29kSWf/z07a2SvdTpT4/rZQfxqfFnccDDRVGqaKa447tB/fk3sjACia/Jnrsaeipo10TACODd8/xfhvmUkUcCH6NJHSXtvPnVhyPthVn2RcuUpuS1sjFhoUZ8sF24Or7PJfcwfeW8zcibf84cyeLByvrrp3eAtM6+zxK9v1c1Px/Jsv8ZMRWGU3Hibm6RfijYWn5sFcjOCQWn1e8YJ6vdKioCgR5S6fr+6GjACt8GN3Hr3vdeKgyeR15cat4HWHwXdT7ZMoY45vnkuiU1xi71addfvTttGMU11lPC7yGnlIatl6vu0Ega0oUizDO7UuXy8WArOXdc6/BAvZvutF8Xn6q3ws5MOc6no3Q27C7o7aSa6S1LQiA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 22:14:25.1339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad1563e-2050-4d40-fe85-08d7d1d30b49
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3338
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_151431_047253_4A35B5F4 
X-CRM114-Status: GOOD (  15.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: shlomin@mellanox.com, jgg@mellanox.com, bvanassche@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/26/2020 8:29 PM, Laurence Oberman wrote:
> On Thu, 2020-03-26 at 20:15 +0200, Max Gurtovoy wrote:
>> In order to save resource allocation and utilize the completion
>> locality in a better way (compared to SRQ per device that exist
>> today),
>> allocate Shared Receive Queues (SRQs) per completion vector.
>> Associate
>> each created QP/CQ with an appropriate SRQ according to the queue
>> index.
>> This association will reduce the lock contention in the fast path
>> (compared to SRQ per device solution) and increase the locality in
>> memory buffers. Add new module parameter for SRQ size to adjust it
>> according to the expected load. User should make sure the size is >=
>> 256
>> to avoid lack of resources. Also reduce the debug level of "last WQE
>> reached" event that is raised when a QP is using SRQ during
>> destruction
>> process to relief the log.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>
>> changes from V3:
>>   - remove redundent NULL assingment (Sagi)
>>   - reduce log level for last wqe reached event
>> changes from V1 + V2:
>>   - removed SRQ pool
>>   - removed SRP target implementation
>>
>> ---
>>   drivers/nvme/target/rdma.c | 176 ++++++++++++++++++++++++++++++++++-
>> ----------
>>   1 file changed, 134 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 9e1b8c6..dc8a969 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -34,6 +34,8 @@
>>   /* Assume mpsmin == device_page_size == 4KB */
>>   #define NVMET_RDMA_MAX_MDTS			8
>>   
>> +struct nvmet_rdma_srq;
>> +
>>   struct nvmet_rdma_cmd {
>>   	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
>>   	struct ib_cqe		cqe;
>> @@ -41,6 +43,7 @@ struct nvmet_rdma_cmd {
>>   	struct scatterlist	inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
>>   	struct nvme_command     *nvme_cmd;
>>   	struct nvmet_rdma_queue	*queue;
>> +	struct nvmet_rdma_srq   *nsrq;
>>   };
>>   
>>   enum {
>> @@ -82,6 +85,7 @@ struct nvmet_rdma_queue {
>>   	struct ib_cq		*cq;
>>   	atomic_t		sq_wr_avail;
>>   	struct nvmet_rdma_device *dev;
>> +	struct nvmet_rdma_srq   *nsrq;
>>   	spinlock_t		state_lock;
>>   	enum nvmet_rdma_queue_state state;
>>   	struct nvmet_cq		nvme_cq;
>> @@ -99,17 +103,24 @@ struct nvmet_rdma_queue {
>>   
>>   	int			idx;
>>   	int			host_qid;
>> +	int			comp_vector;
>>   	int			recv_queue_size;
>>   	int			send_queue_size;
>>   
>>   	struct list_head	queue_list;
>>   };
>>   
>> +struct nvmet_rdma_srq {
>> +	struct ib_srq            *srq;
>> +	struct nvmet_rdma_cmd    *cmds;
>> +	struct nvmet_rdma_device *ndev;
>> +};
>> +
>>   struct nvmet_rdma_device {
>>   	struct ib_device	*device;
>>   	struct ib_pd		*pd;
>> -	struct ib_srq		*srq;
>> -	struct nvmet_rdma_cmd	*srq_cmds;
>> +	struct nvmet_rdma_srq	**srqs;
>> +	int			srq_count;
>>   	size_t			srq_size;
>>   	struct kref		ref;
>>   	struct list_head	entry;
>> @@ -121,6 +132,16 @@ struct nvmet_rdma_device {
>>   module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
>>   MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
>>   
>> +static int srq_size_set(const char *val, const struct kernel_param
>> *kp);
>> +static const struct kernel_param_ops srq_size_ops = {
>> +	.set = srq_size_set,
>> +	.get = param_get_int,
>> +};
>> +
>> +static int nvmet_rdma_srq_size = 1024;
>> +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size,
>> 0644);
>> +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size,
>> should >= 256 (default: 1024)");
>> +
>>   static DEFINE_IDA(nvmet_rdma_queue_ida);
>>   static LIST_HEAD(nvmet_rdma_queue_list);
>>   static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
>> @@ -141,6 +162,17 @@ static int nvmet_rdma_alloc_rsp(struct
>> nvmet_rdma_device *ndev,
>>   
>>   static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>>   
>> +static int srq_size_set(const char *val, const struct kernel_param
>> *kp)
>> +{
>> +	int n = 0, ret;
>> +
>> +	ret = kstrtoint(val, 10, &n);
>> +	if (ret != 0 || n < 256)
>> +		return -EINVAL;
>> +
>> +	return param_set_int(val, kp);
>> +}
>> +
>>   static int num_pages(int len)
>>   {
>>   	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
>> @@ -464,8 +496,8 @@ static int nvmet_rdma_post_recv(struct
>> nvmet_rdma_device *ndev,
>>   		cmd->sge[0].addr, cmd->sge[0].length,
>>   		DMA_FROM_DEVICE);
>>   
>> -	if (ndev->srq)
>> -		ret = ib_post_srq_recv(ndev->srq, &cmd->wr, NULL);
>> +	if (cmd->nsrq)
>> +		ret = ib_post_srq_recv(cmd->nsrq->srq, &cmd->wr, NULL);
>>   	else
>>   		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr,
>> NULL);
>>   
>> @@ -843,23 +875,40 @@ static void nvmet_rdma_recv_done(struct ib_cq
>> *cq, struct ib_wc *wc)
>>   	nvmet_rdma_handle_command(queue, rsp);
>>   }
>>   
>> -static void nvmet_rdma_destroy_srq(struct nvmet_rdma_device *ndev)
>> +static void nvmet_rdma_destroy_srq(struct nvmet_rdma_srq *nsrq)
>> +{
>> +	nvmet_rdma_free_cmds(nsrq->ndev, nsrq->cmds, nsrq->ndev-
>>> srq_size,
>> +			     false);
>> +	ib_destroy_srq(nsrq->srq);
>> +
>> +	kfree(nsrq);
>> +}
>> +
>> +static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
>>   {
>> -	if (!ndev->srq)
>> +	int i;
>> +
>> +	if (!ndev->srqs)
>>   		return;
>>   
>> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size,
>> false);
>> -	ib_destroy_srq(ndev->srq);
>> +	for (i = 0; i < ndev->srq_count; i++)
>> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
>> +
>> +	kfree(ndev->srqs);
>>   }
>>   
>> -static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>> +static struct nvmet_rdma_srq *
>> +nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>>   {
>>   	struct ib_srq_init_attr srq_attr = { NULL, };
>> +	size_t srq_size = ndev->srq_size;
>> +	struct nvmet_rdma_srq *nsrq;
>>   	struct ib_srq *srq;
>> -	size_t srq_size;
>>   	int ret, i;
>>   
>> -	srq_size = 4095;	/* XXX: tune */
>> +	nsrq = kzalloc(sizeof(*nsrq), GFP_KERNEL);
>> +	if (!nsrq)
>> +		return ERR_PTR(-ENOMEM);
>>   
>>   	srq_attr.attr.max_wr = srq_size;
>>   	srq_attr.attr.max_sge = 1 + ndev->inline_page_count;
>> @@ -867,35 +916,71 @@ static int nvmet_rdma_init_srq(struct
>> nvmet_rdma_device *ndev)
>>   	srq_attr.srq_type = IB_SRQT_BASIC;
>>   	srq = ib_create_srq(ndev->pd, &srq_attr);
>>   	if (IS_ERR(srq)) {
>> -		/*
>> -		 * If SRQs aren't supported we just go ahead and use
>> normal
>> -		 * non-shared receive queues.
>> -		 */
>> -		pr_info("SRQ requested but not supported.\n");
>> -		return 0;
>> +		ret = PTR_ERR(srq);
>> +		goto out_free;
>>   	}
>>   
>> -	ndev->srq_cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
>> -	if (IS_ERR(ndev->srq_cmds)) {
>> -		ret = PTR_ERR(ndev->srq_cmds);
>> +	nsrq->cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
>> +	if (IS_ERR(nsrq->cmds)) {
>> +		ret = PTR_ERR(nsrq->cmds);
>>   		goto out_destroy_srq;
>>   	}
>>   
>> -	ndev->srq = srq;
>> -	ndev->srq_size = srq_size;
>> +	nsrq->srq = srq;
>> +	nsrq->ndev = ndev;
>>   
>>   	for (i = 0; i < srq_size; i++) {
>> -		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
>> +		nsrq->cmds[i].nsrq = nsrq;
>> +		ret = nvmet_rdma_post_recv(ndev, &nsrq->cmds[i]);
>>   		if (ret)
>>   			goto out_free_cmds;
>>   	}
>>   
>> -	return 0;
>> +	return nsrq;
>>   
>>   out_free_cmds:
>> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size,
>> false);
>> +	nvmet_rdma_free_cmds(ndev, nsrq->cmds, srq_size, false);
>>   out_destroy_srq:
>>   	ib_destroy_srq(srq);
>> +out_free:
>> +	kfree(nsrq);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
>> +{
>> +	int i, ret;
>> +
>> +	if (!ndev->device->attrs.max_srq_wr || !ndev->device-
>>> attrs.max_srq) {
>> +		/*
>> +		 * If SRQs aren't supported we just go ahead and use
>> normal
>> +		 * non-shared receive queues.
>> +		 */
>> +		pr_info("SRQ requested but not supported.\n");
>> +		return 0;
>> +	}
>> +
>> +	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
>> +			     nvmet_rdma_srq_size);
>> +	ndev->srq_count = min(ndev->device->num_comp_vectors,
>> +			      ndev->device->attrs.max_srq);
>> +
>> +	ndev->srqs = kcalloc(ndev->srq_count, sizeof(*ndev->srqs),
>> GFP_KERNEL);
>> +	if (!ndev->srqs)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < ndev->srq_count; i++) {
>> +		ndev->srqs[i] = nvmet_rdma_init_srq(ndev);
>> +		if (IS_ERR(ndev->srqs[i]))
>> +			goto err_srq;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_srq:
>> +	while (--i >= 0)
>> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
>> +	kfree(ndev->srqs);
>>   	return ret;
>>   }
>>   
>> @@ -908,7 +993,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>>   	list_del(&ndev->entry);
>>   	mutex_unlock(&device_list_mutex);
>>   
>> -	nvmet_rdma_destroy_srq(ndev);
>> +	nvmet_rdma_destroy_srqs(ndev);
>>   	ib_dealloc_pd(ndev->pd);
>>   
>>   	kfree(ndev);
>> @@ -954,7 +1039,7 @@ static void nvmet_rdma_free_dev(struct kref
>> *ref)
>>   		goto out_free_dev;
>>   
>>   	if (nvmet_rdma_use_srq) {
>> -		ret = nvmet_rdma_init_srq(ndev);
>> +		ret = nvmet_rdma_init_srqs(ndev);
>>   		if (ret)
>>   			goto out_free_pd;
>>   	}
>> @@ -978,14 +1063,7 @@ static int nvmet_rdma_create_queue_ib(struct
>> nvmet_rdma_queue *queue)
>>   {
>>   	struct ib_qp_init_attr qp_attr;
>>   	struct nvmet_rdma_device *ndev = queue->dev;
>> -	int comp_vector, nr_cqe, ret, i, factor;
>> -
>> -	/*
>> -	 * Spread the io queues across completion vectors,
>> -	 * but still keep all admin queues on vector 0.
>> -	 */
>> -	comp_vector = !queue->host_qid ? 0 :
>> -		queue->idx % ndev->device->num_comp_vectors;
>> +	int nr_cqe, ret, i, factor;
>>   
>>   	/*
>>   	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE +
>> RDMA_SEND.
>> @@ -993,7 +1071,7 @@ static int nvmet_rdma_create_queue_ib(struct
>> nvmet_rdma_queue *queue)
>>   	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
>>   
>>   	queue->cq = ib_alloc_cq(ndev->device, queue,
>> -			nr_cqe + 1, comp_vector,
>> +			nr_cqe + 1, queue->comp_vector,
>>   			IB_POLL_WORKQUEUE);
>>   	if (IS_ERR(queue->cq)) {
>>   		ret = PTR_ERR(queue->cq);
>> @@ -1017,8 +1095,8 @@ static int nvmet_rdma_create_queue_ib(struct
>> nvmet_rdma_queue *queue)
>>   	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
>>   					ndev->device-
>>> attrs.max_send_sge);
>>   
>> -	if (ndev->srq) {
>> -		qp_attr.srq = ndev->srq;
>> +	if (queue->nsrq) {
>> +		qp_attr.srq = queue->nsrq->srq;
>>   	} else {
>>   		/* +1 for drain */
>>   		qp_attr.cap.max_recv_wr = 1 + queue->recv_queue_size;
>> @@ -1037,7 +1115,7 @@ static int nvmet_rdma_create_queue_ib(struct
>> nvmet_rdma_queue *queue)
>>   		 __func__, queue->cq->cqe, qp_attr.cap.max_send_sge,
>>   		 qp_attr.cap.max_send_wr, queue->cm_id);
>>   
>> -	if (!ndev->srq) {
>> +	if (!queue->nsrq) {
>>   		for (i = 0; i < queue->recv_queue_size; i++) {
>>   			queue->cmds[i].queue = queue;
>>   			ret = nvmet_rdma_post_recv(ndev, &queue-
>>> cmds[i]);
>> @@ -1073,7 +1151,7 @@ static void nvmet_rdma_free_queue(struct
>> nvmet_rdma_queue *queue)
>>   	nvmet_sq_destroy(&queue->nvme_sq);
>>   
>>   	nvmet_rdma_destroy_queue_ib(queue);
>> -	if (!queue->dev->srq) {
>> +	if (!queue->nsrq) {
>>   		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>>   				queue->recv_queue_size,
>>   				!queue->host_qid);
>> @@ -1185,13 +1263,23 @@ static int nvmet_rdma_cm_reject(struct
>> rdma_cm_id *cm_id,
>>   		goto out_destroy_sq;
>>   	}
>>   
>> +	/*
>> +	 * Spread the io queues across completion vectors,
>> +	 * but still keep all admin queues on vector 0.
>> +	 */
>> +	queue->comp_vector = !queue->host_qid ? 0 :
>> +		queue->idx % ndev->device->num_comp_vectors;
>> +
>> +
>>   	ret = nvmet_rdma_alloc_rsps(queue);
>>   	if (ret) {
>>   		ret = NVME_RDMA_CM_NO_RSC;
>>   		goto out_ida_remove;
>>   	}
>>   
>> -	if (!ndev->srq) {
>> +	if (ndev->srqs) {
>> +		queue->nsrq = ndev->srqs[queue->comp_vector % ndev-
>>> srq_count];
>> +	} else {
>>   		queue->cmds = nvmet_rdma_alloc_cmds(ndev,
>>   				queue->recv_queue_size,
>>   				!queue->host_qid);
>> @@ -1212,7 +1300,7 @@ static int nvmet_rdma_cm_reject(struct
>> rdma_cm_id *cm_id,
>>   	return queue;
>>   
>>   out_free_cmds:
>> -	if (!ndev->srq) {
>> +	if (!queue->nsrq) {
>>   		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>>   				queue->recv_queue_size,
>>   				!queue->host_qid);
>> @@ -1238,6 +1326,10 @@ static void nvmet_rdma_qp_event(struct
>> ib_event *event, void *priv)
>>   	case IB_EVENT_COMM_EST:
>>   		rdma_notify(queue->cm_id, event->event);
>>   		break;
>> +	case IB_EVENT_QP_LAST_WQE_REACHED:
>> +		pr_debug("received last WQE reached event for
>> queue=0x%p\n",
>> +			 queue);
>> +		break;
>>   	default:
>>   		pr_err("received IB QP event: %s (%d)\n",
>>   		       ib_event_msg(event->event), event->event);
> Max
> I will test this.
> Is this against latest 5.6

Laurence,

It's rebased against nvme-5.7-rc1 (git://git.infradead.org/nvme.git).

In order to use it, please load nvmet_rdma with use_srq=Y and srq_size 
 >= 256 (default = 1024).

Thanks for your efforts !

Max.


>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
