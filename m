Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A634AC79F80
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRbSPkEQK0Ub6d1aWvrOQpyCJLijQI4WfXdTv81rUTA=; b=v4z71Lrv2XWw9L870kwn4mnCMy
	mH3yA3iMc6PzPbdFZ+pJLSsz9op93KrI+8zhtimtOHm8DwVSE70Srh1ZoW+aGUcbJEjH48W99/7ul
	n+b7KvMS9iCWba4OA+H+wwqdgSUyE4RYcD8siyGa3ZFR6tv3GwjVp2Cj9gCwuYyBumN3urOewlsoC
	UdlaL6WcQUqG4LdQ0S9QsAIxSbDFoDrYdIqzaEMruE0u9Cb7hC9fX5M4hkT09g3FkTUXG5PI97R5B
	iUA5wyUn4lC5Ye6t+BfEgS2lxsjrH+uxBUvzwGsXBXT8N8FJJxr/kZc3W7opWpaKGrwLpVzV/Nuln
	a4xFJCzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2XFb-00000002otg-0BTj;
	Fri, 04 Sep 2026 16:58:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2XFa-00000002otV-0ZmM
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 16:58:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA5AD434CE;
	Fri,  4 Sep 2026 16:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2721F00A3D;
	Fri,  4 Sep 2026 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541129;
	bh=MRbSPkEQK0Ub6d1aWvrOQpyCJLijQI4WfXdTv81rUTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I8EicANysIZ6XquAsV3qJFYV78fja4ojsaGvJLvFTZf41yyvkHUDx2MiVJ2gujSGj
	 BRJ/gOZraKZ0HswtwxqzR3ZRV5F16cxEyop+aZxuFuV3KNY5KPdbBrarAH9Naz6wCD
	 sYqYOQJIFCEUklvLN5uKBeytV8KQQSnHwCqpAwj0VSqF259KhnRbSlXcbus/MnEOdR
	 pAA6okiSdNrKD/Rok3wPY6k4JQ/laVWxFptr5vJLrl3A3zekbuP6UL5TGvDmYmyzAz
	 4MMh/L8rs4wslqlkMSlZJL8J4gZGLg7nW1e48kK13Zw75qTAqVYwWlDS34Df+LglIi
	 7iF9g3fI+xGtg==
Date: Fri, 4 Sep 2026 10:58:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix typo "occuring" in comment
Message-ID: <apr4x1OUVv0dQ1KJ@kbusch-mbp>
References: <20260904112722.5618-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904112722.5618-1-hemanth.selam@gmail.com>
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

On Fri, Sep 04, 2026 at 04:57:21PM +0530, Hemanth Selam wrote:
> Correct "occuring" to "occurring", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.

Generally, but not always, we don't take pure comment typo fixes because
it creates a conflict point for potentially stable fixes in the
surrounding code.

