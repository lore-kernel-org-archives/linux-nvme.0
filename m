Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007FCC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=R1De3wHKs8XM4xO7FydW0PZW8B
	ww/U+mqy23WY4RsIslTaMXnLkm5ziuVrnFJ6kNzo3r9AJBc/Ea3ieYyOQsivazuTdCuNFQFgaeHer
	7SXo57YpYTaTFKVHo3ZpbEyMAjx9W0X8F1MuF4+R9hD+VItPq+1rLRNRAz0frDgErJAVG9AvyYzyg
	qWdo1Gv6fi7qWvxfducdZlmYggefoz/k0XRzP27M2uWR3dSwost/tJKvsgdtKzqcRe5o+CB8Ic42k
	3t9rHFz9gUCRAO0oTgXS4JtW//xurSuzRhURn1yaevMI1FrNKAZCSzwMxIuPcYgMjeZu5/2AJ9XAR
	sx8A7ZZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND1Q-00C0ls-97; Wed, 01 Feb 2023 13:19:32 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND1P-00C0lY-BW; Wed, 01 Feb 2023 13:19:31 +0000
Date: Wed, 1 Feb 2023 05:19:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] fc: add a missing release get taken in
 nvmet_fc_alloc_target_assoc
Message-ID: <Y9pm444yAYCepVol@infradead.org>
References: <1674477448-2455014-1-git-send-email-amit.engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674477448-2455014-1-git-send-email-amit.engel@dell.com>
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

Thanks,

applied to nvme-6.2.

