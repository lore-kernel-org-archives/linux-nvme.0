Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816D8C001DF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 08:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbtrhyTbqvFvkVtT+45mEzd5VrwEiYQ85PWkr31demU=; b=wJh+VHllIPimcKpcSB5J2XkOhL
	rwnIwly6YyW5cs8ZxIbk3cWGM+zqOtC0sH9J32r52rikam2f7wCm/FJxhNtDPDY7vpTkraQg1XvmL
	X2WAcmtrjH8HfQCRj8B3qD8SYJuFRAQ1I/9m34YR3zhD66xVWDZODf2l2r86+BdkrfsFMruusWiv9
	CuZixOLPKE2pFnZCboSWX7h/vGzbDPwZ2YYajeldhyXu4B5UbklYMymtts1oD3cPPWr1A2H5ceAKn
	GMi87b55J86nbUjRdCCaSOtpq/xgMzS8nPU8P6aGqiziVS83wE7F7zGxpKGJVwjLUOhEUeM9EKLj4
	xF2rZXOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ8ib-00E75V-3C;
	Tue, 11 Jul 2023 08:27:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ8iW-00E71Q-1V
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 08:27:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F19396732A; Tue, 11 Jul 2023 10:27:19 +0200 (CEST)
Date: Tue, 11 Jul 2023 10:27:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/6] nvme: unquiesce io queues when removing namespaces
Message-ID: <20230711082719.GA23019@lst.de>
References: <20230710153555.1766438-1-ming.lei@redhat.com> <20230710153555.1766438-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710153555.1766438-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_012728_665589_DD12F1F1 
X-CRM114-Status: GOOD (  14.66  )
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

On Mon, Jul 10, 2023 at 11:35:50PM +0800, Ming Lei wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 47d7ba2827ff..98fa8315bc65 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3903,6 +3903,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	 */
>  	nvme_mpath_clear_ctrl_paths(ctrl);
>  
> +	/*
> +	 * Unquiesce io queues so any pending IO won't hang, especially
> +	 * those submitted from scan work
> +	 */
> +	nvme_unquiesce_io_queues(ctrl);

What quiesce does this pair with?


