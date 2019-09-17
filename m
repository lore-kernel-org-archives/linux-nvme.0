Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A7C4CEC9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 17:52:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4432067B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 17:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W3sA5d6I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2OTgU+Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4432067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B5eT/wOHBnTyi8mmuS3QFDorR5oonG1EUoGJN1vKfSM=; b=W3sA5d6IyuJpIo
	xz9KFN/xgpvxmR5nI0GWU2TYMJeC9YNzjoRMK4xP0CoAhfpSp5sXxxgvR01bK5z+kintFMZICSF89
	XX4gKEeR5hA9DyYKB2L0X51WbVJtF/95vOFYl78paFbjSuDDGpOUtAiGR0POgNGEll6b69uuvfIyJ
	bP2tjSCeIVAkakKaEFA4IAd4J/rEQ54IaZNRTJcExsLAHS5NARLC3gOZ3T+Y3AuakCdVaPPxfLGEf
	GRdNXxGoKK6Bdq6t6a38UOy56ApFrkVJIYRLaWJ1RWIOQszYuc1gmCbVQ+9UCE3FBaC+mN/9kzBrl
	xSlmxdHOK0QwkYcFmqvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAHdv-0005zD-6p; Tue, 17 Sep 2019 17:51:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAHdn-0005s1-Ax
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 17:51:54 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1CA52067B;
 Tue, 17 Sep 2019 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568742711;
 bh=v8pT4QPeWp0p4Cq7QDCJABW9sLLNj0bTl12O7AdzcUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2OTgU+ZuLo7fTcfcZPGojPsGKDipTJh7QUa4i3ZJdXxCjQKBl565pxFmG2QHBPk8g
 GNr7CVGXxyuVOVL1WLwhOR4+cQtYWfgoN2dzY4sUmCg0lsEPMII6vqo3mbC5EJlPQO
 q2Bqi1kuJbD4WDmk7my3o54lPVtmygrSRyVFgP5o=
Date: Tue, 17 Sep 2019 11:51:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Cassiano Campes <cassianocampes@gmail.com>
Subject: Re: [PATCH] nvme: write streams are used even when streams are
 disabled
Message-ID: <20190917175148.GA13982@keith-busch>
References: <20190917171740.GA32566@iss>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190917171740.GA32566@iss>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_105151_607201_AC5E5CBC 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 17, 2019 at 02:17:40PM -0300, Cassiano Campes wrote:
> Even when the streams flag at the nvme_core module is not set, the
> nvme_assign_write_stream is called unnecessarily, and the write hint
> is passed to the controller, thus resulting in a shadowed stream usage.

If the parameter was disabled when the controller was initialized,
ctrl->nr_streams is 0, so streams already will not be used.

If you start the module with the parameter enabled, but then disable it at
runtime, the controller was previously initialized to enable directives.
This should probably be writeable only at modprobe time, or you'd have
to require to reset each stream enabled controller in order to disable
the streams directives.
 
> Although the user application may pass the write_hint to the device driver,
> the user may have disabled the streams support by toggling the
> /sys/module/nvme_core/parameters/streams flag.
> 
> Later, the user may want to enable the streams support to get some write
> performance improvement, however the user will not notice any performance
> difference because the write streams separation was already happening
> although the streams flag was not set.
> 
> Signed-off-by: Cassiano Campes <cassianocampes@gmail.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d3d6b7bd6903..5a77aea0a58e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -645,7 +645,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
>  	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
>  
> -	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
> +	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams && streams)
>  		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
>  
>  	if (ns->ms) {
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
