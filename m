Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA48C7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 06:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=nD5qSX9W9mG14tKx/2FFGIGRdP
	QXFvc5u1PW2/8i2XERaRtbrgGlj1UcDLK1IuUzeFcYPjweBnIH/1RN7FGqs9W6E1MWUTlMvMSgG2V
	/6hcAWR1b1MF0FiL0kxYK3G6gc5MCk+XYcsL9Z+aW2ifLhtkKZqdudZ87/2k6oansOcQE8PgT3nPU
	Ej7Fs/POJHUNrMlIKB1mXY8zw2sj2v2N6adetqRlnGxNLKuq7KRtkvFR4lC1bznBnBfeTJxkz/x4X
	Iu0szRQCZ536cNePCvkVgoo5KkJ1ZTCCRIJP1H3zjEhUpD97EKhp6Jp35pbdEhIF3Odk8CvjklbaX
	xaA/CFtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7B3-00GXdJ-0w;
	Tue, 11 Apr 2023 06:08:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7B0-00GXcl-17
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 06:08:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF73F68BFE; Tue, 11 Apr 2023 08:08:18 +0200 (CEST)
Date: Tue, 11 Apr 2023 08:08:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Nate Thornton <nate.thornton@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme: fix async event trace event
Message-ID: <20230411060818.GA18527@lst.de>
References: <20230405215720.2872579-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405215720.2872579-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_230822_526535_B518DBDC 
X-CRM114-Status: UNSURE (   7.48  )
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

applied to nvme-6.4.

