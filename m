Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375C1EB64DC
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 07:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b99GIAcpO+qEzq1ERbwGliLYufi8zBM6L5AOqAgdoTU=; b=tH1EMNCcLAOATbDkt2tSfN3xTp
	bCTegScG2do3yvjoMIO92dy/CbF7Q0bTAq/i7YlZz87nalLPJhtB1rLpb+DFjAT7uVqg1IZ3fQ0TP
	d3ukZtUTNYRQ9kKCd73Z8DOA3YG3OO/I5xCbBw7I0VaMdnXjQmF5Ad7dIIDmjZWsP3qZ3hSK8kOr2
	5m8nU1N8G17lHKO4L4BxXd1gnIFZIwpfvbZTuNez6u+DhB8XaE0GoIIICWc7CzhtejKcWGzoOfOLv
	NEg3jHkDW/2pZuDANhZiaieItGNMH62y8DVKIuMp75jNh8ixe+hXbYyKXB4+QsX6Qr/3zrme03k5P
	6KVL1Npw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEm9V-000D1w-0S;
	Thu, 29 Jun 2023 07:33:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEm9S-000D0e-2W
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 07:33:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E1BA6732D; Thu, 29 Jun 2023 09:33:06 +0200 (CEST)
Date: Thu, 29 Jun 2023 09:33:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2] nvme: mark ctrl as DEAD if removing from error
 recovery
Message-ID: <20230629073305.GA19464@lst.de>
References: <20230629064818.2070586-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629064818.2070586-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_003314_965045_3194EDD4 
X-CRM114-Status: GOOD (  20.26  )
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

On Thu, Jun 29, 2023 at 02:48:18PM +0800, Ming Lei wrote:
> @@ -4054,8 +4055,14 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	 * disconnected. In that case, we won't be able to flush any data while
>  	 * removing the namespaces' disks; fail all the queues now to avoid
>  	 * potentially having to clean up the failed sync later.
> +	 *
> +	 * If this removal happens during error recovering, resetting part
> +	 * may not be started, or controller isn't be recovered completely,
> +	 * so we have to treat controller as DEAD for avoiding IO hang since
> +	 * queues can be left as frozen and quiesced.
>  	 */
> -	if (ctrl->state == NVME_CTRL_DEAD) {
> +	if (ctrl->state == NVME_CTRL_DEAD ||
> +	    ctrl->old_state != NVME_CTRL_LIVE) {
>  		nvme_mark_namespaces_dead(ctrl);
>  		nvme_unquiesce_io_queues(ctrl);

Thanks for the comment and style, but I really still think doing
the state check was wrong to start with, and adding a check on the
old state makes things significantly worse.  Can we try to brainstorm
on how do this properly?

I think we need to first figure out how to balance the quiesce/unquiesce
calls, the placement of the nvme_mark_namespaces_dead call should
be the simple part.

