Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EDACCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sv39PJrTpgPPUHEbkg7UcF3j1vJO+ue4AKHAHtsEyP8=; b=u4KgBf3J5r/KTrdHi1WsmmOXx/
	1PRHZQxtl3TIqy0E4boR8KDKwVLBUw8sJXzaVFIXAlprA5jt4VLyFzJ6plmH5RHIoeRZrihzBraQV
	PLrarGUG+Hl93tpvt/QFFVan9aMQPCSMu5hu+uWGxP/dLCrdOvKr4h6rufusybvkyDH4YOpeLCZrb
	2RszR+xS7+593edZE2gvHBILDBjE+xYIi/1/DpWeLVihxzZBqwIwaS+qhtdypXkbBfO5CB23Ra7Ir
	3zmQ9NVjAsMgVYbjlaSZz0xaHom/kF3lEBhe3WmYDoGzxH8FWv8Np5/aG4Zdud/AprZWpzi9ccW8I
	BQ24zhRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFswN-00000009kpM-2yez;
	Mon, 03 Nov 2025 11:41:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFswK-00000009ko7-3DkU
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 11:41:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07FDD227A87; Mon,  3 Nov 2025 12:41:31 +0100 (CET)
Date: Mon, 3 Nov 2025 12:41:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] io_uring/uring_cmd: avoid double indirect call
 in task work dispatch
Message-ID: <20251103114130.GA14852@lst.de>
References: <20251031203430.3886957-1-csander@purestorage.com> <20251031203430.3886957-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031203430.3886957-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_034136_975981_6EA2434A 
X-CRM114-Status: GOOD (  10.44  )
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

Looks good for the block/nvme bits:

Reviewed-by: Christoph Hellwig <hch@lst.de>


