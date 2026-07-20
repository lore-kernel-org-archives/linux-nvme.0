Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A538C4451B
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ktYVKQhepqBu9ei/JaTjk9qCOJ
	ugcKAyFQIgW/BltR0bnGMmclHnnbTji6BdkC29wJgNTbfcnFq7T7jdrZebypyK/PkKdMMSSfvDK7a
	5dUrrpXHlXB76Af9MxR29N8n3TgdC4cIFjJFgyNv+G0LSGHdWRdBMR3RUnt0H7GTygGUKsumG2PPS
	BFh48iuR9OJW8nh4uozUQbBSsBZjc48XUVnsPERxTs9vyqp5PQrJxOmOHhuX6R3LiS3JUKXFSqxTi
	IIrlsi7OYEV8EOHnelGHOqgixjObVLFWN49ObQ7YpCHi8Ae7w7lM39r7bJylXF/sLCnw7fFmcHLFl
	MS77z8Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlj15-000000069uY-3K5x;
	Mon, 20 Jul 2026 08:06:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlj11-000000069tb-47UZ
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 08:06:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEB0768BEB; Mon, 20 Jul 2026 10:06:09 +0200 (CEST)
Date: Mon, 20 Jul 2026 10:06:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()
Message-ID: <20260720080609.GA18764@lst.de>
References: <20260720060305.885535-1-yangxiuwei@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720060305.885535-1-yangxiuwei@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_010620_169851_2C6341B6 
X-CRM114-Status: UNSURE (   9.03  )
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


