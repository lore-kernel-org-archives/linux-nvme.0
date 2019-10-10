Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C21CC4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:51:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF892067B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QYIrEX0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF892067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FD5fv0Az0TSSVvrCyQk1NNvfLmkrIwtnEf8Pe/zrf7U=; b=QYIrEX0tvqRRy1
	qDbx7QdDP+qzme/PbD+vIh+E2ZI9eV5fhgiIxZgCarkmWsBLeNQ3PJ+0UTTHptjem/N0ut75pUiYj
	MQxgRtN9GF24cSqI00QqqpqnbJRLr21PyrzT9w4ORm5wWrD1+q729ae1ZuZVD1aIxydZCKd8YsblE
	YI9bcyJPKAqDJSr1j9dhlMH0t59ehfNaCn9NAOAdqj/pWS5CWXy4y9/TqC+GE1VauFT69Qszeg5So
	VsNbd8SWOvIrj8TCgBF2BAhdHw2H4Es5xd0FaVzXgUAKpbUQy4Ae7vuybKHwq/qqW2GiLfmlCYEux
	9Zq1f3rF2qwR82coQuQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIYqb-0008Oq-N3; Thu, 10 Oct 2019 13:51:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIYqY-0008OP-PO
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 13:51:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6CA4368C65; Thu, 10 Oct 2019 15:51:09 +0200 (CEST)
Date: Thu, 10 Oct 2019 15:51:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/8] nvme: Introduce nvme_is_aen_req function
Message-ID: <20191010135109.GA31487@lst.de>
References: <1570714100-15520-1-git-send-email-maxg@mellanox.com>
 <1570714100-15520-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570714100-15520-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_065114_972252_3A48B7C6 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: sagi@grimberg.me, israelr@mellanox.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 04:28:13PM +0300, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> This function improves code readability and reduces code duplication.
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/nvme/host/nvme.h   | 5 +++++
>  drivers/nvme/host/pci.c    | 3 +--
>  drivers/nvme/host/rdma.c   | 4 ++--
>  drivers/nvme/host/tcp.c    | 4 ++--
>  drivers/nvme/target/loop.c | 4 ++--
>  5 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 38a83ef5..6fa2b6e 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -445,6 +445,11 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
>  	put_device(ctrl->device);
>  }
>  
> +static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
> +{
> +	return (!qid && command_id >= NVME_AQ_BLK_MQ_DEPTH);

No need for the braces.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
