Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C41C5ACD1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeKDmW3H1Swfj0dYA0Xtfref2pGOuY0W7hIdBV0MXgQ=; b=XehWjmfcZUbqV/JrD4Os2vm173
	EJtN5A4wU6uiIGu2LH9lV9ORZTIiK7EXYQFOjPrgfokWAOi+rMG2wkNTEc5zZhYhPkyIQD7KE/R0p
	1N99l2PFRSOg/UwR2Ivsu+7Kt9sUQI0M7l1hpnws0AflAUxfKP9MOPYFEoeREUp6TSDKtVs/PQmvq
	jp7RvIR6CRMzRYrI76Aot6UFolux/HULu+woYnvWPVeqdOM1M2dGdWrsMgr5gaFUMPXptWhtz9Ejp
	YZCTEqNiTy3qY+9F+lyabdB0DzikOvaKr5j2g03EBOSyra6dxgq0HXTy6jcbZDXR/Q2Qux5hpEY+4
	g8YncEEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT0m-0000000FAG0-19WH;
	Fri, 20 Feb 2026 16:05:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT0k-0000000FAEu-13nQ
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:05:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F12768B05; Fri, 20 Feb 2026 17:05:42 +0100 (CET)
Date: Fri, 20 Feb 2026 17:05:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] nvme: improve discard_granularity spec compliance
Message-ID: <20260220160541.GA15071@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220032809.758089-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_080546_436841_94C4AEFD 
X-CRM114-Status: UNSURE (   9.64  )
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

"Improving spec compliance" sounds a bit harsh for just adding support
for new optional fields / field extension.


