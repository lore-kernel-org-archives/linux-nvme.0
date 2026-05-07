Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB4CCD3427
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 05:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XNaQFH//cJrpTIackHAQ5WQip+Cq9ZPeCoMkbCq/r7w=; b=NmO4EwxIB1ri/4pX/QJ1exiWdt
	0Z3I1RywkaRmD6RTD1nc2Hbp581Alxnt5PznqVvoo0PH3XXt4/KfWfY1SHXBSK8OmV20u9pfNjpNO
	QMEei9doKnfE/xJcW2xIekq16lPTjTo72A63INYuqu6BJ9YOw5T/Zw1Y7Ac5+5WcCiEkerBIzlDI9
	M4dV+LuohohMvzkgDPOa9U75Fj793no0LqEgjIGmEY1x4f3XL2UixJ3ojte5BR2tEgfaWvcZVQbIg
	X/umoJ64h6y4yQMPQQ77nhtXYyOqhbpeQkrFPupIGMQ0V5oKr007ganZFrL+zdVvEL+ixTfDwi/WT
	lX1XBMOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrLD-00000002oUL-3LvU;
	Thu, 07 May 2026 05:32:07 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrLB-00000002oU0-48qQ;
	Thu, 07 May 2026 05:32:05 +0000
Date: Wed, 6 May 2026 22:32:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: use str_enabled_disabled() for digest mismatch
 messages
Message-ID: <afwj1aZteJRqnKxs@infradead.org>
References: <20260504123555.1741525-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504123555.1741525-1-roheetchavan@gmail.com>
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

On Mon, May 04, 2026 at 06:05:55PM +0530, Rohit Chavan wrote:
>  		pr_err("queue %d: data digest mismatch host: %s ctrl: %s\n",
>  			nvme_tcp_queue_id(queue),
> -			queue->data_digest ? "enabled" : "disabled",
> -			ctrl_ddgst ? "enabled" : "disabled");
> +			str_enabled_disabled(queue->data_digest),
> +			str_enabled_disabled(ctrl_ddgst));

I can't really see how this is considered an improvement.


