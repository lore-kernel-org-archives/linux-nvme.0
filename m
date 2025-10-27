Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A7FCCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 07:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hI8XbS/SbXT3p+Catd3ye96aW7hFWj42YzmUsNBTMNA=; b=sRMd4PoHT+EEKf+kXfY9ybRcgk
	Dbl6D3uGzFLidNXIN8UvH9gH0YwCt8n/VlU0Kvj7b4xC+rW6s9KA15jx3phRaCwH2qTbrPW46CzPF
	l6zOodq71wzTo9rtsm/MQi7EbSBc4vC3tyJE+33dhlrxV34oqC25GT2NGi6iiSCr70Ro6X5FDIIUZ
	Iz9jazcOQ+syJ1IjWlWvgHCsEWbQDIAs/YOQKKEfF0xEux1nArnH1jUAi3JamNTsrF4lr99vLU/Ww
	CguiDcQbMH/hiKfakAnpfS0kETV61MntFFfnJKM8VxLs+nwbFwa7cXbtzIMTG/W7sk9VZDbQgIlSY
	GHe0Odgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI18-0000000DIuX-2JBf;
	Mon, 27 Oct 2025 07:51:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI15-0000000DIu7-3gFn
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 07:51:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACB27227A87; Mon, 27 Oct 2025 08:51:42 +0100 (CET)
Date: Mon, 27 Oct 2025 08:51:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] io_uring/uring_cmd: avoid double indirect call
 in task work dispatch
Message-ID: <20251027075142.GA14661@lst.de>
References: <20251027020302.822544-1-csander@purestorage.com> <20251027020302.822544-5-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027020302.822544-5-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_005148_055239_64A069EB 
X-CRM114-Status: GOOD (  11.24  )
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

> +static void blk_cmd_complete(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> +	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;

In most of these ioctl handlers issue_flags only has a single user,
so you might as well pass it directly.

In fact asm most external callers of io_uring_cmd_done pass that, would
a helper that just harcodes it make sense and then maybe switch the
special cases to use __io_uring_cmd_done directly?


