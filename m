Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97636CDB483
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Nbq3niB/4p4hJdXxY3sV6J5IZitBTTk6R/C7KQVFOU=; b=WwemN4oCaIsnMKD+4MCBJHPTgu
	IX5gWRQxu/xpglrLCI+YRK4WAFyAhnorUTTs29NjzIuW59o4YZwoeczO06LF96SSah08aiHGrbszf
	OMy+hAMVs7Qq28fIeTscrqRXDUcal5OElo43M15LwwB+jB/AOU5VkoZu5yHNoR+4F4vEBA7o/1lzv
	6GXOyrg9QDjGbmg8m4wun7F70ond/9JUD+xbH+YjsM/WjPVgsYQoAoCmBaiOR3sLHFNX4Mx8NkPC7
	6H3ke7S9a9kiHOgj6YjPmWWW/+apTFLI5fnKgAVjKWjqNDQyot2a4jgd9ju/+3vxV+RiZKWoFe+f2
	HfY6T1yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLmS-00GNFQ-0Z;
	Thu, 19 Oct 2023 05:41:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLmP-00GND7-0G
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:41:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47B3567373; Thu, 19 Oct 2023 07:41:06 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:41:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/4] iouring: remove IORING_URING_CMD_POLLED
Message-ID: <20231019054105.GE14346@lst.de>
References: <20231018151843.3542335-1-kbusch@meta.com> <20231018151843.3542335-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018151843.3542335-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_224109_292584_14E7EE1B 
X-CRM114-Status: UNSURE (   9.35  )
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

Looks good and should probably go straight to the io_uring tree
instead of being mixed up with the metadata changes.

Reviewed-by: Christoph Hellwig <hch@lst.de>

