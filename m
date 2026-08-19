Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3662C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wOePaWmstb66bnbAFnzyucyrmj
	5oHLA2KuPFKPz8Eoub/LhyA0nMAOQlspn3pz7yeYCuAn+QcF6Zl8R/uUMNRnCEL/RQvxZF40jltmT
	GaXuA8LOtGNKI/6rMIldO4Sw1/wvihV3L18kIi214SpPF4krh7bazLFdkwmSXTCt+HO/SgKckLzHo
	PPdtll+autO5OiG5QoLfecYjYQuL94xS3CGCBXmEJRXnUcXM6Ei4NH0RxhEP09sS9haOHK/zk/D9g
	6OpnkYQ4mfb1KUQ4b/ucb5wKkLirtkqvnUQUNJRetWTlFj4QVibkPz/3HVoMJSeh+o2en7BX15XAu
	+c3dGkUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwam3-00000009COr-07OY;
	Wed, 19 Aug 2026 07:31:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwam0-00000009CNu-139d
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 07:31:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAE0968CFE; Wed, 19 Aug 2026 09:31:39 +0200 (CEST)
Date: Wed, 19 Aug 2026 09:31:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme-rdma: fix -EIO cleanup order in queue_rq
Message-ID: <20260819073139.GA2705@lst.de>
References: <nvme-rdma-queue-rq-eio-unmap.v1.git.liuxixin@kylinos.cn> <cover.v2.1787121041.git.liuxixin@kylinos.cn> <66b08bdf7d4d.v2.1787121041.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b08bdf7d4d.v2.1787121041.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_003144_455237_8BE3615C 
X-CRM114-Status: UNSURE (   9.51  )
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


