Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB24CED273
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 07:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DVuRYK6Cd11hKJLTd5n9Rehigq0rse9crrBM1xSX8J4=; b=rcoMI51I2a2OB8B60ZaUJr+Z95
	plxfgUVtabe6n9+hRU/VxhIUjc8jL0WU+L0h8icw9J75tXD+Tl69k3zSogtSv9Ty/ibpSVbtHoVGF
	h4lynlzV5zN5Z2FnQPioMX9PoW4KsQRuANTUQ1omZ2vHRKiR4k3AodKPr11imIc7i9PUcnZ731dzn
	dbDU/eDco18eTA+14irEbs1bO8xAkZJVsm+cdVXfFn0YQLQG2khNP0gi5VXiJHKuSqak6UCnIKITT
	/q02RHNHVEKNyGsVcXCPuoLjGVvNomKHVUs9kw0v71+tbnRiwj6xsJ9L7i4xEexByegUAvdXxn9+O
	eqzd9I/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4Iy-00000004kaS-3oYK;
	Tue, 08 Oct 2024 07:06:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4Iv-00000004kZh-1reM
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 07:06:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D45AA227A8E; Tue,  8 Oct 2024 09:06:42 +0200 (CEST)
Date: Tue, 8 Oct 2024 09:06:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_finish function
Message-ID: <20241008070642.GB22711@lst.de>
References: <20241008062210.1094083-1-nilay@linux.ibm.com> <20241008062210.1094083-4-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008062210.1094083-4-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_000645_649035_64E4988D 
X-CRM114-Status: GOOD (  10.97  )
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

On Tue, Oct 08, 2024 at 11:51:52AM +0530, Nilay Shroff wrote:
> We no more need acquiring ctrl->lock before accessing the
> NVMe controller state and instead we can now use the helper
> nvme_ctrl_state. So replace the use of ctrl->lock from
> nvme_keep_alive_finish function with nvme_ctrl_state call.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

