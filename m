Return-Path: <SRS0=MKex=KZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EF3C47089
	for <linux-nvme@archiver.kernel.org>; Sun, 30 May 2021 10:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FE9610C7
	for <linux-nvme@archiver.kernel.org>; Sun, 30 May 2021 10:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FE9610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O4HLMKcok1qgvIpXvp3+9flo06CjwXuzC3b+RiEEmoA=; b=ys9ZDqh8YqGMRRpA0PGXpiIwev
	zJYMIsDWii7JZ4+b4sbtbDYC2HTQkpJ3UHfebwbpgB28W/nkg8DjXw3jyOpNi5Mp1JROtdbgIMude
	9NAmIlQ6jj1hhCpPYmBJ59zve5Cl1Wzy35W5H/96gj2EONUjZ0f5hKUaSPBaqj/WnB4OF4D/BLsWj
	vSk20RVDoeSBZa76LNCodorSh89CdAqGGn23X9uq3wH1O9+E2QkA3s2KnxfRQg+vJGrC9kFgtXSwt
	+Wo0F/WeWc6Yrc09R0QNNRSK2D//BUzQCiAXZW4PFT3l/8Pt3Fff1Fg1VD7oLfj6wS75JA5lEirvw
	cnpNWucg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnJ0D-009U1u-TR; Sun, 30 May 2021 10:49:05 +0000
