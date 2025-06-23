Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EFEC7115D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 05:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLS9TfzrHaJbr7q8HR4u6+oaiCM98vyR/i7lZ8fnI68=; b=BKheH6FWlKlegOJEjsUJmSwr0z
	r0XI56wehMpYiovOQZQXqseYJm6g5C8f5ejCVfbn2wmBzQwzq52F0JaFSrAYIX4HuPe6PxEwwjJw0
	TPA31uarAaMf27PL4QUrpbB1odAq0MXIifi/3/uTgE8u1NahTcxm+lYZW8Kaf95aoHWGjHoXZDLv3
	qLG8z3KYhZ8UGSeW8DuXdMsQbvLoh0sWqUABDXsYE+79mRRJGlTiki3CS5YirNcSCjDxL7zzd8S4O
	b++aIc4NT2mbugqxtff1uSLxMw8NjQYvzwqPF1ejCh+jIe65jmmZq7XTtnefz+5tOp3Qw/l3juiZY
	WEy2VyVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZl2-00000001ch5-09A7;
	Mon, 23 Jun 2025 05:30:16 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZl0-00000001cg2-0hIM;
	Mon, 23 Jun 2025 05:30:14 +0000
Date: Sun, 22 Jun 2025 22:30:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v4 3/4] set pi_offset only when checksum type is
 not BLK_INTEGRITY_CSUM_NONE
Message-ID: <aFjmZkidi9O_73bW@infradead.org>
References: <20250618055153.48823-1-anuj20.g@samsung.com>
 <CGME20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20@epcas5p1.samsung.com>
 <20250618055153.48823-4-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618055153.48823-4-anuj20.g@samsung.com>
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

The Subject line is missing an "nvme: " prefix.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


