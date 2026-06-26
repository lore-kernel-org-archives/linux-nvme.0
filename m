Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DDFCDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Hlg1MEX6u2eC1txu27C1g0xAVf
	QPhXMNc/yVn5XODZ/F1U1qOMz4E1B/G8HpJzt6zJO7C9GpI1D0By5rjpT/Ra8BNJuypR8h7OL27+X
	FwHmV6GC0C55MnsI8gz4A3VJ5bcjUjB3Raiyjytm7ubr0N5Q89H9hoERvM/UfEd6WIB4XNTtLfR2L
	dOPTwD3evay5PtcLFbHxYEW0kf3pD3FBHV4qbNPC3rcvy7eVXoSN4jf+ea+oL4TbsWtx93758P9pA
	Gw/6jAhSAYFl/UH2CYGfVVnHmZs5BFE22+AjfjdyAfVjg7Kx6DBP1DAQiv6/1aH7LFU/MLPjCoTGu
	8h8P9kMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd09W-0000000Abbv-0qv0;
	Fri, 26 Jun 2026 06:35:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd09T-0000000AbbI-42Am
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:35:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46AF068B05; Fri, 26 Jun 2026 08:34:57 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:34:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 03/17] nvme: add Clang context annotations for
 nvme_ns_head::srcu
Message-ID: <20260626063457.GC10731@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-4-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-4-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_233500_167554_65C2FD29 
X-CRM114-Status: UNSURE (   7.92  )
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

