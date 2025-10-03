Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150F9CCD183
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bha2br4f2PAC3laIMRMZ9I/DWJDuDnv5mq007Kww1M8=; b=lrpcgVLWsMoEwItppU4ZULE6Hw
	Ieq+1N+PMR8uqXupoSxLFdpAWPGM9RaD+f1buhPzkLHX9/U+ER8NyJ2XqrpEwBRv2n1A4+SFpjdUW
	DJpFbSKQy760yx5Wx/QW2wGNj5L9SDGrCqhwMxN0xkkg29RSGzpcda/QSRv3xl04nmKySF+ghorES
	WMCVkiz/FPrmzw/tBgRzMv1NLxrZXaJZT5JnYPiJ6WAwJgURilNqukVuYFyGP+09o7NQqaI5ssb+N
	4+ODgXky1r7lQzMxPP/lQsJysrv1sP8l/63V5wwLdYLvT21bwQWo/0hcH7PGZ7uVtgiYa5UkpsMlh
	MHoJ4fzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cRb-0000000Bz7a-33Yy;
	Fri, 03 Oct 2025 09:51:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cRZ-0000000Bz7G-2C6c
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 09:51:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A042E227AAC; Fri,  3 Oct 2025 11:51:11 +0200 (CEST)
Date: Fri, 3 Oct 2025 11:51:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 4/8] nvmet: Expose nvmet_stop_keep_alive_timer
 publically
Message-ID: <20251003095111.GA15497@lst.de>
References: <20251003043140.1341958-1-alistair.francis@wdc.com> <20251003043140.1341958-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003043140.1341958-5-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_025117_717326_CA304443 
X-CRM114-Status: UNSURE (   9.58  )
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

On Fri, Oct 03, 2025 at 02:31:35PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Please explain why making it available is a good idea.  Because it
feels a bit sketchy as-is.


