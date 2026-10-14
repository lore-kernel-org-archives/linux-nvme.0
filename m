Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C24BCC6B33
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=c/ViXU2YcsMkI/vG8ZuZ39w2Xi
	IYKYK7nAbtxX2rFdttuLckjD4e94LNRzSrGPeX8ItZmSNwrzh1r5bYBkEC94R6LIXTkiTcnMJRysf
	g6BjRHkKXXiZxkreawmsQKhgBX07xeoatc7j5zuOSvsS3A387TwqZMiAu9uOb5i+6QtTBytiJ85uI
	e8zrr7oCz5fGGULu7QnwBVvD1ZfbgJg8fd3GUJrHnkEAGA9BQ8SF0fHgaEbuzB4LjhQjEYmDIOSbq
	Twt+xZpR8MXzqLiLhntg0htiB+SYMOn0YgsWF7ilQVAu5aVEzp3W2KdAY6nXQNOvF8dAbQvBDq/dC
	j/CDI09w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxb-00000000TIV-1vzu;
	Thu, 15 Oct 2026 15:01:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyqY-0000000FYhD-0LGh
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 13:16:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=atp4aIqkbW/zzg3ZCRudCSJI5t
	7YRhVbL3sVOTdcCRHiG21kqNVNRPSgVkS/UqGpK91yVLSQUg5TTfhiyix4V+V4196ND6QeFe8bnKa
	fm5IhLxKn8u8loz0W3wIC7KhRN7W7S/oRRzaJ28Nm6+F3JewNLmD11qTmA9+RuH+UbjZH7mOlfEGj
	3IOtrcFAzOnUl5/ntAE+qUpQM7E5t53ktGzMpZS1hhJqMX15oGYsrhA6wMjVI08NhH8+QtF6FlY9Y
	orpPKRCt8y3t7KhwbAdaqBuv+UEqmRz55axr1uyhi1bdCSVx9LEuZxrJf87k8fez3MC/fVBYhAVh4
	nIp+WL2w==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGyqT-0000000GnyH-1zWg
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 13:16:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E99168BFE; Wed, 14 Oct 2026 15:16:34 +0200 (CEST)
Date: Wed, 14 Oct 2026 15:16:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [PATCH v11 08/13] nvme-pci: add SGL support for the dmabuf path
Message-ID: <20261014131633.GC16467@lst.de>
References: <cover.1791975048.git.asml.silence@gmail.com> <86fb4caeddaa58fafad106548f82950782ea04fd.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fb4caeddaa58fafad106548f82950782ea04fd.1791975048.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_141637_584118_BBBEF4A0 
X-CRM114-Status: GOOD (  11.68  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:28 -0700
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


