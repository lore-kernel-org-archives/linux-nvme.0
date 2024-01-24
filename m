Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3B7C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 09:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=46H9PDSA18PP+YXR3kO7TsmNh+
	FS9DlK3nWMVW7Nf5aDgJeQVJ/YpY3CACkhO+m0gGXfR7yRG2d67rwS/yUUeJl2p5pF+zk3K8NJB38
	W5Rj+fLR+/ls6rs3oyj0S5NfL5CtJqZBLKCKv/9GgqSBSkvvOV60qWAS/df9M+6QQPbqM/eDXll2g
	nS197QWT/i0FsRB5kxO2clWZbVVfK2FgS+5gMfDcKlr1E7mZKJTgvlQCvfIKpXZfxdTeK1GPl/6/M
	PX3A0q1nGhXIGc2SYVwZwAsteM6wjG7aqUsUKreT7Gm84nmN3/3MRwT+FSknol+2hG0P2pJax8gyK
	uUTEmzFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZDc-002740-0F;
	Wed, 24 Jan 2024 09:06:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZDZ-00272r-1E
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 09:06:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C71A368BFE; Wed, 24 Jan 2024 10:06:42 +0100 (CET)
Date: Wed, 24 Jan 2024 10:06:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	james.smart@broadcom.com, sagi@grimberg.me
Subject: Re: [PATCH V2 2/2] nvmet: add module description to stop warnings
Message-ID: <20240124090642.GE27760@lst.de>
References: <20240123221341.7902-1-kch@nvidia.com> <20240123221341.7902-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123221341.7902-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_010645_569848_416397AF 
X-CRM114-Status: UNSURE (   8.81  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

