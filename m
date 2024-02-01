Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6304BC47DDB
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 07:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NReHrCxnEObsR8kjXt1VLycYyw5s1+VRYfIlVlsRyt8=; b=wxjuzmF6JFkrSuMSjCRhk35fJW
	p+IE8g8yS6bu4sKeApQ88/L88YbW+cT1thwz7kStiCBhLN09fCFjcL9b2kfs3oBfol9lhY1TvBcv3
	2PEbMFQWB1CPZ+dl8bPF0JmqZMwFB69mLaqv58pRiOCT6k5PEFELnq4z6en9hvzzVKYS3T8ohxBCI
	ISuVxFqp7Yq/Fwl4w4iP7767quJiwAnGs/o6uFhD9m2HaCqyMwfZqE8NCF9xY9n5PP7cQgvgMQoxf
	7iziA6R4pVJdY2NNE/CStJbffWQhnQ1wM7+L+mLspefWwL5cZPssKwvtbmc7Wtk0QgAjuE47VQ3XA
	dhfQfe/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVR7N-00000006rPQ-3sSg;
	Thu, 01 Feb 2024 07:04:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVR7K-00000006rO9-40OH
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 07:04:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E0C168AFE; Thu,  1 Feb 2024 08:04:03 +0100 (CET)
Date: Thu, 1 Feb 2024 08:04:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <20240201070402.GA17262@lst.de>
References: <20240131130400.625836-1-hch@lst.de> <yq1o7d1qeax.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o7d1qeax.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_230411_154902_630ED266 
X-CRM114-Status: GOOD (  13.26  )
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

On Wed, Jan 31, 2024 at 06:26:49PM -0500, Martin K. Petersen wrote:
> Looks nice in general and avoids the annoyances I had with my discovery
> series wrt. discard. I'm in the process of rebasing that series to fit
> on top of your changes and things get cleaned up nicely. We'll probably
> have to coordinate the sd changes a bit.

FYI, I haven't really started on SCSI for a bit of protoyping, and it
will take a while to get to it.


