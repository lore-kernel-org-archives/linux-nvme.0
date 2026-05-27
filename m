Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B5ECD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dw5UvRjiP4NSu8QgbZbt6GtuPDPxrazWBqB4iCOpYVw=; b=jy+O9NOyTD709DFQzjjnS2h5Cd
	re3RfZhsR2uMwReS78Cnme4H808rMDQjoW1ysFTR+50IxYgkmBZQ9XNxjKdcFWxyvYWmc+qDYYLUP
	+gN2Ub3b7q3ILxLAPFWBrYfQM1H6aaI8CWLMWAZbitlaTMutlyNtRt64I6cu9LzojuWD8CtFc+mfq
	lDb7mVDuurbflVEEtQhmWyqnuHWZBxGLw1G9ktL0la6HtgrX9RISKtvwX5qBTjFHzdvEzzCKp9ZQA
	CoPKDYrN4B5XM/NLsMVKOu48X4IP7rclNWx2wYYzaFMUruHv46Zl/azh7YRv0IL3PvQhCJ4BzGvvf
	Kq2xu8Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFzC-00000004O71-1tSH;
	Wed, 27 May 2026 15:15:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFz9-00000004O6P-3uHY
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:15:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E82C418B7;
	Wed, 27 May 2026 15:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E465B1F000E9;
	Wed, 27 May 2026 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894955;
	bh=dw5UvRjiP4NSu8QgbZbt6GtuPDPxrazWBqB4iCOpYVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U4OJd/35bDZluG6fAsECX+EEykrGaaeCBuGIHzWgdpmNeJv/mvGWn7d3QG8vMSsw3
	 vc4R/lzXT2eicVApj6MojRxndJCJBT5jma1lWlJd+1Q2AOswWGBtdDoEQoEsaLlVXJ
	 duZ7i59y+TsTJmpbAEmqGHddrluriFW1/OCuO2WjZlV8U8RXCIhPEQ1b6hcnk5QyIz
	 J86t4t9cYrSa0/ificdFXvmz0fRX1zMIqYzWxtvtZAF6pMDw4+6Cj4IfNO7Ug8fgnn
	 RyGdC7q1+6E+La/LjRCO/5/+3vPC54kQrVMKJoKxdmC+o5pHBkLwsYZEWe96dsjN11
	 PziWsNU7qljjg==
Date: Wed, 27 May 2026 09:15:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@fb.com,
	sagi@grimberg.me, gjoyce@linux.ibm.com, mkchauras@linux.ibm.com
Subject: Re: [PATCH] nvme-multipath: fix flex array size in struct
 nvme_ns_head
Message-ID: <ahcKqQ-uP3dsS2hU@kbusch-mbp>
References: <20260527062010.4036702-1-nilay@linux.ibm.com>
 <ahb2UTQsJywNagyk@kbusch-mbp>
 <aa4f6003-ffce-41dd-8b79-1f0eaa3a40e6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa4f6003-ffce-41dd-8b79-1f0eaa3a40e6@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_081555_991563_C085CEDC 
X-CRM114-Status: UNSURE (   9.11  )
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

On Wed, May 27, 2026 at 08:36:43PM +0530, Nilay Shroff wrote:
> Looking across the architectures supported by Linux, CONFIG_NODES_SHIFT
> appears to be capped at 10, which gives:
> 
> MAX_NUMNODES = 1 << 10 = 1024
> 
> So in practice, nr_node_ids should not exceed 1024.
> 
> This means the flexible array allocation remains bounded and should not grow
> into an unreasonably large sparse allocation.

Cool, thanks for checking. Will get this applied to nvme-7.2.

