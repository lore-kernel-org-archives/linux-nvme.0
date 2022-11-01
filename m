Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675FCC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/shBww2/TLXQAtcIfgbWMWwCcBjdhWufZJartaxi+c=; b=4hPn4AeQuLXFSrFCCL5bRGNdim
	WmelKQx69zsOuvy9+xd/ph7VbJM4z5DsHPvPnLrXU9xYmMvZuQtGPiQk7xIbaUnuG8XdTAPdeRmCy
	ZEyNLKuKV8RYmQGjOLxF7HjOl1FfyKuVxHWoAdHsYJmfs95JgllLPynj8d/gAtvlotX/ZU5dBC1pE
	sQGt/vhGhZNMIJnLR2kNFU/mGRFHgCSbyMBqNDg/U5MSaZ/+Lu2hZ6ZgC3JZ1OS5wSkqY8EDtDD5P
	VY6ShfzUVNGP8LyNzQK/lzl6envtK3BWqu7ZUPpBZoSy7yPDLqp/RNYFNat2hxM0xCN1v3TfviqCn
	ahK2FgVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opt8g-005nEP-5j; Tue, 01 Nov 2022 15:25:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opt8e-005nE6-7v
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 15:25:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C4A8A611DA;
	Tue,  1 Nov 2022 15:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D49C433C1;
	Tue,  1 Nov 2022 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667316314;
	bh=4/shBww2/TLXQAtcIfgbWMWwCcBjdhWufZJartaxi+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saQ5QPxZTcK5CfjYcwKSkWjx+jQDsSb7+3HSwD8V6EDh1gQrkl6iW0r3WD062q8hK
	 UUfMPVaDYBZnQwX7jacAMN1K0jpCSTNZ+7pt8YdRd8nkMBoNfxUi2iS/ckvMM966s3
	 pTV0uoQiKqBI4z56bJeMwvNCCvJKFuF9Lrw68uin5FBZX4zrgerfXJ5eS9WtJu9Rmt
	 fEuCihjkGz4IU6fmdBCVqu5BLUsMIrdoZ6xrIeSs1MBqkSYsGCSMZsyW5rOyXwiz8r
	 YPMsDBM22BLZ842VVRUHWi/QnbJyQNTtKDvGgI8O8fnlYH7erp4/qWUVMHIG+cs5wZ
	 k1CVx+6XQ231Q==
Date: Tue, 1 Nov 2022 09:25:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: per-tagset SRCU struct and quiesce v3
Message-ID: <Y2E6VsyMRfjrOvEh@kbusch-mbp>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_082516_355283_2889822A 
X-CRM114-Status: UNSURE (   8.14  )
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

The series looks good!

Reviewed-by: Keith Busch <kbusch@kernel.org>

