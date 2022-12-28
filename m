Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDD4C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kt3VtTVJkhZOkT03YYXF0ZvgMjNAG7cn6l6+hd4+oEA=; b=x40EwWTNpKkjc2MRBLHzQB0fS6
	i+yBLrnRvg9Yb3z+4eR5LI8di6FJKoeNkyEN52Ze6B94i+09MANdVdR9FQlvBhXCWi8WNESFzgBYv
	RtoByGVRbULpsjvj9gnxdaO7SinqRLlIDDcVVTqYdw5KLDV1tHd7LwmniJLqWXiSHhMQbCaehD4el
	YPGIpqWVAZ43ExmfrN6FG+CStkbteniqWlUYAEYVrhSTE8dsQzpj+ZJVhE60WfYRt1UEGzYqNJy8s
	sJJUNXjtJCBOXo6xmTfH7pOIHk105LBy6CFt98Bzgb8QIFZRbOpKERV7jYG5h4DcQWxvmWi8KQ3nF
	s7CCqOjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZpH-006dBt-Le; Wed, 28 Dec 2022 17:02:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZpB-006d9d-UA
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 17:02:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCBD61558;
	Wed, 28 Dec 2022 17:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23675C433EF;
	Wed, 28 Dec 2022 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672246960;
	bh=exaQ8smMOWbNwMvCC6nRdKqQr2gtCZ0w3JjUwsuz6Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5BAUMrR72dwXczrAJMfl8uNELLpG+30SZnazDV+lddr/y2p6clKaVv4fdVHtefpw
	 Geox1yCgUA1fNJlt+LjagxsiT/4DNy7NYsQxYor4qr16iHJOK5eSt/5el4Hd9PZVb6
	 YLWxsP7UBSrfB2XBGRJ+ZxjoBZyb3TQQOB27b/efzUDRdB+YZ+LoxvA30zQ6sxLg5g
	 V1KYPK28z/Jl0gvEkzZRLzrRd985PyafDGvYQYiAcfy4rkULihMI4pJ6kaTNdKS3l6
	 N4Fsrctdn+DlGVdo/RzQw0yIgmICS0QIlFH6KbfnHgAL/XkR7QB599vMnfJKkUN4kL
	 smx+AM2l7SMIw==
Date: Wed, 28 Dec 2022 10:02:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme: store the actual queue size in ctrl->sqsize
Message-ID: <Y6x2rcIhPhQtYQ4p@kbusch-mbp>
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225103234.226794-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_090242_143702_83514ABF 
X-CRM114-Status: GOOD (  15.53  )
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

On Sun, Dec 25, 2022 at 11:32:33AM +0100, Christoph Hellwig wrote:
> Convert from the strange on the wire 0s based value to a regular size
> when reading the filed to avoid adjustments all over.

s/filed/field

> @@ -3242,7 +3242,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>  		return ret;
>  	}
>  
> -	ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
> +	/* CAP.MQES is 0s based */
> +	ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap) - 1, ctrl->sqsize);

Did you mean '+ 1' instead of '- 1'? The minimum MQES value per spec is
1, giving 2 slots. Subtracting 1 from that possible value would give you
sqsize 0.

But I'm confused why this is being changed. The ctrl->sqsize isn't a 0's
based value. It's normal 1-based value that tells blk-mq how many tags
to allocate.

> +static ssize_t sqsize_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	/* Report the 0s based register value for historic reasons: */
> +        return sysfs_emit(buf, "%d\n", ctrl->sqsize - 1);
> +}

Weird indentation here.

