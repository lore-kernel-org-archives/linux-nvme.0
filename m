Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30913C55186
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 10:25:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B047520704
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 10:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ir9hgtXe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="OHBYwDs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B047520704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YCrZDF+viZSD9THityEHL/6XAf0au+4kRRnsDf1pomo=; b=ir9hgtXelzXxmyU/3kbuFUHc4
	COuRt+mLisVameDROkF487Rm+CayUzwkt6TFhH8VG7kbAKon7HwqpO9kDRTQn9/qV3eZL9BAB7tMe
	OXzdff/0zYXC3L2wMqf2GHHJh9avu+axP3LOsPwZp31Dq3cInYaPIijR9Aws7OfHjS7A/duP0zBut
	39OHMlpJyHIAz5fs2mRRdpmvV/ZcpTlyu9UA9BKBnI+IcO/0Aj/0d4bTBOIklOdbv0nQ71NLGB0so
	b4txd2i3K7IHvhYvEqiEkX9j5tuEvORtV0S3zHHQeX0Gz69/2oItvmXFOsHlaDLsVROuqbgsLWHot
	9kwdK0QIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRZ2V-00005D-53; Thu, 23 Apr 2020 10:25:03 +0000
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRZ2R-0008Nf-Eb
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 10:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A77ZG877ZoQ3zkBJTF4Ht/KuuNfHSeTLWYrH4+u3JQ86xNYnr/JPTit5PHjmTOIhPqWYIYQmpsOSxyeJ7SQuRlDzDXgJdQ7f5lf1/v2AcZsm4bTkMnbuiFFNuApMBQrFLKGErzL5O4ppE0JYvg43GViDBOhv860An+szdZdEK6+LnKcBdVWPKV1grK50PwMNEE0f+8plC2RCSX7cUn/mtwBWJzpCgpedxkHjVfPe5xZggs0S3r1EZXbDqV5pdvOABMyHUspfNX9ySQIF8cMR+5akkARutfq1fRJ5E55BbMPKWrtsMld+6AQ0pECbzb44yUhGc0DWGWEYaeU5NAce7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY+xsGlPX8VRdnk5LgtGims7XIr/FtXF8UoE25BeaAY=;
 b=e6Pzgv2AZh89dR5zXCCZCqg5IqJjvmfOBy25TR4Enp8w3TPGjfEUU8/A7DxjXu9LpyeDM3FWidpuOVSOqMHNVF2beo6Gj/eMNDC1lkYqF3doMEYOlW8L+8RA4aHh84+QclgKiKdDS1baAa2W7NZtAsYMftENJ4IGUEbvbqhqAJCIdh+7WGfAH6ONlEdDNLDZJOpVkziwsOWLc1qJoR+moEqDuIASfJPKkuykmBWJpkKOywYZkXVqe3zjlR0rHiR9nMYpXsY0TJupMyo2CjlQbklbrVTrXYdYZ88QzGYCfR+M+jbSR3De9O/PSr2ukhHROzJ6bpROBPfMMNivz4wPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY+xsGlPX8VRdnk5LgtGims7XIr/FtXF8UoE25BeaAY=;
 b=OHBYwDs5LOIkHpTQvrEdziAhUXBIY4A+7ukjsQcNFnKDSM+cRi2J/HtVPOwRledIB55J9iVMVlsmxnGSo6FMc3xUQPwQ85A5sOPDAqw9uTO2cdCaeS1uDH0XZRGKLNNFNfR9oJyo+eExeJB1XtknhrH5EM0NaqRReI6fkpmCPHI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5041.eurprd05.prod.outlook.com (2603:10a6:208:d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 10:24:54 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 10:24:54 +0000
Subject: Re: [PATCH v2] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
To: Weiping Zhang <zhangweiping@didiglobal.com>, hch@infradead.org,
 axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me
References: <20200423075938.GA11215@192.168.3.9>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <de3cdc57-a97a-f800-26dd-f9439f97bba5@mellanox.com>
Date: Thu, 23 Apr 2020 13:24:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200423075938.GA11215@192.168.3.9>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0082.eurprd02.prod.outlook.com
 (2603:10a6:208:154::23) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 AM0PR02CA0082.eurprd02.prod.outlook.com (2603:10a6:208:154::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 10:24:52 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c92eebc-a368-4b0d-872b-08d7e7709028
X-MS-TrafficTypeDiagnostic: AM0PR05MB5041:
X-Microsoft-Antispam-PRVS: <AM0PR05MB50414097FC943D825A42A39BB6D30@AM0PR05MB5041.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(16526019)(8676002)(52116002)(6486002)(478600001)(26005)(316002)(53546011)(31686004)(16576012)(81156014)(2616005)(956004)(36756003)(2906002)(8936002)(86362001)(66476007)(66946007)(66556008)(31696002)(4326008)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9jI3prY+LZLb1/BYu7jyDqUUOPFtyBj0UVttVqG/cVyZ0o7IbgWsfSG5iTxewDXUQgZXCBuLcS73EXvCKxOMVdd7Q8OQTeusSpXdA3/KwWaC7edPHl/RriGxe414qCNNF72G40CgxIsVFw6Nc9cWC2as8klIAcyBVH735J48H+pq+ZOvo7cPxCPVK/ljIY2JUFPhBMRVEF1kXCi+2WR7z7IQ5zdfcFR7bTx4Xga/ZaSXYsLqQOPn0XyiZUDbYtDti06ClS/kcJNITa+krtA2k/LOINsYNJbvy70Toh2/rgg1X2H1piyUSWZD4IKrvMssyP/MLqrcw3L5ZTyUlByHgmFNfGpHTZfQ2eWWdu2C30PRKfPO7ZhwiA7yozmNtebZjWrejGVUvLZoaXVZr/wasCxjY0CE8dQwr6oOEAIN+y78HhObZNFGSyIhz5roCg7
X-MS-Exchange-AntiSpam-MessageData: 81I9P2EeOD0Kn059OG4/Yjqio2pxYrRtpaB983w5F/+TDZoLNsZgDG2siApzddHVN+Y+rpKAX6xtybNqGRbMMlWYQmSxZeKOxgowS577yBduKEYbzcxrFJu39t6bMTrQIIAwEW4SDHF+STBx+N6xhlrve5xA6Dvdv0sq0O8FzwXbZdx2az1Dmw1wmpr0NMPqCf57ev0MX5ufHAldSBfhbcx+unrA5MWs+8UifkcPC2tf2iHYzGaXRpYLNFUnuJiZKMfZcxj/Gn02MHtXgtAgY32aZbjaO3KGUFbjP9uB9jIOUaS3NnOnT3BvPfg5ZlPdzfvsavveanBGCAFKPnvHnOnUv6goQ2PKKMvUxgxjOD1G7Lu9SLMd9/RRM7q3+p+jAaJzCig28d0Gqq5dnh4mbdOQ42/G6ntsFy4VVZybF/5iI6GofcJzD6fC3D5yWWD8MKzCt3aEtwhX/yzAVVKb+BlIUcRjiNHegsB+Kg/dEQoVieltRK9sXFXgxOH3MCi+9vUxK4jchpj3oErOYkivG+nlXGZLD42PO//yhFWwhTHjMFIJ8SotSeqr6d9+QkZYdRqoYvQMqg+McBoZzjYzEKYR408nP28ZypIy6HqY864/6hnuEfTyfNx1DTUDkWFyj0UHPqQVK5qMEFfrQLI8fpSRh6SwIbb6RLFHgpk9z0Hjj7H3NZU5ix00GTboGRJ6JWfprH8UOqQIBXeFEhZqSFiIvTOUNDHOyfekic+ESoxWTq+I6XRiVnNgKHCIQjZDKhYmk2dNg7ObByQSuseF/jfze49mmYXI52YvqtFXnyUxK7t0Yk/df8sOQcwJ7kmT
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c92eebc-a368-4b0d-872b-08d7e7709028
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 10:24:53.8722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBIinNDNystasuQAFVIC8BoqPety2fdIKAl6IP41GN/ziPVK1GjOy5BLD2YlqgePNQklntGxkY/1wjKMfqWhMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_032459_714340_E3E9DB69 
X-CRM114-Status: GOOD (  27.83  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 4/23/2020 10:59 AM, Weiping Zhang wrote:
> Since the commit 147b27e4bd0 "nvme-pci: allocate device queues storage space at probe"
> nvme_alloc_queue will not alloc struct nvme_queue any more.
> If user change write/poll_queues to larger than the number of
> allocated queue in nvme_probe, nvme_alloc_queue will touch
> the memory out of boundary.
>
> This patch add nr_allocated_queues for struct nvme_dev to record how
> many queues alloctaed in nvme_probe, then nvme driver will not use
> more queues than nr_allocated_queues when user update queue count
> and do a controller reset.
>
> Since global module parameter can be changed at rumtime, so it's not
> safe to use these two parameter directly in the following functions:
> nvme_dbbuf_dma_alloc
> nvme_dbbuf_dma_free
> nvme_calc_irq_sets
> nvme_setup_io_queues
>
> This patch also add nr_write_queues, nr_poll_queues for
> struct nvme_dev and io_queues_reload for struct nvme_ctrl, that allow
> per-controller reload module parmater when reset controller. The nvme
> driver will not reload module parameter(write/poll_queues) by default
> when reset controller. If user want to reload them, they should enable
> it by echo 1 > /sys/block/<nvme_disk>/device/io_queues_reload.
>
> By now, nvme pci driver allow user change io queue count for each
> type(write, read, poll) within nr_allocated_queue, that's to say, if
> user want to change queue dynamically by reset controller, they should
> setup io queues as many as possiable when laod nvme module, and then
> tune io queue count for each type.

typo: laod --> load


> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
> Changes since V1:
>   * don't use module parameter nvme_dbbuf_dma_free, nvme_dbbuf_dma_alloc
> 	and nvme_calc_irq_sets.
>   * add per-controller sysfs file io_queues_reload to enable/disable
> 	reload global module parameter.
>
>   drivers/nvme/host/core.c | 29 +++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/pci.c  | 55 +++++++++++++++++++++++-----------------
>   3 files changed, 62 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfb064b4334f..80172192a9d8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3357,6 +3357,34 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
>   }
>   static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
>   
> +static ssize_t nvme_sysfs_io_queues_reload_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n",
> +		ctrl->io_queues_reload ? 1 : 0);
> +}
> +
> +static ssize_t nvme_sysfs_io_queues_reload_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	bool val;
> +
> +	if (kstrtobool(buf, &val))
> +		return -EINVAL;
> +	ctrl->io_queues_reload = val;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(io_queues_reload, S_IRUGO | S_IWUSR,
> +		nvme_sysfs_io_queues_reload_show,
> +		nvme_sysfs_io_queues_reload_store);
> +
>   static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reset_controller.attr,
>   	&dev_attr_rescan_controller.attr,
> @@ -3374,6 +3402,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_sqsize.attr,
>   	&dev_attr_hostnqn.attr,
>   	&dev_attr_hostid.attr,
> +	&dev_attr_io_queues_reload.attr,
>   	NULL
>   };

