Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2F4C10F25
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 21:54:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0652924655
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 21:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Px62aXUV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dnWQTcgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0652924655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NGBb+0bevN5ywl8Gq4ZlnAsW+gT2OHtDE164WOPpWZY=; b=Px62aXUVDgFHCJXlr4PLP2V6W
	21u5QtyUr3QUP07RncQ/mIpje9uldIAA1vyA0SNri+3foSGnL2a0Lqfch6KizKCwOCBUo7e3zqYjY
	byzE71bThHlPgLmGuQMKQlC4jgxa0Oa0sFTfNK4vNTWWqDFkNk+XoprI7njiXKSzIAByIS3qMmdRx
	M14Zc/zL8B339aMorrqwugBdCdHGevBfKefc/wcqjio6+DyBG8uze86L1h3u/VZXLeYDHSl9p+VOp
	qwyuKG2I3b7tcNZLwQ8+Srf0xSKuf2QqCfObZDpSz4OkPEDcWKsP7ZHByMb57Mkgrzea/PS95zaVn
	+cFlZ8koQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBQLy-0003wV-La; Mon, 09 Mar 2020 21:54:26 +0000
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com
 ([40.107.21.56] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBQLv-0003vd-ER
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 21:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKkmNQHubOMYSukD4pbEUkMxm3E6WBuEyaSc8ele3VULI6ud/1RRF08oDjnHBvEEpWchP6i7zR4ZSRTnqxKkzwrHCk3nV5zNPupxcam0X3fk3+V1RfnCgT+uO7LIUSkn3/I5bAY5n8i1ruP4bULUeA3frGT84RwYhX4kPKs/vMy0tOiPZUl25pg33GifJNGs7jrq3Itjodp8WwWeS9ESUOTCKdT9AIMPIQvkuKm0dcz5vSd/nUO51Ai79pryyzAp7wZT51wt2/pgAGkA3sj8jGfiS552GN10Wj8KEf3aZ207oMtLRo01kKc66VfYH0X3GrmeiGM4YisHG8btdAYf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3oeTY08EI37QDZj6A7xISveQDJo3QRuc2hncjjKpNk=;
 b=izOthKmgokdYQ3L3BJeHHmhAckGF7GU6KRw1pkXh4iIJiNu/ScnW3lcDkICZSRXbpWNUPepmn4maVif+fyWv6GTyK72OvVEhUEuMzIndvinm4gOS9r3ci9ojafqtv7m/zRAf4AJQcT6d4czSd4kQoxKH7sxaJ6v3yRZrgcMbSeAfjOgwsRDdlmrPcWiHkHXsZZG83PkFwyElesOEnD3Co3aDQep3cv4KdQtcoA5Ca+nDH6wo3H4x9ateVB+HINWlll0juem2EzwDLgAbC4Eo7s2vYoPJ7qEGzBy4gwOVcxWY990VtvdVGDHQIqAJTlpqT9lHdDRvp8BlM40Uss7uXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=purestorage.com smtp.mailfrom=mellanox.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3oeTY08EI37QDZj6A7xISveQDJo3QRuc2hncjjKpNk=;
 b=dnWQTcgELfOBkqek2wL5AUue3+yjK7NGKicMn08GkZxmz+G8bbAJf8rUeKfGhTAMbn3XmQurSEasrXihCNaUDcUOPnR6xLtIvjOv9lSOz8n/YRxngJ2jo/5vScHy5lmfqPFXVMZl2f8gI0gHBtfAtLCruIQCgZF6O4sXAhVX5RM=
Received: from DB8PR06CA0065.eurprd06.prod.outlook.com (2603:10a6:10:120::39)
 by VI1PR05MB6576.eurprd05.prod.outlook.com (2603:10a6:803:fb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Mon, 9 Mar
 2020 21:54:17 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::e8) by DB8PR06CA0065.outlook.office365.com
 (2603:10a6:10:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Mon, 9 Mar 2020 21:54:17 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; purestorage.com; dkim=none (message not signed)
 header.d=none;purestorage.com; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 21:54:17 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 9 Mar 2020 23:54:16
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 9 Mar 2020 23:54:16 +0200
Received: from [172.27.0.2] (172.27.0.2) by MTLCAS01.mtl.com (10.0.8.71) with
 Microsoft SMTP Server (TLS) id 14.3.468.0;
 Mon, 9 Mar 2020 23:53:33 +0200
Subject: Re: [PATCH] nvme-rdma: Avoid double freeing of async event data
To: Prabhath Sajeepa <psajeepa@purestorage.com>, <kbusch@kernel.org>,
 <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ad4a9a41-00d7-49b1-c5f0-db58a824e6a0@mellanox.com>
Date: Mon, 9 Mar 2020 23:53:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
Content-Language: en-US
X-Originating-IP: [172.27.0.2]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(316002)(31686004)(70586007)(16576012)(53546011)(31696002)(81166006)(81156014)(5660300002)(478600001)(356004)(110136005)(36756003)(8676002)(16526019)(26005)(70206006)(186003)(336012)(86362001)(2906002)(4326008)(2616005)(8936002)(3940600001)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6576; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd2682a-5999-47d1-dd35-08d7c4746a4f
X-MS-TrafficTypeDiagnostic: VI1PR05MB6576:
X-Microsoft-Antispam-PRVS: <VI1PR05MB657698DD85826D4EDC9FD706B6FE0@VI1PR05MB6576.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0337AFFE9A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lm+E+qlx3A52/fFkIOWzYlqNqCJoJSG0lEDccYHreaD6ABCLx44Fe7GWOZ4FPDIZjcunhroU6S9YSzwgX++eYzkvsm+48Lw/zdtOOftMHHvFKpFdhMYFTFV1WEBbqriRh0Rk+xc77PJVLubGa9Z9w+sUFajFmDwI8apoLYEdtVGqUfWjWz1h+blIyD2NwaJsOTdoc8U8Ns/SuSRB0SitG7LRSn1RzZgVFD6AlwwTZZ/2Tb76iMAQB07C32lfl7Z37kqUVXTDFcKOQwc3zJUbggjroaRikavNPP+I8qo+AJK5t+5IFkQmzc30rv1OWPYXkbGiuTyNkp4w26grcGeavs4c3JsljtCUC//5QxgyhaDGe+xg4lg2XmEPJ1d4lv7ejqOCBtpES+raUaRbYRXu/GgaqdvzdxmF0FqAWhZpQX8CBjL0NBsKaWLisKwNMTtpYtJrdYqqTv5LhvVaNJA8+37DmkVibJkDJzjVTQIBo7qAsYhFRg/ebY07zX1m4jXAl6xKFUIoeQfD5i/7qYy9vA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 21:54:17.1711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd2682a-5999-47d1-dd35-08d7c4746a4f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6576
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_145423_514097_70938C74 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: roland@purestorage.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/9/2020 11:07 PM, Prabhath Sajeepa wrote:
> The timeout of identify cmd, which is invoked as part of admin queue
> creation, can result in freeing of async event data both in
> nvme_rdma_timeout handler and error handling path of
> nvme_rdma_configure_admin queue thus causing NULL pointer reference.
> Call Trace:
>   ? nvme_rdma_setup_ctrl+0x223/0x800 [nvme_rdma]
>   nvme_rdma_create_ctrl+0x2ba/0x3f7 [nvme_rdma]
>   nvmf_dev_write+0xa54/0xcc6 [nvme_fabrics]
>   __vfs_write+0x1b/0x40
>   vfs_write+0xb2/0x1b0
>   ksys_write+0x61/0xd0
>   __x64_sys_write+0x1a/0x20
>   do_syscall_64+0x60/0x1e0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> Reviewed-by: Roland Dreier <roland@purestorage.com>
> ---
>   drivers/nvme/host/rdma.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 3e85c5c..0fe08c4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -850,9 +850,11 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   	if (new)
>   		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
>   out_free_async_qe:
> -	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> -		sizeof(struct nvme_command), DMA_TO_DEVICE);
> -	ctrl->async_event_sqe.data = NULL;
> +	if (ctrl->async_event_sqe.data) {
> +		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> +			sizeof(struct nvme_command), DMA_TO_DEVICE);
> +		ctrl->async_event_sqe.data = NULL;
> +	}
>   out_free_queue:
>   	nvme_rdma_free_queue(&ctrl->queues[0]);
>   	return error;

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


We did the same fix in-house yesterday and planed to send it tomorrow :)



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
