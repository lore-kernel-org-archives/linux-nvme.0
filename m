Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74CBC54E60
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Mar 2024 18:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZl0nM/4XXgIO3jGHMiIeMCu45tfGZLFJHwTUcNGacI=; b=SJ/AptL+C5dSYZq0ZXR1P1RBMd
	AB2sS8Ys2BoCNchNzyofuSRduaAOWH5mk3CG5No34T+77TpS2SA8ebi1G0P9IQ33mDvvYQT9I7fLh
	tzZ9F14AyUxwXondt55K/fd6CAcnWppFz27LRF0JwJdNukmQEZPL4ffFp8n925tvBhzdz3LFyfX+p
	qR0CvaVkJy84unZY73lBfEIiZgRmsRQvXvYEy+Nda3GGKRrxWhHvRpIsWzKEmhkhZCh9Fb0OAaCd8
	gH0fKU94Lc0tXtjEy0c8M7U37WEfYEDofQzuNwQ49L7bgAgV8/7QKkzScxzpQ9myg+/v08kvkSflB
	uUPXjvWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq2l-0000000FLZC-21B1;
	Thu, 14 Mar 2024 18:43:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq2h-0000000FLXr-3Yep
	for linux-nvme@lists.infradead.org;
	Thu, 14 Mar 2024 18:43:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5838761591;
	Thu, 14 Mar 2024 18:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E9AC433F1;
	Thu, 14 Mar 2024 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710441783;
	bh=sZl0nM/4XXgIO3jGHMiIeMCu45tfGZLFJHwTUcNGacI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlcpU2uyDe7CKA4Thhqlb+eUhZQZ4v87GTm+2oMfZK6kc1teSRHRfEmNZ9S+wh9ig
	 mOxioPxpW2S4DAn+iVwHRoaFyEkdn5jCIKgkru+HoINxQut51MeW9Ih2oTmZq4rpvb
	 yo6mgzjBM/ZiKERTtelEQdZCFoaKTLc3HTULB/5F6EM13SYwGyH1y0zW3gebq1SS1E
	 bHf3TbORsukpm5dbxidMa87iEfTlRYMab1WWUqmvGzwG0obdltd+Qfnv0rhEJYN+kN
	 zhbrN2XjcfrLKa1mgz4NMGM4UxWU8Juy1AZUkjkZw8L4auoo2CsM4VJWYbK7i7J+zf
	 LLM4ZCPvGRWHQ==
Date: Thu, 14 Mar 2024 12:43:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: use nvme_disk_is_ns_head helper
Message-ID: <ZfNFNJH9bx1YZ9Ky@kbusch-mbp>
References: <20240313022905.104092-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313022905.104092-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_114303_951371_F7F168F2 
X-CRM114-Status: UNSURE (   6.21  )
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

On Wed, Mar 13, 2024 at 10:29:05AM +0800, Guixin Liu wrote:
> Use nvme_disk_is_ns_head helper instead of check fops directly,
> and also drop CONFIG_NVME_MULTIPATH check.

Applied to nvme-6.9, thanks.

