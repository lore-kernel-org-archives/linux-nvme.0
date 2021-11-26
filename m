Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27AFC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OHb72e91hZeEWyppJQtkuehuhTf8m99Tv0SXjpMzRaU=; b=wi8sO5YrqLAk3rQ2VD0IxNiS+f
	7wXT/hxbYqlW7LGW0BK2Jz2rFLJ+8DaPyCA/e5/WZVRVsbiDDzxYA+fKFq3dHlLsr26FZg7V9iZJs
	XI491vMUUjKnpqtzgp/mLbQP8YS1jPHFFheE//L4qC8xyV+/lBeOHv5S4jO3m0HqAyR/BFlbFJcVN
	A+uBt80EBnuzaKr2luuGFWVpEJ76bGx3r82B6W0jngOacoKlBBId/VkvLFP7wAUjRwb4omat2Mb+Z
	7jyF84wsQkJuiBJ8P51XKvHfjuupt1EJB4fppHwZcS9Gc6PRELX15w2jRZzPIwMY54Ea00JXF/NQ+
	DZJx257A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqW1n-009X0w-68; Fri, 26 Nov 2021 07:52:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqW1k-009WzM-7p
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 07:52:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9736C68AFE; Fri, 26 Nov 2021 08:52:07 +0100 (CET)
Date: Fri, 26 Nov 2021 08:52:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 09/12] nvmet: Parse fabrics commands on all queues
Message-ID: <20211126075207.GA23769@lst.de>
References: <20211123123801.73197-1-hare@suse.de>
 <20211123123801.73197-10-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123123801.73197-10-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211125_235212_468224_D9830546 
X-CRM114-Status: GOOD (  18.77  )
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

On Tue, Nov 23, 2021 at 01:37:58PM +0100, Hannes Reinecke wrote:
> Fabrics commands might be sent to all queues, not just the admin one.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> ---
>  drivers/nvme/target/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 5119c687de68..a3abbf50f7e0 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -943,6 +943,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>  	if (unlikely(!req->sq->ctrl))
>  		/* will return an error for any non-connect command: */
>  		status = nvmet_parse_connect_cmd(req);
> +	else if (nvme_is_fabrics(req->cmd))
> +		status = nvmet_parse_fabrics_cmd(req);

This will allow all fabrics commands on the I/O queue, which is a bad
idea.  Please please nvmet_parse_fabrics_cmd into
nvmet_parse_admin_fabrics_cmd and nvmet_parse_io_fabrics_cmd

