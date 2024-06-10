Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A82CC27C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FUbDXfk9vmTo2P1J22cOQFxcc5Yy1t0ZOpNV82R2Urg=; b=XY9F0WOPSIQbbGo5TsLPrH7ZfV
	tTM+E2HkWMLZrWAm2VSb46MX3rROT2zkzHI4Kg30w9Fe1mhsoi1hPrQC4+qhmE7bzTrbBYS38P+Vo
	m1pvfW5wFUiM8V69heurk1yQGNW95AveQ+nYTp5O0EvOAfYmYCkW/XxULoxCeoSk9UKqxzdXGtAXi
	3/0AeYiWeLSbhKMQxXfdFg32Vl+cykeTzgpHlxobCVZFTZ5WAMlkxlVaNJ6MBs3VnP+ckW0Y4aDYk
	vwrgPmdpo8r0EEt3cAGeT301ltQDD+z94A8gyfXk7L4hQ6ZhPZzxf92kSP2F13xV6C6fmCHSga+WI
	7poDZuhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGe4e-00000004ztl-2IgZ;
	Mon, 10 Jun 2024 12:24:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGe4a-00000004zrn-2K6M
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 12:24:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25B3D67373; Mon, 10 Jun 2024 14:24:24 +0200 (CEST)
Date: Mon, 10 Jun 2024 14:24:23 +0200
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
Subject: Re: [PATCH 03/11] block: remove the BIP_IP_CHECKSUM flag
Message-ID: <20240610122423.GB21513@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-4-hch@lst.de> <yq1frtl3tmw.fsf@ca-mkp.ca.oracle.com> <20240610115732.GA19790@lst.de> <yq1bk492dv3.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1bk492dv3.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_052428_756826_3BE11D7D 
X-CRM114-Status: GOOD (  18.58  )
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

On Mon, Jun 10, 2024 at 08:19:33AM -0400, Martin K. Petersen wrote:
> On the wire between controller and target there's only CRC. If I want to
> write a "bad" CRC to disk, I have switch the controller to CRC mode. The
> controller can't convert a "bad" IP checksum to a "bad" CRC. The PI test
> tooling relies heavily on being able to write "bad" things to disk and
> read them back to validate that we detect the error.

But how do you even toggle the flag?  There is no no code to do that.
And if you already have a special kernel module for that it really
should just use a passthrough request to take care of that.

Note that unlike the NOCHECK flag which I just cleaned up because they
were unused, this one actually does get in the way of the architecture
of the whole series :(  We could add a per-bip csum_type but it would
feel really weird.

