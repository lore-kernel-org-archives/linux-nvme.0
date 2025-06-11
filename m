Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8647AC71135
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SI9XOqI/4lJYdyiTIxPgPUXJZlCnBTdKmztQ/zvR4Dc=; b=b/sVmSh+nD2rF0vwLBHgkCk/6t
	fHL3sI+YDbAxLj+J42VtgMaxAkbxxVNLbqC9QWRjNZa7hRyhdVBRuZFSe28BqdV/Jx1Xn9KM44EqT
	2cBsMGlCuYGxpCQSa2J2pto2IadNeiyJ8sjWB6n2mpvZVAPEcxbeq0gDdB61tgSaBcmByAEuu3a5T
	e+Cni1aOV+HavuXt5+lMCYtp3P818M4ZNP7SzJaM+zwdhyU1371YWX3tDKjeuVqa1WkEVg71DUyQo
	cLWtMbjPVIRQQunGllcZ1GL4neat6j7eA2TLHiFtjRn+uE46dWsReUeYYG1oULzeXnPcPmUhd1ZkW
	00S6ut7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPTzE-0000000BTtf-429T;
	Wed, 11 Jun 2025 22:32:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPSe2-0000000BFAn-09ZV
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 21:06:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7897D43632;
	Wed, 11 Jun 2025 21:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93411C4CEEA;
	Wed, 11 Jun 2025 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675961;
	bh=8tO6qxmsRUkIIBT9ozmrJ7IvNbFTzhbOE1w9t3tNNAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkNksXF6NYQCPrIQvTLXt70JWzKtKoGMt+UTOqYzA06pMtc/9xyXdDtblh6x5lNLy
	 piewtEMfmiZ0JLsb2qm+UEJJIuq9IWVa6xXVltO9o4hiSbDls52ov6hWaIYZDV5QL7
	 mStx7VTvDqkifpSjXVRn/5djR9nVDtVUYdaq3KKiq8fw2X+Sp7qyAf47QxWBDuJMYj
	 HjN9iCsAQYuHTIDAYx0jPRnb8CebMezUfmEKYkODr9h7VwKIN8HJEZH2tasZjkwq+x
	 V581RDCt+JvzhF6DEyRWnrUKh3VgPG9rIoQL/XWk1awq8EzkvyxCqVBj45OLUhieSe
	 IF0AWyRBnX6vQ==
Date: Wed, 11 Jun 2025 15:05:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-pci: remove superfluous arguments
Message-ID: <aEnvttB7jcH8lrCe@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_140602_092492_4659F4E0 
X-CRM114-Status: UNSURE (   8.96  )
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

On Tue, Jun 10, 2025 at 07:06:44AM +0200, Christoph Hellwig wrote:
> The call chain in the prep_rq and completion paths passes around a lot
> of nvme_dev, nvme_queue and nvme_command arguments that can be trivially
> derived from the passed in struct request.  Remove them.

Looks good

Reviewed-by: Keith Busch <kbusch@kernel.org>

