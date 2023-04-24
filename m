Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A99FC7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f0tQJ3C9w8njZRPMSk5toxWyDDKhAtvSqcBeGFZA8O0=; b=MPjNR6o6lkD4Oh/hX3IxV71Fs7
	u6lN7Kp3hPfZLlCL20Eqey2OpvAl97d0nsvwPIAhkdf1pTqQ31TieU0i8WS7IsfhfBDFms/fLwgwp
	CEPVH0nP+9KJKNpH05qFcb1YLUP6Yp+OWrth8JdnqQtj55oc8vudKnBPTE27/oWUcHyOUYnRBe+Qp
	yNBowEZeSkDgvO9negihP8Dxop+226OFnBab1qJSyq+c3KTEuiWV+I/gtwvQJigDyr1rPEZfTQNVX
	OJVs/DGN5VtOp/Va0NnCuSKxpAZ3cNNLkBIfSZwbYZkbBfcKqjjI6ikaM6/1OH834Fek+u2b8e5S7
	SxfbEgFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqzCE-00Goi6-2w;
	Mon, 24 Apr 2023 16:37:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqzCB-00Gogm-2D
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 16:37:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD6461A0D;
	Mon, 24 Apr 2023 16:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D466C433D2;
	Mon, 24 Apr 2023 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682354261;
	bh=f0tQJ3C9w8njZRPMSk5toxWyDDKhAtvSqcBeGFZA8O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLna5VHw30LjdqRGKVJdHLEdhCNwr113Y7C/AeJVJmVqqFC5gFnEawbOWfb7ZLlTj
	 0clQgbJDgAHYt0n98jEQDaUwnBG3urPNXAWShmBERJNfwa6pUy1AOrcg2Ng+bIAlvG
	 rNhwgDKMLquXbm97QM1ehFpTf8C2fqE0iz8iNQUJYaB86lVPz2KLjpytMjzG12HDmV
	 gCUMB73e0pg0IbZrwWwDBV6fy7BByWuhEA4cwNm8XaK9q6QKxCDbW51pMa3iBcE3t3
	 B56aLfd9kcsec5GBmPGvDu524PeozK8YwUKnKFC6gLqOggHYV35cEN8ZD2I/cdjXzv
	 bK0fJRUAkIQ2A==
Date: Mon, 24 Apr 2023 10:37:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation
Message-ID: <ZEawUwOBMkibGybW@kbusch-mbp.dhcp.thefacebook.com>
References: <20230421080800.18837-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421080800.18837-1-adrianhuang0701@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_093743_790518_B21B6A33 
X-CRM114-Status: UNSURE (   7.56  )
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

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

