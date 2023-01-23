Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7563AC54E94
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=F5qyuaF4civTi+e+U7AvF+Mky4
	eWOy7g01YVoH8EhDl7sBFMq9grVbvFSxaDBDGxYx4wAKkdsBphyT5rvA6nZuLBq55SvCSyemBcfCL
	ZdiP0dJ71snjo85xUt0UShE/E5fT37Rafy1ZirCMvId6+b2wo9j1XKUGZgSwH2uZmc15XNW6/ARCy
	lD1hJmXyOnJj53PJ4AmlXg65SsJ6UrIgrJzOnNx1R048DELwuoShrEWxqvXMBCd0Z3hXbVf/yCOqO
	fzUgqDRfqXuE9qpF5M2rhl1tLopJyfhHHQ8rbUv3/ARYxR8AiQiyw/TQupYULUuJKgRr2zCD+1huv
	RpUVySQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK02V-000hDT-Uj; Mon, 23 Jan 2023 16:51:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzxc-000f6Z-Dx; Mon, 23 Jan 2023 16:46:20 +0000
Date: Mon, 23 Jan 2023 08:46:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: for nvme admin set_features cmd, call
 nvmet_check_data_len_lte()
Message-ID: <Y8653OZILgic8rqW@infradead.org>
References: <1672821872-3193931-1-git-send-email-amit.engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1672821872-3193931-1-git-send-email-amit.engel@dell.com>
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

applied to nvme-6.3.

