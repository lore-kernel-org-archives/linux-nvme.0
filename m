Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859831093187
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=U2kzK7dUVS6xR4AMM3RcZoFq3d
	Pf9Qp8fc//KNy3+8fd1PzBoUH9slYfMlwiTulR2cFTl8UMrDvtxWLqy+vowpVvrh9gbuQEzcw8XQm
	lDtrvmneWz1tEY5kN4QNQ2K5110912+LRjtd0nPgOLWqL/BZOHDhL6WuiDXJwS2rinE5kxhKZSFxG
	zu0XWjv8rN5AjWEnS0z1gl1N0VuFqbj8OkWgcvMI2epUr+IIBzpDoiYYIK6bK7MlYpT/F5TVaVXrG
	9s6pauUnBPWnckvWAknRNwZkIwytgXofENifmdCRTnJreVOudh9d5QUiJCrnu/mQc/dbDfFHS/KpG
	OrkKic/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UkG-0000000CIZG-1rBs;
	Fri, 20 Mar 2026 07:58:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UkE-0000000CIY9-0LtP
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:58:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFDEE68BEB; Fri, 20 Mar 2026 08:58:07 +0100 (CET)
Date: Fri, 20 Mar 2026 08:58:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 2/3] nvme: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20260320075807.GB14771@lst.de>
References: <20260223102336.108512-1-marco.crivellari@suse.com> <20260223102336.108512-3-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223102336.108512-3-marco.crivellari@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_005810_268334_14CEA286 
X-CRM114-Status: UNSURE (   9.60  )
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


