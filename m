Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D88C47258
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 00:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=; b=v55WKZZ6aJV7ut8WORKz4FWjhM
	6AUY3yOhhJembIxb0snBVGlWTCZve2CGmd99UcQDzPYmNWi2dgrXCuVPJkvJ0S0Kw4nlcRHnUKbbO
	lN3fvFnHFhkgsQs3zndSahfuc3RCTiSEfSOCC5HJgu3/xBuojI+56xVarTytE8uhPzDxQIe0nZrT3
	QBPmIvQ6Tte7AQFyIiNzUvvW6kivMuEqRxBqM080Uj9gSMctUpTBrUdRrWo4NJGCpBwALmUSzKCI+
	W1CaQawIX1YRVxy8Fs/ovmHIcaMg7wrXF+SGeyMkZxE0V92z3waN1pS6OXFETMHWT8pB++EHhoB7k
	TmTpCz2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKxD-000000065Dm-0bMH;
	Thu, 01 Feb 2024 00:29:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKxB-000000065DG-0fOz
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 00:29:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 323D161B36;
	Thu,  1 Feb 2024 00:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1FDC433C7;
	Thu,  1 Feb 2024 00:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747351;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9bN9POOLMRztt6ErPGsX6uuL0AvEPX6flYTmFos54xUBoYLWt7b8wLENmcFc/HX7
	 gObc8o7iUQSwdV4yKb2b1kzeqMXiH6XtBzMzkmJ5SYQDPRAZQYLrLNy4Zxhw1twSSs
	 V7E3tOnXdTBFRSXbNG2ge7wkwOAEF6DsmXeavPHUhE0RCo3rqDcLfdnzFwTxMStKwN
	 GwazdXvS/4l7d5P+V+JbIAkP/QSpztJ+3XiXihxmRzoZh27FX2iO46uRSqZdrnBfBB
	 Ab+d3h3RpwG2tER31ueVrg1hmWF60xpufCsjDco6ekNOvOsY6ryeWwLHLwcZu0QQD5
	 dw5QuuIBtMvMg==
Date: Wed, 31 Jan 2024 17:29:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] nvme: return string as char *, not unsigned char *
Message-ID: <Zbrl1bvwOEln08VP@kbusch-mbp.dhcp.thefacebook.com>
References: <20240131164315.160042-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131164315.160042-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_162917_241948_9B60E1AE 
X-CRM114-Status: UNSURE (   7.89  )
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

Thanks, applied to nvme-6.8.

