Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDBBCFD376
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLQkiTXYGCUsB7L2b5EJjt/DvYVD1ENOoKRCg67wDMo=; b=rQs753gQMIoPckaeBioa5P6m9O
	ujwLyE/JJJVl2rfpfBnx09mANUC9BikUYxC8ZRDkhpUpCVaG7OkGb5MVNVhGUB27WvIIYbkAKO8DX
	M7UCc1k+e9Bbu+TzMPbCkFf7VZYShEoTGQEUhcKL94OLT26J5y/JCv1hVSNwTxzsuJDPmePqN/qCj
	9RmKBwCJCMCXjrptc7VYUQa5jlcg2ZC8PrO7ys6EcJadJhrHerDqhOY1GM/hYfYI3DCJqX+pYmTLl
	eBC12UDRAnMO6nf53ihMLLeBSwlya3l3Gq3+OIZEfjjqGj0x/6IkvV7SaMih2dzv1bp8YIhxN7RQJ
	xsMQj1AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQJMR-00000004rZj-1uTB;
	Tue, 02 Dec 2025 05:55:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQJMO-00000004rZD-1x04
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:55:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF00768AA6; Tue,  2 Dec 2025 06:55:30 +0100 (CET)
Date: Tue, 2 Dec 2025 06:55:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/4] nvme: reject invalid pr_read_keys() num_keys
 values
Message-ID: <20251202055530.GA15852@lst.de>
References: <20251127155424.617569-1-stefanha@redhat.com> <20251127155424.617569-3-stefanha@redhat.com> <20251201063649.GB19461@lst.de> <20251201162255.GD866564@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201162255.GD866564@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_215536_647121_913A998C 
X-CRM114-Status: GOOD (  16.11  )
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

On Mon, Dec 01, 2025 at 11:22:55AM -0500, Stefan Hajnoczi wrote:
> > We use struct_size to calculate the size below, which saturates on
> > overflow.  So just checking the rse_len variable returned by the that
> > would be nicer.  Bonus points for using sizeof_field() instead of
> > hardcoding U32_MAX.
> 
> Will fix. I don't see how to use sizeof_field() here, but taking
> advantage of struct_size() already improves things a lot:

I thought we'd stuff the len in some field, but we actually convert
it to the ndw in the command, so yes it doesn't make sense here.
Sorry for the misleading direction.

