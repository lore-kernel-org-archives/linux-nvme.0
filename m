Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE98C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 03:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2by0G+w8IJjJL+aumQvwds0m0kgF2/ZB11FTdjteXLo=; b=Zr3MKJXXXhMme6b5nwsWVQgHXz
	A6tI4+l478KDXKn6h5Fl9jewWQGmSXzgO/Bb9gcPBxtRpxM0pSIgclHwLOOKuzmkF4FH0lXqkBqbk
	xgB4t4f+ty3jgIo/atnA25TqpcupPiTlRqkZa8IjvVt46HYZN9By5SB12nGgoZejbLo+YJdvVXZTJ
	Mi0Nl2om/pke1Se5/tiDIIrAoj+AB7F/i7qayIMF/JiRbcylwc/QEsS7GFpDVM+uDMdnVoMmp1ilm
	3Wxd1M+tH0syotfMAtkmB+soF4aGALTxLOHk5w+hVAINk8UrQCyRg/MZQqvrHbYmRuKk+qByzaKBk
	Vg2xcOfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHF7P-0000000Ayfx-0wBl;
	Wed, 12 Jun 2024 03:57:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHF7K-0000000AyfZ-3TEa
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 03:57:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E89F68BEB; Wed, 12 Jun 2024 05:57:39 +0200 (CEST)
Date: Wed, 12 Jun 2024 05:57:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 02/11] block: remove the unused BIP_{CTRL,DISK}_NOCHECK
 flags
Message-ID: <20240612035738.GA25785@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-3-hch@lst.de> <yq1le3d3ua9.fsf@ca-mkp.ca.oracle.com> <20240610115118.GA19227@lst.de> <yq1tthzz29i.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tthzz29i.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_205747_106199_E9182469 
X-CRM114-Status: GOOD (  10.39  )
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

I can just leave them in for now.  Or I can remove them and we add them
back with the right polarity and support in nvme when we add an
actual user.  Either way is pretty simple unlike the weird ip checksum
thing.


