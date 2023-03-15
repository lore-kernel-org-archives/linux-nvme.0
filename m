Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B906C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=e2DIkdtfubbQnvkD3No+w0o+co
	DVhOaMaSQSsgoSdYHm6l4Cm8BdJqhGM9rUONlTCs0l95ptPbDZ4C8ln4TsAa9qFRZL4SczYD+CyDK
	ZaqgoBj3fCVEe7j3Q/tu/46hipCiBzq1A9o3LMXYAElvdSTVki4mTDOtxVilsD8MRHKf3HXSkSGGO
	b5KSGGFiacW7jX5FrkUuQC/irz/dOJXxls8YmI53FAeL/ynX7jsylIgJk7F9h58cL+d/vGxNFV5EH
	+U6U/Ll3XzUwiUf6CQc+hSwHxgzoPsNWgeNXQQ+QVeBPArnN6VYQmtT/vFqZknhDgLOdPSTPcSyN/
	JPoQfkDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRfX-00DXsm-05;
	Wed, 15 Mar 2023 13:59:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRfU-00DXri-0R
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 13:59:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BF9867373; Wed, 15 Mar 2023 14:59:47 +0100 (CET)
Date: Wed, 15 Mar 2023 14:59:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-trace: show more opcode names
Message-ID: <20230315135946.GA26951@lst.de>
References: <ZAnttt3/8EYeMn5f@minwoo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnttt3/8EYeMn5f@minwoo-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_065952_325379_CDBDA982 
X-CRM114-Status: UNSURE (   8.41  )
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

Thanks,

applied to nvme-6.3.

