Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08A0D172DA
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p5IQ0o53BRbKUw40x0pFJD5AdEYLhVn2WspLt+Ay8tc=; b=M8DrD/B8Q3CzxFVWr5rSOD1e5h
	1ldJqeW2SUGoQwrR2uBYETV8aRDBFW/x6qQHPlauWBYuU1fsSBsQ8cwFnm9r2U8TKK3ewvpzU7+dS
	7xlmbPzHgbQWqRcDXMc9H1QXCMfzZHZKMe7qcRJ1y/zO5ynv879eX76KLjIgSRc5mxq0v28w7mIj6
	FLLIvZnSjjA8j5w3bbCNI2ZwRvJ4zsKnkqxAEhzBoQ7qYU4q0RrWy+RUL7MzdGbOd4I20kqgAUA4j
	yYpI2FerOhNbCvOq13YDOgIN4Pd6LZ3aP4rdYKxLiR2S8M2jWaIPPwFZtcYuK7RDGk07IkzIU/2b3
	6ChyOAig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmntJ-00000004ZHy-0Idx;
	Mon, 02 Feb 2026 06:58:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmntF-00000004ZHM-3Hb3
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 06:58:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2550B68B05; Mon,  2 Feb 2026 07:58:26 +0100 (CET)
Date: Mon, 2 Feb 2026 07:58:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Hodges <hodgesd@meta.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: use kfree_sensitive() for DHCHAP secrets
Message-ID: <20260202065825.GB930@lst.de>
References: <20260201030840.3173507-1-hodgesd@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201030840.3173507-1-hodgesd@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260201_225829_967236_5F4169CD 
X-CRM114-Status: GOOD (  12.52  )
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

On Sat, Jan 31, 2026 at 07:08:40PM -0800, Daniel Hodges wrote:
> The DHCHAP secrets (dhchap_secret and dhchap_ctrl_secret) contain
> authentication key material for NVMe-oF. Use kfree_sensitive() instead
> of kfree() in nvmf_free_options() to ensure secrets are zeroed before
> the memory is freed, preventing recovery from freed pages.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


