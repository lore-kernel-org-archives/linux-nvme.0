Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0ACC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:04:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C9720866
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1G87W/QL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrTxXsd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C9720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zyTiJXxUMrbSn8gdfUpQkvtsNZb80biNyG4zsd9m8gg=; b=1G87W/QL8QvAe+i4PAKg5RRFT
	ea/B6oiNWrRei6SpAF/+CfHn4qEdw/7jI+VGYtfWuLps+pPnobmhKbs2RBLt2WYyhA6Q9gc1Zjjes
	qwvxwwAjS1uLb8ClMpKSHaThlmBT8rFPATAmIN34P5C9Rz9yySF+qLRgZUAVmTGJwKYEAGWdkKzUX
	WPzuZlH2XH1hlcdTUKXcCq/4mry8fXB9z1X0KKCZmrb4NLCf8V3wwkxlEgf4JMbiot7D0Q/p73tgp
	uoA7p8KoQTPgLu97znJOvaC9BjSArnH4ohyWQnlpwnDg5lDY7n6DEfUjXRAYtSfUWjlomKdXLU4Xq
	4b/5U3Y9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bG4-00049E-Su; Fri, 14 Aug 2020 15:04:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bG1-00048i-Tj
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 15:04:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9396A20774;
 Fri, 14 Aug 2020 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597417476;
 bh=oisErVD0u+lyl37V1wBsI8bt6Y7+p7CbVMU/YvPDXtQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CrTxXsd1uArNVJnUs+ss6N08rc0GDHeyOnV/HaAHn0kjrRVBpJKfhpX7Q848Unzxm
 HTMX/XkrnvZztSYLgOghV6i4G0XxInbW0Gg6mYtsoc6uIKXUG2I9aVJwYa4o1dryRi
 fnPEdxXyrqpHLX83WXeO7t0EDMYe3WmxhPba1lyw=
Date: Fri, 14 Aug 2020 08:04:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814071431.201400-1-ztong0001@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_110438_028411_8555B8C3 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ba725ae47305..c4f1ce0ee1e3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  		dev_warn_ratelimited(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, disable controller\n",
>  			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, true);
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +		nvme_dev_disable(dev, true);
>  		return BLK_EH_DONE;

Shouldn't this flag have been set in nvme_cancel_request()?  It's not
like the timeout out command is the only command to have been cancelled
by this action, nor is it guaranteed that getting here will mean the
request was in fact cancelled. The controller could still provide a real
completion.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
