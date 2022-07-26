Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C2FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNxgz6KVzUei4Zl8O9nuaJBooUegAYbvDN2yaIZfwQ0=; b=IuCAfB9aPvOSCTSN260iqH4Nbv
	X4Z7y1gZqvThwnpKV68aWp+yV+WUiDVBe9z7SeomLdHEgNl5d9diLGEk1yN5BN6SjW+lYT/Leum3A
	kEC072uCtQLRd1M3ARhnaVuAJ1Tun0msVIL774k8fn0LqTpe4BJeOT9mcW7b20SxXUBw35Hc8W8/4
	YeH2KDake90xajNg0QM9og37MoSo9iK+UlnqDr+0Mi28wS0mQVZRqyhEupoG5eQY2trwbdKF0nZfX
	/XYNdewLJ3EhqntDLYa/7jax2mVUuVGFZ78rDVB1o3w5POPR2lucL2hTIo3epfLa9DDJTtEmE0Fdr
	NMK5AUVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGIok-00FyD8-Fu; Tue, 26 Jul 2022 11:33:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGIoh-00Fy4H-Tu
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 11:33:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 38AE168AA6; Tue, 26 Jul 2022 13:33:33 +0200 (CEST)
Date: Tue, 26 Jul 2022 13:33:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: avoid unnecessary fsync and flush bio
Message-ID: <20220726113333.GA2867@lst.de>
References: <1658730498-11857-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658730498-11857-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_043336_129929_2EEAA185 
X-CRM114-Status: GOOD (  10.75  )
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

On Mon, Jul 25, 2022 at 02:28:18PM +0800, Guixin Liu wrote:
>  u16 nvmet_file_flush(struct nvmet_req *req)
>  {
> -	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
> +	if (req->ns->buffered_io)
> +		return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
> +	return NVME_SC_SUCCESS;

This is broken.  Even direct I/O needs an fsync to commit metadata
changes.

