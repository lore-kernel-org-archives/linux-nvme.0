Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AE2CC6B3A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=msYbVeZ2MF9i6U3L313zKKFe4g
	9w4Qi1Il8vUvG7b+LxiJrhsaO+ilzfGqXPO7ohaA0V4qDoRarDpy9u0/K23PL6W7uRyptiUnNFmVP
	sER0LRdJeSgI6nb2+R5JNVL4pZmdp2svPLwN5+H3eIEksxzSkkBgGOKzTcwAB6RixdQSfVJ9vrWXK
	ZGnV5OFb957aze5aRJP23/rjOcxPdGiNATWiNGPTFUTjTaFzZn0s931zdvJ5XlmPseK9UqG9KGVi+
	YVsJ5xL6INo/1JfBP5NJholwdKQ2vhEst7sZ3NZ6jtetAW1DEIBPqXbqQbyUXiX8HTtOWBcEQeMf2
	aZrqsN4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxb-00000000TI1-0vOa;
	Thu, 15 Oct 2026 15:01:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyqG-0000000FYcB-3j6v
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 13:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jdkvhKst6//HZhhOIJPne/ipzU
	O9kFjnjyPfGFAQ1jfXR13MEWPV3ITC9H63+7G/K5k5U7zl6b4eQGelrevnim5FavK2d+FR4mlCm5d
	UJrNUJSewuVoyfwotv1mvhWGPGLNftQnlGuha/F4tbsl9RKkZm3GGdgkc+yCWaYEytz3cZQ2axDqJ
	26Zew1SqtbjDNlMudtuKI0i/8Xqz74h33lgAM+iY278xzzLfaOmmZQJVVu6SS2KpTGKGionio/Mz6
	Yhj9ORe+baLJ+Nxq3BVSK4eeHVQNpeahYF7DFf/0JZPBuj4fKACsPYG1qVcoeGSpdtM7IzsdYYweK
	eZAMEsmA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGyqD-0000000GnwK-3Mup
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 13:16:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C52D868BEB; Wed, 14 Oct 2026 15:16:18 +0200 (CEST)
Date: Wed, 14 Oct 2026 15:16:18 +0200
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
Subject: Re: [PATCH v11 07/13] nvme-pci: implement dma-buf backed requests
Message-ID: <20261014131618.GB16467@lst.de>
References: <cover.1791975048.git.asml.silence@gmail.com> <9540e74b5d2dd1a5dc0d436bc0c2a6f5e18fc389.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9540e74b5d2dd1a5dc0d436bc0c2a6f5e18fc389.1791975048.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_141622_016911_D4E93970 
X-CRM114-Status: GOOD (  10.98  )
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

