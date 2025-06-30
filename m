Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3181FC83000
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 06:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BH/BFS4DBD/MyEOZSB2vsiZjeO/geaFzg1v7t3pZn2g=; b=ixfpQkZSbWlo+pIcten7+51R4t
	wmBt7fyFTLtU7G7H71LugRUOCqD0VkuvrrZ5m4npu3uV0B2dr0P2AL9LZE9tWFnMTugZNCLGLf6ys
	un3IVFmBtmJD02Ga+DrrHQzOAzcOFX5Cg6DpgcKlLoQyuI5oeNxcuqd6wMrlmDeaZdBpI1hXPVU34
	cT8olVghHXKeBOWE/wQrBpUKw5xULuzLr4t+9g82NHIoUa4EjdaoxStuAMpQaLiVBDzpk86NT8sgR
	U0Y/RH27HoeTwfSllSXQ8zipalGZZcl+B1XOLKzcxI2QRN7SOcrTWKj+148rlUAVdqEKs8bQjqyQC
	WtA9CesQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW88C-00000001LlL-2PJI;
	Mon, 30 Jun 2025 06:36:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW888-00000001LkP-3xhP
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 06:36:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A65A568AFE; Mon, 30 Jun 2025 08:36:37 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:36:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, yi.zhang@redhat.com, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	axboe@kernel.dk, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: Re: [PATCHv3] nvme: correctly account for namespace head reference
 counter
Message-ID: <20250630063637.GB29641@lst.de>
References: <20250626051935.801205-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626051935.801205-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_233641_123011_549A0F8F 
X-CRM114-Status: UNSURE (   7.31  )
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

Thanks, applied to nvme-6.16.

