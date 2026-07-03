Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB6AC43458
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 04:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qUkFcOWdT85XkofjLzr8FixEVGk0Bvd0W1X8es58PKI=; b=RFOFMG12yFx2ZBdh26+A5fG1Ka
	MppagGAXBOZEXFViY3Q8R1iXcmY6HedW6KpUsUZO4jHk+3KfpqEJEwF7629I5Qw4vLbmOosUSCRWV
	VkIFGGWPxbOg86AA23PB1vDY9W4VUhmStfbhUCzKfvzCbdNHSH2mdDngfyCIyBlgRSIEY7w8OajUG
	JIMuerObbc1j7/A2PS///jFMBxBrbud54wapJUB065J+6yTLnE1sESZbGuQNZU19O9COHQTvP2okh
	n8w88x5g4gaLCafLmoSqU7r7MRc/G/o/Yx6yrWwZBkmrY3waulg6y43TLdOIjj8Rm+KpsuAtAU3td
	/RID6U2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfVBG-00000005xxV-3UcQ;
	Fri, 03 Jul 2026 04:07:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfVBF-00000005xxN-23sU
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 04:07:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CE0D43DA0;
	Fri,  3 Jul 2026 04:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29401F00A3E;
	Fri,  3 Jul 2026 04:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051628;
	bh=qUkFcOWdT85XkofjLzr8FixEVGk0Bvd0W1X8es58PKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opAsTt5Vh7itpJrkn9yMwAMyyh2OU1wu1WdrWfN6Jbr0t6uXVDmOC9K+ltRl7pCTE
	 s/6uDnEtQz+ExmJo3rNrHJxy6iu4/xoa6qGcUXmi54e2zB5OXKtaRIbmi93GmObJJF
	 NbHiTZnefkCi/1Qu7Mj+4q7NYNk/GvvKGWEwZ7H206mqdJAD36kg5D8F63SzZB3ULI
	 RUlKe1MxGgfQEVQcSo1Z0PequlsV0hCKvnXMwR07HBRblZJOd2oJlMPt1C5MtITEYD
	 u5ygcrGorJC9Rd2poI1RZZ3oalPXikxTfg2AoA2cWur8vKtcv44McqAgYg1GI44oul
	 NoPLsROumzZSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 6.1.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Fri,  3 Jul 2026 00:06:57 -0400
Message-ID: <stable-reply-nvmet-tcp-61y-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702123644.98527-1-lulie@linux.alibaba.com>
References: <20260702123644.98527-1-lulie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, Jul 02, 2026 at 08:36:44PM +0800, Philo Lu wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Queued up for 6.1.y, thanks!

-- 
Thanks,
Sasha

