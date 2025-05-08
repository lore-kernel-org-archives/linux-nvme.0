Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC29C3ABC0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=scj3YowNeMj84y3j7UD0EMD4jOh2k5JuP5wRJ4dpvPE=; b=NoAXlFwq6CHBwSrkZNjzFdNwa4
	n4DUHjjbJpDSzJ6WU/alDYoZhZF/w82P+IiBWbo2tGhNjak4P95nttUYnJOpcacePBcL02q9Mn/jl
	3At0QMbCio0WaVb2u/6DM19gNNEFcaxaXHcXQtUr2/MUDReEVd6v40gaci3HUfMWCFjMVLDiTsVzC
	fX2VqAtevW2DANJqFvlnng7QHfYcJEwMX5mEaH5zjleGMPkLAmXnmTz2QwcoQd1TUxSbOrgxgvPW0
	oD6+h6wMyj9+e2qoH4BhHWBQqPO7Bo8osCVk4MpdwIYkOpCRfRk0BYBXmWMp7ylzhTspRexjKGpJ6
	MtBsdBCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD5lX-00000001W6x-2M7N;
	Thu, 08 May 2025 18:14:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD5lT-00000001W6N-1RAX
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 18:14:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C409F60008;
	Thu,  8 May 2025 18:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8D6C4CEE7;
	Thu,  8 May 2025 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746728074;
	bh=ZcHp72uGiDAuaKGt1kAckthPOdetYKzv0w1YWor/jNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPPsWpKw0BW5qILUxg8el0u/eIuFgn4h5y36errkvWwg3/SXzNwuvU8apfZInH7SM
	 rvXjDdB5QJH5ojfP7yteHrpLK+/NxXnrDduqUMIt0oxLbGvADxSMVRDP304lVAtSfA
	 FEd856BhfVsZ9CySI3aUnZ9YvIoLGJAkjm3I2o+83fDvlrbImNiwwiAs2L0plOaDO1
	 RVEvQD/AB4xB6z6r7xClpFLvNZquxiaez2pxxQUm9ZkvcApJ2in7hCQLhiB83eZoNu
	 KRJC+1/nqvluGQS4N9YhCYH1OGUhTPplbeARGULGsWNIUSToWlp5xq5/YY/kHznf5F
	 teQflX6YwMzHw==
Date: Thu, 8 May 2025 12:14:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: lock per namespace in nvme_poll_irqdisable
Message-ID: <aBz0iLWpLUQR4rtX@kbusch-mbp>
References: <20250508-nvme-pci-polling-v2-1-0c7e1edad476@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-nvme-pci-polling-v2-1-0c7e1edad476@kernel.org>
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

On Thu, May 08, 2025 at 04:57:06PM +0200, Daniel Wagner wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to lock this queue for that condition because the timeout work
> executes per-namespace.
> 
> Reported-by: Hannes Reinecke <hare@kernel.org>
> Closes: https://lore.kernel.org/all/20240902130728.1999-1-hare@kernel.org/
> Fixes: a0fa9647a54e ("NVMe: add blk polling support")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good to me

Reviewed-by: Keith Busch <kbusch@kernel.org>

