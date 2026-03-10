Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DC3FD2D79
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwGLyWljNfVlc70YMhl9u+n5mcmehW7wxykSiWpf4AA=; b=1tix8xd8Mmp1Bt1PWN3vePXWBr
	yXSGWQ603ZWf+kVE9zGsThm9BI9FvoJebS/pqWn0ybFEo2/+hXD2gbDhX7illQcKgSebeS4CScnIj
	0+Jg7F58I8b3J1QnVlvHy6U9iUXfvMfbKqohl84z+tWSQPLVFBZfwkOtzE4N1a70l0ibQw6FCFhBp
	4zk7yjSRH66OIkcnMHbV5xFb8QVoaaMn7gYfOfk1T8kIu4XAvvIZUYMYfixdpCoirYih2k961tzOs
	y3o+wxugCxnH3vs0ZrJ/SxfD1GxNp0SwUSMNAYpXkt6Q1lKmVAxFObnaGubQF0pxa79yDH8XfhpnD
	Pc9B2d1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzwxw-00000009ZZ9-2KLD;
	Tue, 10 Mar 2026 13:17:40 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzwxt-00000009ZYe-2qOI
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 13:17:39 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id b23ad599 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 14:17:32 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 14:17:31 +0100
Message-Id: <DGZ4QLDVDXLB.16J7Z9QX9BRBC@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH] nvme-core: do not pass empty queue_limits to
 blk_mq_alloc_queue()
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260220133016.524192-1-mlombard@redhat.com>
In-Reply-To: <20260220133016.524192-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_061738_059428_B39A44FA 
X-CRM114-Status: GOOD (  13.74  )
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

Keith? Can you review this?

Thanks,
Maurizio

On Fri Feb 20, 2026 at 2:30 PM CET, Maurizio Lombardi wrote:
> In nvme_alloc_admin_tag_set(), an empty queue_limits struct is
> currently allocated on the stack and passed by reference to
> blk_mq_alloc_queue().
>
> This is redundant because blk_mq_alloc_queue() already handles
> a NULL limits pointer by internally substituting it with a default
> empty queue_limits struct.
> Remove the unnecessary local variable and pass a NULL value.
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 19b67cf5d550..8798a51f735c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4845,7 +4845,6 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
>  int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_s=
et *set,
>  		const struct blk_mq_ops *ops, unsigned int cmd_size)
>  {
> -	struct queue_limits lim =3D {};
>  	int ret;
> =20
>  	memset(set, 0, sizeof(*set));
> @@ -4865,7 +4864,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl=
, struct blk_mq_tag_set *set,
>  	if (ret)
>  		return ret;
> =20
> -	ctrl->admin_q =3D blk_mq_alloc_queue(set, &lim, NULL);
> +	ctrl->admin_q =3D blk_mq_alloc_queue(set, NULL, NULL);
>  	if (IS_ERR(ctrl->admin_q)) {
>  		ret =3D PTR_ERR(ctrl->admin_q);
>  		goto out_free_tagset;


