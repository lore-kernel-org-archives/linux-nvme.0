Return-Path: <SRS0=vsJd=PF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAA3C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 17:19:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E727560EE5
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 17:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E727560EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ouvy+rdBztDsfrTR5N8ioHdj2LWDKQYJq2YNld0jtFk=; b=LWPLoxMdJAIX7PB/eSOuilfzBG
	IA9k/zmtKXoQEZ9qSL0BtZOui0I61HJrvvmolzKGv02sm9QpcXHVpoCYSCs2mQDPeVddmnTMnRHQ3
	szg8Zt1T3AWby4HeOJ+ntaaYsam/PoL0XQxY5s8qRTeTgRroqsuJ1KuKyzdZKOtpkL/YGacAU383E
	zKp/gL32trDFF3pxd5Z3jJYoOJQrunQEgNKzFHNUxPirbFwzSh7/U5xcVGsOicr1va6HThGjO3Pag
	FzrVYC7cAanp3xrtUw8eMxC+945If7smbaVOj1M7t4HGxsYXmsLBVMiYWxt8SC2gmU36Mh+qQ9A/q
	qPT538CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mc9p2-00D3qV-LU; Sun, 17 Oct 2021 17:19:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mc9ok-00D3nn-3u
 for linux-nvme@lists.infradead.org; Sun, 17 Oct 2021 17:19:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1654960FE3;
 Sun, 17 Oct 2021 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634491165;
 bh=N5I/TK6RMFPLcyd9DVqkH+PDXTwES+K3ZR23ZkNZClY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R6HSq4fLCJnzfn0amTzAgSD3Ca6FdmcMwGDzJO6fdYhuMhf476KP1gdodhoheltAP
 9PL6MJbMWs0+bALZEcCtaAJDgJ3G+dHSBchHzPhtEN3kfdO3ubuHNyJCrFnpEaV3nc
 Egz17o6qOfuQffB6Hx/ta+EtJhjmCR7JpHjRv5Oqbu4cExyYiQw8JQTM2QsfY04Lap
 nr9xV+MxPrOoIUhs/IPMotuIWhVvVuSnBTByue7bN5jRchNFRa6Hu0akvRBsOp9MyG
 zvwsmFpk65JAfDKkhx/BtZHwYFCzgxY1kqRVt9JD4ExWTVt4QTaETia8+8mGprlmBz
 lDnp3rKEA5bTQ==
Date: Sun, 17 Oct 2021 12:23:57 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Len Baker <len.baker@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Message-ID: <20211017172357.GA1214270@embeddedor>
References: <20211017095650.3718-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017095650.3718-1-len.baker@gmx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_101926_224733_430B03BD 
X-CRM114-Status: GOOD (  27.73  )
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

On Sun, Oct 17, 2021 at 11:56:50AM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> In this case this is not actually dynamic size: all the operands
> involved in the calculation are constant values. However it is better to
> refactor this anyway, just to keep the open-coded math idiom out of
> code.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kmalloc() function.
> 
> This code was detected with the help of Coccinelle and audited and fixed
> manually.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Hi,
> 
> this patch is built against the linux-next tree (tag next-20211015).

You don't need to include these lines in every patch. Just add [next]
to the subject line, like this:

	[PATCH][next] nvmet: prefer struct_size over open coded arithmetic

It should be clear enough for people that you are talking about
linux-next. And in case someone asks, then you proceed to clarify. :)

> 
> Regards,
> Len
> 
>  drivers/nvme/target/admin-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index aa6d84d8848e..4aa71625c86a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -278,8 +278,8 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>  	u16 status;
> 
>  	status = NVME_SC_INTERNAL;
> -	desc = kmalloc(sizeof(struct nvme_ana_group_desc) +
> -			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
> +	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
> +		       GFP_KERNEL);

It might be worth exploring if the flexible array is actually needed,
once the allocation is always determined by NVMET_MAX_NAMESPACES. Maybe
it can be changed to the following and remove the dynamic allocation
entirely?

	struct nvme_ana_group_desc {
		__le32  grpid;
		__le32  nnsids;
		__le64  chgcnt;
		__u8    state;
		__u8    rsvd17[15];
		__le32  nsids[NVMET_MAX_NAMESPACES];
	};

If the above is possible then (at least) these lines should be audited:

drivers/nvme/host/multipath.c-551-              if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))

drivers/nvme/host/multipath.c-566-              offset += sizeof(*desc);
drivers/nvme/host/multipath.c-567-              if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))

If the flexible array remains, then this line could use
flex_array_size():

drivers/nvme/host/multipath.c-555-              nsid_buf_size = nr_nsids * sizeof(__le32);

struct_size() could be used here, as well:

drivers/nvme/host/multipath.c-847-      ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
drivers/nvme/host/multipath.c:848:              ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc) +
drivers/nvme/host/multipath.c-849-              ctrl->max_namespaces * sizeof(__le32);

drivers/nvme/target/admin-cmd.c:267:    return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);

Thanks
--
Gustavo


>  	if (!desc)
>  		goto out;
> 
> --
> 2.25.1
> 

