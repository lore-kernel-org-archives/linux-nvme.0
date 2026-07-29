Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2A1C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ko8x2a7+emLQfHrdEmgQDj6hhj
	xf+St64haJobz1sLw/QJkoE3ZcRfOKGuHY/okSh3Q3FU1teTBlC1LLdP4tq+8bvppIVq9eQW/l8n6
	q+V8JmLi7mD0RvZ9gGXYEXLyHTkUox3GlnnR/CvTtnuq8Y++AawS5QOTL1jb+ArJtFIH8THZXJK8+
	tA/p3eHdBk4T+0HjVSzATOFW2YRUDYg5V66BgQS/1YUjPlBs0k7XUYlu+Ypdvij0gbr08IeAZAp68
	WpkFIDMc6neNXh25VvXpaUSQzrLwj3ChCckzN2ecsf9zgORvT/psdoak2sxxBb/zTxQeIwb0NtpMU
	23mMfPbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2XQ-00000007jyT-1FUE;
	Wed, 29 Jul 2026 11:33:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2XM-00000007jxQ-3FOG
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:33:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6657468BFE; Wed, 29 Jul 2026 13:33:21 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:33:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Aurelien Aptel <aaptel@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvmet: reject out-of-range mdts values in configfs
 store
Message-ID: <20260729113321.GD31402@lst.de>
References: <20260729110231.1406432-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729110231.1406432-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_043324_954113_51B42FAB 
X-CRM114-Status: UNSURE (   9.81  )
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


