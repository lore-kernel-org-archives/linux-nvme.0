Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEC9C5B572
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LS4JIlqraDcriC4bxlNxrEyn/0oBkj9oHbOV9Olu/ho=; b=GLfKp5yxxFVA6AaGJN4QEGp/58
	+l/afw9ubD4HCoNDZGaMzeDqDlQWIGi39b3f5YxnhGa+L2OSE8zWo2dnG0/23iHFkcm8oXdNovY4S
	pQqu4oH+hU44bYiKk79w1CpAIbEgEEBF4M5RB6nJuqbBZKtQvj89m8QyeQFvMWaTSxcSqpbBCsGyK
	aANausilM2W6ST2FfFPKhwlNzmb/hzwx2fHf5r6nZ1HfgHWH8Qkj2CKq9NDMzTg+2vPhdW6pxMU7A
	EnHIaqjsn9hnaaViivTQP9jLqClPGpODegc5CAiEwGzAUEFcmSLmzfN3hk92mOiYm7/fQK4KFhA+G
	kbvYKW6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtpcM-0000000EXnl-1FGB;
	Tue, 11 Aug 2026 16:46:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtpcL-0000000EXnW-2S8C
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 16:46:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A904D600AE;
	Tue, 11 Aug 2026 16:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195BA1F00A3A;
	Tue, 11 Aug 2026 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786466780;
	bh=LS4JIlqraDcriC4bxlNxrEyn/0oBkj9oHbOV9Olu/ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S5Q6o6c+wz8vPAI8l7cwZFk2KzNNC7Uf0clYL2uSTvHSiAP6qsjlIpPhSrnOby9RS
	 cmXSy840lJWb7uUpWEsGDgFl42KqweDF1QVQhNbL0fV27XpVoa7j4otNU+SfxSgLnM
	 ZIBTqpH0gx6yXYPe0tUal335Duv/e6zPEw7m01HX6dIajPS1uUoXJUx3PLcKiujwlV
	 hzLDL765c9Ga6btaIqbCtxUrGcwSlnFPYeVTa368ILK9P7B6fiX7lBKheFHkhvTxNc
	 4AgJB27Z5WxrJZ/79q1IbOKW4NIs2KvULdOsYzaMlQ5xeOINzSd5Dh4VJBvSjzOA73
	 oe2dJL7Ng0asQ==
Date: Tue, 11 Aug 2026 10:46:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: guzebing <guzebing1612@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH v4] nvme: reduce firmware activation poll interval
Message-ID: <antR2u1eeBDCr0ux@kbusch-mbp>
References: <20260728121735.1627370-1-guzebing1612@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728121735.1627370-1-guzebing1612@gmail.com>
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

On Tue, Jul 28, 2026 at 08:17:35PM +0800, guzebing wrote:
> +static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
> +			   u32 timeout, const char *op)
> +{
> +	unsigned long timeout_jiffies = jiffies + timeout * HZ;
> +	u32 csts;
> +	int ret;
> +
> +	ret = nvme_wait_csts(ctrl, mask, val, timeout_jiffies, false, &csts);
> +	if (ret != -ETIMEDOUT)
> +		return ret;
> +
> +	dev_err(ctrl->device,
> +		"Device not ready; aborting %s, CSTS=0x%x\n", op, csts);
> +	return -ENODEV;

Actually, I'm to back this out for a moment to think about this. I like
that you've changed the error to ETIMEDOUT for that condition, but I'm
not sure we need to convert it to ENODEV. None of the callers seem to
care about the specific error, and the user visible side effect of the
condition is more informative than ENODEV.

So if we can get rid of that legacy behavior, then this simplifies even
more. Thoughts?

