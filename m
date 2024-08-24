Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F789C5472C
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARr6/Yu9HutjOIR+ldoAJgbwcGIH/Ko1k8+YyNeFDoE=; b=I+U8nYxNL1EPfWfOIxAlXPHlRD
	bGKu1MFBZqmetDtiv4jzEeQ6VPzgXwpMaunjUWNZ6kGaacy6627rjfX4vYLEapBL0kQePVhPYe2+x
	nIXE4htWvDaRcYJUrXw1rUa8IF/Hk5breVz35/8NPv4AcwSdlt50LT2XDM741UAFsO+YBR9N1QXrU
	6qdJfoScT4+ivxkAAH+431br6ys9+kzXVG2EEG0OlqDCn5rJLx1fF9vJJ4C3zl3qXyO4Ky9vrhJ1x
	1FtXUH9zWSPkBHUDQsnsNfo+iYsC+MdMUZsy6eySQiy/V3WXWkAdRLZdyf58F0+WIEN2YiTWsTKL/
	SHwu7Tsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmBq-00000001qnx-1Vh5;
	Sat, 24 Aug 2024 08:32:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmBm-00000001qmh-3n0w
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:32:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92986227A87; Sat, 24 Aug 2024 10:31:58 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:31:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 05/10] block: define meta io descriptor
Message-ID: <20240824083158.GD8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104624epcas5p40c1b0f3516100f69cbd31d45867cd289@epcas5p4.samsung.com> <20240823103811.2421-6-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-6-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_013203_167155_BBD48612 
X-CRM114-Status: UNSURE (   8.21  )
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

On Fri, Aug 23, 2024 at 04:08:05PM +0530, Anuj Gupta wrote:
> +struct uio_meta {
> +	meta_flags_t	flags;
> +	u16		app_tag;
> +	struct		iov_iter iter;
> +};

Odd formatting here - the aligning tab goes before the field name,
not the name of the structure type.