Received: from mail-dm3nam07on2084.outbound.protection.outlook.com
 ([40.107.95.84] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnJ09-009U15-8l
 for linux-nvme@lists.infradead.org; Sun, 30 May 2021 10:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmLk4Knz7jiuBCEFxPMj13BksynUadvrI+aGDhBQ1KvU+UVGPrNQuWptsm78FpcCebI8YPOslM3O/lmv7u9rUn4aHj3hLdObJ5FhyUDlpJ63h8DnUCAc5zQ5mpSzFJSM3m87ibWB0GurziciVaHVxKlUtSZZUJyVYF10YCbi39FGoO7Ncz88X6IHqO3/kEN8Cg6X9SdcNk1cN/h2XP7d0lxIuyNXaXE48EtpNJH8Z0jKbogawk865JwRJw5Xbk6M4fiUaaeX3kdUR9jVjCCE9UVtj4gm/mnZ8omlaBrvtQO9HnYcuUsaSXnXAdqbK4x/X8LiGNMSdHcXIM2NkPlS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTm3kx8ZpsrAfsa/Bw5BWsfH61CFY4QKdnbx/1zUIf8=;
 b=PvOWl0p+ZEAre8aP5BcxxJ6pECXxaCmS4DnqJOcsB4q/nCEzUY/HX1iXPaHn2jX5Zze6nZSykx5zUj7SxiLvf2Az4T15poKk1ckr59koK0plwr3BPZy/HCvWIH4ikQEpYGY2jcWxKnFljrp/u0GPdHs/SmlHzx9jqaDkT0dRq1BqvumeeQALA2LIOK/PSU8Fa3HRqom+uSbgEgq9X57DpLJ964TRRq52PlWDnBilgKznK1YiKU3MVN6YPtMVRXG1WsdyP08S3Yeb3qI7DIjSxdkXuLm/CEFEswxi/6PiQ1kJQUuWfS6aZ7yGKjeiCqPmnfAxiLSrAwZbwoOKMyD0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTm3kx8ZpsrAfsa/Bw5BWsfH61CFY4QKdnbx/1zUIf8=;
 b=hvd1MqbOeiaDw3iNxhqMYfgNgKO/uLLtSD859sxA3azFEYHOL7R3A+hWCkV6vdE0ijXwFMnSL8etY63qIljbcCzPvEx3jLnD6hNC8YYSxi14W/XL+1zp2rNdVbtpHVT07UQ5yGyLQ+v0Zo1Y5EDefk98RDC/DwZkBOoraIMfxG27sCSjK4jSSil/GkBpm7oywH475T9B0TDmVQPyAoYntplVPlKqlghUyJNAOoINUFFIEgDO/7h3ZUuXjoe53X0YC7pUTUv6e2VOM3tpH8i3sMtfSZ47bZG0EH13bRFW+wO04M5NJzZTLo4jZD/3qn3piSgAl389PYmYju9tGTEWJg==
Received: from DM6PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:40::45) by
 DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Sun, 30 May 2021 10:48:58 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::ca) by DM6PR03CA0032.outlook.office365.com
 (2603:10b6:5:40::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 10:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 10:48:57 +0000
Received: from [172.27.13.89] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 10:48:55 +0000
Subject: Re: [PATCH v2] nvme-rdma: fix in-casule data send for chained sgls
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Max Gurtovoy <maxg@mellanox.com>
References: <20210528011638.122507-1-sagi@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <0f98fd55-2767-75f5-7479-816b2aabcc86@nvidia.com>
Date: Sun, 30 May 2021 13:48:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528011638.122507-1-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d810ac11-03b1-44ea-bf26-08d923588704
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3818A03C8CFD22C9A9F77B49DE209@DM6PR12MB3818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJo61eUhh4xccO4dkLNJ0H/p80LGk1IL4F5EdKiinlfEv6xb2JRnzj94fNkuKZKwGhuXvQFXa/0rvecqob2tC/HIRGH/ARsPb9CZ+UAbPtmfbwmwTTCbVlg6thNT+saWbpdH44e/xGlchPjteuGxt2zaqq5XZ7VBCRCJMFYelWE9f63zT8M/KNGiBQgr92+sxATz6lz8y3Nz+qvKCvYA9KYmmI2LazSgp1hKBzi3wsMy2B8uuMB5u21ODbl7egjrCkZ4TmVo5PeowQan01ofJfNZipJGk9gtsvjJmYGZYMQawTFGpQhe6MkynBjzmlWiD+LFt/q4s35tuSTXUI6iOZ+bRuQKFjWRIiH12th0pgPmh3z1arfs9g9hKJuuumtvBKDfAPH1PmPBM0GJ4M8uSdCZzkK0ty3K8bQFyUswm+eInYpSPPsHX3WZRcE7iuS1J2FfAAj893keNKI34LNb4tF7jdK13LRP9fQLdSdZ17dWZniA5CL0DUy/amCxm4O1rvoNp8JDVfwcWn5HSG48hVBBPgqW9aW5GSEYjFbvO/pjPFOQ1u53E+ULKXSzeIzEh8HjfUKPlO4ZHl42flpDJgCphGR4A1hI84E7xBWSkRGi3lQaMTtWgL4pL4PGbsaexXs9z7jMN0eGbbKOjWfpnIpf2Qt3lnU477KgoHq/KSdChIvKNxzjKVj7FrRzI/Nk
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(316002)(110136005)(8936002)(16576012)(4326008)(83380400001)(53546011)(26005)(107886003)(86362001)(8676002)(31696002)(36906005)(186003)(336012)(31686004)(82310400003)(2906002)(47076005)(426003)(2616005)(36860700001)(478600001)(5660300002)(356005)(7636003)(70586007)(70206006)(82740400003)(16526019)(6666004)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 10:48:57.7865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d810ac11-03b1-44ea-bf26-08d923588704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3818
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210530_034901_494334_D754CC24 
X-CRM114-Status: GOOD (  19.92  )
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


On 5/28/2021 4:16 AM, Sagi Grimberg wrote:
> We have only 2 inline sg entries and we allow 4 sg entries for the send
> wr sge. Larger sgls entries will be chained. However when we build
> in-capsule send wr sge, we iterate without taking into account that the
> sgl may be chained and still fit in-capsule (which can happen if the sgl
> is bigger than 2, but lower-equal to 4).
>
> Fix in-capsule data mapping to correctly iterate chained sgls.
>
> Reported-by: Walker, Benjamin <benjamin.walker@intel.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - fix silly compilation error
>
>   drivers/nvme/host/rdma.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 8d107b201f16..f61bf39c39a0 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1320,16 +1320,17 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
>   		int count)
>   {
>   	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> -	struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
>   	struct ib_sge *sge = &req->sge[1];
> +	struct scatterlist *sgl;
>   	u32 len = 0;
>   	int i;
>   
> -	for (i = 0; i < count; i++, sgl++, sge++) {
> +	for_each_sg(req->data_sgl.sg_table.sgl, sgl, count, i) {
>   		sge->addr = sg_dma_address(sgl);
>   		sge->length = sg_dma_len(sgl);
>   		sge->lkey = queue->device->pd->local_dma_lkey;
>   		len += sge->length;
> +		sge++;
>   	}
>   
>   	sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
