Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55330C2BA18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 05:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BU5Vd/NHpy0Dq8pwgP7JTu4kXjArbAgYR57DJj5QorI=; b=Z6A5GsbGQtWWSywovXk45iQbgl
	4qgg0fnNRLuF3+bpHx2r3VzVafbWuOM0Tru3AcOXCq4wriKVv0rxVdqi+70FArV4SpNwMoANZNZoC
	gQYipcjuRcBJ1XFkTo663K42bpbRBo8ITdGPRNHVs3MHO7k0VmZs9Ey27MF7L7LRXRvrzFWXn4bHB
	9I3kDbtFTiUIcou3ZsOW/E9u+qsRf8fU5+6Id0tgPmrQVmaPpwFMLxUqsqwBSTviQXE7NPyGAK8d1
	DTXMkLSBGzmN/tj35UqUJA5Jvb3G3PAUwZKIzI2ibgjhkZD4k3vb2wPml2+/lK7nqUslwf55WTkT8
	vU7Sg+kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJRfL-0000000Dgfz-0tBU;
	Tue, 18 Jun 2024 05:45:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJDRs-0000000BCmC-30Bo;
	Mon, 17 Jun 2024 14:35:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7CA6C60F73;
	Mon, 17 Jun 2024 14:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7346C2BD10;
	Mon, 17 Jun 2024 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718634907;
	bh=zR4PmzG8eM11uEea9QT6dpcyWJEpQ/sobqtYRuY7p2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eD5n/nvWPH0mROLi1mYqjLG+6CkIkCxCEDr7KHYv5mCJ6cJ3axvL3iUR8FSfF/NAJ
	 aWF+hMFp26+MYq12L40CvD0LxAzWJTFIpFvJFlT/13JJ1EJCWWsc/XXuMYInx3fYPk
	 PVqFFZp9qinzyqQ1wbJp1uQUpFSEgZjA7/AJ/D87BnMG71EbVAfG4CFQOyKDe6kjS2
	 0qjhzv59DCAwJqh60nhssiSotn3a1GiLXJljndQUFTrzdMkRj7pO46aG6KaDjyXOpw
	 MXJnwDrZxtrM68cj9z93ToW3XbCMjuJFfQuHw/qbhAPx1AOR5+hjUoIbpzcdxhC3Vq
	 UbiPTmWDLBjCA==
Date: Mon, 17 Jun 2024 08:35:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 26/26] block: move the bounce flag into the features field
Message-ID: <ZnBJlix63Fj_G1px@kbusch-mbp.dhcp.thefacebook.com>
References: <20240617060532.127975-1-hch@lst.de>
 <20240617060532.127975-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617060532.127975-27-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_073508_920148_13B2A95D 
X-CRM114-Status: UNSURE (   9.23  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 17 Jun 2024 22:43:56 -0700
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

On Mon, Jun 17, 2024 at 08:04:53AM +0200, Christoph Hellwig wrote:
> @@ -352,7 +355,6 @@ enum blk_bounce {

No more users of "enum blk_bounce" after this, so you can delete that
too.

>  struct queue_limits {
>  	unsigned int		features;
>  	unsigned int		flags;
> -	enum blk_bounce		bounce;

