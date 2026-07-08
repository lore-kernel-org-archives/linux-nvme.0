Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1010C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 09:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=O5rHNUBsbwgdk+4mhzfLjbQVBC
	wKLH4KfPwWatq5cWIIeFFrtabLhxF+TmadzuwKtpi+Ozgy8RBArUJokauziz3Q1mbsU0gYlHXC33t
	8Q/e7aHMwftzCW4ZFJinIld3EPRT1LRfLN85l6l2gW6hsNxjYM36wyJ0KB+j2iTAJQ2in1KHwqp8k
	UhNzZR5U0YT2b3kP4fhEHIKnT8gI+uuIoyTJRlLQPRylHK7zep9KUz6jvLnHFISL6xAv4WnNwVErP
	m9ZnAtUIH5L0s6XSbfFbtl5vAyrQDjT22ZqyYK2WpkqQQs81U9ttfrQUfs9Rqo1XCOuwvyGX4DPcU
	OlT1/FLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOPB-0000000GjLU-471a;
	Wed, 08 Jul 2026 09:17:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOP7-0000000GjKM-2dFx
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 09:17:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9CE968B05; Wed,  8 Jul 2026 11:17:08 +0200 (CEST)
Date: Wed, 8 Jul 2026 11:17:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH] nvme: swap synchronization ordering in
 nvme_remove_head()
Message-ID: <20260708091708.GA6466@lst.de>
References: <20260707135744.1470014-1-john.garry@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707135744.1470014-1-john.garry@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_021717_809519_3C845466 
X-CRM114-Status: UNSURE (   9.29  )
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


