Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF62C3DA7E
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jul 2024 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=yAGwvjDBY58iVggOighBGCB4rq
	/DVkDQ+4EX8CvMoT1vHftZOCi7zzBqyVWRJ2ABnJ9E2N6o2LZHcSKI3kDKax79/a/uGwbn49BmUrI
	cTeK1lWr4DDQteLcAo3GG0S1QyUgGTzuoDmNiG4zu4NlZ0jOpmsuXk/zyXQj8GPjgmr2J5Sn+pzfB
	MCUowsMWqcvzwEWOe4jM08UG7VwrlaeQN9vu0JVGnZIDBys5S3HrJ4sa4Wq5BIc6Tn6nzCOiVK572
	4V9mhQ4rVnx5H1xWuvY2vt2vEivI9TfPFQqQFTNSM79Bvy8pPa7VKqzwT8FlJsJXtN5YLH0ouqJIa
	4IezwN3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYSKM-0000000Bryh-0fof;
	Mon, 29 Jul 2024 15:30:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYR9l-0000000BWjn-30Tf
	for linux-nvme@bombadil.infradead.org;
	Mon, 29 Jul 2024 14:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lAI7kMmY3I7ZSu98JtEWwXvP/h
	cIfy1e29DrElz7t28+t1HBMMIuCv/Ejc1uQsLODw3y2rrSIMlBDIkC82KjexIrEQSTTCefUZ5QA53
	xyNbT45O4tUVpNbHBPgB4RSD90Qu8IKOYziKNenNIqsl1YMF6qNpQrZ8x/394bfnrUF6bDd72ANFO
	ns7TN356mxk1YuF1ZaPbqIdnKR7Esb4CEKz48CTULCtbEi6UzOehgu6Uw/hKBKQfaQ9aEo+hvqgeu
	SR1p5ADTnzi1Nh35iV/k69xt5zrcoaYZGtcXEhl/vopeOEm/+PmYQz42n4Ga9sps5Rl2qKfqUUZYD
	BDEO73DA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYR9i-00000004nA2-0srj
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jul 2024 14:15:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D1F868D07; Mon, 29 Jul 2024 16:15:07 +0200 (CEST)
Date: Mon, 29 Jul 2024 16:15:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: remove unused parameter
Message-ID: <20240729141506.GA27921@lst.de>
References: <CGME20240729063922epcas5p35577196a5bb929f1fdf60306987d134d@epcas5p3.samsung.com> <20240729063133.198682-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729063133.198682-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240729_151518_409638_2636CEF5 
X-CRM114-Status: UNSURE (   8.99  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

