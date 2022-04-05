Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XL9Nlu6tTUq9ing3TbmSIpPHXgKHlG1FbKJc105OYUY=; b=4lD+3WPpB2Grr1+vc2L8nWbh2T
	OB76CWpUhyB09kOkqcQT4fQaVWEjQO1AMnXXqrNYnSG5/8kd5ZuimJRurZr16h/2jMoSNFl1JsqW3
	vwcsC9eMwLoibBmbnkvPsXBlJr1BBAJygs0vV4idPap1z72sG62LDaeV8emWDcBzGxVcyoFZru5vo
	V/gwBafm+hL90mTEjk/ObPrZicx6vHDzzFGL9K9OtfsFvc5ZsB000bW+LvYWxskRTxRdnxsk2DrWs
	ZSpfcIT2cV1nVWxDpdWC+lt601ImwpjUMb5fiEKj3PgdUdukmqAsHL0zt0NF9JnL0sJJ/ov/ePmGE
	XCqr30tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcSe-00HHHy-QX; Tue, 05 Apr 2022 06:14:40 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nbcSd-00HHHk-Pr; Tue, 05 Apr 2022 06:14:39 +0000
Date: Mon, 4 Apr 2022 23:14:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
 linux-nvme@lists.infradead.org
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Message-ID: <YkveT9/oBMoykEsy@infradead.org>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
 <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
 <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
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

On Mon, Apr 04, 2022 at 02:30:12PM -0600, Keith Busch wrote:
> > Eg, nvme0: blah blah command set not supported
> 
> The new print in the completion handler is pretty generic. I don't think it can
> readily tell the difference from a harmless error. Maybe pr_err is too high?
> 
> Or maybe since enough people have been concerned about *this* specific
> identify, maybe it should be restricted to 2.0 devices where it's mandatory. I
> was reluctant to do that at first since the initial device I tested was 1.4,
> but it was a prototype and we should be fine without the non-mdts limits
> anyway.

What SCSI does is to add RQF_QUIET to all internal passthrough commands,
and then skips printing the SCSI specific error messages in addition
if that flag is set.

This would be the nvme version of that:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7e07dd69262a7..9346cd4cf5820 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -366,7 +366,8 @@ static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
+	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS &&
+		     !(req->rq_flags & RQF_QUIET)))
 		nvme_log_error(req);
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
@@ -648,6 +649,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
 
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	req->rq_flags |= RQF_QUIET;
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);

