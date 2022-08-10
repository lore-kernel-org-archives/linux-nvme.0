Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87878C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8TlzB2Z5MzI6MeY+zEYUPzHFTRvWUXfvzTMiyxsoOl4=; b=P3rI6tmq2Xii/8BBx4IJrwtzl5
	BaZTRqnfwAd0QzD3CHouRa1cjzOn1NydQC3IOCGD/qORWZwzXWzdGu5OT0DR8F2m/jPEA9BJxiAEv
	10K/oMekZtttoZegJiW8hSvn9NhXUpU4/8h4wtdKehie6mRRZ+kjskxP9BSIgFoRNyz/oKTGLLXlv
	TSx2qB9CCTRXEqXXNtY7fN6r156M7b0kBv4HICz2TJltwDcfdT4iU2xakvS3vbYbpLhwdQ8wGO2uq
	SN9W9r2Q6Gg3sW8rEhNKefDXVtOzXJofxVo63kV2bNmokEOEoMby7dzslxxJ760pb+icFTnCJvaoL
	hMOGIVYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmNp-00CEMj-0T; Wed, 10 Aug 2022 14:08:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmNj-00CEL4-W4
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 14:08:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6176D68AA6; Wed, 10 Aug 2022 16:08:12 +0200 (CEST)
Date: Wed, 10 Aug 2022 16:08:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linjun Bao <meljbao@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: align "fake" nqn with spec 1.3
Message-ID: <20220810140812.GA24773@lst.de>
References: <20220810133953.5411-1-meljbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810133953.5411-1-meljbao@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_070824_232392_88732F48 
X-CRM114-Status: GOOD (  10.13  )
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

On Wed, Aug 10, 2022 at 09:39:54PM +0800, Linjun Bao wrote:
> Replace '.' with '-' to align "fake" nqn format with nvme spec 1.3 or newer.

We can't just change the existing NQN construction if we don't want
to break userspace.  Maybe add a comment that it is different from
the canonical version for historic reasons instead.