Well for fabrics controllers it doesn't mean anything.

maybe we can do it non-visible for fabrics ?


>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f3ab17778349..50b6392b9a33 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -260,6 +260,7 @@ struct nvme_ctrl {
>   	struct work_struct fw_act_work;
>   	unsigned long events;
>   	bool created;
> +	bool io_queues_reload;
>   
>   #ifdef CONFIG_NVME_MULTIPATH
>   	/* asymmetric namespace access: */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4e79e412b276..00f7c93d73c9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -89,6 +89,9 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
>    */
>   struct nvme_dev {
>   	struct nvme_queue *queues;
> +	int nr_allocated_queue;
> +	int nr_write_queues;
> +	int nr_poll_queues;
>   	struct blk_mq_tag_set tagset;
>   	struct blk_mq_tag_set admin_tagset;
>   	u32 __iomem *dbs;
> @@ -209,25 +212,14 @@ struct nvme_iod {
>   	struct scatterlist *sg;
>   };
>   
> -static unsigned int max_io_queues(void)
> +static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
>   {
> -	return num_possible_cpus() + write_queues + poll_queues;
> -}
> -
> -static unsigned int max_queue_count(void)
> -{
> -	/* IO queues + admin queue */
> -	return 1 + max_io_queues();
> -}
> -
> -static inline unsigned int nvme_dbbuf_size(u32 stride)
> -{
> -	return (max_queue_count() * 8 * stride);
> +	return (dev->nr_allocated_queue * 8 * dev->db_stride);
>   }
>   
>   static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>   {
> -	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
> +	unsigned int mem_size = nvme_dbbuf_size(dev);
>   
>   	if (dev->dbbuf_dbs)
>   		return 0;
> @@ -252,7 +244,7 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>   
>   static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
>   {
> -	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
> +	unsigned int mem_size = nvme_dbbuf_size(dev);
>   
>   	if (dev->dbbuf_dbs) {
>   		dma_free_coherent(dev->dev, mem_size,
> @@ -1991,7 +1983,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>   static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
>   {
>   	struct nvme_dev *dev = affd->priv;
> -	unsigned int nr_read_queues;
> +	unsigned int nr_read_queues, nr_write_queues = dev->nr_write_queues;
>   
>   	/*
>   	 * If there is no interupt available for queues, ensure that
> @@ -2007,12 +1999,12 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
>   	if (!nrirqs) {
>   		nrirqs = 1;
>   		nr_read_queues = 0;
> -	} else if (nrirqs == 1 || !write_queues) {
> +	} else if (nrirqs == 1 || !nr_write_queues) {
>   		nr_read_queues = 0;
> -	} else if (write_queues >= nrirqs) {
> +	} else if (nr_write_queues >= nrirqs) {
>   		nr_read_queues = 1;
>   	} else {
> -		nr_read_queues = nrirqs - write_queues;
> +		nr_read_queues = nrirqs - nr_write_queues;
>   	}
>   
>   	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> @@ -2036,7 +2028,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>   	 * Poll queues don't need interrupts, but we need at least one IO
>   	 * queue left over for non-polled IO.
>   	 */
> -	this_p_queues = poll_queues;
> +	this_p_queues = dev->nr_poll_queues;
>   	if (this_p_queues >= nr_io_queues) {
>   		this_p_queues = nr_io_queues - 1;
>   		irq_queues = 1;
> @@ -2073,7 +2065,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   	int result, nr_io_queues;
>   	unsigned long size;
>   
> -	nr_io_queues = max_io_queues();
> +	/* reload io queue count from module paramters write/poll_queues */
> +	if (dev->ctrl.io_queues_reload) {
> +		dev->nr_write_queues = write_queues;
> +		dev->nr_poll_queues = poll_queues;
> +		nr_io_queues = num_possible_cpus() + dev->nr_write_queues +
> +				dev->nr_poll_queues;
> +		if (nr_io_queues > dev->nr_allocated_queue - 1)
> +			nr_io_queues = dev->nr_allocated_queue - 1;
> +	} else {
> +		nr_io_queues = dev->nr_allocated_queue - 1;
> +	}
>   
>   	/*
>   	 * If tags are shared with admin queue (Apple bug), then
> @@ -2742,7 +2744,7 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
>   
>   static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
> -	int node, result = -ENOMEM;
> +	int node, nr_queue, result = -ENOMEM;
>   	struct nvme_dev *dev;
>   	unsigned long quirks = id->driver_data;
>   	size_t alloc_size;
> @@ -2755,11 +2757,18 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (!dev)
>   		return -ENOMEM;
>   
> -	dev->queues = kcalloc_node(max_queue_count(), sizeof(struct nvme_queue),
> +	dev->nr_write_queues = write_queues;
> +	dev->nr_poll_queues = poll_queues;
> +	/* IO queues + admin queue */
> +	nr_queue = dev->nr_write_queues + dev->nr_poll_queues +
> +		num_possible_cpus() + 1;
> +	dev->queues = kcalloc_node(nr_queue, sizeof(struct nvme_queue),
>   					GFP_KERNEL, node);
>   	if (!dev->queues)
>   		goto free;
>   
> +	dev->nr_allocated_queue = nr_queue;
> +
>   	dev->dev = get_device(&pdev->dev);
>   	pci_set_drvdata(pdev, dev);
>   

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
