Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EFDC98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2yj8JSqmSjEaJauzJWmzIYojVW
	wB0MPPW+p87XXyhm2jRljqT1oyB7JzqcSHAEeBE9TXwZhxzi/JgTmqne8laCouBMsf0T6RC0dS2Iq
	5rb7tmJA0KbJt4D+6g7N0ppaTQhgQON4bkagqXyZJGATJks1oLTqnH8COWV+g3aWtzfr25yawn2ir
	O2mEzP59+/2wc0v2YwhisXQ4bdHT1R4/JydNFsDpOxYI/RGbMfLm2eYb4IHnXLA/CFM+W0TinWNMy
	Z8yY+QMslhZTkXHa7GZebe6j+wLRK7GpLfCfZjYq7QJxLRDf/a5RkV5OcQLgFrZrybkYY3zCy1iSi
	AmQwEZUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90lC-00000005ZKz-21QT;
	Tue, 22 Sep 2026 13:42:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90l9-00000005ZFK-1sri
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:42:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4346768CFE; Tue, 22 Sep 2026 15:42:04 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:42:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: fix command effects log lifetime for
 multipath heads
Message-ID: <20260922134203.GB32567@lst.de>
References: <20260922073730.352203-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922073730.352203-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_064211_633483_07EC36C4 
X-CRM114-Status: UNSURE (   9.43  )
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


