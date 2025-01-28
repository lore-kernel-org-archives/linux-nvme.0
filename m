Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12797C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVnd4OQDVd4OqwxlUo00uQu3kfTHjII4+z4jJBMNvmE=; b=2BwkXV+oIVBzyjo44lTXuYVkHP
	yNenH8CGo6hzOZq3ujNW0patw4UozZNpBifDip7B7PRQk/8NKK1lchkwPV1Hcf76HppsSG6S3Gnqd
	yLxRDVkGWYC0uDIguMMiEn4xAodSKUnBGMmsasBzLW39pECWtnjmdk4CHo34jqfErb/+EFNtdVXLz
	HFTdKQULOj6gw+0EnDy4sFdrULBJeItBTL82JV04cPqblIecEpaOYkkK3FRnfrKAhBKP15qt2RWDR
	TeF0YS4uNRcqC5jGB78DI57T2BHDU/kKN0zNJNuG5X2BKXcEL+dwRzzQAui7ZOiOkGqz2Pqzquzup
	c7KBwrng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfMl-00000004F3M-2TyE;
	Tue, 28 Jan 2025 06:46:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfMj-00000004F33-0GGP
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 06:46:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FEF168D05; Tue, 28 Jan 2025 07:46:24 +0100 (CET)
Date: Tue, 28 Jan 2025 07:46:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
	djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 2/8] nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if
 device supports DEAC bit
Message-ID: <20250128064623.GB21401@lst.de>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com> <20250115114637.2705887-3-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115114637.2705887-3-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_224629_243242_40B39803 
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

I think you also need to add BLK_FEAT_WRITE_ZEROES_UNMAP to the list
of features supported by the nvme-mpath stacking driver in
nvme_mpath_alloc_disk, so that this gets propagated to multipathed
devices.

Otherwise this looks good to me.


