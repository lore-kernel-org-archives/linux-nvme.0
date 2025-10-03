Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AFDCAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtgCdSJwLNV79rJBsjsspu3YaHJOi2kfRmkqkNnRVTY=; b=Z1w/s9SumLf6MftWMz0bWKEufK
	UKfK5NP7+UOej77Kx04g5n8kqLKUeThEUvJUSY86DQmV4HhvaKrPq9BVHsU1U5rOvq1ZcRgl5cxnT
	H1qE6yyeVnNgf6TlPG4srvJCex2ONQ+hVpVBB/3k892n2lHzptW80wNox5yD9QVUt/1XfjTqcMSQo
	XBckA6BZV4nWBRgvpZvhjxosSr5FP19O8YJhMtcq5LJGZqof2SyVW+nHI+gYq9CldOQuzvGZSV5Ib
	dVUCvW+ZMHyJ6j7tbTzWWMxh87V9WDZxV958+528K51CSe5fvsm7Z+yaeA5iMQiyVEumCcriptjZJ
	SnfQN0aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4f6o-0000000CIMN-35Du;
	Fri, 03 Oct 2025 12:42:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4f6n-0000000CILs-2Mal
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 12:42:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A613660245;
	Fri,  3 Oct 2025 12:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A23C4CEF5;
	Fri,  3 Oct 2025 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759495320;
	bh=YzMScmHtzHOasxK6BnzBL+JzzQqMmOUWHKHrSN0tGuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frrvGNjF+G1sk8Kc/M9UE0hFUQVFG2n2SlS3qqNqLkXr9O5w4mBLlRj7blVXBG6uN
	 I6bJWNemHcl0ZvCKMf8wOzASXiv20W6eJaoXpk6r1ml9raYcjirX+u9rKKm2IXt+Rq
	 huBbWQNOHOZNXe3VERbf/cI38qO07oaY5vdO7+jraGW/fcT6mr6SKObPr0Aw1p00Vs
	 xC4ulqIaf6RRQIQqFVERcTs1Iue2x0fwd0f3PlT372Sr4Nm+mjooJDV3HqtZ5ImXvs
	 mxw4sly4lw7wYuOLWfIiVEWyQOk/GoJFL99nfF8H1jvbjs+RgvUFSfXGKFh6TBsX4f
	 x2b4kT+BnSeew==
Date: Fri, 3 Oct 2025 14:41:55 +0200
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] nvme-keyring: typo in nvme_dhchap_psk_lookup()
Message-ID: <aN_Ek04e4ldw7Ppq@kbusch-mbp>
References: <20251001142200.61696-1-hare@kernel.org>
 <20251001142200.61696-3-hare@kernel.org>
 <20251003073506.GB12862@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003073506.GB12862@lst.de>
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

On Fri, Oct 03, 2025 at 09:35:06AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 01, 2025 at 04:21:59PM +0200, Hannes Reinecke wrote:
> > Spurious semicolon in the function stub nvme_dhchap_psk_lookup().
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202509302259.Yku13u90-lkp@intel.com/
> > Signed-off-by: Hannes Reinecke <hare@kernel.org>
> 
> Looks good.  But maybe we should just drop the series and pick up a
> resend with the fixes folded in?

Yes, I was totally planning to squash and force push, but I'm
considering moving this to the -6.19 branch rather than the current
window.

