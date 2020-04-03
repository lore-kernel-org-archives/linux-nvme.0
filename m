Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D2C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 10:30:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FEF20737
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 10:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rMjFxeoE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Cz+njT61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FEF20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jI8xZMxCjtX11x/LGRsST2HgojI7syN1+ImdeqBjsYQ=; b=rMjFxeoEq8mSftrQ9TK3hQ7Zp
	0jFY75PXedbRYupslv5J+MYhLB3oXZ0rtXkpn8ZAxk0NSbiZdJTe6kiW1Yg4Ztz/gSPqlqQb+6nM7
	PNmfAirK0q/wzemg/VL6KLBqL9TrCi5qZ6/AW3FF3nSz9Vbx/sKy4GT0R1QKPrATUszFUY3tkffFT
	ruoGmAiYlUUyHkvYVIEZUb2BDy+ALUV6J/3g7gTJ4oFiSq04k7fcbaAwfNtn3jQLpjNeqghmyVazG
	s7yWgaPw18/fzkkybAxVwz3qXr/7sWYFGtBlHSHgEdDVV58r8aXBw6nlguemj9eB1NIB211i84Es/
	sMImkEeLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKJb9-0003Hu-Qw; Fri, 03 Apr 2020 10:30:51 +0000
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKJb4-0003Gz-Si
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 10:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKMBoCujQ0uGp5OARRKyLGFHYwUNAHsNoSvV5Z/0+asfkfpz6FyZYFAP/Yc06KPk4lZRuwuPvyCgMa7o4NWTjMkYiNYI2Id+S3mJTw8wsQJRax2l/UEOHO+/Ah4fmcTvplvdpSS7NVgQrJG+j1IPqyREMZkhasBdvWtgp5HgQ+vxsjXyHjgYSaX8RG1bv54VBGzDRSp+sWSbGoac/7ogKFwtowt4gcuvVaMW/cxQ9I/PDpcOdaucbOqgecg8ireDWq5nDy7FRs8WYkNmFtbGBSQY2jigEDB0QI+c8Teh3MyT7c2EpQ8lnA+W9KsbnWtlq+3ZG4NEexqhCg7wjYNEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZPKHNIdwXtvx9ggDvg2DIrOD+BSif/YSrG2PPWHHFQ=;
 b=dZskq9g/NxAnMuapCFkNK0hkoAZo0+Sdb5WrPL87BIcIfgwEhD+aYBQ4FmPhQmc24mdCY6jaYSBLSaSgKNgY9zJAx5o1mNlVNCgfH3MyTwne8woqDadpCCLNC5ZjONk9MRjn60v6ebAuG/ilB55yqWBVjbfmBJKSA43TWGtQ3sroL+sMZzREWnV6QlmxKFacePY/YN0p3P588es94C+x201Bsg0/KC5rDd8cXJ0pNyW70MK6CsuNYmIiqm8ErwZaqKOAexlM2Ik8L0XcJKhrIRrXgt4x5JnCckuaFkB8STrcus62F/f2/kClrxAm59YS7jEFJ2Gbehr0dOUb0Q3WnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=zadara.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZPKHNIdwXtvx9ggDvg2DIrOD+BSif/YSrG2PPWHHFQ=;
 b=Cz+njT61HxeOqyOOXgROzhat+Q9YpfZJDoECjf0acxtzkBXlT8ZAJgMmi1KaHULdPnFI7wZEUsV3xhqjQ08Tav2cc0f0J4JLsGWlRqRp1SFaQRUUNv3qtFPPFwd7uG0R2IVQawYI/ZKCoZpqT+Nd7XcWH3iKmuuNFRI4+fIlYkw=
