Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD94D46607
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jan 2026 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjxPoGeOXRZ3tqCAJU4FdNr4oafL//GBJelfzrlOZro=; b=2jyU0AXCT2SRYjrsJyLz1ybaTa
	Ce6FtZebMc/DrHnxUV9Ae9Og2HFd2/3zAeApKO4qBGOg7Bk7Agl0C1Ywcjus1GIWhWo+fIFvHA877
	/PpAEzdPCXKHUmZU2PSFIGfHoUeo1TswneBd4OgfSYDGudX2mMC/38w712bqA1FDQcr1K1Dmsk3Ac
	uewI7wxBnTm13H2YrLFsnt+XsaA9qQe1RpG7SDdQU60ihDvq9uEIYXF3qRwWQW8fH7X/kDH8xq3CS
	WvUCfUnAZnuiNypd1Gsh5r2S/0gJJ5hLqWzgnv1bUvSHQ31fXPuwbCFY/+vJBsu/lLuaCLfS1MQpB
	DofjbAtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgRyc-0000000Cx3b-0HCB;
	Thu, 15 Jan 2026 18:21:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgRya-0000000Cx3U-2tNL
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jan 2026 18:21:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A3ACB60130;
	Thu, 15 Jan 2026 18:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFCBC116D0;
	Thu, 15 Jan 2026 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768501303;
	bh=yR3QzVoL1IJHeU1OqKqCoLa2vLvGzDQAKtL+ewzlkTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVthOLXklUl2f6KXBLJCyV1BuvyOv27suSNDNvnMQjRcSebj6z9D+653aMYUAnnJr
	 4kZoSxg5MwWTQLFUDBpEy3jpWuZWxwn044wzXkDEHIJHNWkj1cCF/Az6yZKjRcxpMh
	 6iPDPTvHI4RQf7EjpG5DfpeQjbArY9FhqzbzPYPz4kiaA+KXsvHSiNPhF+1Pjo+vXn
	 kYIzHTFODod4zrnTmWbGFNVdql1Q5YdQ/0cWSQfexUaePd8bbNhy1mbHvLhSPbycSt
	 8tweF0dbd55VpbOqPeSZU+KKOKEAu0lgS0MpSXnNiky3YZzwQCiKoKLwF/B3lKJaWX
	 lWLVy5RD/KKdg==
Date: Thu, 15 Jan 2026 11:21:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: optimize passthrough IOPOLL completion for local
 ring context
Message-ID: <aWkwNVgAyBbx732l@kbusch-mbp>
References: <20260115085952.494077-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115085952.494077-1-ming.lei@redhat.com>
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

On Thu, Jan 15, 2026 at 04:59:52PM +0800, Ming Lei wrote:
> +	if (blk_rq_is_poll(req) && req->poll_ctx == io_uring_cmd_ctx_handle(ioucmd)) {

...

> @@ -677,8 +691,14 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
>  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>  	struct request *req = pdu->req;
>  
> -	if (req && blk_rq_is_poll(req))
> +	if (req && blk_rq_is_poll(req)) {
> +		/*
> +		 * Store the polling context in the request so end_io can
> +		 * detect if it's completing in the local ring's context.
> +		 */
> +		req->poll_ctx = iob ? iob->poll_ctx : NULL;

I don't think this works. The io_uring polling always polls from a
single ctx's iopoll_list, so it's redundant to store the ctx in the iob
since it will always match the ctx of the ioucmd passed in.

Which then leads to the check at the top: if req->poll_ctx was ever set,
then it should always match its ioucmd ctx too, right? If it was set
once before, but the polling didn't find the completion, then another
ctx polling does find it, we won't complete it in the iouring task as
needed.

I think you want to save off ctx that called
'nvme_ns_chr_uring_cmd_iopoll()', but there doesn't seem to be an
immediate way to refer back to that from 'nvme_uring_cmd_end_io'. Maybe
stash it in current->io_uring->last instead, then check if
io_uring_cmd_ctx_handle(ioucmd)) equals that.

