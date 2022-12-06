Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D68EC63703
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x+tNR98v9Dsz8sj8321KlaH9ArVlVD8VdeTM+PP5eyY=; b=y+5YvrMH9WpyYT5uvM/s62bpk+
	EQuoy8gBRVWU0TaTsSoMluex+ygsS4jJQmJbkw2MNsjMs8HYzXJY7GF+dbXZGDNOFdcGKvH1+fJDF
	/XDOW+NyhrHaavsXIHJ8momKqXv1ZVjNh8I8hOyIOfo4AoDiiVrAJEaThdAXYqOHXOPpkxHYVxTfQ
	sAl9J76u44Al0u3WRd3TJIwES99uUE/geBRi66mIoq1Xuh/uHJ4IKcxssSIPLl08dRQfiEQ0qDNtt
	sRM9Y1kwS4lcRnJmgDiHZU/mj8yCcUKs5uguBR4zZT6i4gXoQScAJnsK+ZTzeStNGWmHPgg/KmKl9
	tIrxFGdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T88-004b03-B2; Tue, 06 Dec 2022 08:16:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T85-004asK-Hm
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 08:16:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0176068B05; Tue,  6 Dec 2022 09:16:37 +0100 (CET)
Date: Tue, 6 Dec 2022 09:16:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, chaitanyak@nvidia.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, javier.gonz@samsung.com,
	joshi.k@samsung.com, p.raghav@samsung.com
Subject: Re: [PATCH v6 0/1] nvme : Add ctrl id to allowed passthru commands
Message-ID: <20221206081637.GA8675@lst.de>
References: <CGME20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5@eucas1p2.samsung.com> <20221206073914.1243191-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206073914.1243191-1-j.granados@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_001641_751748_60387B05 
X-CRM114-Status: UNSURE (   8.04  )
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

I've applied this to the nvme-6.2 branch with a rewritten commit log to
explain a bit better why this feature is useful.