Received: from AM4PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:205::39) by
 AM0PR05MB6531.eurprd05.prod.outlook.com (2603:10a6:208:139::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 10:30:42 +0000
Received: from AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:205:0:cafe::69) by AM4PR05CA0026.outlook.office365.com
 (2603:10a6:205::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 3 Apr 2020 10:30:42 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; zadara.com; dkim=none (message not signed)
 header.d=none;zadara.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT017.mail.protection.outlook.com (10.152.16.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Fri, 3 Apr 2020 10:30:41 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 3 Apr 2020 13:30:38
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 3 Apr 2020 13:30:38 +0300
Received: from [172.27.0.83] (172.27.0.83) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 3 Apr 2020 13:30:36
 +0300
Subject: Re: [PATCH v2] nvmet-rdma: fix bonding failover possible NULL deref
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200402154853.14108-1-sagi@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <914d248c-ce88-48b9-6ffb-3b1d694b06d4@mellanox.com>
Date: Fri, 3 Apr 2020 13:30:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402154853.14108-1-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.0.83]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(16526019)(110136005)(186003)(36756003)(5660300002)(8936002)(8676002)(31686004)(356004)(81156014)(2906002)(47076004)(82740400003)(81166006)(26005)(4326008)(336012)(70206006)(478600001)(2616005)(36906005)(86362001)(30864003)(70586007)(16576012)(31696002)(316002)(53546011)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42b0257f-855f-4604-01ab-08d7d7ba0f3d
X-MS-TrafficTypeDiagnostic: AM0PR05MB6531:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6531D518660D2A86B29DFF8AB6C70@AM0PR05MB6531.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-Forefront-PRVS: 0362BF9FDB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LVG46FW4p+AsybfB3hX8mksT72UtC/O3wQPvawfIjvrfS2ztiEUXTP/qXXM3hWgNh7MdrplpkCcZwYL6WBrJoNCXVgNfD/eXo657Vb1mg58KVsR6sEJFpbcdnuk0dqcYaeAtZD9Vf1qVwdHxNRGn1Wn59MHG6GDDvj/QlaiKGnRMurw+SODvWEb+V77PT0LEtqneflonIslrrfLZwxAxmDi/CKwBm0s7iCb8qWu3pJgx/S/S2f5JQgVkhQHgQlOf4zhD7u1Q+leFC4LSUay/ljDhGTGog/8H8nz+BD0Lc27C4Lw6BWbxk1Q0PE9xuz7oDYvBKkqjNEHVZJTXc1Ie94dXssk7NsdK0PUXj6jGBlJRAJtB+Ud0sPqU1fN38QMyaJVYV5k06TyH6w8xR4VjyNbjfEbKIY3vueBI6RMNhxZTzkWH0PO8BcS9eFHxsXYAuy5pkPbkoQwp3D8H98x/eLtrEHGhMiW+0tH2o0eWozZFu1LQwCd9A6XxW9nRDpiBlNVo5KLgHGq5scIBJNKxX0cQZKzBRX1jOoEVzIxziw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:30:41.3277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b0257f-855f-4604-01ab-08d7d7ba0f3d
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6531
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200403_033047_373818_11E3CC43 
X-CRM114-Status: GOOD (  22.30  )
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
Cc: Alex Lyakas <alex@zadara.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

hi,

if possible, please fix the below comment.

otherwise,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


On 4/2/2020 6:48 PM, Sagi Grimberg wrote:
> RDMA_CM_EVENT_ADDR_CHANGE event occur in the case of bonding failover
> on normal as well as on listening cm_ids. Hence this event will
> immediately trigger a NULL dereference trying to disconnect a queue
> for a cm_id that actually belongs to the port.
>
> To fix this we provide a different handler for the listener cm_ids
> that will defer a work to disable+(re)enable the port which essentially
> destroys and setups another listener cm_id
>
> Reported-by: Alex Lyakas <alex@zadara.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - Fix nvmet_rdma_find_get_device wrong cm_id->context dereference
>
>   drivers/nvme/target/rdma.c | 175 +++++++++++++++++++++++++------------
>   1 file changed, 119 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 9e1b8c61f54e..fd71cfe5c5d6 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -105,6 +105,13 @@ struct nvmet_rdma_queue {
>   	struct list_head	queue_list;
>   };
>   
> +struct nvmet_rdma_port {
> +	struct nvmet_port	*nport;
> +	struct sockaddr_storage addr;
> +	struct rdma_cm_id	*cm_id;
> +	struct delayed_work	repair_work;
> +};
> +
>   struct nvmet_rdma_device {
>   	struct ib_device	*device;
>   	struct ib_pd		*pd;
> @@ -917,7 +924,8 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>   static struct nvmet_rdma_device *
>   nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>   {
> -	struct nvmet_port *port = cm_id->context;
> +	struct nvmet_rdma_port *port = cm_id->context;
> +	struct nvmet_port *nport = port->nport;
>   	struct nvmet_rdma_device *ndev;
>   	int inline_page_count;
>   	int inline_sge_count;
> @@ -934,17 +942,17 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>   	if (!ndev)
>   		goto out_err;
>   
> -	inline_page_count = num_pages(port->inline_data_size);
> +	inline_page_count = num_pages(nport->inline_data_size);
>   	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
>   				cm_id->device->attrs.max_recv_sge) - 1;
>   	if (inline_page_count > inline_sge_count) {
>   		pr_warn("inline_data_size %d cannot be supported by device %s. Reducing to %lu.\n",
> -			port->inline_data_size, cm_id->device->name,
> +			nport->inline_data_size, cm_id->device->name,
>   			inline_sge_count * PAGE_SIZE);
> -		port->inline_data_size = inline_sge_count * PAGE_SIZE;
> +		nport->inline_data_size = inline_sge_count * PAGE_SIZE;
>   		inline_page_count = inline_sge_count;
>   	}
> -	ndev->inline_data_size = port->inline_data_size;
> +	ndev->inline_data_size = nport->inline_data_size;
>   	ndev->inline_page_count = inline_page_count;
>   	ndev->device = cm_id->device;
>   	kref_init(&ndev->ref);
> @@ -1272,6 +1280,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
>   static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>   		struct rdma_cm_event *event)
>   {
> +	struct nvmet_rdma_port *port = cm_id->context;
>   	struct nvmet_rdma_device *ndev;
>   	struct nvmet_rdma_queue *queue;
>   	int ret = -EINVAL;
> @@ -1287,7 +1296,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>   		ret = -ENOMEM;
>   		goto put_device;
>   	}
> -	queue->port = cm_id->context;
> +	queue->port = port->nport;
>   
>   	if (queue->host_qid == 0) {
>   		/* Let inflight controller teardown complete */
> @@ -1412,7 +1421,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
>   static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
>   		struct nvmet_rdma_queue *queue)
>   {
> -	struct nvmet_port *port;
> +	struct nvmet_rdma_port *port;
>   
>   	if (queue) {
>   		/*
> @@ -1431,7 +1440,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
>   	 * cm_id destroy. use atomic xchg to make sure
>   	 * we don't compete with remove_port.
>   	 */
> -	if (xchg(&port->priv, NULL) != cm_id)
> +	if (xchg(&port->cm_id, NULL) != cm_id)
>   		return 0;
>   
>   	/*
> @@ -1462,6 +1471,13 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
>   		nvmet_rdma_queue_established(queue);
>   		break;
>   	case RDMA_CM_EVENT_ADDR_CHANGE:
> +		if (!queue) {
> +			struct nvmet_rdma_port *port = cm_id->context;
> +
> +			schedule_delayed_work(&port->repair_work, 0);
> +			break;
> +		}
> +		/* FALLTHROUGH */
>   	case RDMA_CM_EVENT_DISCONNECTED:
>   	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
>   		nvmet_rdma_queue_disconnect(queue);
> @@ -1504,42 +1520,19 @@ static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
>   	mutex_unlock(&nvmet_rdma_queue_mutex);
>   }
>   
> -static int nvmet_rdma_add_port(struct nvmet_port *port)
> +static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
>   {
> -	struct rdma_cm_id *cm_id;
> -	struct sockaddr_storage addr = { };
> -	__kernel_sa_family_t af;
> -	int ret;
> +	struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);
>   
> -	switch (port->disc_addr.adrfam) {
> -	case NVMF_ADDR_FAMILY_IP4:
> -		af = AF_INET;
> -		break;
> -	case NVMF_ADDR_FAMILY_IP6:
> -		af = AF_INET6;
> -		break;
> -	default:
> -		pr_err("address family %d not supported\n",
> -				port->disc_addr.adrfam);
> -		return -EINVAL;
> -	}
> -
> -	if (port->inline_data_size < 0) {
> -		port->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
> -	} else if (port->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
> -		pr_warn("inline_data_size %u is too large, reducing to %u\n",
> -			port->inline_data_size,
> -			NVMET_RDMA_MAX_INLINE_DATA_SIZE);
> -		port->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
> -	}
> +	if (cm_id)
> +		rdma_destroy_id(cm_id);
> +}
>   
> -	ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
> -			port->disc_addr.trsvcid, &addr);
> -	if (ret) {
> -		pr_err("malformed ip/port passed: %s:%s\n",
> -			port->disc_addr.traddr, port->disc_addr.trsvcid);
> -		return ret;
> -	}
> +static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
> +{
> +	struct sockaddr *addr = (struct sockaddr *)&port->addr;
> +	struct rdma_cm_id *cm_id;
> +	int ret;
>   
>   	cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
>   			RDMA_PS_TCP, IB_QPT_RC);
> @@ -1558,23 +1551,19 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
>   		goto out_destroy_id;
>   	}
>   
> -	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
> +	ret = rdma_bind_addr(cm_id, addr);
>   	if (ret) {
> -		pr_err("binding CM ID to %pISpcs failed (%d)\n",
> -			(struct sockaddr *)&addr, ret);
> +		pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
>   		goto out_destroy_id;
>   	}
>   
>   	ret = rdma_listen(cm_id, 128);
>   	if (ret) {
> -		pr_err("listening to %pISpcs failed (%d)\n",
> -			(struct sockaddr *)&addr, ret);
> +		pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
>   		goto out_destroy_id;
>   	}
>   
> -	pr_info("enabling port %d (%pISpcs)\n",
> -		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
> -	port->priv = cm_id;
> +	port->cm_id = cm_id;
>   	return 0;
>   
>   out_destroy_id:
> @@ -1582,18 +1571,92 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
>   	return ret;
>   }
>   
> -static void nvmet_rdma_remove_port(struct nvmet_port *port)
> +static void nvmet_rdma_repair_port_work(struct work_struct *w)
>   {
> -	struct rdma_cm_id *cm_id = xchg(&port->priv, NULL);
> +	struct nvmet_rdma_port *port = container_of(to_delayed_work(w),
> +			struct nvmet_rdma_port, repair_work);
> +	int ret;
>   
> -	if (cm_id)
> -		rdma_destroy_id(cm_id);
> +	nvmet_rdma_disable_port(port);
> +	ret = nvmet_rdma_enable_port(port);
> +	if (ret)
> +		schedule_delayed_work(&port->repair_work, 5 * HZ);
> +}
> +
> +static int nvmet_rdma_add_port(struct nvmet_port *nport)
> +{
> +	struct nvmet_rdma_port *port;
> +	__kernel_sa_family_t af;
> +	int ret;
> +
> +	port = kzalloc(sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	nport->priv = port;
> +	port->nport = nport;
> +	INIT_DELAYED_WORK(&port->repair_work, nvmet_rdma_repair_port_work);
> +
> +	switch (nport->disc_addr.adrfam) {
> +	case NVMF_ADDR_FAMILY_IP4:
> +		af = AF_INET;
> +		break;
> +	case NVMF_ADDR_FAMILY_IP6:
> +		af = AF_INET6;
> +		break;
> +	default:
> +		pr_err("address family %d not supported\n",
> +				nport->disc_addr.adrfam);

indentation can be fixed.


> +		ret = -EINVAL;
> +		goto out_free_port;
> +	}
> +
> +	if (nport->inline_data_size < 0) {
> +		nport->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
> +	} else if (nport->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
> +		pr_warn("inline_data_size %u is too large, reducing to %u\n",
> +			nport->inline_data_size,
> +			NVMET_RDMA_MAX_INLINE_DATA_SIZE);
> +		nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
> +	}
> +
> +	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
> +			nport->disc_addr.trsvcid, &port->addr);
> +	if (ret) {
> +		pr_err("malformed ip/port passed: %s:%s\n",
> +			nport->disc_addr.traddr, nport->disc_addr.trsvcid);
> +		goto out_free_port;
> +	}
> +
> +	ret = nvmet_rdma_enable_port(port);
> +	if(ret)

missing space.


> +		goto out_free_port;
> +
> +	pr_info("enabling port %d (%pISpcs)\n",
> +		le16_to_cpu(nport->disc_addr.portid),
> +		(struct sockaddr *)&port->addr);
> +
> +	return 0;
> +
> +out_free_port:
> +	kfree(port);
> +	return ret;
> +}
> +
> +static void nvmet_rdma_remove_port(struct nvmet_port *nport)
> +{
> +	struct nvmet_rdma_port *port = nport->priv;
> +
> +	cancel_delayed_work_sync(&port->repair_work);
> +	nvmet_rdma_disable_port(port);
> +	kfree(port);
>   }
>   
>   static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
> -		struct nvmet_port *port, char *traddr)
> +		struct nvmet_port *nport, char *traddr)
>   {
> -	struct rdma_cm_id *cm_id = port->priv;
> +	struct nvmet_rdma_port *port = nport->priv;
> +	struct rdma_cm_id *cm_id = port->cm_id;
>   
>   	if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
>   		struct nvmet_rdma_rsp *rsp =
> @@ -1603,7 +1666,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
>   
>   		sprintf(traddr, "%pISc", addr);
>   	} else {
> -		memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
> +		memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
>   	}
>   }
>   

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
