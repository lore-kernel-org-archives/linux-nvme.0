Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E957FC87FCC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GMTZgr4xBWFXompW7o6OC9Jp7/agq8k0ZmNnxTnFzAE=; b=RHr+crCSjJmcv02CijGd8QtHHP
	l4nzZ34Ku6LB6mkDxD9P+yh5dzS1vS+iOnax0fJacyHhJGpCkHPrFdBu3M2bLxzQamqaB6vmnvojB
	TFxlbGaf/1esjzyCCDRurGdqmwOn38W9qCQx4dz/nvBB5P5SQJXoUDPPeZfgfsMg/LQUiBe2JRSgZ
	XyEuBWra1dapmKPDWXyz9cHv9R9EAtBy3ML8b/oKzbPk/T2wr4nF6sy5cfhG6cQv5JVJJyxnkDwbb
	YXGBrIq/sSE6qo5FR1mZGF6Z7JlZfgBdJWjBY0cPidvPFWw44JTU1Teiz6Qj9a+b1OHC0bl8NIPNs
	NOiVpORw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh99Q-00000001tiq-0Fbp;
	Wed, 30 Jul 2025 15:55:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh97c-00000001tTM-28Oo
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 15:53:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6CB468B05; Wed, 30 Jul 2025 17:53:35 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:53:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Remove unnecessary assignment to ret in
 nvmet_ns_enable()
Message-ID: <20250730155335.GB19799@lst.de>
References: <20250725230639.2017274-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725230639.2017274-1-mkhalfella@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_085340_688411_170929F3 
X-CRM114-Status: GOOD (  11.68  )
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

On Fri, Jul 25, 2025 at 04:06:39PM -0700, Mohamed Khalfella wrote:
> Commit 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
> moved checking maximum number of namespaces in subsystem from
> nvmet_ns_enable() to nvmet_ns_alloc(). The assignment to ret in
> nvmet_ns_enable() is no longer needed, remove it.

This assignment already is gone in the current tree.


