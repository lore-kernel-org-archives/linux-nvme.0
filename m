Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A8AC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McTElUV+W3kWdt8/K3/dZkZlaT/imAiTL00n93RmvGo=; b=cdC6Flv733Y023Zl13dMnyeTl+
	x18qDs0L4jf/7fKIaZEo9KAnkgnXHbpipGbYGKQw6cE6Uks5QUrIZoGzDjZW6HxjZjCKEiPmLvD1+
	3O6CTCvLyVlFeaPpBdI6xKJWaJWkBXENlJu8/OpxcdsprlQqh76YBFg8Cgv9tUTh7OeiG8/IGWtro
	IJjA1kxCW4C5wTCaVk7WeII1JChzOQOSVJJnKqsvgpt01s3yVfghkvQExTcJH6fKx3A+3+d+X7y4i
	mGVQtodkjyvJwE5xbWIWEVmvpS4abSBkzr4KO9vgI1/zdeANDS7RPEM/BaCtJJ3iYYVwGa0SB6OQE
	U/YR/Wgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH8Lh-00DC2F-EL; Thu, 28 Jul 2022 18:35:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH8Lf-00DC0t-BC
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 18:35:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 120CB67373; Thu, 28 Jul 2022 20:34:56 +0200 (CEST)
Date: Thu, 28 Jul 2022 20:34:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-auth: retry command if DNR bit is not set
Message-ID: <20220728183456.GA22439@lst.de>
References: <20220727061144.54203-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727061144.54203-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_113503_570838_47CF4255 
X-CRM114-Status: GOOD (  11.60  )
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

On Wed, Jul 27, 2022 at 08:11:44AM +0200, Hannes Reinecke wrote:
> If the cqe returns a status with the DNR bit not set we should
> retry the command; otherwise we might incur spurious failures.

If we want to start retrying passthrough commands we should do
that properly by setting a flag in the nvme_request and use the
normal retry code instead of open coding that in the callers.

