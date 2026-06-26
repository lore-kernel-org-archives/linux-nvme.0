Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBBBCDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=abiiDd8kvYv1BZwbTzeoUkqYke
	13GuEfw55+7LdWLp79haDV+w1KBYj+0HO+4urZpUzzqojfulhzljbsqZmV/LmB+efdK547lOLYQPT
	1pXCgbzKzL7PYBg+8Hgnp86s737Q3mHW2O+XQq0bBx0zbQxqGbTvZVkvu4RiPhwTkAPTqvZefTR9E
	SKA81OkpbtnLiFwYkpZd3kZdC7U1CHf5NuOPg+j6WCi5VMg4YhSKB9CNSjpSbZQtrmDzRhZHahVfw
	dyBvq7NWf7YYOxzWs+ekTfDSLul64KWQuqF4/V+SOSlSkq6bTWhTB+9PGwmkM/H9HNpIT0lrlchFT
	Hbepdssw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd151-0000000AgAJ-28TB;
	Fri, 26 Jun 2026 07:34:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd14y-0000000Ag9v-1dIE
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 07:34:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4928E68AFE; Fri, 26 Jun 2026 09:34:19 +0200 (CEST)
Date: Fri, 26 Jun 2026 09:34:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com, randyj@purestorage.com,
	adailey@purestorage.com
Subject: Re: [PATCH v3 1/2] nvme-rdma: refactor nvme_rdma_alloc_queue() to
 take a queue pointer
Message-ID: <20260626073418.GA12072@lst.de>
References: <20260625212722.1302344-1-sgogte@purestorage.com> <20260625212722.1302344-2-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625212722.1302344-2-sgogte@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_003424_572433_E9ADC41F 
X-CRM114-Status: UNSURE (   9.46  )
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


