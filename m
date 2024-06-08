Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A9C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Jun 2024 05:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsGZZllTxe9R5ooohMI8oPo5J7qzN/5yMz2dxpOdeGU=; b=uejqVLLoyxVJG1uNolSCXQxmLx
	/ZtTAj0lN7cmCyyFWfM/Z+0xZKFFM0gtM8kSjE25TJ4+jAENTKn4zZZQCNhnF9/DT8nV1ddgvqvbd
	zwbN3NdiewoXkslMR5uBn8GWWbzZcud8PDVKoLR1E69Br/MndCBoO/g0Br4CgAOkNRhtvtd8T7O6t
	VI3P73uj/bQwSlGkli/8Tk/XRaBCVk7+8YC/sH3/tJbOSLGZP8nrmvqZRgADzi4rxpPhafyiXug9G
	aZBJ2hu2W8wrvF183Rie7gaiiWLZBYrR+LW1jSR8JBNOzvTVREjRyyCOG6pnn0xEXtDcFswyVFzxo
	Rk50H5sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoJy-0000000Gadi-0lwV;
	Sat, 08 Jun 2024 05:08:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoJr-0000000Gabh-0lj2
	for linux-nvme@lists.infradead.org;
	Sat, 08 Jun 2024 05:08:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72C1F68AFE; Sat,  8 Jun 2024 07:08:36 +0200 (CEST)
Date: Sat, 8 Jun 2024 07:08:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/11] block: remove the blk_integrity_profile structure
Message-ID: <20240608050836.GA23942@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <CGME20240607060043epcas5p1a6d4d8c3536fe3b6e43ad34155803fc2@epcas5p1.samsung.com> <20240607055912.3586772-5-hch@lst.de> <8d26d133-6fac-531c-d300-5b99678f1cbd@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d26d133-6fac-531c-d300-5b99678f1cbd@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_220847_689201_9CA80266 
X-CRM114-Status: GOOD (  12.05  )
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

On Sat, Jun 08, 2024 at 12:01:43AM +0530, Kanchan Joshi wrote:
> > +	if (!bi || bi->csum_type != BLK_INTEGRITY_CSUM_NONE) {
> >   		ti->error = "Integrity profile not supported.";
> >   		return -EINVAL;
> 
> I'd rename BLK_INTEGRITY_CSUM_NONE to BLK_INTEGRITY_CSUM_NOP. Overall.

Well, we don't do any checksumming here, and not a no-op checksum.
So in terms of the checksum field I think the name is correct.  But
it is indeed confusing vs the format string, but that is an ABI
we can't change..


