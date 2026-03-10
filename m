Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8EEEB1059
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0p6npGPxdTaDQP/V0FnyiepBYzkq4OziP2XRoMVUSB0=; b=Q31veF/Fn/3vS5AsiulSFDGP1l
	+hzY4ITgrYlmqkbMl8f7+VZWsi3XEBDi1FtRd88NyOGlNdSYPw6JUqUBk/2yTjEdt84fpfHRRBbFz
	3bTCzcjbrzTKIqsWvcPbffmRUXQuUzaer3darRzZ2EsPUiXoqWlRH7WTJSLNJdFMZg+10K7pJHY2e
	bQFfOR/T8BPa+StTUgzrJlyCbB4V6PrIugjYoAn9kdIJ/6rDtCA487B9dL9O6fsZ3Ph5DGqIC9xNe
	RFMAOVxDN8LQeJrYCLX8ahU47QiNbXmkBA8NCuFJiyZePasyt+bvJimIvQ0nwuJQsE4l+TYSQYzNK
	dX6ZCnWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxx9-00000009glr-3pni;
	Tue, 10 Mar 2026 14:20:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxx7-00000009glD-1EXF
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 14:20:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 675B068C7B; Tue, 10 Mar 2026 15:20:49 +0100 (CET)
Date: Tue, 10 Mar 2026 15:20:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme: Annotate struct nvme_dhchap_key with __counted_by
Message-ID: <20260310142049.GA10134@lst.de>
References: <20260303213102.86585-1-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303213102.86585-1-thorsten.blum@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_072053_475544_1E6C8DF4 
X-CRM114-Status: GOOD (  11.29  )
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

On Tue, Mar 03, 2026 at 10:31:01PM +0100, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'key' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


