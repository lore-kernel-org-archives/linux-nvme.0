Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EABAEB1058
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MztGezgCToQ9ij9N8tG+LmQpVRFq72RYylpEJIvMJ4=; b=OcJYSPjXuNGLRhvhdwPI7vybrE
	9ntvLdVwYZtZupJaMUY+ipKV6raytMjSvtqWRODuQEUdYb281fYOsgwC5OmKaUqYa1HhDy8gk5ScO
	vIncfU/sr7kZufE8uc07eFaetots6nEVoW4V3RUSGecVtNY+5Ec8BMdpfFbHBbRHsRG05gCKShL87
	AIenYTJPPhWQJZ3VVFVHZIT4qYf7EBna3krSKIgIAW1RTzgnWd3fd4+iAjIHsClt6ec2iCCB4jayI
	EkZrFu40Ck093ipkl88V4k5uK8arBfKidjHk6rmNrm1j8BUQKLG+aFdt26rVMY74t4RKYpbnB6Z6G
	Y+hJskyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzy1i-00000009hE9-3B4n;
	Tue, 10 Mar 2026 14:25:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzy1h-00000009hDj-36zv
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 14:25:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CEF7F6012A;
	Tue, 10 Mar 2026 14:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14527C2BCB1;
	Tue, 10 Mar 2026 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773152736;
	bh=8MztGezgCToQ9ij9N8tG+LmQpVRFq72RYylpEJIvMJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkUZFJj7I7OTdYE2myLQZh0I2l3RFPl715sfyuPm+9TUIGY+N19ESh0PZvP5N3ie+
	 lkxMg2V46Hzt3Xo9XjaeozVzl7XnMcArNNtJVTf5u9jUzjA52W2vsHyrgzjVaaQ9LN
	 0ZvYIRXRgWa29fS8Y9aDqidlfRCYPtlJbydNZo8KFcNVDLIcx8SwsF6tRQda4iDvhe
	 AP0sjLEJz+SZtIJDoD6s+IfYMwjzEoAA8WaHNAjMkVEdyEWSpOVNzZfsKcou6V612Y
	 XlYP2mPz5HNG91QvBEUfZg4pEi4YH8qr38oo9Wmmxh0SeiRuO2sqidSMRpOkLzqlrA
	 ZDSYz8KvAxIVw==
Date: Tue, 10 Mar 2026 08:25:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race bug in nvme_poll_irqdisable()
Message-ID: <abAp3s7aDyKDIHdk@kbusch-mbp>
References: <20260307194636.2755443-2-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307194636.2755443-2-iam@sung-woo.kim>
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

On Sat, Mar 07, 2026 at 02:46:36PM -0500, Sungwoo Kim wrote:
> In the following scenario, pdev can be disabled between (1) and (3) by
> (2). This sets pdev->msix_enabled = 0. Then, pci_irq_vector() will
> return MSI-X IRQ(>15) for (1) whereas return INTx IRQ(<=15) for (2).
> This causes IRQ warning because it tries to enable INTx IRQ that has
> never been disabled before.

Thanks, applied to nvme-7.0 with updated commit subject.

