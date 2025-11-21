Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480C8CFA76C
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 10:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8dFnN/h+patZiXqhujYQZUHBKysv1dYEpiL+1UtwKM=; b=GHNAvmmyAH0Vu+XsHyx11DTXs4
	tu8yak3hjgCfqifzNy4TQx0+QNU9Gg/hhW4RstubaEIkQERcBkO+lGDH4OuwDnTmrP/PE1m4Vz8ue
	2txHLZBRnIaFxc5ByZJGb47Zfwl4fs/lyawlpXyPeWdeCz23ceif7aDi8bljP7jAOEAbsJjTYglzF
	/WAJ1zzIOiSXtklo1G6h9p8ltMArHwcosjmceIYy7d0zYe5fu4dbW21IpptS6n9ghrrHzO9FIxRMO
	tJL5tdmPaLNxRH0p5U4MsqgAIlIHX2VfD6AZfyjBObDbE/x592knEJ4SpWVuIQExyLZEQjuzkz/kF
	kHHtvU9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMOQy-00000008EzP-3bVQ;
	Fri, 21 Nov 2025 10:32:08 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMOQx-00000008Eyz-1ePV;
	Fri, 21 Nov 2025 10:32:07 +0000
Date: Fri, 21 Nov 2025 02:32:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
Message-ID: <aSA_p2N_IK3I-KmM@infradead.org>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-3-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121081748.1443507-3-zhangshida@kylinos.cn>
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

This is almost missing a commit message.  Also I think this
and the following patches are cleanups / refactoring, so maybe
let's concentrate on the bug fix first?


