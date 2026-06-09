Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC5CD8CA8
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmEuIigsmL7HWH7m8kxNpsbmaCiGGk7QrPGi54GMZn4=; b=ZaFiNXGlwuxg/p10zAUa3MG3mp
	LRHrQCy151oYUgn7+jx21LLV0yKkbCzNOYSdpH44TkH9H8wuIIzyh/D5YvkBvhk1vnEbPKmK9LPAt
	bVU8W473BEqSK2MsPB99NOmt7H87DDWR7OOl3ywl5ugBZ+USOe0LGAqLkR6xSzw9+OKDd6ziFbQ7b
	9P+1Q71WllECzDl1FMQf7RQPLK9LD9VCXTCpRbCZuYQAIPVfWap916kXHe+lfmNQbffuIpuCjck4o
	YFRDbBCrxjlndO1GzTU01htuni2+69E+P+1H0VtB0MzzY65yyEjBvQe8wMph4hAGFpCJdyNAUwiNJ
	gBf4eggg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX4VA-00000006QoI-1cLo;
	Tue, 09 Jun 2026 22:00:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX4V9-00000006QoC-344O
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 22:00:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC6F86024D;
	Tue,  9 Jun 2026 22:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380151F00893;
	Tue,  9 Jun 2026 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042450;
	bh=bmEuIigsmL7HWH7m8kxNpsbmaCiGGk7QrPGi54GMZn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WwFhBrRSKVYVtdsk3o4dKtmtIbWi7bPypc9T6efDEkS5Zcm8/jYHOg77OBcNVZiRn
	 g96h+oMy0dRhHDncE/8d8zqsEKcQ2SnFV/L0vC8SnIgG72fXN2r5U9SwjMTgksWqSB
	 JespkbhbhnA5NIPAn89ZCTvLJ9BPmfXg3C96bOWDCljvwYYm1eHzvphxNnzZuL+L5g
	 yOqgoY9n1XJaMTiRLm/FIjHk2GDAizI5oRRsQ7pL8Fr4iXcSuML9PbZ18Jt5cus1O5
	 emNMWZpDHiL8O1lf44m3JxOt5SvHz9ypsbZTN0UvTtgyfsNolC0TyRg38OBg+DKU4h
	 nRcXpiubKX8yg==
Date: Tue, 9 Jun 2026 16:00:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-rdma: handle inline data with a nonzero offset
Message-ID: <aiiNEEdfVbRvtfuy@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
 <ahm6Ksr3rfGdnOsN@kbusch-mbp>
 <20260604084624.120032-1-hexlabsecurity@proton.me>
 <aiFR81yE9_BIsNbM@kbusch-mbp>
 <20260604193645.178350-1-hexlabsecurity@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604193645.178350-1-hexlabsecurity@proton.me>
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

On Thu, Jun 04, 2026 at 07:36:54PM +0000, Bryam Vargas wrote:
> nvmet_rdma_use_inline_sg() maps the host-controlled inline data offset
> into the per-command inline scatterlist.  The bounds check admits any
> offset with off + len <= inline_data_size, but the mapping still assumes
> the data begins in the first inline page:

Thanks applied to nvme-7.2.

And not necessarily directed at you since apparently many people do
this, but it would help me a great deal if subsequent versions were
posted as a new thread rather than appending to the previous. The
interleaving of the intermediate just makes this harder to sift through.

I'm actually not even sure how so many people converged on this
anti-pattern, as 'git send-email' would have naturally created a new
thread for each new version. What exactly are people doing here?

