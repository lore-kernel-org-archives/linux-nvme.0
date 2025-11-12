Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8F0CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7Qs7GQCfWXbxMQpLXtA/Ojh3qcR0Z358ZoPp34gbP4=; b=u/OCXu+8PcrSenzoni3PFBwY2P
	oqEDw8sWCNRrngINR6jNeic3hZBrIpjc/dLapr1EEtTuuEGq0VIuRMoI1UtwTif8fECH/MhQd6/Rz
	Cl3m+glSjkIfiJTY6sH+JNjiWV8jvTveI10S+spNei4s0EQ0HECZqadgwoMMeKW72cF64egirxb+5
	b5jbjn6WNkXB+vuNhkiMcpqiH7bFNEcxbVbWKBoTcsE/HEl3nB8fKWkPZ6fNJbHZ27OmtTxQ1UlgM
	dOuOfmhUGe0t8DycSGfE1K+nh0kg/qbLeLR2SN4ouJSlJAT/LiZ7BUg85fPcgQ8OO6bcGlbPQiEwn
	qbUPHiHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJBzC-00000008wYg-31O0;
	Wed, 12 Nov 2025 14:38:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJBz9-00000008wXw-1MPS
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 14:38:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D20D227A88; Wed, 12 Nov 2025 15:38:04 +0100 (CET)
Date: Wed, 12 Nov 2025 15:38:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, alistair23@gmail.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
Message-ID: <20251112143804.GB2831@lst.de>
References: <20251112042720.3695972-1-alistair.francis@wdc.com> <20251112042720.3695972-6-alistair.francis@wdc.com> <20251112065925.GF4873@lst.de> <f7dd4e03-352f-48ba-8a0d-ab9e793ef385@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7dd4e03-352f-48ba-8a0d-ab9e793ef385@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_063811_500663_8833C345 
X-CRM114-Status: UNSURE (   9.65  )
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

On Wed, Nov 12, 2025 at 09:31:35AM -0500, Chuck Lever wrote:
> But it is correct style for net/ .

Maybe.  But why would non-net/ code care about their odd preference?

