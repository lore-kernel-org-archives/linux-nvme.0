Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F01BC7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 07:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ugEZXEVJeKw7jPNlfeyvvmafXs6OL7AvKzq+caPRhYs=; b=dLGCHb7ioOOf/fc8NIypxVk/Gm
	aGA9T4/O7BKH6hUkE0OmFI2nK7CxN+cGANhmYh5NQFpS7xnUwBlYxGHKVeXPfD2j2Rz0DYoBrHBNU
	xCxEMBPDU7qB53IbuNUZuGMTAHnpAwAzEN/I4yeSIIzkx0QN8fxQZcDl8Gg4vo4RLVSMDL5zH7PZa
	lNvoc9iHB5swVQV55HmVdjhj+Sf2+06rELEJJQiLSE88g1aMfNrWI7Z25n+WtIGAg12y1Ww1YEt0+
	xUN5HZ/Bw4qpv1aBM4h7Utfx+Gdn38+wtUcVyWnCorgjufZhFUIUo+QU2amAOg1G2hrwS2Y1GBiEm
	5fdYReug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqqYA-00FZdj-2r;
	Mon, 24 Apr 2023 07:23:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqqY7-00FZcG-1L
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 07:23:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1FE06732D; Mon, 24 Apr 2023 09:23:39 +0200 (CEST)
Date: Mon, 24 Apr 2023 09:23:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH v2 2/3] io_uring: Pass whole sqe to commands
Message-ID: <20230424072339.GB13287@lst.de>
References: <20230421114440.3343473-1-leitao@debian.org> <20230421114440.3343473-3-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421114440.3343473-3-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_002347_596712_5FBDB590 
X-CRM114-Status: GOOD (  12.10  )
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

On Fri, Apr 21, 2023 at 04:44:39AM -0700, Breno Leitao wrote:
> -	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
> +	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->sqe->cmd;

As mentioned in my (late) reply to the previous series, please
add a helper like:

static inline const void *io_uring_sqe_cmd(struct io_uring_sqe *sqe)
{
	return sqe->cmd;
}

and then avoid all these casts.

>  int io_uring_cmd_prep_async(struct io_kiocb *req)
>  {
>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> +	size_t size = uring_sqe_size(req->ctx);
>  
>  	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
>  	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
>  
> +	memcpy(req->async_data, ioucmd->sqe, size);
> +	ioucmd->sqe = req->async_data;

This can skip the size local variable now.

