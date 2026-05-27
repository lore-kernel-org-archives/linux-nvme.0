Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFF0CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=El3RfNVm85xP2xTiqV9h0LNYYy
	Qiim48U2CmpSFFAJ/E0J1nMLLrKsy1LKOdig+c6V4SmmfIdXyxAG/toaExyVf3OdnTv6bYlwtXuj6
	0c0Ez+tmQVWOPLKQV4dFw9QHrBnlMXe4eiqwdmy/n8korNelzQp5+tOETIATvaBZN7H3rLpoaLiYv
	VWZJihpVWpBSRcdh+q6TkpSvU6WA/+ok8NNcbVsoQ1AjJQXYWIlF1tSFAnmBOHBArY6amoYIvSLIH
	nNtxRkz9GgZVPctGVnsZjKNKi5RNK8z+Q+qVCcDbMXyFBAMNfAwR8gwtPD/eLeFJC8aFMtQk4begG
	gwoRK4Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEFb-00000004BXN-1Bg6;
	Wed, 27 May 2026 13:24:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEFZ-00000004BWm-0lIH
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:24:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 857E768B05; Wed, 27 May 2026 15:24:42 +0200 (CEST)
Date: Wed, 27 May 2026 15:24:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: target: rdma: fix ndev refcount leak on queue
 connect
Message-ID: <20260527132442.GC11071@lst.de>
References: <20260527084544.864221-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527084544.864221-1-vulab@iscas.ac.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_062445_361479_00C05243 
X-CRM114-Status: UNSURE (   9.16  )
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


