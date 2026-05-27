Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CE8CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqunHVGlVBqMaATOn6iDaIT42FlufPZ9asX0RZl6olw=; b=Q2KqyQ9hZYQKO3l7i8JP/OYaFZ
	YGp1YFQplNmq1+pDCTHrg/Y7qJ6KaG0WJUlSaFJvUtgza29uwvoDl9ot41kj+bT61iJ/ZP/5RQBHY
	vFtDK/ZyaVSq0DqLfeCoqQn4N95Lz44zI6lHaVJTm+B/Wlrvqwv7mcVo9Pm9u8vhICZF55BwrOyWL
	G4vT/qSWRZzCXGtCIe/UZCpiSuC932wDGdncWdEMHUEh+eXo9pNHX838Q/nYF/kGgpyUPLDUFdckz
	VuCZLr1nvv7+SN4aEMyMMj87Qn+5gz6bcpw8DfVCuYY8Ws02pxnE5yP35jLJa+cMGzCqQE80D0LFv
	KSEAPHEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSG3x-00000004OZA-0B1Z;
	Wed, 27 May 2026 15:20:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSG3v-00000004OYa-1Nd3
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:20:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 963A5602E2;
	Wed, 27 May 2026 15:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2721F000E9;
	Wed, 27 May 2026 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895250;
	bh=JqunHVGlVBqMaATOn6iDaIT42FlufPZ9asX0RZl6olw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3bWFTpnQZhd7YBZfDdmiWqjYZxjQglXekQz0hQuwuoDp6MdC5P9E1+zj9X1TO7FE
	 axu00FWMpZbH9Zzbu7A53sOhQINjMrXxmb/1sPLWRCFb9MGWlWEVw7XCypwm6N0WJE
	 hDgQIVwGWrAgKEvYDzSi3ujNvMQTlVLDeMb2JjxJMMX7xR5add0vn/rMlRL+wEcc37
	 KJ4mmOi7V0lNfBN44qlu46Xp1niORQmAECOaijmFZRSXKe/q4Dy2g1ISdTLPDnPXTB
	 pC92+gfumImcRzaVBCw8Abil/+FJ727wvzLltumB4VYstUtOw2L5+nilaKPiWgyByq
	 AFcTYP5rhmrXg==
Date: Wed, 27 May 2026 09:20:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Message-ID: <ahcL0Mj2c2kOM9a4@kbusch-mbp>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-3-hch@lst.de>
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

On Wed, May 27, 2026 at 05:10:21PM +0200, Christoph Hellwig wrote:
> Split the two init cases based on code in the zloop driver.  This
> simplifies the code and makes it easier to follow.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

