Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADE9C38142
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HeiethKseVGJ70/5PjRlX5YDB3+nnc26Ua2pXcSZvpo=; b=BftVIqcrfQ+x1X9Nyu0fgtiw2J
	9oZEuNfbcMBCaLecc3Ecf/ChqBXOXxd2SwW87E0qtJCLdeXBTuPwMGZwceVt9RENBHsohuElVrw30
	lEyKFqnDNxLW1yOj97Pw0Gc46MLclL5pxU8W+9KL56Xeagw9fPaZFqfvBj3YtzQukNanfkYv27OvD
	Vf5n6LKxRz6n5RLvWPzdyheDgpkIsJqRNpVL5uCGot8Mz1zmHt8Fx74KmBP947dZbNEnBZy8b1ueh
	XixGhmWMbLjln8e4hM0AiTznnnKu4eyG9Ueug8vBCdofx4lwj9z1p4tEXHKx3XqlqYGjUQj+tMKZI
	bTea2Axg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjkn-006Nzw-Mi; Tue, 31 Jan 2023 06:04:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMil7-006ITy-KR; Tue, 31 Jan 2023 05:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HeiethKseVGJ70/5PjRlX5YDB3+nnc26Ua2pXcSZvpo=; b=Q5zfNh/EB2Bmq7oWjxZpT6+msk
	Wru/DAC5G3Ah5BIaBZRlzZAeO/DNnzrkJTotw+xknA145DoaVDP0PapXQz9haLCp6JFInHd1m/Gq0
	Ugh3dsiSMTuuFZDfTCVfD5u3uqBFHZNFvaNOEf6GBWhQrOrUuRM/LfCeHe1ih3TKWB/32GnPqOt0M
	+KS/+gertHCfno38+Xr4AT42h2GV1/Lh8Psc34Ane6VpgoKN86DPzQO3EbFQEM4/mJ4G+4ucfZfY3
	NPYL3uNiTdgqjKCEqIT2kmWqSZZmNNoBtb5mihNp+8SSg7Q7Ae2AfDTQFg5YePXBH3WHd0Kojkyq6
	mP4yNoNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMiky-00B1Pp-3D; Tue, 31 Jan 2023 05:00:32 +0000
Date: Tue, 31 Jan 2023 05:00:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ilya Dryomov <idryomov@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org, io-uring@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Message-ID: <Y9igcK1d/iGn33pK@casper.infradead.org>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-2-hch@lst.de>
 <20230130204758.38f4c6b9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130204758.38f4c6b9@kernel.org>
X-Mailman-Approved-At: Mon, 30 Jan 2023 22:03:19 -0800
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

On Mon, Jan 30, 2023 at 08:47:58PM -0800, Jakub Kicinski wrote:
> kinda random thought but since we're touching this area - could we
> perhaps move the definition of struct bio_vec and trivial helpers 
> like this into a new header? bvec.h pulls in mm.h which is a right
> behemoth :S

I bet we can drop mm.h now.  It was originally added for nth_page()
in 3d75ca0adef4 but those were all removed by b8753433fc61.

A quick smoke test on my default testing config doesn't find any
problems.  Let me send a patch and see if the build bots complain.

