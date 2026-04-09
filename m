Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45167F31E22
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T35BGxbe9vba0/1akVI7mx/ig6bpncunsVmmRE4j47U=; b=RN/TpyL3OxbBhqNX6hvN+Xw5n8
	5qc2xVT9leKZqDOWO/3aVh9MHEofb+aN6sWb+8NOQAo8CQsn7774FPM6625X7Xm1wL5Ei4R+Spzwv
	9RsV/fWQuNXR83zQHZ7+JQP3RtWZNFqCtdYeeiFLoLnCW1gSsDSSF1X/X5ijCEOqkRATEg/6ZBIiv
	Ujac71WKRH2KWy6T4AI7bK7h9F9t45e32cO+qrE8rWibmTigLWl12B9GP2tdm7hHiVqi5yR4Oinfb
	qVTPPEsLYZ75PbwldX8RlhMjT0PUpCC14XrCh6xYNsqqSGX0lv3pQXWnzhVhOQ4OQTaNozBwV5U6b
	bC9O/hdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqeC-0000000Aj6Q-49hd;
	Thu, 09 Apr 2026 14:46:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqe9-0000000Aj5x-1B5K
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 14:46:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C0122406C7;
	Thu,  9 Apr 2026 14:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51276C4CEF7;
	Thu,  9 Apr 2026 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775745976;
	bh=T35BGxbe9vba0/1akVI7mx/ig6bpncunsVmmRE4j47U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqY+n6TFYujmsfoNO86609Rb6EwRKuZyXEzmohjog791ZVu3RQ+fwO6NiDsbNleyi
	 g4W5qQ7HqNROsA15JgQkxNgY5XNU6sKlRnb86yPeqUrBpX0SBXE7hihirIoAhkymdQ
	 6tqwKkatvYLsVgPA8FQweuXddrhNCHgCkD5ubwgfMd5myZAJtycPrD1EL+8yy770j5
	 Tc0Kl1184pQO3kP2Qj21y9WeQhFI5+63J5gEiQ317YXHY+sdUFMJ/vKHAT+rRgPkCa
	 Rbmyo07D0OTGiH99Q+GGqQT2DrFFlEhN0mQzQIdLprcMkrS6zn1VkKKcMDuuOnmKPr
	 PSsfx1CFYvgQA==
Date: Thu, 9 Apr 2026 08:46:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, roys@lightbitslabs.com,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free
Message-ID: <ade7trJ74HWR5AY5@kbusch-mbp>
References: <20260409005647.112289-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409005647.112289-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_074617_355609_5126230B 
X-CRM114-Status: UNSURE (   6.78  )
X-CRM114-Notice: Please train this message.
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

On Wed, Apr 08, 2026 at 05:56:47PM -0700, Chaitanya Kulkarni wrote:
> nvmet_tcp_release_queue_work() runs on nvmet-wq and can drop the
> final controller reference through nvmet_cq_put(). If that triggers
> nvmet_ctrl_free(), the teardown path flushes ctrl->async_event_work on
> the same nvmet-wq.

Thanks, applied to nvme-7.1.

