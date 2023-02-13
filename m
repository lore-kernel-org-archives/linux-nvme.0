Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C71C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=eGiEwQtXGwmbXIpA+dbEzSJxwW
	ZvBDAfHXKXYAVXMfgcOWt7e7eeOlCfx24BUACwW3SMK5kFyalc+HG16N+Eq9eTguEAL2go0TFpLqA
	4wfrhZuLFh5ardEnqfkzdzUxjYrr/iudqZNaTwqn0BY2AurnRXcef/MpXAmraXrCEzJryxjaFvnzQ
	nhWaUerpCUU8o/u1LyT1OI8O1R7ms7WdIAni/Hh67vSVKjuRwQYHiERkoyzyys4XUZJvqVL3SXE9a
	Su6AsWGvdLAg2dpFG4L3CwKw+zjh5fpnpxds+R1y7C11B1OTTNowkC7YtoPHL1GKZxOarwmBuKmos
	zdhegSZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRRy8-00DIlZ-MZ; Mon, 13 Feb 2023 06:05:40 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRRy4-00DIlD-Mx; Mon, 13 Feb 2023 06:05:36 +0000
Date: Sun, 12 Feb 2023 22:05:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org,
	Gustavo Freitas <freitasmgustavo@gmail.com>
Subject: Re: [PATCH] nvme-pci: add bogus NS ID for ADATA SX6000PNP
Message-ID: <Y+nTMEy9DyyonvbK@infradead.org>
References: <20230208161435.112692-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208161435.112692-1-dwagner@suse.de>
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

Thanks,

applied to nvme-6.2.

