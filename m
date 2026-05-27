Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B45CD6E41
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GzYb46va53a5V7lykYtKMSOYczoGqTemW+PX8cyAiIc=; b=clRqblLBYlmrMODBIOSHpgyPoK
	2hRz19Q3cuOsjpyUXPWwOVBvR/gM8EGii9qmnXYitybqGB8GuCa8xGd7UBKYuq8gVZPR5eFxXYhoz
	ok5ygbw8bHaZjLdYcGMIX6ANGE/8lqz6FU2fiDtbiuDgijACPF2xdrh7RwintEZuruUMkuPQb/PbX
	ljlm5P/MDKPnyQA+OWUeIPkEjq8SR3vmY3a/ovF0WQ6K+ErD2fG0M3jBqtwuLvMrN9CvLU95JLpvl
	vTNWraX40IEfWgEpJlZxakorM9k7pMnLMEMq9qbpaTxRPmjmJBMnK6N+859ZNHOP3tWdqOtZBCjle
	kYy1zFgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFIr-00000004Idt-0n8e;
	Wed, 27 May 2026 14:32:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFIp-00000004IdZ-2J2H
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:32:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 94C6E601E6;
	Wed, 27 May 2026 14:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96F11F000E9;
	Wed, 27 May 2026 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779892330;
	bh=GzYb46va53a5V7lykYtKMSOYczoGqTemW+PX8cyAiIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SxKtsSGy5SFVkgYwJ8OqE9t4UptVrWfraSGByP32Tuuv3pm3gQERIKcGnPtOIiFuh
	 ETtD2wlNfTM/bn9WjHPae3UGfBByxXB+EGz5/e1gO8htoEO3Aymb0GRjr2MOBcGc+G
	 eOauLZeLsAB1wmXotVLomuipLYlxRhn63MZz7xsuvxeZa3JW3rxaBSLNXf3j+Yd/TB
	 /qkL8AVdXILoab3VL+/z0DsDcfsGjWWxkOAAbNB/75aC7in5a7oYZ/k1qINzmMvuoP
	 pYxJBUNwQKZpArthVI/l5wVqiXp2SSv0lq7UCv5Ff0Igw3Ldv4UNcixEi1AMeNAiJ4
	 GCC0Zg+7KXEyQ==
Date: Wed, 27 May 2026 08:32:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v5] nvme: reject passthrough of driver-managed Set
 Features
Message-ID: <ahcAaPTOH9ELlAA4@kbusch-mbp>
References: <20260523225629.3964037-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523225629.3964037-1-coshi036@gmail.com>
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

On Sat, May 23, 2026 at 06:56:29PM -0400, Chao Shi wrote:
> +			switch (le32_to_cpu(c->features.fid) & 0xff) {
> +			case NVME_FEAT_KATO:
> +				if (ctrl->ops->flags & NVME_F_FABRICS)
> +					break;
> +				fallthrough;
> +			case NVME_FEAT_HOST_BEHAVIOR:
> +			case NVME_FEAT_HOST_MEM_BUF:
> +			case NVME_FEAT_NUM_QUEUES:
> +			case NVME_FEAT_AUTO_PST:

I may have been overly restrictive with suggesting AUTO_PST for this
filter. Messing with the other features will break something, but power
state is just user policy. The driver may undo the user setting on a
controller reset, but so what?

