Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876C1CAC59F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Sep 2025 22:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+zCWomt0pBYWAn3Hyn1VZyE7oMNA13/wLJFkMqMURY=; b=k1I7+3LFCJZYcw650a/V//l+Fv
	rbDunUN/o6IVGankpKApnUFnfL/UYUphpw8EUMiWPeNOfsTLCLPO9ljmW7E4tJDAa0NBbpUB+ntYg
	reS5LuMLUhe14bYAiCW9GnQfvuoaR3E7Se1BCQjBEfhDRTrQIvQLQiOxfrfIVsOdw29OTLhv2Xgs4
	0ixBeZ5toa5BKI6fg4GWKc6oHMNhI2qrcHyI+nLDqC+Lq/+03r+2tIDxXYn6VQdIl8H11trD/RWwI
	GWgpF4ONE7AS/XKdBgFwRK/hg2PiHbO3xtyQCHgjH1f56LFinShx0/E/cl6Dks1pAMweg1UD8s2av
	aEfhSd4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz0qf-0000000FJq7-27ZA;
	Wed, 17 Sep 2025 22:42:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz0qd-0000000FJpG-36Q6
	for linux-nvme@lists.infradead.org;
	Wed, 17 Sep 2025 22:41:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DE1CC60008;
	Wed, 17 Sep 2025 22:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159B1C4CEE7;
	Wed, 17 Sep 2025 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148918;
	bh=yxnAPjEaQty8rUJ/aaBVRCSdlEvqeu8iBn1RBHyIkgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2Au4+osFdjBcoaip3nvei8rIH2wKO6KEA9NPI/SbtRsVqDa/6itwZ87llMP1IO/o
	 +G7rh+QqzjlNknLJxxgzv4bJnUrPXM1zusLzOAbFFAbgoEz9tHo04pO5Ld9iCANC7I
	 YFG+SXPzRImSMJd1nqYnnJ7jl94Z1UoHDQcmhUkTD7S3Ju52YT3myQ331Rrsh3dvg9
	 jVurSbouMczclQSe+ZtjNLbvh6BKNvPPd8DMw5BjfAgUDq+/8gw0i/qAlj+f2r+hui
	 2YIxNcNObGaYT+nmFIHjvbvaIqtWuYOuV5HGbLx/HuoJVkYllsu4uzhD+1tooT7due
	 JFCda5OlTz14g==
Date: Wed, 17 Sep 2025 16:41:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v2 0/2] Preclude IOCCSZ/IORCSZ validation for admin
 controller connect
Message-ID: <aMs5NJdx7I3WZ0rg@kbusch-mbp>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
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

On Fri, Sep 05, 2025 at 04:25:48PM -0700, Kamaljit Singh wrote:
> During negative testing it was observed that when ioccsz and/or iorcsz 
> were cleared to zero on a Target, a new connection to an administrative 
> controller failed to establish, due to driver validation of those fields. 
> Since an administrative controller does not support I/O queues, these 
> checks should be excluded for such a controller.

Thanks, applied to nvme-6.18.

