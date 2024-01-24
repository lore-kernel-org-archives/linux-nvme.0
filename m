Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FA1C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ayp0ZVeP1kUGspRFwg7w5xJp46
	ztiJQLs9gPAulQFTgRUkYYp+Y4iBUolDXatntfSxFzsgyOxDnXTC6+I+5iGogiIn76eFhXgj3dzek
	3jyJi5t2piobbjrJmuSMI+XP4ISQU5jS7ue7EGuHF9O9vfm8qzd9Ds2pqwxiPNfS+Fp+T9O7kgQT2
	vJc+CnbMdL5riUfV/o1B3x9aoQJkqu5mq23WAttxAC8scMIeiNmXzWqzNyhZ1cOwsAhv4Tgc8REHU
	aLpYnGnucduc4bupOQLRD6i2JCb08IRPkF15ssnJ8ZW/mZvV6RNArYxLi5xYZpiZMJwAMsOp4qAUT
	WQH7TMfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZAo-0026K9-2u;
	Wed, 24 Jan 2024 09:03:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZAl-0026IK-30
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 09:03:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA36D68AFE; Wed, 24 Jan 2024 10:03:39 +0100 (CET)
Date: Wed, 24 Jan 2024 10:03:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kch@nvidia.com, oren@nvidia.com,
	israelr@nvidia.com
Subject: Re: [PATCH 6/8] nvme-rdma: clamp queue size according to ctrl cap
Message-ID: <20240124090339.GA27760@lst.de>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com> <20240123144032.27801-7-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123144032.27801-7-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_010352_132734_849F9B50 
X-CRM114-Status: UNSURE (   8.77  )
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


