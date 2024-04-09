Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9ECCD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LRqtuL5V22TJIcB0R8IkunkOUsQ+cfzIyMqNuOV9u14=; b=jshBQpW8SYtgGOKEYl4WB7DLQM
	z8qSOZ1MfYllyeGBk5uhvWb+F+qjK4Yalvmoxn1fnKs1ESLVHk7NOikXkI+n/Y6uGg7nxTESXgv3X
	RL4KWiOd6JCzJbYqTKWKyMV1Onuz6aVaX+xgiiB3HYrUn12STYJRc4vEJgjvbRL+CLjglegRBJvlT
	wh1/VSahBKXZ25yzxOFhn5XHXf5c3mdRu/smEXk3XlQbPta24q+thb0HzSAMNONsBKE9G+F359h/a
	2M27And0G1D5250y3LjS+kmcbyj5rb5dJnLECCMNvbEWqpvNnHEh/SrSQxmTUiqSbA4XM/DZxIKTg
	G82GP7QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruBwP-00000002HQD-1y8k;
	Tue, 09 Apr 2024 13:55:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruBwN-00000002HOu-08hE
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 13:55:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39B1668B05; Tue,  9 Apr 2024 15:55:03 +0200 (CEST)
Date: Tue, 9 Apr 2024 15:55:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] nvme: fix warn output about shared namespaces without
 CONFIG_NVME_MULTIPATH
Message-ID: <20240409135502.GA20490@lst.de>
References: <20240408061809.4010087-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408061809.4010087-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_065511_236539_300A3233 
X-CRM114-Status: UNSURE (   9.96  )
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

The commit log is a bit weird.  What this does is to remove the stray
dot after the newline, right?  Maybe state that, and whie you're at
it cut the commit log line to 73 characters and make sure it ends with
a dot.

The change itself looks good to me, thanks!

