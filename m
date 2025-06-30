Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A79C8302D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1zb2wukpdLrkTnDXzUMRZ/M+iO
	Mjjh2rO3uQedp2SALPghnPLZjtqW/UAkXN4/zwVgc4nHQJ6E79IDaty3sUHmjpV7E7z2UKvUczXFY
	FiRU1GvV+q+wsecvlHEwOtpwbFMbDvrzTL1UojA2Q5oc+S5o/+Kmm+ibfsK+Ay8N0amWWcH0T+XGe
	jEJfUpDgvShChyugASqHVbhU6JSil8sddBYrSNJGaI5MV7F67+lb5evfScdp0iuXAeb/dPe4ClmwM
	z4F1L2TkrRg5hvN4xFp3AjGUIBU/Yo0CN/6gUiFwwI07csJFVQmT/dnrlqmM/TuYA//I5A2uW0wKc
	4m852YLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWErT-00000002QZv-2xLU;
	Mon, 30 Jun 2025 13:47:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEaU-00000002Nik-1YOv;
	Mon, 30 Jun 2025 13:30:22 +0000
Date: Mon, 30 Jun 2025 06:30:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v5 4/4] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <aGKRbqS7eD43DEqu@infradead.org>
References: <20250630090548.3317-1-anuj20.g@samsung.com>
 <CGME20250630090616epcas5p2a9ca118ca83586172d69213e22b635a1@epcas5p2.samsung.com>
 <20250630090548.3317-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630090548.3317-5-anuj20.g@samsung.com>
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

